---
slug: /browser/how-browsers-work
draft: true
---

# 浏览器到底是怎么工作的

本文档来自于 [How browsers work](https://web.dev/howbrowserswork/)

作者是以色列 Web 开发工程师，多年研究浏览器，本文是其研究所得，她说：

> Open source browsers having more than half of the usage share, it's a good time to take a peek under the engine's hood and see what's inside a web browser. Well, what's inside are millions of C++ lines…

“开源浏览器已经有超过一半的市场份额，现在是好时机去窥探一下浏览器引擎的底层，看一下里面有什么。好吧，里面其实是数百万行的 C++ 代码……”



## 介绍（Introduction）

当你敲下 https://wukaipeng.com 的时候，浏览器会发生什么？

这篇文章会介绍从敲下一个 URL 到呈现在你面前的整个过程。



### 浏览器的主要功能（The browser’s main functionality）

浏览器的主要功能是呈现你想要的网络资源，这些资源通常是 HTML、图片、PDF 或者其他类型的资源。唯一定位资源叫做 URI（Uniform Resource Identifier）。

W3C 规定了 HTML 和 CSS 规范，浏览器根据规范去解释和渲染 HTML 和 CSS。浏览器目前部分实现了 W3C 规范，并增加了自身的扩展，这就带来了浏览器兼容问题。

有意思的是，规范中并没有要求浏览器界面长什么样，但大部分浏览器的 UI 元素都差不多，都有地址栏、书签菜单、前进、后退等，这源于**多年来的最佳实践和浏览器之间互相抄袭**。



### 浏览器的高层结构（The browser’s high-level structure）

![Figure 1: Browser components](https://img.wukaipeng.com/2023/0924-212130-image-20230924212130882.png)



1. 用户界面（***User Interface***，简称 UI）

   除了请求正文窗口之外的所有 UI 元素，包括地址栏、书签菜单、前进、后退按钮等等。（也就是浏览器本身的 UI 界面，而不是用户请求的 HTML 界面）

2. 浏览器引擎（***Browser engine***）

   封装用户界面和渲染引擎之间的操作。

3. 渲染引擎（***Rendering engine***）

   解析并渲染用户请求的 HTML、CSS。

4. 网络请求（***Networking***）

   发起 HTTP 请求，封装了对 Windows、MacOS、Linux 等不同平台的网络请求，提供了统一的接口。

5. UI 后台（***UI Backend***）

   绘制元素，比如窗口或者组合框，也是封装了不同平台的实现，提供统一的接口，但是绘制出来的样式却是平台特定的，因为它只是封装一层而已，调用的还是平台原生的样式接口，所以你会看到 Windows 和 MacOS 的样式是不一样的。

6. JavaScript 解释器（***JavaScript interpreter***）

7. 数据存储（***Data storage***）

   可以存储任意类型的数据到本地，例如 cookie、localStorage、webSQL、IndexedDB，还有文件系统。



> 💡 Chrome 多标签页机制
>
> Chrome 会运行多个渲染引擎实例，这是因为每一个 Tab 标签页都运行在单独的渲染引擎进程上。



## 渲染引擎（Rendering Engine）

渲染引擎默认可以渲染用户请求的 HTML、XML 和图片，其他类型，比如 PDF，可以通过插件实现。

不同浏览器使用不同的渲染引擎，FireFox 使用 Gecko，Safari 使用 WebKit，Chrome 和 Opera 使用 Blink（Blink 其实也是 WebKit 的另外分支）。

> WebKit 原本是 Linux 平台上的开源渲染引擎， 后来被苹果修改，用于支持 Mac 和 Windows。
>
> 👉 WebKit 官网：[https://webkit.org/](https://webkit.org/)

### 主流程（The main flow）

在从网络层接收到用户请求的 HTML 内容之后，大概 8kB 为一块，渲染引擎开始工作。

渲染引擎基本流程：

![Figure 2: Rendering engine basic flow](https://img.wukaipeng.com/2023/0924-211228-image-20230924211228730.png)



1. 渲染引擎首先把 HTML 解析为 DOM 节点，所有 DOM 节点组成了**内容树**（Content Tree)
2. 接着解析样式数据，包括外部引入的 CSS 文件和内联样式，样式信息和 HTML 中的视觉指令一起组成了**渲染树**

> 🧐 Me: 这里的“HTML 的视觉指令”是什么意思？
>
> 🤖 GPT4: 在原文中，"visual instructions in the HTML"可能指的是HTML中通过各种标签和属性为网页元素定义的视觉展示方式。例如，HTML中的`<img>`标签用于展示图像，`<p>`标签定义了文本段落，而CSS样式则能进一步为这些元素提供颜色、大小、边距等视觉效果。这些标签和属性能指导渲染引擎如何在屏幕上呈现内容，从而被称作是HTML的“视觉指令”。

3. 渲染树组装后走“排列”的过程，也就是给每一个元素一个确定的屏幕坐标
4. 遍历渲染树每一个节点，并调用 UI 后台去绘制

<br />

为了更好的用户体验，渲染引擎会尽可能快地去渲染内容在屏幕上，而不是得等到所有的 HTML 都解析完毕。所以当一部分内容开始展示在屏幕上的同时，剩下的内容持续从网络层获取并给到渲染引擎。

### 主流程例子（Main flow examples）

WebKit 主流程：

![Figure 3: WebKit main flow](https://img.wukaipeng.com/2024/10/28-1730104552772-JjpGVW-image-20241028154858040.png)

Gecko 主流程：

![Figure 4: Mozilla's Gecko rendering engine main flow](https://img.wukaipeng.com/2024/10/28-1730106696087-Jkyf8F-mozillas-gecko-rendering-b18e445544965.jpg)

Gecko 和 WebKit 不太一样：

- Gecko 把一个元素叫做一“帧”（Frame），元素构成的树叫做“帧树”（Frame Tree）；WebKit 使用的是熟知的“渲染树”（Render Tree）、“渲染对象”（Render Objects）术语
- 排列元素 Gecko 用户的“重排”（Reflow），而 WebKit 用的是“布局”（Layout）
- “附着”（Attachment）是 WebKit 的术语，用于连接 DOM 节点和可视化信息，去创建渲染树的过程。
- Gecko 多了一个“内容汇集器“（Content Sink），它用于制作 DOM 节点

### 解析 - 通常（Parsing - General）

解析是指把文档翻译成可以使用的代码结构，解析结果通常是节点数，称之为“解析树”（parse tree）或者“语法树”（syntax tree）。

比如 `2 + 3 - 1` 的语法树为：

![*Figure 5: mathematical expression tree node*](https://img.wukaipeng.com/2024/10/31-1730370295251-5CAxBl-image-20241031182455073.png)



### 语法（Grammar）

解析基于文档规定的语法，这些语法包含词库（关键字）和规则。



### 解析 - 词法结合（Parsing - Lexer combination）



