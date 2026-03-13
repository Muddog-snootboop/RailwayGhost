# SMTP Setup for Ghost

Ghost requires SMTP for:
- member magic-link sign in
- newsletter delivery
- password reset/admin notifications

If SMTP is missing or broken, core membership flows fail.

## Required variables

- `mail__transport=SMTP`
- `mail__from=<verified-sender@your-domain>`
- `mail__options__host=<smtp-host>`
- `mail__options__port=587`
- `mail__options__secure=false`
- `mail__options__auth__user=<username>`
- `mail__options__auth__pass=<password-or-token>`

## Standard 587 STARTTLS configuration

Most providers support this baseline:

- Port: `587`
- `mail__options__secure=false`
- TLS upgrade via STARTTLS

Use `mail__options__secure=true` only when your provider requires implicit TLS (commonly port 465).

## Provider checklist

1. Verify sender domain (SPF + DKIM + DMARC).
2. Use a dedicated transactional sender identity.
3. Ensure credentials allow outbound SMTP.
4. Send a test member sign-in email from Ghost Admin.

## What breaks without SMTP

- Members cannot complete email-based sign in.
- Newsletter publishing with email delivery fails.
- Admin/owner password reset may fail.

## Troubleshooting

- Authentication errors: re-check username/token formatting.
- Timeout errors: provider firewall or blocked outbound ports.
- Delivered but not inboxed: missing SPF/DKIM alignment or poor domain reputation.
