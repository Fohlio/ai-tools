# AI Model Prompting Comparison (2026)

A comprehensive side-by-side comparison of prompting strategies for Claude 4.5, GPT-5.2, and Gemini 3. Use this guide to quickly adapt prompts across the latest models.

## Quick Reference Matrix

| Feature | Claude 4.5 (Sonnet/Opus) | GPT-5.2 (Thinking) | Gemini 3 (Pro/Flash) | DeepSeek R1 |
|---------|--------------------------|-------------------|---------------------|------------|
| **Release Date** | Sep-Nov 2025 | Dec 2025 | Nov 2025 | Jan 2025 |
| **Best For** | Autonomous agents, coding | Professional work | Research, multimodal | Reasoning, budget projects |
| **Context Length** | 200K (1M beta) | 128K tokens | 1M tokens | 64K tokens |
| **Prompting Style** | XML structure, context-aware | CTCO framework | Simplified, conversational | Zero-shot, no system prompts |
| **Key Innovation** | Context awareness | Adaptive reasoning | Dynamic thinking | Open-source o1-level reasoning |
| **CoT Approach** | Explicit `<thinking>` tags | Automatic adaptive | Dynamic thinking_level | Built-in (automatic) |
| **Few-Shot Sweet Spot** | 2-4 examples | 1-3 examples | 2-5 examples | 0 (avoid few-shot!) |
| **Output Format** | XML preferred | JSON preferred | JSON/structured | Any (reasoning + answer) |
| **Tool Use** | Programmatic, tool search | Function calling | Function + Search grounding | None (base model) |
| **Best Temperature** | 1.0 (default) | 0.7 (default) | 1.0 (CRITICAL) | 0.6 (params ignored) |
| **Pricing (Input/Output)** | $3/$15 (Sonnet) | Varies | $0.50/$3 (Flash) | **$0.55/$2.19** 🔥 |
| **Open Source** | ❌ Proprietary | ❌ Proprietary | ❌ Proprietary | ✅ **Open weights** |

---

## Detailed Model Comparison

### DeepSeek R1 (DeepSeek AI) - January 2025

**Available Model:**
- **DeepSeek-R1** (`deepseek-reasoner`) - Open-source reasoning model

#### Architecture Strengths
- **Open-source** - 671B parameter MoE with 37B active per token, fully open weights
- **Reinforcement learning optimized** - Trained specifically for reasoning tasks
- **Built-in Chain of Thought** - Automatic reasoning before final answers
- **o1-comparable performance** - Matches OpenAI o1 on math, code, reasoning
- **Ultra-low cost** - 10x cheaper than commercial alternatives
- **OpenAI-compatible API** - Easy integration and migration

#### Prompting Best Practices

**CRITICAL: DeepSeek R1 has OPPOSITE prompting requirements vs other models**

**1. NO System Prompts - Everything in User Message**

```
❌ Bad:
System: You are an expert coder.
User: Review this code.

✅ Good:
User: You are an expert coder. Review this code for bugs and security issues.
```

**2. NO Few-Shot Examples (Degrades Performance!)**

```
❌ Bad:
Example 1: Input -> Output
Example 2: Input -> Output
Now solve: [problem]

✅ Good:
Solve this problem step by step: [problem]
```

**Why:** R1 is trained with RL to reason from scratch. Examples hurt performance.

**3. Be Concise and Direct**

```
✅ Good:
Analyze this Python function for security vulnerabilities.

List each issue with:
- Line number
- Type (SQL injection, XSS, etc.)
- Severity
- Fix

[code here]
```

**Why:** Long instructions distract reasoning. Be specific but brief.

**4. Leverage Built-in Reasoning**

```python
response = client.chat.completions.create(
    model="deepseek-reasoner",
    messages=[{"role": "user", "content": "Solve: 3x + 7 = 22"}],
    max_tokens=8000
)

# Model automatically generates CoT in reasoning_content
reasoning = response.choices[0].message.reasoning_content
answer = response.choices[0].message.content
```

**5. Request Self-Verification**

```
Solve [problem].

Then:
1. Verify your solution
2. Check for errors
3. List assumptions
```

**When to Use DeepSeek R1:**
- Complex reasoning (math, logic, proofs)
- Budget-constrained projects (10x cheaper)
- Open-source requirement
- Code generation and debugging
- Scientific problem-solving
- o1-level performance needed at low cost

**When NOT to Use:**
- Function calling needed (not supported)
- Multimodal tasks (text only)
- Need for temperature control (params ignored)
- Few-shot learning required

**Unique Limitations:**
- ❌ System prompts ignored
- ❌ Temperature/top_p/frequency_penalty ignored
- ❌ No function calling (base model)
- ❌ Don't include reasoning_content in follow-up messages (API will error)
- ❌ Few-shot degrades performance

**Pricing (Major Advantage):**
- Input: $0.55/million (vs $3 Claude, $2.50 GPT-4o)
- Output: $2.19/million (vs $15 Claude, $10 GPT-4o)
- **~85% cost savings vs commercial models**

**References:**
- [DeepSeek R1 GitHub](https://github.com/deepseek-ai/DeepSeek-R1)
- [API Documentation](https://api-docs.deepseek.com/guides/reasoning_model)
- [Prompting Guidelines](https://deepwiki.com/deepseek-ai/DeepSeek-R1/3.3-prompting-guidelines)

---

### Claude 4.5 (Anthropic) - November 2025

**Available Models:**
- **Sonnet 4.5** (`claude-sonnet-4-5-20250929`) - Best for agents and coding
- **Opus 4.5** (`claude-opus-4-5-20251101`) - Maximum intelligence
- **Haiku 4.5** (`claude-haiku-4-5-20251001`) - Near-frontier at 2x speed

#### Architecture Strengths
- **Extended autonomous operation** - Can work independently for hours
- **Context awareness** - Tracks remaining token budget throughout conversations
- **State-of-the-art coding** - SWE-bench Verified leader
- **Long context** (200K standard, 1M beta for Sonnet)
- **Structured output** with XML tags
- **Enhanced tool use** with parallel calls and programmatic calling
- **Computer use** with zoom action for fine-grained UI inspection

#### New Capabilities in Claude 4.5

1. **Effort Parameter** (Opus only): Control token usage
   - `low`: Token-efficient responses
   - `medium`: Balanced (default for most use cases)
   - `high`: Maximum thoroughness

2. **Thinking Block Preservation**: Maintains reasoning across multi-turn conversations

3. **Programmatic Tool Calling**: Reduces latency by executing tools in code execution container

4. **Tool Search Tool**: Dynamic discovery for working with hundreds of tools

5. **Memory Tool**: Store/retrieve information outside context window

6. **Context Editing**: Automatic tool call clearing when approaching limits

#### Prompting Best Practices

**1. Use XML Structure**
```xml
<context>
Background information here
</context>

<task>
Specific task description
</task>

<instructions>
1. First, [step]
2. Then, [step]
3. Finally, [step]
</instructions>

<examples>
<example>
Input: [input]
Output: [output]
</example>
</examples>
```

**Why:** Claude was trained to recognize XML tags as structural markers, making prompts clearer and more reliable.

**2. Request Explicit Reasoning**
```xml
<thinking>
[Step-by-step reasoning goes here]
</thinking>

<answer>
[Final answer goes here]
</answer>
```

**Why:** Separating reasoning from answers improves output quality and makes evaluation easier.

**3. Provide Comprehensive Context**
- Don't assume niche knowledge
- Include all relevant constraints upfront
- Use long context to your advantage

**4. Leverage Constitutional AI**
- Ask for assumptions and uncertainties
- Request alternative perspectives
- Invite critique of its own reasoning

**When to Use Claude 4.5:**
- Autonomous agent workflows (extended operation)
- Complex coding projects (state-of-the-art performance)
- Long document analysis (50K-1M tokens)
- Policy and legal document review
- Tasks requiring context tracking across sessions
- Computer use and UI automation

**Model Selection:**
- **Sonnet 4.5**: Default for most tasks, best coding/agents
- **Opus 4.5**: Maximum intelligence, effort parameter for control
- **Haiku 4.5**: Fast, cost-effective, near-frontier intelligence

**Common Mistakes:**
- ❌ Assuming brevity is better (Claude handles long prompts well)
- ❌ Using JSON for complex structures (XML works better)
- ❌ Not leveraging context awareness for long sessions
- ❌ Not using extended thinking for complex coding tasks

**References:**
- [Claude 4.5 Best Practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
- [What's New in Claude 4.5](https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-5)
- Context7: `/anthropics/courses`

---

### GPT-5.2 (OpenAI) - December 2025

**Available Models:**
- **GPT-5.2 Instant** - Fastest responses for real-time applications
- **GPT-5.2 Thinking** - Extended reasoning for complex tasks
- **GPT-5.2 Pro** - Maximum capability for professional knowledge work

#### Architecture Strengths
- **Adaptive reasoning** - Automatically engages deep thinking for complex tasks
- **Professional-grade performance** - 70.9% wins/ties against industry professionals (GDPval benchmark)
- **State-of-the-art coding** - Superior performance on coding, math, and scientific reasoning
- **CTCO framework** - Structured approach prevents "instruction drift"
- **Knowledge cutoff**: August 2025

#### Prompting Best Practices

**1. Use the CTCO Framework (2026 Standard)**
```
CONTEXT:
You are a [role] with [expertise].
Working on: [domain/project context]
Relevant background: [key facts]

TASK:
[Single, atomic action with clear goal]

CONSTRAINTS:
- NEVER [forbidden action 1]
- DO NOT [forbidden action 2]
- MUST [required behavior]
- Scope: [boundaries]

OUTPUT:
Return as [format]:
{
  "field1": "description",
  "field2": "description"
}
```

**Why:** CTCO prevents "instruction drift" in long contexts and provides clear structure that GPT-5.2 optimizes for.

**2. Control Reasoning Effort**

Match the variant to your task:

- **GPT-5.2 Instant**: Use for formatting, data extraction, real-time apps
  - Prompt: "Directly output the result without preamble"
  
- **GPT-5.2 Thinking**: Use for complex logic, coding challenges
  - Prompt: "First plan your approach, then execute step-by-step with verification"
  
- **GPT-5.2 Pro**: Use for professional knowledge work requiring maximum capability

**3. Place Instructions Strategically**

To avoid instruction drift in long contexts:
```
[IMPORTANT INSTRUCTIONS AT TOP]

[Large context/data in middle]

[REPEAT KEY INSTRUCTIONS AT BOTTOM]
```

**4. Use Structured JSON Outputs**

```json
{
  "role": "user",
  "content": "CONTEXT: [background]\n\nTASK: [action]\n\nCONSTRAINTS:\n- [constraint 1]\n- [constraint 2]\n\nOUTPUT: Return as JSON with fields: [list]"
}
```

**When to Use GPT-5.2:**
- Professional knowledge work (70.9% vs professionals)
- Complex coding and debugging
- Multi-step reasoning with verification
- Tasks requiring adaptive intelligence
- Structured data extraction with schemas

**Model Selection Guide:**
- **Instant**: Real-time, chat, high-throughput (lowest latency)
- **Thinking**: Complex reasoning, coding, analysis (best quality)
- **Pro**: Maximum capability, professional work (highest intelligence)

**Common Mistakes:**
- ❌ Not using CTCO framework (causes instruction drift)
- ❌ Over-coaching reasoning (model adapts automatically)
- ❌ Wrong variant selection (Instant for complex tasks, Thinking for simple ones)
- ❌ Vague constraints (be explicit about what NOT to do)

**References:**
- [GPT-5.2 Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/gpt-5-2_prompting_guide/)
- [GPT-5.2 2026 Playbook](https://www.atlabs.ai/blog/gpt-5.2-prompting-guide-the-2026-playbook-for-developers-agents)

---

### Gemini 3 (Google) - November 2025

**Available Models:**
- **Gemini 3 Pro** (`gemini-3-pro-preview`) - Maximum intelligence and reasoning
- **Gemini 3 Flash** (`gemini-3-flash-preview`) - Pro-level intelligence at Flash speed
- **Nano Banana Pro** (`gemini-3-pro-image-preview`) - Highest quality image generation

#### Architecture Strengths
- **State-of-the-art reasoning** built on dynamic thinking foundation
- **1M token context window** (largest in class, 64K output)
- **Multimodal excellence** - Text, images, video (2 hours), audio, PDFs
- **Grounding with Google Search** - Real-time data integration
- **Simplified prompting** - Requires less complex prompt engineering than Gemini 2.x
- **Knowledge cutoff**: January 2025

#### Prompting Best Practices

**CRITICAL: Gemini 3 requires SIMPLER prompts than Gemini 2.x. Less is more.**

**1. Keep Prompts Concise**

```
Bad (Gemini 2.x style - too verbose):
Extract the following fields from the Q3 2025 financial report. 
Return the data as valid JSON. Make sure to use proper JSON syntax 
with quotes around strings. The JSON should have the following fields: 
revenue (as a number), expenses (as a number), and margin (as a percentage).
Do not include any text outside the JSON structure.

Good (Gemini 3 style - concise):
Extract Q3 2025 revenue, operating expenses, and net profit margin. 
Return as JSON: {revenue, expenses, margin}
```

**Why:** Gemini 3 infers structure from minimal cues and over-engineering hurts performance.

**2. Control Thinking Level**

Use `thinking_level` parameter to optimize for speed vs. quality:

```python
response = client.models.generate_content(
    model="gemini-3-pro-preview",
    contents="Analyze this code for security issues",
    config={
        "thinking_config": {
            "thinking_level": "high"  # minimal, low, medium, high
        }
    }
)
```

- **`minimal`** (Flash only): No thinking, fastest (chat, high-throughput)
- **`low`**: Simple tasks, faster responses
- **`medium`** (Flash only): Balanced approach
- **`high`** (Default): Complex tasks, maximum reasoning

**3. Use Four-Part Structure (Optional)**

```
Persona: You are a [role] with expertise in [domain].

Task: [Action verb] [specific thing] to [goal].

Context:
- [Background 1]
- [Constraint]

Format: [Output structure]
```

**4. Optimize Media Resolution**

Control multimodal token usage with `media_resolution`:

- **Images**: `media_resolution_high` (1120 tokens) - Recommended for most tasks
- **PDFs**: `media_resolution_medium` (560 tokens) - Optimal for OCR
- **Video (general)**: `media_resolution_low` (70 tokens/frame)
- **Video (text-heavy)**: `media_resolution_high` (280 tokens/frame)

**5. Keep Temperature at 1.0**

**CRITICAL**: Do NOT change temperature from default `1.0`. Lower values may cause:
- Looping behavior
- Degraded performance on complex tasks
- Unexpected failures

**6. Request Citations for Research**

```
Task: Research [topic]

Requirements:
- Cite sources: [Claim (Source, Year)]
- Flag uncertain information
- Provide reference list
```

**When to Use Gemini 3:**
- Research with citations (grounding with Google Search)
- Multimodal analysis (text + images + video + audio)
- Extremely long documents (1M token context)
- Image generation with reasoning (Nano Banana Pro)
- Factual accuracy is critical

**Model Selection Guide:**
- **Pro**: Complex reasoning, broad world knowledge
- **Flash**: Pro-level intelligence at Flash speed/pricing
- **Pro Image**: High-fidelity image generation with reasoning

**Common Mistakes:**
- ❌ Over-engineering prompts (Gemini 3 wants simplicity)
- ❌ Changing temperature from 1.0 (causes issues)
- ❌ Not using thinking_level to optimize performance
- ❌ Missing media_resolution optimization for multimodal
- ❌ Using Gemini 2.x prompting style (too verbose)

**References:**
- [Gemini 3 Developer Guide](https://ai.google.dev/gemini-api/docs/gemini-3)
- [Gemini 3 Prompting Playbook](https://promptbuilder.cc/blog/gemini-3-prompting-playbook-november-2025/)
- [Gemini 3 Prompting Guide (Cloud)](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/start/gemini-3-prompting-guide)


---

## Same Task, Different Models (2026)

### Example: Code Review

#### Claude 4.5 Approach
```xml
<task>
Review this Python function for bugs, performance issues, and maintainability.
</task>

<code>
[function code]
</code>

<instructions>
1. Analyze for correctness and edge cases
2. Identify performance bottlenecks
3. Suggest maintainability improvements
4. Consider security implications

For each issue found:
- Severity: [Critical/High/Medium/Low]
- Location: [line numbers]
- Explanation: [why it's an issue]
- Solution: [specific code fix]
</instructions>

<thinking>
[Your analytical process]
</thinking>

<review>
[Structured review]
</review>
```

#### GPT-5.2 Approach (CTCO Framework)
```
CONTEXT:
You are a senior software engineer with expertise in Python and security.
Reviewing code for a fintech web application processing sensitive user data.

TASK:
Review the Python function below for security vulnerabilities and performance issues.

CONSTRAINTS:
- Focus ONLY on security and performance (not style/formatting)
- DO NOT suggest complete rewrites unless critical
- MUST cite specific line numbers for each issue
- Prioritize by severity: Critical > High > Medium > Low

OUTPUT:
Return as JSON:
{
  "issues": [
    {
      "line": number,
      "severity": "Critical|High|Medium|Low",
      "category": "Security|Performance",
      "description": "string",
      "fix": "string"
    }
  ],
  "summary": "string"
}

[function code]
```

#### Gemini 3 Approach (Simplified)
```
Review this Python function for security and performance.

Function handles user authentication in production (1000+ req/sec, untrusted input).

[function code]

Return JSON with:
- issues: [{line, severity, category, description, fix}]
- summary (prioritize critical issues)
```

**Key Differences:**
- **Claude 4.5**: XML structure, extended thinking tags, explicit reasoning
- **GPT-5.2**: CTCO framework, clear constraints, structured output
- **Gemini 3**: Minimal/concise prompt, infers structure automatically

---

## Cross-Model Adaptation Checklist

When porting a prompt from one model to another:

### From Claude → GPT-4o
- [ ] Convert XML tags to JSON or plain structure
- [ ] Move role/behavior from `<context>` to System message
- [ ] Reduce example count (Claude uses more, GPT uses fewer)
- [ ] Add JSON schema if structured output needed
- [ ] Consider breaking long instructions into sub-prompts

### From Claude → o1
- [ ] Remove explicit "think step by step" language
- [ ] Present problem more directly (less coaching)
- [ ] Add more domain background (o1 has narrower knowledge)
- [ ] Remove XML structure (use headings instead)
- [ ] Simplify instructions (built-in reasoning handles complexity)

### From Claude → Gemini
- [ ] Convert XML to four-part structure (Persona/Task/Context/Format)
- [ ] Make language more conversational
- [ ] Add citation requirements if factual
- [ ] Consider multimodal opportunities
- [ ] Use natural section headers instead of tags

### From GPT-4o → Claude
- [ ] Move System message content into `<context>` or role description
- [ ] Convert JSON schema to XML structure examples
- [ ] Add more detailed context (Claude handles longer prompts)
- [ ] Add explicit reasoning request with `<thinking>` tags
- [ ] Increase example count if needed (2-4 works well)

### From GPT-5.2 → Claude 4.5
- [ ] Convert CTCO framework to XML structure
- [ ] Move Context section to `<context>` tags
- [ ] Add `<thinking>` tags for reasoning
- [ ] Can provide more detailed context (Claude handles longer prompts)
- [ ] Consider enabling extended thinking for complex tasks

### From Claude 4.5 → GPT-5.2
- [ ] Convert XML to CTCO framework (Context-Task-Constraints-Output)
- [ ] Remove `<thinking>` tags (adaptive reasoning is automatic)
- [ ] Make constraints explicit (what NOT to do)
- [ ] Place instructions at top AND bottom (avoid instruction drift)

### From Gemini 3 → Claude 4.5
- [ ] Can add more structure and detail (Claude prefers detailed prompts)
- [ ] Convert to XML tags
- [ ] Add explicit reasoning request
- [ ] Temperature stays at 1.0 for both

### From Gemini 3 → GPT-5.2
- [ ] Add CTCO structure
- [ ] Make instructions more explicit (less inferencing needed)
- [ ] Add clear constraints section
- [ ] Be more directive in Output format

### From Any Model → DeepSeek R1
- [ ] Remove system prompts (combine into user message)
- [ ] Remove ALL few-shot examples (degrades performance)
- [ ] Simplify and shorten instructions (be concise)
- [ ] Request step-by-step or self-verification
- [ ] Don't rely on temperature/sampling params (ignored)

### From DeepSeek R1 → Other Models
- [ ] Can add system prompts (most models use them)
- [ ] Can add few-shot examples (helps other models)
- [ ] Can elaborate instructions (other models handle complexity)
- [ ] Add temperature/sampling params as needed
- [ ] May need explicit CoT prompting (R1 does it automatically)

---

## Performance Comparison by Task Type (2026)

| Task Type | Best Model | Second Best | Notes |
|-----------|-----------|-------------|-------|
| Math/Logic Problems | DeepSeek R1 | GPT-5.2 Thinking | R1: o1-comparable, 10x cheaper |
| Coding (Complex) | Claude Sonnet 4.5 | DeepSeek R1 | Sonnet: SWE-bench leader, R1: budget option |
| Coding (Fast) | Claude Haiku 4.5 | Gemini 3 Flash | Haiku: 2x faster, near-frontier |
| Long Document Analysis | Gemini 3 Pro | Claude Sonnet 4.5 | Gemini: 1M vs Claude: 200K (1M beta) |
| Autonomous Agents | Claude Sonnet/Opus 4.5 | GPT-5.2 | Claude: Extended operation, context awareness |
| Creative Writing | GPT-5.2 | Claude Sonnet 4.5 | Both excel, GPT slightly better |
| Research with Citations | Gemini 3 Pro | Claude Opus 4.5 | Gemini: Google Search grounding |
| Structured Data (JSON) | GPT-5.2 | Gemini 3 | GPT-5.2: CTCO framework |
| Multimodal Tasks | Gemini 3 Pro | Gemini 3 Flash | Both excellent, Pro for quality |
| Image Generation | Nano Banana Pro | N/A | Gemini 3 Pro Image with reasoning |
| Uncertainty Awareness | Claude Opus 4.5 | Gemini 3 Pro | Claude flags uncertainty explicitly |
| Tool/API Integration | Claude Sonnet 4.5 | GPT-5.2 | Claude: Programmatic tool calling |
| High-Speed Processing | Claude Haiku 4.5 | Gemini 3 Flash | Both near-frontier at speed |
| Budget Reasoning | DeepSeek R1 | Gemini 3 Flash | R1: $0.55/$2.19, o1-level reasoning |
| Open-Source Reasoning | DeepSeek R1 | N/A | Only open o1-level model |
| Best Overall Value | DeepSeek R1 (reasoning) | Gemini 3 Flash (general) | R1: 10x cheaper, Flash: versatile |

---

## Cost Considerations (2026)

When choosing a model, consider both performance AND cost:

| Model | Input ($/1M tokens) | Output ($/1M tokens) | Best Value For | Cost vs GPT-4o |
|-------|-------------------|---------------------|----------------|----------------|
| **DeepSeek R1** 🔥 | **$0.55** | **$2.19** | **Reasoning, budget projects** | **~85% cheaper** |
| Gemini 3 Flash | $0.50 | $3.00 | General purpose, Pro-level intelligence | 70% cheaper |
| Claude Haiku 4.5 | $1.00 | $5.00 | Near-frontier at 2x speed | 60% cheaper |
| Gemini 3 Pro | $2.00 | $12.00 | Research, multimodal, 1M context | 20% cheaper |
| Claude Sonnet 4.5 | $3.00 | $15.00 | State-of-the-art coding, agents | Similar |
| Claude Opus 4.5 | $5.00 | $25.00 | Maximum intelligence | 2x more expensive |
| GPT-5.2 (varies) | Varies | Varies | Professional work | Baseline |

**Note:** Gemini 3 Pro has tiered pricing: $2/$12 (<200K tokens), $4/$18 (>200K tokens)

**Cost Optimization Tips:**
1. **Use DeepSeek R1 for reasoning tasks** (85% cost savings, o1-level performance)
2. Start with Gemini 3 Flash for general tasks (70% cost savings)
3. Use Claude Sonnet 4.5 for coding/agent tasks (worth the premium)
4. Use Gemini 3 Pro for long documents (1M context)
5. Reserve Claude Opus 4.5 for maximum intelligence needs
6. Use prompt caching (Claude) for repeated prompts
7. Consider open-source DeepSeek R1 for self-hosting

**When Budget Matters:**
- **Reasoning/Math/Code**: DeepSeek R1 → Gemini 3 Flash → Claude Haiku 4.5
- **General Tasks**: Gemini 3 Flash → Claude Haiku 4.5
- **Premium Quality**: Claude Sonnet 4.5 → Claude Opus 4.5

---

## Common Patterns Across Models

Some techniques work well across ALL models:

### Universal Best Practices

1. **Be Specific**
   - ✅ "Write a 200-word summary in academic tone"
   - ❌ "Write a good summary"

2. **Provide Examples (But Adapt Count)**
   - Claude 4.5: 2-4 examples
   - GPT-5.2: 1-3 examples (CTCO framework)
   - Gemini 3: 2-5 examples (but simpler is better)

3. **Specify Output Format**
   - Show structure explicitly
   - Provide templates or schemas
   - Use examples to demonstrate

4. **Test with Edge Cases**
   - All models need validation
   - Create test suite
   - Iterate based on failures

5. **Iterate from Simple to Complex**
   - Start minimal
   - Add complexity only if needed
   - Test each addition

---

## Quick Decision Tree (2026)

```
Budget constraint (<$1/M tokens)?
└─ YES → DeepSeek R1 (reasoning) or Gemini 3 Flash (general)
└─ NO ↓

Need open-source / self-hosting?
└─ YES → DeepSeek R1 (only open o1-level model)
└─ NO ↓

Need extended autonomous operation (agents)?
└─ YES → Claude Sonnet/Opus 4.5
└─ NO ↓

Need complex math/logic/reasoning?
└─ YES → DeepSeek R1 (budget) or GPT-5.2 Thinking (premium)
└─ NO ↓

Need 500K+ token context?
└─ YES → Gemini 3 Pro (1M) or Claude Sonnet 4.5 (1M beta)
└─ NO ↓

Need image generation with reasoning?
└─ YES → Nano Banana Pro (Gemini 3 Pro Image)
└─ NO ↓

Need multimodal (text + image + video)?
└─ YES → Gemini 3 Pro/Flash
└─ NO ↓

Need real-time data/research?
└─ YES → Gemini 3 (Google Search grounding)
└─ NO ↓

Need state-of-the-art coding?
└─ YES → Claude Sonnet 4.5
└─ NO ↓

Need structured output (CTCO)?
└─ YES → GPT-5.2
└─ NO ↓

Need best value (speed + intelligence)?
└─ YES → Gemini 3 Flash or Claude Haiku 4.5

General purpose?
└─ YES → Gemini 3 Flash (best overall value)
```

---

## References

### Comparative Studies
- [Claude vs ChatGPT vs Gemini Best Practices (2025)](https://promptbuilder.cc/blog/claude-vs-chatgpt-vs-gemini-best-prompt-engineering-practices-2025)
- [Which AI Needs Which Prompts?](https://sureprompts.com/blog/chatgpt-claude-gemini-comparison)
- [Complete Comparison Matrix](https://www.dataunboxed.io/blog/prompt-engineering-best-practices-complete-comparison-matrix)

### Official Documentation
- [Claude Documentation](https://platform.claude.com/docs)
- [OpenAI Documentation](https://platform.openai.com/docs)
- [Gemini Documentation](https://ai.google.dev/gemini-api/docs)

### Context7 Libraries
- `/anthropics/courses` - Claude interactive tutorials
- `/anthropics/anthropic-cookbook` - Claude code examples

---

**Last Updated:** January 24, 2026 (Claude 4.5, GPT-5.2, Gemini 3)

**Model Versions:**
- DeepSeek R1: `deepseek-reasoner` (January 2025)
- Claude Sonnet 4.5: `claude-sonnet-4-5-20250929`
- Claude Opus 4.5: `claude-opus-4-5-20251101`  
- Claude Haiku 4.5: `claude-haiku-4-5-20251001`
- Gemini 3 Pro: `gemini-3-pro-preview`
- Gemini 3 Flash: `gemini-3-flash-preview`
- Nano Banana Pro: `gemini-3-pro-image-preview`
- GPT-5.2: Instant/Thinking/Pro variants (December 2025)

**Note:** Model capabilities evolve rapidly. Always test prompts with the specific model version you're using.
