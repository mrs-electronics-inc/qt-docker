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

# Install the desktop Qt kits.
# We use 5.15.0 for Qt5 and 6.8.0 for Qt6 because these are the latest LTS versions.
ENV QT_PATH=/opt/Qt
RUN .venv/bin/aqt install-qt linux desktop 5.15.0 -O ${QT_PATH} -m all
# These commands need to be broken up because both layers are huge by themselves.
# Combining into one layer is just too big.
# hadolint ignore=DL3059
RUN .venv/bin/aqt install-qt linux desktop 6.8.0 -O ${QT_PATH} -m all
