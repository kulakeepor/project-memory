#!/bin/bash
# memory command handler

MEMORY_DIR="$HOME/.claude/memories"
WORKING_DIR="$(pwd)"
PROJECT_HASH=$(echo -n "$WORKING_DIR" | shasum -a 256 | cut -c1-16)
PROJECT_DIR="$MEMORY_DIR/$PROJECT_HASH"
MEMORY_FILE="$PROJECT_DIR/memory.md"

ACTION="${1:-show}"

case "$ACTION" in
    show|view)
        if [ -f "$MEMORY_FILE" ]; then
            cat "$MEMORY_FILE"
        else
            echo "📭 No memory yet. Will auto-save on session end."
        fi
        ;;
    all|list)
        if [ -f "$MEMORY_DIR/index.md" ]; then
            cat "$MEMORY_DIR/index.md"
        else
            echo "📭 No memories found."
        fi
        ;;
    sessions)
        if [ -d "$PROJECT_DIR/sessions" ]; then
            ls -lt "$PROJECT_DIR/sessions/" | head -11
        else
            echo "No sessions."
        fi
        ;;
    edit) ${EDITOR:-vi} "$MEMORY_FILE" ;;
    clear)
        rm -f "$MEMORY_FILE"
        echo "🗑️ Memory cleared."
        ;;
    save) exec ~/.claude/plugins/project-memory/scripts/save.sh ;;
    *)
        echo "Usage: memory [show|all|sessions|edit|clear|save]"
        ;;
esac
