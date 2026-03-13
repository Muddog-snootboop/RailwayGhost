# Environment Variables Reference

This file lists every variable required for this starter.

## Required Ghost variables

| Variable | Local (docker-compose) | Railway (production) | Required |
|---|---|---|---|
| `url` | `http://localhost:2368` | `https://blog.example.com` | Yes |
| `NODE_ENV` | `development` | `production` | Yes |
| `PORT` | `2368` | `2368` (or Railway-provided) | Yes |
| `database__client` | `mysql` | `mysql` | Yes |
| `database__connection__host` | `mysql` | `${{MYSQLHOST}}` | Yes |
| `database__connection__port` | `3306` | `${{MYSQLPORT}}` | Yes |
| `database__connection__user` | `ghost` | `${{MYSQLUSER}}` | Yes |
| `database__connection__password` | `ghostpass` | `${{MYSQLPASSWORD}}` | Yes |
| `database__connection__database` | `ghost` | `${{MYSQLDATABASE}}` | Yes |
| `mail__transport` | `SMTP` | `SMTP` | Yes |
| `mail__from` | `noreply@example.com` | `noreply@example.com` | Yes |
| `mail__options__host` | SMTP sandbox host | provider host | Yes |
| `mail__options__port` | `587` | `587` | Yes |
| `mail__options__secure` | `false` | `false` (for 587) | Yes |
| `mail__options__auth__user` | SMTP username | SMTP username | Yes |
| `mail__options__auth__pass` | SMTP password/token | SMTP password/token | Yes |

## Local MySQL bootstrap variables

These are used by `docker-compose.yml` for the local MySQL container:

| Variable | Example | Required |
|---|---|---|
| `MYSQL_ROOT_PASSWORD` | `local-root-password-change-me` | Yes |
| `MYSQL_DATABASE` | `ghost` | Yes |
| `MYSQL_USER` | `ghost` | Yes |
| `MYSQL_PASSWORD` | `ghostpass` | Yes |

## Railway variable mapping example

When Ghost and MySQL are in the same Railway project, map Ghost DB vars from MySQL service outputs:

- `database__connection__host=${{MYSQLHOST}}`
- `database__connection__port=${{MYSQLPORT}}`
- `database__connection__user=${{MYSQLUSER}}`
- `database__connection__password=${{MYSQLPASSWORD}}`
- `database__connection__database=${{MYSQLDATABASE}}`

## Notes

- Do not commit real values in `.env`.
- `.env.example` is the canonical template for onboarding and automation.
