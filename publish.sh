#!/bin/bash
# GitHub 发布脚本

echo "=== Project Memory Plugin 发布 ==="
echo ""
echo "步骤 1: 在 GitHub 创建仓库"
echo "  访问: https://github.com/new"
echo "  仓库名: project-memory"
echo "  设置为 Public"
echo "  不要勾选 'Add a README file'"
echo ""
echo "步骤 2: 输入你的 GitHub 用户名:"
read -r USERNAME

if [ -z "$USERNAME" ]; then
    echo "错误: 用户名不能为空"
    exit 1
fi

cd ~/.claude/plugins/project-memory

echo ""
echo "步骤 3: 添加远程仓库并推送..."
git remote add origin "https://github.com/$USERNAME/project-memory.git" 2>/dev/null || git remote set-url origin "https://github.com/$USERNAME/project-memory.git"
git branch -M main
git push -u origin main

echo ""
echo "✅ 发布完成！"
echo ""
echo "其他人可以通过以下方式安装:"
echo "  git clone https://github.com/$USERNAME/project-memory.git ~/.claude/plugins/project-memory"
