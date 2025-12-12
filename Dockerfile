FROM golang:1.25-bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install \
    git \
    curl \
    ca-certificates \
    cmake \
    python3 \
    build-essential

ENV HOME=/root
ENV PATH=${HOME}/.local/bin:${PATH}
WORKDIR ${HOME}

RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN command -v uv && uv --version

RUN uv tool install aqtinstall
RUN command -v aqt && aqt version

WORKDIR /opt
ENV QT_PATH=/opt/Qt
COPY qt-setup.sh .
RUN ./qt-setup.sh
# RUN aqt install-qt linux desktop 5.15.0 -O ${QT_PATH} -m all
# RUN aqt install-qt linux desktop 6.8.0 -O ${QT_PATH} -m all
# RUN aqt install-qt linux desktop 5.15.0 -O ${QT_PATH}
# RUN aqt install-qt linux desktop 6.8.0 -O ${QT_PATH}
# RUN mkdir logs && mv aqtinstall.log logs

WORKDIR ${HOME}
ENV PATH=$QT_PATH/5.15.0/gcc_64/bin:$QT_PATH/6.8.0/gcc_64/bin:$PATH
