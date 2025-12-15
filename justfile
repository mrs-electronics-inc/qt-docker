builder-run: builder
    docker run --rm -it qt-docker:builder /bin/bash
builder:
    cd builder/ && docker buildx build -t qt-docker:builder --progress=plain .

lint:
    @command -v actionlint >/dev/null && echo "Linting GHA workflows..." && actionlint
    @command -v hadolint >/dev/null && echo "Linting Dockerfiles..." && hadolint **/Dockerfile*
