---
name: run-team-health-check
description: Use when a manager wants to periodically assess team effectiveness across multiple dimensions — trust, clarity, collaboration, workload, and psychological safety — so that problems are identified through data before they surface as attrition, conflict, or missed delivery.
source: Spotify "Squad Health Check Model" (Kniberg & Oskarsson, 2014); Google Project Aristotle (2016) team effectiveness factors; Lencioni "The Five Dysfunctions of a Team" assessment framework (2002)
tags: [team-health, team-assessment, psychological-safety, team-effectiveness, retrospective, wellbeing, manager, organizational-health]
---

# Run Team Health Check

Administer a periodic structured assessment of team health across key dimensions — trust, clarity, workload, collaboration, and inclusion — to surface problems early through data rather than waiting for attrition, conflict, or missed goals to reveal them.

## Why This Is Best Practice

**Adopted by:** Spotify's Squad Health Check Model (2014) is the most widely replicated team health assessment in the technology industry, adopted by Zalando, ING, Autodesk, and hundreds of engineering organizations; Google's Project Aristotle (2016) established five team effectiveness dimensions that became the basis for Google's own team health assessment tools; Lencioni's "Five Dysfunctions" assessment has been administered to hundreds of thousands of teams globally and is one of the most widely used team diagnostics in business; the US Army's Command Climate Survey is the military equivalent — mandatory at all echelons above company level
**Impact:** Spotify's internal data on health check adoption found that teams running quarterly health checks identified and resolved team dysfunction 60% faster than teams relying on manager observation alone (Kniberg retrospective, 2015); Google Project Aristotle found that psychological safety — one health dimension — explained more variance in team performance than any other single factor; McKinsey's Organizational Health Index (45,000+ organizations assessed) found that companies in the top quartile of organizational health generate 3× total return to shareholders compared to bottom-quartile companies
**Why best:** Manager observation is a lagging indicator — by the time a manager observes a team health problem, it has usually been present for weeks or months; team members who are experiencing a problem are often reluctant to raise it to their manager (especially if the manager is part of the problem); a structured, anonymous health check creates a direct channel for team health data that bypasses the social dynamics that suppress candid manager feedback

Sources: Kniberg & Oskarsson "Spotify Squad Health Check Model" (2014, engineering.atspotify.com); Google Project Aristotle (rework.withgoogle.com, 2016); Lencioni "The Five Dysfunctions of a Team" (Jossey-Bass, 2002); McKinsey Organizational Health Index (mckinsey.com/capabilities/people-and-organizational-performance)

## Steps

### 1. Choose the dimensions to assess

Base the health check on dimensions relevant to team performance in your context. Six core dimensions applicable to most teams:

| Dimension | What it measures |
|---|---|
| **Psychological safety** | Do team members feel safe to speak up, admit mistakes, and disagree? |
| **Clarity of goals** | Does the team understand what it is working toward and why? |
| **Workload sustainability** | Is the current pace sustainable over the next 90 days? |
| **Collaboration quality** | Does the team work well together — internally and cross-functionally? |
| **Feedback and growth** | Do team members receive meaningful feedback and development support? |
| **Trust and inclusion** | Do all team members feel respected, heard, and treated fairly? |

Adapt these to your team's specific context. Engineering teams might add "technical health"; customer-facing teams might add "customer feedback responsiveness."

### 2. Design the assessment — anonymous, simple, fast

**Format**: a simple rating scale per dimension (3-point or 5-point works; avoid 10-point scales that produce false precision)

Use a 3-option health indicator (adapted from Spotify's model):
- **Green**: This is working well — I'd rate this as healthy
- **Yellow**: This has some issues — it's okay but could be better
- **Red**: This is a real problem — we need to fix this

Add one open-text field per dimension: "What's one thing that would improve this?" — this produces the actionable signal.

**Anonymous**: use a survey tool (Google Forms, Typeform, Culture Amp) with no identifying fields. If employees don't trust anonymity, they will not be candid. Announce the tool and explain that results are aggregated before you see them.

**Fast**: 6 dimensions × 1 rating + 1 optional text field = 10–12 minutes maximum. Longer assessments produce lower completion rates and lower quality answers (fatigue bias).

### 3. Establish a baseline and run quarterly

The first health check establishes the baseline — your reference point for all future comparison. Without it, you cannot distinguish improvement from decline.

Run the same assessment every quarter at the same point in the cycle (e.g., end of each quarter). Consistency enables trend analysis:
- A dimension that was yellow for 3 consecutive quarters without improvement indicates a structural problem, not a temporary one
- A dimension that moved from red to green after a specific intervention validates that intervention

Do not change the assessment instrument between cycles unless a dimension is no longer relevant — changes break trend comparison.

### 4. Share results with the team — not just to yourself

The most common health check failure: the manager receives results and acts on them without sharing them with the team. This produces:
- No collective accountability for the problems identified
- No team input into the actions taken
- Employee cynicism when they see no change after completing the survey

Share results in a team meeting within 1 week of collection:
```
"Here are this quarter's health check results. These are the aggregated 
team responses — not individual. I want to walk through them with you 
and hear your perspective on what they mean and what we should do about them."
```

One dimension per 10 minutes: show the ratings distribution, share the text comments (aggregated and anonymized), and open discussion.

### 5. Prioritize 1–2 dimensions for action — not all of them

If the health check surfaces 4 dimensions in the yellow or red range, the team cannot address all 4 effectively in one quarter. Attempting to fix everything produces thin, ineffective interventions across all dimensions.

Pick the 1–2 dimensions with the highest team pain + highest manager influence:

**Prioritization criteria:**
- Highest pain: which dimension, if improved, would have the biggest positive impact on team effectiveness and wellbeing?
- Highest controllability: which dimension is most within the team's and manager's power to change? (Some health problems trace to organizational factors outside the team's control — do not prioritize these for team-level action; escalate them to leadership instead)

For each priority dimension, define 1–2 specific behavioral actions. The action must be: specific enough to observe, owned by someone, due in the next 90 days.

### 6. Open the next health check by reviewing last quarter's actions

As with retrospectives: accountability closes the loop. Every health check session opens with:

```
"Last quarter, we committed to [actions]. Here's what happened:
- [Action A]: completed / not completed. Why?
- [Action B]: completed / not completed. Why?
```

This prevents the survey from becoming performative. If 3 consecutive rounds of actions produce no change on a dimension, the problem is structural and requires a different intervention than behavioral commitments — escalate to leadership, change the team's structure, or acknowledge that this dimension requires organizational change beyond the team's control.

## Rules

- Anonymous collection is non-negotiable — if employees distrust anonymity, health check data reflects what is safe to say rather than what is true; use a tool that enforces aggregation before manager access
- Share results with the team within one week — data held only by the manager does not create collective accountability or collective action; the team must see what the team said
- Prioritize 1–2 dimensions, not all — shallow intervention across all problems is worse than deep intervention on 1–2; pick the highest pain + highest controllability
- Open the next check by reviewing last quarter's commitments — without this accountability loop, the health check becomes a survey no one believes will change anything
- Run quarterly, not ad hoc — trend data across consistent cadence is what distinguishes structural problems from situational variation

## Common Mistakes

- **Annual health checks**: an annual assessment arrives too late to prevent structural problems from calcifying; quarterly rhythm catches drift while it is still correctable.
- **Non-anonymous collection**: even with the best intentions, employees who see their name on the survey self-censor; true anonymity requires a technical guarantee, not a social one.
- **Manager keeps results private**: survey data that only the manager sees produces manager-led action without team understanding; this undermines the team's own agency to improve.
- **Responding to every dimension with an action**: action on 5 dimensions simultaneously produces 5 half-interventions that none of the team can track or hold accountable; limit to 1–2 priorities per quarter.
- **Running the health check without psychological safety infrastructure**: health checks in psychologically unsafe teams produce optimistic ratings (fear of honest negative assessment); build safety first (see `build-psychological-safety`), then run assessments.

## When NOT to Use

- During a team crisis or major delivery crunch — health check responses gathered during extreme stress reflect the crisis, not the baseline; run after the pressure resolves.
- As a substitute for direct conversation — when a specific team dynamic problem is visible and known, address it directly (see `resolve-team-conflict`, `run-difficult-conversation`) rather than waiting for a quarterly assessment to surface it through survey data.
