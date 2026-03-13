# AGENTS.md

Guidance for coding agents (Codex, Claude, etc.) working in this repository.

## Repository Purpose

This repository is deployment scaffolding for running Ghost on Railway with:
- Ghost service (official container)
- Railway MySQL service
- persistent Ghost content storage
- SMTP integration
- Stripe-ready memberships/paywall

Target platform is **Railway**. Keep changes aligned with that platform unless explicitly requested otherwise.

## Repository Layout

- `README.md` - primary onboarding and architecture doc
- `.env.example` - source-of-truth for required environment variables
- `docker-compose.yml` - local Ghost + MySQL stack
- `railway.json` - Railway runtime/deploy hints
- `docs/railway-deploy.md` - production Railway setup playbook
- `docs/env-vars.md` - variable-by-variable environment reference
- `docs/smtp.md` - SMTP implementation guidance
- `docs/stripe.md` - Ghost membership + Stripe guidance
- `docs/ops-checklist.md` - deploy/post-launch/incident checklists
- `scripts/` - local helper scripts (`verify-env.sh`, `local-up.sh`, `local-down.sh`)
- `.github/workflows/validate.yml` - lightweight CI validation

## Source-of-Truth Rules

1. Environment variable names and requirements must be defined in `.env.example` first.
2. Deployment behavior should be documented in `docs/railway-deploy.md`.
3. If infrastructure expectations change, update both docs and scripts in the same PR.
4. Ghost content persistence is required. Never remove content volume guidance or mounts.

## Commands for Validation

Run from repository root:

```bash
./scripts/verify-env.sh
./scripts/local-up.sh
./scripts/local-down.sh

docker compose config
```

Optional CI-equivalent checks:

```bash
yamllint docker-compose.yml .github/workflows/validate.yml
```

## Conventions

- Keep setup boring and production-safe.
- Use MySQL for production (never document SQLite as production default).
- Do not hardcode secrets.
- Prefer explicit docs over implied behavior.
- Keep scripts POSIX shell and idempotent where practical.
- If infra/env changes are made, update `README.md` and `docs/*.md` together.
