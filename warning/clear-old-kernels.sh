#!/bin/bash

# 获取当前正在运行的内核版本
current_kernel=$(uname -r)

# 列出所有安装的内核包
installed_kernels=$(dpkg --list | grep linux-image | awk '{print $2}')

# 初始化一个要删除的内核列表
kernels_to_remove=()

# 遍历所有安装的内核
for kernel in $installed_kernels; do
  if [[ "$kernel" != *"$current_kernel"* && "$kernel" != "linux-image-amd64" ]]; then
    kernels_to_remove+=("$kernel")
  fi
done

# 如果没有需要删除的内核，退出脚本
if [ ${#kernels_to_remove[@]} -eq 0 ]; then
  echo "没有发现需要删除的旧内核。"
  exit 0
fi

# 显示将要删除的内核并确认
echo "以下内核将被删除:"
for kernel in "${kernels_to_remove[@]}"; do
  echo "$kernel"
done

read -p "你确定要删除这些内核吗？[y/N]: " confirm
if [[ "$confirm" != [yY] ]]; then
  echo "操作取消。"
  exit 0
fi

# 删除旧内核
for kernel in "${kernels_to_remove[@]}"; do
  echo "正在删除 $kernel..."
  sudo apt-get remove --purge -y "$kernel"
done

# 自动清理不再需要的依赖
echo "正在清理未使用的依赖包..."
sudo apt-get autoremove --purge -y

# 更新 GRUB 配置
echo "正在更新 GRUB..."
sudo update-grub

echo "旧内核清理完成。"

exit 0
