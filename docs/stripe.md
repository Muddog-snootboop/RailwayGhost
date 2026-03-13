# Stripe Setup for Ghost Memberships

Ghost integrates with Stripe for paid memberships and paywalled content.

## Prerequisites

- Ghost site deployed and reachable via HTTPS custom domain
- SMTP fully working (member authentication depends on email)
- Stripe account with access to API keys/dashboard

## Setup steps

1. In Ghost Admin, go to **Settings → Membership**.
2. Connect Stripe account.
3. Create at least one paid tier (monthly/yearly).
4. Configure portal/signup pages for tier visibility.
5. Publish a post/page gated to paid members.

## Operational notes

- Keep Stripe account in correct mode (test vs live).
- Use production domain in Ghost `url` before going live.
- Verify webhook/event handling through Ghost’s Stripe integration status.

## Post-setup verification checklist

- [ ] Free member signup works end-to-end.
- [ ] Magic login email arrives reliably.
- [ ] Paid checkout completes successfully.
- [ ] Paid member receives access to protected content.
- [ ] Cancellation and access downgrade behavior is correct.
- [ ] Invoice and customer objects appear correctly in Stripe.
