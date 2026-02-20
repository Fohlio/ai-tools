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

1. **ALWAYS ask clarifying questions first (MANDATORY)** — See STEP ZERO below. This is the very first action — before any planning, auditing, or reading.
2. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
3. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
3. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.
5. **Context Intake** — Gather all requirements, design links, and chat history containing recommendations from other agents involved in the project.
6. **Explicit Approval** — Present the plan to the user and wait for explicit approval before proceeding to implementation phases.
7. **POC First** — If the hypothesis is dubious or the technical confidence level is low, prioritize creating a Proof of Concept (POC) using the `poc-hypothesis` skill to validate the approach before full implementation.
8. **Confidence Check** — For each planning point, explicitly state the confidence level (High/Medium/Low). If the confidence level is not "High", add a step to use the **brainstorming agent** (Researcher with Brainstorming Protocol) to find solutions and propose alternatives before finalizing the plan.
9. **Design Validation** — If the feature has UI and no design mockup or Figma link is provided, **suggest the user generate mock designs using HTML/CSS** to validate the visual direction before implementation. Offer to create a quick HTML/CSS prototype for the user to review. Visual validation upfront prevents costly rework later. **Add `title` tooltips to key elements** with metaphor-based explanations of how they work and why they exist — making the prototype self-documenting.

### STEP ZERO — Ask Questions (MANDATORY)

> **Before doing ANYTHING else — before auditing code, before reading files, before creating a plan — you MUST ask the user at least 5 clarifying questions using `AskQuestion`.** This is the very first action in Phase 1. No exceptions. Five questions is the MINIMUM — even if the task seems perfectly clear, there are always hidden assumptions worth surfacing.

### Planning Tasks
1. **Spawn plan agent** to:
   - Read requirements and gather context.
   - Audit codebase and draft business scenarios (Gherkin).
   - **Create Acceptance Criteria & Verification Checklist** — Save to existing PRD or create new document:
     - **Location**: Add to existing PRD if available, otherwise create `docs/features/[feature-name]/ac.md`.
     - **Acceptance Criteria (AC)**: Derive directly from Gherkin scenarios.
     - **Verification Checklist**: Concrete checklist for build-verificator agent.
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

2. **Ask the user** if they want a visualization or explanation of the coding solution.
   - If yes, create a simple, beautiful HTML file (`docs/features/[feature-name]/code-explanation.html`) explaining how the solution works.

## Phase 4: Refactoring

1. **Spawn code-refactorer agent** to refactor while keeping tests green.

## Phase 5: UX Review (Conditional)

If the feature has UI components:
1. **Spawn ux-designer agent** to:
   - **Validate user flows against Gherkin scenarios** — Walk through each scenario as a user journey. Verify the UI supports every step naturally.
   - **Check UI consistency** — Ensure components match design system and existing patterns.
   - **Review error states** — Confirm error messages are clear and recovery paths exist.
   - Accessibility is secondary to flow correctness — focus on user experience first.

## Phase 6: Build Verification

1. **Spawn build-verificator agent** to:
   - Perform final build check and full suite run.
   - **Requirement Audit**: Cross-check implemented features against Gherkin scenarios and requirements.
   - **Recommendation Tracking**: Ensure all agent feedback is implemented or logged.

## Phase 7: Documentation & Archiving

1. **Spawn librarian agent** to:
   - Update project documentation (README, API docs, etc.) to reflect changes.
   - **Update `CHANGELOG.md`** following the "Keep a Changelog" standard.
   - Log the implementation in the project's knowledge base.
   - Archive or delete any documentation that is now obsolete.
   - Ensure best practices for IT documentation are followed.

## Completion
1. **Phase Compliance Self-Check** — Verify ALL 7 phases were executed by reviewing the Phase Gates table. If any phase was not executed, **STOP and go execute it now.**
2. **Session Analysis**: Brief retrospective — what worked, what didn't, how to improve.
3. **Propose Improvements**: 2-3 ways to enhance the feature or reduce tech debt.
4. **Final Summary**:
   - Summarize implementation and report test metrics.
   - Mark all todos as completed.
