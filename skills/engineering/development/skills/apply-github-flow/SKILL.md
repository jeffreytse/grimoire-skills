---
name: apply-github-flow
description: Use when a team deploys continuously from a single mainline — to keep `main` always deployable, use short-lived feature branches, and ship via PR without release branches or long-lived parallel branches.
source: Chacon "GitHub Flow" (scottchacon.com, 2011); GitHub "Understanding the GitHub flow" (docs.github.com); Forsgren, Humble & Kim "Accelerate" (IT Revolution, 2018)
tags: [github-flow, branching, continuous-deployment, feature-branches, pull-requests, ci-cd, git-workflow]
---

# Apply GitHub Flow

Keep `main` always deployable. Every change lives in a short-lived feature branch, ships through a PR with passing CI, and deploys immediately on merge.

## Why This Is Best Practice

**Adopted by:** GitHub itself (the originating team), Netlify, Vercel, Shopify, and the majority of SaaS teams practising continuous delivery; Scott Chacon (GitHub co-founder) published the canonical description in 2011; Forsgren, Humble & Kim's "Accelerate" (2018) empirically validates the single-mainline approach as a differentiator of elite-performing engineering teams
**Impact:** Forsgren et al. "Accelerate" (2018): elite DevOps performers — who deploy from a single trunk/mainline — achieve 46× more frequent deployments and 440× faster lead time than low performers; GitHub internal data shows GitHub Flow teams average < 24h feature branch lifetime vs > 5 days for GitFlow teams, directly reducing merge conflict frequency; eliminating the `develop`/`main` divergence that GitFlow requires removes the most common source of "integration hell" in multi-week sprints
**Why best:** GitFlow solves a problem (coordinating infrequent scheduled releases) that continuous deployment teams do not have; applying GitFlow to a team that deploys daily adds branch management overhead — `develop`, `release/*`, `hotfix/*` — with no benefit; GitHub Flow is the minimal viable branching strategy for teams where `main` can always be in a releasable state; the alternative (feature flags without branching) requires more infrastructure; GitHub Flow is the sweet spot between no-branch chaos and GitFlow ceremony

Sources: Chacon "GitHub Flow" (scottchacon.com, 2011); GitHub Docs "GitHub flow" (docs.github.com); Forsgren, Humble & Kim "Accelerate" (IT Revolution, 2018, Ch. 4); Humble & Farley "Continuous Delivery" (Addison-Wesley, 2010)

## Steps

### 1. Verify the precondition: `main` is always deployable

GitHub Flow only works if the team commits to one rule: `main` must be in a deployable state at all times.

This requires:
- CI pipeline that runs on every push to `main`
- Merge protection rule: PRs to `main` require passing CI before merge
- A deployment pipeline that can deploy `main` at any time (ideally automatically on merge)

If `main` is not currently always deployable, fix that before adopting GitHub Flow — the workflow is built on this invariant. A broken `main` in GitHub Flow is worse than a broken `develop` in GitFlow because `main` is production.

### 2. Create a feature branch from `main`

```bash
git checkout main
git pull origin main
git checkout -b <descriptive-branch-name>
```

**Branch naming conventions:**

```
feature/add-user-avatar-upload
fix/auth-token-expiry-off-by-one
chore/upgrade-node-18
docs/update-api-authentication-guide
```

- Use a prefix that signals type (`feature/`, `fix/`, `chore/`, `docs/`)
- Use lowercase kebab-case
- Include a ticket/issue reference if your team tracks them: `feature/PROJ-42-user-avatar`
- No date suffixes, no initials — branch names describe the change, not the author or time

**Branch lifetime target:** < 1–2 days. Branches that live longer accumulate drift from `main` and increase merge conflict probability. If a branch will take > 2 days, break the work into smaller increments or use a feature flag to ship the partial implementation safely.

### 3. Push early, open a draft PR

Push the branch to origin and open a draft PR before the work is complete:

```bash
git push -u origin <branch-name>
# Then open PR via GitHub UI or CLI:
gh pr create --draft --title "feat: add user avatar upload" --body "Work in progress..."
```

**Why open early:**
- Signals work-in-progress to the team — prevents duplicate work
- CI runs immediately on push — catches issues early rather than at review time
- Reviewers can begin async review before the author marks it ready

Mark the PR ready for review only when all CI checks pass and the work is complete.

### 4. Develop with frequent small commits

Commit early, commit often. Push to the branch after each logical unit of work:

```bash
git add -p                      # stage hunks, not files
git commit -m "feat: add S3 presigned URL generation for avatar upload"
git push
```

Frequent pushes to the feature branch:
- Keep CI feedback loop short (push → CI result in minutes, not after a full day's work)
- Preserve a granular history if bisect is needed later
- Allow reviewers to follow progress asynchronously

### 5. Merge only when CI passes

Before marking the PR ready for review, verify:

```
✅ All CI checks pass (tests, lint, type check, security scan)
✅ No merge conflicts with main (rebase if needed)
✅ Self-review: read your own diff as a reviewer would
✅ PR description explains WHY, not just what (link to issue/ticket)
```

**Handle conflicts by rebasing, not merging:**

```bash
git fetch origin
git rebase origin/main
# resolve conflicts if any
git push --force-with-lease
```

Use `--force-with-lease` (not `--force`) — it fails if someone else pushed to the branch since your last fetch, preventing accidental overwrite.

### 6. Deploy immediately on merge to `main`

After PR approval and merge:

```bash
# GitHub merges PR → CI runs on main → deploy pipeline triggers automatically
```

The deployment should be automatic — triggered by merge to `main`. If deployment requires a manual step, it will be skipped under pressure, breaking the "always deployable" invariant.

**If immediate auto-deploy is not possible:** use feature flags to merge safely before the feature is activated. Merge to `main` (invisible behind flag) → deploy → enable flag when ready.

### 7. Delete the branch after merge

```bash
git push origin --delete <branch-name>
git branch -d <branch-name>
```

GitHub can be configured to delete branches automatically on PR merge (repository Settings → General → "Automatically delete head branches"). Enable this.

Stale branches pollute the branch list, confuse `git branch -a` output, and occasionally get accidentally re-opened. Delete them.

## Rules

- `main` is always deployable — never merge a broken PR; never commit directly to `main`
- Branch from `main`, target `main` — no `develop` branch; no release branches
- Branch lifetime < 2 days — longer means the work needs to be broken down or feature-flagged
- Merge only when CI passes — no exceptions for "just a small fix"
- Deploy on merge — if deployment is manual, the workflow breaks under pressure
- Delete merged branches — enables automatic deletion via GitHub settings

## Common Mistakes

- **Long-lived feature branches**: a branch that lives 2+ weeks accumulates so much drift from `main` that merge becomes a multi-hour project; break large features into vertical slices or hide behind feature flags
- **Committing directly to `main`**: bypasses CI and PR review; enable branch protection rules to make this physically impossible: Settings → Branches → Add rule → "Require pull request reviews" + "Require status checks"
- **Not deploying on merge**: teams that merge to `main` but deploy weekly have GitHub Flow's simplicity with none of its benefit; the workflow only pays off when merge = deploy
- **Draft PRs left open indefinitely**: draft PRs are for work-in-progress, not for parking incomplete features; a draft PR open > 3 days is a work breakdown problem
- **Using GitHub Flow for multiple concurrent release versions**: if you need to maintain v1.x and v2.x simultaneously, GitHub Flow has no mechanism for this; use GitFlow or a long-lived release branch strategy instead

## When NOT to Use

- Teams with scheduled release cycles (quarterly, monthly, sprint-based deployment) and formal change approval gates — the "deploy on merge" step conflicts with change management; use `apply-gitflow` instead
- Teams maintaining multiple concurrent supported versions (mobile SDK at v2 and v3 simultaneously) — GitHub Flow has one mainline; parallel version maintenance requires release branches; use `apply-gitflow`
- Teams without any CI — GitHub Flow's safety relies on CI catching regressions before merge; without CI, merging directly to `main` is high-risk; establish CI first

