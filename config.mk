 #
 # @Author: cpu_code
 # @Date: 2020-05-14 10:12:50
 # @LastEditTime: 2020-05-14 23:12:40
 # @FilePath: \u_boot_fslc\config.mk
 # @Gitee: https://gitee.com/cpu_code
 # @CSDN: https://blog.csdn.net/qq_44226094
 #
# SPDX-License-Identifier: GPL-2.0+
#
# (C) Copyright 2000-2013
# Wolfgang Denk, DENX Software Engineering, wd@denx.de.
#########################################################################

# This file is included from ./Makefile and spl/Makefile.
# Clean the state to avoid the same flags added twice.
#
# (Tegra needs different flags for SPL.
#  That's the reason why this file must be included from spl/Makefile too.
#  If we did not have Tegra SoCs, build system would be much simpler...)

#  5 个变量在 uboot 根目录下的.config 文件中有定义
PLATFORM_RELFLAGS :=
PLATFORM_CPPFLAGS :=
PLATFORM_LDFLAGS :=
LDFLAGS :=
LDFLAGS_FINAL :=
LDFLAGS_STANDALONE :=
OBJCOPYFLAGS :=
# clear VENDOR for tcsh
VENDOR :=
#########################################################################

# 定义变量 ARCH ，值为 $(CONFIG_SYS_ARCH:"%"=%) ，也就是提取 CONFIG_SYS_ARCH 里面双引号“ ”之间的内容
ARCH := $(CONFIG_SYS_ARCH:"%"=%)
# 定义变量 CPU，值为$(CONFIG_SYS_CPU:"%"=%)
CPU := $(CONFIG_SYS_CPU:"%"=%)
ifdef CONFIG_SPL_BUILD
ifdef CONFIG_TEGRA
CPU := arm720t
endif
endif
BOARD := $(CONFIG_SYS_BOARD:"%"=%)
ifneq ($(CONFIG_SYS_VENDOR),)
VENDOR := $(CONFIG_SYS_VENDOR:"%"=%)
endif
ifneq ($(CONFIG_SYS_SOC),)
SOC := $(CONFIG_SYS_SOC:"%"=%)
endif

# Some architecture config.mk files need to know what CPUDIR is set to,
# so calculate CPUDIR before including ARCH/SOC/CPU config.mk files.
# Check if arch/$ARCH/cpu/$CPU exists, otherwise assume arch/$ARCH/cpu contains
# CPU-specific code.
CPUDIR=arch/$(ARCH)/cpu$(if $(CPU),/$(CPU),)

#  sinclude 和 include 的功能类似，在 Makefile 中都是读取指定文件内容
# 读取文件$(srctree)/arch/$(ARCH)/config.mk 
#  sinclude 读取的文件如果不存在的话不会报错
sinclude $(srctree)/arch/$(ARCH)/config.mk	# include architecture dependend rules

# 读取文件$(srctree)/$(CPUDIR)/config.mk 的内容
sinclude $(srctree)/$(CPUDIR)/config.mk		# include  CPU	specific rules

ifdef	SOC
sinclude $(srctree)/$(CPUDIR)/$(SOC)/config.mk	# include  SoC	specific rules
endif
ifneq ($(BOARD),)
# 定义变量 BOARDDIR ，如 定义了 VENDOR 那么BOARDDIR=$(VENDOR)/$(BOARD)，否则的 BOARDDIR=$(BOARD)
ifdef	VENDOR
BOARDDIR = $(VENDOR)/$(BOARD)
else
BOARDDIR = $(BOARD)
endif
endif
ifdef	BOARD
# 读取文件$(srctree)/board/$(BOARDDIR)/config.mk
sinclude $(srctree)/board/$(BOARDDIR)/config.mk	# include board specific rules
endif

ifdef FTRACE
PLATFORM_CPPFLAGS += -finstrument-functions -DFTRACE
endif

#########################################################################

RELFLAGS := $(PLATFORM_RELFLAGS)

PLATFORM_CPPFLAGS += $(RELFLAGS)
PLATFORM_CPPFLAGS += -pipe

LDFLAGS += $(PLATFORM_LDFLAGS)
LDFLAGS_FINAL += -Bstatic

export PLATFORM_CPPFLAGS
export RELFLAGS
export LDFLAGS_FINAL
export LDFLAGS_STANDALONE
export CONFIG_STANDALONE_LOAD_ADDR
