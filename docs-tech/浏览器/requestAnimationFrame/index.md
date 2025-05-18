---
slug: /browser/requestAnimationFrame
---

🚧 WIP

## 什么是 requestAnimationFrame

requestAnimationFrame 由 3 个单词组成：

- **request** /rɪˈkwest/：请求
- **animation** /ˌænɪˈmeɪʃn/：动画
- **frame** /freɪm/：帧

request ~ animation ~ frame：请求动画帧，HTML5 新增的浏览器 API。

初次见到这个 API 时，会觉得丈二摸不着头脑，每个单词都懂，但组在一起怎么这么抽象，这个 API 是做什么的？

我们看下 MDN 的解释：

> The `window.requestAnimationFrame()` method tells the browser you wish to **perform an animation**. It requests the browser to **call a user-supplied callback function before the next repaint**.

翻译翻译，也就是说这个 API 是告诉浏览器，**你希望执行一个动画，浏览器会在下一次重绘之前调用你提供的回调函数**。

## 动画

「动画」，相信对大家来说应该不陌生。

它是一种视觉上的错觉，**通过快速切换图片，让眼睛误以为图片在动**。

制作动画，最简单的方式就是手翻画，比如下面画的诗人：

<video src="./uIeuV9FsAd4.mp4" controls></video>

> https://v.douyin.com/uIeuV9FsAd4/

整条视频 15 秒，作者画了 224 页图片。

ちょっと待って！ ✋

在动画中，我们不叫做「页」，而是叫做「帧」，也就是单词「frame」。

帧，是动画中最小的单位，一帧就是一张静态的图片。

比如作为向往草原的牛马，在看《我的阿勒泰》时，弹幕时常惊呼：“每一帧都可以做壁纸”。

那么对于上面视频，时长 15 秒，作者画了 224 帧，也就是每秒 14.9 帧，即 14.9 FPS（Frames Per Second）。

FPS 是动画中非常重要的指标，它决定了动画的流畅度。

目前主流的 FPS 有这么几种：

- 24 FPS：每秒 24 帧，电影标准帧率，使画面看起来流畅且具有“电影感”。

- 30 FPS~60 FPS（含以上）：每秒 30~60 帧，常见于电视节目与一般录影设备。

- 120 FPS~240FPS：每秒 120~240 帧，电竞、VR、运动摄影等，以提升流畅度与即时感。


## 浏览器动画

浏览器实现动画，一种是通过 CSS（`transition`、`animation`），另一种是通过 JavaScrip（`setTimeout`、`setInterval`、`requestAnimationFrame`）。

`setTimeout` 和 `setInterval` 是浏览器提供的定时器，它们会按照指定的固定时间间隔执行回调函数。



## Reference

- https://mp.weixin.qq.com/s/BJ2D37lxh4FaFaFv0ZUp5Q
- https://zh.wikipedia.org/wiki/%E8%A6%96%E8%A6%BA%E6%9A%AB%E7%95%99
- https://stackoverflow.com/questions/64091748/any-advantages-of-using-requestanimationframe-for-non-animation-purposes




