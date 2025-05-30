---
slug: /browser/rendering
---

# 浏览器渲染原理

当浏览器的网络线程收到 HTML 文档后，会产生一个渲染任务，并将其传递给渲染主线程的消息队列。
在事件循环机制的作用下，渲染主线程取出消息队列中的渲染任务，开启渲染流程。

![](https://img.wukaipeng.com//2025/03/28-203101-TTt5co-image-20250328203100870.png)

整个渲染流程分为多个阶段，分别是：
HTML 解析、样式计算、布局、分层、绘制、分块、光栅化、绘画
每个阶段都有明确的输入输出，上一个阶段的输出会成为下一个阶段的输入。
这样，整个渲染流程就形成了一套组织严密的生产流水线。

![](https://img.wukaipeng.com//2025/03/28-203909-5NAnRx-image-20250328203909242.png)

##  1. 解析 HTML - Parse HTML

解析成 DOM 树 和 CSSOM 树：

```javascript
<!DOCTYPE html>
<html>
  <head>
    <title>page title</title>
    <style></style>
  </head>
  <body>
    <h1>title</h1>
    <div>
      <p>paragraph</p>
    </div>
    <script>
      console.log('helloworld')
    </script>
  </body>
</html>

```

![DOM](https://img.wukaipeng.com//2025/03/28-205235-XxgsoT-image-20250328205234973.png)

```css
body h1{
  color: red;
  font-size: 3em;
}
div p {
  margin: 1em;
  color: blue;
}
```

![CSSOM](https://img.wukaipeng.com//2025/03/28-210241-vrKHpT-image-20250328210240922.png)

> 浏览器中有三种样式表：
> 1. 作者样式表（Author Style Sheets）由网页开发者编写，包括：
>    1. **内联样式（Inline Styles）**  直接通过元素的 `style` 属性定义，优先级最高，例如： `<p style="color: red;">文本</p>`。
>     2. **内部样式表（Internal Style Sheets）**  通过 `<style>` 标签在 HTML 文档头部定义，适用于单个页面的特殊样式。
>     3. **外部样式表（External Style Sheets）** 通过 `<link>` 标签引入独立的 `.css` 文件，可跨页面复用，便于维护。
> 
> 2. 用户样式表（User Style Sheets）由用户自定义，用于覆盖默认样式或增强可访问性。例如：
>
>     - Chrome 用户可通过 `User StyleSheets\Custom.css` 文件定义全局样式。
>     - 用户样式支持 `!important` 标记，可强制覆盖作者样式（级联规则例外）。
>
> 3. 浏览器默认样式表（Browser Default Styles）浏览器内置的基础样式，用于未定义其他样式时的默认渲染。例如：
>
>     - 超链接默认显示为蓝色带下划线（`a { color: blue; text-decoration: underline; }`）。
>
>     - 标题（`h1`-`h6`）有特定字号和外边距，列表（`li`）默认以项目符号显示。

> Tips：通过 CSSOM 全局添加样式
>
> ![](https://img.wukaipeng.com//2025/03/28-223639-tbFNAi-image-20250328223638842.png)



渲染的第一步是解析 HTML。

解析过程中遇到 CSS 解析 CSS，遇到 JS 执行 JS。为了提高解析效率，浏览器在开始解析前，会启动一个预解析的线程，率先下载 HTML 中的外部 CSS 文件和外部的 JS 文件。

如果主线程解析到 `link` 位置，此时外部的 CSS 文件还没有下载解析好，主线程不会等待，继续解析后续的HTML。这是因为下载和解析 CSS 的工作是在**预解析线程**中进行的。这就是 CSS 不会阻塞 HTML 解析的根本原因。

![Parse CSS](https://img.wukaipeng.com//2025/04/01-202105-yJfU9m-image-20250401202105212.png)

如果主线程解析到 `script` 位置，会停止解析 HTML，转而等待 JS 文件下载好，并将全局代码解析执行完成后，才能继续解析 HTML。这是因为 JS 代码的执行过程可能会修改当前的 DOM 树，所以 DOM 树的生成必须暂停。这就是 JS 会阻塞 HTML 解析的根本原因。

![Parse JS](https://img.wukaipeng.com//2025/04/01-211757-rszO65-image-20250401211757580.png)

第一步完成后，会得到 DOM 树和 CSSOM 树，浏览器的默认样式、内部样式、行内样式均会包含在 CSSOM 树中。

> 第一步的目的就是为了生成 DOM 树和 CSSOM 树



## 2. 样式计算 - Recalculate Style

![Recalculate Style](https://img.wukaipeng.com//2025/04/01-211714-7xJWCc-image-20250401211713986.png)

> 样式计算过程包括 CSS 属性值的计算，包括层叠（比较重要性、比较特殊性、比较元次序）、继承。

> 计算后的样式（Computed Style）就是一个元素的最终样式，在 DevTools 体现为：
>
> ![Computed Style in Chrome](https://img.wukaipeng.com//2025/04/01-212528-s6Pa0N-image-20250401212528852.png)



渲染的下一步是样式计算。

主线程会遍历得到的 DOM树，依次为树中的每个节点计算出它最终的样，称之为 Computed Style。

在这一过程中，很多预设值会变成绝对值，比如 `red` 会变成 `rgb(255,0,0);`，相对单位会变成绝对单位，比如 `em` 会变成` px`。

这一步完成后，会得到一棵带有样式的 DOM 树。

## 3. 布局 - Layout

接下来是布局，布局完成后会得到布局树。

布局阶段会依次遍历 DOM 树的每一个节点，计算每个节点的几何信息。例如节点的宽高、相对包含块的位置。

![Layout](https://img.wukaipeng.com//2025/04/01-213902-7mWYgK-image-20250401213902167.png)

> 布局的过程还是会计算宽高，比如一些值为 `auto` 的元素需要等到布局这一步才能计算。

大部分时候，DOM 树和布局树并非一一对应。

比如 `display:none` 的节点没有几何信息，因此不会生成到布局树；又比如使用了伪元素选择器，虽然 DOM 树中不存在这些伪元素节点，但它们拥有几何信息，所以会生成到布局树中。还有匿名行盒、匿名块盒等等都会导致 DOM 树和布局树无法一一对应：

![Display None](https://img.wukaipeng.com//2025/04/02-150027-K4nJ46-image-20250402150026793.png)



![Before](https://img.wukaipeng.com//2025/04/26-154821-6o1zlt-image-20250426154821452.png)

![Anonymous Inline Box and Block Box](https://img.wukaipeng.com//2025/04/02-151358-SbPEK1-image-20250402151357907.png)

> 内容必须在行盒中，行盒和块盒不能相邻。

> 布局树是 C++ 对象，无法直接访问，但是布局树会暴露部分信息，比如 `document.body.clientWidth`、`document.body.clientHight`、



## 4. 分层 - Layer

下一步是分层。

主线程会使用一套复杂的策略对整个布局树中进行分层。

滚动条、堆叠上下文、`transform`、`opacity` 等样式都会或多或少的影响分层结果，也可以通过 `will-change` 属性更大程度的影响分层结果。

> DevTools 查看 Layer：
>
> ![Layer in DevTools](https://img.wukaipeng.com//2025/04/02-173029-aNWbll-image-20250402173028878.png)
>
> 可以看到 `wukaipeng.com` 分了三个层，选择 🔄 按钮后，可以旋转页面，可以看到有三层叠加在一起。



## 5. 绘制 - Painting

再下一步是绘制

主线程会为每个层单独产生绘制指令集，用于描述这一层的内容该如何画出来。

![Command](https://img.wukaipeng.com//2025/04/02-210018-xNNgEu-02-174546-SCa9Kj-image-20250402174546635.png)

> 绘制这一步会生成绘制指令，比如：
>
> ```
> 将笔移动到10,30位置
> 画一个200*300的矩形
> 用红色填充矩形
> ```
>
> 这里其实类似 Canvas

 渲染主线程的工作到此为止，剩余步骤交给其他线程完成：，

![Next Process](https://img.wukaipeng.com//2025/04/02-175257-x4iMmF-image-20250402175257050.png)



## 6. 分块 - Tiling

完成绘制后，主线程将每个图层的绘制信息提交给合成线程，剩余工作将由合成线程完成。

合成线程首先对每个图层进行分块，将其划分为更多的小区域。

它会从线程池中拿取多个线程来完成分块工作。

![Tiling](https://img.wukaipeng.com//2025/04/02-181753-CoPrLX-image-20250402181753292.png)

分块的工作是交给多个线程同时进行的。

![Tiling with Multiple Threads](https://img.wukaipeng.com//2025/04/02-182650-rSKBXd-image-20250402182649964.png)

## 7. 光栅化 - Raster

光栅化是将每个块变成位图，优先处理靠近视口的块：

![Raster](https://img.wukaipeng.com//2025/04/02-185004-7YzE6h-image-20250402185004205.png)

此过程会用到 GPU 加速：

![GPU](https://img.wukaipeng.com//2025/04/02-185725-WkPrEI-image-20250402185725807.png)



分块完成后，进入光栅化阶段。

合成线程会将块信息交给 GPU 进程，以极高的速度完成光栅化。

GPU 进程会开启多个线程来完成光栅化，并且优先处理靠近现口区域的块。

光栅化的结果，就是一块一块的位图。

## 8. 画 - Draw

最后一个阶段就是画了

合成线程拿到每个层、每个块的位图后，生成一个个「指引（quad）」信息。

指引会标识出每个位图应该画到屏幕的哪个位置，以及会考虑到旋转、缩放等变形。

**变形发生在合成线程，与渲染主线程无关**。这就是 `transform` 效率高的本质原因。

合成线程会把 quad 提交给 GPU 进程，由 GPU 进程产生系统调用，提交给GPU硬件。完成最终的屏幕成像。

![Draw](https://img.wukaipeng.com//2025/04/02-191228-eDXLP3-image-20250402191227826.png)



## 完整过程

![Whole Process](https://img.wukaipeng.com//2025/04/02-192626-oDR20d-image-20250402192626576.png)



## 什么是 Reflow？

什么是 reflow？

Reflow 的本质就是重新计算 layout 树。

当进行了会影响布局树的操作后，需要重新计算布局树，会引发 layout。

为了避免连续的多次操作导致布局树反复计算，浏览器会合并这些操作，当JS代码全部完成后再进行统一计算。所以，改动属性造成的 reflow 是异步完成的。

也同样因为如此，当 JS 获取布局属性时，就可能造成无法获取到最新的布局信息。

浏览器在反复权衡下，最终决定获取属性立即 reflow。

![Reflow](https://img.wukaipeng.com//2025/04/02-204352-rWVwwh-image-20250402204352342.png)

## 什么是 Repaint？

Repaint 的本质就是重新根据分层信息计算了绘制指令。

当改动了可见样式后，就需要重新计算，会引发 repaint。

由于元素的布局信息也属于可见样式，所以 reflow 一定会引起 repaint。

![Repaint](https://img.wukaipeng.com//2025/04/02-204508-FEyZVN-image-20250402204508463.png)

## 为什么 `transform` 效率高？

![Transform](https://img.wukaipeng.com//2025/04/02-205034-9MLHWO-image-20250402205034143.png)





![Transform with Animation](https://img.wukaipeng.com//2025/04/02-205254-KVqifj-image-20250402205253968.png)

## Reference

- https://fe.duyiedu.com/p/t_pc/course_pc_detail/video/v_674eb5ece4b023c058afbbc8?product_id=course_2VKbErGXkTSzvbl9aQ9HgndEtIz

