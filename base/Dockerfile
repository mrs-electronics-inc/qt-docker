# Pin specific SHA of debian:trixie-slim
FROM debian@sha256:e899040a73d36e2b36fa33216943539d9957cba8172b858097c2cabcdb20a3e2

# Install dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Required build tools for any C++ project
    cmake=3.25.1-1 \
    g++=4:12.2.0-3 \
    gcc=4:12.2.0-3 \
    libc6-dev=2.36-9+deb12u13 \
    make=4.3-4.1 \
    # Shared libraries required by Qt
    libdbus-1-3=1.14.10-1~deb12u1 \
    libegl1-mesa-dev=22.3.6-1+deb12u1 \
    libfontconfig1=2.14.1-4 \
    libfreetype6=2.12.1+dfsg-5+deb12u4 \
    libglib2.0-dev=2.74.6-2+deb12u7 \
    libx11-6=2:1.8.4-2+deb12u2 \
    libx11-xcb1=2:1.8.4-2+deb12u2 \
    libxkbcommon0=1.5.0-1 \
    libxcb-cursor0=0.1.4-1 \
    libxcb-icccm4=0.4.1-1.1 \
    libxcb-image0=0.4.0-2 \
    libxcb-keysyms1=0.4.0-1+b2 \
    libxcb-render-util0=0.3.9-1+b1 \
    libxcb-render0=1.15-1 \
    libxcb-shape0=1.15-1 \
    libxcb-sync1=1.15-1 \
    libxcb-xfixes0=1.15-1 \
    libxcb-xkb1=1.15-1 \
    libxcb1-dev=1.15-1 \
    # Remove unnecessary documentation and cache files.
    # This is done in the same RUN to avoid layer bloat.
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/* \
    && rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*

# Add image metadata.
LABEL org.opencontainers.image.source="https://github.com/mrs-electronics-inc/qt-docker"
LABEL org.opencontainers.image.description="Qt Docker base image"
LABEL org.opencontainers.image.licenses=MIT
