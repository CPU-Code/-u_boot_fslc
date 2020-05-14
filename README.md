
 * @Author: cpu_code
 * @Date: 2020-05-14 10:11:25
 * @LastEditTime: 2020-05-14 16:05:19
 * @FilePath: \u_boot_fslc\README.md
 * @Gitee: https://gitee.com/cpu_code
 * @CSDN: https://blog.csdn.net/qq_44226094

# u_boot_fslc

## 介绍
飞思卡尔的编译后的uboot的分析

## 文件描述

uboot自带：

    api:         与硬件无关的 API 函数
    arch:        与架构体系有关的代码，如 arm、 avr32、 m68k 
    board:       不同板子(开发板)的定制代码
    build：      
    cmd:         命令相关代码
    common:      同用代码
    configs：    配置文件
    disk：       磁盘分区相关代码
    doc：        文档
    drivers：    驱动代码
    dts：        设备树
    env：        
    examples：   示例代码
    fs：         文件系统
    include：    头文件
    lib：        库文件
    Licenses：   许可证相关文件
    net：        网络相关代码
    post：       上电自检程序
    scripts：    脚本文件
    spl：        
    test：       测试代码
    tools：      工具文件夹
    .gitignore： git 工具相关文件
    .mailmap：   邮件列表
    config.mk：  某个 Makefile 会调用此文件
    Kbuild：     用于生成一些和汇编有关的文件
    Kconfig：    图形配置界面描述文件
    MAINTAINERS：维护者联系方式文件
    MAKEALL：    一个 shell 脚本文件，帮助编译uboot 的
    Makefile：   主 Makefile，重要文件
    README：     相当于帮助文档。
    snapshot.commint：？？？
编译出来：

    .config：               配置文件，重要的文件
    .u-boot-dtb.bin.cmd:
    .u-boot-dtb.img.cmd:
    .u-boot-nodtb.bin.cmd： 生成 uboot.nodtb.bin
    .u-boot-sunxi-with-spl.bin.cmd:
    .u-boot.bin.cmd：       生成 u-boot.bin
    .u-boot.cmd：           生成 u-boot
    .u-boot.img.cmd：       生成 u-boot.img
    .u-boot.lds.cmd ：      生成 u-boot.lds
    .u-boot.serc.cmd:
    .u-boot.sym.cmd:
    System.map：                系统映射文件
    u-boot：                    编译出来的 ELF 格式的 uboot 镜像文件
    u-boot-dtb.bin:
    u-boot-dtb.img:
    u-boot-nodtb.bin:           和 u-boot.bin 一样， u-boot.bin 就是 u-boot-nodtb.bin 的复制文件
    u-boot-sunxi-with-spl.bin:
    u-boot.bin：                编译出来的二进制格式的 uboot 可执行镜像文件
    u-boot.cfg：                uboot 的另外一种配置文件
    u-boot.cfg.configs:
    u-boot.dtb
    u-boot.dtb.out
    u-boot.img：                u-boot.bin 添加头部信息以后的文件， NXP 的 CPU 专用文件
    u-boot.lds：                链接脚本
    u-boot.map：                uboot 映射文件，通过查看此文件可以知道某个函数被链接到了哪个地址上
    u-boot.srec：               S-Record 格式的镜像文件
    u-boot.sym：                uboot 符号文件

## 分析路径

    .u-bootxx.cmd： 怎么生成 u-boot.xxx
    .config：       如何配置文件
    cmd/Makefile:   


## 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

## 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

## 参与贡献
