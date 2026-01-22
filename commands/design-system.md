---
name: design-system
description: Framework for building and scaling a design system (Tokens, Components, Patterns, Docs).
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite, mcp__Figma__get_design_context, mcp__Figma__get_metadata, mcp__Figma__get_screenshot
---

# Design System Framework Workflow

You are orchestrating the creation or expansion of a Design System. Your goal is to establish a robust "Source of Truth" for foundations, components, and patterns that bridges design and code.

## Phase 1: Discovery & Configuration

1. **Initial Setup Questions**:
   - **Ask the user**: "Where should the Design System be stored? (e.g., `shared/ui`, `/design-system`, or a specific package path?)"
   - **Ask the user**: "Is there a Figma link or a design reference? If so, should I use the Figma MCP or an image/screenshot?"
   - **Ask the user**: "What is the technical stack? (e.g., React + Tailwind, Vue + CSS Modules, etc.)"

2. **Environment Verification**:
   - Check if Figma MCP is configured if the user provides a link.
   - Audit existing UI components to identify patterns and inconsistencies.

## Phase 2: Foundations & Tokens (Layer 1)

1. **Spawn ux-designer agent** to:
   - Extract global tokens: Colors, Typography, Spacing, Radii, Shadows.
   - Design the **Token Hierarchy**: `Global` (raw values) → `Semantic` (usage-based, e.g., `brand.primary`) → `Component` (e.g., `button.bg`).
   - Propose a JSON/YAML structure for tokens.

2. **Spawn code-architect agent** to:
   - Set up the package structure (e.g., `@org/design-tokens`).
   - Configure a build tool like Style Dictionary if needed to generate CSS variables/TS types.

## Phase 3: Component Library (Layer 2)

1. **Atomic Design Implementation**:
   - **Atoms**: Buttons, Inputs, Labels, Icons.
   - **Molecules**: Form Fields, Search Bars.
   - **Organisms**: Navigation, Modals, Tables.
2. **Implementation Strategy**:
   - Build components using the Semantic Tokens.
   - Ensure accessibility (ARIA, keyboard navigation) is baked in.

## Phase 4: Patterns & Templates (Layer 3)

1. **Composite UI**:
   - Build page layouts, forms, and common interaction patterns.
2. **Consistency Audit**:
   - Ensure all patterns strictly follow the established Foundations.

## Phase 5: Documentation & CI/CD (Layer 4)

1. **Docs Strategy**:
   - Set up Storybook, Ladle, or a Markdown-based portal.
   - Define Governance rules: How to propose a new component? How to handle breaking changes?
2. **Automation**:
   - Configure CI/CD: Token update → PR → Auto-generate assets (CSS, TS, Assets).
   - Set up versioning and a automated changelog.

## Phase 6: Quality Review & Handoff

1. **Spawn code-refactorer agent** to:
   - Perform a final review of the implementation.
   - Ensure clean code, proper typing, and adherence to the specified architecture.
   - Suggest simplifications or optimizations for component logic.

2. **Final Presentation**:
   - Present the architecture and the first batch of components to the user.
   - Provide a migration strategy for existing products (Deprecated tags, phasing).
