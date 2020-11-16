Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgKPIdc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 03:33:32 -0500
MIME-Version: 1.0
References: <202011140757.5QyVghe2-lkp@intel.com> <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
In-Reply-To: <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 16 Nov 2020 09:33:07 +0100
Message-ID: <CAK8P3a0w5MpvExp1jShAhqZ3Z08HjMALic6x2K+1_0eqFUi5QA@mail.gmail.com>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kernel test robot <lkp@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, kbuild-all@lists.01.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Mon, Nov 16, 2020 at 5:33 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/13/20 3:27 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81
> > commit: ef8c01eb64ca6719da449dab0aa9424e13c58bd0 irqchip: Add Loongson PCH PIC controller
> > date:   6 months ago
> > config: s390-randconfig-r022-20201113 (attached as .config)
> > compiler: s390-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >          chmod +x ~/bin/make.cross
> >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef8c01eb64ca6719da449dab0aa9424e13c58bd0
> >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >          git fetch --no-tags linus master
> >          git checkout ef8c01eb64ca6719da449dab0aa9424e13c58bd0
> >          # save the attached .config to linux build tree
> >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
>
> Hi lkp (ktr) et al,
>
> arch/s390/Kconfig says that HAS_IOMEM depends on CONFIG_PCI and the
> supplied .config.gz file has
> # CONFIG_PCI is not set
>
> Does that mean that all of these drivers should have an additional
>         depends on HAS_IOMEM
> in their Kconfig entries?
>
> That's what it would take for them to have access to all of the
> devm_platform_iomap* type functions.
>
> For most ARCHes, OF_ADDRESS also depends on HAS_IOMEM, so that's why
> of_iomap() is not available.

(adding s390 folks to cc)

I think fixing this requires a larger-scale effort. I tried building
an s390 allmodconfig
with CONFIG_PCI disabled, and got warnings and failures in many other places,
see full log at the end of this mail.

While in theory, all of those should depend on 'HAS_IOMEM' or some other symbol,
keeping these dependencies sounds like an uphill battle, and there is not much
to be gained from building the drivers for s390 on top of compile-testing them
on more conventional architectures.

One easy hack would be to force-enable PCI when compile-testing:

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0eebaf40c259..bde714e0a8cb 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -187,6 +187,7 @@ config S390
        select PCI_DOMAINS              if PCI
        select PCI_MSI                  if PCI
        select PCI_MSI_ARCH_FALLBACKS   if PCI_MSI
+       select PCI                      if COMPILE_TEST
        select SET_FS
        select SPARSE_IRQ
        select SYSCTL_EXCEPTION_TRACE

This seems to avoid all the problems with few downsides other than it
being a rather artificial dependency.

      Arnd

WARNING: unmet direct dependencies detected for MFD_ATMEL_SMC
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_SYSCON
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - BT1_AXI [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - POWER_RESET_OCELOT_RESET [=y] && POWER_RESET [=y] && (MSCC_OCELOT
|| ARCH_SPARX5 || COMPILE_TEST [=y])
  - COMMON_CLK_GEMINI [=y] && COMMON_CLK [=y] && (ARCH_GEMINI ||
COMPILE_TEST [=y])
  - COMMON_CLK_ASPEED [=y] && COMMON_CLK [=y] && (ARCH_ASPEED ||
COMPILE_TEST [=y])
  - COMMON_CLK_OXNAS [=y] && COMMON_CLK [=y] && (ARCH_OXNAS ||
COMPILE_TEST [=y])
  - COMMON_CLK_BOSTON [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - CLK_BT1_CCU_PLL [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - CLK_BT1_CCU_DIV [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - INGENIC_TCU_CLK [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - INGENIC_TIMER [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_SYSOST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_OST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - EXYNOS_CHIPID [=y] && SOC_SAMSUNG [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]
  - BT1_L2_CTL [=y] && MEMORY [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - INGENIC_TCU_IRQ [=y] && (MIPS || COMPILE_TEST [=y])
  Selected by [m]:
  - MTD_NAND_STM32_FMC2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(MACH_STM32MP157 || COMPILE_TEST [=y])
  - MTD_NAND_MESON [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(ARCH_MESON || COMPILE_TEST [=y])
  - ARMADA_37XX_WATCHDOG [=m] && WATCHDOG [=y] && (ARCH_MVEBU ||
COMPILE_TEST [=y])
  - PHY_HI3670_USB [=m] && STAGING [=y] && (ARCH_HISI && ARM64 ||
COMPILE_TEST [=y])
  - HWSPINLOCK_QCOM [=m] && HWSPINLOCK [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
  - ASPEED_LPC_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_LPC_SNOOP [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_P2A_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_XDMA [=m] && (ARCH_ASPEED || COMPILE_TEST [=y]) && HAS_DMA [=y]
  - QCOM_GSBI [=m] && (ARCH_QCOM || COMPILE_TEST [=y])
  - STM32_FMC2_EBI [=m] && MEMORY [=y] && (MACH_STM32MP157 || COMPILE_TEST [=y])
  - PHY_BCM_SR_PCIE [=m] && OF [=y] && (ARCH_BCM_IPROC || COMPILE_TEST [=y])
  - PHY_HI3660_USB [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISTB_COMBPHY [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISI_INNO_USB2 [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_DA8XX_USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_AT91PIO4 [=y] && PINCTRL [=y] && OF [=y] && (ARCH_AT91 ||
COMPILE_TEST [=y])
  - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
[=y]) && OF [=y]
  - PINCTRL_MTK_MOORE [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_STM32_TIMERS
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_STM32 && OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - STM32_ADC_CORE [=m] && IIO [=m] && (ARCH_STM32 || COMPILE_TEST
[=y]) && OF [=y] && REGULATOR [=y]

WARNING: unmet direct dependencies detected for MFD_STMFX
  Depends on [n]: HAS_IOMEM [=n] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - PINCTRL_STMFX [=m] && PINCTRL [=y] && I2C [=m] && OF_GPIO [=y]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
  - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [m]:
  - MFD_HI6421_SPMI [=m] && STAGING [=y] && OF [=y] && SPMI [=m]

WARNING: unmet direct dependencies detected for MVMDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && HAS_IOMEM [=n]
  Selected by [m]:
  - MV643XX_ETH [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (MV64X60 || PPC32 || PLAT_ORION ||
COMPILE_TEST [=y]) && INET [=y]
  - MVNETA [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])
  - MVPP2 [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for MDIO_OCTEON
  Depends on [n]: NETDEVICES [=y] && MDIO_DEVICE [=m] && MDIO_BUS [=m]
&& (64BIT [=y] && OF_MDIO [=m] || COMPILE_TEST [=y]) && HAS_IOMEM [=n]
  Selected by [m]:
  - OCTEON_ETHERNET [=m] && STAGING [=y] && (CAVIUM_OCTEON_SOC ||
COMPILE_TEST [=y]) && NETDEVICES [=y]

WARNING: unmet direct dependencies detected for GPIO_GENERIC
  Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_NPCM7XX [=y] && PINCTRL [=y] && (ARCH_NPCM7XX ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_ATMEL_SMC
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_SYSCON
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - BT1_AXI [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - POWER_RESET_OCELOT_RESET [=y] && POWER_RESET [=y] && (MSCC_OCELOT
|| ARCH_SPARX5 || COMPILE_TEST [=y])
  - COMMON_CLK_GEMINI [=y] && COMMON_CLK [=y] && (ARCH_GEMINI ||
COMPILE_TEST [=y])
  - COMMON_CLK_ASPEED [=y] && COMMON_CLK [=y] && (ARCH_ASPEED ||
COMPILE_TEST [=y])
  - COMMON_CLK_OXNAS [=y] && COMMON_CLK [=y] && (ARCH_OXNAS ||
COMPILE_TEST [=y])
  - COMMON_CLK_BOSTON [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - CLK_BT1_CCU_PLL [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - CLK_BT1_CCU_DIV [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - INGENIC_TCU_CLK [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - INGENIC_TIMER [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_SYSOST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_OST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - EXYNOS_CHIPID [=y] && SOC_SAMSUNG [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]
  - BT1_L2_CTL [=y] && MEMORY [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - INGENIC_TCU_IRQ [=y] && (MIPS || COMPILE_TEST [=y])
  Selected by [m]:
  - MTD_NAND_STM32_FMC2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(MACH_STM32MP157 || COMPILE_TEST [=y])
  - MTD_NAND_MESON [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(ARCH_MESON || COMPILE_TEST [=y])
  - ARMADA_37XX_WATCHDOG [=m] && WATCHDOG [=y] && (ARCH_MVEBU ||
COMPILE_TEST [=y])
  - PHY_HI3670_USB [=m] && STAGING [=y] && (ARCH_HISI && ARM64 ||
COMPILE_TEST [=y])
  - HWSPINLOCK_QCOM [=m] && HWSPINLOCK [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
  - ASPEED_LPC_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_LPC_SNOOP [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_P2A_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_XDMA [=m] && (ARCH_ASPEED || COMPILE_TEST [=y]) && HAS_DMA [=y]
  - QCOM_GSBI [=m] && (ARCH_QCOM || COMPILE_TEST [=y])
  - STM32_FMC2_EBI [=m] && MEMORY [=y] && (MACH_STM32MP157 || COMPILE_TEST [=y])
  - PHY_BCM_SR_PCIE [=m] && OF [=y] && (ARCH_BCM_IPROC || COMPILE_TEST [=y])
  - PHY_HI3660_USB [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISTB_COMBPHY [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISI_INNO_USB2 [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_DA8XX_USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_AT91PIO4 [=y] && PINCTRL [=y] && OF [=y] && (ARCH_AT91 ||
COMPILE_TEST [=y])
  - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
[=y]) && OF [=y]
  - PINCTRL_MTK_MOORE [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_STM32_TIMERS
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_STM32 && OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - STM32_ADC_CORE [=m] && IIO [=m] && (ARCH_STM32 || COMPILE_TEST
[=y]) && OF [=y] && REGULATOR [=y]

WARNING: unmet direct dependencies detected for MFD_STMFX
  Depends on [n]: HAS_IOMEM [=n] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - PINCTRL_STMFX [=m] && PINCTRL [=y] && I2C [=m] && OF_GPIO [=y]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
  - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [m]:
  - MFD_HI6421_SPMI [=m] && STAGING [=y] && OF [=y] && SPMI [=m]

WARNING: unmet direct dependencies detected for MVMDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && HAS_IOMEM [=n]
  Selected by [m]:
  - MV643XX_ETH [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (MV64X60 || PPC32 || PLAT_ORION ||
COMPILE_TEST [=y]) && INET [=y]
  - MVNETA [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])
  - MVPP2 [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for MDIO_OCTEON
  Depends on [n]: NETDEVICES [=y] && MDIO_DEVICE [=m] && MDIO_BUS [=m]
&& (64BIT [=y] && OF_MDIO [=m] || COMPILE_TEST [=y]) && HAS_IOMEM [=n]
  Selected by [m]:
  - OCTEON_ETHERNET [=m] && STAGING [=y] && (CAVIUM_OCTEON_SOC ||
COMPILE_TEST [=y]) && NETDEVICES [=y]

WARNING: unmet direct dependencies detected for GPIO_GENERIC
  Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_NPCM7XX [=y] && PINCTRL [=y] && (ARCH_NPCM7XX ||
COMPILE_TEST [=y]) && OF [=y]
arnd@threadripper:~/arm-soc/bisect$ make O=obj-tmp/ ARCH=s390
CROSS_COMPILE=/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-
-skj30

WARNING: unmet direct dependencies detected for MFD_ATMEL_SMC
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_SYSCON
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - BT1_AXI [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - POWER_RESET_OCELOT_RESET [=y] && POWER_RESET [=y] && (MSCC_OCELOT
|| ARCH_SPARX5 || COMPILE_TEST [=y])
  - COMMON_CLK_GEMINI [=y] && COMMON_CLK [=y] && (ARCH_GEMINI ||
COMPILE_TEST [=y])
  - COMMON_CLK_ASPEED [=y] && COMMON_CLK [=y] && (ARCH_ASPEED ||
COMPILE_TEST [=y])
  - COMMON_CLK_OXNAS [=y] && COMMON_CLK [=y] && (ARCH_OXNAS ||
COMPILE_TEST [=y])
  - COMMON_CLK_BOSTON [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - CLK_BT1_CCU_PLL [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - CLK_BT1_CCU_DIV [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - INGENIC_TCU_CLK [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - INGENIC_TIMER [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_SYSOST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_OST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - EXYNOS_CHIPID [=y] && SOC_SAMSUNG [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]
  - BT1_L2_CTL [=y] && MEMORY [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - INGENIC_TCU_IRQ [=y] && (MIPS || COMPILE_TEST [=y])
  Selected by [m]:
  - MTD_NAND_STM32_FMC2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(MACH_STM32MP157 || COMPILE_TEST [=y])
  - MTD_NAND_MESON [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(ARCH_MESON || COMPILE_TEST [=y])
  - ARMADA_37XX_WATCHDOG [=m] && WATCHDOG [=y] && (ARCH_MVEBU ||
COMPILE_TEST [=y])
  - PHY_HI3670_USB [=m] && STAGING [=y] && (ARCH_HISI && ARM64 ||
COMPILE_TEST [=y])
  - HWSPINLOCK_QCOM [=m] && HWSPINLOCK [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
  - ASPEED_LPC_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_LPC_SNOOP [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_P2A_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_XDMA [=m] && (ARCH_ASPEED || COMPILE_TEST [=y]) && HAS_DMA [=y]
  - QCOM_GSBI [=m] && (ARCH_QCOM || COMPILE_TEST [=y])
  - STM32_FMC2_EBI [=m] && MEMORY [=y] && (MACH_STM32MP157 || COMPILE_TEST [=y])
  - PHY_BCM_SR_PCIE [=m] && OF [=y] && (ARCH_BCM_IPROC || COMPILE_TEST [=y])
  - PHY_HI3660_USB [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISTB_COMBPHY [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISI_INNO_USB2 [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_DA8XX_USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_AT91PIO4 [=y] && PINCTRL [=y] && OF [=y] && (ARCH_AT91 ||
COMPILE_TEST [=y])
  - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
[=y]) && OF [=y]
  - PINCTRL_MTK_MOORE [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_STM32_TIMERS
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_STM32 && OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - STM32_ADC_CORE [=m] && IIO [=m] && (ARCH_STM32 || COMPILE_TEST
[=y]) && OF [=y] && REGULATOR [=y]

WARNING: unmet direct dependencies detected for MFD_STMFX
  Depends on [n]: HAS_IOMEM [=n] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - PINCTRL_STMFX [=m] && PINCTRL [=y] && I2C [=m] && OF_GPIO [=y]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
  - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [m]:
  - MFD_HI6421_SPMI [=m] && STAGING [=y] && OF [=y] && SPMI [=m]

WARNING: unmet direct dependencies detected for MVMDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && HAS_IOMEM [=n]
  Selected by [m]:
  - MV643XX_ETH [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (MV64X60 || PPC32 || PLAT_ORION ||
COMPILE_TEST [=y]) && INET [=y]
  - MVNETA [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])
  - MVPP2 [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for MDIO_OCTEON
  Depends on [n]: NETDEVICES [=y] && MDIO_DEVICE [=m] && MDIO_BUS [=m]
&& (64BIT [=y] && OF_MDIO [=m] || COMPILE_TEST [=y]) && HAS_IOMEM [=n]
  Selected by [m]:
  - OCTEON_ETHERNET [=m] && STAGING [=y] && (CAVIUM_OCTEON_SOC ||
COMPILE_TEST [=y]) && NETDEVICES [=y]

WARNING: unmet direct dependencies detected for GPIO_GENERIC
  Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_NPCM7XX [=y] && PINCTRL [=y] && (ARCH_NPCM7XX ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_ATMEL_SMC
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_SYSCON
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - BT1_AXI [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - POWER_RESET_OCELOT_RESET [=y] && POWER_RESET [=y] && (MSCC_OCELOT
|| ARCH_SPARX5 || COMPILE_TEST [=y])
  - COMMON_CLK_GEMINI [=y] && COMMON_CLK [=y] && (ARCH_GEMINI ||
COMPILE_TEST [=y])
  - COMMON_CLK_ASPEED [=y] && COMMON_CLK [=y] && (ARCH_ASPEED ||
COMPILE_TEST [=y])
  - COMMON_CLK_OXNAS [=y] && COMMON_CLK [=y] && (ARCH_OXNAS ||
COMPILE_TEST [=y])
  - COMMON_CLK_BOSTON [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - CLK_BT1_CCU_PLL [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - CLK_BT1_CCU_DIV [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - INGENIC_TCU_CLK [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - INGENIC_TIMER [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_SYSOST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_OST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - EXYNOS_CHIPID [=y] && SOC_SAMSUNG [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]
  - BT1_L2_CTL [=y] && MEMORY [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - INGENIC_TCU_IRQ [=y] && (MIPS || COMPILE_TEST [=y])
  Selected by [m]:
  - MTD_NAND_STM32_FMC2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(MACH_STM32MP157 || COMPILE_TEST [=y])
  - MTD_NAND_MESON [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(ARCH_MESON || COMPILE_TEST [=y])
  - ARMADA_37XX_WATCHDOG [=m] && WATCHDOG [=y] && (ARCH_MVEBU ||
COMPILE_TEST [=y])
  - PHY_HI3670_USB [=m] && STAGING [=y] && (ARCH_HISI && ARM64 ||
COMPILE_TEST [=y])
  - HWSPINLOCK_QCOM [=m] && HWSPINLOCK [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
  - ASPEED_LPC_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_LPC_SNOOP [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_P2A_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_XDMA [=m] && (ARCH_ASPEED || COMPILE_TEST [=y]) && HAS_DMA [=y]
  - QCOM_GSBI [=m] && (ARCH_QCOM || COMPILE_TEST [=y])
  - STM32_FMC2_EBI [=m] && MEMORY [=y] && (MACH_STM32MP157 || COMPILE_TEST [=y])
  - PHY_BCM_SR_PCIE [=m] && OF [=y] && (ARCH_BCM_IPROC || COMPILE_TEST [=y])
  - PHY_HI3660_USB [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISTB_COMBPHY [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISI_INNO_USB2 [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_DA8XX_USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_AT91PIO4 [=y] && PINCTRL [=y] && OF [=y] && (ARCH_AT91 ||
COMPILE_TEST [=y])
  - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
[=y]) && OF [=y]
  - PINCTRL_MTK_MOORE [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_STM32_TIMERS
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_STM32 && OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - STM32_ADC_CORE [=m] && IIO [=m] && (ARCH_STM32 || COMPILE_TEST
[=y]) && OF [=y] && REGULATOR [=y]

WARNING: unmet direct dependencies detected for MFD_STMFX
  Depends on [n]: HAS_IOMEM [=n] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - PINCTRL_STMFX [=m] && PINCTRL [=y] && I2C [=m] && OF_GPIO [=y]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
  - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [m]:
  - MFD_HI6421_SPMI [=m] && STAGING [=y] && OF [=y] && SPMI [=m]

WARNING: unmet direct dependencies detected for MVMDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && HAS_IOMEM [=n]
  Selected by [m]:
  - MV643XX_ETH [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (MV64X60 || PPC32 || PLAT_ORION ||
COMPILE_TEST [=y]) && INET [=y]
  - MVNETA [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])
  - MVPP2 [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for MDIO_OCTEON
  Depends on [n]: NETDEVICES [=y] && MDIO_DEVICE [=m] && MDIO_BUS [=m]
&& (64BIT [=y] && OF_MDIO [=m] || COMPILE_TEST [=y]) && HAS_IOMEM [=n]
  Selected by [m]:
  - OCTEON_ETHERNET [=m] && STAGING [=y] && (CAVIUM_OCTEON_SOC ||
COMPILE_TEST [=y]) && NETDEVICES [=y]

WARNING: unmet direct dependencies detected for GPIO_GENERIC
  Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_NPCM7XX [=y] && PINCTRL [=y] && (ARCH_NPCM7XX ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_ATMEL_SMC
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_SYSCON
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [y]:
  - BT1_AXI [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - POWER_RESET_OCELOT_RESET [=y] && POWER_RESET [=y] && (MSCC_OCELOT
|| ARCH_SPARX5 || COMPILE_TEST [=y])
  - COMMON_CLK_GEMINI [=y] && COMMON_CLK [=y] && (ARCH_GEMINI ||
COMPILE_TEST [=y])
  - COMMON_CLK_ASPEED [=y] && COMMON_CLK [=y] && (ARCH_ASPEED ||
COMPILE_TEST [=y])
  - COMMON_CLK_OXNAS [=y] && COMMON_CLK [=y] && (ARCH_OXNAS ||
COMPILE_TEST [=y])
  - COMMON_CLK_BOSTON [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - CLK_BT1_CCU_PLL [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - CLK_BT1_CCU_DIV [=y] && COMMON_CLK [=y] && CLK_BAIKAL_T1 [=y]
  - INGENIC_TCU_CLK [=y] && COMMON_CLK [=y] && (MIPS || COMPILE_TEST [=y])
  - INGENIC_TIMER [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_SYSOST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - INGENIC_OST [=y] && GENERIC_CLOCKEVENTS [=y] && (MIPS ||
COMPILE_TEST [=y]) && COMMON_CLK [=y]
  - EXYNOS_CHIPID [=y] && SOC_SAMSUNG [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])
  - ATMEL_EBI [=y] && MEMORY [=y] && (ARCH_AT91 || COMPILE_TEST [=y]) && OF [=y]
  - BT1_L2_CTL [=y] && MEMORY [=y] && (MIPS_BAIKAL_T1 || COMPILE_TEST [=y])
  - INGENIC_TCU_IRQ [=y] && (MIPS || COMPILE_TEST [=y])
  Selected by [m]:
  - MTD_NAND_STM32_FMC2 [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(MACH_STM32MP157 || COMPILE_TEST [=y])
  - MTD_NAND_MESON [=m] && MTD [=m] && MTD_RAW_NAND [=m] &&
(ARCH_MESON || COMPILE_TEST [=y])
  - ARMADA_37XX_WATCHDOG [=m] && WATCHDOG [=y] && (ARCH_MVEBU ||
COMPILE_TEST [=y])
  - PHY_HI3670_USB [=m] && STAGING [=y] && (ARCH_HISI && ARM64 ||
COMPILE_TEST [=y])
  - HWSPINLOCK_QCOM [=m] && HWSPINLOCK [=y] && (ARCH_QCOM || COMPILE_TEST [=y])
  - ASPEED_LPC_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_LPC_SNOOP [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_P2A_CTRL [=m] && (ARCH_ASPEED || COMPILE_TEST [=y])
  - ASPEED_XDMA [=m] && (ARCH_ASPEED || COMPILE_TEST [=y]) && HAS_DMA [=y]
  - QCOM_GSBI [=m] && (ARCH_QCOM || COMPILE_TEST [=y])
  - STM32_FMC2_EBI [=m] && MEMORY [=y] && (MACH_STM32MP157 || COMPILE_TEST [=y])
  - PHY_BCM_SR_PCIE [=m] && OF [=y] && (ARCH_BCM_IPROC || COMPILE_TEST [=y])
  - PHY_HI3660_USB [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISTB_COMBPHY [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_HISI_INNO_USB2 [=m] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
  - PHY_DA8XX_USB [=m] && (ARCH_DAVINCI_DA8XX || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_AT91PIO4 [=y] && PINCTRL [=y] && OF [=y] && (ARCH_AT91 ||
COMPILE_TEST [=y])
  - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
[=y]) && OF [=y]
  - PINCTRL_MTK_MOORE [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]
  - PINCTRL_MTK_PARIS [=y] && PINCTRL [=y] && (ARCH_MEDIATEK ||
COMPILE_TEST [=y]) && OF [=y]

WARNING: unmet direct dependencies detected for MFD_STM32_TIMERS
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_STM32 && OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - STM32_ADC_CORE [=m] && IIO [=m] && (ARCH_STM32 || COMPILE_TEST
[=y]) && OF [=y] && REGULATOR [=y]

WARNING: unmet direct dependencies detected for MFD_STMFX
  Depends on [n]: HAS_IOMEM [=n] && I2C [=m] && (OF [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - PINCTRL_STMFX [=m] && PINCTRL [=y] && I2C [=m] && OF_GPIO [=y]

WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
  Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
  Selected by [y]:
  - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
  - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

WARNING: unmet direct dependencies detected for MFD_CORE
  Depends on [n]: HAS_IOMEM [=n]
  Selected by [m]:
  - MFD_HI6421_SPMI [=m] && STAGING [=y] && OF [=y] && SPMI [=m]

WARNING: unmet direct dependencies detected for MVMDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && HAS_IOMEM [=n]
  Selected by [m]:
  - MV643XX_ETH [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (MV64X60 || PPC32 || PLAT_ORION ||
COMPILE_TEST [=y]) && INET [=y]
  - MVNETA [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])
  - MVPP2 [=m] && NETDEVICES [=y] && ETHERNET [=y] &&
NET_VENDOR_MARVELL [=y] && (ARCH_MVEBU || COMPILE_TEST [=y])

WARNING: unmet direct dependencies detected for MDIO_OCTEON
  Depends on [n]: NETDEVICES [=y] && MDIO_DEVICE [=m] && MDIO_BUS [=m]
&& (64BIT [=y] && OF_MDIO [=m] || COMPILE_TEST [=y]) && HAS_IOMEM [=n]
  Selected by [m]:
  - OCTEON_ETHERNET [=m] && STAGING [=y] && (CAVIUM_OCTEON_SOC ||
COMPILE_TEST [=y]) && NETDEVICES [=y]

WARNING: unmet direct dependencies detected for GPIO_GENERIC
  Depends on [n]: GPIOLIB [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - PINCTRL_NPCM7XX [=y] && PINCTRL [=y] && (ARCH_NPCM7XX ||
COMPILE_TEST [=y]) && OF [=y]
../drivers/input/joystick/analog.c:160:2: warning: #warning Precise
timer not defined for this architecture. [-Wcpp]
  160 | #warning Precise timer not defined for this architecture.
      |  ^~~~~~~
In file included from ../drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:42:
../drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: In function
'mvpp2_setup_bm_pool':
../drivers/net/ethernet/marvell/mvpp2/mvpp2.h:760:2: warning: overflow
in conversion from 'long unsigned int' to 'int' changes value from
'18446744073709551584' to '-32' [-Woverflow]
  760 |  ((total_size) - MVPP2_SKB_HEADROOM - MVPP2_SKB_SHINFO_SIZE)
      |  ^
../drivers/net/ethernet/marvell/mvpp2/mvpp2.h:864:33: note: in
expansion of macro 'MVPP2_RX_MAX_PKT_SIZE'
  864 | #define MVPP2_BM_SHORT_PKT_SIZE
MVPP2_RX_MAX_PKT_SIZE(MVPP2_BM_SHORT_FRAME_SIZE)
      |                                 ^~~~~~~~~~~~~~~~~~~~~
../drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:647:41: note: in
expansion of macro 'MVPP2_BM_SHORT_PKT_SIZE'
  647 |  mvpp2_pools[MVPP2_BM_SHORT].pkt_size = MVPP2_BM_SHORT_PKT_SIZE;
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~
../kernel/bpf/btf.c:4481:20: warning: 'btf_parse_module' defined but
not used [-Wunused-function]
 4481 | static struct btf *btf_parse_module(const char *module_name,
const void *data, unsigned int data_size)
      |                    ^~~~~~~~~~~~~~~~
../lib/test_kasan.c: In function 'kasan_alloca_oob_right':
../lib/test_kasan.c:531:1: warning: 'kasan_alloca_oob_right' uses
dynamic stack allocation
  531 | }
      | ^
../lib/test_kasan.c: In function 'kasan_alloca_oob_left':
../lib/test_kasan.c:511:1: warning: 'kasan_alloca_oob_left' uses
dynamic stack allocation
  511 | }
      | ^
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
kernel/dma/coherent.o: in function `dma_init_coherent_memory':
coherent.c:(.text+0x39c): undefined reference to `memremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
coherent.c:(.text+0x4ca): undefined reference to `memunmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
coherent.c:(.text+0x7e6): undefined reference to `memunmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
irq-al-fic.c:(.init.text+0x6c): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
irq-al-fic.c:(.init.text+0x180): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/exynos-combiner.o: in function `combiner_of_init':
exynos-combiner.c:(.init.text+0x208): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-jcore-aic.o: in function `aic_irq_of_init':
irq-jcore-aic.c:(.init.text+0x72): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
irq-jcore-aic.c:(.init.text+0xb8): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-renesas-intc-irqpin.o: in function
`intc_irqpin_probe':
irq-renesas-intc-irqpin.c:(.text+0x1242): undefined reference to `devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-renesas-irqc.o: in function `irqc_probe':
irq-renesas-irqc.c:(.text+0x4ec): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-renesas-rza1.o: in function `rza1_irqc_probe':
irq-renesas-rza1.c:(.text+0xa06): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-renesas-h8s.o: in function `h8s_intc_of_init':
irq-renesas-h8s.c:(.init.text+0x80): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
irq-renesas-h8s.c:(.init.text+0x94): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-uniphier-aidet.o: in function
`uniphier_aidet_probe':
irq-uniphier-aidet.c:(.text+0x3d8): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-imx-irqsteer.o: in function `imx_irqsteer_probe':
irq-imx-irqsteer.c:(.text+0x43e): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
irq-imx-intmux.c:(.text+0x6e8): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-loongson-pch-pic.o: in function `pch_pic_of_init':
irq-loongson-pch-pic.c:(.text+0x5be): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
irq-loongson-pch-pic.c:(.text+0x77e): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/irqchip/irq-mst-intc.o: in function `mst_intc_of_init':
irq-mst-intc.c:(.init.text+0x1b6): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
irq-mst-intc.c:(.init.text+0x2d8): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/bus/bt1-apb.o: in function `bt1_apb_request_regs':
bt1-apb.c:(.text+0xa8): undefined reference to
`devm_platform_ioremap_resource_byname'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
bt1-apb.c:(.text+0x1a4): undefined reference to
`devm_platform_ioremap_resource_byname'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/bus/bt1-axi.o: in function `bt1_axi_probe':
bt1-axi.c:(.text+0x83a): undefined reference to
`devm_platform_ioremap_resource_byname'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/phy/samsung/phy-exynos-pcie.o: in function
`exynos_pcie_phy_probe':
phy-exynos-pcie.c:(.text+0x77e): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
phy-exynos-pcie.c:(.text+0x7d6): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/pinctrl-at91-pio4.o: in function
`atmel_pinctrl_probe':
pinctrl-at91-pio4.c:(.text+0x1d8c): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/pinctrl-bm1880.o: in function `bm1880_pinctrl_probe':
pinctrl-bm1880.c:(.text+0x10f4): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/pinctrl-lpc18xx.o: in function `lpc18xx_scu_probe':
pinctrl-lpc18xx.c:(.text+0x17f4): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/pinctrl-ingenic.o: in function
`ingenic_pinctrl_probe':
pinctrl-ingenic.c:(.init.text+0x566): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/actions/pinctrl-owl.o: in function
`owl_pinctrl_probe':
pinctrl-owl.c:(.text+0x3538): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-bcm281xx.o:pinctrl-bcm281xx.c:(.init.text+0x74):
more undefined references to `devm_platform_ioremap_resource' follow
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-bcm2835.o: in function
`bcm2835_pinctrl_probe':
pinctrl-bcm2835.c:(.text+0x1358): undefined reference to
`of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-bcm2835.c:(.text+0x13a6): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-iproc-gpio.o: in function
`iproc_gpio_probe':
pinctrl-iproc-gpio.c:(.text+0xc4e): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-iproc-gpio.c:(.text+0xce4): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-cygnus-mux.o: in function
`cygnus_pinmux_probe':
pinctrl-cygnus-mux.c:(.text+0xd0a): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-cygnus-mux.c:(.text+0xd7a): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-nsp-gpio.o: in function `nsp_gpio_probe':
pinctrl-nsp-gpio.c:(.text+0x9a0): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-nsp-gpio.c:(.text+0xa1a): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-ns2-mux.o: in function `ns2_pinmux_probe':
pinctrl-ns2-mux.c:(.text+0x1898): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-ns2-mux.c:(.text+0x1932): undefined reference to
`devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-ns2-mux.c:(.text+0x1982): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/bcm/pinctrl-nsp-mux.o: in function `nsp_pinmux_probe':
pinctrl-nsp-mux.c:(.text+0xd86): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-nsp-mux.c:(.text+0xe18): undefined reference to `devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-nsp-mux.c:(.text+0xe68): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/berlin/berlin-bg4ct.o: in function
`berlin4ct_pinctrl_probe':
berlin-bg4ct.c:(.text+0x7e): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/berlin/pinctrl-as370.o: in function
`as370_pinctrl_probe':
pinctrl-as370.c:(.text+0x7e): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/renesas/core.o: in function `sh_pfc_map_resources':
core.c:(.text+0x72c): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/renesas/pinctrl-rza1.o: in function
`rza1_pinctrl_probe':
pinctrl-rza1.c:(.text+0xf44): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/renesas/pinctrl-rza2.o: in function
`rza2_pinctrl_probe':
pinctrl-rza2.c:(.text+0xcc4): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/renesas/pinctrl-rzn1.o: in function
`rzn1_pinctrl_probe':
pinctrl-rzn1.c:(.text+0x1a08): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
pinctrl-rzn1.c:(.text+0x1a82): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/samsung/pinctrl-samsung.o: in function
`samsung_pinctrl_get_soc_data':
pinctrl-samsung.c:(.text+0x348): undefined reference to `devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/samsung/pinctrl-exynos-arm.o: in function
`s5pv210_retention_init':
pinctrl-exynos-arm.c:(.text+0x11e): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/mediatek/pinctrl-mtk-common.o: in function
`mtk_eint_init':
pinctrl-mtk-common.c:(.text+0x18ea): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.o: in function
`mtk_build_eint':
(.text+0x19b0): undefined reference to `devm_platform_ioremap_resource_byname'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/mediatek/pinctrl-moore.o: in function
`mtk_moore_pinctrl_probe':
pinctrl-moore.c:(.text+0x1b98): undefined reference to
`devm_platform_ioremap_resource_byname'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/mediatek/pinctrl-paris.o: in function
`mtk_paris_pinctrl_probe':
(.text+0x14fe): undefined reference to `devm_platform_ioremap_resource_byname'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/pinctrl/visconti/pinctrl-common.o: in function
`visconti_pinctrl_probe':
pinctrl-common.c:(.text+0xcd6): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/gpio/gpiolib-of.o: in function `of_mm_gpiochip_add_data':
(.text+0x892): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
(.text+0x952): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/gpio/gpiolib-of.o: in function `of_mm_gpiochip_remove':
(.text+0xa10): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-bm1880.o: in function `bm1880_clk_probe':
clk-bm1880.c:(.text+0xf90): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-bm1880.c:(.text+0xfe2): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-fixed-mmio.o: in function `fixed_mmio_clk_setup':
clk-fixed-mmio.c:(.text+0x9a): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-fixed-mmio.c:(.text+0xe6): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-fsl-sai.o: in function `fsl_sai_clk_probe':
clk-fsl-sai.c:(.text+0xc0): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-gemini.o: in function `gemini_clk_probe':
clk-gemini.c:(.text+0x8e0): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-aspeed.o: in function `aspeed_cc_init':
clk-aspeed.c:(.init.text+0x794): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-qoriq.o: in function `_clockgen_init':
clk-qoriq.c:(.init.text+0x1942): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-qoriq.c:(.init.text+0x19b2): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-qoriq.c:(.init.text+0x1aec): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-qoriq.c:(.init.text+0x1c94): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-qoriq.o: in function `core_mux_init':
clk-qoriq.c:(.init.text+0x1e92): undefined reference to `of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-qoriq.o: in function `core_pll_init':
clk-qoriq.c:(.init.text+0x22b8): undefined reference to `of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-xgene.o: in function `xgene_pllclk_init':
clk-xgene.c:(.text+0x140c): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-xgene.o: in function `xgene_pmdclk_init':
clk-xgene.c:(.text+0x18d0): undefined reference to `of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-xgene.c:(.text+0x1916): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-xgene.c:(.text+0x1a0e): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/clk-xgene.o: in function `xgene_devclk_init':
clk-xgene.c:(.init.text+0x108): undefined reference to `of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-xgene.c:(.init.text+0x16a): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-xgene.c:(.init.text+0x532): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-xgene.c:(.init.text+0x552): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/actions/owl-common.o: in function `owl_clk_regmap_init':
owl-common.c:(.text+0x4a): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-bcm63xx-gate.o: in function `clk_bcm63xx_probe':
clk-bcm63xx-gate.c:(.text+0x280): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-kona-setup.o: in function `kona_dt_ccu_setup':
clk-kona-setup.c:(.init.text+0x9e): undefined reference to
`of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-kona-setup.c:(.init.text+0x1ae): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-kona-setup.c:(.init.text+0xad6): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-iproc-armpll.o: in function `iproc_armpll_setup':
clk-iproc-armpll.c:(.init.text+0xe2): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-armpll.c:(.init.text+0x232): undefined reference to
`iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-iproc-pll.o: in function `iproc_pll_clk_setup':
clk-iproc-pll.c:(.text+0x3334): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x33aa): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x37fe): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x3828): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x3854): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x3872): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x3a8a): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-pll.c:(.text+0x3aec): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-iproc-asiu.o: in function `iproc_asiu_setup':
clk-iproc-asiu.c:(.init.text+0x1a8): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-asiu.c:(.init.text+0x1e8): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-asiu.c:(.init.text+0x57c): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-iproc-asiu.c:(.init.text+0x598): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-bcm2835.o: in function `bcm2835_pll_debug_init':
clk-bcm2835.c:(.text+0x1b4a): undefined reference to `debugfs_create_regset32'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-bcm2835.o: in function `bcm2835_clk_probe':
clk-bcm2835.c:(.text+0x1f2c): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-bcm2835.o: in function `bcm2835_clock_debug_init':
clk-bcm2835.c:(.text+0x2502): undefined reference to `debugfs_create_regset32'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-bcm2835.o: in function
`bcm2835_pll_divider_debug_init':
clk-bcm2835.c:(.text+0x2d02): undefined reference to `debugfs_create_regset32'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/bcm/clk-bcm2835-aux.o: in function
`bcm2835_aux_clk_probe':
clk-bcm2835-aux.c:(.text+0x78): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/ingenic/cgu.o: in function `ingenic_cgu_new':
cgu.c:(.text+0x2c4c): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-pll.o: in function `mtk_clk_register_plls':
clk-pll.c:(.text+0x1242): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt6765.o: in function `clk_mt6765_ifr_probe':
clk-mt6765.c:(.text+0x52): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt6765.o: in function `clk_mt6765_top_probe':
clk-mt6765.c:(.text+0x172): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt6765.o: in function
`clk_mt6765_apmixed_probe':
clk-mt6765.c:(.text+0x332): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt6779.o: in function `clk_mt6779_top_probe':
clk-mt6779.c:(.text+0xc0): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt6797.o: in function `mtk_topckgen_init':
clk-mt6797.c:(.text+0x200): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt2701.o: in function `mtk_pericfg_init':
clk-mt2701.c:(.text+0x272): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt2701.o: in function `mtk_topckgen_init':
clk-mt2701.c:(.text+0x392): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt2712.o: in function `clk_mt2712_mcu_probe':
clk-mt2712.c:(.text+0x40): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt2712.o: in function `clk_mt2712_top_probe':
clk-mt2712.c:(.text+0x320): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt7622.o: in function `mtk_pericfg_init':
clk-mt7622.c:(.text+0x220): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt7622.o: in function `mtk_topckgen_init':
clk-mt7622.c:(.text+0x580): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt7629.o: in function `mtk_pericfg_init':
clk-mt7629.c:(.text+0x1e0): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt7629.o:clk-mt7629.c:(.text+0x520): more
undefined references to `devm_platform_ioremap_resource' follow
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8135.o: in function `mtk_pericfg_init':
clk-mt8135.c:(.init.text+0x30): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8135.o: in function `mtk_topckgen_init':
clk-mt8135.c:(.init.text+0x280): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8167.o: in function `mtk_topckgen_init':
clk-mt8167.c:(.init.text+0x30): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8167.o: in function `mtk_infracfg_init':
clk-mt8167.c:(.init.text+0x168): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8167.o: in function `mtk_apmixedsys_init':
clk-mt8167.c:(.init.text+0x248): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8173.o:clk-mt8173.c:(.init.text+0x390):
more undefined references to `of_iomap' follow
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8173.o: in function `mtk_apmixedsys_init':
clk-mt8173.c:(.init.text+0x76e): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8183.o: in function `clk_mt8183_mcu_probe':
clk-mt8183.c:(.text+0x40): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8183.o: in function `clk_mt8183_top_probe':
clk-mt8183.c:(.text+0x280): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8516.o: in function `mtk_topckgen_init':
clk-mt8516.c:(.init.text+0x30): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8516.o: in function `mtk_infracfg_init':
clk-mt8516.c:(.init.text+0x168): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/mediatek/clk-mt8516.o: in function `mtk_apmixedsys_init':
clk-mt8516.c:(.init.text+0x248): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-emev2.o: in function `emev2_smu_init':
clk-emev2.c:(.init.text+0xc8): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-rz.o: in function `rz_cpg_clocks_init':
clk-rz.c:(.init.text+0x122): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-rz.c:(.init.text+0x1e2): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-rz.c:(.init.text+0x1f6): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-rz.c:(.init.text+0x256): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-rz.c:(.init.text+0x264): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-r8a73a4.o: in function
`r8a73a4_cpg_clocks_init':
clk-r8a73a4.c:(.init.text+0x746): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-r8a7740.o: in function
`r8a7740_cpg_clocks_init':
clk-r8a7740.c:(.init.text+0x67a): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-r8a7778.o: in function
`r8a7778_cpg_clocks_init':
clk-r8a7778.c:(.init.text+0x488): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/r9a06g032-clocks.o: in function
`r9a06g032_clocks_probe':
r9a06g032-clocks.c:(.init.text+0x1e8): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-sh73a0.o: in function
`sh73a0_cpg_clocks_init':
clk-sh73a0.c:(.init.text+0x68e): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/rcar-usb2-clock-sel.o: in function
`rcar_usb2_clock_sel_probe':
rcar-usb2-clock-sel.c:(.text+0x60a): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/renesas-cpg-mssr.o: in function
`cpg_mssr_common_init':
renesas-cpg-mssr.c:(.init.text+0xa80): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
renesas-cpg-mssr.c:(.init.text+0xd06): undefined reference to
`iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-mstp.o: in function `cpg_mstp_clocks_init':
clk-mstp.c:(.init.text+0x322): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-mstp.c:(.init.text+0x344): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/renesas/clk-div6.o: in function `cpg_div6_clock_init':
clk-div6.c:(.init.text+0x49c): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
clk-div6.c:(.init.text+0x5ba): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk.o: in function `samsung_cmu_register_one':
clk.c:(.init.text+0x108c): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk-exynos5433.o: in function
`exynos5433_cmu_apollo_init':
clk-exynos5433.c:(.init.text+0x230): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk-exynos5433.o: in function
`exynos5433_cmu_atlas_init':
clk-exynos5433.c:(.init.text+0x390): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk-exynos5433.o: in function
`exynos5433_cmu_probe':
clk-exynos5433.c:(.init.text+0x59c): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk-s3c2410.o: in function
`s3c2410_common_clk_init':
clk-s3c2410.c:(.init.text+0xae): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk-s3c2412.o: in function
`s3c2412_common_clk_init':
clk-s3c2412.c:(.init.text+0xae): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/samsung/clk-s3c2443.o: in function
`s3c2443_common_clk_init':
clk-s3c2443.c:(.init.text+0x50): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sifive/fu540-prci.o: in function
`sifive_fu540_prci_probe':
fu540-prci.c:(.text+0x646): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun50i-a64.o: in function
`sun50i_a64_ccu_probe':
ccu-sun50i-a64.c:(.text+0x42): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun50i-a100.o: in function
`sun50i_a100_ccu_probe':
ccu-sun50i-a100.c:(.text+0x30): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun50i-a100-r.o: in function
`sun50i_a100_r_ccu_probe':
ccu-sun50i-a100-r.c:(.text+0x30): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun50i-h6.o: in function
`sun50i_h6_ccu_probe':
ccu-sun50i-h6.c:(.text+0x42): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun8i-a83t.o: in function
`sun8i_a83t_ccu_probe':
ccu-sun8i-a83t.c:(.text+0x42): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun8i-de2.o: in function
`sunxi_de2_clk_probe':
ccu-sun8i-de2.c:(.text+0x64): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun8i-r40.o: in function
`sun8i_r40_ccu_probe':
ccu-sun8i-r40.c:(.text+0xa6): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun9i-a80.o: in function
`sun9i_a80_ccu_probe':
ccu-sun9i-a80.c:(.text+0x42): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/sunxi-ng/ccu-sun9i-a80-de.o:ccu-sun9i-a80-de.c:(.text+0x46):
more undefined references to `devm_ioremap_resource' follow
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/versatile/clk-versatile.o: in function `cm_osc_setup':
clk-versatile.c:(.init.text+0x88): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clk/versatile/clk-sp810.o: in function `clk_sp810_of_setup':
clk-sp810.c:(.init.text+0x148): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/coh901318.o: in function `coh901318_probe':
coh901318.c:(.init.text+0x1da): undefined reference to `devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/mmp_pdma.o: in function `mmp_pdma_probe':
mmp_pdma.c:(.text+0x32fc): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/mmp_tdma.o: in function `mmp_tdma_probe':
mmp_tdma.c:(.text+0x154a): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/mv_xor.o: in function `mv_xor_probe':
mv_xor.c:(.text.unlikely+0x1fec): undefined reference to `devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
mv_xor.c:(.text.unlikely+0x2074): undefined reference to
`devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/mxs-dma.o: in function `mxs_dma_probe':
mxs-dma.c:(.init.text+0x1d2): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/stm32-dma.o: in function `stm32_dma_probe':
stm32-dma.c:(.text+0x152a): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/stm32-dmamux.o: in function `stm32_dmamux_probe':
stm32-dmamux.c:(.text+0xa0e): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/stm32-mdma.o: in function `stm32_mdma_probe':
stm32-mdma.c:(.text+0x2636): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/s3c24xx-dma.o: in function `s3c24xx_dma_probe':
s3c24xx-dma.c:(.text+0x298c): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/ti/dma-crossbar.o: in function `ti_am335x_xbar_probe':
dma-crossbar.c:(.text+0x34e): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/dma/ti/dma-crossbar.o: in function `ti_dra7_xbar_probe':
dma-crossbar.c:(.text+0x1318): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/aspeed/aspeed-socinfo.o: in function
`aspeed_socinfo_init':
aspeed-socinfo.c:(.init.text+0xe6): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
aspeed-socinfo.c:(.init.text+0x118): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
aspeed-socinfo.c:(.init.text+0x126): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
aspeed-socinfo.c:(.init.text+0x166): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/bcm/bcm63xx/bcm63xx-power.o: in function
`bcm63xx_power_probe':
bcm63xx-power.c:(.text+0x156): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/bcm/brcmstb/common.o: in function
`brcmstb_soc_device_early_init':
common.c:(.init.text+0x4e): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
common.c:(.init.text+0x9a): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/bcm/brcmstb/biuctrl.o: in function
`setup_hifcpubiuctrl_regs':
biuctrl.c:(.init.text+0x30): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/imx/soc-imx8m.o: in function `imx8mq_soc_revision':
soc-imx8m.c:(.init.text+0x4e): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
soc-imx8m.c:(.init.text+0xde): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/imx/soc-imx8m.o: in function `imx8mm_soc_uid':
soc-imx8m.c:(.init.text+0x190): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
soc-imx8m.c:(.init.text+0x200): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/imx/soc-imx8m.o: in function `imx8mm_soc_revision':
soc-imx8m.c:(.init.text+0x26e): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
soc-imx8m.c:(.init.text+0x29e): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/mediatek/mtk-scpsys.o: in function `init_scp':
mtk-scpsys.c:(.text+0x6cc): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/mediatek/mtk-mmsys.o: in function `mtk_mmsys_probe':
mtk-mmsys.c:(.text+0xec0): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/renesas/renesas-soc.o: in function `renesas_soc_init':
renesas-soc.c:(.init.text+0x9e): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
renesas-soc.c:(.init.text+0xda): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
renesas-soc.c:(.init.text+0x17a): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
renesas-soc.c:(.init.text+0x1f8): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
renesas-soc.c:(.init.text+0x232): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/renesas/r8a779a0-sysc.o: in function
`r8a779a0_sysc_pd_init':
r8a779a0-sysc.c:(.init.text+0x3f0): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/renesas/rcar-rst.o: in function `rcar_rst_init':
rcar-rst.c:(.init.text+0xa2): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/renesas/rcar-sysc.o: in function `rcar_sysc_pd_init':
rcar-sysc.c:(.init.text+0x492): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/renesas/rmobile-sysc.o: in function
`rmobile_init_pm_domains':
rmobile-sysc.c:(.init.text+0x8c2): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
rmobile-sysc.c:(.init.text+0x91a): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/soc/samsung/pm_domains.o: in function
`exynos4_pm_init_power_domain':
pm_domains.c:(.init.text+0x206): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/regulator/stm32-pwr.o: in function
`stm32_pwr_regulator_probe':
stm32-pwr.c:(.text+0x128): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-ath79.o: in function `ath79_reset_probe':
reset-ath79.c:(.text+0x196): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-axs10x.o: in function `axs10x_reset_probe':
reset-axs10x.c:(.text+0x106): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-lpc18xx.o: in function `lpc18xx_rgu_probe':
reset-lpc18xx.c:(.text+0x366): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-npcm.o: in function `npcm_rc_probe':
reset-npcm.c:(.text+0x834): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-simple.o: in function `reset_simple_probe':
reset-simple.c:(.text+0x3d8): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-stm32mp1.o: in function `stm32_reset_probe':
reset-stm32mp1.c:(.text+0x1ea): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-socfpga.o: in function `a10_reset_init.isra.0':
reset-socfpga.c:(.text.unlikely+0xd6): undefined reference to
`of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
reset-socfpga.c:(.text.unlikely+0x154): undefined reference to
`ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/reset/reset-sunxi.o: in function `sunxi_reset_init.isra.0':
reset-sunxi.c:(.text.unlikely+0xbc): undefined reference to
`of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
reset-sunxi.c:(.text.unlikely+0x136): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/iommu/ipmmu-vmsa.o: in function `ipmmu_probe':
ipmmu-vmsa.c:(.text+0x8ba): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/iommu/mtk_iommu.o: in function `mtk_iommu_probe':
mtk_iommu.c:(.text+0x156a): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/iommu/omap-iommu.o: in function `omap_iommu_probe':
omap-iommu.c:(.text+0x1288): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/iommu/rockchip-iommu.o: in function `rk_iommu_probe':
rockchip-iommu.c:(.text+0xd62): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/iommu/sun50i-iommu.o: in function `sun50i_iommu_probe':
sun50i-iommu.c:(.text+0x9de): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/mfd/sun6i-prcm.o: in function `sun6i_prcm_probe':
sun6i-prcm.c:(.text+0xde): undefined reference to `mfd_add_devices'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/mfd/syscon.o: in function `syscon_probe':
syscon.c:(.text+0x150): undefined reference to `devm_ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/mfd/syscon.o: in function `of_syscon_register':
syscon.c:(.text+0x3da): undefined reference to `of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
syscon.c:(.text+0x41c): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
syscon.c:(.text+0x80e): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/power/reset/brcm-kona-reset.o: in function `kona_reset_probe':
brcm-kona-reset.c:(.text+0xc2): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/power/reset/ocelot-reset.o: in function `ocelot_reset_probe':
ocelot-reset.c:(.text+0x66): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/watchdog/rtd119x_wdt.o: in function `rtd119x_wdt_probe':
rtd119x_wdt.c:(.text+0x2d8): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-of.o: in function `timer_of_init':
timer-of.c:(.init.text+0x5e6): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
timer-of.c:(.init.text+0x802): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
timer-of.c:(.init.text+0x95e): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-davinci.o: in function
`davinci_timer_register':
timer-davinci.c:(.init.text+0xe0): undefined reference to `ioremap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-davinci.o: in function
`of_davinci_timer_register':
timer-davinci.c:(.init.text+0x5bc): undefined reference to
`of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/bcm2835_timer.o: in function `bcm2835_timer_init':
bcm2835_timer.c:(.init.text+0x84): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
bcm2835_timer.c:(.init.text+0x300): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/clps711x-timer.o: in function
`clps711x_timer_init':
clps711x-timer.c:(.init.text+0x19c): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-atlas7.o: in function
`sirfsoc_of_timer_init':
timer-atlas7.c:(.init.text+0x248): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/mxs_timer.o: in function `mxs_timer_init':
mxs_timer.c:(.init.text+0x30): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-prima2.o: in function
`sirfsoc_prima2_timer_init':
timer-prima2.c:(.init.text+0x158): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-zevio.o: in function `zevio_timer_add':
timer-zevio.c:(.init.text+0xc0): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
timer-zevio.c:(.init.text+0x186): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
timer-zevio.c:(.init.text+0x1a6): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
timer-zevio.c:(.init.text+0x1de): undefined reference to
`of_address_to_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/bcm_kona_timer.o: in function `kona_timer_init':
bcm_kona_timer.c:(.init.text+0x1aa): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-cadence-ttc.o: in function
`ttc_timer_probe':
timer-cadence-ttc.c:(.init.text+0x676): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-oxnas-rps.o: in function
`oxnas_rps_timer_init':
timer-oxnas-rps.c:(.init.text+0x5ea): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
timer-oxnas-rps.c:(.init.text+0x668): undefined reference to
`of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/armv7m_systick.o: in function
`system_timer_of_register':
armv7m_systick.c:(.init.text+0x84): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
armv7m_systick.c:(.init.text+0x270): undefined reference to `iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/ingenic-ost.o: in function `ingenic_ost_probe':
ingenic-ost.c:(.init.text+0xb2): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/clocksource/timer-microchip-pit64b.o: in function
`mchp_pit64b_dt_init_timer':
timer-microchip-pit64b.c:(.init.text+0x7d0): undefined reference to `of_iomap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
timer-microchip-pit64b.c:(.init.text+0xb46): undefined reference to
`iounmap'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/mailbox/rockchip-mailbox.o: in function `rockchip_mbox_probe':
rockchip-mailbox.c:(.text+0xa52): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/mailbox/qcom-ipcc.o: in function `qcom_ipcc_probe':
qcom-ipcc.c:(.text+0x68c): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/memory/brcmstb_dpfe.o: in function `brcmstb_dpfe_probe':
brcmstb_dpfe.c:(.text+0x17be): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
brcmstb_dpfe.c:(.text+0x1832): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
brcmstb_dpfe.c:(.text+0x18a6): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/memory/mvebu-devbus.o: in function `mvebu_devbus_probe':
mvebu-devbus.c:(.text+0x876): undefined reference to
`devm_platform_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/memory/mtk-smi.o: in function `mtk_smi_larb_probe':
mtk-smi.c:(.text+0x6e8): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/memory/mtk-smi.o: in function `mtk_smi_common_probe':
mtk-smi.c:(.text+0xb8e): undefined reference to `devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
mtk-smi.c:(.text+0xc9e): undefined reference to
`devm_ioremap_resource'
/home/arnd/cross/x86_64/gcc-10.1.0-nolibc/s390-linux/bin/s390-linux-ld:
drivers/memory/da8xx-ddrctl.o: in function `da8xx_ddrctl_probe':
