---
name: apply-forking-workflow
description: Use when contributing to a repository you cannot push to directly — to fork the repo, develop on your fork, keep it in sync with upstream, and submit changes via pull request without requiring write access to the canonical repository.
source: Chacon & Straub "Pro Git" Ch. 5 "Distributed Git" (git-scm.com, 2nd ed.); GitHub "Working with forks" (docs.github.com); Linux kernel "Submitting patches" (kernel.org/doc/html/latest/process/submitting-patches.html)
tags: [forking, open-source, contribution, upstream, pull-request, distributed-git, external-contributors, git-workflow]
---

# Apply Forking Workflow

Fork the canonical repository, add it as `upstream`, develop on a branch in your fork, keep your fork in sync, and submit changes via PR — so external contributors can participate without write access to the source repository.

## Why This Is Best Practice

**Adopted by:** Every major open source project on GitHub uses the forking workflow as its primary contribution model — Linux kernel (via mailing list patches, the conceptual origin), CPython, React, Vue, Kubernetes, Node.js, and virtually all public GitHub repositories; GitHub built its entire collaboration model around forks; Chacon & Straub's "Pro Git" (the definitive Git reference, available at git-scm.com) dedicates Chapter 5 to distributed workflows with forking as the primary external-contributor model
**Impact:** The Linux kernel (maintained via fork-based patch submission since 2005) receives contributions from 4,000+ developers across 500+ organizations annually — the largest collaborative software project in history, enabled entirely by fork-based contribution; GitHub's 2023 Octoverse report: 94 million developers on GitHub, the majority contributing to projects they don't own via forks; forking enables contribution without coordination overhead — contributors work independently on their fork with zero impact on the upstream repository until a PR is opened
**Why best:** Shared-branch models (where all contributors push to the same repository) require write-access grants for every contributor — impractical for public projects and creates security exposure in enterprise for contractors and external teams; forking isolates contributor work completely — a broken fork has zero impact on upstream; the alternative (patch files via email, the pre-GitHub model) is the Linux kernel's original method, which forking on GitHub simplified while preserving the same isolation model

Sources: Chacon & Straub "Pro Git" 2nd edition, Ch. 5 "Distributed Git" (git-scm.com/book); GitHub "Forking a repository" (docs.github.com); Linux kernel "Submitting patches" (kernel.org); Torvalds "Git in 5 minutes" origin documentation

## Steps

### 1. Fork the repository

On GitHub/GitLab/Bitbucket: click "Fork" on the upstream repository page.

This creates a full copy of the repository under your own account or organization:
```
upstream:  github.com/org/project          (you have read access; no push)
your fork: github.com/your-username/project (you have full write access)
```

The fork is an independent Git repository. Changes to your fork do not affect upstream until you open a PR.

### 2. Clone your fork locally

```bash
git clone git@github.com:your-username/project.git
cd project
```

Clone your fork, not upstream. Your fork's remote is `origin` by default.

### 3. Add the upstream remote

```bash
git remote add upstream git@github.com:org/project.git
```

Verify both remotes are configured:

```bash
git remote -v
# origin    git@github.com:your-username/project.git (fetch)
# origin    git@github.com:your-username/project.git (push)
# upstream  git@github.com:org/project.git (fetch)
# upstream  git@github.com:org/project.git (push)
```

`upstream` = canonical repository (read-only in practice — you cannot push)
`origin` = your fork (full write access)

**Never push directly to `upstream`.** You do not have write access; the push will fail. All pushes go to `origin`.

### 4. Keep your fork in sync with upstream

Before starting any new work, sync your fork's `main` with upstream `main`:

```bash
git checkout main
git fetch upstream
git merge upstream/main        # fast-forward if no local changes on main
git push origin main           # keep your fork's remote main in sync
```

Or with rebase (cleaner history):

```bash
git fetch upstream
git rebase upstream/main
git push origin main --force-with-lease
```

**Frequency:** Sync before starting every new branch. For active projects, sync daily. A fork that drifts far behind upstream accumulates merge conflicts that are expensive to resolve.

### 5. Create a feature branch on your fork

Never work directly on `main` — always use a branch:

```bash
git checkout main
git checkout -b fix/typo-in-readme
```

Branch naming follows the same conventions as any branching strategy:
```
feature/add-dark-mode
fix/null-pointer-in-parser
docs/update-contributing-guide
chore/upgrade-eslint-9
```

Develop on this branch. Commit as you normally would:

```bash
git add -p
git commit -m "fix: correct typo in README installation section"
git push origin fix/typo-in-readme
```

### 6. Open a pull request from your fork to upstream

On GitHub: navigate to the upstream repository → "Pull requests" → "New pull request" → "compare across forks".

```
base repository: org/project          base: main
head repository: your-username/project  compare: fix/typo-in-readme
```

**PR description for external contributions:**
- Explain **what** the change does and **why**
- Reference the issue it addresses: "Closes #42"
- If the project has a CONTRIBUTING.md, follow its PR template
- Sign a CLA if the project requires one (common for Apache, Google, Meta projects)

**Check contribution guidelines first:** Most major projects have a `CONTRIBUTING.md` or `CONTRIBUTING.rst` that specifies:
- Required commit message format
- Whether to squash commits before submitting
- CLA requirements
- Code style and test requirements

Failing to follow contribution guidelines is the primary reason external PRs are rejected without review.

### 7. Respond to review feedback

Upstream maintainers review your PR. To update it based on feedback:

```bash
git checkout fix/typo-in-readme
# make changes
git add -p
git commit -m "fix: address review feedback — use American English spelling"
git push origin fix/typo-in-readme
```

Pushing additional commits to the same branch automatically updates the PR.

**Squashing:** Some projects request squashed commits before merge. If asked:

```bash
git rebase -i upstream/main
# mark all but the first commit as 'squash' or 's'
git push origin fix/typo-in-readme --force-with-lease
```

Use `--force-with-lease` when force-pushing — it fails if someone else pushed to your branch since your last fetch.

### 8. Clean up after merge

After the upstream maintainer merges your PR:

```bash
# Sync your fork's main
git checkout main
git fetch upstream
git merge upstream/main
git push origin main

# Delete the merged branch locally and remotely
git branch -d fix/typo-in-readme
git push origin --delete fix/typo-in-readme
```

GitHub offers automatic branch deletion after PR merge — enable this in your fork's settings if you frequently contribute.

## Rules

- Always add `upstream` remote immediately after cloning — never lose the connection to the canonical source
- Never push to `upstream` — your fork is `origin`; push only there
- Sync `main` from `upstream` before starting every new branch — stale forks accumulate conflicts
- Develop on branches, never directly on `main` — `main` must stay clean to sync with upstream
- Read `CONTRIBUTING.md` before opening a PR — projects reject non-compliant PRs without review
- `--force-with-lease` when force-pushing, never `--force` — prevents overwriting others' work

## Common Mistakes

- **Forgetting to add `upstream` remote**: contributors clone their fork and never add `upstream` — they have no way to sync with the canonical source; add it as step one, immediately after clone
- **Working on fork's `main` directly**: making changes to `main` in your fork makes it impossible to sync cleanly with `upstream/main`; always use branches, reserve `main` as a sync target only
- **Not syncing before branching**: branching from a stale `main` that's 100 commits behind upstream — the PR will have massive conflicts; always `git fetch upstream && git merge upstream/main` before creating a new branch
- **Opening PR without reading CONTRIBUTING.md**: the most common reason first-time contributors have PRs closed immediately; contribution guidelines exist because maintainers have spent years documenting how to contribute correctly
- **Force-pushing `main` in your fork**: `main` should always fast-forward from upstream; if you need to force-push `main`, you've made commits to it and need to reset it: `git checkout main && git reset --hard upstream/main && git push origin main --force-with-lease`

## When NOT to Use

- When you have direct write access to the repository — if you're on the core team, use the shared-branch workflow (GitHub Flow, GitLab Flow, or GitFlow); forking when you have push access adds unnecessary indirection
- Internal team repositories where all contributors are trusted employees with push access — forking is the open-source model for untrusted-contributor isolation; internal teams don't need that isolation and can work in the shared repository directly

