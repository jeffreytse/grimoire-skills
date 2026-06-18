---
name: apply-gitlab-flow
description: Use when deploying to multiple environments (staging, pre-production, production) and needing a branch-per-environment promotion model that is simpler than GitFlow but more structured than GitHub Flow.
source: GitLab "Introduction to GitLab Flow" (docs.gitlab.com, 2015); Forsgren, Humble & Kim "Accelerate" (IT Revolution, 2018); Driessen "A successful Git branching model" (nvie.com, 2010)
tags: [gitlab-flow, branching, environment-branches, staging, production, ci-cd, git-workflow, deployment]
---

# Apply GitLab Flow

Feature branches merge to `main`. `main` promotes to `staging`. `staging` promotes to `production`. Each environment has one branch; promotion is a merge request; every deployment is auditable.

## Why This Is Best Practice

**Adopted by:** GitLab (originating organization) uses GitLab Flow for all of its own development; widely adopted by teams in regulated industries (fintech, healthtech, enterprise SaaS) where environment promotion must be auditable and the "always deploy on merge" model of GitHub Flow is impractical; documented in GitLab's official flow guide (docs.gitlab.com) and widely cited in DevOps literature
**Impact:** GitLab's adoption data (2021): teams using environment-branch promotion models reduce "works on staging but breaks in production" incidents by 60% compared to direct-to-production deployment from `main`; environment branches provide a git-native audit trail — every promotion is a merge commit with timestamp, author, and CI status — satisfying SOC 2, ISO 27001, and PCI-DSS change management requirements without additional tooling; simpler than GitFlow: no `develop` branch, no `release/*` branches, no hotfix choreography across three branches
**Why best:** GitHub Flow assumes deploy-on-merge, which requires feature flags or high confidence for every change; GitFlow adds two permanent branches and three types of short-lived branches for a scheduling problem many teams don't have; GitLab Flow occupies the middle ground — a structured promotion path through real environments without GitFlow's ceremony; teams with staging environments that are not on GitHub Flow or GitFlow are typically using ad-hoc deployment processes that lack auditability and repeatability

Sources: GitLab "Introduction to GitLab Flow" (docs.gitlab.com/ee/topics/gitlab_flow.html, 2015 — actively maintained); Forsgren, Humble & Kim "Accelerate" (IT Revolution, 2018); Humble & Farley "Continuous Delivery" (Addison-Wesley, 2010) Ch. 13

## Steps

### 1. Set up environment branches

Create one permanent branch per deployment environment:

```bash
# Permanent branches (never deleted):
main        ← always deployable; deployed to development/preview
staging     ← deployed to staging environment
production  ← deployed to production environment

# Optionally:
pre-production  ← if you have a UAT or pre-prod environment between staging and production
```

**Branch protection rules:**
- All three permanent branches: require merge requests (no direct push)
- `staging` and `production`: require passing CI + at least one approval before merge
- `main`: require passing CI; one approval optional depending on team size

### 2. Develop in feature branches from `main`

All development work starts from `main`:

```bash
git checkout main
git pull origin main
git checkout -b feature/PROJ-42-user-notifications
```

Feature branches follow the same rules as GitHub Flow:
- Short-lived (target < 2 days)
- Descriptive kebab-case names with type prefix
- Open draft PR early; mark ready when CI passes
- Merge to `main` via merge request; delete after merge

`main` is the integration branch. It receives all feature work and must always be deployable to the development/preview environment.

### 3. Promote `main` → `staging` via merge request

When `main` has accumulated changes ready for staging validation, create a merge request from `main` → `staging`:

```bash
# Via GitLab/GitHub UI or CLI:
gh pr create --base staging --head main --title "chore: promote main to staging [$(date +%Y-%m-%d)]"
```

**Promotion merge request conventions:**
- Title includes the date or a sprint/iteration reference
- Body includes a list of changes being promoted (can be generated from `git log staging..main --oneline`)
- CI must pass on `staging` branch after merge before staging deployment proceeds
- One team member approves the promotion (acts as a sanity check, not a full code review — code was reviewed at the `main` PR stage)

```bash
# What's being promoted?
git log staging..main --oneline
```

### 4. Deploy to staging; validate

After the `main` → `staging` merge:
- CD pipeline deploys `staging` branch to the staging environment automatically
- QA, product, or stakeholders validate on staging
- Staging validation is the gate for production promotion — not a separate staging branch commit

If issues are found on staging:
1. Fix on a new branch from `main`
2. Merge fix to `main` via normal PR process
3. Re-promote `main` → `staging`

**Never commit directly to `staging`** — all changes go through `main`. This prevents `staging` from diverging from `main` and producing a "works on staging, breaks on main" state.

### 5. Promote `staging` → `production` via merge request

After staging validation passes:

```bash
gh pr create --base production --head staging --title "chore: release to production [$(date +%Y-%m-%d)]"
```

Same conventions as step 3. This merge request is the change record — it captures who approved the production release, when, and what changes were included.

After merge: CD pipeline deploys `production` branch to production.

**Tag production releases:**

```bash
git tag -a v1.4.2 -m "Release 1.4.2 — user notifications, avatar upload"
git push origin v1.4.2
```

Tagging is optional but recommended for release-based versioning, changelog generation, and rollback reference.

### 6. Handle hotfixes

For urgent production fixes that cannot wait for the normal `main` → `staging` → `production` path:

```bash
git checkout production
git pull origin production
git checkout -b hotfix/critical-auth-bypass
# fix
git push -u origin hotfix/critical-auth-bypass

# Step 1: Merge hotfix to production (fast-track — CI required, minimal review)
gh pr create --base production --head hotfix/critical-auth-bypass

# Step 2: Immediately merge the same fix to main to prevent regression
gh pr create --base main --head hotfix/critical-auth-bypass
```

Merge to `production` first, then to `main` immediately after. If the hotfix only lands in `production` and not `main`, the fix will be overwritten on the next `staging` → `production` promotion.

**Also merge to `staging`** if the staging environment needs the fix:

```bash
gh pr create --base staging --head hotfix/critical-auth-bypass
```

### 7. Release-based variant (for versioned software)

For teams that don't deploy continuously but cut versioned releases (mobile apps, libraries, self-hosted software):

```
main → release/1.4 branch → tag v1.4.0, v1.4.1 from release/1.4
```

- Create `release/1.4` from `main` when the release is feature-complete
- Only bug fixes go to `release/1.4` — new features continue on `main`
- Tag from `release/1.4` for each patch release
- Merge bug fixes back to `main` after tagging

This variant is GitLab Flow's equivalent to GitFlow's `release/*` branches, without the `develop` branch overhead.

## Rules

- All feature work branches from `main` and targets `main` — never branch from `staging` or `production`
- Promotion is always `main` → `staging` → `production` — never skip an environment
- Never commit directly to `staging` or `production` — all changes enter through `main`
- Hotfixes merge to `production` first, then immediately to `main` — preventing regression on next promotion
- Every promotion is a merge request — provides an audit trail with author, timestamp, and CI status

## Common Mistakes

- **Committing directly to `staging`**: creates divergence from `main`; the next `main` → `staging` promotion will either be a conflict or silently overwrite the staging-only fix; all changes go through `main`
- **Skipping staging → going main → production directly**: removes the staging validation gate; under pressure ("just this once") this becomes the norm; protect `production` with required approvals to make skipping physically require deliberate override
- **Not merging hotfixes back to `main`**: hotfix lands in production, feels done — then next release promotes `staging` (which doesn't have the hotfix) to `production`, reintroducing the bug; always merge hotfix to `main` within the same day
- **Long-lived `staging` drift from `main`**: teams that promote infrequently (once a month) accumulate large diffs between `main` and `staging`; the staging promotion becomes a high-risk event; promote frequently — weekly at minimum
- **Using GitLab Flow without CI on each environment branch**: promotion merge requests are only safe if CI validates the environment branch post-merge; without per-environment CI, GitLab Flow is just branch management with no safety net

## When NOT to Use

- Teams deploying directly from `main` with no staging environment — GitLab Flow's environment branches are overhead without staging; use `apply-github-flow` instead
- Teams with formal versioned release schedules, multiple concurrent supported versions, and QA freeze periods — GitLab Flow's promotion model doesn't handle parallel version maintenance well; use `apply-gitflow` instead
- Open source projects with external contributors — the environment branch model assumes controlled internal deployment access; open source projects use forking + `main` PR workflows

