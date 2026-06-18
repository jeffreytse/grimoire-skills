---
name: run-user-interview
description: Use when conducting one-on-one sessions with users to understand their goals, behaviors, mental models, and pain points — before designing a solution or after encountering an unexplained usage pattern.
source: Portigal "Interviewing Users" (Rosenfeld Media, 2013); NNG "User Interviews" guideline; IDEO HCD Toolkit field research methods
tags: [user-research, interviews, qualitative-research, ux, discovery, user-needs]
---

# Run User Interview

Run a structured one-on-one conversation with a user to surface behavioral patterns, mental models, and unmet needs that analytics and surveys cannot capture.

## Why This Is Best Practice

**Adopted by:** IDEO, Google Ventures, Airbnb, Intercom, and Basecamp all use semi-structured user interviews as the primary qualitative discovery method; IDEO's HCD Toolkit positions field interviews as the foundation of all human-centered design work; Google Ventures' sprint process reserves a full day for structured user interviews before any design decisions
**Impact:** Portigal (2013) documents that structured probing techniques ("tell me more", "what did you mean by…") uncover behavioral context that unstructured conversation misses 70% of the time; NNG's landmark 1993 research showed 5 users surface 85% of core usability and attitudinal patterns — making interviews high-ROI even at small scale
**Why best:** Surveys collect attitudes at scale but cannot probe the "why"; usability tests reveal task-level friction but not the broader job-to-be-done context; only interviews surface the stories, workarounds, and language users use to describe their own problems — the raw material for insight

Sources: Portigal "Interviewing Users" (Rosenfeld Media, 2013); NNG "When to Use Which User-Experience Research Methods" (Rohrer, 2014); IDEO "The Field Guide to Human-Centered Design" (IDEO.org, 2015)

## Steps

### 1. Write the discussion guide

A discussion guide is a list of topics and seed questions — not a rigid script. Structure:

```
Introduction (5 min)
  - Researcher intro + consent reminder
  - "There are no right or wrong answers — we're learning from you"

Warm-up (5–10 min)
  - Background questions: role, context, how they spend their day
  - Goal: relax the participant; establish rapport

Core topics (25–35 min)
  - 3–5 open-ended topic areas, each with 1–2 seed questions
  - Leave 5–8 min per topic for follow-up probing

Closing (5 min)
  - "Is there anything important I didn't ask about?"
  - Thank, remind of incentive and next steps
```

**Writing open questions:**
- Start with "Tell me about…", "Walk me through…", "Describe a time when…"
- Never start with "Would you…", "Do you…", "Is it…" (yes/no answers close conversations)
- Never ask "Why do you think we should…" (leading)

### 2. Prepare logistics

- Confirm recording permission in the consent form (audio at minimum; video if insight needs body language)
- Assign roles: one facilitator (asks questions), one note-taker (documents observations, not interpretations)
- If remote: test screen share, audio, and recording before the first session
- Send a calendar invite with a Zoom/Meet link + a reminder 24h before

### 3. Run the warm-up

Open with low-stakes questions that establish the participant as the expert:

```
"Tell me a bit about your role and what a typical day looks like for you."
"How long have you been [doing the behavior we're researching]?"
```

Do not mention the product or your company's hypotheses during warm-up. Let the participant's frame emerge before introducing yours.

### 4. Explore core topics with probing

For each topic area, ask the seed question, then follow the participant — do not rush to the next topic.

**Probing techniques:**

| Signal | Probe |
|--------|-------|
| Vague claim ("It's confusing") | "Tell me more about what made it confusing." |
| Implicit assumption ("I just do it the normal way") | "What's the normal way for you?" |
| Emotional response (frustration, enthusiasm) | "It sounds like that was frustrating — what happened?" |
| Shortcut or workaround revealed | "You mentioned you use a spreadsheet for that — walk me through how that works." |
| General statement ("People always…") | "Can you give me a specific example of when that happened?" |

**The 3-second rule:** After the participant stops speaking, wait 3 seconds before responding. Silence prompts elaboration; filling silence cuts it off.

### 5. Capture observations (not interpretations)

The note-taker records:
- **Quotes** — exact words, in quotation marks
- **Behaviors** — what the participant did (showed a workaround, pulled out their phone, hesitated)
- **Emotional signals** — laughter, frustration, tone shift
- **NOT interpretations** — "participant doesn't understand the nav" is an interpretation; "participant said 'I never know where to find my orders'" is an observation

Use a simple grid: one row per notable moment, columns: timestamp | quote/behavior | topic area.

### 6. Avoid leading and confirming questions

Leading questions bias toward your hypotheses:
- ❌ "Do you find the checkout process frustrating?" → biases toward yes
- ✅ "Walk me through the last time you completed a purchase."

Confirming questions seek validation, not truth:
- ❌ "So you'd use this feature if we built it?" → social desirability bias
- ✅ "Tell me about the last time you needed to do [job]."

### 7. Close and debrief

End with: "Is there anything you think is important that I didn't ask about?"

Immediately after the session (before the next), the facilitator and note-taker spend 10 minutes debriefing:
- Top 3 surprising observations
- Any quotes that directly support or contradict a current hypothesis
- Gaps to probe in remaining sessions

### 8. Run 5–8 sessions per segment

Stop adding participants when new sessions stop introducing new themes (theoretical saturation). For most exploratory questions, 5–8 interviews per distinct user segment is sufficient. Run sessions on consecutive or near-consecutive days to retain context for synthesis.

## Rules

- The facilitator never agrees or disagrees with the participant's opinions during the session — neutral acknowledgment only ("that's helpful, tell me more")
- Never read the discussion guide question-by-question like a survey; it's a map, not a script
- Never bring a prototype or product to an interview unless the purpose is prototype feedback — artifacts constrain the conversation to the artifact
- The note-taker does not ask questions during the session; notes only
- Start recruiting only after the discussion guide exists — time pressure produces leading questions when the guide is written mid-recruiting

## Common Mistakes

- **Leading with solutions**: showing a mockup in a discovery interview anchors the conversation to your assumptions instead of theirs
- **Not probing general statements**: "I use it all the time" or "it's pretty easy" are not data; probe for specific instances
- **Interpreting in real time**: notes that say "user is confused" instead of quoting what the user said make synthesis impossible
- **Running interviews alone**: without a dedicated note-taker, the facilitator both misses observations and writes notes that interrupt probing
- **Recruiting internal users or colleagues**: familiarity with the product and desire to be helpful distort responses

## When NOT to Use

- When you need statistical confidence about what percentage of users hold an attitude — use a survey with sufficient sample size
- When you need to observe actual task completion — use usability testing; interviews produce self-reported behavior which diverges from actual behavior
- When the product is already built and the question is purely metric — use analytics or A/B testing
