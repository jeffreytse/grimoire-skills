---
name: prevent-dark-patterns
description: Use when reviewing or designing e-commerce flows, subscription sign-ups, cookie consent banners, settings pages, and cancellation flows — to identify and remove deceptive UX patterns that manipulate users against their own interests.
source: Brignull "Dark Patterns" taxonomy (deceptive.design, 2010); EU Digital Services Act Article 25 (2022); FTC "Bringing Dark Patterns to Light" (2022); NNG "Dark Patterns in UX" (Gibbons, 2023)
tags: [dark-patterns, deceptive-ux, ethics, ux-review, compliance, consumer-protection, ui-patterns]
---

# Avoid Dark Patterns

Audit flows for Brignull's dark pattern taxonomy, classify each by deception type and legal risk, and redesign to eliminate manipulation while preserving legitimate conversion goals.

## Why This Is Best Practice

**Adopted by:** The EU Digital Services Act (DSA) Article 25 (2022) explicitly prohibits dark patterns for platforms with 45M+ EU monthly users; the FTC published "Bringing Dark Patterns to Light" (2022) with enforcement guidelines and named dark patterns in settlements against companies including Amazon (2023, $25M settlement) and Vonage (2023, $100M settlement); the Norwegian Consumer Council's "Deceived by Design" (2018) report named Google, Facebook, and Microsoft as dark pattern practitioners and triggered regulatory investigations in multiple EU jurisdictions
**Impact:** FTC enforcement actions demonstrate measurable financial and reputational risk: Amazon's $25M settlement for Prime cancellation dark patterns; Epic Games' $520M settlement for dark patterns targeting children in Fortnite; the EU's enforcement of DSA Article 25 creates ongoing regulatory exposure for platforms with large EU user bases; NNG user studies show dark patterns reduce long-term trust and customer lifetime value even when they improve short-term conversion metrics
**Why best:** Dark patterns produce short-term conversion gains at the cost of long-term trust — users who feel manipulated churn, leave negative reviews, and do not return; the alternative to dark patterns is not zero conversion — it is honest conversion, where users who take an action do so intentionally and remain customers; the legal and reputational risk of dark patterns now exceeds their conversion benefit in most regulated markets

Sources: Brignull "Deceptive Design" (deceptive.design, 2010 — updated taxonomy); EU Digital Services Act Article 25 (2022); FTC "Bringing Dark Patterns to Light" (2022); NNG "Dark Patterns in UX" (Gibbons, 2023); Norwegian Consumer Council "Deceived by Design" (2018)

## Steps

### 1. Audit using Brignull's dark pattern taxonomy

Review the flow for each of the following patterns:

**Trick questions**
Pre-checked boxes that opt users into things they didn't intend. Inverted or confusing checkbox logic ("Uncheck to not receive emails").
- ❌ `[✓] Yes, I want to receive marketing emails` (pre-checked)
- ✅ `[ ] Send me product updates and offers` (unchecked by default)

**Sneak into basket**
Items added to the cart during checkout without explicit user action (often insurance, add-ons, or donations).
- ❌ Travel insurance added to cart by default; user must find and remove it
- ✅ Travel insurance offered as an opt-in step

**Roach motel**
Easy to get into, hard to get out of. Subscriptions with a "1-click signup" but a multi-step phone-call-required cancellation.
- ❌ Cancel subscription requires finding a hidden link, calling customer service, and completing a retention interview
- ✅ Cancel subscription is accessible from account settings with a 2-click confirmation

**Privacy zuckering**
Confusing, layered privacy settings designed to maximize data collection by making the privacy-protective option hard to find or understand.
- ❌ Cookie banner with an "Accept all" button and "Manage preferences" buried 3 clicks deep
- ✅ Cookie banner with equally prominent "Accept all" and "Reject non-essential" options on the first screen (required under EU GDPR)

**Misdirection**
Visual design or copy draws attention to one option while obscuring another. Typically used to make the undesirable choice (for the user) visually prominent.
- ❌ Dark, prominent "Upgrade to Pro" button; "Continue free" in small gray text below it
- ✅ Both options at equal visual weight when the user hasn't indicated preference

**Confirmshaming**
Opt-out copy that shames or guilts the user for declining: "No thanks, I hate saving money."
- ❌ "No thanks, I don't want more traffic."
- ✅ "No thanks" or "Maybe later"

**Disguised ads**
Content or links styled to look like editorial content, search results, or system UI.
- ❌ Sponsored results with "Ad" in 8px gray text identical in layout to organic results
- ✅ Sponsored results with clearly differentiated visual treatment (background, labeled "Sponsored" in visible text)

**Forced continuity**
Free trial that requires credit card; automatic billing at end of trial with no warning email.
- ❌ Trial ends, user is charged with no reminder; cancellation requires finding buried settings
- ✅ Email reminder 3–7 days before trial ends with a clear link to cancel

**Hidden costs**
Fees, taxes, or charges that appear only at the final step of checkout.
- ❌ Product shown at $29 throughout checkout; $8 processing fee and $6 shipping appear on the final confirmation page
- ✅ Estimated total including fees shown from the first product page or early in checkout

**Bait and switch**
Advertising one outcome but delivering another. Clicking "Update now" installs software the user didn't intend.

**Interface interference**
Making the privacy-protective or consumer-protective option harder to use — greyed out buttons, extra confirmation steps, broken unsubscribe links.

**Nagging**
Repeatedly prompting for the same action the user has already declined (cookie consent, push notification permission, review requests).

### 2. Classify by deception severity and legal risk

For each dark pattern found:

| Severity | Criteria | Action |
|----------|----------|--------|
| **High** | Meets FTC/DSA prohibited pattern definition; creates regulatory exposure | Remove immediately; escalate to legal |
| **Medium** | Manipulative but not clearly illegal; long-term trust risk | Redesign in current sprint |
| **Low** | Aggressive but not manipulative; creates friction without deception | Review against brand values |

High-severity patterns in markets with active enforcement (EU, US, UK, Australia): prioritize removal over conversion optimization.

### 3. Redesign for honest conversion

For each dark pattern found, the redesign goal is honest conversion — keeping the conversion opportunity without the deception:

| Dark pattern | Dishonest version | Honest version |
|--------------|------------------|----------------|
| Pre-checked add-on | Adds item to cart automatically | Offers item clearly as an opt-in during checkout |
| Roach motel cancellation | Cancellation hidden/phone-required | Cancellation in account settings, 2-click confirmation |
| Confirmshaming | "No thanks, I hate saving money" | "No thanks" |
| Forced continuity | Silent billing after trial | Email reminder 7 days before; clear cancellation link |
| Hidden costs | Fee appears at final step | Estimated total shown from product page |

Honest conversion typically produces slightly lower initial conversion rates but significantly higher 30-day retention and lower churn — because users who converted intended to.

### 4. Apply cookie consent compliance (EU GDPR / DSA minimum)

Cookie banners are the most litigated dark pattern area in the EU. Minimum compliant design:
- "Accept all" and "Reject non-essential" (or equivalent decline) on the same initial screen with equal visual prominence
- "Manage preferences" available as an additional option, not as a substitute for decline
- No pre-ticked consent boxes
- Consent must be as easy to withdraw as to give (GDPR Article 7(3))

Non-compliant cookie banners have resulted in fines against Google (€150M), Facebook (€60M), and Microsoft under CNIL enforcement.

### 5. Document findings for stakeholders

For each dark pattern found, document:
- Screenshot with annotation
- Pattern name (from Brignull taxonomy)
- Regulatory risk (FTC/DSA/GDPR applicability)
- Recommended redesign
- Estimated conversion impact of fix (if known)

Present to product, legal, and design leads. Dark pattern removal requires stakeholder alignment because it typically affects conversion metrics that teams are measured on.

## Rules

- Pre-checked opt-ins are prohibited by GDPR for marketing emails and most consent purposes — remove them
- All unsubscribe and cancellation flows must be accessible without contacting customer service — buried cancellation is a roach motel pattern
- Cookie consent must offer decline at equal visual prominence to accept on the initial banner — a buried "Manage preferences" is not compliant
- Never use confirmshaming copy — the opt-out copy must be neutral
- Hidden fees that appear only at checkout final confirmation are FTC-prohibited unfair or deceptive trade practices in the US

## Common Mistakes

- **Assuming dark patterns only affect conversion rates**: the primary risk is now regulatory — FTC and EU enforcement actions carry multi-million dollar penalties that dwarf conversion gains
- **Treating cookie banners as a legal formality**: dark pattern cookie banners are one of the most actively enforced GDPR violations; a non-compliant banner is not "close enough"
- **Confusing aggressive design with dark patterns**: a prominent CTA with clear intent is not a dark pattern; a CTA that is designed to mislead users about what will happen when they click is
- **Removing dark patterns without measuring the honest alternative**: removing a trick question without measuring whether the unchecked opt-in still converts reduces stakeholder support; measure and report honest conversion rates

## When NOT to Use

- When reviewing purely internal tools (admin dashboards, internal ops tools) with no external user base — dark pattern risk is a consumer protection concern; internal tools have different ethics considerations
- When the "pattern" is a legitimate UX convention (e.g., a single prominent CTA on a landing page is not misdirection — it's hierarchy) — apply the taxonomy carefully; not every asymmetric design is a dark pattern
