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

## Further Reading

- **Full research:** `agent-research-2026.md` (12 sections, comprehensive)
- **Techniques:** `techniques-catalog.md` (65+ techniques)
- **Models:** `model-comparison.md` (side-by-side comparison)
- **Prompts:** `prompt-libraries.md` (curated collections)
- **Main guide:** `SKILL.md` (complete skill documentation)

**Last Updated:** January 24, 2026
