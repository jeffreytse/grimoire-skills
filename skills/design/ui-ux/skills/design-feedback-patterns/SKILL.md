---
name: design-feedback-patterns
description: Use when designing system responses to user actions — form submission, data save, deletion, errors, and confirmations — to tell users what happened, what went wrong, and what to do next.
source: Nielsen "10 Usability Heuristics" Heuristic #1 (1994); NNG "Error Message Guidelines" (Harley, 2018); NNG "Confirmation Dialog Boxes" guideline
tags: [feedback, notifications, error-messages, confirmations, toasts, dialogs, ux, ui-patterns]
---

# Design Feedback Patterns

Map each user action to the right feedback mechanism — inline, toast, modal, or full-page — and write copy that confirms success, explains failure, and offers recovery.

## Why This Is Best Practice

**Adopted by:** Nielsen's Heuristic #1 "Visibility of system status" is the most-cited usability heuristic across all major design systems; Google Material Design, Apple HIG, IBM Carbon, and Shopify Polaris all provide explicit feedback component guidelines (snackbars, alerts, dialogs) with usage rules; Stripe's and GitHub's developer experience teams have published case studies on error message redesigns
**Impact:** NNG analysis finds that 82% of usability problems involve unclear system status — users not knowing if an action succeeded, failed, or is in progress; NNG "Error Message Guidelines" (2018) documents that error messages explaining cause + resolution reduce support tickets by 40–50% vs generic "An error occurred" messages; Stripe's redesign of API error messages reduced developer support contacts by 35%
**Why best:** Users make decisions based on perceived system state — no feedback after a click causes re-clicks and duplicate submissions; generic success messages ("Done!") don't confirm what was done; generic error messages ("Something went wrong") don't tell users what to do — all three outcomes require support escalation that a well-designed feedback response would have avoided

Sources: Nielsen "10 Usability Heuristics" (1994); NNG "Error Message Guidelines" (Harley, 2018); NNG "Indicators, Validations, and Notifications: Pick the Correct Communication Option" (Rosala, 2021); Stripe Design "Error Messages" (stripe.dev)

## Steps

### 1. Map actions to feedback types

Select the feedback mechanism based on severity, reversibility, and required attention:

| Action type | Feedback mechanism | Rationale |
|-------------|-------------------|-----------|
| Non-destructive save / background sync | Toast / snackbar (auto-dismiss, 3–5s) | Confirms without interrupting |
| Destructive action (delete, remove) | Confirmation modal (before) + toast (after) | Requires conscious approval |
| Form submission — success | Inline success or page redirect | Confirms the form completed |
| Form submission — validation error | Inline field error (immediate) | Localizes error to the field |
| System error (load failure, server error) | Inline error + retry CTA | Explains failure + recovery path |
| Permission or access denied | Full page or inline explanation + CTA | Needs context, not just a snackbar |
| Long operation complete (async) | Persistent notification or badge | User may have left the view |

### 2. Write success feedback

Success messages must confirm the specific action — not just "Done":

```
❌ "Success!"
❌ "Done!"
✅ "Invoice sent to maya@company.com"
✅ "Settings saved"
✅ "Project deleted"
```

After confirmation, move the user forward:
- A background save: no redirect needed; toast is sufficient
- A form submission: redirect to the created/updated item or a relevant next step
- A completed process: offer a clear next action (view result, share, continue)

### 3. Write error messages

Every error message must include three parts:

1. **What failed** — specific, not generic
2. **Why it failed** — if knowable without exposing system internals
3. **How to recover** — a concrete next step

```
❌ "An error occurred."
❌ "Something went wrong. Please try again."
✅ "Couldn't send the invoice — maya@company.com isn't a valid email address. Check the address and try again."
✅ "Couldn't save your changes. Your session expired. [Sign in again]"
✅ "File too large. Maximum size is 10 MB. [Compress the file] or [Upload a different file]"
```

**Tone:** factual, not apologetic. "We couldn't save your changes" is cleaner than "We're so sorry, something went wrong and we couldn't save your changes."

### 4. Design confirmation dialogs for destructive actions

Never use a toast or snackbar to confirm a destructive action — the action must be interrupted before execution:

```
Dialog structure:
  [Title]   Delete "Q3 Report"?
  [Body]    This will permanently delete the report and all its data.
            This cannot be undone.
  [Actions] [Cancel]  [Delete]  ← destructive action is secondary/danger-styled
```

Rules for confirmation dialogs:
- Title states the action + the specific item affected — not "Are you sure?"
- Body describes the consequence — "This cannot be undone" is essential for permanent deletions
- Destructive button is right-aligned, danger-styled (red), and labeled with the verb ("Delete", "Remove") — never "OK" or "Yes"
- Cancel is always available and is the default (press Escape to cancel)

### 5. Design inline validation for forms

Real-time validation reduces form abandonment:

- **Validate on blur** (when user leaves a field), not on keystroke — keystroke validation marks fields as errors before the user finishes typing
- Show the error adjacent to the field — not in a banner at the top of the form
- Write specific error messages per validation rule:

```
❌ "Invalid input"
✅ "Password must be at least 8 characters" (length rule)
✅ "Phone number must be 10 digits" (format rule)
✅ "This email is already registered. [Sign in instead]" (conflict)
```

- On submission with errors: scroll to the first error, focus it, and announce via ARIA live region for screen readers

### 6. Offer undo for reversible destructive actions

Where technically feasible, prefer undo over confirmation dialogs for reversible actions:

```
Toast:  "Report deleted"  [Undo]  ×  (5s to undo)
```

Undo + auto-dismiss reduces the friction of destructive actions without sacrificing safety. Gmail's delete and archive interactions pioneered this pattern. Use confirmation dialogs when the action is genuinely irreversible (permanent deletion, sent messages).

## Rules

- Every user action must produce visible feedback within 0.1s — even if it's just a loading state (see `design-loading-states`)
- Destructive actions always require explicit confirmation before execution — never after
- Error messages must name the specific failure — never "Something went wrong" as the final message
- Inline field errors appear on blur, not on keystroke, and are field-adjacent — not top-of-form banners
- Toast/snackbars auto-dismiss in 3–5s and are for low-priority confirmations only — errors, confirmations for destructive actions, and alerts that require reading must not auto-dismiss

## Common Mistakes

- **Snackbar for destructive action confirmation**: "Item deleted" in a toast after deletion with no undo — user has no way to recover; use undo or require pre-confirmation
- **Generic error with no recovery**: "Error 500" or "Something went wrong" with only a Close button; always provide a recovery path (retry, contact support, go back)
- **Validation on every keystroke**: marking a password field as "too short" while the user is still typing creates false error states that frustrate users; validate on blur
- **Confirmation dialog for non-destructive actions**: "Are you sure you want to save?" for a settings change that can be changed again at any time — unnecessary friction; reserve confirmation dialogs for irreversible actions
- **Success toast that doesn't name the entity**: "Saved!" after editing one of ten open items — users can't confirm which item was saved; be specific

## When NOT to Use

- For real-time collaboration updates (another user edited the document) — use presence indicators and live cursors rather than toast notifications, which would flood the interface
- For system-level alerts unrelated to user action (session about to expire, maintenance window) — use a persistent banner or modal, not action feedback patterns
- For progress on background operations the user triggered but has since navigated away from — use a notification center or badge, not a toast that appears mid-task
