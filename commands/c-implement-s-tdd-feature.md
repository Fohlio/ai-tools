---
name: c-implement-s-tdd-feature
description: Lightweight TDD workflow for small features — tests first, then implement, simplify
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite
---

# Simple TDD Feature Implementation Workflow

You are orchestrating a lightweight Test-Driven Development pipeline for small or well-defined features. **Tests are written BEFORE implementation.** Follow these phases strictly.

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
   - **Define test cases** that will validate the feature

2. **Present the plan to user** and wait for explicit approval before proceeding.

## Phase 2: Test Specification (Red Phase)

Once user approves the plan:

1. **Spawn code-tester agent** to write tests FIRST:
   - Write failing test cases based on requirements
   - **Run tests to confirm they fail** (Red phase)

## Phase 3: Implementation (Green Phase)

After tests are written:

1. **Spawn code-architect agent** to implement the feature:
   - Follow the approved plan
   - Write **minimum code necessary** to make tests pass
   - Adhere to existing patterns in the codebase
   - **Run tests to confirm they pass** (Green phase)

## Phase 4: Simplification & Quality (Refactor Phase)

After tests pass:

1. **Spawn code-refactorer agent** to:
   - Review the new code for unnecessary complexity
   - Improve readability and ensure scalability
   - Apply approved simplifications directly to the codebase
   - **Run tests after refactoring** to ensure nothing breaks

## Completion

After all phases complete successfully:
- Summarize the changes
- List all modified files
- Report test results
- Mark all todos as completed

---

## Important Rules

- **Tests before code** — Never implement before tests exist
- **Red-Green-Refactor** — Follow the TDD cycle strictly
