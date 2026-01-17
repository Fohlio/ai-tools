# poc-hypothesis

A Claude Code skill for rapid technical hypothesis validation through minimal Proof of Concept implementations.

## Adding This Skill to Your Project

Copy the `poc-hypothesis` folder to your project's `.claude/skills/` directory:

```bash
# From your project root
mkdir -p .claude/skills
cp -r /path/to/ai-tools/skills/poc-hypothesis .claude/skills/
```

## Using the Skill

Start Claude Code in your project and ask naturally:

```
Can we use WebSockets instead of polling?
```

```
Will this external API handle our expected load?
```

```
Test if we can render 10,000 items without performance issues
```

```
Validate that the new auth flow works with SSO
```

## Workflow

### 1. Define Hypothesis

Claude will ask clarifying questions:
- What exactly are we testing?
- What does success look like?
- Any constraints (time, tech stack)?

### 2. Build Minimal POC

| Scenario | What Claude Does |
|----------|------------------|
| Relevant code exists | Reuses or calls existing functions |
| Code needs isolation | Duplicates only what's needed |
| Nothing exists | Writes minimal implementation |

### 3. Test & Report

**On Success:**
- Reports what was proven
- Shows evidence (logs, metrics, screenshots)
- Recommends next steps

**On Failure:**
- Diagnoses the issue
- Proposes alternatives:
  - A: Adjust hypothesis and retry
  - B: Try different approach
  - C: Pivot to alternative solution
  - D: Investigate deeper
- Waits for your decision

### 4. Cleanup

- Documents findings
- You decide: keep POC / integrate / delete

## Examples

### Performance Hypothesis

```
User: Can we load 50MB of data client-side?

Claude:
1. Creates test with 50MB JSON
2. Measures load time, memory usage
3. Reports: "Loads in 2.3s, uses 180MB RAM"
4. Recommends: "Consider pagination or streaming for better UX"
```

### Integration Hypothesis

```
User: Will our auth work with the new payment provider?

Claude:
1. Checks existing auth code
2. Creates minimal integration test
3. Tests token flow with payment API sandbox
4. Reports: "Works, but tokens expire before payment completes"
5. Proposes: "A: Extend token TTL, B: Refresh mid-flow, C: Use API keys instead"
```

### Architecture Hypothesis

```
User: Can we replace Redux with Zustand without breaking tests?

Claude:
1. Identifies Redux usage patterns
2. Creates parallel Zustand store for one slice
3. Runs existing tests against new store
4. Reports results
5. Recommends migration path or alternatives
```

## Key Principles

| Principle | Description |
|-----------|-------------|
| **Speed > Polish** | POC is throwaway code, optimize for learning |
| **Fail Fast** | Report issues immediately, don't hide problems |
| **Minimal Scope** | Only build what validates the hypothesis |
| **Reuse First** | Check existing code before writing new |
| **User Decides** | Present options, let user choose direction |
| **Document** | Even failed POCs provide valuable learnings |

## When NOT to Use

- For production features (use `/c-implement-feature` instead)
- When you already know the answer
- For trivial questions answerable by documentation
- When the "POC" would be as complex as the full feature
