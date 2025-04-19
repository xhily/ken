---
slug: /interview/network/browser-can-concurrent-how-many-http-requests
---

> 富柯斯二面

:::info 基本点
- 不同协议
  - http1.1：每个域名可以并发 6 个请求，总并发数在 10-30 个左右
  - http2：每个域名使用一个连接，通过多路复用技术，通过流在同一个连接上并发多个请求，理论上可以并发无限个请求
  > 但其实并不是真的无限，在  [HTTP/2 RFC (RFC 7540)](https://www.rfc-editor.org/rfc/rfc7540#section-6.5.2) 中规定，可以设置 `SETTINGS_MAX_CONCURRENT_STREAMS` 来限制流的并发上限，最小值为 100。
- 其他
  - 根据浏览器版本、设备性能、网络环境等不同，并发数不同
:::


## Reference

- [Understanding HTTP/2 Parallel Requests: Streams vs Connections](https://dev.to/sibiraj/understanding-http2-parallel-requests-streams-vs-connections-3anf)
