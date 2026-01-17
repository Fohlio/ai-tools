---
name: poc-hypothesis
description: Create minimal POC to validate technical hypotheses. Reuse/call existing code, or write new if needed. Report success or propose alternatives on failure.
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
2. **Build** minimal POC using existing code when possible
3. **Test** and evaluate results
4. **Report** success or propose alternatives if failed

## Procedure

### Step 1: Clarify Hypothesis

Ask the user:
- What are we trying to prove/disprove?
- What is the expected outcome if successful?
- What are the acceptance criteria?

### Step 2: Choose Approach

| Scenario | Action |
|----------|--------|
| Server code exists | Reuse or call it directly |
| Server code exists but needs isolation | Duplicate relevant parts for POC |
| Server code doesn't exist | Write minimal implementation |

### Step 3: Build POC

```
Rules:
- Minimal scope — only what's needed to validate
- No production polish — skip error handling, edge cases
- Prefer existing code — import/call when possible
- Document assumptions made
```

### Step 4: Validate

**If successful:**
1. Report what was proven
2. Show evidence (logs, screenshots, metrics)
3. Recommend next steps (integrate, expand, etc.)

**If failed:**
1. Diagnose what didn't work
2. Propose alternatives:
   - **A: Adjust hypothesis** — modify assumptions, re-test
   - **B: Different approach** — same goal, new implementation
   - **C: Pivot** — abandon path, explore alternatives
   - **D: Investigate** — need more research
3. Wait for user decision before proceeding

### Step 5: Cleanup

- Document findings (original hypothesis, approach, results)
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

- **Speed over polish** — POC is throwaway code
- **Fail fast** — Report issues immediately
- **Minimal scope** — Only build what validates
- **Reuse first** — Check existing code before writing
- **User decides** — Present options, let user choose
- **Document learnings** — Even failed POCs are valuable
