---
name: implement-tdd-feature
description: TDD feature implementation workflow — tests first, then implementation, refactoring, review, and verification
---

# TDD Feature Implementation Skill

## When to Use This Skill

- User wants to implement a feature using Test-Driven Development
- User explicitly asks for "TDD" or "test-first" approach
- User has a feature specification and wants tests before code
- User wants rigorous testing coverage from the start
- User mentions Red-Green-Refactor workflow

## How It Works

This skill orchestrates a full TDD pipeline with these phases:

1. **Discovery & Planning** — Analyze requirements, audit codebase, create roadmap
2. **Test Specification (Red)** — Write failing tests first
3. **Implementation (Green)** — Write minimum code to pass tests
4. **Refactoring** — Improve code while keeping tests green
5. **UX Review** — Audit UI/UX (if applicable)
6. **Build Verification** — Final validation and readiness check

## Procedure

### Phase 1: Discovery & Planning

#### Planning Principles

Before creating the implementation plan, enforce these constraints:

1. **Audit before building** — Search the codebase for existing components, utilities, and patterns that solve similar problems. Reuse first.
2. **No placeholders** — Every requested feature must be fully implemented. Never leave `TODO`, `FIXME`, or stub comments. If scope needs trimming, explicitly ask to defer.
3. **Minimize invention** — Prefer existing libraries, framework features, and project abstractions over custom solutions. Build only what doesn't exist.
4. **Map integration surfaces** — Identify how new code connects to existing systems. Verify APIs, props, and data flows before implementation.

#### Planning Tasks

1. **Analyze requirements**:
   - Read the feature file specified by the user
   - Analyze requirements and gather context from documentation
   - **Audit existing codebase** for reusable components, utilities, and patterns

2. **Ask clarifying questions**:
   - Resolve any ambiguities or missing requirements
   - Confirm scope and acceptance criteria

3. **Create implementation roadmap**:
   - Phased plan with priorities (P0-P2) and T-shirt sizes (XS-XL)
   - Identify files to create/modify
   - Note potential risks or blockers
   - **Flag existing infrastructure** to leverage
   - **Define test cases** that will validate the feature

4. **Present roadmap to user** and wait for explicit approval

### Phase 2: Test Specification (Red Phase)

Once user approves the plan:

1. **Write tests FIRST**:
   - Write failing test cases based on requirements and acceptance criteria
   - Define unit tests for expected behavior
   - Define integration tests for system interactions
   - Tests should clearly document expected behavior

2. **Run tests to confirm they fail** (Red phase)
   - This validates tests are actually testing something
   - Failing tests prove the feature doesn't exist yet

### Phase 3: Implementation (Green Phase)

After tests are written and failing:

1. **Implement the feature**:
   - Follow the approved plan
   - Write **minimum code necessary** to make tests pass
   - Adhere to existing patterns in the codebase

2. **Run tests after implementation**
   - Confirm all tests pass (Green phase)
   - Do not over-engineer — just make tests green

### Phase 4: Refactoring

After tests pass:

1. **Refactor for quality**:
   - Improve code quality while keeping tests green
   - Check for over-engineering
   - Improve readability and scalability
   - Apply simplifications

2. **Run tests after each refactoring**
   - Ensure nothing breaks
   - Maintain green state throughout

### Phase 5: UX Review (Conditional)

If the feature has UI/UX components:

1. **Audit the user interface**:
   - Check accessibility
   - Validate user flows
   - Suggest improvements

**Skip this phase** if the feature is backend-only or has no user-facing elements.

### Phase 6: Build Verification

Final phase:

1. **Verify build compiles** without errors
2. **Run full test suite** and confirm all tests pass
3. **Check for runtime issues**
4. **Validate against acceptance criteria**
5. **Confirm production readiness**

### Completion

After all phases complete successfully:

- Summarize what was implemented
- List all files created/modified
- Report test coverage metrics
- Note any follow-up items or technical debt

## Important Rules

| Rule | Description |
|------|-------------|
| **Tests before code** | Never implement before tests exist |
| **Never skip phases** | Each phase builds on the previous |
| **Wait for approval** | Always wait for user approval after Phase 1 |
| **Sequential execution** | Do not parallelize phases |
| **Stop on failure** | If any phase fails, stop and report before continuing |
| **Keep user informed** | Report progress between phases |
| **Red-Green-Refactor** | Follow the TDD cycle strictly |

## Examples

### Example 1: API Endpoint

```
User: Implement user registration endpoint with email validation

TDD Flow:
1. Plan: Audit existing auth code, identify patterns
2. Red: Write tests for registration endpoint
   - Test valid registration succeeds
   - Test duplicate email fails
   - Test invalid email format fails
3. Green: Implement minimum code to pass tests
4. Refactor: Clean up, extract validation helpers
5. Verify: Run full test suite
```

### Example 2: React Component

```
User: Add a sortable data table component

TDD Flow:
1. Plan: Check for existing table components, design patterns
2. Red: Write tests for table rendering, sorting behavior
   - Test renders data correctly
   - Test column headers are clickable
   - Test sorting toggles asc/desc
3. Green: Implement table with basic sorting
4. Refactor: Extract sorting logic, optimize renders
5. UX Review: Check accessibility, keyboard navigation
6. Verify: Build compiles, all tests pass
```

### Example 3: Service Integration

```
User: Integrate Stripe payment processing

TDD Flow:
1. Plan: Review existing payment code, Stripe docs
2. Red: Write tests for payment flow
   - Test successful payment
   - Test card declined handling
   - Test webhook processing
3. Green: Implement Stripe integration
4. Refactor: Extract payment service, add error handling
5. Verify: All tests pass, sandbox payments work
```

## When NOT to Use

- For simple one-line fixes (just fix it directly)
- When user explicitly wants code without tests
- For exploratory/prototype work (use `poc-hypothesis` instead)
- For refactoring existing code without new features
