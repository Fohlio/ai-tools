---
name: implement-feature
description: Standard feature implementation workflow (Plan -> Implement -> Test -> Refactor -> Verify)
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite
---

# Feature Implementation Workflow

You are orchestrating a complete feature implementation pipeline. This workflow is suitable for general features where rapid development is prioritized while maintaining quality.

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
   - Audit existing codebase for reusable components and patterns.
   - Ask clarifying questions to the user.
   - Create a phased roadmap with priorities (P0-P2) and T-shirt sizes.
   - Identify files to create/modify and potential risks.

2. **Present roadmap** to user and wait for explicit approval.

## Phase 2: Implementation

1. **Spawn code-architect agent** to implement:
   - Follow the approved plan.
   - Write clean, production-ready code.
   - Adhere to existing patterns in the codebase.

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
1. **Spawn ux-designer agent** to audit UI, accessibility, and user flows.
Skip if backend-only.

## Phase 6: Build Verification

1. **Spawn build-verificator agent** to:
   - Verify the build compiles without errors.
   - **Requirement Audit**: Ensure all requirements and recommendations from previous steps/agents are met.
   - **Technical Validation**: Run full test suite and check for runtime issues.
   - **Agent Handoff Check**: Verify that all expert advice was either implemented, communicated, or logged.

## Completion
- Summarize implementation and list modified files.
- Report test results and metrics.
- Note follow-up items or technical debt.
- Mark all todos as completed.
