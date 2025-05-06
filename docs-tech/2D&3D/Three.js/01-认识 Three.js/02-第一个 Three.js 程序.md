---
slug: /2d-3d/threejs/01/02
---

我们使用 Vite 来初始化我们项目：

```bash
npm init vite@latest`
```

Vite 提供了 Vue、React、Svelte 等框架以供选择，如果不需要任何框架，可以直接选择 `vanilla`。

这里我们选择 `vanilla` 并且集成 TypeScript：

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
npm i
```

安装 Three.js 依赖：

```bash
npm i three
npm i --save-dev @types/three
```

打开 `main.ts` 文件，添加如下代码：

```typescript
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

打开 `style.css`，修改样式：

```css
* {
  margin: 0;
  padding: 0;
}

canvas {
  display: block;
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
}
```

在 `index.html` 中引用该样式：

```html
<link rel="stylesheet" href="/src/style.css" />
```

运行项目：

```bash
npm run dev
```

可以看到一个正在旋转的绿色的正方体：

![Rotated Box](https://img.wukaipeng.com//2025/04/23-173907-qDg1Ei-20250423173842_rec_-convert.gif)

打开 `main.ts`，增加自适应：

```typescript
// 监听窗口大小
window.addEventListener('resize', () => {
  // 更新渲染器大小
  renderer.setSize(window.innerWidth, window.innerHeight)
  // 更新相机宽高比
  camera.aspect = window.innerWidth / window.innerHeight
  // 更新相机
  camera.updateProjectionMatrix()
})
```

> 示例代码： https://github.com/wukaipeng-dev/threejs-demo/tree/main/01-getting-started/first-three.js-app