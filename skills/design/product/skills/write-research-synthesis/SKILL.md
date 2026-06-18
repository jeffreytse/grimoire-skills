---
name: write-research-synthesis
description: Use when user research sessions are complete and raw notes need to be organized — to identify behavioral patterns and extract actionable insight statements the team can act on.
source: NNG affinity diagramming guide; IDEO Design Thinking synthesis methods; Dovetail "Research Repository Best Practices" (2022)
tags: [user-research, synthesis, affinity-mapping, insights, qualitative-analysis, thematic-analysis]
---

# Write Research Synthesis

Convert raw session notes into a structured insight set by grouping atomic observations into themes, then distilling themes into declarative insight statements that the team can act on.

## Why This Is Best Practice

**Adopted by:** IDEO's Design Thinking process treats synthesis as a mandatory phase between fieldwork and ideation; NNG's research training certifies affinity diagramming as the standard qualitative analysis method; Dovetail, Airtable, and Notion have each built dedicated research repository products around structured synthesis workflows, reflecting widespread adoption in product teams
**Impact:** Unstructured synthesis — reviewing notes and writing a summary — produces conclusions dominated by recency bias (last session) and confirmation bias (findings that match existing hypotheses); structured affinity mapping surfaces patterns across all sessions with equal weight; NNG documents that teams using structured synthesis report significantly higher stakeholder confidence in research findings because conclusions are visibly grounded in evidence
**Why best:** Reporting raw quotes without synthesis transfers the analytical burden to stakeholders who were not present in sessions; synthesizing to generic themes ("users want simplicity") without grounding in behavioral evidence produces insights too vague to act on; the atomic observation → cluster → insight chain creates a traceable path from evidence to recommendation

Sources: NNG "Affinity Diagrams: Learn How to Cluster and Bundle Ideas and Facts" (2023); IDEO "The Field Guide to Human-Centered Design" (IDEO.org, 2015); Portigal "Interviewing Users" Ch. 8 (Rosenfeld Media, 2013); Dovetail "Research Repository Best Practices" (2022)

## Steps

### 1. Gather raw materials

Collect everything from sessions before analysis begins:
- Session notes (timestamped quotes and behaviors)
- Recording timestamps for notable moments
- Facilitator debrief notes from each session

Do not begin clustering until all sessions are complete. Synthesizing mid-study introduces availability bias — early sessions get disproportionate weight.

### 2. Convert notes to atomic observations

Rewrite each note as a single, self-contained observation on a sticky note (physical or digital — Miro, FigJam, Dovetail):

- One observation per note
- Written as a behavioral fact, not an interpretation
- Includes the participant ID for traceability

```
✅ P3: "I always screenshot the confirmation page because I don't trust the email will arrive"
✅ P1: opened a separate spreadsheet to cross-reference pricing during the session
❌ "Users don't trust the system" — interpretation, not observation
```

A 60-minute session typically produces 20–40 atomic observations. For 6 sessions, expect 120–240 notes before clustering.

### 3. Cluster by similarity (affinity mapping)

Arrange all notes on a shared canvas. Group notes that describe the same behavior, attitude, or context — without pre-defining the categories.

**Process:**
1. Place all notes ungrouped
2. Move notes that feel similar near each other — let groups emerge organically
3. When a group stabilizes at 3+ notes, give it a temporary label
4. Merge groups that mean the same thing; split groups that contain two distinct phenomena

**Rules for clustering:**
- Groups are defined by what participants did or said, not by product feature areas
- No group should be named after a product feature (e.g., "navigation issues") — name it after the behavior or need (e.g., "users lose context switching between sections")
- An ungrouped outlier is valid data — do not force it into a cluster

### 4. Name the clusters as behavioral themes

Write a theme label that describes the pattern, not the feature:

```
❌ "Search problems"
✅ "Users rely on external tools when internal search fails"

❌ "Onboarding"
✅ "New users skip setup steps they perceive as optional, then hit errors later"
```

A cluster with fewer than 3 observations is a weak signal — note it but do not elevate it to a primary insight.

### 5. Write insight statements

For each theme, write one declarative insight statement:

```
[User group] [behavior or belief] because [underlying reason], 
which means [implication for design or product].
```

Example:
```
Power users maintain a personal spreadsheet alongside the product because the export 
function doesn't include the columns they need, which means the data model needs 
to support configurable exports before they will reduce spreadsheet use.
```

An insight is not:
- A raw quote ("User said 'I find it confusing'")
- A vague theme label ("Users want simplicity")
- A solution ("We should add an export button")

### 6. Prioritize insights by frequency and severity

Rate each insight:

| Dimension | How to assess |
|-----------|---------------|
| **Frequency** | How many participants exhibited this pattern? (out of N) |
| **Severity** | Does this block task completion, cause errors, or just create friction? |
| **Actionability** | Can the team act on this in the next sprint, quarter, or roadmap? |

Present the top 3–5 insights in the readout. Include the full set in an appendix for stakeholders who want depth.

### 7. Present findings with evidence

Each insight in the readout should include:
- The insight statement
- 2–3 supporting quotes (with participant ID, anonymized if needed)
- Frequency count ("4 of 6 participants…")
- A recommended next step (design direction, further research, or product decision)

Avoid presenting findings as a list of problems without recommendations — research without a clear path forward stalls in stakeholder review.

## Rules

- Do not begin synthesis until all planned sessions are complete — mid-study synthesis biases remaining session facilitation
- Every insight must be traceable to at least 3 observations from at least 2 different participants; single-participant observations are notable but not insights
- Synthesis is a team activity — include at least one non-researcher (PM, designer) in the clustering session to prevent researcher interpretation monopoly
- Never delete raw notes after synthesis — evidence must remain accessible for follow-up questions

## Common Mistakes

- **Summarizing instead of synthesizing**: a session summary ("participant 3 talked about export issues") is not synthesis; synthesis requires cross-session pattern identification
- **Naming clusters after features**: "search", "onboarding", "dashboard" are product areas, not behavioral insights; rename to user behaviors
- **Forcing all notes into clusters**: ungrouped notes that don't fit are valid weak signals; they should be noted, not discarded
- **Writing insights as solutions**: "Users need a better export" is a solution; "Users work around the current export by maintaining external spreadsheets" is an insight
- **Presenting insights without frequency data**: "users find the nav confusing" without a count ("4 of 6 participants") has no credibility with stakeholders

## When NOT to Use

- When the research produced fewer than 3 sessions — too little data for pattern identification; report observations directly and note the limitation
- When the research question is quantitative — survey data requires statistical analysis, not affinity mapping
- When you need to prioritize between insights using business value — combine synthesis output with a prioritization framework (RICE, ICE) rather than trying to embed business logic into synthesis
