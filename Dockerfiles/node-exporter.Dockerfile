FROM golang:alpine3.19
LABEL MAINTAINER=spidercensus

ARG ARCH=linux-arm64
ARG NODE_EXPORTER_VERSION=1.7.0
ARG NODE_EXPORTER_PACKAGE_NAME="node_exporter-${NODE_EXPORTER_VERSION}.${ARCH}"
ARG NODE_EXPORTER_URL="https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/${NODE_EXPORTER_PACKAGE_NAME}.tar.gz"

ENV HOST_PROC=/host/proc
ENV HOST_SYS=/host/sys
ENV HOST_ROOTFS=/rootfs

RUN apk add wget
RUN wget "${NODE_EXPORTER_URL}"
RUN tar -xzvf "${NODE_EXPORTER_PACKAGE_NAME}.tar.gz"
RUN cp  "./${NODE_EXPORTER_PACKAGE_NAME}/node_exporter" /usr/local/bin/node_exporter

EXPOSE 9100

ENTRYPOINT "/usr/local/bin/node_exporter" "--path.rootfs=${HOST_ROOTFS}" "--path.procfs=${HOST_PROC}" "--path.sysfs=${HOST_SYS}"
