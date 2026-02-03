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
2. **Technical Constraints & Edge Cases** — Identify technical limitations (performance, security, API limits) and plan for edge cases (error states, empty data, network failures) from the start.
3. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
4. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.
5. **Context Intake** — Gather all requirements, design links, and chat history containing recommendations from other agents involved in the project.
6. **Explicit Approval** — Present the plan to the user and wait for explicit approval before proceeding to implementation phases. **Use the `AskQuestion` tool to present options or confirm the plan when possible.**
7. **POC First** — If the hypothesis is dubious or the technical confidence level is low, prioritize creating a Proof of Concept (POC) using the `poc-hypothesis` skill to validate the approach before full implementation.
8. **Confidence Check** — For each planning point, explicitly state the confidence level (High/Medium/Low). If the confidence level is not "High", add a step to use the **brainstorming agent** (Researcher with Brainstorming Protocol) to find solutions and propose alternatives before finalizing the plan.

### Planning Tasks
1. **Spawn plan agent** to:
   - Read requirements and gather context.
   - Audit existing codebase for reusable components.
   - **Create User Journey Map** — Visualize the user's path through the feature:
     - Define user persona and entry point.
     - Map each step/screen the user interacts with.
     - Identify user goals, actions, and expected outcomes at each step.
     - Note potential pain points, emotions, and opportunities for delight.
     - Derive test cases from journey steps (each step = testable behavior).
   - **Create Acceptance Criteria & Verification Checklist** — Save to existing PRD or create new document:
     - **Location**: Add to existing PRD if available, otherwise create `docs/features/[feature-name]/ac.md`.
     - **Acceptance Criteria (AC)**: List testable conditions derived from User Journey. Format: `[ ] AC-1: [Given/When/Then or clear condition]`.
     - **Test Case Mapping**: Each AC item should map to one or more test cases. Format: `AC-1 → test_feature_behavior()`.
     - **Verification Checklist**: Concrete checklist for build-verificator agent:
       - [ ] All AC items have corresponding tests
       - [ ] All tests pass (unit + integration)
       - [ ] Test coverage meets project standards
       - [ ] No regressions in existing functionality
       - [ ] Error states and edge cases covered by tests
       - [ ] Performance tests pass (if applicable)
     - **Definition of Done (DoD)**: Project-specific completion criteria.
   - Define test cases that will validate the feature.
   - Create a phased roadmap, present User Journey Map and AC document, and get user approval.

## Phase 2: Test Specification (Red Phase)

1. **Spawn code-tester agent** to:
   - **Read AC document** — Acceptance Criteria are the source of truth for test cases.
   - Write failing unit and integration tests that validate each AC item.
   - **Run tests to confirm they fail.**
   - **Update AC document**: Link each AC item to corresponding test file and function.

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
   - **Read AC document** — use as primary verification source.
   - Verify build and full test suite.
   - **AC Verification**: Walk through each AC item, verify corresponding test passes, mark as ✅ or ❌.
   - **Checklist Audit**: Complete all items in Verification Checklist from AC document.
   - **Requirement & Recommendation Audit**: Ensure all requirements and agent feedback are accounted for.
   - Confirm production readiness.
   - **Update AC document**: Record verification results and sign-off status.

## Phase 7: Documentation & Archiving

1. **Spawn librarian agent** to:
   - Update project documentation (README, API docs, etc.) to reflect changes.
   - **Update `CHANGELOG.md`** following the "Keep a Changelog" standard.
   - Log the implementation in the project's knowledge base.
   - Archive or delete any documentation that is now obsolete.
   - Ensure best practices for IT documentation are followed.

## Completion
1. **Session Analysis**: Perform a brief retrospective of the session:
   - What worked well (tools, communication, logic)?
   - What were the friction points or failures?
   - How can the workflow or instructions be improved for next time?
2. **Propose Improvements**: Suggest 2-3 specific ways to further enhance the feature, improve performance, or reduce technical debt.
3. **Final Summary**:
   - Summarize changes and report test coverage.
   - Mark all todos as completed.
