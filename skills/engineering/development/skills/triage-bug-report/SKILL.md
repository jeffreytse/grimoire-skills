---
name: triage-bug-report
description: Use when a bug report is filed — to reproduce it, assess severity and priority, capture required context, and assign it before any diagnosis begins.
source: Mozilla "Bug Triage" process (wiki.mozilla.org/BMO/UserGuide/BugTriage); Kaner, Falk & Nguyen "Testing Computer Software" (Wiley, 1999); Google Testing Blog "Effective Bug Reports"; Microsoft "Triage" (docs.microsoft.com/devops)
tags: [bug-triage, defect-management, severity, priority, bug-report, issue-tracking, quality-assurance]
---

# Triage Bug Report

Reproduce the bug, classify it by severity and priority, capture complete environment context, and assign it — so developers receive actionable reports and no time is lost to "cannot reproduce."

## Why This Is Best Practice

**Adopted by:** Mozilla has maintained a public bug triage process (wiki.mozilla.org) since Bugzilla's creation in 1998 — it is the most documented open-source triage process; Google's internal defect management practices are documented in the Google Testing Blog; Microsoft, Atlassian (Jira), and GitHub Issues all provide triage workflow guidance; Kaner, Falk & Nguyen's "Testing Computer Software" (Wiley, 1999) is the academic foundation for defect report quality standards
**Impact:** Kaner et al. (1999): 40% of bug reports filed without structured triage are closed as "cannot reproduce" due to missing environment information — triage that captures reproduction steps eliminates this back-and-forth; Mozilla's structured triage process reduced median time-to-fix by 30% by ensuring bugs arrive at developers with complete reproduction steps; Google Testing Blog: developers spend 25–40% of bug-fix time reproducing bugs reported without structured context — triage moves this cost to the reporter (cheaper) vs the developer (more expensive)
**Why best:** Untriaged bugs create three failure modes: (1) developers cannot reproduce them and close them unresolved, (2) P0 bugs sit in a backlog behind P3 noise, (3) duplicate reports create parallel fix efforts; structured triage eliminates all three; the alternative — letting reporters self-classify priority — consistently results in every bug being marked "critical" (reporter bias)

Sources: Kaner, Falk & Nguyen "Testing Computer Software" (Wiley, 1999) Ch. 5; Mozilla "BMO Bug Triage" (wiki.mozilla.org); Google Testing Blog "How Google Handles Bug Reports"; Wiegers "Creating a Software Engineering Culture" (Dorset House, 1996)

## Steps

### 1. Attempt to reproduce the bug

Before any classification, reproduce the bug exactly as reported:

```
Checklist:
[ ] Follow the reported steps exactly (not your interpretation of them)
[ ] Use the exact reported environment (OS, version, browser, device)
[ ] Confirm the actual behavior matches what was reported
[ ] Confirm expected behavior is indeed different from actual
```

**If reproducible:** proceed to step 2.

**If not reproducible:**
- Mark status: **"Needs More Info"** (or equivalent in your tracker)
- Request specifically: "Cannot reproduce. Please provide: [what's missing — OS version, exact steps, account type, data state, etc.]"
- Do NOT close the report — "cannot reproduce" ≠ "does not exist"
- Set a follow-up reminder; close only if no response after 14 days

**If intermittently reproducible:**
- Document exact reproduction rate: "Reproduced 2/5 attempts"
- Note any differences between successful and failed reproduction attempts
- Classify as reproducible; note flakiness in the report

### 2. Classify severity

Severity describes the technical impact of the bug — independent of how many users are affected:

| Severity | Definition | Examples |
|----------|-----------|---------|
| **S1 — Critical** | Data loss, data corruption, security vulnerability, complete system unavailability | Payments charged but not recorded; user data exposed to other users; app crashes on launch for all users |
| **S2 — Major** | Core feature broken with no workaround | Login fails; checkout cannot be completed; primary user action returns error |
| **S3 — Moderate** | Feature partially broken or has a workaround | Export fails but copy-paste works; search returns wrong results but filter works |
| **S4 — Minor** | Cosmetic, incorrect text, minor UI issue | Button label says "Cancle"; tooltip text is wrong; animation stutters |

Severity is factual, not subjective. Assign based on impact, not urgency.

### 3. Classify priority

Priority describes when the bug should be fixed — depends on severity, user impact, and business context:

| Priority | Definition | SLA |
|----------|-----------|-----|
| **P0** | Fix immediately — production is broken or users are at risk | Hours |
| **P1** | Fix this sprint — significant user-facing impact | Days |
| **P2** | Fix in the next 1–2 sprints — notable but not blocking | Weeks |
| **P3** | Fix when time allows — low impact or cosmetic | Backlog |

**Severity ≠ Priority:**
- S1 bug on an internal admin tool used by 2 people → severity Critical, priority P1 (not P0)
- S4 bug on the homepage of a major marketing campaign → severity Minor, priority P1

Priority incorporates business context; severity does not. Triage assigns both independently.

### 4. Capture the required context

A complete bug report contains:

```markdown
**Summary:** One sentence describing the incorrect behavior

**Steps to reproduce:**
1. [First step — specific action, not "go to the page"]
2. [Second step]
3. [...]

**Expected behavior:** What should happen

**Actual behavior:** What actually happens

**Environment:**
- OS: macOS 14.2 / Windows 11 / Ubuntu 22.04
- Browser/Client: Chrome 120.0.6099.109 / iOS 17.2 / Node 20.11
- Application version: 2.4.1 (build 20240115)
- Account type / role: Admin / Free tier / Guest
- Data state: Fresh account / After importing data / During checkout

**Frequency:** Always / Intermittent (N/M attempts) / Once

**Attachments:** Screenshot, screen recording, log output, HAR file
```

**Minimum required fields before assignment:**
- Steps to reproduce (specific, numbered)
- Expected vs actual behavior (both stated)
- Environment (at minimum: OS + version + app version)

If any minimum field is missing → request it (step 1 "Needs More Info") before assigning.

### 5. Check for duplicates

Before creating a new report:

```bash
# Search the issue tracker for related reports:
# - Same error message
# - Same feature area
# - Same steps
# - Recent reports (last 30 days) in same component
```

If a duplicate exists:
- Link the new report to the existing one ("Duplicate of #1234")
- Close the new report as duplicate
- Add any new environment information or reproduction steps from the duplicate to the original

Duplicate reports split developer attention and inflate bug counts. Merge them aggressively.

### 6. Assign to the right owner

Assign the bug to the team or individual responsible for the affected component:

```
Who to assign:
- Clear owner: assign directly to that developer or team queue
- Unclear owner: assign to tech lead for the affected area; they re-assign after reviewing
- Cross-team: assign to the team whose code the bug occurs in (even if caused by another team's input)
- Security bugs (S1 with security impact): assign to security team immediately; do NOT leave in public backlog
```

**Security bugs require special handling:**
- Mark as private/confidential in the issue tracker immediately
- Notify security team directly (Slack/email) — do not rely on tracker notification
- Do not describe the vulnerability in public comments

### 7. Set labels and milestone

```
Labels to apply:
- Severity label: severity:critical / severity:major / severity:moderate / severity:minor
- Priority label: priority:p0 / priority:p1 / priority:p2 / priority:p3
- Component: component:auth / component:checkout / component:api
- Type: type:bug (not type:feature, type:task)

Milestone:
- P0: current sprint or hotfix milestone
- P1: current or next sprint milestone
- P2/P3: backlog or unscheduled
```

## Rules

- Never close "cannot reproduce" — mark "Needs More Info" and request specific missing context
- Severity describes technical impact; priority describes fix urgency — assign both independently
- Minimum required fields before assignment: steps to reproduce, expected/actual behavior, environment
- Security bugs (data exposure, auth bypass, injection): private immediately + notify security team directly
- Check for duplicates before creating; merge aggressively
- Reporter self-classification of priority is not final — triager assigns priority based on impact, not reporter urgency

## Common Mistakes

- **Closing "cannot reproduce" without requesting info**: the bug may exist and only reproduce in specific environments or data states; always request missing context before closing
- **Conflating severity and priority**: "critical" priority because the CEO reported it — priority is business-driven; severity is technical-driven; keep them separate
- **Accepting vague steps**: "it doesn't work when I click the button" — which button? On which page? After which action? Accepting vague reports means developers will spend time reproducing that could be spent fixing
- **Leaving security bugs public**: S1 security bugs in a public tracker expose the vulnerability before it's fixed; private immediately, then notify

## When NOT to Use

- Feature requests masquerading as bugs ("the button should be blue, not gray") — reclassify as feature request and route to product; do not apply bug triage process to enhancement requests
- Performance issues without a specific broken behavior — performance complaints that don't identify a regression or a threshold violation belong in performance review, not bug triage

