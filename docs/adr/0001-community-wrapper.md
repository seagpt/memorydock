# ADR-0001: Ship an upstream-compatible community Docker wrapper

- **Status:** Accepted
- **Date:** 2026-08-15
- **Decision makers:** Community maintainers

## Context and problem statement

Supermemory Local is documented as an installable local server with an API-compatible base URL. Teams still need a reproducible, secure-by-default way to operate it with Compose: a private bind address, persistent state, non-interactive configuration, pinned versions, health checks, backup gates, and a clear boundary between community deployment code and upstream server behavior.

The project must not misrepresent itself as official, reimplement the memory API, ship secrets, or claim feature parity with upstream hosted-only products.

## Decision drivers

- Preserve upstream API and lifecycle semantics.
- Make local operation low-friction and reversible.
- Default to private network exposure and least privilege.
- Make upgrades and restore verification explicit.
- Allow community contributions without importing private runtime data.

## Considered options

1. A thin Compose wrapper around the official server installer and binary.
2. Fork the upstream server into a Docker-first distribution.
3. Publish only documentation and leave container assembly to each user.

## Decision outcome

Choose **option 1**. The repository downloads a pinned official server through the official CLI at image build time, configures it by supported environment variables, and persists its native data directory in a named volume.

## Consequences

### Good

- The deployment stays close to the official local path.
- Upgrades are explicit and can be tested independently.
- Security defaults are reviewable in one Compose file.
- The project can focus on operational evidence rather than rebuilding memory extraction.

### Bad

- The server release asset is fetched during the image build.
- Docker availability is required for the supplied quick start.
- Self-hosted capability does not equal hosted-platform feature parity.
- Users remain responsible for their LLM provider, data governance, backup, and access controls.

## Non-goals

- Operate a multi-tenant hosted service.
- Claim official affiliation.
- Redistribute a proprietary hosted extraction pipeline.
- Build an alternative API or silently alter source/memory lifecycle semantics.

## Acceptance criteria

The wrapper is acceptable only when a supported runtime proves the documented synthetic health, ingest, retrieval, forget, restart, and restore gates without private content.
