Write-Host "============================================"
Write-Host "  Synthetic Types — Project Setup"
Write-Host "  ABK Stuttgart SS2026"
Write-Host "============================================"
Write-Host ""

# Check Node.js
Write-Host "→ Checking Node.js..."
try {
    $nodeVersion = (node -v) -replace 'v', ''
    $major = [int]($nodeVersion.Split('.')[0])
    if ($major -lt 18) {
        Write-Host "✗ Node.js $nodeVersion found, but v18+ is required."
        Write-Host "  Please update: https://nodejs.org"
        exit 1
    }
    Write-Host "✓ Node.js v$nodeVersion"
} catch {
    Write-Host "✗ Node.js not found. Please install from https://nodejs.org (v18+)"
    exit 1
}

# Check Claude Code
Write-Host "→ Checking Claude Code..."
try {
    claude --version | Out-Null
    Write-Host "✓ Claude Code installed"
} catch {
    Write-Host "→ Installing Claude Code..."
    irm https://claude.ai/install.ps1 | iex
    Write-Host "  Please restart your terminal, then run this script again."
    exit 1
}

# Install Playwright browsers
Write-Host "→ Installing Playwright browser..."
npx playwright install chromium 2>$null

# Create output directories
Write-Host "→ Creating output directories..."
New-Item -ItemType Directory -Force -Path "research" | Out-Null
New-Item -ItemType Directory -Force -Path "sources" | Out-Null
New-Item -ItemType Directory -Force -Path "output/maps" | Out-Null

Write-Host ""
Write-Host "============================================"
Write-Host "  Setup complete!"
Write-Host ""
Write-Host "  To start: claude"
Write-Host ""
Write-Host "  Commands:"
Write-Host "    /explore `"topic`"       — brainstorm and branch out"
Write-Host "    /research `"topic`"      — deep research (auto-detects approach)"
Write-Host "    /connections            — map patterns across your research"
Write-Host "    /connections-report     — write synthesis from map selection"
Write-Host "    /orchestrate `"topic`"   — 6 parallel research tracks"
Write-Host "============================================"
