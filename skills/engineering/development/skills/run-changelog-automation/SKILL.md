---
name: run-changelog-automation
description: Use when a software project enforces Conventional Commits and wants automated changelog generation and semantic version bumping without manual writing at each release.
source: semantic-release (npm, open-source); release-please (Google, open-sourced 2019); changelogen (UnJS/Nuxt team); Angular changelog automation case study
tags: [changelog, automation, conventional-commits, semantic-versioning, ci-cd, release, semantic-release, release-please]
---

# Run Changelog Automation

Automate changelog generation and version bumping from Conventional Commit history so release preparation requires zero manual writing.

## Why This Is Best Practice

**Adopted by:** Angular, Vue, Electron, AWS CDK, and Nx use automated changelog generation as part of their release pipelines; semantic-release is used by 500k+ GitHub repositories and downloaded over 2 million times per week on npm; release-please is Google's internal release automation tool, open-sourced and used across Google's OSS portfolio including googleapis and gRPC
**Impact:** Angular adopted semantic-release for their monorepo and reduced release preparation time from several hours of manual work to a fully automated CI step; automated generation eliminates the two most common release errors — forgotten changelog entries and version/git tag mismatches — because all three are derived from the same commit history atomically
**Why best:** Manual changelog writing depends on a developer remembering every commit since the last release; this fails under time pressure, produces inconsistent entry quality, and decouples the changelog from the version bump (a common source of mismatch); raw commit log surfacing (`git log`) is the alternative but produces developer-facing messages unfit for users; automated tools parse Conventional Commits, filter to user-relevant types, and produce structured markdown — deterministically, on every release

Sources: Angular blog "So You Think You Know Semantic Versioning" (2022); semantic-release documentation (semantic-release.gitbook.io); release-please GitHub repository (github.com/googleapis/release-please); changelogen documentation (github.com/unjs/changelogen)

## Steps

### 1. Verify Conventional Commits enforcement

Automated tools parse commit types (`feat:`, `fix:`, `docs:`) to determine version bump and entry inclusion. Non-conforming commits produce no changelog entry — silent omissions.

Enforce before setting up automation:

```bash
# Install commitlint + husky
npm install --save-dev @commitlint/cli @commitlint/config-conventional husky

# Init husky
npx husky init

# Add commit-msg hook
echo 'npx --no -- commitlint --edit $1' > .husky/commit-msg
chmod +x .husky/commit-msg

# Create commitlint config
echo "export default { extends: ['@commitlint/config-conventional'] };" > commitlint.config.mjs
```

Or enforce in CI instead of locally (lower friction for contributors):

```yaml
# GitHub Actions: .github/workflows/commitlint.yml
- uses: wagoid/commitlint-github-action@v6
```

### 2. Choose the right tool

| Tool | Best for | Automation level | Non-npm support |
|------|----------|-----------------|-----------------|
| **semantic-release** | Full CI automation, npm publish | Fully automatic — no human trigger | Via plugins |
| **release-please** | Teams wanting PR review before release | Semi-automatic — creates a Release PR | Yes (Go, Java, Python, etc.) |
| **changelogen** | Changelog-only (no publish step) | Manual trigger, markdown output | Yes |

**Use semantic-release** when: CI should release automatically on every merge to main, project publishes to npm, team trusts the commit discipline.

**Use release-please** when: team wants to review and approve the next release before it ships (Release PR accumulates changes, human merges to trigger release).

**Use changelogen** when: project is not an npm package, or you only want changelog generation without automated publish.

### 3. Configure semantic-release

```bash
npm install --save-dev semantic-release @semantic-release/changelog @semantic-release/git
```

`.releaserc` (project root):

```json
{
  "branches": ["main"],
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    ["@semantic-release/changelog", {
      "changelogFile": "CHANGELOG.md"
    }],
    "@semantic-release/npm",
    ["@semantic-release/git", {
      "assets": ["CHANGELOG.md", "package.json"],
      "message": "chore(release): ${nextRelease.version} [skip ci]\n\n${nextRelease.notes}"
    }],
    "@semantic-release/github"
  ]
}
```

Default version bump rules (from `@semantic-release/commit-analyzer`):

| Commit type | Version bump |
|-------------|-------------|
| `fix:` | patch |
| `feat:` | minor |
| `feat!:` or `BREAKING CHANGE:` footer | major |
| `chore:`, `docs:`, `style:`, `refactor:`, `test:` | none |

### 4. Configure release-please

```bash
npm install --save-dev release-please
```

`release-please-config.json` (project root):

```json
{
  "packages": {
    ".": {
      "release-type": "node",
      "changelog-path": "CHANGELOG.md"
    }
  }
}
```

`.release-please-manifest.json`:

```json
{
  ".": "1.0.0"
}
```

GitHub Action (`.github/workflows/release-please.yml`):

```yaml
on:
  push:
    branches: [main]

jobs:
  release-please:
    runs-on: ubuntu-latest
    steps:
      - uses: googleapis/release-please-action@v4
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
```

This creates a "Release PR" that accumulates `feat:` and `fix:` commits into a changelog draft. When the PR is merged, release-please creates the GitHub release and tag.

### 5. Configure changelogen (changelog-only)

```bash
npm install --save-dev changelogen
```

Add to `package.json`:

```json
{
  "scripts": {
    "changelog": "changelogen --release"
  }
}
```

Run before tagging:

```bash
npm run changelog          # updates CHANGELOG.md
git add CHANGELOG.md
git commit -m "chore: update changelog for v1.2.0"
git tag v1.2.0
```

### 6. CI integration for semantic-release

```yaml
# .github/workflows/release.yml
name: Release

on:
  push:
    branches: [main]

jobs:
  release:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      issues: write
      pull-requests: write
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0        # semantic-release needs full history
          persist-credentials: false

      - uses: actions/setup-node@v4
        with:
          node-version: 20

      - run: npm ci

      - run: npx semantic-release
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          NPM_TOKEN: ${{ secrets.NPM_TOKEN }}
```

`fetch-depth: 0` is required — semantic-release reads all tags to determine the last release.

### 7. Dry-run verification

Before enabling on main, verify the generated output:

```bash
# semantic-release dry run (no tags, no publish, no changelog write)
npx semantic-release --dry-run

# changelogen preview
npx changelogen --from v1.0.0 --to HEAD
```

Check that:
- Version bump type matches expectations (patch/minor/major)
- Generated entries cover all user-relevant commits since last tag
- Breaking changes appear prominently

## Rules

- Never mix automated and manual changelog editing — pick one workflow; mixed editing corrupts the automation's ability to determine what was already released
- Do not squash-merge PRs into main — squash produces a single commit with the PR title, discarding all conventional commit messages from branch commits; use merge commits or rebase-merge
- Breaking changes must use `feat!:` prefix or include `BREAKING CHANGE: <description>` in the commit footer — tools detect these token patterns to trigger major bumps
- `[skip ci]` in the release commit message is required when using semantic-release with `@semantic-release/git` — prevents infinite CI loops when the release commit pushes to main
- The `NPM_TOKEN` secret must have publish permissions to the package's npm scope; automation fails silently on auth errors without this

## Common Mistakes

- **Missing `fetch-depth: 0`** — `actions/checkout` defaults to a shallow clone (depth 1); semantic-release cannot find prior tags and either fails or bumps to 1.0.0 on every run.
- **Squash-merging PRs** — discards commit types; all squash-merged PRs appear as a single commit with no type prefix, producing no changelog entry.
- **Running semantic-release on feature branches** — triggers spurious releases; scope to `main` (or `master`) in `.releaserc` `branches` field.
- **Committing CHANGELOG.md manually** — creates a commit that looks like a release commit to the tool; can cause duplicate or skipped releases; let the tool own the file.
- **No breaking change syntax** — a commit that removes a public API without `!` or `BREAKING CHANGE:` footer gets detected as a patch bump; downstream users get a breaking change in a patch release.

## When NOT to Use

- The project does not use Conventional Commits — automated tools produce empty or incorrect changelogs from freeform commit messages; adopt `propose-conventional-commit` first.
- The team uses squash-merge as their primary merge strategy and cannot change it — commit type information is lost at merge time; `write-changelog` (manual) is more reliable in this case.
- The project has no CI pipeline — automated changelog generation requires a CI step to run deterministically; running it locally leads to the same consistency problems as manual writing.
