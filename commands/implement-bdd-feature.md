---
name: ai-tools:implement-bdd-feature
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
- **NEVER skip a phase** unless explicitly disabled in the pre-flight `workflow.md`. Only Phase 5 (UX Review) can be disabled via pre-flight. The Red Phase (Gherkin specification) is inherent to BDD and always active — state skipped phases to the user.
- **NEVER do a phase's work yourself.** Spawn the named agent via `Task` tool.
- **NEVER mark workflow complete** before Phase 7 (Documentation) is done.
- **If unsure, ask the user.** Do not assume any phase is unnecessary.

### Phase Gates

| Gate | Agent to spawn | Confirm before proceeding |
|------|---------------|--------------------------|
| Phase 0: Pre-flight | orchestrator | Pre-flight questions answered. `workflow.md` created. POCs completed (if requested). |
| Phase 1: Planning | `plan` | User Journey Map, AC with Gherkin, roadmap created. **User approved.** |
| Phase 2: Red (Specs) | `code-tester` | .feature files + step defs written. **Confirmed to fail.** |
| Phase 3: Green (Impl) | `code-architect` | All BDD scenarios + unit tests pass. |
| Phase 4: Refactor | `code-refactorer` | Code improved. Tests still green. |
| Phase 5: UX Review | `ux-designer` | User flows validated against Gherkin — or skipped (zero-UI, stated to user). |
| Phase 6: Verification | `build-verificator` | AC verified against Gherkin. Full suite passes. |
| Phase 7: Documentation | `librarian` | Docs, CHANGELOG updated. |

---

## Phase 0: Pre-flight Check

> **This phase runs BEFORE any planning or discovery. It configures the workflow for this specific feature.**

### Pre-flight Questions (MANDATORY)

Use `AskQuestion` to gather the following decisions from the user:

1. **Design availability**: "Do you have a design for this feature (Figma link, mockup, wireframe)?"
   - Options: `Yes, I have a design` / `No design available` / `Backend-only, no UI needed`

2. **Visual POC** *(ask only if Q1 answer is "No design available")*: "Should we generate a visual POC (standalone HTML/CSS/JS) to validate the UI direction before implementation?"
   - Options: `Yes, generate visual POC first` / `No, proceed without visual validation`

3. **Technical risk / POC**: "Does this feature involve risky or unproven technology (AI agents, novel integrations, unfamiliar APIs)? Should we build a technical POC to validate the approach first?"
   - Options: `Yes, build technical POC first` / `No, confident in the approach`

4. **Workflow phases** *(multi-select)*: "Which optional workflow phases do you need for this feature?"
   - `Design/UX review phase`
   - `Testing guide (manual testing instructions)`
   - `Test cases document (positive base cases from AC)`

> **Note**: In BDD, the Red Phase (Gherkin specification + step definitions) is inherent to the methodology and always active. It cannot be disabled.

### Create Workflow Document

After collecting all pre-flight answers, create the feature documentation folder and workflow document at `docs/features/[feature-name]/workflow.md`:

    # Workflow Configuration: [Feature Name]

    ## Pre-flight Decisions
    - **Design**: [Figma link / No design / Backend-only]
    - **Visual POC**: [Yes — generate before Phase 1 / No / N/A]
    - **Technical POC**: [Yes — validate before Phase 1 / No]
    - **Design/UX review**: [Enabled / Disabled]
    - **Testing guide**: [Required / Not required]
    - **Test cases document**: [Required / Not required]

    ## Active Phases
    - [x] Phase 0: Pre-flight Check
    - [ ] Phase 1: Discovery & Planning
    - [ ] Phase 2: Specification (Red) — always active
    - [ ] Phase 3: Implementation (Green)
    - [ ] Phase 4: Refactoring
    - [ ] Phase 5: UX Review *(if enabled)*
    - [ ] Phase 6: Build Verification
    - [ ] Phase 7: Documentation & Archiving

    ## Notes
    [Any additional context from pre-flight decisions]

### Execute POCs (if requested)

- **If Visual POC was selected**: Use the `visual-poc` skill to generate a standalone HTML/CSS/JS prototype. Save to `docs/features/[feature-name]/visual-poc.html`. Present to user for approval before proceeding.
- **If Technical POC was selected**: Use the `poc-hypothesis` skill to validate the technical approach. Present findings to user. Proceed only after the approach is validated.

---

## Phase 1: Discovery & Planning

### Planning Principles

Before creating or executing any implementation plan, the following constraints must be enforced:

1. **ALWAYS ask clarifying questions first (MANDATORY)** — See STEP ZERO below. This is the very first action — before any planning, auditing, or reading.
2. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
3. **Technical Constraints & Edge Cases** — Identify technical limitations (performance, security, API limits) and plan for edge cases (error states, empty data, network failures) from the start.
3. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
4. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.
5. **Context Intake** — Gather all requirements, design links, and chat history containing recommendations from other agents involved in the project.
6. **Explicit Approval** — Present the plan to the user and wait for explicit approval before proceeding to implementation phases. **Use the `AskQuestion` tool to present options or confirm the plan when possible.**
7. **POC First** — If the hypothesis is dubious or the technical confidence level is low, prioritize creating a Proof of Concept (POC) using the `poc-hypothesis` skill to validate the approach before full implementation.
8. **Confidence Check** — For each planning point, explicitly state the confidence level (High/Medium/Low). If the confidence level is not "High", add a step to use the **brainstorming agent** (Researcher with Brainstorming Protocol) to find solutions and propose alternatives before finalizing the plan.
9. **Design Validation** — If the feature has UI and no design mockup or Figma link is provided, **suggest the user generate mock designs using HTML/CSS** to validate the visual direction before implementation. Offer to create a quick HTML/CSS prototype for the user to review. Visual validation upfront prevents costly rework later. **Add `title` tooltips to key elements** with metaphor-based explanations of how they work and why they exist — making the prototype self-documenting.

### STEP ZERO — Ask Questions (MANDATORY)

> **Before doing ANYTHING else — before auditing code, before reading files, before creating a plan — you MUST ask the user at least 5 clarifying questions using `AskQuestion`.** This is the very first action in Phase 1. No exceptions. Five questions is the MINIMUM — even if the task seems perfectly clear, there are always hidden assumptions worth surfacing.

### Planning Tasks
1. **Spawn plan agent** to:
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
   - **Create positive base case test document** at `docs/features/[feature-name]/test-cases.md` *(if "Test cases document" was enabled in pre-flight)*:
     - Derive one positive (happy-path) test case per AC item / Gherkin scenario.
     - Format: `TC-1: [AC/Scenario reference] — Given [precondition], When [action], Then [expected positive outcome]`.
     - This document serves as the test plan and is referenced during verification.
   - `.feature` files with Gherkin scenarios matching AC items.
   - Unit tests and step definitions mapping Gherkin to code.
   - **Run all tests to confirm they fail.**
   - **Update AC document**: Link each AC item to corresponding `.feature` file and line.
   - **If "Testing guide" was enabled in pre-flight**: Create `docs/features/[feature-name]/testing-guide.md` with manual testing instructions, prerequisites, and test credentials (if applicable).

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
1. **Phase Compliance Self-Check** — Before writing the summary, verify ALL phases were executed by reviewing the Phase Gates table and `workflow.md`. If any enabled phase was not executed, **STOP and go execute it now.** Specifically confirm:
   - [ ] Phase 0: Pre-flight questions answered, `workflow.md` created, POCs completed (if requested)
   - [ ] Phase 1: Plan agent spawned, User Journey Map + AC doc with Gherkin created, user approved
   - [ ] Phase 2: Code-tester spawned, .feature files + step defs written, confirmed to fail
   - [ ] Phase 3: Code-architect spawned, all BDD scenarios + unit tests pass
   - [ ] Phase 4: Code-refactorer spawned, code improved, tests green
   - [ ] Phase 5: UX-designer spawned (or disabled in pre-flight / backend-only)
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
