# Operations Checklist

## A) Deploy checklist (pre-launch)

- [ ] Railway project created
- [ ] MySQL service added
- [ ] Ghost service connected to this repo
- [ ] Persistent volume mounted to `/var/lib/ghost/content`
- [ ] All required env vars set (see `.env.example` and `docs/env-vars.md`)
- [ ] SMTP validated with successful test email
- [ ] Custom domain configured and HTTPS active
- [ ] Ghost `url` matches production domain exactly
- [ ] Stripe connected and paid tier configured

## B) Post-launch verification checklist

- [ ] Home page loads over HTTPS
- [ ] `/ghost` admin reachable
- [ ] New member signup works
- [ ] Magic-link login email delivered
- [ ] Paid membership purchase succeeds
- [ ] Paid-only post correctly restricted to paid tier
- [ ] Image upload persists after redeploy
- [ ] Railway logs show no crash loop

## C) Rollback / incident checklist

1. Confirm incident scope: app, DB, SMTP, Stripe, or DNS.
2. Check latest deploy logs in Railway for first failure timestamp.
3. If bad deploy:
   - roll back to previous known-good release
   - keep DB unchanged unless migration explicitly needs reversal
4. If data issue:
   - restore MySQL from latest verified backup/snapshot
   - restore Ghost content volume backup if media/themes affected
5. Validate critical flows after recovery:
   - admin login
   - member login email
   - paid content access
6. Record incident timeline, root cause, and follow-up actions.
