# Project Memory Plugin

自动保存和加载项目会话记忆，让你下次打开项目时无缝继续讨论。

## 功能

- ✅ 会话开始时自动显示项目记忆
- ✅ 会话结束时自动保存当前内容
- ✅ 按项目路径自动组织记忆
- ✅ 集成 continuous-learning 学习模式
- ✅ `/memory` 命令手动管理

## 安装

```bash
# 克隆到插件目录
git clone <repo> ~/.claude/plugins/project-memory

# 或复制此文件夹到 ~/.claude/plugins/
```

## 使用

安装后自动运行，无需额外配置。

```bash
# 查看当前项目记忆
/memory

# 查看所有项目
/memory all

# 查看会话历史
/memory sessions
```

## 文件结构

```
~/.claude/memories/
├── {project_hash}/
│   ├── memory.md       # 主记忆
│   └── sessions/       # 会话记录
└── index.md            # 项目索引
```
