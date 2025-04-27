---
slug: /2d-3d/threejs/02/10
---

加载模型：

```javascript
// 加载 gltf 模型
const gltfLoader = new GLTFLoader()
gltfLoader.load('/model/Duck.glb', (gltf) => {
  console.log(gltf)
  scene.add(gltf.scene)
})
```


![The duck model](https://img.wukaipeng.com//2025/04/26-230622-OL01F4-image-20250426230622151.png)

可以看到，模型加载成功了，但是却是黑色的，这是因为没有灯光。

添加环境贴图：

```javascript
// 加载 hdr 贴图
const rgbeLoader = new RGBELoader()
rgbeLoader.load('/texture/Alex_Hart-Nature_Lab_Bones_2k.hdr', (envMap) => {
  // 设置环境贴图
  scene.environment = envMap
  // 设置环境贴图的映射方式
  envMap.mapping = THREE.EquirectangularReflectionMapping
})
```

![The duck model with environment map](https://img.wukaipeng.com//2025/04/26-231212-DGdZ0o-image-20250426231212790.png)

可以看到，鸭子模型已经显示出原来的颜色了。

对于压缩过的 GLTF 文件，可以使用 `DRACOLoader` 来加载。

```javascript
// 加载 draco 模型
const dracoLoader = new DRACOLoader()
// 设置 draco 解码器路径
dracoLoader.setDecoderPath('/draco/')
// 设置 draco 加载器
gltfLoader.setDRACOLoader(dracoLoader)
gltfLoader.load('/model/city.glb', (gltf) => {
  console.log(gltf)
  scene.add(gltf.scene)
})
```

![The city model](https://img.wukaipeng.com//2025/04/26-231212-DGdZ0o-image-20250426231212790.png)

可以看到，城市模型已经加载成功了。

> 本节示例代码：https://github.com/wukaipeng-dev/threejs-demo/blob/main/02-basic/src/main-gltf.ts



