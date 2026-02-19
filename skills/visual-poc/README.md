# visual-poc

A Claude Code skill that generates standalone visual POCs (HTML/CSS/JS) from documentation, acceptance criteria, or PRDs.

## Adding This Skill to Your Project

Copy the `visual-poc` folder to your project's `.claude/skills/` directory:

```bash
# From your project root
mkdir -p .claude/skills
cp -r /path/to/ai-tools/skills/visual-poc .claude/skills/
```

## Using the Skill

Provide a PRD, AC, or documentation and ask Claude to visualize it:

```
Here's the AC for our new dashboard. Create a visual POC.
```

```
Mock up the onboarding flow from this PRD.
```

```
Show me what this notification center would look like.
```

```
Visualize the settings page described in this doc.
```

## Workflow

### 1. Parse Input

Claude extracts screens, components, states, flows, and data shape from your documentation.

### 2. Build POC

| What You Provide | What You Get |
|-----------------|--------------|
| PRD with screens | Multi-view HTML with navigation |
| AC with states | Interactive toggles for each state |
| Docs with data | Realistic placeholder data matching your schema |
| Flow description | Clickable step-by-step journey |

### 3. Control Panel

Every POC includes a floating control panel (bottom-right) that lets you:
- Switch between screens
- Toggle states (empty, loading, filled, error, success)
- Toggle dark mode
- Simulate mobile/desktop

### 4. AC Coverage Report

Claude maps every acceptance criterion to what's covered in the POC:

```
| # | Acceptance Criterion          | Covered? | How                    |
|---|-------------------------------|----------|------------------------|
| 1 | Shows plan comparison table   | Yes      | Three-column card grid |
| 2 | Handles payment failure       | Yes      | Error state via toggle |
| 3 | Sends confirmation email      | No       | Backend — simulated    |
```

## Examples

### Dashboard from PRD

```
User: Here's the PRD for our analytics dashboard. Visualize it.

Claude:
1. Parses PRD: 3 screens (Overview, Details, Settings)
2. Builds single HTML with view switching
3. Overview: KPI cards, line chart (CSS), recent activity table
4. Details: filterable data table with pagination
5. Settings: form with toggles and save button
6. Control panel: screen switcher, state toggles
```

### Onboarding from AC

```
User: Create a visual POC from these acceptance criteria for onboarding.

Claude:
1. Parses AC: 4 steps, validation rules, completion state
2. Builds wizard with step indicator and navigation
3. Each step has form fields matching the AC
4. Validation states wired up (empty, invalid, valid)
5. Final step shows confirmation summary
6. Control panel: jump to step, toggle validation states
```

### Settings Page from Docs

```
User: Visualize the settings page from this documentation.

Claude:
1. Parses docs: sections (Profile, Notifications, Security, Billing)
2. Builds tabbed layout with sidebar navigation
3. Each section has the described form fields
4. Toggle switches, dropdowns, text inputs all interactive
5. Save/cancel buttons with success feedback
6. Control panel: jump to section, toggle save states
```

## Output

- **File**: `poc/[feature-name].html` in your project root
- **Open**: Double-click the file or run `open poc/[feature-name].html`
- **No dependencies**: Works offline, no build step, no server needed

## Key Principles

| Principle | Description |
|-----------|-------------|
| **No Frameworks** | Vanilla HTML/CSS/JS only — no CDN, no build tools |
| **Self-Contained** | Works as a local file, no server needed |
| **Visually Polished** | Looks like a real app, not a wireframe |
| **Interactive** | Wires up states and transitions described in the AC |
| **Realistic Data** | Domain-appropriate placeholder content |
| **AC-Driven** | Every visual AC is covered, non-visual AC flagged |

## When NOT to Use

- For production UI (use `/ai-tools:implement-feature` instead)
- When you need real API integration (use `/ai-tools:poc-hypothesis`)
- For design system creation (use `/ai-tools:create-design-system`)
- When the feature is purely backend with no UI
