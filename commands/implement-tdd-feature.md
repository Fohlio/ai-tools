---
name: implement-tdd-feature
description: TDD workflow — Tests first, then implement, refactor, and verify
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskQuestion, TodoWrite
---

# TDD Feature Implementation Workflow

You are orchestrating a Test-Driven Development pipeline. **Tests are written BEFORE implementation.**

## Phase 1: Discovery & Planning

### Planning Principles

Before creating or executing any implementation plan, the following constraints must be enforced:

1. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
2. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
3. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.
5. **Context Intake** — Gather all requirements, design links, and chat history containing recommendations from other agents involved in the project.
6. **Explicit Approval** — Present the plan to the user and wait for explicit approval before proceeding to implementation phases. **Use the `AskQuestion` tool to present options or confirm the plan when possible.**
7. **POC First** — If the hypothesis is dubious or the technical confidence level is low, prioritize creating a Proof of Concept (POC) using the `poc-hypothesis` skill to validate the approach before full implementation.

### Planning Tasks
1. **Spawn plan agent** to:
   - Read requirements and gather context.
   - Audit existing codebase for reusable components.
   - Define test cases that will validate the feature.
   - Create a phased roadmap and get user approval.

## Phase 2: Test Specification (Red Phase)

1. **Spawn code-tester agent** to:
   - Write failing unit and integration tests based on requirements.
   - **Run tests to confirm they fail.**

## Phase 3: Implementation (Green Phase)

1. **Spawn code-architect agent** to:
   - Write **minimum code necessary** to make tests pass.
   - Adhere to existing patterns.
   - **Run tests to confirm they pass.**

## Phase 4: Refactoring (Refactor Phase)

1. **Spawn code-refactorer agent** to:
   - Improve code quality and readability while keeping tests green.
   - Run tests after each refactoring step.

## Phase 5: UX Review (Conditional)

If the feature has UI components:
1. **Spawn ux-designer agent** to audit UI, accessibility, and user flows.

## Phase 6: Build Verification

1. **Spawn build-verificator agent** to:
   - Verify build and full test suite.
   - **Requirement & Recommendation Audit**: Ensure all requirements and agent feedback are accounted for.
   - Confirm production readiness.

## Phase 7: Documentation & Archiving

1. **Spawn librarian agent** to:
   - Update project documentation (README, API docs, etc.) to reflect changes.
   - Log the implementation in the project's knowledge base.
   - Archive or delete any documentation that is now obsolete.
   - Ensure best practices for IT documentation are followed.

## Completion
1. **Propose Improvements**: Suggest 2-3 specific ways to further enhance the feature, improve performance, or reduce technical debt.
2. **Final Summary**:
   - Summarize changes and report test coverage.
   - Mark all todos as completed.
