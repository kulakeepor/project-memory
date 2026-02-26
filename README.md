<div align="center">

# 🧠 Project Memory

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Claude Code](https://img.shields.io/badge/Claude-Code-24292F?style=flat&logo=anthropic&logoColor=white)](https://claude.ai/code)
[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/kulakeepor/project-memory)

### 自动保存和加载项目会话记忆，让你下次打开项目时无缝继续讨论

[English](#english) | [中文](#中文)

</div>

---

## ✨ 功能

- 🔄 **自动加载** - 会话开始时自动显示项目记忆和续接要点
- 💾 **自动保存** - 会话结束时自动保存当前内容
- 📁 **智能组织** - 按项目路径自动组织记忆
- 🧩 **集成学习** - 与 continuous-learning 无缝集成
- 🎯 **命令管理** - `/memory` 命令快速查看和管理

## 📦 安装

```bash
# 方式一：直接克隆
git clone https://github.com/kulakeepor/project-memory.git ~/.claude/plugins/project-memory

# 方式二：添加到 settings.json 的 extraKnownMarketplaces
```

## 🚀 使用

安装后自动运行，无需额外配置。

```bash
# 查看当前项目记忆
/memory

# 查看所有项目记忆
/memory all

# 查看会话历史
/memory sessions

# 编辑记忆文档
/memory edit

# 手动保存当前会话
/memory save

# 清除当前项目记忆
/memory clear
```

## 📂 文件结构

```
~/.claude/memories/
├── {project_hash}/          # 项目哈希目录
│   ├── memory.md            # 主记忆文档
│   └── sessions/            # 会话记录
│       ├── 20250226_093000.md
│       └── 20250226_143000.md
└── index.md                 # 所有项目索引
```

## 🎨 记忆内容

每次会话结束时自动记录：

- **项目上下文** - 路径、Git 分支、远程仓库
- **最近话题** - 从对话中提取的用户提问
- **完成的工作** - 从对话中提取的完成项
- **学习模式** - 集成 continuous-learning 的输出
- **续接要点** - 下次会话的起点

## ⚙️ 配置

插件会自动配置以下 hooks：

```json
{
  "hooks": {
    "SessionStart": {
      "*": ["${CLAUDE_PLUGIN_ROOT}/scripts/load.sh"]
    },
    "Stop": {
      "*": ["${CLAUDE_PLUGIN_ROOT}/scripts/save.sh"]
    }
  }
}
```

## 📝 许可证

[MIT License](LICENSE)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## ⭐ Star

如果这个项目对你有帮助，请给个 Star ⭐

---

## English

A Claude Code plugin that automatically saves and loads project session memory, letting you seamlessly continue discussions when you return to a project.

### Features

- 🔄 Auto-loads project memory on session start
- 💾 Auto-saves session content on session end
- 📁 Organizes memories by project path
- 🧩 Integrates with continuous-learning
- 🎯 `/memory` command for manual management

### Installation

```bash
git clone https://github.com/kulakeepor/project-memory.git ~/.claude/plugins/project-memory
```

### License

[MIT](LICENSE)
