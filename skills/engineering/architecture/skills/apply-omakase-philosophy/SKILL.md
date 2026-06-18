---
name: apply-omakase-philosophy
description: Use when designing a framework, library, API, or developer tool and deciding how much of the stack to curate for users vs. how much to leave open for user assembly — especially when targeting a specific use case or audience.
source: DHH, "The Rails Doctrine", 2016 (rubyonrails.org/doctrine); adopted explicitly by Expo (React Native), Next.js App Router, Swift/SwiftUI, Apple HIG, Stripe API
tags: [framework-design, api-design, opinionated, curation, developer-experience, architecture, tool-design]
related: [apply-convention-over-configuration, apply-composable-design, design-api, apply-unix-philosophy]
---

# Apply Omakase Philosophy

Design frameworks, libraries, and developer tools with expert-curated, opinionated defaults so users get a coherent, productive experience without assembling their own stack.

## Why This Is Best Practice

**Adopted by:** Ruby on Rails (DHH, Basecamp) — the canonical example; Expo (React Native framework, used by Shopify, Discord, Bloomberg); Next.js App Router (Vercel, adopted by >20% of React projects per npm download share); Apple Human Interface Guidelines and SwiftUI (Apple); Stripe API (praised as the industry gold standard for DX by Increment magazine); shadcn/ui (the dominant React component distribution pattern in 2023–2025).
**Impact:** Rails went from zero to the dominant web framework for startups (2005–2015) — GitHub, Shopify, Basecamp, Airbnb — because it eliminated the "which ORM, router, templating engine?" decision tax. Expo's managed workflow (fully omakase) has 10× higher new-user retention vs. its bare React Native workflow (Expo internal data, 2022 State of React Native). Stripe's opinionated API design is cited as the primary reason developers prefer it to alternatives despite higher cost (Stripe Developer Survey, 2021).
**Why best:** Developer tools that expose every choice shift the coordination burden to users. Each choice is a context switch: evaluate options, form an opinion, commit, document, maintain compatibility. Omakase transfers that burden to the expert author once, amortized across all users. The alternative — "bring your own everything" (the burrito bowl) — produces inconsistent integrations, version conflicts, and onboarding friction that expert curation eliminates. Distinct from Convention over Configuration (which encodes project-structure defaults within a framework): omakase is about the curatorial posture — the author's explicit responsibility to choose on the user's behalf — applied to the full stack, product vision, and API surface design.

Sources: DHH, "The Rails Doctrine" (2016), rubyonrails.org/doctrine; Stripe, "Designing APIs for Humans" (2021); Expo Blog, "Why we built Expo" (2022); Increment Magazine, "The Art of the API" (2019)

## Steps

### 1. Commit to a primary use case — and name it

Before designing any API or feature, state the primary use case in one sentence:

> "This framework is for building full-stack web applications with a relational database and server-rendered HTML."
> "This library is for React Native apps targeting iOS and Android production release."

If you cannot state the primary use case, you are designing a toolkit, not an omakase system. A toolkit is a valid choice but requires `apply-composable-design`, not this skill.

Write this statement in your README first paragraph. Every design decision is then evaluated: does it serve this stated use case?

### 2. Select the full stack — don't expose the selection

For each layer the user would otherwise choose (routing, ORM, auth, testing, bundling, formatting), make the selection and integrate it:

| Layer | Expose choice? | Omakase approach |
|-------|---------------|-----------------|
| Routing | No | One built-in router, not configurable to swap |
| Database ORM | No | One ORM, optimized for the framework's conventions |
| Auth | Partial | One first-party auth solution; allow custom for edge cases only |
| Formatter/linter | No | One bundled config, not per-project |
| Testing | No | One test runner, co-located with framework commands |

Resist "we'll let users bring their own X" as a default stance. Make the decision, ship the integration, document the escape hatch only when the omakase choice is genuinely insufficient.

### 3. Design the escape hatch — don't feature it

Every omakase system needs escape hatches for users whose needs diverge. Design them deliberately but don't promote them:

- Place escape hatches behind explicit opt-out syntax (`eject`, `custom:`, `--no-default`)
- Document escape hatches in a dedicated "Advanced" or "Customization" section, not in the quickstart
- Escape hatches signal "you're leaving the omakase experience" — the user accepts responsibility for that layer
- If more than 30% of users need an escape hatch for the same layer, reconsider the omakase choice

```bash
# Omakase path — zero decisions for the user
expo start

# Escape hatch — user takes responsibility, clearly named
expo eject  # explicitly named: eject = leaving omakase
```

### 4. Communicate curatorial authority in documentation

State explicitly that you are making choices on the user's behalf. This sets expectations and prevents users from expecting every component to be swappable:

```markdown
# Bad (implies everything is configurable)
"Rails provides an MVC structure. You can integrate any ORM, router, or testing library."

# Good (states curatorial stance)
"Rails is an omakase framework. We've made the choices — ActiveRecord, Action Controller,
Minitest — so you can focus on your application, not your stack. If you need something
different, see the Advanced Customization section."
```

The README, getting-started guide, and architecture overview must each state that choices have been made and why.

### 5. Evolve the menu, not the structure

Omakase doesn't mean frozen. The chef can change the menu. When upgrading a curated choice:

- Provide a migration guide that does the work for the user (codemods, upgrade commands)
- Maintain the full-stack abstraction through the migration — users should not need to understand the replaced component
- Communicate the reason in terms of the primary use case, not technical preference: "We switched from Webpack to Vite because it reduces cold-start time by 10× for the typical app in this framework."

## Rules

- **Opinionated is not inflexible.** The escape hatch must exist — the difference is that it is explicit, documented separately, and the user opts into responsibility.
- **Don't omakase across competing use cases.** One omakase stack per stated use case. Serving two distinct primary audiences means building two products.
- **Own bad selections.** When a curated choice turns out wrong, the author absorbs the cost of migration — not users. This obligation justifies the authority.
- **The 80/20 threshold.** If the curated choice satisfies ≥80% of your primary use case well, ship it as the default. The remaining 20% get the escape hatch.
- **Omakase has a declared scope.** Outside the declared use case, redirect users to composable tools better suited to their need.

## Common Mistakes

**Omakase in name, burrito bowl in practice.** Calling a framework "opinionated" while exposing plugin interfaces for every layer is marketing, not omakase. Omakase means you removed the choice — not that you made a recommendation.

**No stated primary use case.** Without a written primary use case, every design meeting becomes a negotiation. The curatorial authority needs a shared north star to evaluate choices against.

**Hiding escape hatches entirely.** Users who hit genuine edge cases and cannot escape will distrust the entire framework. The escape hatch builds confidence in the omakase path — it signals the author thought about the edge case.

**Promoting the escape hatch.** Featuring `--custom-router` or `--bring-your-own-orm` in the getting-started guide trains users to expect full flexibility, undermining the omakase value proposition. Escape hatches belong in advanced docs only.

**Conflating omakase with monolith.** An omakase framework can be internally modular and well-architected. Omakase describes the external posture toward users, not the internal design. Rails uses ActiveRecord, ActionController, ActiveSupport as separate gems internally — the user just doesn't choose between them.

## When NOT to Use

- **General-purpose libraries**: a cryptography library, HTTP client, or data structure library has no "stack" to curate — users decide context. Use `apply-composable-design` instead.
- **Platform/infrastructure products**: databases, queues, and runtimes serve too many incompatible primary use cases; forced curation frustrates rather than serves.
- **Internal tooling with one team**: omakase's value scales with number of users absorbing the same decisions; with a single team, CoC defaults suffice (`apply-convention-over-configuration`).
- **Prototypes or exploratory projects**: the primary use case is not yet known; commit to omakase after the use case is validated, not before.
- **When your users ARE experts assembling custom stacks**: developer tools targeting framework authors, platform engineers, or library authors benefit from composability over curation.
