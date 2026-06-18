---
name: design-research-plan
description: Use when starting any user research study — to define the research question, select methods, write a participant screener, and set a timeline before recruiting begins.
source: NNG "UX Research Cheat Sheet" (Nielsen, 2017); IDEO Human-Centered Design Toolkit (IDEO.org, 2015); Google Ventures Research Sprint guide
tags: [user-research, research-planning, ux, screener, methods, study-design]
---

# Design Research Plan

Write a one-page research plan that aligns the team on what questions the study will answer, which method fits those questions, and who to recruit — before a single participant is contacted.

## Why This Is Best Practice

**Adopted by:** Google Ventures mandates a written research plan before every sprint research day; IDEO's HCD Toolkit requires a "learning goals" document as the first step in all field research; Nielsen Norman Group's UX research training treats the research plan as the non-negotiable foundation of any credible study
**Impact:** NNG research shows that teams without a written plan collect data that answers the wrong question in the majority of studies — the most expensive research mistake because it is only discovered after sessions are complete and cannot be fixed retrospectively; a plan reviewed by stakeholders before recruiting eliminates post-study scope disputes and prevents "we should have asked about X" regret
**Why best:** Ad-hoc research — starting with recruiting before aligning on questions — produces data that is hard to act on; different team members leave sessions with different interpretations of what was learned; a written plan is the contract between the research team and stakeholders that prevents both under-scoping (missing key questions) and over-scoping (trying to answer everything in one study)

Sources: NNG "UX Research Cheat Sheet" (Nielsen Norman Group, 2017); IDEO "The Field Guide to Human-Centered Design" (IDEO.org, 2015); Goodman, Kuniavsky & Moed "Observing the User Experience" (Morgan Kaufmann, 2012) Ch. 3

## Steps

### 1. Write the research question

One sentence. Not a business question ("should we build this?") and not a solution ("how do we improve checkout?") — a behavioral or attitudinal question about users:

```
What are the primary reasons users abandon the checkout flow before entering payment information?
```

Gates:
- Cannot be answered with existing analytics alone → user research is needed
- Specific enough that you will know when it is answered
- Does not presuppose the answer ("why do users dislike X?" presupposes they dislike it)

If the team cannot agree on one research question, run a 20-minute alignment session to prioritize — multiple competing questions signal a scope problem, not a research plan problem.

### 2. Select the method

| Question type | Method |
|---------------|--------|
| Why do users behave a certain way? | User interviews |
| Can users complete tasks on the interface? | Usability testing |
| What do users do in their natural environment? | Contextual inquiry / diary study |
| How do users mentally organize a topic? | Card sorting |
| What are users' attitudes at scale? | Survey |
| Which of two designs performs better? | A/B test |

One method per study. If multiple question types are present, split into multiple studies or prioritize the highest-risk unknown.

### 3. Define participant criteria

Write a screener with three sections:

**Qualifying criteria** — must-haves that define the target user:
- Role, behavior, or context (not just demographics)
- Example: "Has made an online purchase in the last 30 days"

**Disqualifying criteria** — exclude anyone who would skew results:
- Competitors, researchers, UX practitioners (familiarity bias)
- People who work at your company

**Desired mix** — diversity factors relevant to your question:
- Experience level (novice vs. power user)
- Device type (mobile vs. desktop) if relevant
- Frequency of the behavior being studied

### 4. Set participant count

| Method | Recommended count |
|--------|-----------------|
| Interviews | 5–8 per distinct user segment |
| Usability testing (formative) | 5 per segment |
| Usability testing (summative) | 20+ for statistical validity |
| Card sorting | 15–20 |
| Survey | 100+ for quantitative analysis |
| Contextual inquiry | 5–8 |

More participants are not always better for qualitative methods — the 5-user rule (Nielsen, 1993) applies to formative usability testing; diminishing returns set in quickly for interviews.

### 5. Build the timeline

```
Week 1: Finalize plan + screener → stakeholder review
Week 2: Recruit participants (allow 5–7 business days minimum)
Week 3: Run sessions (1–2 per day max to preserve researcher quality)
Week 4: Synthesize findings → readout
```

Buffer for: no-shows (recruit 20% more than needed), scheduling conflicts, pilot session rescheduling.

### 6. Address consent and legal requirements

- Prepare consent form covering: recording permission, data usage, anonymization
- Check if incentive requires legal/finance approval (typically ≥$50 USD)
- For healthcare, financial, or children's products: flag for compliance review before recruiting
- Store session recordings in accordance with your data retention policy

### 7. Get stakeholder sign-off

Share the one-page plan with PM, design lead, and any stakeholder who will act on findings. Require explicit sign-off before recruiting begins. The questions they add or remove at this stage cost nothing; the questions they add after sessions end cost another full round of research.

## Rules

- One research question per study — if stakeholders push for more, negotiate which is highest priority or plan sequential studies
- Write the screener before recruiting; never recruit first and write criteria after
- Never recruit from your internal user panel exclusively — familiarity with your product biases results
- Pilot every study (one session with a colleague) before running real participants
- Do not start recruiting before the discussion guide or task scenarios exist — schedule conflicts will force you to run unprepared

## Common Mistakes

- **Research question is a business question**: "Should we redesign the nav?" is a decision, not a research question. Reframe: "What tasks do users attempt in the nav that they fail to complete?"
- **Screener is too permissive**: "Anyone who uses apps" recruits the wrong people; be specific about the behavior you're studying
- **No buffer for no-shows**: participants cancel; always recruit 20–30% more than the target count
- **Skipping stakeholder alignment**: stakeholders who don't see the plan until the readout will question the findings or ask for follow-up research on questions the plan could have included

## When NOT to Use

- When the research question can be answered with existing analytics, support tickets, or NPS data — run a desk research pass first; quantitative data may already answer the question
- When the team is mid-sprint and needs a decision in 24 hours — use a 2-hour guerrilla testing session instead of a full planned study
- When no change budget exists to act on findings — research without action is waste; confirm the team can act before investing in a study
