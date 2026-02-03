---
name: feature-implementation
description: Orchestrates full feature implementation using Standard, TDD, or BDD workflows with automated quality gates.
---

# Feature Implementation Skill

## When to Use This Skill

- User wants to implement a new feature from scratch.
- User wants to use a specific methodology like **TDD** (Tests-First) or **BDD** (Behavior-Driven).
- User wants a structured, production-ready implementation with full verification.
- User wants to ensure that all requirements and expert recommendations are tracked and verified.

## How It Works

This skill selects and orchestrates one of three specialized pipelines based on the task complexity and user preference. Each pipeline is defined in the `workflows/` directory:

1.  **Standard Workflow**: Rapid implementation with tests following the code. (See `workflows/standard.md`)
2.  **TDD Workflow**: Rigorous unit-testing from the start (Red-Green-Refactor). (See `workflows/tdd.md`)
3.  **BDD Workflow**: High-level business scenarios (Gherkin) driving the implementation. (See `workflows/bdd.md`)

All workflows follow a mandatory **Build Verification** phase using the `build-verificator` agent to ensure 100% completeness.

## Procedure

### Phase 1: Planning (Shared)
Follow the planning principles defined in each workflow:
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

### Phase 3: Quality Gates (Build Verification)
The `build-verificator` agent performs the final audit as described in each workflow:
1.  **Build Check**: Ensures the project compiles.
2.  **Test Check**: Ensures 100% test pass rate.
3.  **Requirement Audit**: Maps implementation back to the original plan.
4.  **Recommendation Audit**: Verifies that all expert feedback from the conversation was either implemented, communicated, or roadmaped.

## Important Rules

| Rule | Description |
| :--- | :--- |
| **No Placeholders** | Never leave `TODO` or `FIXME`. Implementation must be complete. |
| **Verification Gate** | Never mark a task as "Done" without a successful Build Verification Report. |
| **Sequential Phases** | Complete each phase fully before moving to the next. |
| **Audit First** | Always check for existing code to reuse before writing new logic. |
| **POC First** | If hypothesis is dubious or confidence is low, prioritize creating a POC first. |

## Examples

- **User**: "Add a login form with validation." -> Use **Standard** or **TDD**.
- **User**: "Implement the checkout flow described in this Gherkin file." -> Use **BDD**.
- **User**: "I need a super robust calculation engine for the bank." -> Use **TDD**.
