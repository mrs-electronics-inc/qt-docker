# List recipes
default:
    @just --list

# Run the local build of the builder image
builder-run: builder
    docker run --rm -it qt-docker/builder:local /bin/bash
# Create a local build of the builder image
builder:
    cd builder/ && docker buildx build -t qt-docker/builder:local --progress=plain .

# Run the local build of the base image
base-run: base
    docker run --rm -it qt-docker/base:local /bin/bash
# Create a local build of the base image
base:
    cd base && docker buildx build -t qt-docker/base:local --progress=plain .

# Lint all source code
lint:
    @command -v actionlint >/dev/null && actionlint
    @command -v hadolint >/dev/null && hadolint ./**/Dockerfile*
    @command -v ruff >/dev/null && ruff check .

# Format source code
format: lint
    @command -v yamlfmt >/dev/null && yamlfmt .
    @command -v ruff >/dev/null && ruff format .
