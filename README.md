user@DESKTOP-AL0KJRD:~/hw_3_template$ docker compose stop redis
[+] stop 1/1
 ✔ Container hw_3_template-redis-1 Stopped  
user@DESKTOP-AL0KJRD:~/hw_3_template$ curl -i http://localhost:8000/healthz
HTTP/1.0 200 OK
Server: BaseHTTP/0.6 Python/3.12.16
Date: Sun, 22 Nov 2026 20:48:27 GMT
Content-Type: application/json; charset=utf-8
Content-Length: 19
Cache-Control: no-store
{"status": "alive"}user@DESKTOP-AL0KJRD:~/hw_3_template$ curl -i http://localhost:8000/readyz
HTTP/1.0 503 Service Unavailable
Server: BaseHTTP/0.6 Python/3.12.16
Date: Sun, 22 Nov 2026 20:48:46 GMT
Content-Type: application/json; charset=utf-8
Content-Length: 32
Cache-Control: no-store
http://localhost:8000/increment
HTTP/1.0 503 Service Unavailable
Server: BaseHTTP/0.6 Python/3.12.16
Date: Sun, 22 Nov 2026 20:50:29 GMT
Content-Type: application/json; charset=utf-8
Content-Length: 32
Cache-Control: no-store
app-1  | 2026-11-22 20:47:09,888 listening port=8000 storage=redis
app-1  | 2026-11-22 20:47:12,675 http 172.18.0.1 "GET / HTTP/1.1" 200 -
app-1  | 2026-11-22 20:47:14,728 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:47:24,904 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:47:35,084 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:47:45,238 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:47:55,470 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:05,623 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:15,778 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:26,015 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:27,276 http 172.18.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:36,181 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:46,348 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:48:46,502 storage_unavailable: ConnectionError
app-1  | 2026-11-22 20:48:46,502 http 172.18.0.1 "GET /readyz HTTP/1.1" 503 -
app-1  | 2026-11-22 20:48:56,519 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:49:06,671 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:49:16,895 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:49:27,083 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:49:37,257 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:49:47,436 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:49:57,598 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:50:07,949 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:50:18,144 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:50:19,877 storage_unavailable: ConnectionError
app-1  | 2026-11-22 20:50:19,878 http 172.18.0.1 "GET /readyz HTTP/1.1" 503 -
app-1  | 2026-11-22 20:50:28,335 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:50:29,214 storage_unavailable: ConnectionError
app-1  | 2026-11-22 20:50:29,214 http 172.18.0.1 "POST /increment HTTP/1.1" 503 -
app-1  | 2026-11-22 20:50:38,522 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:50:48,689 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:50:58,895 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:00,521 http 172.18.0.1 "GET /readyz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:09,095 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:09,757 http 172.18.0.1 "GET / HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:18,446 http 172.18.0.1 "POST /increment HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:19,257 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:26,772 http 172.18.0.1 "GET / HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:29,423 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:39,696 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:51:49,849 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:52:00,025 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:52:10,218 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:52:20,418 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:52:30,588 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:52:40,759 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:52:50,973 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:53:01,134 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:53:11,319 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:53:21,476 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:53:31,648 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:53:41,836 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:53:52,031 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:54:02,219 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:54:12,382 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:54:22,569 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:54:32,740 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:54:42,893 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:54:53,067 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:55:03,214 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:55:13,371 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:55:23,531 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:55:33,732 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:55:43,898 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:55:54,078 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:56:04,250 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:56:14,402 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:56:24,581 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:56:34,734 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:56:44,920 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:56:55,087 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:57:05,244 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:57:15,435 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:57:25,592 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:57:35,745 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:57:45,929 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:57:56,094 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:58:06,292 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:58:16,456 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:58:26,616 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:58:36,780 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:58:46,959 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:58:57,145 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:59:07,339 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:59:17,517 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:59:27,679 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:59:37,828 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:59:48,008 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 20:59:58,206 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:00:08,400 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:00:18,550 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:00:28,722 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:00:38,871 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:00:49,025 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:00:59,193 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:01:09,355 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:01:19,533 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:01:29,717 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:01:40,144 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:01:50,945 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:02:01,314 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:02:11,962 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:02:22,880 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:02:33,476 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:02:44,292 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
app-1  | 2026-11-22 21:02:55,290 http 127.0.0.1 "GET /healthz HTTP/1.1" 200 -
NAME                  IMAGE               COMMAND           SERVICE   CREATED          STATUS                    PORTS
hw_3_template-app-1   hw_3_template-app   "python app.py"   app       16 minutes ago   Up 16 minutes (healthy)   0.0.0.0:8000->8000/tcp, [::]:8000->8000/tcp
