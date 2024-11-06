# 🚀 Blast

```text

 _      _              _
| |__  | |  __ _  ___ | |_
| '_ \ | | / _` |/ __|| __|
| |_) || || (_| |\__ \| |_
|_.__/ |_| \__,_||___/ \__|

```

🚀 Blast: A powerful, lightweight HTTP load generator for stress testing and benchmarking web applications with ease.

## ✨ Features

- **High-Performance Load Testing**: Send a specified number of requests at customizable concurrency levels to simulate real-world traffic and measure server response.
- **HTTP/2 Support**: Fully compatible with HTTP/2, allowing for efficient, high-throughput testing on modern web servers.

- **Flexible Rate Limiting**: Control request rate per worker (QPS) for fine-grained load management.
- **Duration-Based Testing**: Specify a duration to run tests continuously, ideal for long-term stress tests without counting requests.

- **Multiple HTTP Methods**: Supports a variety of HTTP methods including GET, POST, PUT, DELETE, HEAD, and OPTIONS.

- **Customizable Headers**: Add multiple custom headers for testing with different request configurations.

- **Detailed Output Options**: Choose between summary output or CSV format for detailed, structured response metrics.

- **Timeout Control**: Configure request timeouts to handle slow or unresponsive servers.

- **Request Body Support**: Send custom request bodies from text or file, supporting various payloads for POST/PUT tests.

- **Compression and Keep-Alive Control**: Optionally disable compression and keep-alive to test under different connection settings.

- **HTTP Redirect Handling**: Enable or disable following of HTTP redirects as needed.

- **Proxy Support**: Route requests through an HTTP proxy for testing in specific network setups.

- **CPU Core Utilization Control**: Specify the number of CPU cores for optimal load distribution based on your machine’s capabilities.

## 🚀 Installation

TBD

## 💡 Usage

`blast` runs a specified number of requests at a given concurrency level, providing comprehensive performance stats. Supports HTTP/2.

```bash
Usage: blast [options...] <url>

Options:
  -n  Number of requests to send (default: 200).
  -c  Concurrent workers (default: 50).
  -q  Rate limit per worker in QPS.
  -z  Duration of request sending (overrides -n). Ex: -z 10s, -z 3m.
  -o  Output format (default: summary; options: csv).

  -m  HTTP method (GET, POST, PUT, DELETE, etc.).
  -H  Custom headers. Repeatable, e.g., -H "Content-Type: application/json".
  -t  Request timeout in seconds (default: 20).
  -A  HTTP Accept header.
  -d  Request body.
  -D  Request body from file (e.g., ./file.txt).
  -T  Content-Type header (default: "text/html").
  -a  Basic auth in username:password format.
  -x  Proxy address as host:port.
  -h2 Enable HTTP/2.

  -host               HTTP Host header.
  -disable-compression  Disable response compression.
  -disable-keepalive    Disable TCP keep-alive for requests.
  -disable-redirects    Prevents following HTTP redirects.
  -cpus               Number of CPU cores to use (default: machine max).
```

## 🤝 How to contribute

We welcome contributions!

- Fork this repository;
- Create a branch with your feature: `git checkout -b my-feature`;
- Commit your changes: `git commit -m "feat: my new feature"`;
- Push to your branch: `git push origin my-feature`.

Once your pull request has been merged, you can delete your branch.

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
