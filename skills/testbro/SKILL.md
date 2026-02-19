---
name: ai-tools:testbro
description: Run AI-powered browser tests using TestBro CLI. Guides through setup, test generation, and execution from any project directory. Use when the user mentions "testbro", "browser test", "run tests with testbro", or wants to test a web app with AI.
---

# TestBro Skill

Run AI-powered Playwright tests from plain English descriptions using the TestBro CLI.

## When to Use This Skill

- User wants to run browser tests against a URL
- User wants to generate test cases from a PRD, acceptance criteria, or description
- User wants to set up TestBro in a new project
- User mentions "testbro", "browser test", or wants AI-based testing

## Procedure

### Phase 1: Pre-flight Checks

Run ALL of these checks before executing any tests. Do NOT skip any.

#### 1. CLI Available

Run `testbro --version` to verify the CLI is installed.
- If missing: tell the user to install it with `npm install -g testbro` (or from the monorepo).

#### 2. Authentication

Run `testbro whoami` to verify the user is logged in.
- If not authenticated: run `testbro init` for interactive setup (handles auth + project config in one step).
- Alternative: `testbro login --token <token>` for direct token auth.

#### 3. Active Project

The `whoami` output shows the active project. If none is set, the user will need to either:
- Run `testbro init` to set up project config interactively
- Or select one: `testbro projects` to list, then `testbro use-project <id>`

#### 4. Environment Check

Determine which environment to test against. Read `test-bro.config.json` to check the current `environment` field.

Use `AskUserQuestion` to confirm the target environment:

| Environment | Typical baseUrl |
|:---|:---|
| **local** | `http://localhost:3000` |
| **staging** | `https://staging.myapp.com` |
| **production** | `https://myapp.com` |

If the config has an `environments` section (see "Multi-Environment Config" below), resolve the correct `baseUrl`, `credentials`, and `auth` from the chosen environment.

If not configured, ask the user and help them set up the `environments` block in the config.

#### 5. Local Dev Server Check (if environment is "local")

If the target environment is "local", verify the dev server is actually running:

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000
```

- If the server is not reachable (connection refused / non-200): warn the user and suggest starting it first (e.g., `pnpm dev`, `npm run dev`).
- Do NOT proceed with test execution until the server is confirmed running.

#### 6. Test ID Coverage

Before running tests, check whether the features/pages under test have `data-testid` attributes on key interactive elements (buttons, inputs, links, forms).

**How to check:**
- Read the relevant component/page files that the test will interact with
- Search for `data-testid` on interactive elements (buttons, inputs, links, forms, dialogs)

**If testIds are missing:**
- Warn the user: "The components under test are missing `data-testid` attributes. This makes tests fragile — they'll rely on AI vision or CSS selectors that break on UI changes."
- Offer to add `data-testid` attributes to key interactive elements before running tests.
- Follow the project's naming convention: `data-testid="section-action-element"` (e.g., `data-testid="login-submit-button"`, `data-testid="project-name-input"`).
- Only add testIds to elements the test will interact with — don't blanket every element.

#### 7. Test Credentials & Seed Data

If the test requires authentication (i.e., the config has an `auth` section or the test navigates to protected pages):

**Check credentials exist:**
- Read `test-bro.config.json` — verify the `credentials` block has an entry matching the auth config
- If missing, ask the user for test credentials and add them to the config

**Check the user is seeded in the database:**
- For local environment: verify the test user exists by checking if the seed script has been run. Suggest `pnpm --filter @testbro/db db:seed` if needed.
- For staging/production: ask the user to confirm the test account exists on that environment
- Default seed credentials: `test@testbro.dev` / `Test123456`

**Check auth config completeness:**
- `loginUrl` is set
- `steps` array covers fill email, fill password, click submit
- `waitForUrl` is set (for redirect-based auth like NextAuth) — e.g., `"**/dashboard"`
- Credential template variables (`{{email}}`, `{{password}}`) resolve correctly

### Phase 2: Determine Intent

Use `AskUserQuestion` to clarify what the user wants. Common intents:

| Intent | Description |
|:---|:---|
| **Quick test** | Test a URL with a plain English description |
| **Generate tests** | Create test cases from a file (PRD/AC) or description |
| **Run existing tests** | Run already-saved test cases for a project |
| **Setup project** | Initialize TestBro in the current directory |
| **Full flow** | Generate tests from requirements, then run them |

### Phase 3: Execute Workflow

#### A. Quick Test

Run a one-off test against a URL with a description:

```bash
testbro run --url <url> --description "<what to test>" --mode ai --verbose --record-video
```

**IMPORTANT: Always include `--record-video`** so the user can review what happened.

Options:
- `--mode ai` for vision-based testing (most flexible)
- `--mode hybrid` for selectors + AI fallback (recommended for known UIs)
- `--mode selector` for fast, selector-only testing
- `--headed` to show the browser window
- `--timeout <ms>` to adjust step timeout (default: 30000)
- `--learn-selectors` to learn selectors from AI actions for future runs
- `--record-video` to capture a video of the test execution (always recommended)
- `--yes` to auto-confirm prompts (useful with `--learn-selectors`)

**Adaptive Agent Features** (enabled by default in AI/hybrid modes):
- **Step Recovery**: If a step fails, the agent takes a fresh screenshot and attempts an alternative action to achieve the step's intent (1 retry per step).
- **Continue on Failure**: Failed steps no longer skip all remaining steps. Only unrecoverable failures (page crash, timeout) abort the test.
- **Auto-Login**: If a login page is detected and `auth` config exists in `test-bro.config.json`, the agent handles login transparently. Login steps in test cases are auto-stripped when auth is configured.

#### B. Generate Test Cases

From a file (PRD, acceptance criteria, feature spec):

```bash
testbro generate --file <path> --save
```

From a text description:

```bash
testbro generate --description "<requirements>" --save
```

- `--save` persists the generated test cases to the active project. A **feature** is auto-created from the description/filename and linked to all generated test cases.
- `--project <id>` to target a specific project instead of the active one.
- Every test case must belong to a feature. The CLI auto-creates one if not specified.

#### C. Run Existing Test Cases

Run all test cases for the active project:

```bash
testbro run --url <url> --mode hybrid --verbose --record-video
```

Run a specific test case:

```bash
testbro run --url <url> --test-case <id> --mode hybrid --verbose --record-video
```

Run from a file with deduplication control:

```bash
testbro run --url <url> --file <path> --no-dedup --mode ai --verbose --record-video
```

#### D. Setup Project (Interactive)

Run the interactive setup wizard:

```bash
testbro init
```

This handles everything in one step:
1. Creates global config (`~/.testbro/config.json`) if missing
2. Prompts for API token and validates it
3. Creates or selects a project
4. Generates `test-bro.config.json` with project settings (baseUrl, mode, projectId)
5. Verifies the setup

For CI/CD (non-interactive):

```bash
testbro init --token <token> --project-id <id> --non-interactive
```

Flags:
- `--token <token>` — API token
- `--project-id <id>` — project to use
- `--non-interactive` — skip all prompts, use defaults
- `--skip-project` — skip project setup

#### E. Setup Project (Manual)

For manual config file creation:

```bash
testbro config init
```

This creates `test-bro.config.json`. Edit it to set project-specific values:

```json
{
  "$schema": "https://testbro.dev/schema/config.json",
  "baseUrl": "http://localhost:3000",
  "environment": "local",
  "mode": "hybrid",
  "timeout": 30000,
  "projectId": "<your-project-id>",
  "credentials": {
    "default": {
      "email": "test@example.com",
      "password": "TestPassword123"
    }
  },
  "auth": {
    "loginUrl": "/login",
    "steps": [
      { "action": "fill", "selector": "[data-testid='login-email-input']", "value": "{{email}}" },
      { "action": "fill", "selector": "[data-testid='login-password-input']", "value": "{{password}}" },
      { "action": "click", "selector": "[data-testid='login-submit-button']" }
    ],
    "credentials": { "email": "test@example.com", "password": "TestPassword123" },
    "waitForUrl": "**/dashboard"
  },
  "deduplication": {
    "enabled": true,
    "autoMerge": false
  }
}
```

Key fields:
- `baseUrl`: Default URL when `--url` is not provided
- `mode`: Default execution mode (`selector`, `ai`, `hybrid`)
- `projectId`: Links this directory to a TestBro project
- `credentials`: Login credentials for authenticated testing
- `auth`: Auto-login configuration. When set, the agent logs in before tests and strips login steps from test cases. Uses Playwright storage state (`auth-state.json`) so login only happens once per session.
- `auth.waitForUrl`: URL pattern to wait for after login completes — critical for redirect-based auth flows (NextAuth, OAuth). Example: `"**/dashboard"`.
- `deduplication`: Controls how duplicate test cases are handled during generation

After setting the `projectId`, activate it:

```bash
testbro use-project <project-id>
```

#### F. Multi-Environment Config

For projects that need to test across multiple environments (local, staging, production), set up the `environments` block in `test-bro.config.json`:

```json
{
  "$schema": "https://testbro.dev/schema/config.json",
  "projectId": "<your-project-id>",
  "mode": "hybrid",
  "timeout": 30000,
  "environment": "local",
  "environments": {
    "local": {
      "baseUrl": "http://localhost:3000",
      "credentials": {
        "default": {
          "email": "test@testbro.dev",
          "password": "Test123456"
        }
      },
      "auth": {
        "loginUrl": "/login",
        "steps": [
          { "action": "fill", "selector": "[data-testid='login-email-input']", "value": "{{email}}" },
          { "action": "fill", "selector": "[data-testid='login-password-input']", "value": "{{password}}" },
          { "action": "click", "selector": "[data-testid='login-submit-button']" }
        ],
        "credentials": { "email": "test@testbro.dev", "password": "Test123456" },
        "waitForUrl": "**/dashboard"
      },
      "seed": "pnpm --filter @testbro/db db:seed"
    },
    "staging": {
      "baseUrl": "https://staging.testbro.dev",
      "credentials": {
        "default": {
          "email": "staging-test@testbro.dev",
          "password": "StagingPass123"
        }
      },
      "auth": {
        "loginUrl": "/login",
        "steps": [
          { "action": "fill", "selector": "[data-testid='login-email-input']", "value": "{{email}}" },
          { "action": "fill", "selector": "[data-testid='login-password-input']", "value": "{{password}}" },
          { "action": "click", "selector": "[data-testid='login-submit-button']" }
        ],
        "credentials": { "email": "staging-test@testbro.dev", "password": "StagingPass123" },
        "waitForUrl": "**/dashboard"
      }
    },
    "production": {
      "baseUrl": "https://testbro.dev",
      "credentials": {
        "default": {
          "email": "smoke-test@testbro.dev",
          "password": "ProdSmokePass123"
        }
      },
      "auth": {
        "loginUrl": "/login",
        "steps": [
          { "action": "fill", "selector": "[data-testid='login-email-input']", "value": "{{email}}" },
          { "action": "fill", "selector": "[data-testid='login-password-input']", "value": "{{password}}" },
          { "action": "click", "selector": "[data-testid='login-submit-button']" }
        ],
        "credentials": { "email": "smoke-test@testbro.dev", "password": "ProdSmokePass123" },
        "waitForUrl": "**/dashboard"
      }
    }
  }
}
```

**How environment resolution works:**
1. The top-level `environment` field selects which environment is active by default
2. When running tests, read `environments[activeEnv]` to get `baseUrl`, `credentials`, and `auth`
3. These override the top-level fields for that environment
4. The `--url` CLI flag always takes highest priority

**When helping users set this up:**
- Ask which environments they deploy to
- Get the baseUrl for each
- Get (or help create) test credentials for each environment
- Set up auth steps — prefer `data-testid` selectors for stability
- For local, include a `seed` command hint so the pre-flight check can suggest it

#### G. Full Flow (Generate + Run)

1. Generate test cases from requirements:
   ```bash
   testbro generate --file <path> --save
   ```
2. Run the generated tests:
   ```bash
   testbro run --url <url> --mode hybrid --verbose
   ```
3. Review results: check the output for pass/fail, or view history:
   ```bash
   testbro runs
   ```
4. View details of a specific run:
   ```bash
   testbro runs <run-id>
   ```

### Phase 4: Review Results

After a test run completes:

1. **Always share the video link** with the user if one was produced. The CLI outputs a "Video URL:" line with a public URL — copy it and present it to the user prominently. If no video URL appeared in the output but `--record-video` was used, check the local path from "Video recorded:" and mention it.

2. **Always share the dashboard link** — the CLI outputs a "View results:" line with a dashboard URL.

3. **Show the pass/fail summary** from the output.

4. If tests failed, analyze the failure output and suggest fixes.

5. Additional review commands:
   - List recent runs: `testbro runs` or `testbro runs --status failed --limit 5`
   - View run details (includes video URL, results table): `testbro runs <run-id>`

6. Suggest `--learn-selectors --yes` on successful AI runs to speed up future runs.
7. Suggest saving test cases if they were generated ad-hoc.

## CLI Command Reference

| Command | Description |
|:---|:---|
| `testbro init` | Interactive setup wizard (auth + project config) |
| `testbro login --token <token>` | Authenticate with API token |
| `testbro logout` | Remove stored credentials |
| `testbro whoami` | Show current user and active project |
| `testbro projects` | List available projects |
| `testbro use-project <id>` | Set active project |
| `testbro use-project --clear` | Clear active project |
| `testbro config init` | Create config file in current directory (static template) |
| `testbro config show` | Show current configuration |
| `testbro generate --file <path> --save` | Generate and save test cases from file |
| `testbro generate --description "<text>" --save` | Generate and save test cases from description |
| `testbro run --url <url> --mode <mode>` | Run tests against a URL |
| `testbro run --test-case <id>` | Run a specific test case |
| `testbro runs` | List recent test runs (supports --status, --project, --limit) |
| `testbro runs <run-id>` | View run details with results, video/trace URLs |
| `testbro quickstart` | Demo setup wizard (httpbin.org) |

## Troubleshooting

| Problem | Solution |
|:---|:---|
| `command not found: testbro` | Install globally: `npm install -g testbro` or link from monorepo |
| `Not authenticated` | Run `testbro init` to set up interactively |
| `No active project` | Run `testbro init` or `testbro projects` then `testbro use-project <id>` |
| `No test cases found` | Generate first: `testbro generate --description "..." --save` |
| Timeouts during AI mode | Increase with `--timeout 60000` |
| `baseUrl` not set | Add to `test-bro.config.json` or pass `--url` explicitly |
| Selectors not found | Use `--mode ai` or `--mode hybrid` instead of `--mode selector` |
| Duplicate test cases | Use `--no-dedup` to skip deduplication, or `--auto-merge` to auto-merge |
| Login required but not handled | Add `auth` section to `test-bro.config.json` with login steps and `waitForUrl` |
| Session cookie not captured | Add `waitForUrl` to auth config (e.g., `"**/dashboard"`) — needed for redirect-based auth (NextAuth) |
| Steps skipped after failure | This is legacy behavior — adaptive agent now continues on failure by default |
| Local server not running | Start with `pnpm dev` / `npm run dev` before running tests |
| Test user not seeded | Run `pnpm --filter @testbro/db db:seed` for local environment |
