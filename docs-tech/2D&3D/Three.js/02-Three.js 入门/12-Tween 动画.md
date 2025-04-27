---
slug: /2d-3d/threejs/02/12
---

Tween 动画是一种非常常用的动画效果，它可以让物体在一定时间内从一个状态平滑地过渡到另一个状态。

Three.js 自带 `Tween.js` 库。


创建一个立方体：

```javascript
const geometry = new THREE.BoxGeometry(1, 1, 1)
const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
const cube = new THREE.Mesh(geometry, material)
scene.add(cube)
```

让立方体从左到右移动：

```javascript
const tween = new TWEEN.Tween(cube.position)
tween.to({ x: 1 }, 1000)
tween.repeat(Number.POSITIVE_INFINITY)
tween.start()
```

注意要让 Tween 更新：

```javascript
// 渲染
function animate() {
  //...

  TWEEN.update()
}
```

![The cube moves from left to right](https://img.wukaipeng.com//2025/04/27-133411-OB2BOa-20250427133346_rec_.gif)

> 本节示例代码：https://github.com/wukaipeng-dev/threejs-demo/blob/main/02-basic/src/main-tween.ts
