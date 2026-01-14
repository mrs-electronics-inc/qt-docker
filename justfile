# List recipes
default:
    @just --list

# Build all images (local)
build:
    docker buildx bake --load


# Build all public images (local)
build-public:
    docker buildx bake --load public

# Run the full public image interactively
run-full: build-public
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/full:local /bin/bash

# Run the NeuralPlex image interactively
run-neuralplex: build-public
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/neuralplex:local /bin/bash

# Run the MConn image interactively
run-mconn: build-public
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/mconn:local /bin/bash

# Run the FUSION public image interactively
run-fusion: build-public
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/fusion:local /bin/bash


# Build all infra images (local)
build-infra:
    docker buildx bake --load infra

# Build the builder infra image (local)
build-builder:
    docker buildx bake --load builder

# Build the base infra image (local)
build-base:
    docker buildx bake --load base

# Run the builder infra image interactively
run-builder: build-builder
    docker run --rm -it ghcr.io/mrs-electronics-inc/qt-docker/builder:local /bin/bash

# Run the base infra image interactively
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
