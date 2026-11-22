# syntax=docker/dockerfile:1
FROM python:3.12-slim

RUN groupadd -g 10001 appgroup && \
    useradd -u 10001 -g appgroup -m -s /usr/sbin/nologin appuser

WORKDIR /app

COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app/ .
RUN chown -R appuser:appgroup /app

USER 10001:10001
EXPOSE 8000
CMD ["python", "app.py"]
