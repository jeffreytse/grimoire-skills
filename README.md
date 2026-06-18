<div align="center">
  <a href="https://grimoire.jeffreytse.net">
    <img alt="grimoire" src="https://raw.githubusercontent.com/jeffreytse/grimoire/main/assets/banner.svg" width="700">
  </a>
  <p>The official skill library for <a href="https://github.com/jeffreytse/grimoire">grimoire</a> — 1000+ best practices across 27 domains, ready to load into any AI assistant.</p>
  <br><h1>📖 grimoire-core 📖</h1>
</div>

<h4 align="center">
  The expert standard you didn't know applied — cited, verified, and executable by your <a href="#-agent-support">AI</a>.
</h4>

<p align="center">
  <a href="https://github.com/jeffreytse/grimoire-core/actions/workflows/validate.yml">
    <img src="https://github.com/jeffreytse/grimoire-core/actions/workflows/validate.yml/badge.svg"
      alt="Skill Validation" />
  </a>

  <a href="https://github.com/jeffreytse/grimoire-core/releases">
    <img src="https://img.shields.io/github/v/release/jeffreytse/grimoire-core?color=brightgreen"
      alt="Release Version" />
  </a>

  <a href="https://github.com/jeffreytse/grimoire-core/graphs/contributors">
    <img src="https://img.shields.io/github/contributors/jeffreytse/grimoire-core?color=brightgreen"
      alt="Contributors" />
  </a>

  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-greygreen.svg"
      alt="License: MIT" />
  </a>

  <a href="https://github.com/sponsors/jeffreytse">
    <img src="https://img.shields.io/static/v1?label=sponsor&message=%E2%9D%A4&logo=GitHub&link=&color=greygreen"
      alt="Donate (GitHub Sponsor)" />
  </a>

  <a href="#-agent-support">
    <img src="https://img.shields.io/badge/works%20with-Claude%20%C2%B7%20Codex%20%C2%B7%20Cursor%20%C2%B7%20Gemini%20%C2%B7%20OpenCode-blue"
      alt="Works with" />
  </a>

  <a href="./SKILLS.md">
    <img src="https://img.shields.io/badge/skills-1000%2B-blue"
      alt="1000+ Skills" />
  </a>
</p>

<div align="center">
  <h4>
    <a href="#-why-grimoire-core">Why</a> |
    <a href="#%EF%B8%8F-install">Install</a> |
    <a href="#-quick-start">Quick Start</a> |
    <a href="#-agent-support">Agents</a> |
    <a href="#%EF%B8%8F-domains">Domains</a> |
    <a href="#-the-grimoire-skill-standard">Standard</a> |
    <a href="#-contributing">Contributing</a> |
    <a href="https://github.com/jeffreytse/grimoire-core/releases">Changelog</a> |
    <a href="#-license">License</a>
  </h4>
</div>

<div align="center">
  <sub>Built with ❤︎ by
  <a href="https://jeffreytse.net">jeffreytse</a> and
  <a href="https://github.com/jeffreytse/grimoire-core/graphs/contributors">contributors</a>
  </sub>
</div>
<br>

## 🤔 Why Grimoire Skills?

> Your AI knows everything — Grimoire makes it practice it.

Books gave everyone knowledge. Google gave everyone access. AI gave everyone comprehension. None of them gave everyone *practice*. Grimoire does.

The model knows SOLID, DDD, Google SRE, and the ABA Model Rules. Without explicit guidance, it enforces none of them. This library is the enforcement layer — **skills**: named, citable, executable units of expert practice. One concept. One source. One set of steps.

- 🔍 **You don't know what you don't know.** Grimoire surfaces the governing standard you didn't know applied.
- 🤖 **Knowing is not enough. Grimoire enforces.** Specific steps, verifiable criteria, repeatable results. Not summaries — verdicts.
- 🌍 **The world's best practices belong to everyone.** McKinsey charges $1M. Senior lawyers bill $800/hr. The practices they follow are not proprietary. Grimoire makes them free — as executable steps, cited and verified.
- 🧱 **Every profession. Every AI.** 1000+ skills across 27 domains. Works with Claude, Codex, Cursor, Gemini, OpenCode, and OpenClaw.

| Repo | Role |
|------|------|
| [jeffreytse/grimoire](https://github.com/jeffreytse/grimoire) | CLI tool — installs and manages skills |
| **jeffreytse/grimoire-core** (this repo) | Skills content — 1000+ practices across 27 domains |

If you've spent 10,000 hours mastering something, your practice belongs here.

## 🛠️ Install

**macOS / Linux:**

```bash
# 1. Install the grimoire CLI
curl -fsSL https://raw.githubusercontent.com/jeffreytse/grimoire/main/scripts/install.sh | bash

# 2. Pull this skills library and link to your AI agents
grimoire update    # clone → ~/.grimoire
grimoire install   # link to Claude Code, Codex, Gemini CLI, OpenCode, etc.
```

**Go:**

```bash
go install github.com/jeffreytse/grimoire@latest
grimoire update && grimoire install
```

**Native plugin install (Claude Code):**

```bash
/plugin marketplace add jeffreytse/grimoire-core
/plugin install grimoire@grimoire-core           # all domains
/plugin install grimoire-engineering@grimoire-core  # one domain
```

## 🤖 Agent Support

| Agent | Plugin install | Script install |
|-------|----------------|----------------|
| Claude Code | `/plugin marketplace add jeffreytse/grimoire-core` then `/plugin install grimoire@grimoire-core` | `grimoire install --target claude` |
| GitHub Copilot CLI | `copilot plugin marketplace add jeffreytse/grimoire-core` then `copilot plugin install grimoire@grimoire-core` | `grimoire install --target all` |
| Gemini CLI | `gemini extensions install https://github.com/jeffreytse/grimoire-core` | `grimoire install --target gemini` |
| OpenCode | See [`.opencode/INSTALL.md`](./.opencode/INSTALL.md) | `grimoire install --target opencode` |
| Codex CLI | `AGENTS.md` auto-loaded | `grimoire install --target codex` |
| Cursor | `AGENTS.md` context injection | `grimoire install --target cursor` |

## 🚀 Quick Start

**Describe any problem in plain language — grimoire routes to the right skill:**

```
User: I need to raise a Series A but don't know how to pitch investors.

Claude: Situation matches: write-value-proposition + design-go-to-market + apply-pyramid-principle
        → Start with your value prop. /write-value-proposition
```

**Or invoke a skill directly:**

```bash
/suggest-best-practice     # describe any problem — auto-routes to the right skill
/review-pull-request       # engineering code review
/calculate-fire-number     # how much do I need to retire?
/review-saas-contract      # flag the 3 highest-risk clauses
/design-sleep-protocol     # evidence-based sleep improvement
/negotiate-salary          # structure your compensation negotiation
```

**Common paths:**

| You want to… | Use |
|---|---|
| Know exactly which skill you need | `/skill-name` directly |
| Have a problem, unsure which skill | `/suggest-best-practice` |
| Already have a plan, want gaps checked | `/review-best-practice-fit` |
| Need 2+ practices coordinated in sequence | `/plan-best-practice-solution` |
| Complex problem — sub-problems emerge during execution | `/apply-best-practice-tree` |
| Don't know what practices exist for a topic | `/discover-best-practices` |
| About to start a task — want to catch gaps first | `/start-best-practice` |

## 🗺️ Domains

| Domain | Sub-domains |
|--------|-------------|
| [meta](./skills/meta/) | suggest-best-practice, start-best-practice, analyze, discover, plan, compare, review, teach, apply-bpdd, check-compliance, write-skill, review-skill, … |
| [engineering](./skills/engineering/) | development, frontend, architecture, testing, reliability, devops, cloud, networking, security, data, ai, hardware, mobile, performance, project-management, product, documentation |
| [business](./skills/business/) | strategy, operations, leadership, entrepreneurship, hr |
| [science](./skills/science/) | biology, physics, chemistry, mathematics, earth-science, astronomy |
| [health](./skills/health/) | fitness, nutrition, mental-health, sleep, medicine |
| [writing](./skills/writing/) | creative, technical, copywriting, academic, journalism |
| [design](./skills/design/) | ui-ux, graphic, branding, motion, product |
| [marketing](./skills/marketing/) | seo, content, social-media, paid-ads, growth, analytics |
| [finance](./skills/finance/) | personal-finance, investing, accounting, real-estate, corporate |
| [law](./skills/law/) | contracts, ip, employment, privacy, corporate |
| [education](./skills/education/) | curriculum, teaching, e-learning, assessment, learning-science |
| [film](./skills/film/) | cinematography, directing, editing, screenwriting, production |
| [photography](./skills/photography/) | composition, lighting, editing, genres |
| [music](./skills/music/) | composition, production, mixing, theory, performance |
| [cooking](./skills/cooking/) | techniques, baking, flavor, nutrition, world-cuisine |
| [language](./skills/language/) | learning, linguistics, translation, communication |
| [art](./skills/art/) | drawing, painting, digital-art, illustration, color-theory |
| [sports](./skills/sports/) | training, coaching, nutrition, tactics, recovery |
| [productivity](./skills/productivity/) | time-management, habits, focus, goals, tools |
| [travel](./skills/travel/) | planning, budgeting, cultural, adventure |
| [psychology](./skills/psychology/) | cognitive, behavioral, social, clinical, positive |
| [home](./skills/home/) | renovation, interior-design, gardening, organization, smart-home |
| [environment](./skills/environment/) | sustainability, ecology, climate, energy, policy |
| [pets](./skills/pets/) | dogs, cats, training, nutrition, health |
| [fashion](./skills/fashion/) | styling, wardrobe, design, sustainability, accessories |
| [parenting](./skills/parenting/) | infant, toddler, school-age, teen |
| [automotive](./skills/automotive/) | maintenance, troubleshooting, buying, ev |

→ [Browse all skills](./SKILLS.md)

## 🌟 Featured Skills

| Skill | Domain | Source methodology | Verified |
|-------|--------|--------------------|----------|
| [`review-saas-contract`](./skills/law/contracts/skills/review-saas-contract/) | law/contracts | ABA model SaaS agreements | ✓ |
| [`calculate-fire-number`](./skills/finance/personal-finance/skills/calculate-fire-number/) | finance/personal-finance | Bengen (1994) / Trinity Study | ✓ |
| [`negotiate-salary`](./skills/finance/personal-finance/skills/negotiate-salary/) | finance/personal-finance | Fisher & Ury "Getting to Yes" | ✓ |
| [`design-sleep-protocol`](./skills/health/sleep/skills/design-sleep-protocol/) | health/sleep | Walker "Why We Sleep" / AASM | ✓ |
| [`apply-mise-en-place`](./skills/cooking/techniques/skills/apply-mise-en-place/) | cooking/techniques | Culinary Institute of America | ✓ |
| [`apply-five-whys`](./skills/engineering/reliability/skills/apply-five-whys/) | engineering/reliability | Toyota Production System | ✓ |
| [`review-pull-request`](./skills/engineering/development/skills/review-pull-request/) | engineering/development | Google Engineering Practices | ✓ |
| [`design-training-program`](./skills/sports/training/skills/design-training-program/) | sports/training | NSCA / Bompa "Periodization" | ✓ |

→ [Browse all skills by domain](./SKILLS.md)

## 📐 The Grimoire Skill Standard

grimoire maintains an open standard for AI agent skill quality — freely adoptable by any skill library.

Every skill must pass [`review-best-practice-skill`](./skills/meta/skills/review-best-practice-skill/) before merge:

| Criterion | Requirement | Rejection example |
|-----------|-------------|-------------------|
| **Adopted by** | Named organizations or institutions | "Many top companies" |
| **Impact** | Cited study or % number | "Significantly improves quality" |
| **Steps** | Immediately executable | Abstract theory or advice |
| **Scope** | One concept per skill | "Nutrition and training program" |
| **Source** | External institution or standard body | Internal opinion |

Each skill lives at `skills/<domain>/<subdomain>/skills/<skill-name>/SKILL.md`:

```markdown
---
name: skill-name
description: Use when <triggering conditions>
source: Author/Org, "Title", Year
tags: [problem-keyword, tool, role, outcome]
---

# Skill Name

One-sentence purpose.

## Why This Is Best Practice

**Adopted by:** ...
**Impact:** ...

## Steps
...
```

→ [Read the full standard](./STANDARD.md) · [Adopt this standard](./STANDARD.md#adopting-this-standard)

## 🤝 Contributing

**Your first skill in ~30 minutes:**

1. Pick a practice you've used at the highest level in your field
2. Run `/write-best-practice-skill` — it guides you through the format step by step
3. Open a PR — `/review-best-practice-skill` runs automatically and flags any gaps
4. Merge after review passes

> This workflow applies to contributions to **this repository** (the official package). Skills in your own package have no such requirement — see [docs/user-package.md](./docs/user-package.md).

| Task | Skill |
|------|-------|
| Write a new skill | [`write-best-practice-skill`](./skills/meta/skills/write-best-practice-skill/) |
| Review a skill PR | [`review-best-practice-skill`](./skills/meta/skills/review-best-practice-skill/) |
| Fix review findings | [`revise-best-practice-skill`](./skills/meta/skills/revise-best-practice-skill/) |
| Add a new domain | [`design-best-practice-domain`](./skills/meta/skills/design-best-practice-domain/) |
| Audit a domain's health | [`audit-best-practice-domain`](./skills/meta/skills/audit-best-practice-domain/) |
| Retire an outdated skill | [`deprecate-best-practice-skill`](./skills/meta/skills/deprecate-best-practice-skill/) |

See [CONTRIBUTING.md](./CONTRIBUTING.md) · [GOVERNANCE.md](./GOVERNANCE.md) · [STANDARD.md](./STANDARD.md)

## 🔧 Maintainer

**Update plugin manifest before each release** (keeps Claude Code marketplace in sync with new skills):

```bash
make update-plugin-manifest   # auto-generates .claude-plugin/plugin.json from directory structure
make check-manifest           # CI gate: fails if manifest is out of sync
```

## 📄 License

This project is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php) © [Jeffrey Tse](https://jeffreytse.net)
