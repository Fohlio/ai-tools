---
name: ai-tools:visual-poc
description: Generates a standalone visual POC (HTML/CSS/JS) from documentation, acceptance criteria, or PRD. Use when the user wants to see how a feature looks before building it, validate UI/UX assumptions, or create an interactive prototype for stakeholder review.
---

# Visual POC Generator Skill

## When to Use This Skill

- User provides a PRD, AC, or documentation and wants to see the UI before building
- User wants a clickable prototype to validate UX flow
- User needs a visual reference for stakeholder alignment
- User says "show me what this looks like" or "mock this up" or "prototype this"
- Before committing to full implementation, need to prove the UI concept works

## Output

A single self-contained HTML file (or a small set of files) that:
- Opens directly in any browser — no build step, no dependencies
- Uses only vanilla HTML, CSS, and JS
- Looks polished enough to demonstrate the concept (not wireframe-level)
- Includes interactive states where the AC describes them (hover, click, toggle, form input)
- Uses realistic placeholder content — not "Lorem ipsum" but domain-appropriate text

## Procedure

### Step 1: Parse the Input

Read the provided documentation / AC / PRD and extract:

```
1. SCREENS — what distinct views or pages are described?
2. COMPONENTS — what UI elements appear (forms, tables, cards, modals, nav, etc.)?
3. STATES — what interactive states exist (empty, loading, filled, error, success)?
4. FLOW — what is the user journey through the screens?
5. DATA SHAPE — what data is displayed (field names, types, example values)?
6. CONSTRAINTS — responsive? dark mode? accessibility requirements? brand colors?
```

Present a brief summary to the user:
```
Screens: [list]
Key components: [list]
Interactive states: [list]
Flow: Screen A → Screen B → ...
Assumptions: [anything inferred that wasn't explicit]
```

### Step 2: Choose Architecture

| Complexity | Approach |
|------------|----------|
| Single screen, few components | One HTML file with embedded `<style>` and `<script>` |
| Multiple screens, shared layout | One HTML file with JS-driven view switching (SPA-style) |
| Complex multi-page flow | Small folder: `index.html` + `styles.css` + `app.js` |

**Always prefer fewer files.** A single HTML file is ideal.

### Step 3: Build the Visual POC

```
Rules:
- Vanilla HTML/CSS/JS only — no frameworks, no CDN dependencies, no build tools
- Self-contained — must work when opened as a local file (file:// protocol)
- Modern CSS — use flexbox/grid, custom properties, clamp(), container queries where useful
- Semantic HTML — proper elements (nav, main, section, article, dialog, etc.)
- Realistic content — use domain-appropriate placeholder text and plausible data
- Interactive — wire up clicks, hovers, form inputs, toggles described in the AC
- State management — use simple JS to switch between states (empty/loading/filled/error)
- Responsive — mobile-first unless the AC specifies desktop-only
- Accessible basics — proper contrast, focus states, aria-labels on interactive elements
- Visual polish — subtle shadows, transitions, consistent spacing, readable typography
- Explanatory tooltips — Add `title` attribute tooltips to key UI elements explaining HOW they work using metaphors and reasoning. Example: a progress bar tooltip might say "Think of this like a fuel gauge — it reads from the usage API and fills proportionally to the quota limit." Tooltips should help stakeholders understand the logic behind the UI, not just label it.
```

```
Structure of the HTML file:
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Feature Name] — Visual POC</title>
  <style>
    /* CSS custom properties for theming */
    /* Reset + base styles */
    /* Component styles */
    /* State styles */
    /* Responsive overrides */
  </style>
</head>
<body>
  <!-- Semantic HTML structure -->
  <script>
    /* State management */
    /* Event handlers */
    /* View switching (if multi-screen) */
  </script>
</body>
</html>
```

### Step 4: Add a Control Panel

Include a small floating control panel in the POC that lets the user:
- Switch between screens (if multi-screen)
- Toggle states (empty / loading / filled / error / success)
- Toggle dark mode (if applicable)
- Toggle mobile / desktop viewport simulation

```
Control panel rules:
- Fixed position, bottom-right corner, collapsible
- Styled distinctly from the POC itself (e.g., dark toolbar with small buttons)
- Labeled "POC Controls" so it's clearly not part of the feature
- Does not interfere with the feature UI
```

### Step 5: Validate Against AC

Go through each acceptance criterion from the input and check:

```
| # | Acceptance Criterion | Covered? | How |
|---|---------------------|----------|-----|
| 1 | ...                 | Yes/No   | ... |
| 2 | ...                 | Yes/No   | ... |
```

- If an AC requires backend logic (API calls, auth, DB) — simulate it with realistic delays and mock responses **in the JS layer only** (setTimeout + hardcoded JSON)
- If an AC is purely visual — it must be fully represented
- If an AC is ambiguous — make a reasonable choice and note the assumption

### Step 6: Deliver

1. Write the file(s) to a `poc/` directory in the project root (or a user-specified location)
2. Present a summary:

```
## Visual POC: [Feature Name]

**File**: poc/[feature-name].html
**Open**: Just open the file in any browser

### What's Included
- [Screen 1]: [description]
- [Screen 2]: [description]
- Interactive: [what you can click/toggle]

### AC Coverage
[The table from Step 5]

### Assumptions Made
- [List of inferences not explicitly in the AC]

### Limitations
- [What's simulated vs real]
- [What's not covered]
```

3. Suggest opening the file: remind the user they can just double-click it or use `open poc/[feature-name].html`

## Examples

**User provides**: PRD for a subscription management dashboard

**Expected output**:
1. Single HTML file with dashboard layout
2. Cards showing plan tiers (Free, Pro, Enterprise)
3. Usage metrics with progress bars
4. Billing history table with sample data
5. Upgrade flow modal with form
6. Control panel to toggle: empty state, active subscription, expired, payment failed
7. Responsive — works on mobile and desktop

---

**User provides**: AC for a multi-step onboarding wizard

**Expected output**:
1. Single HTML file with step indicator
2. Step 1: Profile info form
3. Step 2: Preferences selection (checkboxes/toggles)
4. Step 3: Confirmation screen
5. Forward/back navigation between steps
6. Validation states (empty fields highlighted)
7. Control panel to jump to any step and toggle validation states

---

**User provides**: Documentation for a notification center

**Expected output**:
1. Bell icon with badge count
2. Dropdown panel with notification list
3. Read/unread states
4. "Mark all as read" action
5. Empty state ("No new notifications")
6. Different notification types (info, warning, success, error)
7. Control panel to add/clear notifications and toggle types

## Important Rules

- **No frameworks** — Vanilla HTML/CSS/JS only. No React, Vue, Tailwind CDN, Bootstrap, etc.
- **No external dependencies** — Must work offline, opened as a local file
- **Visual fidelity** — Should look like a real app, not a wireframe. Use proper spacing, colors, typography
- **Interactive where AC says so** — Don't just show a static screenshot. Wire up the described interactions
- **Realistic data** — Use plausible names, numbers, dates. Not "Test User" or "Lorem ipsum"
- **One POC per feature** — Don't mix unrelated features into one file
- **AC is the source of truth** — Cover every visual/interaction AC. Flag non-visual AC as limitations
- **Fast delivery** — This is a POC, not production. Optimize for speed of creation, not perfection
- **Clean up assumptions** — Clearly separate what was specified from what was inferred
- **Explanatory tooltips** — Every key UI element must have a `title` tooltip with a metaphor-based explanation of how it works and why it's there. This turns the POC into a self-documenting artifact that stakeholders can explore without a walkthrough
