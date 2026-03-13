#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .env ]]; then
  echo "No .env found. Run: cp .env.example .env" >&2
  exit 1
fi

./scripts/verify-env.sh
mkdir -p data/ghost/content

docker compose up -d

echo "Ghost is starting at http://localhost:${PORT:-2368}"
echo "Use: docker compose logs -f ghost"
