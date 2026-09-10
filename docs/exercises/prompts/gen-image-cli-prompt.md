# Build: Image Generation CLI

**Purpose:** Create a command-line tool that generates images using an AI image generation API. This is used in Exercise 3 or as a standalone tool-building exercise.

## Requirements

### Functional

- Accept a `--prompt` argument (required) describing the image to generate
- Accept `--aspect-ratio` argument with options: `square`, `portrait`, `landscape` (default: `square`)
- Accept `--output` argument for the output file path (default: `output.png`)
- Accept `--provider` argument: `openai`, `gemini`, or `openrouter` (default: `openai`)
- Display a progress message while generating
- Save the generated image to the specified output path
- Print the file path on success

### Technical

- Language: Python (use `uv` for dependency management)
- Minimal dependencies — use the official SDK for the chosen provider
- Load API keys from environment variables or `.env` file:
  - `OPENAI_API_KEY` for OpenAI (DALL-E 3)
  - `GEMINI_API_KEY` for Google Gemini
  - `OPENROUTER_API_KEY` for OpenRouter
- Include a helper script `gen-image.sh` that runs the CLI via `uv run`
- Support `--help` for usage information
- Validate inputs and provide clear error messages

### Provider Details

**OpenAI (GPT Image):**
- Model: `gpt-image-2` (DALL-E 2/3 were shut down in May 2026; `gpt-image-1` variants retire December 2026)
- Endpoint: `/v1/images/generations`; map square/portrait/landscape to the sizes the model accepts (check the Images API docs)

**Google Gemini:**
- Model: `gemini-3.1-flash-image` (or `gemini-3-pro-image` for higher quality; `gemini-2.0-flash-exp` is retired)
- Aspect ratios mapped to API parameters

**OpenRouter:**
- Use the OpenRouter Image API (`POST https://openrouter.ai/api/v1/images`)
- Model: any image model listed on OpenRouter, e.g. `bytedance-seed/seedream-4.5` or `google/gemini-3.1-flash-image`
- Pass `OPENROUTER_API_KEY` as the API key

### Example Usage

```bash
cd gen-image
./gen-image.sh --prompt "A minimalist logo for a todo app, blue gradient" --output logo.png
./gen-image.sh --prompt "A robot coding" --provider gemini --aspect-ratio landscape
./gen-image.sh --help
```

### Project Structure

```
gen-image/
├── pyproject.toml
├── gen-image.sh          # Helper script
├── src/
│   └── gen_image/
│       ├── __init__.py
│       ├── cli.py        # CLI argument parsing
│       └── providers/    # Provider implementations
│           ├── __init__.py
│           ├── openai.py
│           ├── gemini.py
│           └── openrouter.py
└── .env                  # API keys (gitignored)
```
