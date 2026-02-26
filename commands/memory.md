---
description: "查看或管理项目记忆"
---

# memory 命令

管理项目会话记忆，让你可以无缝继续之前的讨论。

## 用法

- `memory` - 查看当前项目记忆
- `memory all` - 列出所有项目记忆
- `memory sessions` - 查看会话历史
- `memory edit` - 编辑当前项目记忆
- `memory clear` - 清除当前项目记忆
- `memory save` - 手动保存当前会话

## 工作原理

每次会话自动：
1. **开始时** - 加载项目记忆和上次续接要点
2. **结束时** - 保存当前会话内容

记忆存储在 `~/.claude/memories/`，按项目哈希组织。
