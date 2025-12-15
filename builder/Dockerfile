FROM python:3.12-slim-trixie
# Start from a base image, then add the UV package manager (https://github.com/astral-sh/uv).
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN command -v uv && uv --version
RUN sudo apt install just

# Set up the root user's PATH to ensure UV installs tools to a valid location.
ENV HOME=/root
ENV PATH=${HOME}/.local/bin:${PATH}
WORKDIR ${HOME}

# Download the aqt tool for unofficial Qt installations (https://github.com/miurahr/aqtinstall).
# It provides a robust CLI for installing Qt without having to go through the online installer.
RUN uv tool install aqtinstall
RUN command -v aqt && aqt version

# Install the desktop Qt kits.
# We use 5.15.0 for Qt5 and 6.8.0 for Qt6 because these are the latest LTS versions.
ENV QT_PATH=/opt/Qt
RUN aqt install-qt linux desktop 5.15.0 -O ${QT_PATH} -m all
RUN aqt install-qt linux desktop 6.8.0 -O ${QT_PATH} -m all
