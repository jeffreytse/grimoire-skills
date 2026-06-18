---
name: design-user-persona
description: Use when distilling user research data into 2–4 archetypal user profiles to give the team a shared, evidence-grounded reference for design and product decisions.
source: Cooper "The Inmates Are Running the Asylum" (SAMS, 1999); NNG "Personas" guideline; Pruitt & Adlin "The Persona Lifecycle" (Morgan Kaufmann, 2006)
tags: [user-research, personas, ux, design-thinking, user-needs, product-strategy]
---

# Create User Persona

Build 2–4 behavior-based persona profiles from research data to give the team a concrete, named representation of who they are designing for — and who they are not.

## Why This Is Best Practice

**Adopted by:** Alan Cooper introduced the persona method at Apple in the 1980s; Microsoft adopted personas organization-wide in the early 2000s (documented in Pruitt & Adlin 2006); Google, IBM, and Amazon all use persona-based design as the standard for aligning cross-functional teams on user needs; IDEO's HCD process includes persona creation as a core synthesis artifact
**Impact:** Cooper (1999) documented that teams without personas consistently design for edge cases and hypothetical "elastic users" — leading to features that satisfy no one; Pruitt & Adlin (2006) studied Microsoft teams and found persona adoption correlated with fewer late-stage design reversals and reduced cross-team disagreements about target user needs; NNG reports that teams with research-grounded personas ship 20% fewer features that users consistently don't use
**Why best:** Demographic profiles ("male, 25–40, tech-savvy") describe who users are but not what they need; ad-hoc user stories describe tasks but not goals or context; behavior-based personas synthesize both into a single artifact that teams can reference in any product decision — "would Maya do this?" is a faster, more consistent decision filter than re-running the research

Sources: Cooper "The Inmates Are Running the Asylum" (SAMS, 1999) Ch. 9; Pruitt & Adlin "The Persona Lifecycle" (Morgan Kaufmann, 2006); NNG "Personas Make Users Memorable for Product Team Members" (Harley, 2015)

## Steps

### 1. Cluster participants by behavior, not demographics

From research synthesis, identify 2–4 distinct behavioral patterns across participants. Behavioral patterns are defined by what participants do and why — not by age, gender, or job title.

Look for variation in:
- Goals (what they are ultimately trying to achieve, beyond the immediate task)
- Frequency and context of use
- Workarounds and coping strategies
- Attitudes toward technology, process, or the domain
- Pain point severity and tolerance

Example: a project management tool might find two distinct patterns — "coordinator" (tracks others' work, high communication frequency, frustrated by status-request overhead) and "executor" (works head-down on assigned tasks, low collaboration need, frustrated by interruptions). Same product, different behavioral clusters.

**Do not create personas by:**
- Averaging all participants into one composite — destroys behavioral distinctions
- Mapping one persona per demographic segment — demographics don't predict behavior reliably
- Inventing a persona for an underrepresented user type not seen in research

### 2. Name and sketch each persona

For each behavioral cluster:

```
Name: Maya Chen
Photo: [stock photo matching the persona's context — not a headshot of a real participant]
Tagline: "I need to know the status of everything without having to ask."

Role/context: Operations coordinator at a 50-person logistics company
Experience level: Moderate technical proficiency; heavy spreadsheet user
```

The name and photo are memory aids — they make the persona easier to reference in conversation than "user type 2". The name should be culturally plausible for the demographic the research surfaced, not aspirational or generic.

### 3. Document goals and frustrations

**Primary goal** — the underlying outcome the persona is trying to achieve, beyond the immediate task:
```
Goal: Know her team's status at any moment without chasing people for updates
```

**Secondary goals** — supporting outcomes:
```
Secondary: Keep her manager informed without spending time preparing status reports
```

**Top frustrations** — specific pain points grounded in research observations:
```
Frustrations:
- Spends 30+ min/day asking teammates for status updates via Slack
- Status information lives in 3 different tools with no single view
- Teammates mark tasks "done" before they're actually complete
```

Frustrations must be grounded in specific research observations — not invented to make the persona more sympathetic.

### 4. Add a behavior quote

One direct quote from research (or a composite of similar quotes) that captures the persona's core tension:

```
"I have a spreadsheet that I update manually every morning because I don't trust the system to be current."
```

The quote should be something a real participant said (or closely paraphrased). It anchors the persona in evidence and gives the team language to reference.

### 5. Document key tasks and context

List 3–5 tasks the persona performs that are in scope for the product:

```
Key tasks:
1. Checks project status first thing each morning
2. Assembles a weekly status report for her manager
3. Escalates blocked tasks to the project owner
4. Onboards new team members to the project workflow
```

Include context: device, environment, time pressure, collaboration patterns.

### 6. Define "not this persona"

For each persona, write one sentence about who they are NOT — to prevent the team from designing for everyone simultaneously:

```
Maya is NOT the project owner making strategic decisions about scope — that's Persona 2 (Amir).
Maya is NOT a solo freelancer with no team to coordinate.
```

This boundary is as important as the persona definition itself. Without it, teams expand personas to include edge cases until they become meaningless.

### 7. Validate against research data

Before publishing, check each persona against the raw data:
- Every frustration maps to at least 2 research observations
- The goal statement is grounded in what participants said, not what you assume they want
- No persona attribute was invented to round out the profile

Flag invented attributes as assumptions to be validated in future research.

### 8. Distribute and make it sticky

A persona that lives in a Confluence page no one reads is not being used. Make it visible:
- One-page printable format per persona, posted in the team's physical or virtual workspace
- Referenced by name in design critiques, backlog grooming, and roadmap discussions
- Reviewed and updated after each major research cycle (typically once per year)

## Rules

- Never create a persona without research data — proto-personas (assumption-based) must be labeled as unvalidated hypotheses, not presented as research findings
- Limit to 2–4 personas per product scope; more than 4 fragments team focus and makes tradeoff decisions harder, not easier
- Personas are not market segments — a 25% market segment does not automatically become a persona; behavioral clusters may cut across market segments
- Demographic details (age, location, income) are context, not definition — the behavior pattern is the persona's identity
- Update personas after each major research cycle; stale personas that no longer reflect observed behavior are worse than no personas

## Common Mistakes

- **Demographic personas**: "Sarah, 35, marketing manager, tech-savvy" describes who she is, not what she does; add goals, frustrations, and behaviors or the persona cannot inform design decisions
- **The average user persona**: a single composite that blends all participants obscures the behavioral distinctions that drive design tradeoffs; if one persona has conflicting needs, it's two personas
- **Inventing frustrations**: adding pain points not observed in research to make the persona more compelling undermines credibility; annotate invented details as assumptions
- **Personas as presentations**: a persona presented in a readout and then filed away has no effect; the mechanism of value is reference in ongoing design decisions
- **Designing for the least-capable persona by default**: personas allow conscious tradeoffs — explicitly decide which persona is primary for each feature rather than always defaulting to the most novice profile

## When NOT to Use

- When no user research has been conducted — assumption-based personas must be labeled "proto-persona" and treated as hypotheses, not design constraints
- When the product serves a single, highly homogeneous user population with no meaningful behavioral variation — a single representative user description suffices
- When the team already has validated, current personas from recent research — update existing personas rather than creating new ones from scratch
