---
name: implement-bdd-feature
description: BDD+TDD workflow — Gherkin scenarios and unit tests first
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskQuestion, TodoWrite
---

# BDD Feature Implementation Workflow

You are orchestrating a Behavior-Driven Development pipeline. **Both business scenarios (Gherkin) and unit tests are written BEFORE implementation.**

---

## MANDATORY EXECUTION PROTOCOL

> **Every phase below is MANDATORY. Skipping, combining, or self-performing phases is a WORKFLOW VIOLATION.**

**Before starting Phase 1:**
- Review the Phase Gates table below. Each gate is a checkpoint you MUST pass.

**Between every phase:**
- Report deliverables to the user. Only then proceed to the next phase.
- Use `TodoWrite` for tracking implementation tasks within phases — not for phases themselves.

**Hard rules:**
- **ALWAYS ask clarifying questions at the start of Phase 1.** This is non-negotiable — even if the task seems clear. Use `AskQuestion` before creating any plan.
- **NEVER skip a phase.** Only Phase 5 (UX Review) may be skipped for zero-UI features — state this to the user first.
- **NEVER do a phase's work yourself.** Spawn the named agent via `Task` tool.
- **NEVER mark workflow complete** before Phase 7 (Documentation) is done.
- **If unsure, ask the user.** Do not assume any phase is unnecessary.

### Phase Gates

| Gate | Agent to spawn | Confirm before proceeding |
|------|---------------|--------------------------|
| Phase 1: Planning | `plan` | User Journey Map, AC with Gherkin, roadmap created. **User approved.** |
| Phase 2: Red (Specs) | `code-tester` | .feature files + step defs written. **Confirmed to fail.** |
| Phase 3: Green (Impl) | `code-architect` | All BDD scenarios + unit tests pass. |
| Phase 4: Refactor | `code-refactorer` | Code improved. Tests still green. |
| Phase 5: UX Review | `ux-designer` | User flows validated against Gherkin — or skipped (zero-UI, stated to user). |
| Phase 6: Verification | `build-verificator` | AC verified against Gherkin. Full suite passes. |
| Phase 7: Documentation | `librarian` | Docs, CHANGELOG updated. |

---

## Phase 1: Discovery & Planning

### Planning Principles

Before creating or executing any implementation plan, the following constraints must be enforced:

1. **ALWAYS ask clarifying questions first (MANDATORY)** — Ask the user clarifying questions BEFORE creating any plan. This is NOT conditional — do it every time regardless of how clear the task appears. Use `AskQuestion`. Key questions: What exactly should happen? What edge cases matter? What's in scope vs. deferred? Are there existing constraints or preferences? **Planning with wrong assumptions wastes more time than asking 3 questions upfront.**
2. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
3. **Technical Constraints & Edge Cases** — Identify technical limitations (performance, security, API limits) and plan for edge cases (error states, empty data, network failures) from the start.
3. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
4. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.
5. **Context Intake** — Gather all requirements, design links, and chat history containing recommendations from other agents involved in the project.
6. **Explicit Approval** — Present the plan to the user and wait for explicit approval before proceeding to implementation phases. **Use the `AskQuestion` tool to present options or confirm the plan when possible.**
7. **POC First** — If the hypothesis is dubious or the technical confidence level is low, prioritize creating a Proof of Concept (POC) using the `poc-hypothesis` skill to validate the approach before full implementation.
8. **Confidence Check** — For each planning point, explicitly state the confidence level (High/Medium/Low). If the confidence level is not "High", add a step to use the **brainstorming agent** (Researcher with Brainstorming Protocol) to find solutions and propose alternatives before finalizing the plan.

### STEP ZERO — Ask Questions (MANDATORY)

> **Before doing ANYTHING else — before auditing code, before reading files, before creating a plan — you MUST ask the user clarifying questions using `AskQuestion`.** This is the very first action in Phase 1. No exceptions.

### Planning Tasks
1. **Spawn plan agent** to:
   - **Ask clarifying questions FIRST** — Use `AskQuestion` to identify gaps in requirements. Confirm: expected behavior, scope boundaries, edge cases, and priorities. Do NOT skip this even if the task seems clear — there are always assumptions worth validating.
   - Read requirements and gather context.
   - Audit codebase and draft business scenarios (Gherkin).
   - **Create User Journey Map** — Visualize the user's path through the feature:
     - Define user persona and entry point.
     - Map each step/screen the user interacts with.
     - Identify user goals, actions, and expected outcomes at each step.
     - Note potential pain points, emotions, and opportunities for delight.
     - Align journey steps with Gherkin scenarios (each scenario = journey touchpoint).
   - **Create Acceptance Criteria & Verification Checklist** — Save to existing PRD or create new document:
     - **Location**: Add to existing PRD if available, otherwise create `docs/features/[feature-name]/ac.md`.
     - **Acceptance Criteria (AC)**: Derive directly from Gherkin scenarios. Each scenario = one AC item. Format: `[ ] AC-1: Scenario: [scenario name]`.
     - **Verification Checklist**: Concrete checklist for build-verificator agent:
       - [ ] All Gherkin scenarios pass
       - [ ] All unit tests pass
       - [ ] Step definitions cover all scenarios
       - [ ] No regressions in existing functionality
       - [ ] Error states and edge cases handled
       - [ ] Performance within acceptable thresholds
       - [ ] Accessibility requirements met (if UI)
     - **Definition of Done (DoD)**: Project-specific completion criteria.
   - Define technical test cases for unit coverage.
   - Create roadmap, present User Journey Map and AC document, and get user approval.

## Phase 2: Specification (Red Phase)

1. **Spawn code-tester agent** to write:
   - **Read AC document** — Gherkin scenarios from AC are the source of truth.
   - `.feature` files with Gherkin scenarios matching AC items.
   - Unit tests and step definitions mapping Gherkin to code.
   - **Run all tests to confirm they fail.**
   - **Update AC document**: Link each AC item to corresponding `.feature` file and line.

## Phase 3: Implementation (Green Phase)

1. **Spawn code-architect agent** to:
   - Write minimum code to make ALL tests pass.
   - Run BDD scenarios and unit tests to confirm success.

2. **Ask the user** if they want a visualization or explanation of the coding solution.
   - If yes, create a simple, beautiful HTML file (`docs/features/[feature-name]/code-explanation.html`) explaining how the solution works.

## Phase 4: Refactoring

1. **Spawn code-refactorer agent** to refactor while keeping tests green.

## Phase 5: UX Review (Conditional)

If the feature has UI components:
1. **Spawn ux-designer agent** to:
   - **Validate user flows against Gherkin scenarios** — Walk through each scenario as a user journey. Verify the UI supports every Given/When/Then step naturally.
   - **Check UI consistency** — Ensure components match design system and existing patterns.
   - **Review error states** — Confirm error messages are clear and recovery paths exist.
   - Accessibility is secondary to flow correctness — focus on user experience first.

## Phase 6: Build Verification

1. **Spawn build-verificator agent** to:
   - **Read AC document** — use as primary verification source.
   - Perform final build check and full suite run.
   - **AC Verification**: Walk through each AC item (Gherkin scenario), mark as ✅ or ❌ with test results.
   - **Checklist Audit**: Complete all items in Verification Checklist from AC document.
   - **Requirement Audit**: Cross-check implemented features against Gherkin scenarios and requirements.
   - **Recommendation Tracking**: Ensure all agent feedback is implemented or logged.
   - **Update AC document**: Record verification results and sign-off status.

## Phase 7: Documentation & Archiving

1. **Spawn librarian agent** to:
   - Update project documentation (README, API docs, etc.) to reflect changes.
   - **Update `CHANGELOG.md`** following the "Keep a Changelog" standard.
   - Log the implementation in the project's knowledge base.
   - Archive or delete any documentation that is now obsolete.
   - Ensure best practices for IT documentation are followed.

## Completion
1. **Phase Compliance Self-Check** — Before writing the summary, verify ALL 7 phases were executed by reviewing the Phase Gates table. If any phase was not executed, **STOP and go execute it now.** Specifically confirm:
   - [ ] Phase 1: Plan agent spawned, User Journey Map + AC doc with Gherkin created, user approved
   - [ ] Phase 2: Code-tester spawned, .feature files + step defs written, confirmed to fail
   - [ ] Phase 3: Code-architect spawned, all BDD scenarios + unit tests pass
   - [ ] Phase 4: Code-refactorer spawned, code improved, tests green
   - [ ] Phase 5: UX-designer spawned (or explicitly skipped for backend-only)
   - [ ] Phase 6: Build-verificator spawned, AC verified against Gherkin
   - [ ] Phase 7: Librarian spawned, docs updated
2. **Session Analysis**: Perform a brief retrospective of the session:
   - What worked well (tools, communication, logic)?
   - What were the friction points or failures?
   - How can the workflow or instructions be improved for next time?
3. **Propose Improvements**: Suggest 2-3 specific ways to further enhance the feature, improve performance, or reduce technical debt.
4. **Final Summary**:
   - Summarize implementation and report test metrics.
   - Mark all todos as completed.
