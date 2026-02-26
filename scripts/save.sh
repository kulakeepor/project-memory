#!/bin/bash
# Save session memory on stop
set -e

MEMORY_DIR="$HOME/.claude/memories"
mkdir -p "$MEMORY_DIR"

WORKING_DIR="${CLAUDE_WORKING_DIR:-$(pwd)}"
PROJECT_HASH=$(echo -n "$WORKING_DIR" | shasum -a 256 | cut -c1-16)
PROJECT_DIR="$MEMORY_DIR/$PROJECT_HASH"
mkdir -p "$PROJECT_DIR/sessions"

MEMORY_FILE="$PROJECT_DIR/memory.md"
DATE=$(date +"%Y-%m-%d %H:%M:%S")
DATE_FILE=$(date +"%Y%m%d_%H%M%S")
SESSION_FILE="$PROJECT_DIR/sessions/$DATE_FILE.md"

# Init memory file if new
if [ ! -f "$MEMORY_FILE" ]; then
    cat > "$MEMORY_FILE" << EOF
# Project Memory

## Project Context
- **Path**: \`$WORKING_DIR\`
- **Created**: $DATE

## Description
## Tech Stack
## Architecture Notes

---
EOF
fi

# Extract recent context from history
HISTORY_FILE="$HOME/.claude/history.jsonl"
if [ -f "$HISTORY_FILE" ]; then
    RECENT=$(tail -50 "$HISTORY_FILE" | python3 -c "
import json, sys
for line in reversed(sys.stdin.readlines()[-30:]):
    try:
        msg = json.loads(line)
        if msg.get('role') == 'user' and msg.get('content'):
            print(f'- {msg[\"content\"][:200]}')
    except: pass
" 2>/dev/null || echo "")
fi

# Create session log
cat > "$SESSION_FILE" << EOF
# Session - $DATE
\`$WORKING_DIR\`

## Topics
$RECENT

## Continuation Notes
- Resume from: $(git branch --show-current 2>/dev/null || echo 'unknown')
- Next: Continue from where we left off
EOF

# Merge continuous-learning output if exists
CL_DIR="$HOME/.claude/skills/continuous-learning/sessions/$PROJECT_HASH"
if [ -d "$CL_DIR" ]; then
    LATEST_CL=$(find "$CL_DIR" -name "summary.md" -type f 2>/dev/null | sort -r | head -1)
    if [ -f "$LATEST_CL" ]; then
        echo "" >> "$SESSION_FILE"
        echo "## Learned" >> "$SESSION_FILE"
        cat "$LATEST_CL" >> "$SESSION_FILE"
    fi
fi

# Update index
INDEX_FILE="$MEMORY_DIR/index.md"
SESSION_COUNT=$(ls -1 "$PROJECT_DIR/sessions/" 2>/dev/null | wc -l | tr -d ' ')

if [ ! -f "$INDEX_FILE" ]; then
    echo "# Project Memories" > "$INDEX_FILE"
    echo "| Hash | Path | Last | Total |" >> "$INDEX_FILE"
    echo "|------|------|------|-------|" >> "$INDEX_FILE"
fi

if ! grep -q "$PROJECT_HASH" "$INDEX_FILE" 2>/dev/null; then
    echo "| $PROJECT_HASH | $WORKING_DIR | $DATE_FILE | $SESSION_COUNT |" >> "$INDEX_FILE"
fi

exit 0
