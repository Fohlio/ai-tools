# Agent Prompting: Quick Reference (2026)

Fast lookup guide for production agent development. For detailed information, see `agent-research-2026.md`.

---

## When to Use What

| Task Type | Architecture | Reasoning |
|-----------|--------------|-----------|
| Simple, predictable | Agentic workflow | Fixed runtime, lower cost |
| Open-ended, creative | True agent | Dynamic decisions |
| Most real-world | Hybrid | Best of both worlds |

---

## Multi-Agent Orchestration Patterns

| Pattern | When to Use | Pros | Cons |
|---------|-------------|------|------|
| **Hub-and-Spoke** | Compliance, finance, healthcare | Predictable, debuggable | Bottleneck |
| **Sequential** | Clear stage dependencies | Simple | High latency |
| **Supervisor-Worker** | Tasks that branch | Oversight + specialization | Complexity |
| **Mesh** | Scale-out needed | No bottleneck | Hard to debug |

**Performance gains:** 45% faster resolution, 60% more accurate vs single-agent

---

## Memory Systems: Choose Based on Need

| System | Use When | Key Benefit |
|--------|----------|-------------|
| **RAG** | Simple retrieval | Fast, simple |
| **CMA** | Need temporal continuity | Persistent state, chaining |
| **EverMemOS** | Self-organizing knowledge | MemCells → MemScenes |
| **Mem0** | Production-ready, cost-critical | 91% lower latency, >90% token savings |

**Key limitation of RAG:** Stateless, no accumulation/mutation over long horizons

---

## Security Checklist

### 7 Unique Agent Risks
- [ ] Prompt injection protection
- [ ] Tool abuse prevention (least privilege)
- [ ] Data exfiltration controls
- [ ] Memory poisoning safeguards
- [ ] Goal hijacking detection
- [ ] Autonomy limits (human-in-loop)
- [ ] Denial of wallet prevention (cost caps)

### 5 Core Safety Patterns
1. **Tool Security**: Minimum required tools, per-tool scoping, allowlists, block sensitive files
2. **I/O Guardrails**: Validate before/after execution, content filters, screening models
3. **Identity/Auth**: Control who agent acts as, different tools for different trust levels
4. **Sandboxing**: Isolated execution, VPC-SC network controls
5. **Monitoring**: Control plane + data plane + access monitoring + response filters

---

## Open-Source Models for Self-Hosting (2026)

| Model | Sizes | License | Context | Best For |
|-------|-------|---------|---------|----------|
| **Qwen 3** | 0.6B-235B | Apache 2.0 | 32K (128K) | Multilingual (119 langs), general tasks |
| **Qwen 3 Coder** | 0.6B-480B | Apache 2.0 | 256K (1M) | Coding (119 langs), SWE-Bench, agents |
| **DeepSeek R1** | 671B MoE (~37B active) | MIT | 64K | Reasoning, math, logic (o1-comparable) |

**Deployment:**
- **Ollama**: `ollama run qwen3`, `ollama run qwen3-coder`, `ollama run deepseek-r1`
- **llama.cpp**: Local deployment on consumer hardware
- **vLLM**: Production server deployment
- **Cloud**: Google Vertex AI (Qwen 3 Coder), DashScope (Qwen 3)

**Hardware Requirements:**
- **0.6B-4B**: Consumer laptops (M1/M2 Macs, 16GB RAM)
- **8B-14B**: Gaming PCs (RTX 3090/4090, 24GB VRAM)
- **30B-32B**: High-end workstations (dual GPUs, 48GB+ VRAM)
- **235B+**: Multi-GPU servers or cloud

---

## Cost Optimization Levers

### Context Management (Primary Lever)
```
✅ Explicit lifecycle rules
✅ Conversation truncation
✅ Context compression
✅ Pass summaries, not full analysis
```

### Other Levers
| Lever | Impact | When to Use |
|-------|--------|-------------|
| **Summarization checkpoints** | 50-70% reduction | Long conversations |
| **Prompt caching** | 45-80% reduction | Multi-turn, repeated prompts |
| **Smart memory (Mem0)** | >90% reduction | vs full-context |
| **Model selection** | 85% reduction | DeepSeek R1 vs GPT-4o |

**Economic reality:**
- $0.50/day per user → $15,000/month at 1,000 users
- Token optimization is **foundational design**, not post-deployment fix

---

## Prompt Caching: Critical Rules

### Structure for Caching
```
✅ STATIC (cached):
   - Model instructions
   - Tool definitions (sorted!)
   - Project docs
   - Sandbox config

✅ DYNAMIC (end):
   - Environment (cwd, timestamp)
   - User message
   - Tool results
```

### Cache-Breaking Actions (AVOID)
- ❌ Changing tool list mid-conversation
- ❌ Switching models
- ❌ Modifying early messages
- ❌ Inconsistent tool ordering

### Cache-Preserving Actions (DO)
- ✅ Append new messages (don't modify old)
- ✅ Sort tool lists consistently
- ✅ Keep static content stable

**Impact:** 45-80% cost reduction, 13-31% latency improvement

---

## Tool Calling: 2026 Best Practices

### Tool Schema Checklist
- [ ] Clear, action-oriented name
- [ ] Detailed description (when AND how to use)
- [ ] Explicit parameter requirements
- [ ] Constraints and examples included
- [ ] Use `strict: true` for validation

### Advanced Optimization
| Technique | Benefit | Source |
|-----------|---------|--------|
| **ToolGen** | 47K+ tools, no retrieval | ICLR 2025 |
| **Parallel Function Calling** | 4x parallel, 40% cost, 12% latency | Compiler-level fusion |

---

## Agent Evaluation: Beyond Task Success

### Three Frameworks

**HB-Eval (System-Level):**
1. Failure Resilience Rate (recovery from faults)
2. Planning Efficiency Index (trajectory optimality)
3. Traceability Index (reasoning transparency)

**Finding:** 42.9pp gap between nominal success and stressed performance

**Agent-Pex (Microsoft):**
- Extract specs from prompts/traces
- Assess compliance (arguments, outputs, plans)
- Compare across architectures

**Google's Three Pillars:**
1. Success/quality (final output)
2. Process/trajectory (decision-making)
3. Interaction (collaboration)

**Critical:** Addresses "silent failures" (correct output, flawed process)

---

## Framework Selection (2026)

| Framework | Best For | Key Strength |
|-----------|----------|--------------|
| **LangGraph** | Structured workflows | Granular control, DAG clarity |
| **CrewAI** | Role-based collaboration | Accessibility, organization |
| **AutoGen** | Flexible communication | Mature, conversational |

**Evaluation factors:**
- State/memory management
- Human-in-the-loop
- Orchestration flexibility
- Setup vs production readiness
- Structured output
- Governance

---

## MCP Integration: Best Practices

### Design Principles
1. **Single responsibility** - One domain per server
2. **Bounded toolsets** - Avoid "kitchen-sink"
3. **Contracts first** - Strict schemas, explicit side effects
4. **Stateless by default** - Scale and resiliency
5. **Security by design** - Identity, auth, audit built-in
6. **Controlled autonomy** - Least-privilege + approval gates

### Transport Selection
| Transport | Use When | Pros |
|-----------|----------|------|
| **stdio** | Local, per-user | Strong isolation |
| **Streamable HTTP** | Remote, shared | Scale-out |

### Enterprise: MCP Gateway
- Centralized auth/routing
- Rate limiting
- Policy-as-code
- Multi-tenancy

---

## Debugging: LangSmith Hierarchy

```
Threads (full conversations)
  └─ Traces (single execution)
      └─ Runs (individual steps: LLM calls, tool calls)
```

**New tools (2025-2026):**
- **Polly**: AI assistant for trace analysis
- **langsmith-fetch**: CLI debugging for coding agents

**Challenge:** Deep agents = minutes-long, hundreds of steps, massive traces

---

## Top Performers (January 2026)

### GAIA Leaderboard
1. JoinAI_V2.2: 90.7%
2. NVIDIA agents: 90.37%
3. JD Enterprise Intelligence: 90.37%

### HAL Benchmarks (Cost-Aware)
- **AssistantBench**: Browser-Use + o3 Medium (38.8%, $15.15)
- **CORE-Bench Hard**: CORE-Agent + Claude Opus 4.1 (51.1%, $412.42)
- **GAIA**: HAL Generalist + Claude Sonnet 4.5 (74.5%, $178.20)
- **SWE-bench**: SWE-Agent + Claude Sonnet 4.5 High (72.0%, $463.90)

**Key finding:** Higher reasoning effort sometimes reduced accuracy

---

## Quick Decision Trees

### Memory System Selection
```
Need simple retrieval? → RAG
Need cost savings + speed? → Mem0
Need temporal continuity? → CMA
Need self-organizing? → EverMemOS
```

### Model Selection for Agents (2026)
```
Commercial, best quality? → Claude 4.5 Sonnet/Opus
Budget + cloud? → GPT-5.2 Instant, Gemini 3 Flash
Reasoning-heavy? → GPT-5.2 Thinking, DeepSeek R1
Self-hosted + multilingual? → Qwen 3 (0.6B-235B)
Self-hosted + coding? → Qwen 3 Coder (0.6B-480B)
Ultra-budget + reasoning? → DeepSeek R1 (85% cheaper)
Edge devices? → Qwen 3-0.6B/1.7B/4B
```

### Orchestration Pattern Selection
```
Compliance-heavy? → Hub-and-Spoke
Simple pipeline? → Sequential
Need oversight? → Supervisor-Worker
Scale-out critical? → Mesh
```

### Cost Optimization Priority
```
1. Context management (biggest impact)
2. Prompt caching (easy win)
3. Memory system (Mem0 > RAG)
4. Model selection (DeepSeek R1 for budget)
5. Summarization checkpoints
6. Multi-agent efficiency
```

---

## Common Pitfalls

| Pitfall | Impact | Solution |
|---------|--------|----------|
| **Quadratic token growth** | Context exhaustion | Compaction at 60% limit |
| **Tool flapping** | Wasted cost, loops | Max 3 retries, analyze failures |
| **Cache misses** | 2-5x cost increase | Static first, dynamic last |
| **No security** | Data leaks, abuse | Implement 5 safety patterns |
| **Task success only** | Silent failures | Use HB-Eval metrics |
| **Isolated prompt optimization** | Suboptimal | Think token flow across architecture |

---

## Production Readiness Checklist

### Before Deployment
- [ ] Security: All 7 risks addressed, 5 safety patterns implemented
- [ ] Cost: Context management + caching + monitoring in place
- [ ] Evaluation: Beyond task success (process, trajectory, interaction)
- [ ] Observability: Structured tracing (threads → traces → runs)
- [ ] Memory: Right system for use case (not just default RAG)
- [ ] MCP: Single responsibility, bounded toolsets, contracts first
- [ ] Approval gates: For high-impact operations
- [ ] Cost caps: Prevent denial of wallet

### After Deployment
- [ ] Monitor token usage trends
- [ ] Track cache hit rates
- [ ] Measure failure resilience
- [ ] Analyze tool calling patterns
- [ ] Review security logs
- [ ] Evaluate against HB-Eval metrics
- [ ] Compare cost vs budget

---

## Key Metrics to Track

| Metric | Target | Red Flag |
|--------|--------|----------|
| **Cache hit rate** | >70% | <50% |
| **Token cost per user** | Stable/decreasing | Increasing |
| **Failure resilience** | >90% | <70% |
| **Latency (TTFT)** | <2s | >5s |
| **Tool calls per turn** | <10 | >20 (flapping) |
| **Context usage** | <60% of limit | >80% |
| **Silent failures** | <5% | >15% |

---

## Agent Architecture Comparison (2026)

### OpenAI Codex vs Anthropic Claude Code

| Aspect | Codex (OpenAI) | Claude Code (Anthropic) |
|--------|----------------|------------------------|
| **Philosophy** | Prompt-centric | Extension ecosystem |
| **Context Strategy** | Role hierarchy, compaction | Layered loading, subagents |
| **Memory** | Stateless (optional previous_response_id) | Ephemeral sessions + CLAUDE.md |
| **Extensions** | Tools in flat list | CLAUDE.md, Skills, MCP, Subagents, Hooks |
| **Caching** | Static first, dynamic last | Extension layering |
| **Permissions** | Sandbox + approval gates | Modes + allowlists + checkpoints |

**Key insight:** Both converge on same core patterns (agentic loop, tool calling, caching), but differ in extension philosophy.

---

## Context Loading: Two Approaches

### OpenAI Codex: Prompt Structure
```
system: [Model instructions - static]
developer: [Framework config - static]
developer: [Developer instructions - static]
user: [Project docs - static]
user: [Environment - dynamic]
user: [User message - dynamic]
```

**Optimization:** Static first (cacheable), dynamic last (changes per request)

### Anthropic Claude Code: Extension Layering
```
Session Start:
  ✅ CLAUDE.md (full content, every request)
  ✅ MCP servers (all tool definitions, every request)
  ✅ Skills (descriptions only, ~few hundred tokens)

On Demand:
  ✅ Skills (full content when invoked)
  ✅ Subagents (isolated context, don't bloat main)

External:
  ✅ Hooks (zero context cost)
```

**Optimization:** On-demand loading + context isolation

---

## Best Practices: Production Insights

### From OpenAI Codex

**Prompt Construction:**
- ✅ Role hierarchy: system > developer > user
- ✅ XML tags for structure
- ✅ Tool definitions with clear descriptions
- ✅ Old prompt = exact prefix of new (caching)

**Context Management:**
- ✅ Compact at ~60% of limit
- ✅ Append new messages (don't modify old)
- ✅ Sort tool lists consistently

**Agent Patterns:**
- ✅ Planning tool for progress tracking
- ✅ Self-correction (verify → fix → retry)
- ✅ Approval gates for sensitive ops

### From Anthropic Claude Code

**Working Style:**
- ✅ It's a conversation (iterate, don't expect perfect first try)
- ✅ Be specific upfront (reference files, constraints, examples)
- ✅ Give something to verify against (tests, screenshots, output)
- ✅ Explore before implementing (plan mode first)
- ✅ Delegate, don't dictate (trust agent to figure out details)
- ✅ Interrupt and steer (can stop and redirect anytime)

**Context Optimization:**
- ✅ Keep CLAUDE.md <500 lines
- ✅ Use `disable-model-invocation: true` for user-only skills
- ✅ Disconnect unused MCP servers
- ✅ Spawn subagents for isolation
- ✅ Move reference material from CLAUDE.md to skills

**Extension Patterns:**
- ✅ CLAUDE.md = always-on rules
- ✅ Skills = on-demand knowledge/workflows
- ✅ MCP = external connections
- ✅ Subagents = isolated work
- ✅ Hooks = external automation

---

## Extension Decision Tree (Anthropic)

```
Need persistent rules? → CLAUDE.md
Need reference material? → Skill (reference)
Need workflow trigger? → Skill (action) with /<name>
Need external service? → MCP server
Need context isolation? → Subagent
Need parallel work? → Subagents
Need automation? → Hook
Need to package/distribute? → Plugin
```

---

## Context Cost Comparison

### OpenAI Codex (Token-Centric)

```
Cost = Base prompt + Tool definitions + History + Tool results

Optimization levers:
1. Prompt caching (45-80% reduction)
2. Compaction (when > threshold)
3. Tool list management (consistent ordering)
```

### Anthropic Claude Code (Extension-Centric)

```
Per Request Cost:
  High: CLAUDE.md (full) + MCP (all tools)
  Medium: Skills (descriptions only)
  Low: Skills (full, when invoked)
  Zero: User-only skills, Subagents, Hooks

Optimization levers:
1. Keep CLAUDE.md <500 lines
2. Use disable-model-invocation: true
3. Disconnect unused MCP
4. Subagents for isolation
```

---

## Safety Patterns Comparison

### OpenAI Codex

**Sandbox:**
- File permissions (writable paths)
- Network access controls
- Approval modes (on_request, etc.)

**Tools:**
- ask_user_permission before sensitive ops
- Explicit approval gates

### Anthropic Claude Code

**Permission Modes:**
- Default: Ask before edits and commands
- Auto-accept edits: Edits without asking
- Plan mode: Read-only, create plan first

**Checkpoints:**
- Every file edit snapshots contents
- Reversible within session
- Press Esc twice to rewind

**Allowlists:**
- Trusted commands in settings.json
- No asking for approved commands

---

## Hybrid Best Practices (Combined Insights)

### Prompt Structure (Both)
```
1. Static content first (caching)
   - Model instructions
   - Tool definitions (sorted!)
   - Project conventions (CLAUDE.md)
   
2. Dynamic content last
   - Environment (cwd, timestamp)
   - User message
   - Tool results
```

### Context Management (Both)
```
1. Automatic mechanisms
   - Compaction (Codex)
   - On-demand loading (Claude Code)
   
2. Manual optimization
   - Move reference to skills
   - Use subagents for isolation
   - Track context usage
```

### Agent Patterns (Both)
```
1. Planning & Tracking
   - Planning tool (Codex)
   - Plan mode (Claude Code)
   
2. Verification
   - Self-correction patterns
   - Test-driven workflows
   
3. Safety
   - Approval gates (Codex)
   - Permission modes (Claude Code)
```

---

## Further Reading

- **Full research:** `agent-research-2026.md` (13 sections, comprehensive)
  - Section 1: OpenAI Codex architecture
  - Section 13: Anthropic Claude Code architecture
- **Techniques:** `techniques-catalog.md` (65+ techniques)
- **Models:** `model-comparison.md` (side-by-side comparison)
- **Prompts:** `prompt-libraries.md` (curated collections)
- **Main guide:** `SKILL.md` (complete skill documentation)

**Production architectures covered:**
- OpenAI Codex CLI (prompt-centric)
- Anthropic Claude Code (extension-centric)
- Microsoft Agent-Pex (evaluation)
- Google frameworks (multi-agent)
- LangSmith (observability)

**Last Updated:** January 24, 2026
