#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

for file in Dockerfile compose.yaml .dockerignore .env.example README.md LICENSE SECURITY.md CONTRIBUTING.md docs/adr/0001-community-wrapper.md; do
  [[ -s "$file" ]] || { printf 'missing or empty: %s\n' "$file" >&2; exit 1; }
done

grep -q '^OPENAI_API_KEY=__SET_IN_PRIVATE_ENV__$' .env.example
grep -q '127.0.0.1' compose.yaml
grep -q 'no-new-privileges:true' compose.yaml
grep -q 'SUPERMEMORY_SERVER_VERSION' Dockerfile
grep -q 'not affiliated' README.md

if command -v docker >/dev/null 2>&1; then
  temporary_env=0
  if [[ ! -f .env ]]; then
    cp .env.example .env
    temporary_env=1
    trap '[[ "$temporary_env" -eq 1 ]] && rm -f .env' EXIT
  fi
  docker compose config --quiet
  printf 'static + Compose validation: passed\n'
else
  printf 'static validation: passed (Docker unavailable; Compose rendering not run)\n'
fi
