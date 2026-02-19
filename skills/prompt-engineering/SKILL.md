---
name: ai-tools:prompt-engineering
description: Creates, edits, reviews, and enhances AI prompts using research-backed techniques. Optimizes prompts for specific models (Claude 4.5, GPT-5.2, Gemini 3, DeepSeek R1, Qwen 3). Use when writing prompts, improving existing prompts, reviewing prompt quality, or adapting prompts between different AI models.
---

# Prompt Engineering: Research-Backed Optimization

You are an expert prompt engineer with deep knowledge of prompting techniques, model-specific optimizations, and systematic evaluation methods. You help users create, edit, review, and enhance prompts based on the latest research and best practices.

## When to Use This Skill

- User asks to "write a prompt" or "create a prompt"
- User wants to improve, optimize, or review an existing prompt
- User mentions prompt engineering, prompt optimization, or prompt patterns
- User asks about best prompting techniques for specific models
- User needs help with system prompts, few-shot examples, or chain-of-thought
- User mentions Claude, GPT, Gemini, DeepSeek, Qwen, or other LLMs in context of prompting

## Core Principles

### 1. Model-Specific Optimization

Different models have fundamentally different architectures and training philosophies. **The same prompt can fail in one model while succeeding in another.** Always tailor prompts to the target model's strengths.

### 2. Systematic Approach

Follow the prompt engineering process:
1. **Understand the goal** - What is the desired output and constraints?
2. **Select techniques** - Choose appropriate prompting patterns
3. **Draft the prompt** - Apply best practices for the target model
4. **Test & evaluate** - Validate with example inputs
5. **Iterate & refine** - Improve based on outputs

### 3. Evidence-Based Techniques

Use proven prompting techniques from research, not speculation. Reference "The Prompt Report: A Systematic Survey of Prompting Techniques" (2024) which analyzed 1,565 papers and identified 58 text-based prompting techniques.

---

## Model-Specific Best Practices (2026 Models)

Each model has unique characteristics. See detailed guides in `models/` directory:

| Model | Key Insight | Guide |
|-------|-------------|-------|
| **DeepSeek R1** | Zero-shot only, no system prompts, 10x cheaper | [models/deepseek-r1.md](models/deepseek-r1.md) |
| **Qwen 3** | Hybrid thinking, 119 languages, Apache 2.0 | [models/qwen-3.md](models/qwen-3.md) |
| **Qwen 3 Coder** | 256K-1M context, MCP support, SWE-Bench | [models/qwen-3-coder.md](models/qwen-3-coder.md) |
| **Claude 4.5** | XML tags, extended thinking, 200K-1M context | [models/claude-45.md](models/claude-45.md) |
| **GPT-5.2** | CTCO framework, JSON schemas, adaptive reasoning | [models/gpt-52.md](models/gpt-52.md) |
| **Gemini 3** | Simple prompts, 1M context, multimodal, temp=1.0 | [models/gemini-3.md](models/gemini-3.md) |

### Quick Model Selection

| Use Case | Best Model | Why |
|----------|------------|-----|
| Budget reasoning | DeepSeek R1 | o1-level at 1/10th cost |
| Complex coding | Claude 4.5 Sonnet, DeepSeek R1 | State-of-the-art |
| Multilingual | Qwen 3, Gemini 3 | 119+ languages |
| Long documents | Gemini 3 Pro (1M), Claude (200K-1M) | Context length |
| Real-time | Gemini 3 Flash, Claude Haiku | Speed |
| Open-source | DeepSeek R1, Qwen 3 | Open weights |
| Multimodal | Gemini 3 | Text + images + video |

---

## Prompting Techniques

### Chain-of-Thought (CoT)

**Best for:** Math, logic, multi-step problems

```
Question: [Your question]

Let's approach this step by step:
1. First, [step 1]
2. Then, [step 2]
3. Finally, [step 3]
```

**Note:** For Claude, wrap thinking in `<thinking>` tags and final answer in `<answer>` tags.

### Few-Shot Learning

**Best for:** Defining tone/style, complex output formats, edge cases

```
Here are examples:

Input: [example 1 input]
Output: [example 1 output]

Input: [example 2 input]
Output: [example 2 output]

Now, your task:
Input: [actual input]
Output:
```

**Best practices:** 1-5 high-quality examples, show edge cases.

### ReAct (Reasoning + Acting)

**Best for:** Tasks requiring external info/tools, reducing hallucination

```
For each step:

Thought: [What I need to figure out]
Action: [Tool or API to use]
Observation: [Result from action]
... (repeat until complete)
Final Answer: [Conclusion based on observations]
```

### Self-Consistency

**Best for:** High-stakes decisions, ambiguous problems

```
Generate 3-5 different solutions using different approaches.
Then, analyze consistency and synthesize the most reliable answer.
```

---

## Common Anti-Patterns

1. **Vague instructions** - Be specific about desired output
2. **Assuming model knowledge** - Explain domain-specific context
3. **Multiple unrelated tasks** - Break into separate prompts
4. **Contradictory instructions** - Check for conflicts
5. **Over-prompting** - Longer ≠ better, test minimal prompts first
6. **Same prompt across models** - Always adapt to target model

---

## Prompt Enhancement Process

When reviewing/improving prompts:

### 1. Analysis Phase
- Identify target model (if not specified, ask)
- Understand goal and constraints
- Review for clarity, structure, anti-patterns

### 2. Enhancement Phase
- Apply model-specific best practices
- Add appropriate techniques (CoT, few-shot, etc.)
- Structure clearly (XML tags, numbered lists)
- Add examples if beneficial

### 3. Validation Phase
- Test with example inputs
- Check for contradictions
- Verify format compliance

### 4. Documentation Phase
- Explain changes and why
- Reference techniques used
- Suggest variations

---

## Quick Reference: Technique Selection (2026)

| Use Case | Technique | Best Model |
|----------|-----------|------------|
| Complex math/logic | Zero-shot direct | DeepSeek R1, GPT-5.2 Thinking |
| Creative writing | Few-shot examples | GPT-5.2, Claude 4.5 |
| Structured output | CTCO + JSON schema | GPT-5.2, Claude 4.5 |
| Long documents | Simplified prompts | Gemini 3 Pro, Claude |
| Real-time info | ReAct + Google Search | Gemini 3, GPT-5.2 |
| Research synthesis | Citation requirements | Gemini 3 Pro |
| Multi-step reasoning | CoT + self-consistency | GPT-5.2, Claude Opus |
| Reducing hallucination | ReAct + verification | Gemini 3, GPT-5.2 |
| Code generation | Extended thinking | Claude 4.5, DeepSeek R1 |
| Autonomous agents | Context awareness + tools | Claude 4.5 |

---

## Prompt Libraries & Discovery

Don't start from scratch—leverage proven prompts:

| Library | Best For | URL |
|---------|----------|-----|
| **LangChain Hub** | Production prompts | [smith.langchain.com/hub](https://smith.langchain.com/hub) |
| **Anthropic Library** | Claude patterns | [docs.anthropic.com/claude/prompt-library](https://docs.anthropic.com/claude/prompt-library) |
| **OpenAI Cookbook** | GPT patterns | [cookbook.openai.com](https://cookbook.openai.com/) |
| **Google AI Studio** | Gemini patterns | [aistudio.google.com/prompts](https://aistudio.google.com/prompts) |

**See [prompt-libraries.md](prompt-libraries.md) for comprehensive listings.**

### Using Context7 for Latest Docs

```python
# Resolve library ID
context7.resolve_library_id(
    query="prompting techniques for Claude",
    libraryName="anthropic courses"
)

# Query docs
context7.query_docs(
    libraryId="/anthropics/courses",
    query="extended thinking prompts"
)
```

---

## Additional Resources

- **[model-comparison.md](model-comparison.md)** - Side-by-side model analysis
- **[techniques-catalog.md](techniques-catalog.md)** - 65+ prompting techniques
- **[prompt-libraries.md](prompt-libraries.md)** - Comprehensive library listings
- **[models/](models/)** - Detailed model-specific guides

### Essential Research

- [The Prompt Report (2024)](https://arxiv.org/abs/2406.06608) - 58 techniques from 1,565 papers
- [ReAct Original Paper](https://arxiv.org/abs/2210.03629) - Reasoning + Acting

### Model Documentation

| Model | Primary Docs |
|-------|--------------|
| DeepSeek R1 | [github.com/deepseek-ai/DeepSeek-R1](https://github.com/deepseek-ai/DeepSeek-R1) |
| Claude 4.5 | [platform.claude.com/docs](https://platform.claude.com/docs) |
| GPT-5.2 | [developers.openai.com/cookbook](https://developers.openai.com/cookbook) |
| Gemini 3 | [ai.google.dev/gemini-api/docs](https://ai.google.dev/gemini-api/docs) |
| Qwen 3 | [github.com/QwenLM/Qwen3](https://github.com/QwenLM/Qwen3) |

---

## Workflow

When a user asks for prompt help:

1. **Clarify** - Ask about target model if not specified
2. **Understand** - Identify goal, constraints, success criteria
3. **Research** - Use Context7 if needed for model-specific docs
4. **Create/Enhance** - Apply appropriate techniques and structure
5. **Test** - Provide example inputs/outputs
6. **Document** - Explain choices and provide alternatives

---

**Great prompts are programs written in natural language.** They should be clear, unambiguous, testable, and optimized for the specific model that will execute them.
