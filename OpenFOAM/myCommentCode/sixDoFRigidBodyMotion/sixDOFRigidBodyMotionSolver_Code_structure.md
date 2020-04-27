---
layout:     post
title:      The structure of sixDofMotionSolver
date:       2018-12-02
Author:     Maoyanjun
header-img: img/post-myj-photo.jpg
catalog:    true
tags:
     - template:
---

本次博客主要讲述 OpenFOAM 中的 'sixDofMotionSolver' 从而可以明确 动网格的操作和实现流程。

动网格求解器中主要包含这样的一句话：这句话包含了动网格求解所需要的所有内容。

```
mesh.update()
```

这个会根据 'dynamicMeshDict'中 链接的库动态的链接到对应的函数。也就是'dynamicFvMesh/dynamicMotionSolverFvMesh/dynamicMotionSolverFvMesh.C' 的函数中 第62行：

```

```
