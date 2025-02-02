# Use Ubuntu as base image
FROM ubuntu:24.04

# Avoid timezone prompt during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install basic build requirements
RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    bison \
    re2c \
    llvm \
    clang \
    libclang-dev \
    php-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
# WORKDIR /build

# Clone PHP source code
# RUN git clone https://github.com/php/php-src.git \
#     && cd php-src \
#     && git checkout PHP-8.3

# Build PHP from source
# RUN cd php-src \
#     && ./buildconf \
#     && ./configure --prefix=/usr/local/php \
#         --enable-debug \
#         --disable-all \
#         --disable-cgi \
#     && make -j$(nproc) \
#     && make install

# Copy source code
COPY . /usr/src/typ-php

# Download and install Rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

# Build extension
WORKDIR /usr/src/typ-php/php-typ
ENV PHP=/usr/bin/php
ENV PHP_CONFIG=/usr/bin/php-config
RUN cargo build

# Run test
WORKDIR /usr/src/typ-php
CMD ["/usr/bin/php", "-d", "extension=./php-typ/target/debug/libtyp_php.so", "./test.php"]