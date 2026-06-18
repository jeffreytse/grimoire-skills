---
name: bisect-regression
description: Use when a test or behavior that previously worked is now broken and the commit that introduced the regression is unknown — to use `git bisect` to binary-search the commit history and identify the exact commit that caused it.
source: Git documentation "git-bisect" (git-scm.com/docs/git-bisect); Chacon & Straub "Pro Git" Ch. 7 "Debugging with Git" (git-scm.com/book); Google Engineering Practices internal tooling documentation
tags: [git-bisect, regression, debugging, git, binary-search, commit-history, root-cause]
---

# Bisect Regression

Use `git bisect` to binary-search commit history and identify the exact commit that introduced a regression — reducing a search across thousands of commits to O(log n) steps.

## Why This Is Best Practice

**Adopted by:** `git bisect` is a built-in Git command used by the Linux kernel team (Torvalds designed it for this purpose), Google, Mozilla, and any team using Git for version control; Chacon & Straub's "Pro Git" (the canonical Git reference at git-scm.com) dedicates a section to `git bisect` as the primary tool for locating regressions; the `git bisect run` subcommand enables full automation, making it suitable for CI regression detection
**Impact:** Binary search finds the culprit commit in ⌈log₂(n)⌉ steps — 10 commits to check in a 1,000-commit history, 17 in a 100,000-commit history; without bisect, engineers manually read commit history, which takes O(n) time; `git bisect run` with an automated test script reduces a multi-hour manual investigation to under 5 minutes for most repositories; the Linux kernel team uses automated bisect to find regressions across tens of thousands of commits
**Why best:** Reading commit messages and diffs to find a regression is O(n) and error-prone — commits are often grouped by feature, not by the system component that regressed; `git bisect` bypasses reading and directly identifies the offending commit by testing behavior; the alternative (blaming based on recent changes) misses regressions introduced by seemingly unrelated commits

Sources: Chacon & Straub "Pro Git" 2nd ed. Ch. 7 "Debugging with Git" (git-scm.com/book/en/v2); Git documentation "git-bisect" (git-scm.com/docs/git-bisect); Torvalds on bisect design (lkml.org)

## Steps

### 1. Identify a known-bad and known-good commit

Before starting bisect, establish two reference points:

```bash
# Current HEAD is broken → this is "bad"
# Find a known-good commit: last release tag, a recent passing CI build, or "it worked last week"

git log --oneline -20          # scan recent commits
git tag --sort=-creatordate    # list tags newest-first; recent release tags are good candidates
```

You need:
- **Bad commit:** the current broken state (usually `HEAD`)
- **Good commit:** any commit where the behavior worked (a tag, a SHA, a branch)

The range between good and bad is what bisect will search. Wider range = more steps, but bisect is still fast: 100 commits = 7 steps; 10,000 commits = 14 steps.

### 2. Start bisect

```bash
git bisect start
git bisect bad                          # mark HEAD (current) as bad
git bisect good v2.3.1                  # mark a known-good tag or SHA
```

Git immediately checks out the midpoint commit between good and bad:

```
Bisecting: 47 revisions left to test after this (roughly 6 steps)
[abc1234] Some commit message
```

### 3. Test the checked-out commit

At each midpoint, test whether the behavior is broken:

```bash
# Run your test, build, or manual check
npm test -- --grep "the failing behavior"
# OR
./run-specific-test.sh
# OR manually test the feature
```

Then tell bisect the result:

```bash
git bisect good    # this commit does NOT have the bug
git bisect bad     # this commit DOES have the bug
```

Git checks out the next midpoint. Repeat until bisect outputs:

```
abc1234 is the first bad commit
commit abc1234
Author: Someone <someone@example.com>
Date:   Mon Jan 1 12:00:00 2024

    feat: add new cache invalidation logic
```

### 4. Automate with `git bisect run` (preferred)

If you have an automated test that reliably reproduces the bug, automate the entire process:

```bash
git bisect start
git bisect bad HEAD
git bisect good v2.3.1
git bisect run npm test -- --grep "the failing behavior"
```

`git bisect run` rules:
- Exit code `0` = good (test passes = no bug)
- Exit code `1`–`127` (except `125`) = bad (test fails = bug present)
- Exit code `125` = skip this commit (cannot test — e.g., won't compile)

```bash
# Example: run a single test file
git bisect run python -m pytest tests/test_cache.py::test_invalidation -x

# Example: shell script that builds and tests
git bisect run ./scripts/bisect-test.sh
```

For repositories that sometimes fail to compile at intermediate commits, use `125` skip:

```bash
#!/bin/bash
# bisect-test.sh
make || exit 125          # skip if build fails
./run-test.sh             # 0 = good, non-zero = bad
```

### 5. Inspect the bad commit

Once bisect identifies the first bad commit:

```bash
git show abc1234           # full diff of the offending commit
git log --stat abc1234     # files changed
```

Read the diff with the bug in mind. The regression is in this commit. Common patterns:

- An off-by-one introduced in a refactor
- A condition that was inadvertently inverted
- A caching layer added that broke a side effect the caller depended on
- A dependency version bump that changed behavior

### 6. End the bisect session

```bash
git bisect reset           # returns HEAD to the original branch/commit
```

Always run `git bisect reset` when done — it restores the working tree to its pre-bisect state. Forgetting leaves you on a detached HEAD at the last-tested commit.

### 7. Apply findings

With the offending commit identified:

1. Read the commit message and PR/issue it references
2. Understand the intended change and why it caused the regression
3. Write a regression test that reproduces the bug (`write-regression-test`)
4. Fix the bug — either revert the offending commit or make a targeted correction
5. Reference the bisect-identified commit SHA in the fix commit message: "Fix regression introduced in abc1234"

## Rules

- Always run `git bisect reset` at the end — never leave the repo in detached HEAD state
- The test used in `git bisect run` must be deterministic — flaky tests produce wrong good/bad assignments and lead bisect to wrong commits
- Exit code `125` to skip commits that can't be tested — never force a bad/good verdict on an untestable commit
- The good commit must predate the bad commit — bisect searches forward in time, not backward

## Common Mistakes

- **Forgetting `git bisect reset`**: leaves repository in detached HEAD state; `git status` will show "HEAD detached at abc1234"; fix by running `git bisect reset` or `git checkout main`
- **Using a flaky test**: if the test sometimes passes and sometimes fails independently of the commit, bisect will misclassify commits and converge on the wrong commit; fix or isolate the flakiness before bisecting
- **Good commit too recent**: choosing a good commit that's only 5 commits before bad when the actual regression was introduced 200 commits ago; if bisect finds a "first bad commit" that looks correct and unrelated to the bug, widen the good commit range
- **Not using `git bisect run`**: manually testing 15 commits one by one when an automated test exists; `git bisect run` reduces a 30-minute process to 2 minutes

## When NOT to Use

- When the regression was introduced in the last 1–3 commits — reading the diff directly is faster than the bisect setup overhead; bisect pays off at 5+ commits to search
- When no automated test or reliable manual check exists to determine good/bad — bisect requires a deterministic test; without one, you cannot assign good/bad reliably; write a reproducing test first (`write-regression-test`), then bisect

