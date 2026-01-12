FROM ghcr.io/mrs-electronics-inc/qt-docker/builder:latest AS builder

FROM ghcr.io/mrs-electronics-inc/qt-docker/base:latest

# Copy Qt toolchains for FUSION devices from the builder image.
COPY --from=builder --parents /opt/Qt/5.15.0 /

# Add image metadata.
LABEL org.opencontainers.image.source="https://github.com/mrs-electronics-inc/qt-docker"
LABEL org.opencontainers.image.description="Docker image containing MRS Qt toolchains for FUSION projects"
LABEL org.opencontainers.image.licenses="MIT"
