---
name: replicate
description: Analyzes an existing feature or module from architecture, user flow, and design standpoints (including global styling sets), then produces a PRD for integrating the replicated feature into a new target architecture. Use when replicating a competitor's feature, porting a module between projects, or reverse-engineering a reference implementation for your own codebase.
allowed-tools: Task, Read, Glob, Grep, Bash(ls *), Bash(wc *), Bash(git log *), Bash(npm *), Bash(npx *), Write, AskUserQuestion, TodoWrite, WebSearch, WebFetch, mcp__Playwright__browser_navigate, mcp__Playwright__browser_snapshot, mcp__Playwright__browser_take_screenshot, mcp__Playwright__browser_click, mcp__Playwright__browser_evaluate, mcp__Figma__get_design_context, mcp__Figma__get_metadata, mcp__Figma__get_screenshot, mcp__Figma__get_variable_defs, mcp__stitch__create_project, mcp__stitch__generate_screen_from_text, mcp__stitch__list_screens, mcp__stitch__get_screen, mcp__context7__resolve-library-id, mcp__context7__query-docs
---

# Replicate Skill

## When to Use This Skill

- Replicating a feature from a competitor product or reference application into your own codebase
- Porting a module from one project to another with a different architecture
- Reverse-engineering a live product's feature to understand how it works before building your version
- Creating a specification for a feature you've seen elsewhere and want to adapt
- Building a "clone of X but for Y" — need the full spec before writing code

## How It Works

Five phases, executed sequentially. Each phase deepens understanding and feeds into the final PRD.

1. **Scope** — Identify the source, define boundaries, understand the target
2. **Architecture Analysis** — Reverse-engineer the technical structure
3. **User Flow Analysis** — Map every user journey end-to-end
4. **Design Analysis** — Extract visual system, global styles, and component patterns
5. **PRD Generation** — Synthesize everything into an integration-ready PRD

## Input Types

The skill works with different source types. Identify which one applies:

| Source Type | How to Analyze |
|---|---|
| **Live URL** | Use Playwright to navigate, snapshot, screenshot. Inspect network requests, DOM structure, behavior |
| **Codebase (local)** | Read files directly — components, routes, API calls, styles, state management |
| **Codebase (GitHub)** | Use GitHub MCP or clone locally, then read |
| **Figma design** | Use Figma MCP to extract design context, variables, screenshots |
| **Screenshots / description** | Work from user-provided materials + web research |

## Procedure

### Phase 1: Scope & Context

**Goal**: Define exactly what is being replicated and where it's going.

#### 1a. Identify the Source

Determine what the user wants to replicate:

```
Source:         [URL / repo path / Figma link / description]
Feature:        [specific feature or module name]
Boundary:       [what's included vs excluded — e.g., "the checkout flow, not the cart"]
```

If the source is a live URL, immediately navigate to it and take a snapshot + screenshot:

```
1. browser_navigate → the URL
2. browser_snapshot → capture accessibility tree (for structure analysis)
3. browser_take_screenshot → capture visual state
4. Explore key sub-pages and states (click through the feature flow)
```

If the source is code, scan the directory structure and identify the relevant files.

#### 1b. Identify the Target

Understand where this feature will be integrated:

```
Target project:     [path or repo]
Tech stack:         [framework, language, styling approach, DB]
Architecture:       [FSD, layered, hexagonal, monolith, microservices]
Design system:      [Tailwind, MUI, custom, Figma-based tokens]
Existing patterns:  [state management, API layer, auth approach]
```

Read the target project's `package.json`, config files, `CLAUDE.md`, and scan the directory structure. If there's no target project yet, ask the user about the planned stack.

#### 1c. Clarify Scope

Ask the user **at most one compound question** to resolve ambiguity:

```
Example: "I see the source has [feature A], [feature B], and [feature C].
Are we replicating all three, or focusing on [specific subset]?
And should this match the source exactly, or adapt to your existing [design system / architecture]?"
```

If scope is clear from context, skip the question and proceed.

### Phase 2: Architecture Analysis

**Goal**: Reverse-engineer the technical structure of the source feature.

Analyze and document:

#### 2a. Component Structure

```
Components:
├── [Top-level container]
│   ├── [Sub-component A] — [responsibility]
│   ├── [Sub-component B] — [responsibility]
│   └── [Sub-component C] — [responsibility]
```

For live URLs: inspect the DOM via `browser_snapshot` and `browser_evaluate` to understand component hierarchy.
For code: read the component files, trace imports and composition.

#### 2b. Data Flow & State

```
Data sources:    [API endpoints, local state, URL params, cookies, localStorage]
State management:[what library/pattern, where state lives, how it flows]
Data model:      [key entities, their relationships, required fields]
API contracts:   [endpoints, methods, request/response shapes]
```

For live URLs: use `browser_evaluate` to inspect state (window.__NEXT_DATA__, Redux devtools, network tab).
For code: trace data from API calls through state management to UI rendering.

#### 2c. Business Logic

```
Rules:           [validation, permissions, conditional rendering, calculations]
Edge cases:      [empty states, error states, loading states, boundary conditions]
Side effects:    [analytics events, notifications, external API calls]
```

#### 2d. Technical Dependencies

```
Libraries:       [key packages the feature depends on]
Services:        [external APIs, auth providers, payment gateways, CDNs]
Infrastructure:  [caching, queues, websockets, SSR requirements]
```

### Phase 3: User Flow Analysis

**Goal**: Map every path a user takes through the feature.

#### 3a. Happy Path

Walk through the primary user journey step by step:

```
Step 1: [User action] → [System response] → [Next state]
Step 2: [User action] → [System response] → [Next state]
...
Step N: [User action] → [System response] → [End state / outcome]
```

For live URLs: actually perform the flow using Playwright — click, type, navigate. Capture screenshots at each key state.

#### 3b. Alternative Paths

Map branching scenarios:

```
Branch: [Condition — e.g., "user is not logged in"]
  → Step 1: [what happens differently]
  → Rejoins main flow at: [step N] / [different outcome]
```

#### 3c. Error & Edge States

```
Error states:
- [trigger] → [what the user sees] → [recovery path]

Empty states:
- [when this occurs] → [what is shown]

Loading states:
- [what shows during load] → [skeleton / spinner / progressive]

Boundary conditions:
- [max items, character limits, timeout behavior]
```

#### 3d. Flow Diagram (Text)

Produce a text-based flow diagram:

```
[Entry Point]
    │
    ├── [Action A] ──→ [State 1] ──→ [Action B] ──→ [End: Success]
    │
    ├── [Action A] ──→ [State 1] ──→ [Error] ──→ [Recovery] ──→ [Retry]
    │
    └── [No Auth] ──→ [Login Redirect] ──→ [Return to Entry]
```

### Phase 4: Design Analysis

**Goal**: Extract the complete visual system — not just how it looks, but the rules behind it.

#### 4a. Global Styling Set

This is the most critical design output. Extract the foundational design tokens:

```
Typography:
  Font families:    [primary, secondary, monospace]
  Scale:            [h1: Xpx/Xrem, h2: ..., body: ..., small: ...]
  Weights:          [regular, medium, semibold, bold — which used where]
  Line heights:     [tight, normal, relaxed — mapped to usage]

Colors:
  Primary:          [hex/hsl + usage context]
  Secondary:        [hex/hsl + usage context]
  Accent:           [hex/hsl + usage context]
  Neutral:          [gray scale with steps]
  Semantic:         [success, warning, error, info — hex + usage]
  Background:       [page bg, card bg, elevated bg]
  Text:             [primary text, secondary text, muted text, inverse text]

Spacing:
  Scale:            [4px base? 8px? — the spacing unit]
  Common values:    [xs, sm, md, lg, xl mapped to px/rem]
  Section spacing:  [between major sections]
  Component spacing:[internal padding patterns]

Borders & Radius:
  Radius scale:     [none, sm, md, lg, full — mapped to px]
  Border colors:    [default, focus, error]
  Border widths:    [1px, 2px — usage patterns]

Shadows & Elevation:
  Levels:           [flat, raised, floating, modal — CSS values]

Breakpoints:
  Mobile:           [max-width]
  Tablet:           [range]
  Desktop:          [min-width]
  Wide:             [if applicable]

Animations:
  Transitions:      [default duration, easing]
  Common patterns:  [fade, slide, scale — where used]
```

For live URLs: use `browser_evaluate` to extract computed styles, CSS custom properties, and font stacks.
For Figma: use `get_variable_defs` to extract design tokens and `get_design_context` for structure.
For code: read tailwind config, CSS variables, theme files, or styled-components themes.

#### 4b. Component Inventory

List every distinct UI component used in the feature:

```
| Component | Variants | Key Props/States | Design Notes |
|---|---|---|---|
| Button | primary, secondary, ghost, danger | disabled, loading, icon | 40px height, 16px padding |
| Input | text, search, textarea | error, focus, disabled | Full-width in forms, inline in search |
| Card | default, elevated, outlined | hoverable, clickable | 16px padding, 8px radius |
| Modal | dialog, drawer, fullscreen | with/without overlay | 480px max-width on desktop |
| ... | ... | ... | ... |
```

#### 4c. Layout Patterns

```
Page layout:     [sidebar + content, full-width, centered container]
Grid system:     [CSS Grid, Flexbox, columns count]
Max widths:      [container, content, form widths]
Responsive:      [stack on mobile, side-by-side on desktop, hidden elements]
```

#### 4d. Interaction Patterns

```
Hover effects:   [color change, elevation, underline, cursor]
Focus indicators:[ring, outline, border change]
Active/pressed:  [scale, color shift]
Transitions:     [duration, easing, what animates]
Micro-interactions: [toast appearance, dropdown open, accordion expand]
```

### Phase 5: PRD Generation

**Goal**: Produce a complete, implementation-ready PRD that combines all findings.

Generate the PRD document with this structure:

```markdown
# PRD: [Feature Name] — Replication Specification

## 1. Overview

### 1.1 Background
[What is being replicated, from where, and why]

### 1.2 Source Reference
[URL / repo / Figma link — where the source was analyzed]

### 1.3 Goal
[What the replicated feature should achieve in the target system]

### 1.4 Scope
**In scope:**
- [Feature A]
- [Feature B]

**Out of scope:**
- [Feature C — reason]

## 2. Architecture Specification

### 2.1 Component Structure
[Component tree from Phase 2a — adapted for target architecture]

### 2.2 Data Model
[Entities, relationships, required fields — adapted for target DB/ORM]

### 2.3 API Contracts
[Endpoints needed, request/response shapes — adapted for target API patterns]

### 2.4 State Management
[How state should be managed in the target architecture]

### 2.5 Dependencies
[Libraries to add, services to integrate, infrastructure needed]

### 2.6 Integration Points
[Where this feature connects to existing target codebase — routes, navigation, shared state, shared components]

## 3. User Flow Specification

### 3.1 Primary Flow
[Step-by-step from Phase 3a — adapted for target UX patterns]

### 3.2 Alternative Flows
[Branching scenarios from Phase 3b]

### 3.3 Error & Edge States
[From Phase 3c — with target-specific error handling patterns]

### 3.4 Flow Diagram
[Text diagram from Phase 3d]

## 4. Design Specification

### 4.1 Global Styling Tokens
[From Phase 4a — mapped to target design system or provided as new tokens to add]

### 4.2 Component Specifications
[From Phase 4b — mapped to target component library or specified as new components to build]

### 4.3 Layout & Responsive Behavior
[From Phase 4c — adapted for target breakpoints and layout system]

### 4.4 Interaction & Animation
[From Phase 4d — adapted for target interaction patterns]

### 4.5 Visual References
[Screenshots captured during analysis, Figma links, Stitch mockup links]

## 5. Gap Analysis

### 5.1 What Exists in Target
[Components, patterns, infrastructure already available in the target project]

### 5.2 What Must Be Built
[New components, new API endpoints, new DB tables, new packages]

### 5.3 What Must Be Adapted
[Source patterns that don't fit target architecture — and how to bridge them]

### 5.4 Risks & Open Questions
[Technical risks, unknowns, decisions that need user input]

## 6. Implementation Roadmap

### Phase 1: Foundation
- [ ] [Task] — Priority: P0 | Size: [XS-XL]
- [ ] [Task] — Priority: P0 | Size: [XS-XL]

### Phase 2: Core Feature
- [ ] [Task] — Priority: P0 | Size: [XS-XL]
- [ ] [Task] — Priority: P1 | Size: [XS-XL]

### Phase 3: Polish & Edge Cases
- [ ] [Task] — Priority: P1 | Size: [XS-XL]
- [ ] [Task] — Priority: P2 | Size: [XS-XL]

## 7. Success Criteria

- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Measurable criterion 3]
```

Save the PRD to `docs/features/[feature-name]/prd.md` (create directory if needed).

If the user has Stitch available, offer to generate visual mockups for the key screens using `mcp__stitch__generate_screen_from_text` based on the design specification.

## Agent Delegation

This skill uses the following agents during execution:

| Phase | Agent | Purpose |
|---|---|---|
| Phase 2 | `code-architect` | Analyze architecture of source (if codebase) and map integration points in target |
| Phase 3 | `ux-designer` | Capture and analyze user flows, especially from live URLs via browser |
| Phase 4 | `ux-designer` | Extract design tokens, component inventory, and visual patterns |
| Phase 5 | `project-manager` | Create implementation roadmap with priorities and sizing |

Spawn agents in parallel where phases are independent (e.g., Phase 2 + Phase 3 + Phase 4 can run concurrently once Phase 1 is complete).

## Important Rules

- **Analyze the source yourself** — don't ask the user to describe the feature. Navigate it, read it, inspect it
- **Global styling is mandatory** — never skip the design token extraction in Phase 4a. This is the foundation for visual consistency
- **Adapt, don't copy** — the PRD should fit the *target* architecture, not mirror the source's implementation details. A React feature replicated into a Next.js app should use Next.js patterns
- **Evidence-based** — every specification must trace back to something observed (a screenshot, a code path, a network request, a computed style)
- **Screenshots at every key state** — if analyzing a live URL, capture the feature at rest, during interaction, in error states, and on mobile viewport
- **One question max** — infer context from the source and target. Ask at most one clarifying question in Phase 1, then execute
- **Complete the PRD** — don't produce a partial document. Every section must be filled. If information is unavailable, state what's missing and what assumption was made
- **Target-first gap analysis** — always assess what the target project already has before specifying what needs to be built. Reuse over rebuild
- **Respect existing design systems** — if the target has an established design system, map source design tokens to target tokens instead of introducing a parallel system
- **Flow before pixels** — user flow correctness matters more than visual fidelity. Get the journey right, then worry about exact colors
