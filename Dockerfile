# Community Docker wrapper for the official Supermemory Local server.
# Pin both the CLI and server versions for reproducible builds.
FROM node:22-bookworm-slim

ARG SUPERMEMORY_CLI_VERSION=4.25.4
ARG SUPERMEMORY_SERVER_VERSION=0.0.7

ENV NODE_ENV=production \
    HOME=/data \
    PORT=6767 \
    SUPERMEMORY_DATA_DIR=/data/.supermemory \
    SUPERMEMORY_DISABLE_TELEMETRY=1

RUN apt-get update \
    && apt-get install --no-install-recommends --yes ca-certificates curl \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --uid 10001 --shell /usr/sbin/nologin supermemory \
    && npm install --global --omit=dev "supermemory@${SUPERMEMORY_CLI_VERSION}" \
    && mkdir -p /data/.supermemory /opt/supermemory \
    && SUPERMEMORY_INSTALL_DIR=/opt/supermemory \
       SUPERMEMORY_BIN_DIR=/usr/local/bin \
       supermemory local install --version "${SUPERMEMORY_SERVER_VERSION}" \
    && chown -R 10001:10001 /data /opt/supermemory

USER 10001:10001
WORKDIR /data
EXPOSE 6767

# The official server consumes PORT and SUPERMEMORY_DATA_DIR from the environment.
ENTRYPOINT ["supermemory-server"]
