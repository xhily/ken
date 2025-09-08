---
slug: class/nextjs/create-project
title: 上线你的第一个 Next.js 项目
draft: true
---

哈喽，我是楷鹏。

本节是一个 Hello World 时刻，将会创建你的第一个 Next.js 项目，并上线到 Vercel。

如果你是一个 Next.js 老炮，那么你可以跳过本节，直接看下一节。

好了，那么创建空白的 Next.js 项目，我们可以借助 `create-next-app` 这个工具。

⚠️ 温馨提示，记得安装 Node.js 18 以上版本。

首先，找到一个干净又卫生的控制台，执行下面命令：

```bash
npx create-next-app@latest
```

按照命令提示选择你喜欢的配置：

```bash
✔ What is your project named? … starter
```

填写项目名称，这里我填的是 `starter`。

```bash
✔ Would you like to use TypeScript? … No / Yes
```

TypeScript 是 JavaScript 的超集，可以编写更安全的代码，这里选 `Yes`。

```bash
? Which linter would you like to use? › - Use arrow-keys. Return to submit.
    ESLint
❯   Biome
    None
    Skip linter configuration
```

linter 是代码检查工具，可以检查代码的错误和风格。

Biome 是比较新的 linter，使用 Rust 编写，性能更好，这里选择 `Biome`。

```bash
✔ Would you like to use Tailwind CSS? … No / Yes
```

Tailwind CSS 是 CSS 框架，可以快速构建样式，这里我选 `Yes`。

```base
✔ Would you like your code inside a `src/` directory? … No / Yes
✔ Would you like to use App Router? (recommended) … No / Yes
✔ Would you like to use Turbopack? (recommended) … No / Yes
```

这三项是关于代码结构、路由和打包工具的，我们全选 `Yes`。

```base
✔ Would you like to customize the import alias (`@/*` by default)? … No / Yes
? What import alias would you like configured? › @/*
```

这个选项是关于导入别名的，可以让依赖关系更清晰，这里选 `Yes`，然后回车（使用默认的 `@/*`）。

那么当你完成上面命令之后，一个新鲜的 Next.js 项目就出炉了。

在控制台运行下面命令，启动 Next.js 项目：

```bash
cd starter
npm run dev
```

接着在浏览器中访问：http://localhost:3000/

激动人心的时刻到了，你将会看到一个默认的页面。

![](https://img.wukaipeng.com//2025/08/24-232628-eGBo1m-image-20250824232628446.png)

将文本“Hello World”写进去，然后保存。

这时，你的第一个 Hello World 程序就写好啦。

![](https://img.wukaipeng.com//2025/08/24-233153-vSooR9-image-20250824233153559.png)

接下来，我们就可以靠 AI 编辑器大军，天马行空。

> Cursor：https://cursor.com/
> Copilot: https://copilot.github.com/
> CodeBuddy:
> Trae:
> Qoder:
> Kiro:
> Windsurf:

挥斥方遒之后，就可以去公开我们的 Next.js 项目了。

部署 Next.js 项目，Vercel 作为我们的第一选择。

无他，主要是——免费、快速。

下面是 Vercel 的免费套餐：

| 资源类型         | 免费月配额                   | 说明                                                                 |
| :--------------- | :--------------------------- | :------------------------------------------------------------------- |
| **项目数量**     | 最多 200 个项目        | 包括前端应用、静态站点和无服务器函数                                   |
| **部署次数**     | 每天 100 次部署        | 连接 Git 仓库后，每次推送代码可自动触发部署                             |
| **带宽**         | 100 GB | 所有进出流量，包括静态资源和API响应                                      |
| **Serverless 函数** | 100 GB·秒 执行时间     | 计算方式为 `函数内存大小 (GB) × 运行时间 (秒) × 调用次数`                |
|                  | 1,000,000 次调用       | 所有 Serverless 函数调用的总次数                                        |
| **Edge Requests** | 1,000,000 次           | **任何**经过 Vercel 全球边缘网络的请求（HTML、CSS、JS、图片、API、重定向等） |
| **存储空间**     | 100 GB                 | 用于存储静态文件（如图片、HTML、CSS、JavaScript 等）                      |
| **团队成员**     | 1 名                   | 免费套餐仅支持个人账户或一名团队成员协作                                   |

这对于一些小型 or 个人项目来说，完全够用。

当然，坏处是 Vercel 在国内访问有阻力，需要一点魔法。

那么接下来，我们就来部署我们的 Next.js 项目。

首先，我们创建一个 GitHub 仓库，将我们的 Next.js 项目推送到 GitHub 仓库中。

接着，我们打开 Vercel 官网：https://vercel.com/

认准这个三角 logo，10 年老字号。

我们使用 GitHub 账号登录 Vercel，进入之后创建项目：

// TODO

然后从 GitHub 中直接导入项目，完成之后点击 Deploy，等待部署完成。

非常 Easy。


