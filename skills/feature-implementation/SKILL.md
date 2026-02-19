---
name: ai-tools:feature-implementation
description: Orchestrates full feature implementation using Standard, TDD, or BDD workflows with automated quality gates. Use when implementing new features from scratch, when a structured development workflow is needed, or when the user mentions TDD, BDD, or test-driven development.
---

# Feature Implementation Skill

## When to Use This Skill

- User wants to implement a new feature from scratch.
- User wants to use a specific methodology like **TDD** (Tests-First) or **BDD** (Behavior-Driven).
- User wants a structured, production-ready implementation with full verification.
- User wants to ensure that all requirements and expert recommendations are tracked and verified.
- User wants a quick, lightweight implementation without the full pipeline (use **Small** workflow).

## How It Works

This skill selects and orchestrates one of three specialized pipelines based on the task complexity and user preference. Each pipeline is defined in the `workflows/` directory:

1.  **Standard Workflow**: Rapid implementation with tests following the code. (See `workflows/standard.md`)
2.  **TDD Workflow**: Rigorous unit-testing from the start (Red-Green-Refactor). (See `workflows/tdd.md`)
3.  **BDD Workflow**: High-level business scenarios (Gherkin) driving the implementation. (See `workflows/bdd.md`)
4.  **Small Workflow**: Lightweight plan-and-implement only, no full pipeline. (See `workflows/small.md`)

All workflows follow a mandatory **Build Verification** phase using the `build-verificator` agent to ensure 100% completeness.

## Procedure

### Phase 1: Planning (Shared)
Follow the planning principles defined in each workflow:
- **ALWAYS ask clarifying questions first** — This is MANDATORY before any planning. Use `AskQuestion`.
- **Audit codebase** for reusable patterns.
- **Identify integration surfaces**.
- **Gather recommendations** from other agents in the history.
- **Get explicit approval** on the roadmap.

### Phase 2: Execution

#### Option A: Standard Workflow
Follow the stages in `workflows/standard.md`:
1.  **Implement**: Write production-ready code.
2.  **Test**: Write and run unit tests to confirm implementation.
3.  **Refactor**: Clean up and simplify while keeping tests green.
4.  **Visualize**: Ask user if they want an HTML explanation of the solution.

#### Option B: TDD Workflow (Red-Green-Refactor)
Follow the stages in `workflows/tdd.md`:
1.  **Red**: Write failing unit tests first. Run them to confirm failure.
2.  **Green**: Write minimum code to make tests pass.
3.  **Refactor**: Improve quality while keeping tests green.
4.  **Visualize**: Ask user if they want an HTML explanation of the solution.

#### Option C: BDD Workflow
Follow the stages in `workflows/bdd.md`:
1.  **Spec**: Write Gherkin scenarios (`.feature`) and failing technical tests.
2.  **Implement**: Write code to satisfy both business and technical specs.
3.  **Refactor**: Simplify and optimize.
4.  **Visualize**: Ask user if they want an HTML explanation of the solution.

#### Option D: Small Workflow (Lightweight)
Follow `workflows/small.md`:
1.  **Plan**: Ask questions, audit codebase, create concise plan, get approval.
2.  **Implement**: Write production-ready code following the plan.
3.  **Refactor**: Review and simplify code while keeping the build green.

### Phase 3: Quality Gates (Build Verification)
The `build-verificator` agent performs the final audit as described in each workflow:
1.  **Build Check**: Ensures the project compiles.
2.  **Test Check**: Ensures 100% test pass rate.
3.  **Requirement Audit**: Maps implementation back to the original plan.
4.  **Recommendation Audit**: Verifies that all expert feedback from the conversation was either implemented, communicated, or roadmaped.

### Phase 4: Documentation & Archiving
**Spawn librarian agent** to update all project documentation, CHANGELOG, and knowledge base. This phase is **MANDATORY** — the workflow is NOT complete without it.

## MANDATORY EXECUTION RULES

> **Every phase in the selected workflow is MANDATORY. The orchestrator MUST execute ALL phases sequentially, spawning the named agent for each.**

| # | Rule | Detail |
|---|------|--------|
| 1 | **Track phases** | Review Phase Gates table before starting. Report deliverables to user after each phase. Use `TodoWrite` for implementation tasks, not phase tracking. |
| 2 | **Spawn agents** | Each phase names a specific agent. Use the `Task` tool. **Never self-perform.** |
| 3 | **No skipping** | Only UX Review may be skipped (zero-UI features, stated to user). All other phases are mandatory — including Refactoring, Build Verification, and Documentation. |
| 4 | **Phase gates** | After each phase, report deliverables to the user before proceeding. |
| 5 | **Complete ALL phases** | Workflow ends after Documentation (Phase 7), not before. |
| 6 | **No placeholders** | Never leave `TODO` or `FIXME`. |
| 7 | **Verification gate** | Never mark "Done" without Build Verification Report from `build-verificator`. |
| 8 | **Audit first** | Check for existing code to reuse before writing new logic. |
| 9 | **POC first** | If confidence is low, create a POC before full implementation. |
| 10 | **Phase compliance check** | Before writing the final summary, verify ALL phases were executed per the Phase Gates table. If any were not, go back and execute them. |

## Examples

- **User**: "Add a login form with validation." -> Use **Standard** or **TDD**.
- **User**: "Implement the checkout flow described in this Gherkin file." -> Use **BDD**.
- **User**: "I need a super robust calculation engine for the bank." -> Use **TDD**.
- **User**: "Add a new field to the settings page." -> Use **Small**.
