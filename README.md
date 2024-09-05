一些可能需要用到的sh脚本，内容基本上都是基于GPT/Claude写的，请各位需要的自行验证

## 清理旧内核脚本
很多VPS服务商的系统镜像在迭代更新的时候，并不会删除旧内核，这将导致小硬盘鸡的存储空间紧张，因此需要一个清理就内核的脚本。
```bash
curl -O https://raw.githubusercontent.com/hi2global/sh/main/warning/clear-old-kernels.sh && chmod +x clear-old-kernels.sh && ./clear-old-kernels.sh
```
对应GPT响应内容 [clear-old-kernels](./chatgpt-log/clear-old-kernels.md)
