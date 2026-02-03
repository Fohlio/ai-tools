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
6. **Explicit Approval** — Present the plan to the user and wait for explicit approval before proceeding to implementation phases.
7. **POC First** — If the hypothesis is dubious or the technical confidence level is low, prioritize creating a Proof of Concept (POC) using the `poc-hypothesis` skill to validate the approach before full implementation.
8. **Confidence Check** — For each planning point, explicitly state the confidence level (High/Medium/Low). If the confidence level is not "High", add a step to use the **brainstorming agent** (Researcher with Brainstorming Protocol) to find solutions and propose alternatives before finalizing the plan.

### Planning Tasks
1. **Spawn plan agent** to:
   - Read requirements and gather context.
   - Audit existing codebase for reusable components.
   - **Create Acceptance Criteria & Verification Checklist** — Save to existing PRD or create new document:
     - **Location**: Add to existing PRD if available, otherwise create `docs/features/[feature-name]/ac.md`.
     - **Acceptance Criteria (AC)**: List testable conditions derived from User Journey.
     - **Verification Checklist**: Concrete checklist for build-verificator agent.
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

2. **Ask the user** if they want a visualization or explanation of the coding solution.
   - If yes, create a simple, beautiful HTML file (`docs/features/[feature-name]/code-explanation.html`) explaining how the solution works.

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

## Completion
- Summarize changes and report test coverage.
- Mark all todos as completed.
