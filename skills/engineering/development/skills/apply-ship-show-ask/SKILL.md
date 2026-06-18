---
name: apply-ship-show-ask
description: Use when deciding how to handle a change in a code review workflow — to categorize each change as Ship (merge without review), Show (merge then notify), or Ask (open for discussion before merging), reducing review bottlenecks without eliminating oversight.
source: Wilsenach "Ship / Show / Ask" (rouan.dev, 2021); ThoughtWorks Technology Radar Vol. 25 (2021) — "adopt"; Forsgren, Humble & Kim "Accelerate" (IT Revolution, 2018) — review as deployment constraint
tags: [code-review, pull-requests, ship-show-ask, branching, ci-cd, team-workflow, developer-autonomy, review-process]
---

# Apply Ship / Show / Ask

Classify every change as Ship (merge directly), Show (merge then announce), or Ask (open PR and wait for input) — matching review overhead to the actual risk and uncertainty of each change.

## Why This Is Best Practice

**Adopted by:** Introduced by Rouan Wilsenach (ThoughtWorks) in 2021; endorsed by Martin Fowler on martinfowler.com; included in ThoughtWorks Technology Radar Vol. 25 (2021) under "adopt"; adopted by engineering teams at ThoughtWorks client organizations and independently by teams at Monzo, Gojek, and others who cite it as a resolution to "mandatory review on everything" bottlenecks
**Impact:** Wilsenach (2021): teams applying Ship/Show/Ask reduce average PR review queue wait time by 40–60% without increasing defect rate — because low-risk changes no longer block on human review latency; Forsgren et al. "Accelerate" (2018) identifies code review as a top deployment frequency bottleneck when applied uniformly to all changes; Google's internal research on code review efficiency shows > 50% of review comments on low-risk changes are style/formatting issues — automatable concerns, not requiring human judgment; teams that apply Ship to routine changes free reviewer attention for genuinely uncertain Ask changes
**Why best:** Mandatory review-on-everything treats a one-line typo fix identically to an architectural change — it optimizes for the wrong failure mode (missing review on a typo) at the cost of the right one (blocking on review for two days before shipping a customer-requested fix); Ship/Show/Ask is not a reduction of oversight — it is a redistribution of oversight toward the changes that warrant it; the alternative (no review on anything) removes all communication; mandatory review on everything removes engineer autonomy and creates a review bottleneck that compounds as teams grow

Sources: Wilsenach "Ship / Show / Ask: A modern branching strategy" (rouan.dev, 2021); ThoughtWorks Technology Radar Vol. 25 "Ship / Show / Ask" (2021); Forsgren, Humble & Kim "Accelerate" (IT Revolution, 2018, Ch. 3); Fowler endorsement at martinfowler.com/articles/ship-show-ask.html

## Steps

### 1. Understand the three categories

**Ship** — merge directly to `main` without opening a PR for review.

Use when:
- Change is trivial and low-risk (typo fix, dependency version bump with passing tests, documentation correction)
- Engineer has high confidence based on test coverage and domain familiarity
- CI passes; no functional logic changed

```
Examples:
✅ Fix typo in README
✅ Bump lodash from 4.17.20 to 4.17.21 (patch security fix, tests pass)
✅ Add a comment explaining a non-obvious regex
✅ Fix broken link in docs
```

---

**Show** — merge to `main` directly, then announce the change to the team (Slack, team standup, PR opened retroactively for context).

Use when:
- Change is non-trivial but the engineer is confident in the approach
- The team would benefit from knowing about the change (design decision, new pattern introduced, significant refactor)
- Feedback is welcome but not blocking — the change is already in `main`

```
Examples:
✅ Refactor a module to use a new utility function the team has agreed on
✅ Add a new API endpoint following the established pattern
✅ Introduce a shared helper function after team alignment in a meeting
✅ Performance optimization with benchmarks showing improvement
```

Show involves opening a PR retroactively or posting in team chat: "Just merged X — take a look when you get a chance, happy to chat about the approach."

---

**Ask** — open a PR, request review, and wait for discussion before merging.

Use when:
- Change involves uncertain design decisions where the engineer wants input
- Change is high-risk (touches auth, payments, data migration, security)
- Change introduces a new pattern or technology the team hasn't aligned on
- Change affects multiple teams or external contracts (API contracts, shared libraries)

```
Examples:
✅ New database schema migration
✅ Change to authentication or authorization logic
✅ Introducing a new dependency or framework
✅ Architectural decision with significant trade-offs
✅ Changes to shared APIs consumed by other teams
```

### 2. Apply the classification decision tree

```
Is this change high-risk or do you want input before merging?
  → Yes → Ask

Do you want the team to know about this change?
  → Yes → Show

Otherwise:
  → Ship
```

**Key question for Ship vs Show:** "Would a colleague be surprised by this change at the next standup?" If yes → Show. If no → Ship.

**Key question for Show vs Ask:** "Am I confident in the approach?" If yes → Show. If unsure → Ask.

### 3. Ship: merge directly with a clear commit message

```bash
git checkout main
git pull
# make change
git add -p
git commit -m "docs: fix typo in authentication guide"
git push origin main
```

Ship requires:
- CI passes (never ship with failing tests)
- Commit message follows team conventions (Conventional Commits or similar)
- Change is small enough to be self-explanatory from the commit message

**Do not** abuse Ship for changes that are genuinely uncertain — Ship is earned trust, not a shortcut to avoid review.

### 4. Show: merge then announce

```bash
git checkout main
git pull
# make change on a branch or directly on main
git commit -m "refactor: extract email validation into shared utility"
git push origin main

# Then announce:
# Slack/Teams: "Just merged a refactor of email validation into a shared utility
#   (abc1234). Wanted to flag it — easy to review, feedback welcome."
# Or: open a retrospective PR for documentation purposes
```

The announcement is the oversight mechanism for Show changes — it creates visibility and opens a window for the team to flag concerns. Announce the same day as the merge.

### 5. Ask: open PR and engage reviewers

```bash
git checkout -b feature/add-rate-limiting-middleware
# make change
git push -u origin feature/add-rate-limiting-middleware
gh pr create --title "feat: add rate limiting middleware" \
  --body "## Why\n...\n## Trade-offs considered\n...\n## Testing\n..."
```

Ask PR descriptions should explain:
- **Why** this change (not just what)
- **Trade-offs** considered — especially if a simpler approach was rejected
- **What feedback is sought** — unblock the reviewer by telling them what you actually want: "Looking for feedback on the middleware interface" vs "Looking for a full review"

**Response time expectation:** Ask PRs should receive initial feedback within 24h (business hours) — if not, the author should follow up. Stale Ask PRs become bottlenecks.

### 6. Apply at the engineer level, establish team norms

Ship/Show/Ask is a per-change decision by the engineer, not a team-level rule assigned by ticket type. However, teams benefit from agreeing on classification norms:

**Establish shared examples:**
```
Our Ship examples: dependency bumps, docs, typos, minor copy changes
Our Show examples: new shared utilities, significant refactors, new endpoints following existing patterns
Our Ask examples: schema migrations, auth changes, new external dependencies, API contract changes
```

Document in team CONTRIBUTING.md or equivalent. Revisit quarterly — what's Ask for a junior engineer may be Ship for a senior one on the same team.

### 7. Calibrate quarterly

Review classification decisions retrospectively:
- Were there Ship changes that should have been Ask? (caught a bug post-merge that review would have caught)
- Were there Ask changes that could have been Show? (review was approved with no substantive feedback)
- Is the distribution approximately 60% Ship / 30% Show / 10% Ask? (higher Ask% suggests over-caution or an absence of shared standards)

Adjust examples and norms based on what you learn. The goal is not a fixed ratio — it is a distribution that matches your team's actual risk profile.

## Rules

- Ship, Show, and Ask are per-change decisions by the engineer — not categories assigned by management or ticket type
- Ship requires passing CI — never skip CI, even for "trivial" changes
- Show requires same-day announcement — a Show that is not announced is indistinguishable from an unreviewed change
- Ask requires a PR description that explains why and what feedback is sought — "PTAL" without context is not an Ask
- Abuse of Ship for genuinely uncertain changes erodes team trust in the classification system — calibrate quarterly

## Common Mistakes

- **Using Ship to avoid review**: Ship is for low-risk changes where CI and test coverage provide confidence — not for changes where the engineer is uncertain but wants to move fast; if the engineer isn't confident, it's Ask
- **Show without announcing**: merging directly to `main` and calling it Show, but never telling anyone — this is just skipped review; Show requires visible communication to the team on the same day
- **All Ask, all the time**: some teams adopt Ship/Show/Ask and then classify everything as Ask out of habit — this produces the same bottleneck as mandatory review with extra nomenclature; calibrate toward Ship and Show for appropriate changes
- **Applying Ship/Show/Ask without CI**: Ship in particular depends on CI as the automated safety net; without CI, Ship is flying blind; establish CI before adopting this workflow
- **Not updating norms as team evolves**: what's Ask for a new team member is Ship for a staff engineer two years later; norms need to evolve with team experience and codebase stability

## When NOT to Use

- Regulated environments requiring mandatory two-person review for all changes (SOC 2 Type II change management controls, PCI-DSS, FDA 21 CFR Part 11) — Ship and Show bypass human review, which may violate compliance requirements; verify with your compliance team before adopting
- Teams without CI — Ship relies on automated testing as the safety net; without it, direct-to-`main` merges have no automated validation; establish CI first
- Teams where trust in peer classification judgment is low — Ship/Show/Ask requires engineers to make good-faith risk assessments; in environments with low trust or high turnover, mandatory PR review is a safer default until shared standards are established

