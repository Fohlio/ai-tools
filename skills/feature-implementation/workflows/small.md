# Small Feature Implementation Workflow

This lightweight workflow covers **Planning, Implementation, and Refactoring** — suitable for small, well-scoped features that don't need the full 7-phase pipeline.

---

## MANDATORY EXECUTION PROTOCOL

> **All phases below are MANDATORY.**

**Hard rules:**
- **ALWAYS ask clarifying questions at the start of Phase 1.** This is non-negotiable — even if the task seems clear. Use `AskQuestion` before creating any plan.
- **NEVER do a phase's work yourself.** Spawn the named agent via `Task` tool.
- **If unsure, ask the user.** Do not assume anything.

### Phase Gates

| Gate | Agent to spawn | Confirm before proceeding |
|------|---------------|--------------------------|
| Phase 1: Planning | `plan` | Clarifying questions asked. Plan created. **User approved.** |
| Phase 2: Implementation | `code-architect` | Implementation complete. Build passes. |
| Phase 3: Refactoring | `code-refactorer` | Code reviewed and improved. Build still passes. |

---

## Phase 1: Discovery & Planning

### STEP ZERO — Ask Questions (MANDATORY)

> **Before doing ANYTHING else — before auditing code, before reading files, before creating a plan — you MUST ask the user clarifying questions using `AskQuestion`.** This is the very first action in Phase 1. No exceptions.

Questions to cover:
- What exactly should happen? What is the expected behavior?
- What is in scope vs. deferred?
- Are there edge cases that matter?
- Are there existing constraints, preferences, or design decisions?
- What does "done" look like for this feature?

**Do NOT proceed to planning until the user has answered.**

### Planning Principles

1. **Audit before building** — Search the codebase for existing components, utilities, and patterns. Reuse first.
2. **No placeholders** — Fully implement features. Never leave `TODO` or `FIXME`.
3. **Minimize invention** — Prefer existing libraries and project abstractions.
4. **Map integration surfaces** — Identify how new code connects to existing systems.
5. **Explicit Approval** — Present the plan and wait for approval before implementing.

### Planning Tasks
1. **Spawn plan agent** to:
   - Read requirements and gather context.
   - Audit existing codebase for reusable components and patterns.
   - Create a concise implementation plan: files to create/modify, approach, and risks.
   - Present plan to user and wait for approval.

## Phase 2: Implementation

1. **Spawn code-architect agent** to implement:
   - Follow the approved plan.
   - Write clean, production-ready code.
   - Adhere to existing patterns in the codebase.
   - Run the build to confirm it passes.

## Phase 3: Refactoring & Quality

1. **Spawn code-refactorer agent** to:
   - Review code for over-engineering and readability.
   - Suggest and apply simplifications while keeping the build green.
   - Run the build after each change.

## Completion
1. **Summary**:
   - Summarize implementation and list modified files.
   - Note any follow-up items (testing, documentation) the user may want to do separately.
