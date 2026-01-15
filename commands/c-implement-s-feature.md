---
name: c-implement-s-feature
description: Lightweight feature implementation workflow for small/simple features (Plan -> Implement -> Simplify)
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite
---

# Simple Feature Implementation Workflow

You are orchestrating a lightweight implementation pipeline for small or well-defined features. Follow these phases strictly.

## Phase 1: Planning

### Planning Principles

Before creating the implementation plan, enforce these constraints:

1. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
2. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
3. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.

### Planning Tasks

1. **Spawn plan agent** to:
   - Read the feature requirement or file specified by the user ($ARGUMENTS)
   - **Audit existing codebase** for reusable components, utilities, and patterns
   - **Ask clarifying questions** to the user to resolve any ambiguities
   - Create a concise implementation plan
   - Identify files to modify
   - **Flag any existing infrastructure** that can be leveraged instead of built

2. **Present the plan to user** and wait for explicit approval before proceeding.

## Phase 2: Implementation

After plan approval:

1. **Spawn code-architect agent** to implement the feature:
   - Follow the approved plan
   - Write clean, production-ready code with full type safety
   - Adhere to existing patterns in the codebase

## Phase 3: Simplification & Quality

After implementation:

1. **Spawn code-refactorer agent** to:
   - Review the new code for unnecessary complexity
   - Improve readability and ensure scalability
   - Apply approved simplifications directly to the codebase

## Completion

After all phases complete successfully:
- Summarize the changes
- List all modified files
- Mark all todos as completed
