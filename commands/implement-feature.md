---
name: implement-feature
description: Full feature implementation workflow with planning, testing, coding, review, and verification
allowed-tools: Task, Read, Glob, Grep, Edit, Write, Bash, AskUserQuestion, TodoWrite
---

# Feature Implementation Workflow

You are orchestrating a complete feature implementation pipeline. Follow these phases strictly and do not skip any step.

## Phase 1: Discovery & Planning

1. **Spawn plan agent** to:
   - Read the feature file specified by the user ($ARGUMENTS)
   - Analyze requirements and gather context from documentation
   - Create a phased implementation plan (roadmap) with priorities (P0-P2) and T-shirt sizes (XS-XL)
   - Identify files to create/modify and note potential risks or blockers

2. **Present the roadmap to user** and wait for explicit approval before proceeding

## Phase 2: Test-First Design

Once user approves the plan:

1. **Spawn code-tester agent** to create test cases:
   - Acceptance tests based on requirements
   - Edge cases and error scenarios
   - Do NOT implement yet - just define test specifications

2. **Review test specs with user** - ensure coverage is adequate

## Phase 3: Implementation

After test specs are approved:

1. **Spawn code-architect agent** to implement the feature:
   - Follow the approved plan
   - Write clean, production-ready code
   - Adhere to existing patterns in the codebase

## Phase 4: Code Quality

After implementation:

1. **Spawn code-simplifier:code-simplifier agent** to review:
   - Check for over-engineering
   - Improve readability and scalability
   - Suggest simplifications if needed
   - Apply approved changes

## Phase 5: Testing

After code quality pass:

1. **Spawn code-tester agent** again to:
   - Implement the test specifications from Phase 2
   - Add unit tests for new code
   - Run all tests and fix failures

## Phase 6: UX Review (Conditional)

If the feature has UI/UX components:

1. **Spawn ux-optimiser agent** to:
   - Audit the user interface
   - Check accessibility
   - Validate user flows
   - Suggest improvements

Skip this phase if the feature is backend-only or has no user-facing elements.

## Phase 7: Build Verification

Final phase:

1. **Spawn build-verificator agent** to:
   - Verify the build compiles without errors
   - Check for runtime issues
   - Validate against acceptance criteria
   - Confirm production readiness

## Completion

After all phases complete successfully:
- Summarize what was implemented
- List all files created/modified
- Note any follow-up items or technical debt
- Mark all todos as completed

---

## Important Rules

- **Never skip phases** - each builds on the previous
- **Always wait for user approval** after Phase 1 planning
- **Run agents sequentially** - do not parallelize phases
- **If any phase fails**, stop and report the issue before continuing
- **Keep user informed** of progress between phases
