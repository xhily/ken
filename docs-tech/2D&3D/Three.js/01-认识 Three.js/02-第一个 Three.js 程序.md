---
slug: /2d-3d/threejs/01/02
---

我们使用 Vite 来初始化我们项目：

```bash
npm init vite@latest`
```

Vite 提供了 Vue、React、Svelte 等框架以供选择，如果不需要任何框架，可以直接选择 `vanilla`。

这里我们选择 `vanilla` 以及集成 TypeScript：

```bash
npm init vite@latest

> npx
> create-vite

│
◇  Project name:
│  solar-system
│
◇  Select a framework:
│  Vanilla
│
◇  Select a variant:
│  TypeScript
```

项目生成后，执行：

```bash
npm install
npm run dev
```

在 `main.js` 文件中，添加如下代码：

```js
import * as THREE from 'three'

// 创建场景
const scene = new THREE.Scene()

// 创建相机
const camera = new THREE.PerspectiveCamera(
  45, // 视角
  window.innerWidth / window.innerHeight, // 宽高比
  0.1, // 近裁面
  1000 // 远裁面
)

// 渲染器
const renderer = new THREE.WebGLRenderer()
renderer.setSize(window.innerWidth, window.innerHeight)
document.body.appendChild(renderer.domElement)

// 创建几何体
const geometry = new THREE.BoxGeometry(1, 1, 1)
// 创建材质
const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
// 创建网格
const cube = new THREE.Mesh(geometry, material)
// 将几何体添加到场景中
scene.add(cube)

// 设置相机位置
camera.position.z = 5
camera.lookAt(0, 0, 0)

// 渲染
function animate() {
  requestAnimationFrame(animate)
  // 旋转
  cube.rotation.x += 0.01
  cube.rotation.y += 0.01
  // 渲染
  renderer.render(scene, camera)
}

animate()
```

运行项目，可以看到一个正在旋转的绿色的正方体：

![Rotated Box](https://img.wukaipeng.com//2025/04/23-173907-qDg1Ei-20250423173842_rec_-convert.gif)

> 示例代码： https://github.com/wukaipeng-dev/threejs-demo/tree/main/01-startapp