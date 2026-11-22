#!/usr/bin/env bash
set -euo pipefail

PROJECT_NAME="check-$(date +%s)-$$"
COMPOSE_FILE="compose.yaml"
CHECK_PORT="${CHECK_PORT:-18080}"
STAGE="init"

cleanup() {
    local rc=$?
    echo "--- cleanup (exit code: $rc) ---"
    docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" down -v --remove-orphans 2>/dev/null || true
    rm -f "/tmp/${PROJECT_NAME}.env" 2>/dev/null || true
    exit $rc
}
trap cleanup EXIT INT TERM

wait_for() {
    local url="$1"
    local timeout="${2:-60}"
    local elapsed=0
    while [ $elapsed -lt $timeout ]; do
        if curl -sf -o /dev/null "$url" 2>/dev/null; then return 0; fi
        sleep 1
        elapsed=$((elapsed + 1))
    done
    echo "ERROR: timeout waiting for $url (${timeout}s)" >&2
    return 1
}

check_code() {
    local url="$1"
    local expected="$2"
    local code
    code=$(curl -s -o /dev/null -w "%{http_code}" "$url" 2>/dev/null || echo "000")
    if [ "$code" != "$expected" ]; then
        echo "ERROR: $url returned $code, expected $expected" >&2
        return 1
    fi
    echo "OK: $url -> $code"
}

STAGE="prepare"
echo "=== Stage: $STAGE ==="
cat > "/tmp/${PROJECT_NAME}.env" <<EOT
GREETING=CheckGreeting
APP_PORT=${CHECK_PORT}
REDIS_URL=redis://redis:6379/0
EOT

STAGE="up-empty"
echo "=== Stage: $STAGE ==="
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" --env-file "/tmp/${PROJECT_NAME}.env" up -d --build
wait_for "http://localhost:${CHECK_PORT}/healthz" 60

STAGE="counter"
echo "=== Stage: $STAGE ==="
INITIAL=$(curl -sf "http://localhost:${CHECK_PORT}/" 2>/dev/null || echo "FAIL")
echo "Initial counter: $INITIAL"
N=5
for i in $(seq 1 $N); do
    curl -sf -X POST "http://localhost:${CHECK_PORT}/increment" -o /dev/null || { echo "ERROR: POST /increment failed"; exit 1; }
done
AFTER=$(curl -sf "http://localhost:${CHECK_PORT}/" 2>/dev/null || echo "FAIL")
echo "After $N increments: $AFTER"
if [ "$INITIAL" != "FAIL" ] && [ "$AFTER" != "FAIL" ]; then
    NUM_INITIAL=$(echo "$INITIAL" | grep -oE '[0-9]+' | tail -1 || echo "")
    NUM_AFTER=$(echo "$AFTER" | grep -oE '[0-9]+' | tail -1 || echo "")
    if [ -n "$NUM_INITIAL" ] && [ -n "$NUM_AFTER" ]; then
        EXPECTED=$((NUM_INITIAL + N))
        if [ "$NUM_AFTER" -ne "$EXPECTED" ]; then
            echo "ERROR: counter mismatch. Expected $EXPECTED, got $NUM_AFTER"; exit 1
        fi
    fi
fi

STAGE="recreate-app"
echo "=== Stage: $STAGE ==="
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" --env-file "/tmp/${PROJECT_NAME}.env" up -d --force-recreate app
wait_for "http://localhost:${CHECK_PORT}/healthz" 60
AFTER_RECREATE=$(curl -sf "http://localhost:${CHECK_PORT}/" 2>/dev/null || echo "FAIL")
echo "After app recreate: $AFTER_RECREATE"
if [ "$AFTER" != "FAIL" ] && [ "$AFTER_RECREATE" != "FAIL" ]; then
    NUM_AFTER=$(echo "$AFTER" | grep -oE '[0-9]+' | tail -1 || echo "")
    NUM_RECREATE=$(echo "$AFTER_RECREATE" | grep -oE '[0-9]+' | tail -1 || echo "")
    if [ -n "$NUM_AFTER" ] && [ -n "$NUM_RECREATE" ] && [ "$NUM_RECREATE" -ne "$NUM_AFTER" ]; then
        echo "ERROR: counter lost after app recreate. Was $NUM_AFTER, now $NUM_RECREATE"; exit 1
    fi
fi

STAGE="stop-redis"
echo "=== Stage: $STAGE ==="
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" --env-file "/tmp/${PROJECT_NAME}.env" stop redis
sleep 2
check_code "http://localhost:${CHECK_PORT}/healthz" "200"
check_code "http://localhost:${CHECK_PORT}/readyz" "503"
code=$(curl -s -o /dev/null -w "%{http_code}" -X POST "http://localhost:${CHECK_PORT}/increment" 2>/dev/null || echo "000")
if [ "$code" != "503" ]; then
    echo "ERROR: POST /increment with Redis down returned $code, expected 503"; exit 1
fi
echo "OK: POST /increment -> 503"

STAGE="start-redis"
echo "=== Stage: $STAGE ==="
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" --env-file "/tmp/${PROJECT_NAME}.env" start redis
wait_for "http://localhost:${CHECK_PORT}/readyz" 60 || { echo "ERROR: app not ready after Redis start"; exit 1; }
AFTER_REDIS=$(curl -sf "http://localhost:${CHECK_PORT}/" 2>/dev/null || echo "FAIL")
echo "After Redis restart: $AFTER_REDIS"
curl -sf -X POST "http://localhost:${CHECK_PORT}/increment" -o /dev/null || { echo "ERROR: POST after Redis start failed"; exit 1; }
AFTER_INC=$(curl -sf "http://localhost:${CHECK_PORT}/" 2>/dev/null || echo "FAIL")
echo "After one more increment: $AFTER_INC"

STAGE="backup"
echo "=== Stage: $STAGE ==="
docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" --env-file "/tmp/${PROJECT_NAME}.env" stop app redis
BACKUP_FILE="redis-backup-$(date +%Y%m%d-%H%M%S).tar.gz"
docker run --rm \
    -v "${PROJECT_NAME}_redis-data:/data:ro" \
    -v "$(pwd):/backup" \
    alpine tar czf "/backup/${BACKUP_FILE}" -C /data .
echo "Backup created: ${BACKUP_FILE}"
if [ ! -s "${BACKUP_FILE}" ]; then
    echo "ERROR: backup file is empty"; exit 1
fi

STAGE="done"
echo "=== All checks passed ==="
