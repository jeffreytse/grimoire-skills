---
name: apply-progressive-disclosure
description: Use when a feature, form, or settings panel has more complexity than most users need — to show only what the current step requires and reveal additional options on demand.
source: NNG "Progressive Disclosure" (Nielsen, 2006); Miller "The Magical Number Seven" (Psychological Review, 1956); Apple HIG "Progressive Disclosure" pattern; Google Material Design "Revealing additional content"
tags: [progressive-disclosure, cognitive-load, ux, forms, information-architecture, complexity-management, ui-patterns]
---

# Apply Progressive Disclosure

Show only the options and information required for the primary task. Reveal additional complexity — advanced settings, optional fields, secondary actions — only when the user requests or needs it.

## Why This Is Best Practice

**Adopted by:** Apple HIG codifies progressive disclosure as a core interaction pattern and applies it throughout macOS and iOS (Advanced settings in dialogs, More options in action sheets); Google Material Design uses progressive disclosure in its expansion panel and bottom sheet patterns; Salesforce, Figma, and Linear each apply progressive disclosure in their settings and configuration UIs to manage feature complexity without overwhelming new users
**Impact:** NNG (2006) reports that progressive disclosure reduces task completion time by 20–40% for first-time users on complex forms and settings screens, compared to fully-exposed layouts; Miller's (1956) working memory research establishes 7±2 (now revised to ~4±1 by Cowan 2001) as the cognitive limit for simultaneously held items — interfaces that surface all options at once routinely exceed this limit; Apple's own HIG cites progressive disclosure as a key contributor to the "learnability" of its platforms
**Why best:** Feature parity with a power user audience should not come at the cost of first-time user experience; a fully-exposed interface is the designer's mental model, not the user's — progressive disclosure presents the user's mental model first and reveals the designer's model on demand; the alternative (exposing everything at once) is equivalent to providing an API reference manual as onboarding documentation

Sources: NNG "Progressive Disclosure" (Nielsen, 2006); Miller "The Magical Number Seven, Plus or Minus Two" (Psychological Review, 1956); Cowan "The magical number 4 in short-term memory" (Behavioral and Brain Sciences, 2001); Apple HIG "Progressive Disclosure" (developer.apple.com)

## Steps

### 1. Identify novice vs. expert tasks

For each feature, list all possible actions and options. Classify each as:

- **Primary** — needed by most users, most of the time (always visible)
- **Secondary** — needed by some users or in specific contexts (reveal on demand)
- **Advanced** — needed rarely, by power users or edge cases (hidden by default, accessible via Advanced settings)

Example — a file export dialog:
```
Primary (always show):   File format (PDF, PNG, SVG)
                         File name field
                         [Export] button

Secondary (on expand):   Resolution/DPI setting
                         Color profile (sRGB, CMYK)
                         Compression quality

Advanced (rare):         Custom ICC profile
                         Metadata embedding options
```

### 2. Choose the disclosure pattern

| Pattern | When to use |
|---------|-------------|
| **Expand/collapse** | Settings panels, FAQ accordions, detail rows in tables |
| **"Advanced options" toggle** | Form dialogs with optional technical settings |
| **Progressive wizard/stepper** | Multi-step flows where later steps depend on earlier choices |
| **Tab groups** | When secondary content is large enough to warrant a full panel |
| **Contextual reveal** | Show additional fields only when a checkbox or toggle is selected |

**Contextual reveal example:**
```
[ ] Send confirmation email
    ↓ (shows when checked)
    Email address: ___________
    Subject line:  ___________
```

Showing an email address field before the "send email" checkbox is checked — and hiding it — reduces the visible field count without removing the feature.

### 3. Apply the 4-item rule for menus and option lists

Limit primary-level menus and option groups to 4–7 items. When a list exceeds 7 items:
- Group related items under a sub-heading or sub-menu
- Move low-frequency items to a secondary level
- Use a "More" or "Other" disclosure control for the tail

A dropdown with 20 options is a classification problem masquerading as a UI problem — classify before displaying.

### 4. Never hide required fields

Progressive disclosure applies only to optional, contextual, or advanced content. Required fields for completing the primary task must always be visible.

Rules:
- Required form fields: always visible
- Optional form fields: acceptable to hide behind "Add optional details" if they are genuinely rarely used
- Fields that become required based on another selection: reveal immediately when the selecting condition is met (contextual reveal)

### 5. Make the disclosure control obvious

The control that reveals additional content must be immediately recognizable:

- Label it explicitly: "Advanced options", "More settings", "Show N more"
- Use a chevron or arrow icon to indicate expand/collapse state
- Show the count of hidden items when quantity is meaningful: "3 more options"
- Never hide the disclosure control itself — a toggle that only appears on hover is itself a progressive disclosure violation

### 6. Preserve state across disclosure

When a user expands an advanced section and sets values, those values must be preserved if the section is collapsed and re-expanded. Collapsing a section should not reset the values within it — the collapse is a display choice, not a clear.

### 7. Test with first-time users

The test for progressive disclosure is the first-time user completing the primary task:
- Can they complete the primary task without encountering the advanced section?
- If they accidentally reveal the advanced section, can they close it without disrupting their task?
- Do they feel uncertain that a required option is hidden?

If users feel like they're missing something hidden in the advanced section, primary/secondary classification needs to be revisited.

## Rules

- Required fields and primary actions are never hidden — progressive disclosure applies to optional and secondary content only
- The disclosure control must always be visible — it must not require hover or a specific sequence of actions to appear
- Expanded state must be preserved — collapsing a section does not reset its values
- Apply the 4–7 item limit before reaching for progressive disclosure — if a menu has 5 items, progressive disclosure adds overhead without benefit; use it only when the full set clearly exceeds working memory limits
- Progressive disclosure is not a substitute for good information architecture — if secondary content is always needed, the primary/secondary classification is wrong

## Common Mistakes

- **Hiding required fields**: putting a required field under "Advanced options" because it feels technical — users will miss it and submit incomplete forms; if it's required, it must be primary
- **Unlabeled disclosure controls**: a chevron with no label next to a form section — users don't know if expanding it adds required fields or optional ones; label it
- **Resetting values on collapse**: a user sets "DPI: 300" in Advanced, collapses the section, then re-opens it to find "DPI: 72" — disclosure must be display-only, not a reset mechanism
- **Progressive disclosure for 5 items**: adding "Advanced options" to a form with 6 total fields, hiding 1 — the overhead of disclosure is not worth hiding a single field; use it when the secondary set is 3+ items that are genuinely rarely needed
- **Disclosure as a workaround for poor IA**: using advanced options to hide a conceptually primary feature because it "feels advanced" — if users frequently open the section, it belongs in the primary view

## When NOT to Use

- When the secondary content is needed by > 50% of users on > 50% of sessions — frequency of use disqualifies it from progressive disclosure; make it primary
- When the primary and secondary content are equally important and of similar complexity — use tabs or a multi-step wizard instead; progressive disclosure implies a clear hierarchy that doesn't exist here
- For mobile navigation menus — progressive disclosure in navigation (hamburger + sub-menus) adds tap depth that slows navigation on mobile; prefer a flat bottom nav or tab bar for primary navigation
