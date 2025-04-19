---
slug: /interview/git/reflog
---

> 九瓴科技一面

:::note 基本点

1. reflog 其实是 reference log 的缩写，相当于 git 操作的日志
2. 可以通过 reflog 恢复删除的分支、提交的误操作

:::

运行 `git reflog` 查看日志：

```bash
> git reflog

ed7c138 (HEAD -> main, origin/main, origin/HEAD) HEAD@{0}: checkout: moving from demo to main
b273aa8 (demo) HEAD@{1}: checkout: moving from main to demo
ed7c138 (HEAD -> main, origin/main, origin/HEAD) HEAD@{2}: checkout: moving from demo to main
b273aa8 (demo) HEAD@{3}: commit: 🚧 chore: Remove mdnice.css file to streamline styles and improve project organization
e9d0937 HEAD@{4}: checkout: moving from main to demo
ed7c138 (HEAD -> main, origin/main, origin/HEAD) HEAD@{5}: commit: 🚧 chore: Remove draft blog posts on programming experiences and learning English to streamline content and improve organization
```

每一行操作的含义：

- `ed7c138` 是 commit hash
- `HEAD@{0}` 是当前分支的指针
- `checkout: moving from demo to main` 是操作
- `HEAD@{0}: checkout: moving from demo to main` 是操作的日志


比如要恢复误删除的分支：

```
git checkout -b new-branch-for-feature <commit hash>
```






