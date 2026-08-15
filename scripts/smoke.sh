#!/usr/bin/env bash
set -euo pipefail

# This test intentionally uses synthetic data only.
# It proves the Compose service reaches health; lifecycle/retrieval tests require
# an explicit approved provider configuration and are documented in ACCEPTANCE.md.
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

command -v docker >/dev/null || { echo 'Docker is required.' >&2; exit 127; }
[[ -f .env ]] || { echo 'Create .env from .env.example first.' >&2; exit 2; }

docker compose up --build -d
trap 'docker compose down' EXIT

for _ in $(seq 1 45); do
  if curl --fail --silent --show-error http://127.0.0.1:"${SUPERMEMORY_PORT:-6767}"/v3/health >/dev/null; then
    echo 'health: passed'
    exit 0
  fi
  sleep 2
done

docker compose logs --tail=150 supermemory >&2
exit 1
