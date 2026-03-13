# Railway Deployment Guide (Ghost + MySQL)

This is the exact production path for deploying Ghost on Railway with paid memberships.

## 1) Create project and services

1. Create a new Railway project.
2. Add a **MySQL** service.
3. Add a **GitHub repo service** pointing to this repository for Ghost.

## 2) Configure persistent storage

In the Ghost service:
1. Open **Volumes**.
2. Create/attach a volume.
3. Mount path: `/var/lib/ghost/content`.

Without this mount, images/themes/uploads are lost on redeploy.

## 3) Configure environment variables

Set these in the Ghost service (Variables tab):

- `url=https://blog.example.com`
- `PORT=2368`
- `NODE_ENV=production`
- `database__client=mysql`
- `database__connection__host=${{MYSQLHOST}}`
- `database__connection__port=${{MYSQLPORT}}`
- `database__connection__user=${{MYSQLUSER}}`
- `database__connection__password=${{MYSQLPASSWORD}}`
- `database__connection__database=${{MYSQLDATABASE}}`
- `mail__transport=SMTP`
- `mail__from=noreply@example.com`
- `mail__options__host=smtp.provider.tld`
- `mail__options__port=587`
- `mail__options__secure=false`
- `mail__options__auth__user=<smtp-user>`
- `mail__options__auth__pass=<smtp-pass>`

Tip: reference the MySQL service variables directly where Railway supports shared vars.

## 4) Deploy and verify logs

1. Trigger deploy from Railway (or push to main if auto-deploy enabled).
2. Check logs for:
   - DB connection successful
   - Ghost starts and listens on port 2368
   - No repeated restart loop

## 5) Configure custom domain and HTTPS

1. In Railway, add custom domain to Ghost service.
2. Point DNS records as instructed by Railway.
3. Wait for cert provisioning.
4. Ensure `url` exactly matches `https://<custom-domain>`.

## 6) Ghost initial setup

1. Open `https://<domain>/ghost`.
2. Create admin user.
3. Configure site title, publication language, branding.

## 7) Test signup and paywall flow

1. Enable memberships in Ghost Admin.
2. Connect Stripe under **Settings → Membership**.
3. Create paid tier.
4. Visit public site, sign up as member, confirm email login link works.
5. Complete test checkout for paid tier and confirm access.

## 8) Ongoing checks

- Validate backups for MySQL and Ghost content volume.
- Review Railway metrics and restart counts.
- Keep SMTP sender domain authenticated (SPF/DKIM/DMARC).
