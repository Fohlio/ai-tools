# BDD Feature Implementation Workflow

You are orchestrating a Behavior-Driven Development pipeline. **Both business scenarios (Gherkin) and unit tests are written BEFORE implementation.**

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

### Planning Tasks
1. **Spawn plan agent** to:
   - Read requirements and gather context.
   - Audit codebase and draft business scenarios (Gherkin).
   - Define technical test cases for unit coverage.
   - Create roadmap and get user approval.

## Phase 2: Specification (Red Phase)

1. **Spawn code-tester agent** to write:
   - `.feature` files with Gherkin scenarios.
   - Unit tests and step definitions mapping Gherkin to code.
   - **Run all tests to confirm they fail.**

## Phase 3: Implementation (Green Phase)

1. **Spawn code-architect agent** to:
   - Write minimum code to make ALL tests pass.
   - Run BDD scenarios and unit tests to confirm success.

## Phase 4: Refactoring

1. **Spawn code-refactorer agent** to refactor while keeping tests green.

## Phase 5: UX Review (Conditional)

If the feature has UI components:
1. **Spawn ux-designer agent** to validate user flows against Gherkin scenarios.

## Phase 6: Build Verification

1. **Spawn build-verificator agent** to:
   - Perform final build check and full suite run.
   - **Requirement Audit**: Cross-check implemented features against Gherkin scenarios and requirements.
   - **Recommendation Tracking**: Ensure all agent feedback is implemented or logged.

## Completion
- Summarize implementation and report test metrics.
- Mark all todos as completed.
