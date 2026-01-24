# Prompt Libraries & Collections

A curated collection of prompt libraries, repositories, and resources for finding, using, and adapting proven prompts across different AI models.

## Why Use Prompt Libraries?

- **Save time**: Don't reinvent the wheel—start with proven prompts
- **Learn patterns**: See what works for specific use cases
- **Cross-model adaptation**: Find prompts and adapt them to your target model
- **Quality baseline**: Start with tested prompts and customize as needed

---

## Major Prompt Libraries

### LangChain Hub

**Official managed prompt hub with version control and model-specific optimization.**

- **URL**: [LangSmith Hub](https://smith.langchain.com/hub)
- **Access**: Free read-only, full access with LangSmith account
- **Features**:
  - Version control with commit tags
  - Webhook triggers for automation
  - Multi-model tagged prompts (Claude, GPT, Gemini, Llama, etc.)
  - First-class Python/Node SDK integration
  - Community-contributed prompts
  
**Key Advantages:**
- Prompts are tagged per model (OpenAI, Anthropic, Google, open-source)
- Built-in versioning system
- Easy integration via SDK

**How to Use:**
```python
from langchain import hub

# Pull a specific prompt
prompt = hub.pull("username/prompt-name")

# Use with your model
chain = prompt | model
```

**Documentation**: [LangChain Hub Docs](https://docs.smith.langchain.com/prompt_engineering/how_to_guides/langchain_hub)

---

### Anthropic Prompt Library

**Official Claude prompts from Anthropic showcasing best practices.**

- **URL**: [Anthropic Prompts](https://docs.anthropic.com/claude/prompt-library)
- **Focus**: Claude-optimized prompts
- **Categories**:
  - Code generation & review
  - Content creation & editing
  - Analysis & extraction
  - Creative & roleplay
  - Productivity & organization

**Key Features:**
- Claude 4.5-specific optimizations
- XML-tagged structure examples
- Extended thinking patterns
- Tool use demonstrations

**Best For:**
- Claude 4.5 Sonnet/Opus users
- Learning Claude-specific patterns
- XML structure best practices

---

### OpenAI Prompt Examples

**Official prompt examples and patterns from OpenAI.**

- **URL**: [OpenAI Cookbook - Prompting Guide](https://cookbook.openai.com/examples/gpt_prompting_guide/)
- **Focus**: GPT-4o, GPT-5.2 patterns
- **Features**:
  - CTCO Framework examples
  - Few-shot learning templates
  - System message patterns
  - Function calling examples

**GPT-5.2 Specific:**
- Reasoning effort examples
- Plan-then-Execute patterns
- Adaptive reasoning workflows

---

### Google AI Prompt Gallery

**Official Gemini prompts and templates from Google.**

- **URL**: [Google AI Studio](https://aistudio.google.com/prompts)
- **Focus**: Gemini 3.0-optimized prompts
- **Features**:
  - Interactive prompt testing
  - Thinking level examples
  - Multimodal prompt patterns
  - Media resolution optimization

**Key Advantages:**
- Test prompts directly in AI Studio
- Gemini 3 thinking levels demonstrated
- Multimodal best practices

---

### The Prompt Library

**Curated collection of 500+ prompts across 18 categories.**

- **URL**: [The Prompt Library](https://thepromptlibrary.io/)
- **Coverage**: ChatGPT, Claude, Gemini, all major models
- **Categories**: 2,000+ variations organized by use case
- **Features**:
  - Searchable by task/category
  - Model compatibility tags
  - Community ratings
  - Regular updates

**Best For:**
- Cross-model prompt discovery
- Starting point for adaptation
- Use case exploration

---

### Ki-Ecke Prompt Library

**One of the largest AI prompt libraries with 1000+ prompts.**

- **URL**: [Ki-Ecke Prompts](https://ki-ecke.com/prompts/)
- **Models**: ChatGPT, Claude, Gemini, Mistral, LLaMA
- **Categories**:
  - Writing & Content Creation
  - SEO & Marketing
  - Business & Productivity
  - Design & Creative
  - Education & Learning
  - Legal & HR
  - Technical & Coding

**Features:**
- Extremely comprehensive coverage
- Multi-language support
- Free access to all prompts
- Category filters

---

### Awesome AI Prompts (GitHub)

**Open-source curated list of 500+ powerful LLM prompts.**

- **URL**: [Awesome-AI-Prompts](https://github.com/0x2e-Tech/awesome-ai-prompts)
- **Format**: GitHub repository (Markdown)
- **Updates**: Community-driven
- **License**: Open source

**Key Advantages:**
- Fully free and open
- Git-versioned
- Community contributions
- Fork and customize

**How to Use:**
```bash
# Clone the repository
git clone https://github.com/0x2e-Tech/awesome-ai-prompts.git

# Browse by category
cd awesome-ai-prompts/categories
```

---

### PromptBase

**Marketplace for buying and selling prompts.**

- **URL**: [PromptBase.com](https://promptbase.com/)
- **Model Coverage**: DALL-E, Midjourney, ChatGPT, Claude, Stable Diffusion
- **Business Model**: Paid marketplace
- **Features**:
  - Premium quality prompts
  - Creator ratings & reviews
  - Niche-specific collections
  - Prompt versioning

**Best For:**
- Professional prompt engineers
- High-quality curated prompts
- Specialized use cases
- Supporting creators

---

### PromptHero

**Community-driven prompt sharing platform.**

- **URL**: [PromptHero.com](https://prompthero.com/)
- **Focus**: AI art & text generation
- **Models**: ChatGPT, Claude, Midjourney, DALL-E, Stable Diffusion
- **Features**:
  - Free prompt browsing
  - Trending prompts
  - Community voting
  - Search by style/task

---

### FlowGPT

**Social network for AI prompts.**

- **URL**: [FlowGPT.com](https://flowgpt.com/)
- **Community**: Large active user base
- **Features**:
  - Prompt sharing & discovery
  - Upvoting system
  - Prompt chains/workflows
  - Character prompts
  - Roleplay scenarios

**Best For:**
- Creative prompts
- Character AI
- Conversational agents
- Community interaction

---

## Specialized Collections

### GitHub Collections

#### Awesome ChatGPT Prompts
- **URL**: [github.com/f/awesome-chatgpt-prompts](https://github.com/f/awesome-chatgpt-prompts)
- **Stars**: 110K+
- **Focus**: ChatGPT roleplay & character prompts
- **Format**: Ready-to-use prompts in Markdown

#### Prompt Engineering Guide
- **URL**: [github.com/dair-ai/Prompt-Engineering-Guide](https://github.com/dair-ai/Prompt-Engineering-Guide)
- **Focus**: Educational prompting guide
- **Content**: Techniques, papers, tools, notebooks
- **Languages**: 10+ translations

#### LLM Prompts
- **URL**: [github.com/yokoffing/llm-prompts](https://github.com/yokoffing/llm-prompts)
- **Focus**: Curated production-ready prompts
- **Categories**: Business, coding, research, creative

---

## Model-Specific Resources

### Claude 4.5

**Official Resources:**
- [Anthropic Prompt Library](https://docs.anthropic.com/claude/prompt-library)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)
- [Claude 4.5 Best Practices](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-4-best-practices)

**Context7 Access:**
```
Library ID: /anthropics/courses
Library ID: /anthropics/anthropic-cookbook

Use Context7 MCP to query latest examples
```

**Key Pattern Libraries:**
- Extended thinking prompts
- Parallel tool calling patterns
- Context-aware agent workflows
- Effort parameter optimization

---

### GPT-5.2

**Official Resources:**
- [GPT-5.2 Prompting Guide](https://developers.openai.com/cookbook/examples/gpt-5/gpt-5-2_prompting_guide/)
- [OpenAI Cookbook](https://cookbook.openai.com/)
- [GPT Best Practices](https://platform.openai.com/docs/guides/gpt-best-practices)

**CTCO Framework Templates:**
- Context-Task-Constraints-Output patterns
- Reasoning effort examples
- Plan-then-Execute workflows
- JSON schema templates

---

### Gemini 3.0

**Official Resources:**
- [Gemini 3 Developer Guide](https://ai.google.dev/gemini-api/docs/gemini-3)
- [Gemini 3 Prompting Playbook](https://promptbuilder.cc/blog/gemini-3-prompting-playbook-november-2025/)
- [Google AI Studio](https://aistudio.google.com/)

**Key Pattern Libraries:**
- Thinking level examples (minimal, low, medium, high)
- Multimodal prompt patterns
- Media resolution optimization
- Grounding with Google Search

---

### DeepSeek R1

**Official Resources:**
- [DeepSeek R1 GitHub](https://github.com/deepseek-ai/DeepSeek-R1)
- [API Documentation](https://api-docs.deepseek.com/guides/reasoning_model)
- [Prompting Guidelines](https://deepwiki.com/deepseek-ai/DeepSeek-R1/3.3-prompting-guidelines)

**Key Pattern Libraries:**
- Zero-shot reasoning templates
- Self-verification patterns
- Concise instruction examples
- Step-by-step problem-solving

**⚠️ Unique Requirements:**
- NO system prompts (everything in user message)
- NO few-shot examples (hurts performance)
- Use zero-shot approach exclusively
- Keep instructions concise

---

## How to Find the Right Prompt

### 1. Identify Your Use Case

Map your need to a category:
- **Code generation** → Search: "code generation prompt", "coding assistant"
- **Content writing** → Search: "writing assistant", "content creation"
- **Data extraction** → Search: "structured output", "JSON extraction"
- **Analysis** → Search: "analytical thinking", "research assistant"
- **Creative** → Search: "creative writing", "storytelling"

### 2. Search Multiple Libraries

Don't rely on one source:

```
1. Start with official docs (Anthropic/OpenAI/Google)
2. Check LangChain Hub for versioned prompts
3. Browse community collections (GitHub, FlowGPT)
4. Review specialized marketplaces (PromptBase) for premium options
```

### 3. Filter by Model

Always check model compatibility:
- Some prompts are Claude-specific (XML tags)
- Others are GPT-specific (system messages)
- Gemini has unique multimodal patterns

### 4. Adapt to Your Model

Use the model-comparison guide to adapt:

**Example: Converting a GPT prompt to Claude**

Original (GPT):
```
System: You are a code reviewer.

User: Review this code: [code]
```

Adapted (Claude):
```xml
<role>
You are a senior code reviewer.
</role>

<code>
[code]
</code>

<instructions>
1. Analyze for bugs
2. Check security
3. Suggest improvements
</instructions>

<thinking>
[Your analysis]
</thinking>

<review>
[Final review]
</review>
```

---

## Using Context7 to Find Prompts

When you need the latest model-specific examples:

### For Claude 4.5:
```
1. mcp__context7__resolve-library-id(
   query="Claude 4.5 prompting examples",
   libraryName="anthropic courses"
)

2. mcp__context7__query-docs(
   libraryId="/anthropics/courses",
   query="extended thinking prompts for coding tasks"
)
```

### For Anthropic Cookbook:
```
mcp__context7__query-docs(
   libraryId="/anthropics/anthropic-cookbook",
   query="metaprompting examples"
)
```

---

## Building Your Own Prompt Library

### Personal Library Structure

```
my-prompts/
├── by-model/
│   ├── claude-4.5/
│   ├── gpt-5.2/
│   └── gemini-3/
├── by-task/
│   ├── coding/
│   ├── writing/
│   ├── analysis/
│   └── creative/
├── by-technique/
│   ├── chain-of-thought/
│   ├── few-shot/
│   └── react/
└── templates/
    ├── system-prompts.md
    ├── few-shot-templates.md
    └── xml-structures.md
```

### Prompt Template Format

```markdown
# Prompt Name

**Model**: Claude 4.5 Sonnet
**Use Case**: Code Review
**Technique**: Chain-of-Thought + XML Structure

## Prompt

[Full prompt text here]

## Variables

- `{CODE}`: Code to review
- `{LANGUAGE}`: Programming language
- `{FOCUS}`: Specific focus area

## Example Usage

Input:
...

Output:
...

## Notes

- Works best with extended thinking enabled
- Adjust effort parameter for thoroughness
- Can be adapted for GPT-5.2 by...

## Version History

- v1.0 (2026-01-24): Initial version
- v1.1 (2026-02-15): Added security focus
```

---

## Prompt Evaluation Tools

### Testing Prompts

Before adding to your library:

1. **Test with multiple inputs**
   - Edge cases
   - Typical cases
   - Failure cases

2. **Compare models**
   - Does it work across models?
   - Which performs best?
   - What adaptations are needed?

3. **Measure results**
   - Accuracy
   - Consistency
   - Token efficiency
   - Latency

### Prompt Eval Frameworks

- **LangSmith**: Built-in evaluation tools
- **PromptFoo**: Open-source prompt testing
- **Braintrust**: ML evaluation platform
- **Custom scripts**: Build your own test suite

---

## Prompt Discovery Workflow

### Step-by-Step Process

```
1. Define Task
   ↓
2. Search Libraries
   - Official docs (Anthropic/OpenAI/Google)
   - LangChain Hub
   - Community repos (GitHub)
   - Prompt marketplaces
   ↓
3. Find 3-5 Candidates
   ↓
4. Test Each Prompt
   - With your specific input
   - Note what works/doesn't work
   ↓
5. Select Best Candidate
   ↓
6. Adapt to Your Model
   - Use model-comparison guide
   - Apply model-specific patterns
   ↓
7. Iterate & Refine
   - Test edge cases
   - Optimize structure
   - Add examples if needed
   ↓
8. Save to Personal Library
   - Document adaptations
   - Note model compatibility
   - Track version changes
```

---

## Advanced: Automated Prompt Discovery

### Using APIs to Search Prompts

```python
import requests

def search_langchain_hub(query, model=None):
    """
    Search LangChain Hub for prompts
    """
    # Use LangSmith API
    pass

def search_github_prompts(query):
    """
    Search GitHub for prompt repos
    """
    # Use GitHub API
    pass

def aggregate_prompts(task, model):
    """
    Search multiple sources and rank by relevance
    """
    results = []
    results.extend(search_langchain_hub(task, model))
    results.extend(search_github_prompts(task))
    # Rank by model compatibility + ratings
    return sorted(results, key=lambda x: x['score'], reverse=True)
```

### Building a Prompt Cache

```python
from typing import Dict, List
import json

class PromptCache:
    def __init__(self, cache_file='prompt_cache.json'):
        self.cache_file = cache_file
        self.prompts = self.load_cache()
    
    def add_prompt(self, name, prompt, model, task, technique):
        """Add prompt to cache with metadata"""
        self.prompts[name] = {
            'prompt': prompt,
            'model': model,
            'task': task,
            'technique': technique,
            'added': datetime.now().isoformat()
        }
        self.save_cache()
    
    def search(self, task=None, model=None, technique=None):
        """Search cached prompts"""
        results = []
        for name, data in self.prompts.items():
            if task and task.lower() not in data.get('task', '').lower():
                continue
            if model and model.lower() not in data.get('model', '').lower():
                continue
            if technique and technique.lower() not in data.get('technique', '').lower():
                continue
            results.append((name, data))
        return results
```

---

## Community Resources

### Forums & Discussions

- [OpenAI Community](https://community.openai.com/)
- [Anthropic Discord](https://discord.com/invite/anthropic)
- [Google AI Discord](https://discord.gg/googleai)
- [r/PromptEngineering](https://reddit.com/r/PromptEngineering)
- [r/ChatGPT](https://reddit.com/r/ChatGPT)

### Newsletters & Blogs

- [Prompt Engineering Daily](https://www.neatprompts.com/blog)
- [LearnPrompting](https://learnprompting.org/)
- [Anthropic Blog](https://www.anthropic.com/news)
- [OpenAI Blog](https://openai.com/blog)

---

## Quick Reference: Where to Find What

| Need | Best Source | Alternative |
|------|------------|-------------|
| Claude 4.5 prompts | Anthropic Library, Context7 | LangChain Hub |
| GPT-5.2 prompts | OpenAI Cookbook | GitHub collections |
| Gemini 3 prompts | Google AI Studio | PromptBuilder |
| Creative prompts | FlowGPT | PromptHero |
| Code prompts | GitHub Awesome lists | LangChain Hub |
| Production prompts | LangChain Hub | PromptBase (paid) |
| Quick start | The Prompt Library | Ki-Ecke |
| Learning patterns | Prompt Engineering Guide | Official docs |
| Cross-model prompts | Ki-Ecke, The Prompt Library | GitHub |
| Latest examples | Context7 + official docs | Community forums |

---

## Integration with This Skill

When using the prompt-engineering skill:

1. **Finding prompts**: Ask "Search for prompts for [task] using [model]"
2. **Adapting prompts**: Provide a prompt and say "Adapt this for [model]"
3. **Comparing prompts**: Give 2-3 prompts and ask "Which is best for [use case]?"
4. **Learning patterns**: Ask "Show me examples of [technique] for [model]"

The skill will:
- Use Context7 for latest official examples
- Reference the libraries listed here
- Apply model-specific adaptations
- Provide tested, optimized versions

---

**Remember**: Prompt libraries are starting points, not final solutions. Always test, adapt, and iterate for your specific use case and target model.
