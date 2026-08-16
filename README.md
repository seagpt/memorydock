# Supermemory Local Docker

> Docker Compose for Supermemory Local, built from pinned upstream releases.
> Unofficial and not affiliated with Supermemory.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Community project](https://img.shields.io/badge/status-community%20project-6f42c1)](https://github.com/seagpt/supermemory-local-docker)
[![Upstream: Supermemory](https://img.shields.io/badge/upstream-Supermemory-111827)](https://github.com/supermemoryai/supermemory)

Docker Compose for the official [Supermemory Local](https://docs.supermemory.ai/self-hosting/quickstart) server. This is a community-maintained, unofficial wrapper; it does not fork, replace, or represent Supermemory.

- **Loopback-only by default** — the API is not published to the Internet accidentally.
- **Persistent named volume** — graph data, generated local auth material, and embedding cache survive container replacement.
- **Pinned versions** — CLI and server version are explicit and reviewable.
- **Non-interactive deployment** — provider configuration belongs in a private `.env` or secrets manager.
- **Production-shaped guardrails** — healthcheck, least privilege, read-only root filesystem, dropped Linux capabilities, and upgrade/restore gates.

> [!IMPORTANT]
> This is **not affiliated with, endorsed by, or sponsored by Supermemory**. “Supermemory” is used only to accurately describe compatibility with the upstream local server. Hosted-only functionality remains hosted-only.

## Why this exists

Long-horizon agents need memory that can be inspected, backed up, moved, tested, and operated deliberately. A local deployment makes that practical without pretending that “a vector database” alone is memory.

Use this project when you want to:

- prototype a private assistant or developer tool;
- run the official local Supermemory API beside your agent stack;
- learn the complete document → extraction → search lifecycle;
- keep operational ownership of data and upgrades; or
- contribute reproducible deployment, backup, test, and documentation improvements to the ecosystem.

## What you get — and what you do not

| Included through the official local server | Not supplied by this community wrapper |
|---|---|
| Documents, memories, profiles, spaces/filtering, local search API | Hosted connectors (Drive, Notion, Gmail, OneDrive) |
| Bring-your-own LLM / OpenAI-compatible model endpoints | Hosted Supermemory MCP service |
| Local/default embeddings or supported alternate embedding providers | Supermemory’s hosted optimized extraction pipeline |
| Local data ownership and backup control | Managed global scale, managed support, or an official image |

The upstream docs say the local server’s standard memory API works against a local base URL. The server still needs a supported LLM provider for extraction; local embeddings are a separate concern.

## Quick start

### 1. Prerequisites

- Docker Engine with Docker Compose v2
- One supported LLM provider credential **or** a reachable OpenAI-compatible endpoint
- Enough disk for the persistent data volume and embedding cache

### 2. Configure privately

```bash
git clone https://github.com/seagpt/supermemory-local-docker.git
cd supermemory-local-docker
cp .env.example .env
```

Edit `.env` locally. It is gitignored. Set exactly the provider configuration you intend to use; never commit it. The current starter pins CLI `4.25.4` and official server `0.0.7`; update either only through the documented backup/test/release-note gate.

### 3. Start

```bash
docker compose up --build -d
docker compose ps
curl http://127.0.0.1:6767/v3/health
```

The first start can take longer while the official server initializes its local graph engine and embedding model. `docker compose ps` should eventually report `healthy`.

### 4. Point a client at it

```python
from supermemory import Supermemory

client = Supermemory(
    api_key="your-local-server-bearer-token",
    base_url="http://127.0.0.1:6767",
)

# Use the upstream SDK/API documentation for endpoint-specific calls.
```

The local server generates its own bearer token on first boot. Treat it like a password. Retrieve it from the private server state/logs according to the upstream documentation; do not paste it into an issue or commit.

## Operating model

### Safety defaults

- Port bind: `127.0.0.1:${SUPERMEMORY_PORT:-6767}`
- Runtime user: unprivileged UID `10001`
- Root filesystem: read-only
- Writable locations: persistent `/data` and a bounded temporary filesystem
- Linux capabilities: dropped
- Telemetry: disabled through `SUPERMEMORY_DISABLE_TELEMETRY=1`

If you need remote access, put an authenticated reverse proxy or private-network boundary in front of the service. Do **not** simply bind this API to `0.0.0.0` on a public host.

### Data and backups

All runtime state lives in the `supermemory-local-data` named volume by default. Back it up before an upgrade. A practical restore is not complete until an isolated container can start from the backup and pass a synthetic create → retrieve → delete/forget verification.

See [the operations guide](docs/OPERATIONS.md).

### Upgrades

1. Read upstream release notes and compatibility notes.
2. Back up the named volume.
3. Change `SUPERMEMORY_SERVER_VERSION` and/or `SUPERMEMORY_CLI_VERSION` in `.env`.
4. Build and start a disposable test instance from a copied volume.
5. Run the acceptance suite with synthetic data.
6. Promote only if search, profile, lifecycle, and restore checks pass.

Never use an untested downgrade against a newer data directory.

## Acceptance contract

A healthy deployment is more than a green health endpoint. Before calling a deployment ready, prove:

1. a synthetic document is accepted;
2. its asynchronous status reaches a terminal success state;
3. expected scoped retrieval works;
4. a direct v4 memory can be written and softly forgotten with a **real memory ID**;
5. a document ID is never sent to the memory-forget endpoint;
6. restart preserves expected behavior;
7. restore from a backup does too; and
8. no credential or private corpus appears in logs, examples, or test fixtures.

See [`docs/ACCEPTANCE.md`](docs/ACCEPTANCE.md).

## Architecture

```text
Agent / SDK
    │  official Supermemory API
    ▼
Docker Compose ──► official Supermemory Local server
                        │
                        ├── async document ingestion + extraction
                        ├── direct memories / profiles / search
                        ├── local or configured embedding provider
                        └── persistent /data volume
```

This repository owns only the container boundary and operational tooling. Upstream owns the server behavior and API contract.

## Contributing

Start with [`CONTRIBUTING.md`](CONTRIBUTING.md). We welcome deployment hardening, observability, synthetic acceptance tests, docs, backup/restore automation, and upstream-compatible integration examples.

Every architectural decision requires an ADR. See [`docs/adr/0001-community-wrapper.md`](docs/adr/0001-community-wrapper.md).

## Community positioning

The project exists to help developers make durable agent memory **boring to run and easy to verify**. The community goal is not to create a competing managed platform; it is to improve the self-hosted path around the upstream project with honest documentation, safe defaults, and reproducible evidence.

If this project helps you, please:

- star/watch the repository;
- file a synthetic, reproducible issue;
- contribute a verified deployment pattern; and
- support the upstream Supermemory project directly.

## License

This repository’s original wrapper code and documentation are released under [MIT](LICENSE). The official Supermemory server, CLI, SDKs, name, logos, and upstream material retain their respective terms. This is a **recipe**: it downloads the selected upstream binary during a user’s own image build and does not publish a prebuilt image. Do not remove, bypass, or misrepresent upstream document-cap, licensing, or service terms; obtain upstream clarification before commercial redistribution or registry publishing of an image containing its binary.
