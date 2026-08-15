# Security policy

## Scope

This project is a community Docker/Compose wrapper for the official Supermemory Local server. It does not operate a hosted service and must not receive user data, API keys, local database archives, or production logs in issues or pull requests.

## Reporting a vulnerability

Do **not** open a public issue for a suspected vulnerability. Use GitHub's private security advisory flow for this repository, with:

- affected version or commit;
- reproducible steps using synthetic data only;
- security impact; and
- proposed mitigation if available.

For an upstream Supermemory server or SDK issue, also report through the official upstream security channel/repository.

## Safe operation baseline

- Bind to `127.0.0.1` by default; do not expose the unauthenticated port directly to the Internet.
- Keep `.env`, runtime data volumes, backups, generated local API keys, and logs private.
- Use an authenticated reverse proxy or private network boundary for remote access.
- Use a secrets manager for provider credentials; rotate a credential if it enters a terminal transcript, issue, chat, or index.
- Back up the named volume before upgrades and test restore in an isolated environment.

## Supported versions

Security fixes target the latest repository `main` and currently documented pinned server/CLI versions.
