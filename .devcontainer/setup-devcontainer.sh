#!/usr/bin/env bash
set -e

echo "=== Setting up Agentic SWE 2026 Workshop ==="

# Install Claude Code (native installer; falls back to npm)
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash || npm install -g @anthropic-ai/claude-code
export PATH="$HOME/.local/bin:$PATH"

# Install todo-app dependencies
echo "Installing todo-app dependencies..."
cd todo-app
rm -rf .venv
uv sync
cd ..

# Install Gilded Rose test dependencies
echo "Installing Gilded Rose dependencies..."
cd gilded-rose/python
pip install -r requirements.txt 2>/dev/null || true
cd ../..

# Install AndThen plugin (used in Exercise 3 Task 4, Exercise 4 code review, Lab D; optional in Challenge A)
# Source: https://github.com/IT-HUSET/andthen
echo "Installing AndThen plugin..."
(claude plugin marketplace add IT-HUSET/andthen && claude plugin install andthen) 2>/dev/null \
  || echo "Note: AndThen plugin install skipped (requires auth). Install manually inside Claude Code: /plugin marketplace add IT-HUSET/andthen, then /plugin install andthen"

echo ""
echo "=== Setup Complete ==="
echo ""
echo "To get started:"
echo "  1. Run 'claude' to start Claude Code"
echo "  2. Run 'cd todo-app && uv run uvicorn app.main:app --reload' to start the todo app"
echo "  3. Open the exercises in docs/exercises/"
echo ""
