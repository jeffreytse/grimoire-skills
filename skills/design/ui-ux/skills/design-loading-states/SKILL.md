---
name: design-loading-states
description: Use when a UI action triggers a wait of 0.1 seconds or more — to communicate system progress, prevent duplicate submissions, and maintain perceived performance.
source: Nielsen "Usability Engineering" response time limits (1993); Facebook/LinkedIn skeleton screen A/B research; Google "The Economic Times of User Experience" (RAIL model)
tags: [loading-states, skeleton-screens, spinners, progress, perceived-performance, ux, ui-patterns]
---

# Design Loading States

Apply the correct loading indicator for each response time range, prevent duplicate submissions, and use skeleton screens to reduce perceived wait time.

## Why This Is Best Practice

**Adopted by:** Facebook introduced skeleton screens (content placeholders that match the layout of loading content) in 2013 and published A/B test results showing improved perceived performance; LinkedIn, Slack, YouTube, and Google Search all use skeleton screens for primary content loading; Google's RAIL model (Response, Animation, Idle, Load) codifies the 0.1s/1s/10s response time thresholds as the industry standard for web performance UX
**Impact:** Facebook and LinkedIn A/B tests comparing skeleton screens to spinners found skeleton screens reduce perceived wait time by 20–30% at identical actual load times; Nielsen (1993) research on response time thresholds established that users lose the feeling of direct manipulation at > 0.1s, lose the sense that the task is proceeding normally at > 1s, and cannot maintain attention without a progress indicator at > 10s — thresholds confirmed by subsequent Google RAIL research
**Why best:** No loading indicator on a slow action causes duplicate submissions (users click again because they believe the first click failed); a generic spinner gives users no information about progress and no ability to cancel; skeleton screens reduce layout shift when content loads and give users a preview of the forthcoming structure

Sources: Nielsen "Usability Engineering" Ch. 5 (Morgan Kaufmann, 1993); Luke Wroblewski "Designing for Loading States" (lukew.com, 2014); Google Developers "RAIL Performance Model" (web.dev); Bojko "Eye Tracking the User Experience" (Rosenfeld Media, 2013)

## Steps

### 1. Select indicator by response time

| Response time | Indicator | Rationale |
|---------------|-----------|-----------|
| < 0.1s | None | Instant; user perceives as direct |
| 0.1–1s | Inline spinner or subtle state change | Brief; spinner communicates "working" |
| 1–4s | Skeleton screen (preferred) or centered spinner | Long enough to notice; skeleton reduces shift |
| 4–10s | Progress bar + percentage or step count | Users need to know how far along the process is |
| > 10s | Progress bar + estimated time + Cancel option | Users need to assess whether to wait or abort |

Default for unknown duration: skeleton screen (preferable to spinner for layout-heavy content); spinner for single values or compact components.

### 2. Disable the triggering element immediately

The moment an action is triggered:
- Disable the button (no re-clicks)
- Show the loading indicator
- Optionally: show optimistic state (act as if success, revert on error)

```html
<!-- on submit: -->
button.disabled = true
button.innerHTML = '<spinner /> Saving…'
```

Failure to disable causes duplicate form submissions, double payments, and conflicting API calls — the most expensive class of loading state bug.

### 3. Implement skeleton screens for content-heavy loads

A skeleton screen is a layout placeholder that mirrors the shape of the incoming content — same number of lines, same rough dimensions, same card/row structure.

**What to show:**
- Gray or muted rectangles for text lines (2/3 width for body, full width for headings)
- Gray rectangles for images
- Animated shimmer gradient moving left to right (signals "loading", not "empty")

**What NOT to show:**
- Actual content that will be replaced (causes flash)
- Exact text placeholders (users try to read them)
- Skeletons that don't match the incoming layout (causes layout shift)

Use skeleton screens when:
- Loading a list, table, or card grid
- Loading a full page route
- Content has a predictable structure

Use spinner when:
- Loading a single value (a count, a price)
- Loading content with unpredictable structure
- Loading in a compact widget where a skeleton would be larger than the content

### 4. Show progress for multi-step or long operations

For operations > 4s or with known steps (file upload, multi-step processing):

```
Uploading: ████████░░░░  67% — 12s remaining   [Cancel]
```

Include:
- Visual progress indicator (bar preferred over percentage alone)
- Percentage or step count ("Step 2 of 4")
- Estimated remaining time when calculable (file upload, known step count)
- Cancel option for operations > 10s — never trap users in a wait they cannot exit

### 5. Handle success and error states after loading

Loading is a transition, not a destination. Plan the states on either side:

**Success:**
- Remove the loading indicator
- Show a brief success confirmation (inline checkmark, toast, or state change)
- Move focus/attention to the next logical step

**Error:**
- Remove the loading indicator
- Show a specific error (not "Something went wrong") — what failed + how to recover
- Re-enable the triggering element so the user can retry

**Timeout:**
- If load exceeds an expected threshold with no response, assume failure
- Show the error state with a retry option — never leave the loading indicator running indefinitely

### 6. Use optimistic UI for low-risk actions

For low-risk, reversible actions (liking a post, adding a tag, reordering items):
- Apply the change immediately in the UI without waiting for the server
- Revert if the server returns an error + show an error message
- Show a subtle "Saving…" indicator if confirmation is important

Optimistic UI eliminates perceived latency for the most common interactions. Do not use for high-risk, irreversible actions (payments, deletions, sending messages).

## Rules

- Never leave a user action with no visual response — even a 0.1s spinner on a fast action is better than a click that appears to do nothing
- Disable the triggering element on activation — duplicate submissions are a loading state failure, not a backend problem
- Never run a loading indicator indefinitely — set a timeout (typically 30s) after which the loading state is replaced with an error state
- Skeleton screens must match the incoming content structure — mismatched skeletons cause layout shift and disorientation
- For operations users cannot cancel (irreversible), do not show a Cancel option — show it only for operations with a clean abort path

## Common Mistakes

- **Spinner with no timeout**: loading spinner that runs until the user refreshes the page; add a timeout → error recovery flow
- **Skeleton that doesn't match content**: showing a 3-line skeleton when 8 lines load causes layout shift; skeleton geometry must match actual content
- **Loading indicator not clearing on error**: spinner stays visible after a failed request; users see "still loading" when the action has failed
- **No loading state on destructive actions**: clicking "Delete" with no visual confirmation of processing causes users to click again; disable immediately
- **Progress bar that jumps to 99% and stalls**: fake progress that stops near completion is worse than a spinner; only use progress bars when real progress is measurable

## When NOT to Use

- For navigation transitions < 0.1s on fast connections — no indicator needed; adding a loading overlay to instant navigation adds visual noise without benefit
- For background operations the user did not trigger — use a notification or badge to surface completion rather than a blocking loading state
- For optimistic UI on irreversible actions — optimistic updates assume success; for payments, sends, and deletes, wait for server confirmation before updating the UI
