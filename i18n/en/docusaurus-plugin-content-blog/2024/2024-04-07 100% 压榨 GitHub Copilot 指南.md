---
slug: github-copilot
title: Guide to 100% Maximizing GitHub Copilot
---

Long before OpenAI launched ChatGPT, OpenAI had already partnered with GitHub to launch GitHub Copilot.

> Hereinafter referred to as Copilot

Copilot caused a sensation in the programming community at that time.

The radical claim back then was: **Copilot will replace programmers**.

Three years later, calm down - Copilot hasn't replaced programmers as hoped.

Instead, it's a powerful assistant that improves efficiency. Mastering it can **multiply your programming efficiency**.

![](https://img.wukaipeng.com/2024/04/12-234638-MyWTBn-download.png)

## Copilot Pricing

Domestic developers are relatively price-sensitive.

Copilot officially offers two subscription types: **Individual** and **Team**.

Let's skip the team version - if you have company support, you don't need to worry about this.

Individual pricing comes in two options:
1. Monthly subscription, $10 per month, **¥72.37 RMB**
2. Annual subscription, $100 per year, **¥723.7 RMB**

![](https://img.wukaipeng.com/2024/04/12-234839-d3CXp0-image-20240412234839346.png)

The individual version includes a 30-day free trial period, so you can try it first.

GitHub is quite friendly - it **supports domestic credit card payment**, including China Merchants Bank, GuangFa Bank, China Construction Bank, etc.

For unofficial channels like Taobao or uTools plugins, they might be unstable but are cheaper.

## Copilot Family Suite

Using Copilot is simple - install the corresponding plugin in VSCode/JetBrains, then log in with your GitHub account.

![](https://img.wukaipeng.com/2024/04/12-181521-InDV4W-12-180931-cqLDKX-image-20240412180930744.png)

> 👉 VSCode: https://marketplace.visualstudio.com/items?itemName=GitHub.copilot
> 👉 JetBrains: https://plugins.jetbrains.com/plugin/17718-github-copilot

After installation, when typing code, Copilot will automatically suggest code. Press `Tab` to complete.

![](https://img.wukaipeng.com/2024/04/12-181423-r0m99D-212964557-8d832278-61bb-4288-a8a7-47f35859e868.gif)

JetBrains' Copilot plugin integration provides sidebar Chat functionality:

![](https://img.wukaipeng.com/2024/04/12-182530-ZLDeBh-image-20240412182529852.png)

For VSCode users, to enable sidebar Chat functionality, you need to install the additional Copilot Chat plugin:

![](https://img.wukaipeng.com/2024/04/12-182139-JZOxxA-image-20240412182138873.png)

After installation, the sidebar menu will have a new "Chat" option, with a chat interface like ChatGPT:

![](https://img.wukaipeng.com/2024/04/12-182250-GevSkt-image-20240412182250704.png)

VSCode is indeed a bit more troublesome, but has an advantage.

New Copilot features will be launched on VSCode first, like Copilot Voice.

![](https://img.wukaipeng.com/2024/04/12-212938-WOOCt5-12-212913-8ez2BA-image-20240412212912912.png)

Install this plugin in VSCode 👇 to experience **voice programming**.

![](https://img.wukaipeng.com/2024/04/12-213107-dMajyo-image-20240412213107161.png)

Although it currently only supports English, multilingual support will surely come soon.

![Speech to text in Visual Studio Code Chat](https://img.wukaipeng.com/2024/04/12-213300-UPF36A-63279c01-3941-46c5-bf51-284fbc31fbfe.gif)

Even with English-only support, I believe Chinese developers who've been learning English since childhood have excellent English skills.

![](https://img.wukaipeng.com/2024/04/12-213812-4hp6KE-R.jpeg)

## Copilot Code Completion

Besides Copilot's automatic triggering, we can also use `Option` + `\` to manually trigger code completion.

> Windows: `Alt` + `\`

Although the manual shortcut is rarely used, it's useful for testing Copilot during network fluctuations.

After triggering code completion, pressing `Tab` accepts all the code, but sometimes we only need partial completion.

You can use `Command` + → to accept completion code step by step:
> Windows: `Ctrl` + →

![](https://img.wukaipeng.com/2024/04/12-221048-rhh5pH-20240412221008_rec_-convert.gif)

If you're not satisfied with the current completion, you can press `Option` + `]` or `Option` + `[` to switch to the next or previous completion:
> Windows: `Alt` + `]` or `Alt` + `[`

![](https://img.wukaipeng.com/2024/04/12-221510-ZAlVae-20240412221442_rec_-convert.gif)

For VSCode, press `Command` + `I` to invoke Copilot Editor in code:
> Windows: `Ctrl` + `I`

![](https://img.wukaipeng.com/2024/04/12-222404-6ICwrS-20240412222305_rec_-convert.gif)

## Using Copilot Chat

Copilot Chat is like having GPT-4 directly in your editor, allowing quick Q&A about project issues:

![](https://img.wukaipeng.com/2024/04/12-222909-NjtEzI-image-20240412222909416.png)

For JetBrains IDEs, you need to right-click on files to show references:

![](https://img.wukaipeng.com/2024/04/12-223012-8owLSw-image-20240412223012255.png)

JetBrains IDEs are currently clumsy, requiring manual right-clicking to specify files and referencing entire files.

VSCode doesn't need explicit specification - it automatically determines whether to reference the entire file or just the selected portion:

![](https://img.wukaipeng.com/2024/04/12-223257-kmNJYr-image-20240412223257582.png)

## Some Small Joys with Copilot

Let me mention some of Copilot's nice-to-have features, like directly generating Commit Messages:

![](https://img.wukaipeng.com/2024/04/12-223743-34Opnl-20240412223717_rec_-convert.gif)

Generating Git Commits is really convenient - it detects all file changes and generates appropriate messages.

Another feature is variable renaming, though it's currently unstable, so I'll skip it for now.

## Copilot CLI

Copilot CLI is now fully available, allowing you to use Copilot in the command line.

For example, we can ask Copilot to explain what the `sudo apt-get` command means:

![](https://img.wukaipeng.com/2024/04/12-225423-uOLDTd-image-20240412225423062.png)

However, CLI is still quite dumb. It's better to use Warp's AI features, as mentioned in my previous article 👉

[Beautiful, Functional + Free AI-Powered Terminal Tool: Recommending Warp!](https://mp.weixin.qq.com/s/l9IZeitz8zX7GjZFAR5xFg)



