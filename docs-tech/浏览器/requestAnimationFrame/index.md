---
slug: /browser/requestAnimationFrame
title: 你好，requestAnimationFrame
---

## requestAnimationFrame 初相遇

requestAnimationFrame 由 3 个单词组成：

- **request** /rɪˈkwest/：请求
- **animation** /ˌænɪˈmeɪʃn/：动画
- **frame** /freɪm/：帧

request ~ animation ~ frame：请求~动画~帧，HTML5 新增的浏览器 API。

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

✋ 求多麻爹（ちょっと待って）！

在动画中，我们不叫做「页」，而是叫做「帧」，也就是单词「frame」。

帧，是动画中最小的单位，一帧就是一张静态的图片。

比如在看《我的阿勒泰》时，弹幕时常惊呼：“每一帧都可以做壁纸”。

那么对于上面视频，时长 15 秒，作者画了 224 帧，也就是每秒 14.9 帧，即 14.9 FPS（Frames Per Second）。

FPS 是动画中非常重要的指标，它决定了动画的流畅度。

目前主流的 FPS 有这么几种：

- 24 FPS：每秒 24 帧，电影标准帧率，使画面看起来流畅且具有“电影感”。

- 30 FPS~60 FPS（含以上）：每秒 30~60 帧，常见于电视节目与一般录影设备。

- 120 FPS~240FPS：每秒 120~240 帧，电竞、VR、运动摄影等，以提升流畅度与即时感。


## 浏览器动画

浏览器实现动画，一种是通过 CSS，比如 `transition`、`animation`，另一种则是通过 JavaScrip。

`setTimeout` 和 `setInterval` 是最古早的动画实现方式，它们会按照指定的固定时间间隔执行回调函数。

用它们实现动画有一个大问题，那是什么问题呢？

我们先来看一个例子：

<video src="./setTimeout-60fps.mp4" controls></video>

这是用 `setTimeout` 实现的动画，时间间隔为 16ms，也就是 60 FPS。

我的显示器默认刷新频率是 60 Hz，等价看做 60 FPS。

但是，当我把显示器刷新频率调到 30Hz 时：

<video src="./setTimeout-30fps.mp4" controls></video>

你可能会觉得头痒，这动画不还是一样的吗？

确实，`setTimeout` 时间是固定的，当显示屏刷新率改变时，`setTimeout` 的执行时机还是雷打不动。

换成 `requestAnimationFrame` 就不一样的，当显示器刷新率为 30Hz 时：

<video src="./requestAnimationFrame-30fps.mp4" controls></video>

可以看到，动画和显示器的刷新频率保持一致，水位拉齐。

你说这有什么问题吗？

还真有，如果放在 144Hz 的显示器上，`setTimeout` 显然就不够打了，会变得卡顿，而 `requestAnimationFrame` 则可以完美适配。

😅 没有 144Hz 的显示器，此处脑补

世界破破烂烂，requestAnimationFrame 缝缝补补。

## 主角

`requestAnimationFrame`，浏览器对动画这一垂直场景打造的 API。

可以把它看做 `setTimeout` 的 Pro 专业版，它的时间参数是浏览器给的，值为当前显示设备的刷新频率。

这是 `requestAnimationFrame` 的最简单用法：

```js
requestAnimationFrame(callback)
```

它会返回一个 `id`，可以传给 `cancelAnimationFrame` 来取消动画，比如：

```js
const id = requestAnimationFrame(callback)
cancelAnimationFrame(id)
```

这里的 `callback` 会传入一个 `timestamp` 参数，表示当前动画执行的时间：

```js
requestAnimationFrame(timestamp => {
  console.log(timestamp)
})
```

掌握上面这些，就可以写一些简单的动画了，比如模拟某良心平台：

<video src="./ad.mp4" controls></video>

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <div id="ad-banner">🚀 双十一，不买立省 100% 🚀</div>
    <style>
      #ad-banner {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 50vh;
        background: linear-gradient(90deg, #ff9800, #ffc107);
        color: #222;
        font-size: 1.5rem;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 1rem 0;
        z-index: 1000;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        font-family: sans-serif;
      }
    </style>
    <script defer>
      const banner = document.getElementById('ad-banner')
      let pos
      const speed = 4 // pixels per frame (faster)
      function startAnimation() {
        pos = -banner.offsetHeight // Start hidden above
        banner.style.transform = `translateY(${pos}px)`
        console.log(banner.style.transform)
        requestAnimationFrame(animate)
      }
      function animate(timestamp) {
        console.log('timestamp', timestamp)
        if (pos < 0) {
          pos += speed
          if (pos > 0) pos = 0 // Clamp to 0
          banner.style.transform = `translateY(${pos}px)`
          requestAnimationFrame(animate)
        }
        // Stops when fully visible (pos === 0)
      }
      // Wait for banner to render to get correct offsetHeight
      window.addEventListener('load', startAnimation)
    </script>
  </body>
</html>
```

## Reference

- https://mp.weixin.qq.com/s/BJ2D37lxh4FaFaFv0ZUp5Q
- https://zh.wikipedia.org/wiki/%E8%A6%96%E8%A6%BA%E6%9A%AB%E7%95%99
- https://stackoverflow.com/questions/64091748/any-advantages-of-using-requestanimationframe-for-non-animation-purposes




