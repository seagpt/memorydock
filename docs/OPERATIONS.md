# Operations guide

## Before first start

1. Create `.env` from `.env.example` and add one supported LLM configuration.
2. Keep `.env` in a secrets manager-backed workflow; do not commit it.
3. Confirm the default loopback bind is appropriate. If not, design an authenticated private access boundary first.
4. Set a durable Docker volume location according to your host’s backup policy.
5. Record the CLI/server pins and image digest after the first validated build.

## Start and observe

```bash
docker compose up --build -d
docker compose ps
docker compose logs --tail=100 supermemory
curl --fail http://127.0.0.1:6767/v3/health
```

A health endpoint only proves that the HTTP process is available. It does not prove asynchronous ingestion, memory extraction, scoped retrieval, or deletion semantics.

## Backup

Stop writes before a filesystem-level backup. Use your Docker platform’s documented volume backup mechanism. Capture metadata alongside the archive:

- server and CLI versions;
- image digest;
- backup timestamp;
- volume name;
- upstream migration/release note reference; and
- a checksum of the archive.

Do not place a raw backup archive in GitHub, an issue, chat, or a public CI artifact.

## Restore drill

1. Restore to a new isolated volume.
2. Start a temporary Compose project on a non-conflicting loopback port.
3. Run the synthetic acceptance checks from `docs/ACCEPTANCE.md`.
4. Compare only aggregate proof (pass/fail, status, latency), not private memory bodies.
5. Destroy the temporary environment when complete.

## Upgrade decision gate

No production upgrade until all apply:

- backup completed and checksum recorded;
- upstream release notes reviewed;
- disposable clone starts;
- health check passes;
- synthetic create → terminal status → retrieval passes;
- direct-memory soft forget passes with a genuine memory ID;
- restart and restore checks pass; and
- rollback path is documented.

## Incident basics

1. Stop publishing logs and preserve evidence privately.
2. If a credential may have reached a log, index, issue, or chat, rotate/revoke it immediately.
3. Do not assume soft forget or document deletion alone eliminates exposure from all backups/caches.
4. Restore service only after root cause and private evidence review.
