# Ghost on Railway (MySQL) Starter

Production-ready starter scaffolding for running a **self-hosted Ghost paywall site** on **Railway** using **MySQL**, persistent content storage, SMTP, and Stripe memberships.

This repository focuses on deployment and operations scaffolding. It does **not** modify Ghost internals.

## Quick Start

1. Copy env template:
   ```bash
   cp .env.example .env
   ```
2. Fill `.env` with local values (especially SMTP placeholders if testing email flows).
3. Start local stack:
   ```bash
   ./scripts/local-up.sh
   ```
4. Open Ghost at [http://localhost:2368](http://localhost:2368).
5. Stop local stack:
   ```bash
   ./scripts/local-down.sh
   ```

## Architecture

```mermaid
flowchart LR
    U[Site Visitors] -->|HTTPS| R[Railway Ingress + Custom Domain]
    R --> G[Ghost Service\n(official Ghost container)]
    G --> M[(Railway MySQL)]
    G --> V[(Persistent Volume\n/content)]
    G --> S[SMTP Provider\n(Postmark/Mailgun/SES/etc.)]
    G --> P[Stripe API]
```

## Prerequisites

- Railway account + project
- GitHub repository connected to Railway
- SMTP provider credentials (for magic link login/newsletters)
- Stripe account (for paid memberships)
- Docker + Docker Compose (for local development)

## Railway Production Setup

Detailed guide: [docs/railway-deploy.md](docs/railway-deploy.md)

High-level flow:
1. Create Railway project.
2. Add **MySQL** service.
3. Add **Ghost** service from this repo (Dockerfile-based deploy).
4. Attach persistent volume mounted at `/var/lib/ghost/content`.
5. Configure required environment variables.
6. Add custom domain in Railway.
7. Configure Ghost memberships + Stripe inside Ghost Admin.

## Required Railway Variables

| Variable | Required | Example | Notes |
|---|---|---|---|
| `url` | Yes | `https://blog.example.com` | Public canonical URL |
| `PORT` | Yes | `2368` | Railway injects runtime port if configured |
| `NODE_ENV` | Yes | `production` | Production mode |
| `database__client` | Yes | `mysql` | Must be mysql |
| `database__connection__host` | Yes | `${{MYSQLHOST}}` | Map from Railway MySQL service |
| `database__connection__port` | Yes | `${{MYSQLPORT}}` | Usually 3306 |
| `database__connection__user` | Yes | `${{MYSQLUSER}}` | MySQL username |
| `database__connection__password` | Yes | `${{MYSQLPASSWORD}}` | MySQL password |
| `database__connection__database` | Yes | `${{MYSQLDATABASE}}` | MySQL database name |
| `mail__transport` | Yes | `SMTP` | Required for member emails |
| `mail__from` | Yes | `noreply@example.com` | Sender address |
| `mail__options__host` | Yes | `smtp.postmarkapp.com` | SMTP host |
| `mail__options__port` | Yes | `587` | STARTTLS port |
| `mail__options__secure` | Yes | `false` | Use false for port 587 STARTTLS |
| `mail__options__auth__user` | Yes | `postmark-server-token` | SMTP username |
| `mail__options__auth__pass` | Yes | `postmark-server-token` | SMTP password/token |

## Local Development

- Uses `docker-compose.yml` for Ghost + MySQL.
- Ghost content persisted to `./data/ghost/content`.
- MySQL data persisted in Docker named volume `mysql_data`.

Commands:

```bash
./scripts/verify-env.sh
./scripts/local-up.sh
./scripts/local-down.sh
```

## SMTP Setup

- SMTP is mandatory for Ghost member sign-in links and newsletter sends.
- See [docs/smtp.md](docs/smtp.md).

## Stripe Setup

- Stripe is configured inside Ghost Admin after deployment.
- See [docs/stripe.md](docs/stripe.md).

## Domain and HTTPS

- Railway handles ingress TLS certificates and HTTPS termination.
- Set Ghost `url` to the final `https://` custom domain.
- Add/verify domain in Railway before public launch.

## Common Failure Modes

1. **Ghost boot loops with DB errors**
   - Usually incorrect `database__connection__*` values.
2. **Member login emails never arrive**
   - SMTP credentials wrong or provider blocking sender domain.
3. **Admin URL redirects incorrectly**
   - `url` does not match deployed domain.
4. **Images/themes disappear after deploy**
   - Persistent volume not attached at `/var/lib/ghost/content`.
5. **Paid plans fail at checkout**
   - Stripe not connected in Ghost Admin or webhook not configured.

## Backup and Recovery Notes

- **Database**: use Railway MySQL backup strategy/snapshots.
- **Content volume**: regularly export `/var/lib/ghost/content`.
- **Ghost export**: periodically export members/posts from Ghost Admin as an additional fallback.
- Store restore runbooks with timestamps and test restoration quarterly.

## What this repo does NOT do

- No custom Ghost theme development.
- No Ghost core/plugin code modifications.
- No reverse proxy containers (Caddy/Nginx) in front of Ghost.
- No infrastructure-as-code (Terraform/Kubernetes/Helm).

## License

MIT. See [LICENSE](LICENSE).
