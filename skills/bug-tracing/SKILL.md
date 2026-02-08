---
name: bug-tracing
description: Systematic bug diagnosis through architecture analysis, hypothesis-driven debugging, and instrumented logging. Injects a lightweight debug logger into the codebase, asks the user to reproduce, then analyzes logs to confirm the root cause. Use when a bug is hard to reproduce, the cause is unclear, or printf-debugging would help.
allowed-tools: Bash(cat *), Bash(> *), Read, Edit, Write, Grep, Glob
---

# Bug Tracing Skill

## When to Use This Skill

- User reports a bug but the root cause is unclear
- Bug is hard to reproduce or intermittent
- Stack trace is missing or misleading
- Multiple code paths could be responsible
- Need to understand what actually happens at runtime vs what should happen

## How It Works

1. **Analyze** the architecture around the bug
2. **Understand** the reproduction steps
3. **Hypothesize** multiple root causes
4. **Instrument** the code with the bundled debug logger to validate all hypotheses at once
5. **User reproduces** the bug with instrumentation active
6. **Analyze logs** to confirm or eliminate hypotheses
7. **Iterate** if confidence is low
8. **Fix** the confirmed root cause
9. **User verifies** the fix

## The Debug Logger

Pre-built scripts bundled with this skill. Copy the appropriate one into the target project's `tmp/` directory.

| Project language | Source script | Copy to |
|---|---|---|
| TypeScript | [scripts/debug-logger.ts](scripts/debug-logger.ts) | `tmp/debug-logger.ts` |
| JavaScript (CJS) | [scripts/debug-logger.js](scripts/debug-logger.js) | `tmp/debug-logger.js` |
| Python | [scripts/debug_logger.py](scripts/debug_logger.py) | `tmp/debug_logger.py` |

For other languages — adapt the same pattern: append a JSON line `{t, h, loc, data}` to `tmp/debug.log`.

### API

```
debugTrace(hypothesis, location, data?)  — write a trace entry
debugClear()                             — clear log before reproduction
debugHasLogs()                           — check if log file exists
```

Each log entry is a single JSON line:

```json
{"t":"2026-02-08T14:23:01.123Z","h":"H1","loc":"processOrder:entry","data":{"orderId":42,"status":"pending"}}
```

### Properties

- **Zero-dependency** — no npm packages, no pip installs
- **Non-invasive** — does not alter application behavior, only observes
- **Structured** — every entry tagged with hypothesis + location
- **Greppable** — JSON lines, filter by `"h":"H1"` to see one hypothesis

## Procedure

### Step 1: Analyze Architecture

Read the code around the reported bug area. Understand:

- Data flow: where does the input enter, how is it transformed, where does it exit
- Component boundaries: which modules/services/layers are involved
- State management: what state is read/written and when
- Side effects: network calls, DB writes, event emissions, timers

Do this silently — don't ask the user to explain the architecture.

### Step 2: Understand Reproduction Steps

Infer reproduction steps from the user's bug report. If the steps are ambiguous or missing, ask the user for exact steps — this is the one place where you ask questions:

```
To instrument the right code paths, I need the exact reproduction steps.
Please list them: what do you click, what do you type, what do you see?
```

### Step 3: Form Hypotheses

Brainstorm **3-5 hypotheses** for the root cause:

```
H1: [Most likely cause] — evidence: [why you suspect this]
H2: [Second candidate] — evidence: [why]
H3: [Third candidate] — evidence: [why]
H4: [Less likely but possible] — evidence: [why]
```

Present hypotheses to the user briefly, then immediately proceed to instrumentation — don't wait for approval.

### Step 4: Instrument the Code

1. **Copy the debug logger** from this skill's `scripts/` into the target project's `tmp/` directory:

```bash
# For a TS project:
cp ~/.claude/skills/bug-tracing/scripts/debug-logger.ts <project>/tmp/debug-logger.ts

# For a JS project:
cp ~/.claude/skills/bug-tracing/scripts/debug-logger.js <project>/tmp/debug-logger.js

# For a Python project:
cp ~/.claude/skills/bug-tracing/scripts/debug_logger.py <project>/tmp/debug_logger.py
```

If the skill is installed at a different path (e.g. `.claude/skills/`), adjust accordingly. The key: copy the real file, don't recreate it from memory.

2. **Place `debugTrace()` calls** at strategic points that will confirm or eliminate each hypothesis:

```
Rules:
- Tag every trace with the hypothesis it validates (H1, H2, H3...)
- Place traces at entry/exit of suspected functions
- Log the actual values of variables you suspect are wrong
- Log conditional branches to see which path is taken
- Log timing for suspected race conditions
- One instrumentation pass should cover ALL hypotheses — don't instrument one at a time
```

Example instrumentation:

```typescript
import { debugTrace } from '../tmp/debug-logger';

function processOrder(order: Order) {
  debugTrace('H1', 'processOrder:entry', { orderId: order.id, status: order.status });

  if (order.status === 'pending') {
    debugTrace('H2', 'processOrder:pending-branch', { items: order.items.length });
    // ... existing code
  } else {
    debugTrace('H2', 'processOrder:else-branch', { status: order.status });
  }

  const result = calculateTotal(order);
  debugTrace('H3', 'processOrder:after-calculate', { result });

  return result;
}
```

3. **Clear the log** before asking the user to reproduce:

```bash
> tmp/debug.log
```

### Step 5: Ask User to Reproduce

Tell the user exactly what to do. Be specific:

```
I've instrumented the code to trace the bug. Please do the following:

1. [Exact step — e.g., "Open the app at localhost:3000/orders"]
2. [Exact step — e.g., "Click 'New Order' and fill in the form"]
3. [Exact step — e.g., "Click 'Submit' and observe the error"]

When done, tell me "done" and I'll analyze the logs.
```

Do NOT proceed until the user confirms they've completed the steps.

### Step 6: Analyze Logs

Read `tmp/debug.log` and analyze:

```
For each hypothesis:
- What did the logs reveal?
- Does the data confirm or contradict the hypothesis?
- Are there unexpected values, missing entries, or wrong execution order?

Produce a verdict:
- H1: CONFIRMED / ELIMINATED / INCONCLUSIVE — [evidence from logs]
- H2: CONFIRMED / ELIMINATED / INCONCLUSIVE — [evidence from logs]
- H3: CONFIRMED / ELIMINATED / INCONCLUSIVE — [evidence from logs]
```

### Step 7: Iterate if Needed

If no hypothesis is confirmed or confidence is low:

1. Form new hypotheses based on what the logs revealed
2. Add/move instrumentation points
3. Clear the log and ask the user to reproduce again
4. Repeat until the root cause is identified with high confidence

### Step 8: Fix the Bug

Once the root cause is confirmed:

1. Implement the fix
2. Keep the instrumentation in place (don't remove yet)
3. Tell the user:

```
I've applied the fix for [root cause summary].

Please reproduce the bug using the same steps:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Tell me if the bug is gone. I'll also check the logs to confirm the fix.
```

### Step 9: Cleanup

After the user confirms the fix works:

1. Remove all `debugTrace()` / `debug_trace()` imports and calls from the codebase
2. Delete `tmp/debug-logger.ts` (or `.js` / `.py`) from the project
3. Delete `tmp/debug.log`
4. Verify the build still passes
5. Summarize: root cause, what was tried, what fixed it

## Important Rules

- **Use the bundled scripts** — copy from `scripts/`, don't write loggers from scratch
- **Instrument all hypotheses at once** — don't make the user reproduce multiple times if you can avoid it
- **Real runtime data only** — never guess what the values are, read the logs
- **Be specific with repro steps** — "click the button" is not enough, say which button, which page, what state
- **Don't fix before you understand** — the temptation to "just try a fix" is strong, resist it until logs confirm the cause
- **Minimal instrumentation** — log what matters, not everything. Don't slow down the app
- **Clean removal** — every import and call must be removed after debugging. Leave zero traces
- **Tag hypotheses** — every log entry must say which hypothesis it's testing. Untagged logs are noise
- **Ask once, learn maximum** — design instrumentation to extract maximum information from a single reproduction
