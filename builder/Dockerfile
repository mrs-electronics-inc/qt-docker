# Lock in a specific version of UV package manager.
FROM ghcr.io/astral-sh/uv:0.9.17 AS uv

# Lock in a specific version of Python.
FROM python:3.12-slim-trixie
COPY --from=uv /uv /uvx /bin/
RUN command -v uv && uv --version

ENV HOME=/root
WORKDIR ${HOME}

# Copy in the Python project files and install from locked dependencies.
# Using this method is best for reproducibility.
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen && \
    command -v .venv/bin/aqt && .venv/bin/aqt version
ENV PATH=${HOME}/.venv/bin:${PATH}

# Install the desktop Qt kits.
# We use 5.15.0 for Qt5 and 6.8.0 for Qt6 because these are the latest LTS versions.
# Note that the installations are performed in separate RUN commands because the layers are so big;
# it's much more feasible for each layer to contain one Qt installation.
COPY qt-desktop-installer.py ./
ENV QT_PATH=/opt/Qt
RUN python3 qt-desktop-installer.py 5 ${QT_PATH}
# hadolint ignore=DL3059
RUN python3 qt-desktop-installer.py 6 ${QT_PATH}

# Add image metadata.
LABEL org.opencontainers.image.source=https://github.com/mrs-electronics-inc/qt-docker
LABEL org.opencontainers.image.description="Qt Docker builder image"
LABEL org.opencontainers.image.licenses=MIT
