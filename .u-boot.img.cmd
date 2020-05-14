#用到了工具 tools/mkimage
# 将要添加到文件 u-boot.bin 的头部，最终生成 u-boot.img
cmd_u-boot.img := ./tools/mkimage -A arm -T firmware -C none -O u-boot -a 0x4a000000 -e 0 -n "U-Boot 2020.01"" for sunxi board" -d u-boot.bin u-boot.img >/dev/null 
g