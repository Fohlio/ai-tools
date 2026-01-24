---
name: prompt-engineering
description: Create, edit, review and enhance AI prompts using research-backed techniques. Optimizes prompts for specific models (Claude, GPT-4o, o1, Gemini) and use cases.
---

# Prompt Engineering: Research-Backed Optimization

You are an expert prompt engineer with deep knowledge of prompting techniques, model-specific optimizations, and systematic evaluation methods. You help users create, edit, review, and enhance prompts based on the latest research and best practices.

## When to Use This Skill

- User asks to "write a prompt" or "create a prompt"
- User wants to improve, optimize, or review an existing prompt
- User mentions prompt engineering, prompt optimization, or prompt patterns
- User asks about best prompting techniques for specific models
- User needs help with system prompts, few-shot examples, or chain-of-thought
- User mentions Claude, GPT, Gemini, o1, or other LLMs in context of prompting

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

### DeepSeek R1 (DeepSeek AI)

**Current Model:** DeepSeek-R1 (`deepseek-reasoner`) - January 2025

**Architecture:** DeepSeek R1 is a 671B parameter Mixture-of-Experts (MoE) model with 37B activated parameters per token. Trained using large-scale reinforcement learning specifically for reasoning tasks. Performance comparable to OpenAI o1 on math, code, and reasoning benchmarks.

**Key Characteristics:**
- **Open-source** - Fully open weights and architecture
- **Built-in reasoning** - Generates Chain of Thought (CoT) automatically before answers
- **Ultra-low cost** - $0.55/$2.19 per million tokens (10x cheaper than GPT-4o)
- **OpenAI-compatible API** - Easy integration
- **64K max tokens** - Includes reasoning content
- **No sampling params** - Temperature, top_p, etc. are ignored

**Best Practices:**

**1. Avoid System Prompts - Use User Prompts Only**

```
Bad (will not work optimally):
System: You are an expert mathematician.

User: Solve this equation...

Good (all in user prompt):
User: You are an expert mathematician. Solve this equation step by step: [equation]
```

**Why:** DeepSeek R1 ignores system prompts. Place all instructions in the user message.

**2. Use Zero-Shot Prompting (NO Few-Shot Examples)**

```
Bad (degrades performance):
Here are examples:
Example 1: [input] -> [output]
Example 2: [input] -> [output]

Now solve: [your problem]

Good (direct instruction):
Solve this problem step by step: [your problem]
```

**Why:** Few-shot examples degrade R1's reasoning performance. The model is trained to reason from scratch.

**3. Be Concise and Explicit**

```
Good:
Analyze this code for security vulnerabilities. List each vulnerability with:
- Line number
- Severity (Critical/High/Medium/Low)
- Explanation
- Fix

[code]
```

**Why:** Long instructions distract the reasoning process. State tasks clearly and directly.

**4. Encourage Self-Verification**

```
Solve [problem].

After solving:
1. Verify your answer
2. Check for mistakes
3. List assumptions made
```

**Why:** Self-verification improves reliability without needing examples.

**5. Control Reasoning with max_tokens**

```python
response = client.chat.completions.create(
    model="deepseek-reasoner",
    messages=[{"role": "user", "content": problem}],
    max_tokens=8000  # Default 32K, max 64K
)

# Access reasoning and answer separately
reasoning = response.choices[0].message.reasoning_content
answer = response.choices[0].message.content
```

**Why:** max_tokens limits both reasoning and answer length. Adjust based on task complexity.

**6. Use Step-by-Step Instructions**

```
Task: [your task]

Steps:
1. [First step]
2. [Second step]
3. [Third step]

Execute these steps methodically.
```

**Why:** Explicit steps guide the reasoning process for more coherent outputs.

**Example Structure:**

```
You are a Python security expert reviewing production code.

Task: Identify all security vulnerabilities in the code below.

Requirements:
- Analyze line by line
- Focus on SQL injection, XSS, and authentication issues
- Provide specific fixes

Output format:
For each vulnerability:
- Line number
- Type
- Risk level
- Fix

Code:
[your code here]
```

**When to Use DeepSeek R1:**
- Complex reasoning tasks (math, logic, proofs)
- Code generation and debugging
- Scientific problem-solving
- Budget-constrained projects (10x cheaper than alternatives)
- Open-source requirement
- Tasks where o1-level reasoning is needed at lower cost

**Important Limitations:**
- ❌ No function calling (in base R1)
- ❌ No temperature/top_p control (params ignored)
- ❌ Don't include reasoning_content in follow-up prompts (will error)
- ❌ Few-shot prompting degrades performance
- ❌ System prompts are ignored

**Common Mistakes:**
- ❌ Using system prompts instead of user prompts
- ❌ Providing few-shot examples (hurts performance)
- ❌ Using temperature parameters (ignored)
- ❌ Overly long/complex instructions
- ❌ Including reasoning_content in conversation history

**Pricing Advantage:**
- Input: $0.55/million tokens (vs $2.50 GPT-4o, $3 Claude Sonnet)
- Output: $2.19/million tokens (vs $10 GPT-4o, $15 Claude Sonnet)
- **10x cheaper than commercial alternatives**

**References:**
- [DeepSeek R1 GitHub](https://github.com/deepseek-ai/DeepSeek-R1)
- [DeepSeek API Docs](https://api-docs.deepseek.com/guides/reasoning_model)
- [Prompting Guidelines](https://deepwiki.com/deepseek-ai/DeepSeek-R1/3.3-prompting-guidelines)

---

### Claude 4.5 (Anthropic)

**Current Models:** Claude Sonnet 4.5, Claude Opus 4.5, Claude Haiku 4.5

**Architecture:** Claude 4.5 excels at extended autonomous operation, deep reasoning, long-context analysis (200K tokens, 1M beta for Sonnet), and context-aware workflows. Built for coding, AI agents, and complex analytical tasks.

**Model Selection:**
- **Sonnet 4.5** (`claude-sonnet-4-5-20250929`): Best for complex agents and coding tasks
- **Opus 4.5** (`claude-opus-4-5-20251101`): Maximum intelligence with effort parameter control
- **Haiku 4.5** (`claude-haiku-4-5-20251001`): Near-frontier performance at 2x speed, 1/3 cost

**New Capabilities (Claude 4.5):**
- Extended thinking with thinking block preservation
- Effort parameter (Opus only): Control token usage (low/medium/high)
- Context awareness: Model tracks remaining token budget
- Programmatic tool calling: Reduce latency in multi-tool workflows
- Tool search tool: Work with hundreds of tools via dynamic discovery
- Memory tool: Store/retrieve info outside context window
- Enhanced computer use with zoom action for fine-grained UI inspection

**Best Practices:**

1. **Provide comprehensive context upfront**
   - Include all relevant background and constraints
   - Don't assume the model knows niche details
   - Use XML tags for structure: `<context>`, `<instructions>`, `<examples>`

2. **Request step-by-step reasoning**
   - Use numbered sections and clear structure
   - Ask for assumptions, risks, and alternatives
   - Invite the model to flag uncertainty

3. **Leverage long context effectively**
   - Place most important info at beginning AND end (avoid "lost in the middle")
   - Use clear section headers and delimiters
   - Reference specific sections by name

4. **Use structured output formats**
   - XML tags work better than JSON for complex structures
   - Use examples to show desired format
   - Be explicit about edge cases

**Example Structure:**

```xml
<task>
Your clear, specific task description
</task>

<context>
Relevant background information
- Key constraint 1
- Key constraint 2
</context>

<instructions>
1. First, analyze X by...
2. Then, consider Y by examining...
3. Finally, provide Z in the following format:
</instructions>

<example>
Input: [example input]
Output: [example output with reasoning]
</example>
```

**References:**
- [Claude Prompt Engineering Overview](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview)
- [Anthropic Courses](https://github.com/anthropics/courses)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)

---

### GPT-5.2 (OpenAI)

**Current Models:** GPT-5.2 Instant, GPT-5.2 Thinking, GPT-5.2 Pro (released December 2025)

**Architecture:** GPT-5.2 represents OpenAI's most advanced model for professional work with adaptive reasoning that activates for complex tasks. Features multiple variants optimized for speed vs. intelligence trade-offs. 

**Model Selection:**
- **GPT-5.2 Instant**: Fastest responses, best for real-time applications
- **GPT-5.2 Thinking**: Extended reasoning for complex logic and coding
- **GPT-5.2 Pro**: Maximum capability for professional knowledge work

**Key Capabilities:**
- Adaptive reasoning (automatically engages for complex tasks)
- 70.9% wins/ties against industry professionals (GDPval benchmark)
- August 2025 knowledge cutoff
- Context: 128K tokens
- State-of-the-art coding, math, and scientific reasoning

**Best Practices:**

**1. Use the CTCO Framework (2026 Standard)**

The CTCO Framework is the recommended structure for GPT-5.2 prompting:

```
# Context (C)
Define the model's role and background
Provide domain knowledge and constraints

# Task (T)
Specify a single, atomic action
Be clear and direct about the goal

# Constraints (C)
Set negative constraints (what NOT to do)
Define scope limits and requirements

# Output (O)
Define exact format (JSON, Markdown, etc.)
Provide schema or structure
```

**2. Control Reasoning Effort**

GPT-5.2 distinguishes between reasoning levels:

- **Low/Minimal Effort** (for formatting, data extraction):
  - Prompt: "Directly output the result without preamble"
  - Use GPT-5.2 Instant for speed
  
- **High/Thinking Effort** (for complex logic):
  - Use "Plan-then-Execute" patterns
  - Prompt: "First plan your approach, then execute step-by-step with verification"
  - Use GPT-5.2 Thinking for quality

**3. Avoid "Instruction Drift"**

In long-context windows, instructions can get lost:
- Place critical instructions at BOTH the beginning AND end
- Use clear section markers (#, ##, ###)
- Reference earlier context explicitly

**4. Use Structured Outputs**

GPT-5.2 excels at JSON schemas:
```json
{
  "role": "system",
  "content": "You are an expert analyst."
}
{
  "role": "user",
  "content": "Context: [background]\n\nTask: Analyze [data]\n\nConstraints: \n- Use only provided data\n- No speculation\n\nOutput: Return as JSON with fields: summary, insights, recommendations"
}
```

**Example CTCO Structure:**

```
CONTEXT:
You are a senior software engineer with expertise in system design and security.
You're reviewing code for a fintech application that processes sensitive user data.

TASK:
Review the attached Python function for security vulnerabilities and performance issues.

CONSTRAINTS:
- Focus ONLY on security and performance (not style)
- Do NOT suggest rewrites unless critical
- MUST cite specific line numbers
- Prioritize issues by severity (Critical/High/Medium/Low)

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
```

**References:**
- [GPT-5.2 Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/gpt-5-2_prompting_guide/)
- [GPT-5.2 2026 Playbook](https://www.atlabs.ai/blog/gpt-5.2-prompting-guide-the-2026-playbook-for-developers-agents)

---

### Gemini 3.0 (Google)

**Current Models:** Gemini 3 Pro, Gemini 3 Flash, Nano Banana Pro (Gemini 3 Pro Image)

**Architecture:** Gemini 3 is Google's most intelligent model family built on state-of-the-art reasoning. Excels at agentic workflows, autonomous coding, complex multimodal tasks, and research synthesis. Features 1M token context window.

**Model Selection:**
- **Gemini 3 Pro** (`gemini-3-pro-preview`): Best for complex reasoning tasks requiring broad world knowledge
- **Gemini 3 Flash** (`gemini-3-flash-preview`): Pro-level intelligence at Flash speed and pricing
- **Nano Banana Pro** (`gemini-3-pro-image-preview`): Highest quality image generation model

**Key Capabilities:**
- Dynamic thinking by default for reasoning through prompts
- 1M token input context, 64K output
- January 2025 knowledge cutoff
- Multimodal: text, images, video (up to 2 hours), audio, PDFs
- Grounding with Google Search for real-time data
- Thinking level parameter for control over reasoning depth

**Best Practices:**

**1. Keep Prompts Simple (Major Change from Gemini 2.x)**

Gemini 3 requires SIMPLER prompts than previous versions. It infers structure from minimal cues.

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

**2. Control Thinking Level**

Use `thinking_level` parameter (replaces `thinking_budget`):

- **`minimal`** (Flash only): No thinking, fastest responses (chat, high-throughput)
- **`low`**: Minimizes latency and cost for simple tasks
- **`medium`** (Flash only): Balanced thinking for most tasks
- **`high`** (Default): Maximizes reasoning depth (complex tasks)

```python
response = client.models.generate_content(
    model="gemini-3-pro-preview",
    contents="How does quantum computing work?",
    config={
        "thinking_config": {
            "thinking_level": "low"  # For faster responses
        }
    }
)
```

**3. Use Four-Part Structure (Optional but Recommended)**

```
Persona: You are a [role] with expertise in [domain].

Task: [Action verb] [specific thing] to [goal].

Context:
- [Background 1]
- [Background 2]
- [Constraint]

Format: Provide output as:
- [Structure 1]
- [Structure 2]
```

**4. Optimize Media Resolution**

Control multimodal processing with `media_resolution`:

- **Images**: `media_resolution_high` (1120 tokens, recommended)
- **PDFs**: `media_resolution_medium` (560 tokens, optimal for OCR)
- **Video (general)**: `media_resolution_low` (70 tokens/frame)
- **Video (text-heavy)**: `media_resolution_high` (280 tokens/frame for OCR)

**5. Keep Temperature at Default (1.0)**

**CRITICAL**: Keep temperature at `1.0` (default). Gemini 3's reasoning is optimized for this setting. Lower values may cause looping or degraded performance on complex tasks.

**6. Request Citations for Research**

```
Task: Research the impact of AI on healthcare in 2025.

Requirements:
- Cite sources for all factual claims
- Use format: [Claim (Source, Year)]
- Flag any uncertain information
- Provide reference list at end
```

**7. Leverage Multimodal Capabilities**

```
Analyze this chart and the accompanying text together:

Image: [image]
Text: [description]

Compare: [specific comparison]
Synthesize: [how to integrate both modalities]
```

**Example Structure:**

```
Persona: You are a research analyst specializing in climate science.

Task: Analyze the provided climate data and identify key trends for 2025-2030.

Context:
- Data covers global temperature changes
- Focus on actionable insights for policymakers
- Must cite sources

Format: Provide:
1. Executive summary (3-4 sentences)
2. Key trends (bullet points with data)
3. Recommendations (numbered list)

Include citations for all claims.
```

**When to Use Gemini 3:**
- Research with citations needed
- Multimodal analysis (text + images + video)
- Extremely long document processing (1M tokens)
- Factual accuracy is critical
- Grounding with Google Search for real-time data

**Common Mistakes:**
- ❌ Over-engineering prompts (Gemini 3 prefers simplicity)
- ❌ Changing temperature from 1.0 (causes issues)
- ❌ Not using thinking_level for performance tuning
- ❌ Missing media_resolution optimization for multimodal tasks

**References:**
- [Gemini 3 Developer Guide](https://ai.google.dev/gemini-api/docs/gemini-3)
- [Gemini 3 Prompting Playbook](https://promptbuilder.cc/blog/gemini-3-prompting-playbook-november-2025/)

---

## Prompt Libraries & Discovery

Don't start from scratch—leverage proven prompts from comprehensive libraries and adapt them to your needs.

### Why Use Prompt Libraries?

- **Save time**: Start with tested prompts instead of reinventing
- **Learn patterns**: See what works for specific use cases  
- **Cross-model adaptation**: Find prompts and adapt to your target model
- **Quality baseline**: Begin with proven prompts and iterate

### Major Prompt Libraries

**LangChain Hub** - Official managed hub with version control
- URL: [smith.langchain.com/hub](https://smith.langchain.com/hub)
- Features: Model-specific tags, versioning, SDK integration
- Best for: Production-ready prompts with version control

**Anthropic Prompt Library** - Claude 4.5-optimized prompts
- URL: [docs.anthropic.com/claude/prompt-library](https://docs.anthropic.com/claude/prompt-library)
- Features: XML structure examples, extended thinking patterns
- Best for: Claude users learning best practices

**OpenAI Prompt Examples** - GPT-5.2 and CTCO framework
- URL: [cookbook.openai.com](https://cookbook.openai.com/)
- Features: CTCO templates, reasoning effort examples
- Best for: GPT-5.2 users, function calling patterns

**Google AI Studio** - Gemini 3.0 prompt gallery
- URL: [aistudio.google.com/prompts](https://aistudio.google.com/prompts)
- Features: Interactive testing, thinking level examples
- Best for: Gemini users, multimodal patterns

**The Prompt Library** - 500+ cross-model prompts
- URL: [thepromptlibrary.io](https://thepromptlibrary.io/)
- Features: 2,000+ variations, 18 categories, model compatibility
- Best for: Use case discovery, starting points

**Ki-Ecke** - 1000+ prompts across all major models
- URL: [ki-ecke.com/prompts](https://ki-ecke.com/prompts/)
- Features: Comprehensive categories, multi-language, free access
- Best for: Broad coverage, business/technical prompts

**Awesome AI Prompts** - Open-source GitHub collection
- URL: [github.com/0x2e-Tech/awesome-ai-prompts](https://github.com/0x2e-Tech/awesome-ai-prompts)
- Features: 500+ prompts, community-driven, Git-versioned
- Best for: Free, customizable, fork and adapt

### Using Context7 for Latest Prompts

Access official prompt examples via Context7 MCP:

```python
# Claude 4.5 prompts
context7.resolve_library_id(
    query="Claude 4.5 prompting examples",
    libraryName="anthropic courses"
)

context7.query_docs(
    libraryId="/anthropics/courses",
    query="extended thinking prompts for coding"
)

# Anthropic Cookbook
context7.query_docs(
    libraryId="/anthropics/anthropic-cookbook",
    query="metaprompting examples tool use"
)
```

### Prompt Discovery Workflow

**1. Identify Use Case** → Map to category (code, writing, analysis, etc.)

**2. Search Multiple Libraries** → Don't rely on one source:
- Official docs (Anthropic/OpenAI/Google)
- LangChain Hub for versioned prompts
- GitHub for open-source collections
- Community platforms (FlowGPT, PromptHero)

**3. Find 3-5 Candidates** → Test each with your specific input

**4. Select Best Candidate** → Based on quality, model fit, adaptability

**5. Adapt to Your Model** → Use model-comparison guide:
- GPT → Claude: Convert system messages to XML context
- Claude → Gemini: Simplify, use four-part structure
- GPT → Gemini: Remove verbose instructions, add persona

**6. Iterate & Save** → Document what works, build personal library

### Quick Reference: Where to Find What

| Need | Best Source |
|------|------------|
| Claude 4.5 prompts | Anthropic Library, Context7 |
| GPT-5.2 prompts | OpenAI Cookbook |
| Gemini 3 prompts | Google AI Studio |
| Creative prompts | FlowGPT, PromptHero |
| Code prompts | GitHub Awesome lists |
| Production prompts | LangChain Hub |
| Quick start | The Prompt Library, Ki-Ecke |
| Learning patterns | Official docs + Prompt Engineering Guide |

**See `prompt-libraries.md` for comprehensive library listings, integration examples, and advanced discovery techniques.**

---

## Prompting Techniques by Use Case

### When to Use Chain-of-Thought (CoT)

**Best for:**
- Math problems and logical reasoning
- Multi-step problem decomposition
- Tasks with clear intermediate steps
- When the model has sufficient internal knowledge

**How to implement:**
```
Question: [Your question]

Let's approach this step by step:
1. First, [step 1]
2. Then, [step 2]
3. Finally, [step 3]
```

**Note:** For Claude, wrap thinking in `<thinking>` tags and final answer in `<answer>` tags.

**Research:** Improves accuracy on reasoning tasks by 10-50% depending on complexity.

---

### When to Use Few-Shot Learning

**Best for:**
- Defining specific tone or style
- Showing complex output formats
- Demonstrating edge case handling
- Teaching new patterns or structures

**How to implement:**
```
Here are examples of the desired output:

Input: [example 1 input]
Output: [example 1 output]

Input: [example 2 input]
Output: [example 2 output]

Now, your task:
Input: [actual input]
Output:
```

**Best practices:**
- 1-5 examples (more isn't always better)
- High-quality examples > many examples
- Show edge cases in examples
- Keep examples relevant to the task

**Research:** Most effective when examples demonstrate format + reasoning, not just format alone.

---

### When to Use ReAct (Reasoning + Acting)

**Best for:**
- Tasks requiring external information or tools
- Real-time data needs
- API integrations
- Knowledge gap situations
- Reducing hallucination

**How to implement:**
```
For each step, follow this pattern:

Thought: [What I need to figure out]
Action: [Tool or API to use]
Observation: [Result from action]
Thought: [Analysis of result]
... (repeat until task is complete)
Final Answer: [Your conclusion based on observations]
```

**When to use ReAct vs CoT:**
- Use CoT when the model has all needed knowledge internally
- Use ReAct when external information or tools are needed
- Combine both for complex tasks with knowledge gaps

**Research:** ReAct outperforms pure CoT on question answering and fact verification while significantly reducing hallucination.

---

### When to Use Metaprompting

**Best for:**
- Generating prompts for other models
- Optimizing existing prompts
- Creating prompt templates
- Automated prompt engineering

**How to implement:**
```
You are a prompt engineering expert. Your task is to create an optimal prompt for [specific goal].

Requirements:
- Target model: [model name]
- Task type: [classification/generation/reasoning/etc]
- Key constraints: [list constraints]

Generate a prompt that:
1. [Requirement 1]
2. [Requirement 2]
3. [Requirement 3]
```

**See Anthropic's metaprompt example:** [Anthropic Cookbook - Metaprompt](https://github.com/anthropics/anthropic-cookbook/blob/main/misc/metaprompt.ipynb)

---

### When to Use Self-Consistency

**Best for:**
- High-stakes decisions
- Ambiguous problems with multiple valid approaches
- Reducing variance in outputs
- Improving reliability

**How to implement:**
```
Generate 3-5 different solutions to this problem, each using a different approach.

Then, analyze the consistency across solutions and synthesize the most reliable answer.
```

**Research:** Improves accuracy by 5-20% on reasoning tasks, especially when combined with CoT.

---

### When to Use Zero-Shot vs Few-Shot

**Zero-Shot (no examples):**
- Task is straightforward and well-understood by the model
- You want maximum flexibility in output
- You don't have good examples yet

**Few-Shot (with examples):**
- Task requires specific format or style
- Model consistently misunderstands zero-shot instructions
- You need precise control over output structure
- Edge cases need to be demonstrated

**Research:** Few-shot typically improves performance but can reduce generalization. Test both approaches.

---

## Common Prompting Anti-Patterns

### ❌ Avoid These Mistakes

1. **Vague or ambiguous instructions**
   - Bad: "Write something good about AI"
   - Good: "Write a 200-word explanation of transformer architecture for software engineers with no ML background"

2. **Assuming model knowledge**
   - Bad: "Use the standard approach"
   - Good: "Use [specific method/framework], which involves [brief explanation]"

3. **Multiple unrelated tasks in one prompt**
   - Bad: "Analyze this data, write a summary, and create a marketing plan"
   - Good: Break into separate prompts with clear sequencing

4. **Contradictory instructions**
   - Check for conflicting requirements
   - Be explicit about priorities and trade-offs

5. **Over-prompting (too many instructions)**
   - Longer ≠ better
   - Focus on essential constraints only
   - Test minimal viable prompts first

6. **Using the same prompt across different models**
   - Each model has unique strengths and optimal patterns
   - Always adapt prompts to the target model

---

## Evaluation Framework

### How to Test Prompts

1. **Create test cases**
   - 5-10 representative inputs
   - Include edge cases
   - Cover expected variations

2. **Define success criteria**
   - Accuracy on factual content
   - Format compliance
   - Tone/style consistency
   - Handling of edge cases

3. **Run systematic comparisons**
   - Test prompt variations side-by-side
   - Track which techniques improve results
   - Document what works and what doesn't

4. **Measure quantitatively when possible**
   - Accuracy scores
   - Format compliance rate
   - Token efficiency (output length vs quality)

---

## Prompt Enhancement Process

When a user asks you to review or improve a prompt, follow this process:

### 1. Analysis Phase

- Identify the target model (if not specified, ask)
- Understand the goal and constraints
- Review the current prompt for:
  - Clarity and specificity
  - Model-appropriate structure
  - Use of effective techniques
  - Common anti-patterns

### 2. Enhancement Phase

- Apply model-specific best practices
- Add appropriate prompting techniques (CoT, few-shot, etc.)
- Structure for clarity (XML tags, numbered lists, sections)
- Include examples if beneficial
- Add edge case handling

### 3. Validation Phase

- Test with example inputs
- Check for contradictions or ambiguity
- Verify format compliance
- Suggest evaluation criteria

### 4. Documentation Phase

- Explain changes made and why
- Reference specific techniques used
- Provide guidance on when to use this prompt pattern
- Suggest variations for different scenarios

---

## Output Format

When creating or reviewing prompts, provide:

1. **The optimized prompt** (clearly formatted)
2. **Model-specific notes** (if relevant)
3. **Techniques used** (with brief explanations)
4. **Test cases** (2-3 example inputs/outputs)
5. **Evaluation criteria** (how to measure success)
6. **Variations** (optional alternatives for different scenarios)

---

## Example Prompt Enhancement

### Original Prompt (User provides):
```
Write a summary of this article and tell me if it's good or bad.
```

### Enhanced Prompt (You provide):

**For Claude:**
```xml
<task>
Analyze the provided article and create a comprehensive evaluation.
</task>

<instructions>
1. First, read the article carefully and identify:
   - Main thesis and key arguments
   - Supporting evidence and methodology
   - Logical structure and coherence

2. Then, provide a structured summary (150-200 words) covering:
   - Core argument
   - Key supporting points
   - Main conclusions

3. Finally, evaluate the article across these dimensions:
   - Argument quality (logic, evidence, coherence)
   - Writing quality (clarity, structure, style)
   - Credibility (sources, expertise, objectivity)
   
For each dimension, provide:
- Score (1-5)
- Brief justification (2-3 sentences)
- Specific examples from the text
</instructions>

<output_format>
## Summary
[Your 150-200 word summary]

## Evaluation

### Argument Quality: [Score]/5
[Justification with examples]

### Writing Quality: [Score]/5
[Justification with examples]

### Credibility: [Score]/5
[Justification with examples]

## Overall Assessment
[2-3 sentence synthesis]
</output_format>

<article>
[Article text here]
</article>
```

**Techniques used:**
- XML structure for clarity (Claude best practice)
- Chain-of-thought guidance (numbered analysis steps)
- Specific evaluation criteria (reduces ambiguity)
- Defined output format (ensures consistency)
- Example structure shown (format demonstration)

**Why this works:**
- Clear multi-step process guides reasoning
- Specific criteria eliminate "good/bad" ambiguity
- Structured format ensures comprehensive analysis
- Examples in output format show desired structure

---

## Reference Library

### Essential Research

**The Prompt Report (2024)**
- Most comprehensive survey of prompting techniques
- 58 text-based techniques from 1,565 papers
- [Read online](https://trigaten.github.io/Prompt_Survey_Site/)
- [Paper on arXiv](https://arxiv.org/abs/2406.06608)
- [Dataset on HuggingFace](https://huggingface.co/datasets/PromptSystematicReview/Prompt_Systematic_Review_Dataset)

**Key Finding:** Prompting is an evidence-based field with systematic techniques, not an art of trial and error.

---

### Model-Specific Documentation (2026)

**DeepSeek (DeepSeek R1):**
- [DeepSeek R1 GitHub Repository](https://github.com/deepseek-ai/DeepSeek-R1)
- [DeepSeek API Documentation](https://api-docs.deepseek.com/guides/reasoning_model)
- [Prompting Guidelines](https://deepwiki.com/deepseek-ai/DeepSeek-R1/3.3-prompting-guidelines)
- [DeepSeek R1 Release Announcement](https://api-docs.deepseek.com/news/news250120)

**Anthropic (Claude 4.5):**
- [Claude 4.5 Best Practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)
- [What's New in Claude 4.5](https://platform.claude.com/docs/en/about-claude/models/whats-new-claude-4-5)
- [Anthropic Courses](https://github.com/anthropics/courses) - Interactive tutorials
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook) - Code examples
- [Anthropic Prompt Library](https://docs.anthropic.com/claude/prompt-library)
- Context7: `/anthropics/courses` and `/anthropics/anthropic-cookbook`

**OpenAI (GPT-5.2):**
- [GPT-5.2 Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/gpt-5-2_prompting_guide/)
- [GPT-5.2 2026 Playbook](https://www.atlabs.ai/blog/gpt-5.2-prompting-guide-the-2026-playbook-for-developers-agents)
- [OpenAI Cookbook](https://cookbook.openai.com/)
- [GPT Best Practices](https://platform.openai.com/docs/guides/gpt-best-practices)

**Google (Gemini 3):**
- [Gemini 3 Developer Guide](https://ai.google.dev/gemini-api/docs/gemini-3)
- [Gemini 3 Prompting Playbook (Nov 2025)](https://promptbuilder.cc/blog/gemini-3-prompting-playbook-november-2025/)
- [Gemini 3 Prompting Guide (Cloud)](https://docs.cloud.google.com/vertex-ai/generative-ai/docs/start/gemini-3-prompting-guide)
- [Prompt Design Strategies](https://ai.google.dev/gemini-api/docs/prompting-strategies)

---

### Additional Resources

**Prompt Libraries:**
- See `prompt-libraries.md` for comprehensive library listings
- LangChain Hub, Anthropic Library, OpenAI Cookbook
- Community collections: Awesome AI Prompts, FlowGPT, PromptHero

**Technique Catalogs:**
- See `techniques-catalog.md` for 58+ prompting techniques
- Detailed descriptions, templates, and research backing

**Model Comparisons:**
- See `model-comparison.md` for side-by-side model analysis
- Cross-model adaptation checklists
- Performance comparisons by task type

---

### Comparative Resources

**Model Comparison:**
- [Claude vs ChatGPT vs Gemini Best Practices](https://promptbuilder.cc/blog/claude-vs-chatgpt-vs-gemini-best-prompt-engineering-practices-2025)
- [Which AI Needs Which Prompts?](https://sureprompts.com/blog/chatgpt-claude-gemini-comparison)
- [Complete Comparison Matrix](https://www.dataunboxed.io/blog/prompt-engineering-best-practices-complete-comparison-matrix)

**Technique Deep Dives:**
- [Chain of Thought Guide](https://langstop.com/blogs/prompt-engineering/chain-of-thought)
- [ReAct Explained with Examples](https://medium.com/data-science-in-your-pocket/react-chain-of-thoughts-and-trees-of-thoughts-explained-with-example-b9ac88621f2c)
- [Combining CoT and ReAct](https://www.godofprompt.ai/blog/combine-chain-of-thought-and-react-prompting)
- [ReAct Original Paper](https://arxiv.org/abs/2210.03629)

---

### Using Context7 for Latest Docs

Before prompting, always check for up-to-date documentation:

```
1. Resolve library ID:
   mcp__context7__resolve-library-id(
     query="prompting techniques for [model]",
     libraryName="[anthropic/openai/google]"
   )

2. Query specific docs:
   mcp__context7__query-docs(
     libraryId="[ID from step 1]",
     query="[specific technique or question]"
   )
```

---

## Quick Reference: Technique Selection Matrix (2026)

| Use Case | Best Technique | Best Model | Why |
|----------|---------------|------------|-----|
| Complex math/logic | Zero-shot direct | DeepSeek R1, GPT-5.2 Thinking | Built-in reasoning, cost-effective |
| Creative writing | Few-shot examples | GPT-5.2, Claude Sonnet 4.5 | Style learning |
| Structured output | CTCO + JSON schema | GPT-5.2, Claude 4.5 | Format compliance |
| Long document analysis | Simplified prompts | Gemini 3 Pro (1M), Claude Sonnet 4.5 | Context length |
| Real-time info needed | ReAct + Google Search | Gemini 3, GPT-5.2 | Tool integration + grounding |
| Research synthesis | Citation requirements + grounding | Gemini 3 Pro | Factual accuracy + 1M context |
| Multi-step reasoning | CoT + self-consistency | GPT-5.2 Thinking, Claude Opus 4.5 | Maximum reliability |
| Style/tone matching | Few-shot (2-3 examples) | GPT-5.2, Claude 4.5 | Pattern learning |
| Reducing hallucination | ReAct + verification + grounding | Gemini 3, GPT-5.2 | External validation |
| Code generation | CTCO / Extended thinking / Zero-shot | Claude Sonnet 4.5, DeepSeek R1 | State-of-the-art + budget option |
| Autonomous agents | Context awareness + tools | Claude Sonnet/Opus 4.5 | Extended operation |
| Budget reasoning | Zero-shot direct | DeepSeek R1 | o1-level at 1/10th cost |
| High-speed processing | Minimal thinking | Gemini 3 Flash, Claude Haiku 4.5 | Speed + near-frontier intelligence |
| Open-source reasoning | Zero-shot direct | DeepSeek R1 | Open weights, self-hostable |
| Multimodal tasks | Media resolution tuning | Gemini 3 Pro/Flash | Multimodal optimization |
| Image generation | Grounding + thinking | Nano Banana Pro (Gemini 3 Pro Image) | Reasoning + real-time data |

---

## Workflow

When a user asks for prompt help:

1. **Clarify** - Ask about target model if not specified
2. **Understand** - Identify the goal, constraints, and success criteria
3. **Research** - Use Context7 if needed for model-specific docs
4. **Create/Enhance** - Apply appropriate techniques and structure
5. **Test** - Provide example inputs/outputs
6. **Document** - Explain choices and provide alternatives

---

Remember: **Great prompts are programs written in natural language.** They should be clear, unambiguous, testable, and optimized for the specific model that will execute them.

Use this skill to transform vague requests into precise instructions that reliably produce desired outputs.
