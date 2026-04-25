# Vercel AI Gateway Setup

This hub uses **Vercel AI Gateway** as the model provider for unified access to multiple AI models.

## Why Vercel AI Gateway?

- **Single API key** for Anthropic, OpenAI, Google, xAI, and 40+ providers
- **Built-in routing** and fallback
- **Usage tracking** and spend monitoring
- **Caching** and retries

## Getting Started

### 1. Get API Key

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Select your project
3. Go to **AI Gateway** → **API Keys**
4. Create a new API key
5. Copy the key (shown once)

### 2. Add to Environment

```bash
# Add to your shell profile (~/.zshrc)
export VERCEL_AI_GATEWAY_KEY="vck_YourKeyHere"

# Also add MCP tokens (optional)
export OPENCODE_BOT_TOKEN="ghp_YourBotToken"
export HUMAN_TOKEN="ghp_YourHumanToken"
export CONTEXT7_API_KEY="ctx7_YourKey"
```

Apply: `source ~/.zshrc`

### 3. Authenticate

```bash
opencode auth login
```

Select GitHub to authorize (required for MCP GitHub operations).

### 4. Start Using

```bash
opencode
```

The hub is pre-configured with Vercel AI Gateway and multiple models.

## Available Models

| Model | Provider | Description |
|-------|----------|-------------|
| `vercel/anthropic/claude-sonnet-4-20250514` | Anthropic | Claude Sonnet 4.6 (default) |
| `vercel/anthropic/claude-haiku-4-20250514` | Anthropic | Claude Haiku 4.5 |
| `vercel/openai/gpt-5.4` | OpenAI | GPT-5.4 |
| `vercel/openai/gpt-5-mini` | OpenAI | GPT-5 Mini |
| `vercel/google/gemini-2.5-flash` | Google | Gemini 2.5 Flash |
| `vercel/google/gemini-2.5-pro` | Google | Gemini 2.5 Pro |
| `vercel/xai/grok-3` | xAI | Grok 3 |
| `vercel/xai/grok-3-mini` | xAI | Grok 3 Mini |

## Switching Models

```bash
# List available models
/models

# Select a model (during OpenCode session)
/model vercel/anthropic/claude-haiku-4-20250514
```

## Troubleshooting

### "Invalid API key"

Check your Vercel AI Gateway API key is correct:
```bash
echo $VERCEL_AI_GATEWAY_KEY
```

### "Model not found"

Make sure the model is enabled in your Vercel AI Gateway dashboard.

### "Rate limit exceeded"

Configure fallback models in config:
```json
{
  "provider": {
    "vercel": {
      "models": {
        "anthropic/claude-sonnet-4-20250514": {
          "options": {
            "order": ["anthropic", "vertex"]
          }
        }
      }
    }
  }
}
```

## Security Notes

- Never commit API keys to version control
- Use environment variables
- Rotate keys periodically