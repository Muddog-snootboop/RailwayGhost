#!/usr/bin/env bash
set -euo pipefail

ENV_FILE=".env"
if [[ "${1:-}" == "--ci" ]]; then
  ENV_FILE=".env.example"
fi

required_vars=(
  url
  PORT
  NODE_ENV
  database__client
  database__connection__host
  database__connection__port
  database__connection__user
  database__connection__password
  database__connection__database
  mail__transport
  mail__from
  mail__options__host
  mail__options__port
  mail__options__secure
  mail__options__auth__user
  mail__options__auth__pass
  MYSQL_ROOT_PASSWORD
  MYSQL_DATABASE
  MYSQL_USER
  MYSQL_PASSWORD
)

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing $ENV_FILE. Copy .env.example to .env first." >&2
  exit 1
fi

missing=0
for key in "${required_vars[@]}"; do
  if ! grep -E -q "^${key}=" "$ENV_FILE"; then
    echo "Missing key in ${ENV_FILE}: ${key}" >&2
    missing=1
  fi
done

if [[ "$missing" -ne 0 ]]; then
  exit 1
fi

echo "Environment file ${ENV_FILE} contains all required keys."
