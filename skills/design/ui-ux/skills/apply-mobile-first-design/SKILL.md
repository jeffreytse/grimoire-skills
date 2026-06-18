---
name: apply-mobile-first-design
description: Use when designing for multiple screen sizes — to design under mobile constraints first, then progressively enhance for larger viewports, rather than adapting a desktop layout down to mobile.
source: Wroblewski "Mobile First" (A Book Apart, 2011); Google "Mobile-First Indexing" documentation (2019); WCAG 2.1 Success Criterion 1.4.10 Reflow; NNG "Mobile UX Design" (Budiu, 2021)
tags: [mobile-first, responsive-design, progressive-enhancement, thumb-zone, breakpoints, mobile-ux, touch, viewport]
---

# Apply Mobile First Design

Design for 320px viewport and thumb-zone reachability first, make content priority decisions on the constrained canvas, then progressively add layout complexity for wider viewports.

## Why This Is Best Practice

**Adopted by:** Wroblewski's "Mobile First" (A Book Apart, 2011) is the definitive reference — adopted by Ethan Marcotte's responsive design movement, Bootstrap (mobile-first since v3), Tailwind CSS, and all major CSS frameworks; Google "Mobile-First Indexing" (2019) uses mobile Googlebot as primary crawler — mobile UX directly affects search ranking for all sites; WCAG 2.1 Success Criterion 1.4.10 (Reflow) requires content to reflow at 320px without horizontal scroll; Apple HIG and Material Design both specify mobile as the primary design target
**Impact:** Google: mobile accounts for 60% of global web traffic (StatCounter 2023); 85% of users start tasks on mobile and complete on desktop — mobile entry experience determines whether the task continues (NNG 2021); Wroblewski (2011) documents that mobile-first process reduces desktop redesign time by 40% because mobile constraints force content priority decisions that would otherwise be deferred; mobile-first designers produce 30% fewer design iterations overall because content hierarchy decisions are made once on the constrained canvas, not re-made per viewport (Wroblewski, interviews with teams at Google, Facebook, and LinkedIn)
**Why best:** Desktop-first design produces desktop layouts that are adapted down to mobile — adapting down means removing or stacking things that were designed for large-screen display; mobile-first design produces mobile layouts that are enhanced up — adding layout complexity only when the viewport warrants it; "design down" creates a shrunk desktop; "design up" creates a focused mobile that scales intelligently

Sources: Wroblewski "Mobile First" (A Book Apart, 2011); Google "Mobile-First Indexing Best Practices" (developers.google.com, 2023); WCAG 2.1 "1.4.10 Reflow" (W3C, 2018); NNG "Mobile User Experience" (Budiu, 2021)

## Steps

### 1. Start at 320px

Design the mobile layout at 320px viewport width — the minimum size supported by WCAG 2.1 Reflow (SC 1.4.10) and the size of the smallest current iOS device (iPhone SE).

**Why 320px and not 375px:**
375px is the iPhone 14 width. 320px is the floor — designing at 375px and "forgetting" 320px leaves users on older/smaller devices with a broken layout. Design at 320px, verify at 375px, 390px, and 430px (current iPhone sizes).

**320px layout constraints:**
- Maximum content width: 288px (320px minus 16px margins on each side)
- Single-column layout for all content
- No horizontal scroll on the content area
- No side-by-side panels or multi-column grids

### 2. Apply thumb zone analysis

The thumb zone determines which areas of the mobile screen are comfortable to tap without shifting grip:

```
Right-handed thumb zones (320–390px wide phone):

[──────────────────────]  ← Hard to reach (top 30% of screen)
[──────────────────────]  ← Reachable with stretch
[──────────────────────]
[──────────────────────]  ← Easy (bottom 60% of screen)
[──────────────────────]  ← Natural thumb position
[──────────────────────]
[──────────────────────]  ← Easy reach (home area, bottom nav)
```

**Placement rules by thumb zone:**
- **Primary actions** (primary CTA, submit, send): bottom 60% of the viewport — reachable without shifting grip
- **Primary navigation**: bottom nav bar — directly in the thumb's natural arc
- **Secondary actions**: middle of screen — acceptable reach
- **Destructive/dangerous actions** (Delete, Cancel account): top of screen — requires intentional stretch, reducing accidental taps
- **Back navigation**: iOS/Android system back gesture handles this; don't add a redundant software back button at top-left on native mobile

### 3. Enforce minimum tap target size

Tap targets must be large enough to activate reliably with a fingertip:

```
Minimum: 44×44 CSS pixels (Apple HIG, WCAG 2.5.5 Target Size)
Recommended: 48×48 CSS pixels (Material Design)
Spacing between adjacent targets: ≥ 8px to prevent mis-taps

❌ Icon button at 20×20px with no padding → impossible to tap without mis-activation
✅ Icon button at 20×20px visual + 12px padding on all sides → 44×44 tap target
```

**Implementation:**
```css
.icon-button {
  min-width: 44px;
  min-height: 44px;
  display: flex;
  align-items: center;
  justify-content: center;
}
```

The visual size of the element can be smaller than the tap target — padding makes up the difference. The user's tap area extends beyond the visible element boundary.

### 4. Make content priority decisions — remove, don't hide

Mobile-first forces a content priority conversation that desktop-first defers:

```
Desktop-first approach:
  Desktop layout has 6 widgets in the sidebar → adapt to mobile → hide sidebar → 
  now on mobile: "where did the widgets go?" → add hamburger → users never find them

Mobile-first approach:
  Mobile layout: what are the 3 things users NEED here? → design those 3 things →
  Desktop: what additional content earns screen space at 768px+?
```

**The mobile-first content prioritization rule:** If content is hidden on mobile, ask whether it should exist at all. Content hidden by `display: none` on mobile but visible on desktop:
1. Is it needed? If not, remove from the codebase entirely
2. Is it needed by mobile users? If yes, it should not be hidden — restructure the layout to include it
3. Is it genuinely only useful on desktop? Then hiding is justified — but document why

Hidden content that users need is a navigation failure, not a responsive solution.

### 5. Write CSS mobile-first (min-width breakpoints)

Mobile-first CSS uses `min-width` media queries to add complexity at wider viewports:

```css
/* Mobile base (320px+): single column, full width */
.container {
  display: block;
  padding: 0 16px;
}

.sidebar {
  display: none;  /* not available on mobile — content moved to main */
}

/* Tablet (768px+): add sidebar */
@media (min-width: 768px) {
  .container {
    display: grid;
    grid-template-columns: 240px 1fr;
    gap: 24px;
    padding: 0 24px;
  }

  .sidebar {
    display: block;
  }
}

/* Desktop (1024px+): wider layout */
@media (min-width: 1024px) {
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 32px;
  }
}
```

**Common breakpoint scale:**
```
320px   — mobile minimum (design target)
480px   — large mobile
768px   — tablet portrait
1024px  — tablet landscape / small desktop
1280px  — desktop
1440px  — wide desktop
1920px  — max content width (cap layout here; wider is whitespace)
```

Do not add a breakpoint until a layout problem exists at that width. Arbitrary breakpoints at round numbers create maintenance overhead without solving real layout problems.

### 6. Adapt typography for mobile readability

Mobile typography rules differ from desktop:

```
Body text:
  Mobile minimum: 16px (prevents iOS auto-zoom on form focus)
  Desktop: 16–18px
  Never: < 16px for body; < 14px for anything interactive

Line length (characters per line):
  Mobile: 35–50 characters (narrower column = shorter lines = correct)
  Desktop: 50–75 characters
  Never: > 85 characters (requires eye tracking back to left margin)

Line height:
  Body: 1.5–1.6 (same as desktop; do not reduce for mobile)
  Headings: 1.2–1.3
```

**Prevent iOS input zoom:** iOS Safari zooms when a focused input has font-size < 16px. Set `font-size: 16px` on all inputs — or add `touch-action: manipulation` and `font-size: 16px` to the form.

### 7. Test on real devices, not just emulators

80% of mobile UX bugs are invisible in browser emulators (Chrome DevTools device mode). Required real-device tests:

- **Thumb reach**: tap every interactive element with your thumb — does it require grip shift?
- **Text size**: hold the device at normal distance — is body text readable without pinching?
- **Scroll behavior**: does the page scroll smoothly? Any sticky elements blocking the content area?
- **Keyboard interaction**: does the soft keyboard obscure the active input? Does the page reflow correctly after keyboard dismissal?
- **Network**: test on 3G (Chrome DevTools → Network → Slow 3G) — does the critical content appear before the user bounces?

Test on at minimum: current-generation iOS Safari, current-generation Android Chrome, one 2-year-old Android device. Emulators do not replicate iOS Safari's rendering quirks, Android WebView behavior, or touch event handling.

## Rules

- Design at 320px first — never assume 375px is the floor
- Primary CTAs and navigation go in the bottom 60% of the viewport — thumb-reachable
- Minimum 44×44 CSS px tap target for all interactive elements
- Content hidden on mobile must either be removed from the codebase or proven unnecessary for mobile users
- CSS uses `min-width` breakpoints (mobile-first) — not `max-width` (desktop-first adaptation)
- Body font size minimum 16px on mobile — prevents iOS auto-zoom
- Test on real devices — emulators miss 80% of real-device bugs

## Common Mistakes

- **375px as the design floor**: designing at iPhone 14 width (375px) and skipping 320px — leaves users on iPhone SE and some Android devices with horizontal scroll or clipped content; WCAG requires 320px support
- **`display: none` on needed content**: hiding mobile content that users need and labeling it "responsive design" — hidden content is a navigation failure; restructure or remove
- **`max-width` media queries (desktop-first)**: writing base styles for desktop and adding `max-width` breakpoints to shrink — produces more media queries, more specificity conflicts, and a heavier payload for mobile devices that download all CSS
- **48px gap between desktop and mobile**: designing desktop at 1440px, mobile at 375px, and forgetting 768px tablet — tablet portrait is 768px and needs its own layout consideration; the gap between mobile and desktop often produces a broken middle state
- **Testing only in Chrome DevTools**: emulators do not reproduce iOS Safari scroll behavior, sticky element bugs, safe area insets (notch/home indicator), or hardware-specific rendering; always test on a real device before shipping

## When NOT to Use

- Internal desktop-only tools (analytics dashboards, code editors, database admin tools) where mobile access is explicitly not supported and users have consented to desktop-only — applying mobile-first layout constraints to a tool intentionally designed for large screens adds unnecessary complexity
- Progressive web apps with a native mobile app counterpart — if the mobile experience is handled by the native app, the web version can be desktop-first; but document this explicitly and verify mobile users are redirected

