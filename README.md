
<div align='center'>

# AMPD 峰值查找算法

**Automatic Multiscale-based Peak Detection (AMPD) Algorithm**

![AMPD](https://img.shields.io/badge/AMPD-v1.0.202310-blueviolet)
![Fortran](https://img.shields.io/badge/-Fortran-734f96?logo=fortran&logoColor=white)
![Python](https://img.shields.io/badge/-Python-green?logo=Python&logoColor=white)
![Matlab](https://img.shields.io/badge/-Matlab-blue?logo=Octave&logoColor=white)
![Windows](https://img.shields.io/badge/-Windows-blue?logo=windows&logoColor=white)

</div>

本仓库实现了 Python、Matlab、Fortran 语言的 AMPD 算法。建议直接复制 `src/AMPD.*` 文件到项目中使用。

## Fortran

支持 Fortran Package Manager 编译与依赖：

```sh
fpm run --example --all
```

```toml
[dependencies]
AMPD = { git = "https://gitee.com/zoziha/AMPD-Algorithm" }
```

## 参考

1. [An Efficient Algorithm for Automatic Peak Detection in Noisy Periodic and Quasi-Periodic Signals](https://www.mdpi.com/1999-4893/5/4/588/htm).
2. [推荐一个非常实用的峰值查找算法（peak detection）](https://zhuanlan.zhihu.com/p/549588865).