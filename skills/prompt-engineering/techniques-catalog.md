# Prompting Techniques Catalog

A comprehensive catalog of 58+ prompting techniques organized by category. Based on "The Prompt Report: A Systematic Survey of Prompting Techniques" (2024).

## Text-Based Techniques

### Reasoning & Problem-Solving

#### Chain-of-Thought (CoT)
**Description:** Ask the model to show intermediate reasoning steps before providing the final answer.

**When to use:**
- Math and logic problems
- Multi-step reasoning
- Tasks requiring explicit steps

**Template:**
```
Question: [question]

Let's solve this step by step:
1. [step 1]
2. [step 2]
3. [final answer]
```

**Research:** Improves accuracy 10-50% on reasoning tasks.

**References:**
- [Chain-of-Thought Guide](https://langstop.com/blogs/prompt-engineering/chain-of-thought)

---

#### ReAct (Reasoning + Acting)
**Description:** Combine reasoning with actions in a loop to access external information.

**When to use:**
- Need real-time/external info
- Tool integration required
- Reducing hallucination

**Template:**
```
Thought: [what I need to know]
Action: [tool/API to use]
Observation: [result]
Thought: [analysis]
... (repeat)
Final Answer: [conclusion]
```

**Research:** Outperforms CoT on Q&A and fact verification. Reduces hallucination significantly.

**References:**
- [ReAct Paper](https://arxiv.org/abs/2210.03629)
- [ReAct Explained](https://medium.com/data-science-in-your-pocket/react-chain-of-thoughts-and-trees-of-thoughts-explained-with-example-b9ac88621f2c)

---

#### Self-Consistency
**Description:** Generate multiple reasoning paths and select the most consistent answer.

**When to use:**
- High-stakes decisions
- Ambiguous problems
- Reducing output variance

**Template:**
```
Generate 3 different solutions using different approaches:

Solution 1: [approach A]
Solution 2: [approach B]
Solution 3: [approach C]

Analyze consistency and synthesize the most reliable answer.
```

**Research:** Improves accuracy 5-20% when combined with CoT.

---

#### Tree-of-Thoughts (ToT)
**Description:** Explore multiple reasoning branches like a search tree, backtracking when needed.

**When to use:**
- Complex planning problems
- Multiple solution paths
- When exploration is needed

**Template:**
```
Problem: [problem]

Explore 3 possible approaches:
Branch 1: [approach 1] → [evaluation] → [continue/backtrack]
Branch 2: [approach 2] → [evaluation] → [continue/backtrack]
Branch 3: [approach 3] → [evaluation] → [continue/backtrack]

Select most promising path and continue.
```

**Research:** Significantly outperforms CoT on planning and search problems.

---

#### Zero-Shot Chain-of-Thought
**Description:** Add "Let's think step by step" to trigger reasoning without examples.

**When to use:**
- Don't have good examples
- Want flexible reasoning
- Quick baseline testing

**Template:**
```
Question: [question]

Let's think step by step:
```

**Research:** Simple addition of this phrase improves reasoning across many tasks.

---

### Learning & Examples

#### Few-Shot Learning
**Description:** Provide 1-5 examples showing desired input-output patterns.

**When to use:**
- Specific format/style needed
- Complex output structure
- Demonstrating edge cases

**Template:**
```
Here are examples:

Input: [example 1 input]
Output: [example 1 output]

Input: [example 2 input]
Output: [example 2 output]

Now solve:
Input: [actual input]
Output:
```

**Best practices:**
- 1-5 examples (quality > quantity)
- Show format AND reasoning
- Include edge cases

**Research:** Most effective when demonstrating both format and reasoning process.

---

#### Zero-Shot Learning
**Description:** Give task instructions without examples.

**When to use:**
- Task is well-understood by model
- Want maximum flexibility
- Don't have good examples yet

**Template:**
```
Task: [clear description]
Requirements: [list requirements]
Output format: [specify format]
```

**Research:** Works well for common tasks; few-shot usually improves performance but may reduce generalization.

---

#### One-Shot Learning
**Description:** Provide exactly one example.

**When to use:**
- Simple format demonstration
- Limited example availability
- Quick format guidance

**Template:**
```
Example:
Input: [input]
Output: [output]

Your turn:
Input: [new input]
Output:
```

---

### Prompting Structure

#### Role Prompting
**Description:** Assign a specific role or persona to the model.

**When to use:**
- Need specific expertise
- Want consistent tone
- Domain-specific knowledge

**Template:**
```
You are a [role] with expertise in [domain].
Your communication style is [description].

Task: [task description]
```

**Research:** Effective for grounding behavior and setting context.

---

#### Instruction Prompting
**Description:** Provide clear, direct instructions for the task.

**When to use:**
- Straightforward tasks
- Clear requirements
- Need explicit control

**Template:**
```
Instructions:
1. [instruction 1]
2. [instruction 2]
3. [instruction 3]

Follow these exactly.
```

---

#### Contextual Prompting
**Description:** Provide rich background context before the task.

**When to use:**
- Complex domain knowledge needed
- Multiple constraints
- Nuanced requirements

**Template:**
```
Context:
[Background information]
[Relevant constraints]
[Important considerations]

Given this context, [task].
```

---

### Output Control

#### Format Prompting
**Description:** Specify exact output structure (JSON, XML, tables, etc.).

**When to use:**
- Need structured data
- Parsing output programmatically
- Consistent format required

**Template:**
```
Output must be valid JSON with this schema:
{
  "field1": "type",
  "field2": "type"
}

No additional text outside the JSON.
```

---

#### Template Prompting
**Description:** Provide a template with placeholders for the model to fill.

**When to use:**
- Consistent structure needed
- Forms or reports
- Standardized outputs

**Template:**
```
Fill in this template:

## Section 1
[Field A]: ___
[Field B]: ___

## Section 2
[Field C]: ___
```

---

#### Length Control
**Description:** Specify desired output length explicitly.

**When to use:**
- Length constraints exist
- Consistent sizing needed
- Conciseness required

**Template:**
```
Task: [task]

Requirements:
- Exactly 200 words
- 3 paragraphs
- No more than 5 bullet points
```

**Best practice:** Be specific with numbers rather than vague terms like "brief" or "detailed."

---

### Refinement & Iteration

#### Iterative Refinement
**Description:** Generate output, then refine it in subsequent steps.

**When to use:**
- Complex outputs
- Multiple quality dimensions
- Incremental improvement

**Template:**
```
Step 1: Draft a [thing]
Step 2: Review for [criteria]
Step 3: Refine based on review
Step 4: Final version
```

---

#### Self-Critique
**Description:** Ask model to critique its own output and improve it.

**When to use:**
- Quality improvement
- Error detection
- Iterative refinement

**Template:**
```
First, generate: [task]

Then, critique your output for:
- [criterion 1]
- [criterion 2]

Finally, provide an improved version.
```

**Research:** Effective for improving quality on second pass.

---

#### Multi-Step Prompting
**Description:** Break complex tasks into explicit sequential steps.

**When to use:**
- Complex multi-stage tasks
- Clear dependencies
- Need intermediate outputs

**Template:**
```
Complete these steps in order:

Step 1: [substask 1]
Output: [format for step 1]

Step 2: [substask 2, using step 1]
Output: [format for step 2]

Step 3: [final integration]
Output: [final format]
```

---

### Meta & Optimization

#### Metaprompting
**Description:** Create prompts that generate or optimize other prompts.

**When to use:**
- Automated prompt generation
- Prompt optimization
- Template creation

**Template:**
```
You are a prompt engineering expert.

Task: Create an optimal prompt for [goal]

Requirements:
- Target model: [model]
- Task type: [type]
- Constraints: [list]

Generate a prompt that [requirements].
```

**Reference:**
- [Anthropic Metaprompt Example](https://github.com/anthropics/anthropic-cookbook/blob/main/misc/metaprompt.ipynb)

---

#### Prompt Chaining
**Description:** Use output from one prompt as input to the next.

**When to use:**
- Complex workflows
- Stage-dependent processing
- Maintaining context across steps

**Template:**
```
Prompt 1: [task 1] → Output A
Prompt 2: Using [Output A], [task 2] → Output B
Prompt 3: Given [Output B], [task 3] → Final Output
```

---

#### Automatic Prompt Engineering (APE)
**Description:** Automatically generate and test prompts to find optimal versions.

**When to use:**
- Large-scale optimization
- A/B testing prompts
- Systematic improvement

**References:**
- [APO Survey (EMNLP 2025)](https://aclanthology.org/2025.emnlp-main.1681.pdf)
- DSPy framework for automatic optimization

---

### Specialized Techniques

#### Analogical Prompting
**Description:** Provide analogies to help model understand the task.

**When to use:**
- Abstract concepts
- Novel tasks
- Building understanding

**Template:**
```
This task is similar to [analogy].
Just as [comparison], in this case [application].

Now, [actual task].
```

---

#### Contrastive Prompting
**Description:** Show both positive and negative examples.

**When to use:**
- Clarifying boundaries
- Avoiding specific mistakes
- Precise behavior control

**Template:**
```
Good examples:
- [example 1]
- [example 2]

Bad examples (avoid this):
- [counterexample 1]
- [counterexample 2]

Now generate: [task]
```

---

#### Constraint Prompting
**Description:** Explicitly list what NOT to do.

**When to use:**
- Avoiding specific behaviors
- Safety requirements
- Compliance needs

**Template:**
```
Task: [task]

Constraints (MUST follow):
- NEVER [forbidden action 1]
- DO NOT [forbidden action 2]
- AVOID [forbidden pattern]
```

---

#### Emotion/Sentiment Prompting
**Description:** Include emotional context or sentiment guidance.

**When to use:**
- Tone control
- Empathetic responses
- Style matching

**Template:**
```
Respond with [emotion/tone] while [task].
Consider that the user feels [sentiment].
```

**Research:** Can improve response quality and appropriateness in social contexts.

---

#### Perspective-Taking Prompting
**Description:** Ask model to take a specific perspective or viewpoint.

**When to use:**
- Multiple stakeholder analysis
- Bias awareness
- Comprehensive evaluation

**Template:**
```
Analyze [topic] from these perspectives:
1. From the view of [stakeholder 1]: [analysis]
2. From the view of [stakeholder 2]: [analysis]
3. Synthesis: [balanced view]
```

---

#### Question Decomposition
**Description:** Break complex questions into simpler sub-questions.

**When to use:**
- Complex information needs
- Multi-faceted problems
- Systematic analysis

**Template:**
```
Main question: [complex question]

Decompose into:
1. [subquestion 1]
2. [subquestion 2]
3. [subquestion 3]

Answer each, then synthesize.
```

---

#### Socratic Prompting
**Description:** Use questioning to guide reasoning and exploration.

**When to use:**
- Learning scenarios
- Deep analysis
- Critical thinking

**Template:**
```
Let's explore [topic] through questions:

Q1: What is [fundamental aspect]?
Q2: Why does [relationship] exist?
Q3: What if [counterfactual]?

Use answers to build understanding.
```

---

#### Verification Prompting
**Description:** Ask model to verify its own answers with evidence.

**When to use:**
- Factual accuracy critical
- Reducing hallucination
- Building trust

**Template:**
```
Task: [task]

After generating answer, verify by:
1. Checking [source/logic]
2. Confirming [key claims]
3. Flagging any uncertainties

Provide confidence level (0-100%).
```

---

#### Exemplar Selection
**Description:** Carefully choose which examples to show based on similarity to task.

**When to use:**
- Diverse task variations
- Improving few-shot effectiveness
- Adaptive prompting

**Research:** Example selection can matter more than number of examples.

---

## Multimodal Techniques

### Vision + Language

#### Visual Question Answering
**Description:** Answer questions about provided images.

**When to use:**
- Image analysis needed
- Visual content understanding
- Multimodal reasoning

**Best models:** Gemini, GPT-4o, Claude (Sonnet 3.5+)

---

#### Image-Grounded Generation
**Description:** Generate text based on image content.

**When to use:**
- Image descriptions
- Alt text generation
- Visual analysis

**Template:**
```
Analyze this image and provide:
1. [aspect 1]
2. [aspect 2]

Be specific about visual elements.
```

---

#### Visual Chain-of-Thought
**Description:** Reason about images step-by-step.

**When to use:**
- Complex visual reasoning
- Multi-step visual analysis
- Spatial reasoning

**Template:**
```
Looking at this image:
1. First, observe [aspect]
2. Then, note [relationship]
3. Therefore, conclude [insight]
```

---

## Multilingual Techniques

#### Cross-Lingual Prompting
**Description:** Use one language for instructions, another for output.

**When to use:**
- Translation tasks
- Multilingual analysis
- Language learning

**Template:**
```
Instructions in English:
[task description]

Respond in [target language]:
```

---

#### Language-Specific Optimization
**Description:** Adapt prompting patterns to specific languages.

**When to use:**
- Non-English primary language
- Cultural context matters
- Language-specific nuances

**Note:** Techniques like CoT may work differently across languages.

---

## Technique Combinations

### Powerful Combinations

1. **CoT + Self-Consistency**
   - Generate multiple reasoning paths
   - Compare for consistency
   - Best for complex reasoning with high stakes

2. **ReAct + Verification**
   - Use tools for information
   - Verify retrieved information
   - Best for factual tasks

3. **Few-Shot + CoT**
   - Show examples WITH reasoning steps
   - Guide both format and thinking
   - Best for complex structured tasks

4. **Role + Constraint Prompting**
   - Set expert persona
   - Add explicit boundaries
   - Best for specialized domains with compliance

5. **Question Decomposition + Chain-of-Thought**
   - Break into sub-questions
   - Reason through each
   - Best for research and analysis

---

## Technique Selection Guide

| Task Type | Recommended Techniques | Priority |
|-----------|----------------------|----------|
| Math/Logic | CoT, Self-Consistency | High |
| Creative Writing | Few-Shot, Role, Emotion | Medium |
| Data Extraction | Format, Few-Shot, Constraint | High |
| Analysis | CoT, Perspective-Taking, Verification | Medium |
| Code Generation | Few-Shot, Multi-Step, Self-Critique | High |
| Research | ReAct, Question Decomposition, Verification | High |
| Summarization | Length Control, Format | Medium |
| Translation | Cross-Lingual, Verification | High |
| Q&A | ReAct, Verification, Context | High |
| Classification | Few-Shot, Contrastive | High |

---

## Anti-Patterns to Avoid

1. **Over-prompting:** Too many instructions dilute focus
2. **Vague language:** "Good" and "comprehensive" are unclear
3. **Mixed techniques:** Don't use CoT with o1 (it's redundant)
4. **No examples for complex format:** Show don't tell for structures
5. **Assuming knowledge:** Provide context, don't assume
6. **Same prompt, all models:** Each model needs optimization
7. **No verification:** Always test with examples
8. **Ignoring token efficiency:** Verbose ≠ better

---

## Research Foundation

This catalog is based on:

- **The Prompt Report (2024)** - 58 techniques from 1,565 papers
  - [Website](https://trigaten.github.io/Prompt_Survey_Site/)
  - [Paper](https://arxiv.org/abs/2406.06608)

- **Academic Papers:**
  - Chain-of-Thought Prompting (Wei et al., 2022)
  - ReAct (Yao et al., 2022)
  - Tree-of-Thoughts (Yao et al., 2023)
  - Self-Consistency (Wang et al., 2022)

- **Industry Documentation:**
  - Anthropic Prompt Engineering Guide
  - OpenAI Best Practices
  - Google Gemini Strategies

---

## Using This Catalog

1. **Identify your use case** in the selection guide
2. **Choose 1-2 primary techniques** (don't overcombine)
3. **Adapt to your target model** using model-specific guidance
4. **Test with examples** to validate effectiveness
5. **Iterate based on results**

Remember: Start simple, test, then add complexity only if needed.
