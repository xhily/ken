---
slug: /2d-3d/threejs/02/05
---

## 引入 lil-gui 调试

上一节在添加全屏功能时，需要手动添加按钮，并监听点击事件。

如果想要更方便地调试，[可以使用 `lil-gui` 来调试](https://lil-gui.georgealways.com/)。

Three.js 的官方仓库中，提供了 `lil-gui` 的模块化版本，可以直接引入：

```javascript
import { GUI } from 'three/examples/jsm/libs/lil-gui.module.min.js'
```

将上一节的全屏功能，使用 `lil-gui` 来实现：

```javascript
const gui = new GUI()

const events = {
  fullscreen: () => {
    document.documentElement.requestFullscreen()
  },
  exitFullscreen: () => {
    document.exitFullscreen()
  },
}

gui.add(events, 'fullscreen').name('点击全屏')
gui.add(events, 'exitFullscreen').name('退出全屏')
```

![Fullscreen and exit fullscreen](https://img.wukaipeng.com//2025/04/24-155338-2HjjyQ-image-20250424155338105.png)

还可以增加设置 x、y、z 轴的位置：

```javascript
// 设置 x、y、z 轴
const folder = gui.addFolder('设置 x、y、z 轴')
folder.add(cube.position, 'x').min(-10).max(10).step(0.1).name('x')
folder.add(cube.position, 'y').min(-10).max(10).step(0.1).name('y')
folder.add(cube.position, 'z').min(-10).max(10).step(0.1).name('z')
```

设置线框：

```javascript
// 设置线框
const folder2 = gui.addFolder('设置线框')
folder2.add(material, 'wireframe')
```

Lil-gui 还提供回调函数，比如设置颜色：

```javascript
// 设置颜色
const colorObject = {
  color: 0x00ff00,
}

const folder3 = gui.addFolder('设置颜色')
folder3.addColor(colorObject, 'color').onChange(() => {
  material.color.set(colorObject.color)
})
```

![](https://img.wukaipeng.com//2025/04/24-155850-5oKYGM-image-20250424155850215.png)

> 本节示例代码：https://github.com/wukaipeng-dev/threejs-demo/blob/main/02-basic/src/main-lil-gui.ts