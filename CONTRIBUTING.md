# Contributing

Thank you for helping make private, portable agent memory easier to operate.

## Ground rules

- This is a **community companion**, branded MemoryDock, not an official Supermemory distribution or support channel.
- Preserve upstream behavior: do not replace the official API with a look-alike service.
- Never include API keys, tokens, database snapshots, proprietary prompts, real memory content, or production logs.
- Keep claims testable and distinguish local self-hosted behavior from hosted-platform-only features.

## Change workflow

1. Open an issue describing the user problem and expected observable outcome.
2. For architectural changes, add or update an ADR in `docs/adr/`.
3. Add a reproducible test or validation step using synthetic content.
4. Run `./scripts/validate.sh` and the relevant smoke test.
5. Explain compatibility, security implications, upgrade behavior, and rollback in the pull request.

## Scope guardrails

Good contributions: Compose hardening, documentation, reproducible upgrade/backup scripts, health checks, synthetic acceptance tests, and upstream-compatible integration examples.

Out of scope: a forked proprietary extraction engine, a hosted multi-tenant service, dashboards that transmit private corpus data, claims of official affiliation, or a replacement for upstream licensing/support.
