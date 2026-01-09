# List recipes
default:
    @just --list

# Build all infra images (local)
build-infra:
    docker buildx bake --load infra

# Build the builder image (local)
build-builder:
    docker buildx bake --load builder

# Build the base image (local)
build-base:
    docker buildx bake --load base

# Run the builder image interactively
run-builder: build-builder
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/builder:local /bin/bash

# Run the base image interactively
run-base: build-base
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/base:local /bin/bash


# Lint all source code
lint:
    @command -v actionlint >/dev/null && actionlint
    @command -v hadolint >/dev/null && find . -name 'Dockerfile*' -exec hadolint {} +
    @command -v ruff >/dev/null && ruff check .

# Format source code
format: lint
    @command -v yamlfmt >/dev/null && yamlfmt .
    @command -v ruff >/dev/null && ruff format .
