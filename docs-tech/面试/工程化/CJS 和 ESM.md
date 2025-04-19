---
slug: /interview/engineering/cjs-and-esm
---

:::note 基本点
1. 标准制订
   1. CJS
      1. 社区标准
      2. 新增 API
    > Node.js 社区推动，由于是社区，所以无法改动语法，仅在 API 层面做新增
   2. ESM
      1. 官方标准
      2. 新增语法
2. 时态
   1. CJS
      1. 运行时
         1. 动态依赖：模块放置在函数中，运行时才能确定依赖关系
         2. 同步加载：依赖是同步加载的（涉及到 IO 操作）
   2. ESM
        1. 编译时（静态依赖，在代码运行前就确定了依赖关系）
        2. 运行时
3. 运行环境
   1. CJS
      1. 仅限于 Node.js 环境
   2. ESM（都支持）
      1. 浏览器环境
      2. Node.js 环境
4. 引用
   1. CJS
      1. 普通函数调用和复制
   2. ESM
      1. 符号绑定

:::

## 1. CommonJS

伪代码实现：

```js
function require(path) {
  if (/* 该模块存在缓存吗？ */) {
    return /* 缓存 */
  }

  function _run(exports, require, module, __filename, __dirname) {
    /* 模块代码 */
  }

  var module = { exports: {} }
  var exports = module.exports

  _run.call(
    module.exports, // 所以模块中 `this` 指向 module.exports
    exports,
    require,
    module,
    /* 模块路径 */
    /* 模块目录 */
  )

  /* 把 module.exports 加入缓存 */

  return module.exports
}

```

### 相关面试题

下面模块最后导出的结果是什么？

```js
exports.a = 'a'

module.exports.b = 'b'

this.c = 'c'

module.exports = {
  d: 'd'
}
```

<details>
  <summary>答案</summary>
  ```js
  {
    d: 'd'
  }
  ```
</details>

## 2. ESM

关于符号绑定（Symbol Binding），在 ESM 中，`export` 并不是拷贝，而是绑定，比如：

```js
// other.js
export let count = 1;

export const increment = () => count++;
```

```js
// main.js
import { count, increment } from './other.js';

console.log('count: ', count); // Output: 1

increment();

console.log('count: ', count); // Output: 2
```

首先这里导入的 `count` 是只读的，其次 `increment` 函数可以修改 `count` 的值，并且会实时绑定（Live Binding），所以在 `increment()` 执行后，`count` 的值会实时更新。


### 相关面试题

`export` 和 `export default` 的区别是什么？

<details>
  <summary>答案</summary>
  1. 导出数量
     1. `export` 可以导出多个
     2. `export default` 一个模块只能有一个
  2. 导出命名
     1. `export` 需要具名导出
     2. `export default` 默认导出，可以不具名
</details>

下面代码最后导出的结果是什么？

```js
// other.js
export let count = 1;

export const increment = () => count++;

// main.js
import { count, increment } from './other.js';
import * as counter from './other.js';

const { count: sameCount } = counter;

increment();

console.log('count: ', count);

console.log('counter.count: ', counter.count);

console.log('sameCount: ', sameCount);
```

<details>
  <summary>答案</summary>
  ```js
  count: 2
  counter.count: 2
  sameCount: 1
  ```
</details>

:::info Hint
只有导入的时候才具有符号绑定，其余都为正常赋值
:::

## Reference

- [CommonJs和ESM的区别？【渡一教育】](https://www.bilibili.com/video/BV1FgcneDE76)
- [ESM模块中的符号绑定](https://juejin.cn/post/7383992257807171594)