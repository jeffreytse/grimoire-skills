---
name: apply-changesets
description: Use when a monorepo contains multiple independently versioned packages and each package needs its own changelog updated only when that package has actual changes.
source: Changesets documentation (changesets.dev); Atlassian Design System engineering blog; pnpm workspace documentation; Turbo monorepo handbook
tags: [changelog, monorepo, changesets, versioning, multi-package, workspace, release-management]
---

# Apply Changesets

Use Changesets to track what changed in which packages, generate per-package changelogs, and coordinate multi-package version bumps without manual bookkeeping.

## Why This Is Best Practice

**Adopted by:** pnpm itself, Atlassian (Atlaskit design system), Vercel, Radix UI, Tailwind CSS, Turbo, Astro, and hundreds of major OSS monorepos use Changesets as their release workflow; Changesets has 10k+ GitHub stars and 3M+ weekly npm downloads
**Impact:** Changesets solves the two core monorepo release problems that manual workflows cannot: (1) tracking which packages need a version bump — without Changesets, a developer must manually audit all changes across packages before each release; (2) automatically bumping dependent packages when their dependencies release — in a monorepo with 20 packages, a single API change can require cascading version bumps that are error-prone to track manually
**Why best:** Lerna was the original monorepo release tool but is no longer actively maintained for this use case and requires complex configuration; Nx Release is excellent within the Nx ecosystem but Nx-specific; Changesets is tool-agnostic (works with npm/pnpm/yarn workspaces), requires minimal configuration, and introduces an explicit human-authored changeset-per-PR workflow that produces higher-quality changelog entries than tools that auto-generate from commit messages (developers write for package consumers, not just for git history)

Sources: Changesets documentation (changesets.dev/introduction); Atlassian "Releasing multiple packages at once" engineering blog (2022); pnpm workspace release documentation; Turbo Monorepo Handbook — Versioning and Publishing chapter

## Steps

### 1. Install and initialize Changesets

```bash
# npm workspaces
npm install --save-dev -w <root> @changesets/cli

# pnpm workspaces (install at workspace root)
pnpm add -D @changesets/cli

# yarn workspaces
yarn add -D @changesets/cli
```

Initialize (creates `.changeset/` directory with config):

```bash
pnpm changeset init
```

This creates `.changeset/config.json`:

```json
{
  "$schema": "https://unpkg.com/@changesets/config@3.0.0/schema.json",
  "changelog": "@changesets/cli/changelog",
  "commit": false,
  "fixed": [],
  "linked": [],
  "access": "restricted",
  "baseBranch": "main",
  "updateInternalDependencies": "patch",
  "ignore": []
}
```

Set `"access": "public"` if publishing to npm with public packages. Set `"commit": true` to auto-commit changeset files.

### 2. Add a changeset per PR

Every PR that changes package behavior must include a changeset file. Run from the monorepo root:

```bash
pnpm changeset
```

The interactive prompt:
1. Asks which packages changed (select with space, confirm with enter)
2. Asks bump type per package: `major` / `minor` / `patch`
3. Opens an editor for a human-written summary

The summary is written for consumers of the package — not for internal developers:

```
❌ "Refactored the auth module to use the new token parser"
✅ "OAuth tokens are now validated locally without a round-trip to the auth server, reducing login latency by ~200ms"
```

This creates a file like `.changeset/purple-dogs-fly.md`:

```markdown
---
"@my-org/auth": minor
"@my-org/api-client": patch
---

OAuth tokens are now validated locally without a round-trip to the auth server, reducing login latency by ~200ms.
```

Commit this file with the PR. It persists until release.

### 3. Install the Changeset bot (optional but recommended)

The bot comments on every PR showing which packages will be affected and what bump type is set:

```yaml
# .github/workflows/changeset-bot.yml
name: Changeset Status
on: [pull_request]
jobs:
  changeset:
    runs-on: ubuntu-latest
    steps:
      - uses: changesets/action@v1
        with:
          comment: true
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

The bot also warns if a PR has no changeset (useful to catch missing entries before merge).

### 4. Version packages (release preparation)

When ready to release, run the version command to consume all pending changesets:

```bash
pnpm changeset version
```

This:
- Bumps `package.json` versions for all affected packages
- Updates each package's `CHANGELOG.md` with the human-written summaries grouped by bump type
- Cascades version bumps to dependent packages per `updateInternalDependencies` config
- Deletes consumed changeset files from `.changeset/`

Commit the result:

```bash
git add .
git commit -m "chore: version packages"
```

Review the generated changelogs before committing — they can be edited at this point. After commit, they are owned by Changesets.

### 5. Publish packages

```bash
pnpm changeset publish
```

This publishes all packages whose version in `package.json` is not yet on the registry. After publishing, tag the release:

```bash
git tag -a v1.2.0 -m "Release v1.2.0"
git push --follow-tags
```

Or use the full Changesets GitHub Action to automate both steps:

### 6. Automate with GitHub Actions

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    branches: [main]

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: pnpm/action-setup@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: pnpm

      - run: pnpm install --frozen-lockfile

      - uses: changesets/action@v1
        with:
          publish: pnpm changeset publish
          version: pnpm changeset version
          commit: "chore: version packages"
          title: "chore: version packages"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

This action:
1. Checks if there are unconsumed changesets on main
2. If yes: creates or updates a "Version Packages" PR accumulating all pending changesets
3. When the PR is merged: runs publish automatically

### 7. Handle pre-release mode (beta/canary)

For pre-release channels:

```bash
# Enter pre-release mode
pnpm changeset pre enter beta

# Add changesets as normal
pnpm changeset

# Version (produces 1.2.0-beta.0)
pnpm changeset version

# Publish to beta tag
pnpm changeset publish --tag beta

# Exit pre-release mode when stable
pnpm changeset pre exit
pnpm changeset version   # produces the stable 1.2.0
pnpm changeset publish
```

## Rules

- One changeset per PR — changesets represent intentional changes by a developer, not individual commits; combining multiple unrelated changes in one changeset obscures the changelog
- Write changeset summaries for package consumers, not internal developers — the summary becomes a CHANGELOG.md entry that external users read when deciding whether to upgrade
- Never edit `CHANGELOG.md` files by hand after Changesets has generated them — Changesets assumes it owns these files; manual edits will be overwritten or produce merge conflicts on the next version run
- Every PR that changes observable behavior must include a changeset — a PR with only internal refactoring that has no effect on package consumers may omit it; when in doubt, include one
- Do not version and publish from local machines in team environments — use CI to ensure consistent publish environment and prevent race conditions between concurrent releases

## Common Mistakes

- **Missing changesets for PRs** — packages ship without changelog entries; the bot in Step 3 prevents this by warning on PRs with no changeset.
- **Writing changeset summaries as commit messages** — "fix: null check in parser" is a developer message; "Fixed a crash when parsing files with null byte sequences" is a consumer message. Changesets summaries are changelog entries, not git history.
- **Versioning without reviewing changelogs** — `pnpm changeset version` produces correct entries from changeset content, but changeset content written hastily may be vague or incorrect; review `CHANGELOG.md` diffs after versioning before publishing.
- **Publishing from a dirty working tree** — if `pnpm changeset publish` runs while uncommitted changes exist in a package, the published artifact may include unintended code; always publish from a clean, CI-verified commit.
- **Forgetting to cascade dependencies** — package A depends on package B; package B bumps a minor; without `updateInternalDependencies: "patch"` config, package A's `package.json` still references the old version of B; Changesets handles this automatically when configured correctly.

## When NOT to Use

- The monorepo publishes a single package or has a single version for all packages — Changesets adds overhead (changeset files per PR) without benefit; use `generate-changelog` or `write-changelog` instead.
- The project uses Nx and has already adopted Nx Release — Nx Release is tightly integrated with the Nx task graph and provides equivalent functionality within the Nx ecosystem; switching to Changesets would require parallel configuration.
- Packages are not published externally (internal-only libraries, backend services with no npm publish step) — Changesets is primarily a publish-coordination tool; for internal versioning only, a changelog in git is sufficient without the full Changesets workflow.
