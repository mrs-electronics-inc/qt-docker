# AGENTS.md

This repository contains Docker images with Qt installations for CI/CD pipelines.

## Project Structure

- `infra/` - Private infrastructure images
  - `base/` - Base Docker image with Debian + Qt runtime dependencies
  - `builder/` - Builder image that installs Qt 5.15.0 and Qt 6.8.0 using `aqt`
- `public/` - Public product images (neuralplex, mconn, fusion, all)
- `.github/workflows/` - CI/CD workflows for building and linting

## Common Commands

Use `just` recipes for development tasks:

```bash
just              # List all available recipes
just builder      # Build the builder image locally
just builder-run  # Build and run builder image interactively
just base         # Build the base image locally
just base-run     # Build and run base image interactively
just lint         # Lint all source code (actionlint, hadolint, ruff)
just format       # Format YAML and Python files
```

## Linting

Run `just lint` before committing. This requires:

- `actionlint` - GitHub Actions workflow linter
- `hadolint` - Dockerfile linter
- `ruff` - Python linter

Pre-commit hooks are configured in `.pre-commit-config.yaml`.

## Technologies

- **Docker**: All images use pinned versions/SHAs for reproducibility
- **Python**: Used in `infra/builder/qt-desktop-installer.py` for Qt installation
- **uv**: Python package manager (locked deps in `infra/builder/uv.lock`)
- **aqt**: Qt installer tool (`aqtinstall` package)

## Key Conventions

- Pin all package versions explicitly in Dockerfiles
- Use SHA-pinned base images when possible
- Keep Docker layers small by cleaning up in the same RUN command
- Qt installations go to `/opt/Qt` in the builder image
