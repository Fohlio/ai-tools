---
name: c-implement-tdd-feature
description: TDD feature implementation workflow — tests first, then implementation, review, and verification
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite
---

# TDD Feature Implementation Workflow

You are orchestrating a Test-Driven Development pipeline. **Tests are written BEFORE implementation.** Follow these phases strictly and do not skip any step.

## Phase 1: Discovery & Planning

### Planning Principles

Before creating the implementation plan, enforce these constraints:

1. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
2. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
3. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.

### Planning Tasks

1. **Spawn plan agent** to:
   - Read the feature file specified by the user ($ARGUMENTS)
   - Analyze requirements and gather context from documentation
   - **Audit existing codebase** for reusable components, utilities, and patterns
   - **Ask focused clarifying questions** to the user to resolve any ambiguities or missing requirements
   - Create a phased implementation plan (roadmap) with priorities (P0-P2) and T-shirt sizes (XS-XL)
   - Identify files to create/modify and note potential risks or blockers
   - **Flag any existing infrastructure** that can be leveraged instead of built
   - **Define test cases** that will validate the feature works correctly

2. **Present the roadmap to user** and wait for explicit approval before proceeding

## Phase 2: Test Specification (TDD - Red Phase)

Once user approves the plan:

1. **Spawn code-tester agent** to write tests FIRST:
   - Write failing test cases based on requirements and acceptance criteria
   - Define unit tests for expected behavior
   - Define integration tests for system interactions
   - **Run tests to confirm they fail** (Red phase)
   - Tests should clearly document expected behavior

## Phase 3: Implementation (TDD - Green Phase)

After tests are written:

1. **Spawn code-architect agent** to implement the feature:
   - Follow the approved plan
   - Write **minimum code necessary** to make tests pass
   - Adhere to existing patterns in the codebase
   - **Run tests after implementation** to confirm they pass (Green phase)

## Phase 4: Refactoring (TDD - Refactor Phase)

After tests pass:

1. **Spawn code-refactorer agent** to refactor:
   - Improve code quality while keeping tests green
   - Check for over-engineering
   - Improve readability and scalability
   - Apply simplifications
   - **Run tests after each refactoring** to ensure nothing breaks

## Phase 5: UX Review (Conditional)

If the feature has UI/UX components:

1. **Spawn ux-optimiser agent** to:
   - Audit the user interface
   - Check accessibility
   - Validate user flows
   - Suggest improvements

Skip this phase if the feature is backend-only or has no user-facing elements.

## Phase 6: Build Verification

Final phase:

1. **Spawn build-verificator agent** to:
   - Verify the build compiles without errors
   - **Run full test suite** and confirm all tests pass
   - Check for runtime issues
   - Validate against acceptance criteria
   - Confirm production readiness

## Completion

After all phases complete successfully:
- Summarize what was implemented
- List all files created/modified
- Report test coverage metrics
- Note any follow-up items or technical debt
- Mark all todos as completed

---

## Important Rules

- **Tests before code** — Never implement before tests exist
- **Never skip phases** — each builds on the previous
- **Always wait for user approval** after Phase 1 planning
- **Run agents sequentially** — do not parallelize phases
- **If any phase fails**, stop and report the issue before continuing
- **Keep user informed** of progress between phases
- **Red-Green-Refactor** — Follow the TDD cycle strictly
