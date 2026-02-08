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
- **NEVER skip a phase.** Only Phase 5 (UX Review) may be skipped for zero-UI features — state this to the user first.
- **NEVER do a phase's work yourself.** Spawn the named agent via `Task` tool.
- **NEVER mark workflow complete** before Phase 7 (Documentation) is done.
- **If unsure, ask the user.** Do not assume any phase is unnecessary.

### Phase Gates

| Gate | Agent to spawn | Confirm before proceeding |
|------|---------------|--------------------------|
| Phase 1: Planning | `plan` | User Journey Map, AC document, roadmap created. **User approved.** |
| Phase 2: Implementation | `code-architect` | Implementation complete. User asked about visualization. |
| Phase 3: Testing | `code-tester` | Tests written per AC. All pass. AC doc updated. |
| Phase 4: Refactoring | `code-refactorer` | Code reviewed and improved. Tests still green. |
| Phase 5: UX Review | `ux-designer` | User flows validated, UI consistency checked — or skipped (zero-UI, stated to user). |
| Phase 6: Verification | `build-verificator` | AC verified. Full suite passes. |
| Phase 7: Documentation | `librarian` | Docs, CHANGELOG updated. |

---

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
   - Audit existing codebase for reusable components and patterns.
   - Ask clarifying questions to the user.
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

1. **Spawn code-tester agent** to:
   - Write tests based on requirements.
   - Add unit tests for new code.
   - Run all tests and fix any failures.

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
1. **Phase Compliance Self-Check** — Verify ALL 7 phases were executed by reviewing the Phase Gates table. If any phase was not executed, **STOP and go execute it now.**
2. **Session Analysis**: Brief retrospective — what worked, what didn't, how to improve.
3. **Propose Improvements**: 2-3 ways to enhance the feature or reduce tech debt.
4. **Final Summary**:
   - Summarize implementation and list modified files.
   - Report test results and metrics.
   - Note follow-up items or technical debt.
   - Mark all todos as completed.
