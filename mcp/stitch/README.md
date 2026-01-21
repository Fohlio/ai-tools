# Stitch MCP Setup

Google Stitch is a UI design tool with MCP integration for AI-powered code generation from Figma-like designs.

## Prerequisites

- macOS with Homebrew
- A Google Cloud project

## Installation

### 1. Install Google Cloud SDK

```bash
brew install google-cloud-sdk
```

Add to your `~/.zshrc`:

```bash
export PATH="/opt/homebrew/share/google-cloud-sdk/bin:$PATH"
source "/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc"
source "/opt/homebrew/share/google-cloud-sdk/path.zsh.inc"
```

Reload shell: `exec zsh`

### 2. Authenticate with Google Cloud

```bash
# Login to gcloud
gcloud auth login

# Set up Application Default Credentials (ADC)
gcloud auth application-default login
```

If browser auth fails, use:

```bash
gcloud auth application-default login --no-browser
```

### 3. Configure Project

```bash
# Set your project (create one at console.cloud.google.com if needed)
gcloud config set project "YOUR_PROJECT_ID"

# Set quota project for ADC
gcloud auth application-default set-quota-project "YOUR_PROJECT_ID"
```

### 4. Enable Stitch MCP Service

```bash
# Install beta components if prompted
gcloud beta services mcp enable stitch.googleapis.com --project="YOUR_PROJECT_ID"
```

### 5. Add IAM Permissions

```bash
# Get your account email
gcloud config get-value account

# Add service usage consumer role
gcloud projects add-iam-policy-binding "YOUR_PROJECT_ID" \
    --member="user:YOUR_EMAIL@gmail.com" \
    --role="roles/serviceusage.serviceUsageConsumer" \
    --condition=None
```

### 6. Generate Access Token

```bash
gcloud auth application-default print-access-token
```

Set this as `STITCH_ACCESS_TOKEN` environment variable.

## MCP Configuration

### Claude Code (`~/.claude.json`)

```json
{
  "mcpServers": {
    "stitch": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "https://stitch.googleapis.com/v1alpha/mcp:streamableHttp"],
      "env": {
        "MCP_HEADERS": "Authorization: Bearer ${STITCH_ACCESS_TOKEN},x-goog-user-project: YOUR_PROJECT_ID"
      }
    }
  }
}
```

### Cursor/VS Code (see `mcp/mcp.json`)

```json
{
  "stitch": {
    "command": "npx",
    "args": ["-y", "mcp-remote", "https://stitch.googleapis.com/v1alpha/mcp:streamableHttp"],
    "env": {
      "MCP_HEADERS": "Authorization: Bearer ${STITCH_ACCESS_TOKEN},x-goog-user-project: ${GCLOUD_PROJECT_ID}"
    }
  }
}
```

## Token Regeneration

Tokens expire after ~1 hour. Use the included script to regenerate:

```bash
./mcp/stitch/refresh-token.sh
```

Or manually:

```bash
export STITCH_ACCESS_TOKEN=$(gcloud auth application-default print-access-token)
```

## Available Tools

Once configured, the following MCP tools become available:

| Tool | Description |
|------|-------------|
| `create_project` | Create a new Stitch project |
| `get_project` | Get project details by name |
| `list_projects` | List all accessible projects |
| `list_screens` | List screens in a project |
| `get_screen` | Get screen details |
| `generate_screen_from_text` | Generate UI from text prompt |

## Troubleshooting

### "quota exceeded" or "API not enabled" error

```bash
gcloud auth application-default set-quota-project "YOUR_PROJECT_ID"
```

### Token expired

Re-run the token refresh script or manually regenerate:

```bash
gcloud auth application-default print-access-token
```

### Permission denied

Ensure you have the `serviceusage.serviceUsageConsumer` role on the project.

## Links

- [Stitch MCP Docs](https://stitch.withgoogle.com/docs/mcp/setup)
- [Google Cloud Console](https://console.cloud.google.com)
