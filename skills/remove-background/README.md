# remove-background

A Claude Code skill that removes backgrounds from images using rembg (local AI model).

## Adding This Skill to Your Project

Copy the `remove-background` folder to your project's `.claude/skills/` directory:

```bash
# From your project root
mkdir -p .claude/skills
cp -r /path/to/ai-tools/skills/remove-background .claude/skills/
```

## Setup

### Install rembg

For CPU (works on all machines):
```bash
pip install "rembg[cpu]"
```

For NVIDIA GPU (faster):
```bash
pip install "rembg[gpu]"
```

### Verify Installation

```bash
rembg --version
```

## Using the Skill

Start Claude Code in your project and ask naturally:

```
Remove background from player.png
```

```
Make all images in the sprites folder transparent
```

```
Remove background from this anime character using the anime model
```

## Manual Usage

```bash
# Single image
rembg i input.png output.png

# Batch process folder
rembg p input_folder/ output_folder/

# Use specific model
rembg i -m isnet-anime anime.png anime_nobg.png

# Better edges with alpha matting
rembg i -a input.png output.png
```

## Available Models

| Model | Best For |
|-------|----------|
| `u2net` (default) | General purpose |
| `u2netp` | Fast, lower quality |
| `u2net_human_seg` | Human subjects |
| `silueta` | Portraits |
| `isnet-general-use` | High quality general |
| `isnet-anime` | Anime/cartoon images |

## Troubleshooting

**"No onnxruntime backend found"**
```bash
pip install "rembg[cpu]"  # reinstall with CPU support
```

**"ModuleNotFoundError: watchdog"**
```bash
pip install watchdog onnxruntime
```

**Slow first run**
- First run downloads the model (~170MB), subsequent runs are faster

**Edges look rough**
- Try alpha matting: `rembg i -a input.png output.png`
- Or try different model: `rembg i -m isnet-general-use input.png output.png`
