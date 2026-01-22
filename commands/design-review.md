---
name: design-review
description: Comprehensive design review workflow (Audit -> Critique -> Optimize -> Verify)
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite, mcp__cursor-ide-browser__browser_navigate, mcp__cursor-ide-browser__browser_snapshot, mcp__cursor-ide-browser__browser_take_screenshot, mcp__Figma__get_design_context, mcp__Figma__get_metadata, mcp__Figma__get_screenshot, mcp__stitch__get_project, mcp__stitch__list_screens, mcp__stitch__get_screen
---

# Design Review Framework Workflow

You are orchestrating a comprehensive design review and optimization process. Your goal is to ensure that the implementation matches the design intent while pushing for the highest standards of UX, accessibility, and visual consistency.

## Phase 1: Context & Discovery

1. **Initial Setup Questions**:
   - **Ask the user**: "Which feature, screen, or component should I review?"
   - **Ask the user**: "Is there a Figma link, a design reference, or a live URL I should use?"
   - **Ask the user**: "Are there specific UX goals or known pain points I should focus on?"

2. **Environment Verification**:
   - If a URL is provided, use `cursor-ide-browser` to navigate and take snapshots.
   - If a Figma link is provided, use `Figma` MCP to fetch design context and screenshots.
   - If no design reference exists, check if `Stitch` MCP has relevant project screens.

## Phase 2: UX Audit & Critique

1. **Spawn ux-optimiser agent** to perform a deep audit using the 10-point checklist:
   - **Context & Goals**: Is the primary task explicit?
   - **Users & Flows**: Is the happy path short and dead-end free?
   - **Navigation & IA**: Is information grouped logically?
   - **Usability & Feedback**: Are there clear indicators for loading/success/error?
   - **Visual Hierarchy**: Is the primary action dominant?
   - **UI Consistency**: Are components aligned with the design system?
   - **Accessibility**: Do elements meet contrast guidelines and touch target sizes?
   - **Interactions & Motion**: Do they follow platform conventions?
   - **Content & Microcopy**: Are CTAs clear and action-oriented?
   - **Evidence**: Prioritize issues by impact vs. effort.

2. **Visual System Mapping**:
   - Extract and document the "Big Picture": Typography scale, Spacing/Grid system, and Color Palette.

## Phase 3: Optimization Proposal

1. **Develop Recommendations**:
   - Categorize findings by impact (Critical, High, Medium, Low).
   - Provide specific, actionable recommendations (e.g., "Increase contrast to 4.5:1").
   - **Reference Comparison**: Compare implementation vs. design. Be critical of both—if the design itself has flaws, call them out.

2. **Present Audit Summary** to the user:
   - **Overall Experience Score** (1-10)
   - **Top 3 Friction Points**
   - **Key Wins**
   - **Detailed Findings & Proposed Fixes**

## Phase 4: Implementation & Refinement

1. **Spawn code-architect agent** to:
   - Apply the approved UX/UI fixes directly to the code (CSS, Tailwind, JSX/TSX).
   - Ensure microcopy updates are implemented.
   - Fix accessibility issues (ARIA labels, keyboard focus).

2. **Spawn code-refactorer agent** to:
   - Review the applied changes for code quality and consistency with the existing codebase.
   - Simplify any over-engineered UI logic.

## Phase 5: Build Verification

1. **Spawn build-verificator agent** to:
   - Verify the build compiles and there are no linting errors.
   - Take final screenshots/snapshots to confirm visual fixes.
   - Ensure all "Critical" and "High" impact issues from the audit have been addressed.

## Completion
- Summarize the improvements made.
- Provide a "Before vs. After" comparison if possible.
- List any remaining low-priority items for future iterations.
