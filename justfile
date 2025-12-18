builder-run: builder
    docker run --rm -it qt-docker/builder:local /bin/bash
builder:
    cd builder/ && docker buildx build -t qt-docker/builder:local --progress=plain .

base-run: base
    docker run --rm -it qt-docker/base:local /bin/bash
base:
    cd base && docker buildx build -t qt-docker/base:local --progress=plain .

lint:
    @command -v actionlint >/dev/null && actionlint
    @command -v hadolint >/dev/null && hadolint ./**/Dockerfile*
