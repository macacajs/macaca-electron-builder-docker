FROM ubuntu:18.04

COPY sources.list /etc/apt/sources.list

RUN dpkg --add-architecture i386

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
    libnotify-bin \
    locales \
    lsb-release \
    nano \
    python-dbus \
    python-pip \
    python-setuptools \
    sudo \
    vim-nox \
    wget \
    g++-multilib \
    libgl1:i386 \
    xvfb \
  && rm -rf /var/lib/apt/lists/*

# Variable Layer: Node.js etc.
ENV NODE_VERSION=8.12.0 \
    NODE_REGISTRY=https://npm.taobao.org/mirrors/node \
    CHROMEDRIVER_CDNURL=http://npm.taobao.org/mirrors/chromedriver/ \
    ELECTRON_MIRROR=https://npm.taobao.org/mirrors/electron/ \
    DISPLAY=':99.0' \
    NODE_IN_DOCKER=1

RUN curl -SLO "$NODE_REGISTRY/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
      && tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
      && rm "node-v$NODE_VERSION-linux-x64.tar.gz"

COPY entrypoint.sh /root/entrypoint.sh

WORKDIR /root

ENTRYPOINT ["./entrypoint.sh"]

CMD ["/bin/bash"]
