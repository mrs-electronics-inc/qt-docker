# Pin specific SHA of debian:bookworm-slim
FROM debian@sha256:e899040a73d36e2b36fa33216943539d9957cba8172b858097c2cabcdb20a3e2

# Install dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Required build tools for any C++ project
    gcc g++ make cmake libc6-dev \
    # Shared libraries required by Qt
    libdbus-1-3 libegl1-mesa-dev libfontconfig1 libfreetype6 libglib2.0-dev \
    libxkbcommon0 libx11-6 libx11-xcb1 libxcb1-dev libxcb-cursor0 libxcb-icccm4 libxcb-image0 \
    libxcb-keysyms1 libxcb-render0 libxcb-render-util0 libxcb-shape0 libxcb-sync1 libxcb-xfixes0 libxcb-xkb1 \
    # Remove unnecessary documentation and cache files.
    # This is done in the same RUN to avoid layer bloat.
    && rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/* \
    && rm -rf /usr/share/doc/* /usr/share/man/* /usr/share/info/*
