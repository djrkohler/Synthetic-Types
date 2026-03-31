#!/bin/bash
set -e

echo "============================================"
echo "  Synthetic Types — Project Setup"
echo "  ABK Stuttgart SS2026"
echo "============================================"
echo ""

# Check Node.js
echo "→ Checking Node.js..."
if ! command -v node &> /dev/null; then
    echo "✗ Node.js not found. Please install from https://nodejs.org (v18+)"
    exit 1
fi

NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    echo "✗ Node.js $NODE_VERSION found, but v18+ is required."
    echo "  Please update: https://nodejs.org"
    exit 1
fi
echo "✓ Node.js $(node -v)"

# Check Claude Code
echo "→ Checking Claude Code..."
if ! command -v claude &> /dev/null; then
    echo "✗ Claude Code not found. Installing..."
    curl -fsSL https://claude.ai/install.sh | bash
    echo "  Please restart your terminal, then run this script again."
    exit 1
fi
echo "✓ Claude Code installed"

# Install Playwright browsers
echo "→ Installing Playwright browser..."
npx playwright install chromium 2>/dev/null || echo "  (Playwright will install on first use)"

# Install yt-dlp (fallback for YouTube transcripts)
echo "→ Checking yt-dlp..."
if ! command -v yt-dlp &> /dev/null; then
    echo "  Installing yt-dlp..."
    if command -v pip3 &> /dev/null; then
        pip3 install --user yt-dlp 2>/dev/null || echo "  (Optional: yt-dlp not installed, YouTube MCP will handle transcripts)"
    elif command -v brew &> /dev/null; then
        brew install yt-dlp 2>/dev/null || echo "  (Optional: yt-dlp not installed)"
    else
        echo "  (Optional: Install yt-dlp manually for YouTube fallback)"
    fi
else
    echo "✓ yt-dlp installed"
fi

# Install K-Dense scientific skills plugin (optional)
echo "→ Note: K-Dense scientific skills plugin"
echo "  To install, run inside Claude Code:"
echo "  /plugin marketplace add K-Dense-AI/claude-scientific-skills"
echo "  /plugin install scientific-skills@claude-scientific-skills"

echo ""
echo "============================================"
echo "  Setup complete!"
echo ""
echo "  To start: claude"
echo ""
echo "  Available commands:"
echo "    /research \"topic\""
echo "    /youtube \"URL\""
echo "    /supply-chain \"material\""
echo "    /construction \"method\""
echo "    /robotics \"topic\""
echo "    /export"
echo "============================================"
