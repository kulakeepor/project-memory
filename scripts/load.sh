#!/bin/bash
# Load project memory on session start
set -e

MEMORY_DIR="$HOME/.claude/memories"
WORKING_DIR="${CLAUDE_WORKING_DIR:-$(pwd)}"
PROJECT_HASH=$(echo -n "$WORKING_DIR" | shasum -a 256 | cut -c1-16)
PROJECT_DIR="$MEMORY_DIR/$PROJECT_HASH"

MEMORY_FILE="$PROJECT_DIR/memory.md"
LATEST_SESSION=$(ls -t "$PROJECT_DIR/sessions/" 2>/dev/null | head -1)

if [ ! -f "$MEMORY_FILE" ]; then
    exit 0
fi

cat << 'HEADER'


═══════════════════════════════════════════════════════════
📚  PROJECT MEMORY LOADED
═══════════════════════════════════════════════════════════

HEADER

awk '/^## Project Context/,/^---/' "$MEMORY_FILE" 2>/dev/null | head -20

if [ -n "$LATEST_SESSION" ]; then
    echo ""
    echo "📝 Last Session Notes:"
    grep -A 10 "## Continuation Notes" "$PROJECT_DIR/sessions/$LATEST_SESSION" 2>/dev/null || true
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo ""

exit 0
