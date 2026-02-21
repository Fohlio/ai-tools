# Standard Feature Implementation Workflow

This workflow is suitable for general features where rapid development is prioritized while maintaining quality.

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
- **NEVER skip a phase** unless explicitly disabled in the pre-flight `workflow.md`. Only Phase 3 (Testing) and Phase 5 (UX Review) can be disabled via pre-flight — state skipped phases to the user.
- **NEVER do a phase's work yourself.** Spawn the named agent via `Task` tool.
- **NEVER mark workflow complete** before Phase 7 (Documentation) is done.
- **If unsure, ask the user.** Do not assume any phase is unnecessary.

### Phase Gates

| Gate | Agent to spawn | Confirm before proceeding |
|------|---------------|--------------------------|
| Phase 0: Pre-flight | orchestrator | Pre-flight questions answered. `workflow.md` created. POCs completed (if requested). |
| Phase 1: Planning | `plan` | User Journey Map, AC document, roadmap created. **User approved.** |
| Phase 2: Implementation | `code-architect` | Implementation complete. User asked about visualization. |
| Phase 3: Testing | `code-tester` | Tests written per AC. All pass. AC doc updated. |
| Phase 4: Refactoring | `code-refactorer` | Code reviewed and improved. Tests still green. |
| Phase 5: UX Review | `ux-designer` | User flows validated, UI consistency checked — or skipped (zero-UI, stated to user). |
| Phase 6: Verification | `build-verificator` | AC verified. Full suite passes. |
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
   - `Test phase (automated tests)`
   - `Design/UX review phase`
   - `Testing guide (manual testing instructions)`
   - `Test cases document (positive base cases from AC)`

### Create Workflow Document

After collecting all pre-flight answers, create `docs/features/[feature-name]/workflow.md` capturing all decisions and the active phases list. Mark disabled phases accordingly.

### Execute POCs (if requested)

- **If Visual POC was selected**: Use the `visual-poc` skill. Save to `docs/features/[feature-name]/visual-poc.html`. Present to user before proceeding.
- **If Technical POC was selected**: Use the `poc-hypothesis` skill. Proceed only after the approach is validated.

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
   - Audit existing codebase for reusable components and patterns.
   - **Create Acceptance Criteria & Verification Checklist** — Save to existing PRD or create new document:
     - **Location**: Add to existing PRD if available, otherwise create `docs/features/[feature-name]/ac.md`.
     - **Acceptance Criteria (AC)**: List testable conditions.
     - **Verification Checklist**: Concrete checklist for build-verificator agent.
   - Create a phased roadmap with priorities (P0-P2) and T-shirt sizes.
   - Identify files to create/modify and potential risks.

2. **Present roadmap** to user and wait for explicit approval.

## Phase 2: Implementation

1. **Spawn code-architect agent** to implement:
   - Follow the approved plan.
   - Write clean, production-ready code.
   - Adhere to existing patterns in the codebase.

2. **Ask the user** if they want a visualization or explanation of the coding solution.
   - If yes, create a simple, beautiful HTML file (`docs/features/[feature-name]/code-explanation.html`) explaining how the solution works.

## Phase 3: Testing

> **Skip this phase if "Test phase" was disabled in pre-flight `workflow.md`. State this to the user.**

1. **Spawn code-tester agent** to:
   - **Read AC document** — use Acceptance Criteria as test case source.
   - **Create positive base case test document** at `docs/features/[feature-name]/test-cases.md` *(if "Test cases document" was enabled in pre-flight)*:
     - Derive one positive (happy-path) test case per AC item.
     - Format: `TC-1: [AC reference] — Given [precondition], When [action], Then [expected positive outcome]`.
   - Write automated tests based on requirements.
   - Add unit tests for new code.
   - Run all tests and fix any failures.
   - **If "Testing guide" was enabled in pre-flight**: Create `docs/features/[feature-name]/testing-guide.md` with manual testing instructions.

## Phase 4: Refactoring & Quality

1. **Spawn code-refactorer agent** to:
   - Review code for over-engineering and readability.
   - Suggest and apply simplifications while keeping tests green.
   - Run all tests after each change.

## Phase 5: UX Review (Conditional)

If the feature has UI components:
1. **Spawn ux-designer agent** to:
   - **Validate user flows** — Walk through the User Journey Map. Verify each step works as intended and transitions are smooth.
   - **Check UI consistency** — Ensure components match design system and existing patterns.
   - **Review error states** — Confirm error messages are clear and recovery paths exist.
   - Accessibility is secondary to flow correctness — focus on user experience first.
Skip if backend-only.

## Phase 6: Build Verification

1. **Spawn build-verificator agent** to:
   - Verify the build compiles without errors.
   - **Requirement Audit**: Ensure all requirements and recommendations from previous steps/agents are met.
   - **Technical Validation**: Run full test suite and check for runtime issues.
   - **Agent Handoff Check**: Verify that all expert advice was either implemented, communicated, or logged.

## Phase 7: Documentation & Archiving

1. **Spawn librarian agent** to:
   - Update project documentation (README, API docs, etc.) to reflect changes.
   - **Update `CHANGELOG.md`** following the "Keep a Changelog" standard.
   - Log the implementation in the project's knowledge base.
   - Archive or delete any documentation that is now obsolete.
   - Ensure best practices for IT documentation are followed.

## Completion
1. **Phase Compliance Self-Check** — Verify ALL phases were executed by reviewing the Phase Gates table and `workflow.md`. If any enabled phase was not executed, **STOP and go execute it now.** Confirm Phase 0 (Pre-flight) was completed and `workflow.md` exists.
2. **Session Analysis**: Brief retrospective — what worked, what didn't, how to improve.
3. **Propose Improvements**: 2-3 ways to enhance the feature or reduce tech debt.
4. **Final Summary**:
   - Summarize implementation and list modified files.
   - Report test results and metrics.
   - Note follow-up items or technical debt.
   - Mark all todos as completed.
