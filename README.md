# Network Metrics ebpf

Rust-based eBPF to do network metrics.

## Build (Mac M3 → Linux x86_64)

**Single method: Docker Compose.** No Makefile, no alternatives.

On Mac M3 (Apple Silicon), Docker runs ARM64 by default. We force `platform: linux/amd64` so the container is x86_64 Linux—required for eBPF (kernel headers, libbpf) and to produce binaries for typical x86_64 Linux servers. Docker Desktop uses QEMU emulation; the first build is slower, then cached.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) for Mac (Apple Silicon)

### Step 1: Build the image

```bash
docker compose build
```

Builds the Ubuntu 22.04 image with Rust, clang, llvm, libbpf-dev, linux-headers-generic, bpf-linker, bindgen-cli. First run: ~5–10 min.

### Step 2: Build the project

```bash
docker compose run builder cargo build --release --target x86_64-unknown-linux-gnu
```

Runs `cargo build` inside the container. Output is written to the mounted project directory.

### Output

```txt
target/x86_64-unknown-linux-gnu/release/app
```

### Shell (optional)

```bash
docker compose run builder /bin/bash
```

Interactive shell in the container for debugging or manual commands.
