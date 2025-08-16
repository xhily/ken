---
slug: class/nextjs/create-project
title: 上线你的第一个 Next.js 项目
draft: true
---

使用 v0 创建页面：https://v0.dev/

哈喽，我是楷鹏。

本节是一个 Hello World 时刻，将会创建你的第一个 Next.js 项目并上线 Vercel。

如果你是一个 Next.js 老炮，那么你可以跳过本节，直接看下一节。

好了，那么创建空白的 Next.js 项目，我们可以借助 `create-next-app` 这个工具。

⚠️ 温馨提示，记得安装 Node.js 18 以上版本。

首先，找到一个干净又卫生的控制台，执行下面命令：

```bash
npx create-next-app@latest`
```

按照命令提示选择你喜欢的配置：

```bash
✔ What is your project named? … my-app
✔ Would you like to use TypeScript? … No / Yes
✔ Would you like to use ESLint? … No / Yes
✔ Would you like to use Tailwind CSS? … No / Yes
✔ Would you like your code inside a `src/` directory? … No / Yes
✔ Would you like to use App Router? (recommended) … No / Yes
? Would you like to use Turbopack for `next dev`? › No / Yes
```

如果你不知道选项是什么意思，没关系，直接选 `No`，这不是在学校上课、在公司上班。

那么当你完成上面命令之后，一个崭新的 Next.js 项目就创建出来啦。

运行：

```bash
npm run dev
```

在浏览器中访问：http://localhost:3000/

激动人心的时刻到了，你将会看到一个默认的页面。

// TODO

将文本“Hello World”写进去，然后保存。

这时，你的第一个 Hello World 程序就写好啦。

// TODO










