# eBPF/Linux dev environment for building from macOS
# Base: Ubuntu with full eBPF toolchain
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Base tools + eBPF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    clang \
    llvm \
    libelf-dev \
    libbpf-dev \
    linux-headers-generic \
    pkg-config \
    cmake \
    git \
    curl \
    ca-certificates \
    zlib1g-dev \
    libzstd-dev \
    && rm -rf /var/lib/apt/lists/*

# Rust + target x86_64-unknown-linux-gnu
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    --default-toolchain stable \
    --target x86_64-unknown-linux-gnu
ENV PATH="/root/.cargo/bin:${PATH}"

# Cargo tools for eBPF (aya / libbpf-cargo)
RUN cargo install bpf-linker 2>/dev/null || true
RUN cargo install bindgen-cli 2>/dev/null || true

WORKDIR /workspace
