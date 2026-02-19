---
name: ai-tools:poc-hypothesis
description: Creates minimal POC to validate technical hypotheses, reusing existing code or writing new if needed. Use when testing technical feasibility, validating approaches before full implementation, or when the user asks "will this work?" or "can we do X?"
---

# POC Hypothesis Validation Skill

## When to Use This Skill

- User wants to test a technical hypothesis or assumption
- User needs to validate an approach before full implementation
- User asks "will this work?" or "can we do X?"
- User wants to prototype a solution quickly
- Before committing to a large feature, need to prove feasibility

## How It Works

1. **Define** the hypothesis with clear success criteria
2. **Brainstorm** multiple hypotheses — suggest several approaches to validate
3. **Build** minimal POC for the most promising hypothesis first
4. **Test** and evaluate results — if it fails, move to the next hypothesis
5. **Iterate** through hypotheses one by one until one works or all are exhausted
6. **Report** success or propose alternatives if all failed

## Procedure

### Step 1: Clarify Hypothesis

Infer the hypothesis, success criteria, and expected outcome from the user's message and codebase context — don't ask clarifying questions, just start.

### Step 2: Suggest Multiple Hypotheses

Before building anything, brainstorm **2-4 hypotheses** (approaches) that could solve the problem:

```
Format:
H1: [Most promising approach] — Why it might work
H2: [Alternative approach] — Why it might work
H3: [Fallback approach] — Why it might work
```

- Rank by likelihood of success and implementation effort
- Present all hypotheses to the user
- Start with H1, move to H2 on failure, and so on
- Each hypothesis gets its own build-test cycle — don't skip ahead

### Step 3: Choose Approach

| Scenario | Action |
|----------|--------|
| Server code exists | Reuse or call it directly |
| Server code exists but needs isolation | Duplicate relevant parts for POC |
| Server code doesn't exist | Write minimal implementation |
| Hypothesis needs live endpoint testing | Add a temporary BE endpoint (see Step 3b) |

### Step 3a: Build POC

```
Rules:
- Minimal scope — only what's needed to validate
- No production polish — skip error handling, edge cases
- Prefer existing code — import/call when possible
- Document assumptions made
- Label which hypothesis (H1/H2/H3) is being tested
- NO mocks, stubs, fakes, or simulated data — use real APIs, real DB, real services
- NO shortcuts or imitations — if the hypothesis is about sending email, actually send an email
- This is production-grade validation: real network calls, real data, real infrastructure
```

### Step 3b: Self-Testable BE Endpoint (when applicable)

If the hypothesis involves backend logic, API integration, data processing, or any server-side behavior — spin up a temporary endpoint to test it yourself:

```
Endpoint rules:
- Add a dedicated route: POST /api/poc/<hypothesis-name>
- Protect with a token signature: require `Authorization: Bearer <POC_TOKEN>` header
- Include structured logging: log input, processing steps, output, and timing
- Keep it isolated — don't pollute existing routes or middleware
- After validation, call the endpoint yourself (via curl/fetch) and capture results
- Include the endpoint response + logs as evidence in the report
```

```
Example:
POST /api/poc/websocket-latency
Headers: Authorization: Bearer poc_test_abc123
Body: { "payload": "test", "iterations": 100 }
Response: { "success": true, "avg_latency_ms": 12, "p99_latency_ms": 45 }
Logs: timestamped entries for each step
```

This makes the POC self-verifiable — you test the hypothesis end-to-end without relying on manual user testing.

### Step 4: Validate & Iterate

**If current hypothesis succeeds:**
1. Report what was proven
2. Show evidence (logs, endpoint responses, screenshots, metrics)
3. Recommend next steps (integrate, expand, etc.)

**If current hypothesis fails:**
1. Diagnose what didn't work and why
2. Document the failure (this is valuable data)
3. **Automatically move to the next hypothesis** — don't stop
4. Repeat Steps 3a/3b → 4 for the next hypothesis
5. Continue until one succeeds or all are exhausted

**If ALL hypotheses fail:**
1. Summarize what was tried and why each failed
2. Propose new directions:
   - **A: New hypotheses** — based on learnings from failures
   - **B: Pivot** — the goal itself may need rethinking
   - **C: Investigate deeper** — need more research before next attempt
3. Wait for user decision before proceeding

### Step 5: Cleanup

- Document findings for **each hypothesis tested** (approach, results, why it passed/failed)
- Remove temporary BE endpoints and POC tokens
- Decide on POC code: keep / integrate / delete

## Examples

**User**: "Can we use WebSockets instead of polling for real-time updates?"

**Expected behavior**:
1. Check if WebSocket server code exists
2. If yes, create minimal client to test connection
3. If no, write basic WebSocket server + client
4. Test message roundtrip
5. Report latency vs polling approach
6. Recommend: proceed with WS or stick with polling

**User**: "Will this external API handle our load?"

**Expected behavior**:
1. Create minimal script to call the API
2. Run load test (10, 100, 1000 requests)
3. Measure response times and error rates
4. Report findings with metrics
5. Recommend: use API / need caching / find alternative

**User**: "Can we render 10,000 items without lag?"

**Expected behavior**:
1. Check for existing list/virtualization components
2. Create test with 10,000 dummy items
3. Measure render time, scroll performance
4. If slow, try virtualization (reuse existing or add library)
5. Report: works / needs optimization / needs different approach

## Important Rules

- **Real validation only** — No mocks, stubs, fakes, or simulated paths. Hit real APIs, real DB, real services. If you can't prove it works for real, you haven't proven anything
- **Speed over polish** — POC is throwaway code
- **Fail fast, try next** — Don't stop at the first failure, move to the next hypothesis
- **Minimal scope** — Only build what validates
- **Reuse first** — Check existing code before writing
- **Self-test when possible** — Spin up endpoints and verify yourself before reporting
- **User decides** — Present options, let user choose
- **Document learnings** — Every failed hypothesis narrows the search space
- **Clean up after** — Remove POC endpoints and tokens when done
