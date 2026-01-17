# implement-tdd-feature

A Claude Code skill for implementing features using Test-Driven Development (TDD). Tests are written BEFORE implementation, following the Red-Green-Refactor cycle.

## Adding This Skill to Your Project

Copy the `implement-tdd-feature` folder to your project's `.claude/skills/` directory:

```bash
# From your project root
mkdir -p .claude/skills
cp -r /path/to/ai-tools/skills/implement-tdd-feature .claude/skills/
```

## Using the Skill

Start Claude Code in your project and reference a feature specification:

```
Implement the user authentication feature using TDD
```

```
TDD implementation of the shopping cart from docs/features/cart.md
```

```
Build the notification service test-first
```

## Workflow Overview

### The TDD Cycle: Red-Green-Refactor

```
┌─────────┐     ┌─────────┐     ┌──────────┐
│   RED   │────▶│  GREEN  │────▶│ REFACTOR │
│ (tests  │     │ (make   │     │ (improve │
│  fail)  │     │  pass)  │     │  code)   │
└─────────┘     └─────────┘     └──────────┘
     ▲                               │
     └───────────────────────────────┘
```

### Full Pipeline

| Phase | Description | Output |
|-------|-------------|--------|
| 1. Planning | Analyze requirements, audit codebase | Roadmap with test cases |
| 2. Red | Write failing tests | Test suite (failing) |
| 3. Green | Implement minimum code | Tests passing |
| 4. Refactor | Improve code quality | Clean, maintainable code |
| 5. UX Review | UI/UX audit (if applicable) | UX improvements |
| 6. Verification | Final build and test check | Production-ready code |

## Phase Details

### Phase 1: Discovery & Planning

Claude will:
1. Read your feature specification
2. Audit existing codebase for reusable patterns
3. Ask clarifying questions
4. Create a prioritized roadmap (P0-P2, XS-XL sizing)
5. Define test cases upfront
6. **Wait for your approval** before proceeding

### Phase 2: Test Specification (Red)

Before any implementation:
- Unit tests for expected behavior
- Integration tests for system interactions
- Tests run and **confirm they fail**

This proves tests are meaningful and feature doesn't exist yet.

### Phase 3: Implementation (Green)

Write **minimum code** to make tests pass:
- No over-engineering
- No extra features
- Just make the tests green

### Phase 4: Refactoring

With green tests as safety net:
- Improve code quality
- Remove duplication
- Enhance readability
- Tests must stay green after each change

### Phase 5: UX Review (Conditional)

For UI features:
- Accessibility audit
- User flow validation
- Improvement suggestions

Skipped for backend-only features.

### Phase 6: Build Verification

Final checks:
- Build compiles without errors
- Full test suite passes
- Runtime validation
- Acceptance criteria met

## Example Session

```
User: Implement user registration with email validation

Claude:
📋 Phase 1: Planning
- Auditing existing auth code...
- Found: AuthService, ValidationUtils, UserRepository
- Questions:
  1. Should registration send confirmation email?
  2. What password requirements?
  
User: Yes to email, min 8 chars with number

Claude:
📋 Roadmap:
- P0 [M]: Registration endpoint with validation
- P0 [S]: Email confirmation flow
- P1 [S]: Password strength validation

Test cases:
✓ Valid registration succeeds
✓ Duplicate email returns 409
✓ Invalid email format returns 400
✓ Weak password returns 400
✓ Confirmation email is sent

Approve to proceed? (y/n)

User: y

Claude:
🔴 Phase 2: Writing tests...
- Created: tests/auth/registration.test.ts
- Running tests... 5 failing ✓

🟢 Phase 3: Implementing...
- Created: src/auth/registration.ts
- Modified: src/auth/AuthService.ts
- Running tests... 5 passing ✓

🔧 Phase 4: Refactoring...
- Extracted: src/utils/passwordValidator.ts
- Running tests... 5 passing ✓

✅ Phase 6: Verification
- Build: ✓
- Tests: 5/5 passing
- Ready for production

Summary:
- Files created: 2
- Files modified: 1
- Test coverage: 94%
```

## Key Principles

| Principle | Why It Matters |
|-----------|----------------|
| **Tests first** | Defines behavior before implementation |
| **Minimum code** | Avoids over-engineering |
| **Continuous testing** | Catches regressions immediately |
| **Audit before building** | Reuses existing code |
| **Sequential phases** | Each phase builds on previous |
| **User gates** | You approve before major work begins |

## When NOT to Use

| Scenario | Better Alternative |
|----------|-------------------|
| Quick one-line fix | Just fix it directly |
| User wants no tests | Use `/c-implement-feature` |
| Exploratory prototype | Use `poc-hypothesis` skill |
| Pure refactoring | Use `code-refactorer` agent |

## Requirements

- Project should have a test framework configured (Jest, Vitest, pytest, etc.)
- Feature specification or clear requirements
- Time for the full TDD cycle (worth it for quality)
