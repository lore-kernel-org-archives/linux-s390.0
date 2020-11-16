Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: irq-loongson-pch-pic.c:undefined reference to `of_iomap'
References: <202011140757.5QyVghe2-lkp@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4f6f2244-033c-8413-818d-0b9c1b0b33ae@infradead.org>
Date: Sun, 15 Nov 2020 20:33:50 -0800
MIME-Version: 1.0
In-Reply-To: <202011140757.5QyVghe2-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: kernel test robot <lkp@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>

On 11/13/20 3:27 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9e6a39eae450b81c8b2c8cbbfbdf8218e9b40c81
> commit: ef8c01eb64ca6719da449dab0aa9424e13c58bd0 irqchip: Add Loongson PCH PIC controller
> date:   6 months ago
> config: s390-randconfig-r022-20201113 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef8c01eb64ca6719da449dab0aa9424e13c58bd0
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout ef8c01eb64ca6719da449dab0aa9424e13c58bd0
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Hi lkp (ktr) et al,

arch/s390/Kconfig says that HAS_IOMEM depends on CONFIG_PCI and the
supplied .config.gz file has
# CONFIG_PCI is not set

Does that mean that all of these drivers should have an additional
	depends on HAS_IOMEM
in their Kconfig entries?

That's what it would take for them to have access to all of the
devm_platform_iomap* type functions.

For most ARCHes, OF_ADDRESS also depends on HAS_IOMEM, so that's why
of_iomap() is not available.


> All errors (new ones prefixed by >>):
> 
>     s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
>     irq-al-fic.c:(.init.text+0x5c): undefined reference to `of_iomap'
>     s390-linux-ld: irq-al-fic.c:(.init.text+0x28c): undefined reference to `iounmap'
>     s390-linux-ld: drivers/irqchip/irq-jcore-aic.o: in function `aic_irq_of_init':
>     irq-jcore-aic.c:(.init.text+0x86): undefined reference to `of_iomap'
>     s390-linux-ld: irq-jcore-aic.c:(.init.text+0xac): undefined reference to `iounmap'
>     s390-linux-ld: drivers/irqchip/irq-renesas-irqc.o: in function `irqc_probe':
>     irq-renesas-irqc.c:(.text+0x26a): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/irqchip/irq-renesas-h8s.o: in function `h8s_intc_of_init':
>     irq-renesas-h8s.c:(.init.text+0xcc): undefined reference to `of_iomap'
>     s390-linux-ld: drivers/irqchip/irq-uniphier-aidet.o: in function `uniphier_aidet_probe':
>     irq-uniphier-aidet.c:(.text+0x356): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
>     irq-imx-intmux.c:(.text+0x46c): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/irqchip/irq-loongson-pch-pic.o: in function `pch_pic_of_init':
>>> irq-loongson-pch-pic.c:(.text+0x4aa): undefined reference to `of_iomap'
>>> s390-linux-ld: irq-loongson-pch-pic.c:(.text+0x5f8): undefined reference to `iounmap'
>     s390-linux-ld: drivers/phy/broadcom/phy-bcm-cygnus-pcie.o: in function `cygnus_pcie_phy_probe':
>     phy-bcm-cygnus-pcie.c:(.text+0xb4): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/phy/broadcom/phy-bcm-ns2-usbdrd.o: in function `ns2_drd_phy_probe':
>     phy-bcm-ns2-usbdrd.c:(.text+0x2ee): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: phy-bcm-ns2-usbdrd.c:(.text+0x324): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: phy-bcm-ns2-usbdrd.c:(.text+0x35a): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: phy-bcm-ns2-usbdrd.c:(.text+0x390): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/phy/broadcom/phy-brcm-sata.o:phy-brcm-sata.c:(.text+0x107c): more undefined references to `devm_ioremap_resource' follow
>     s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
>     phy-mvebu-a3700-utmi.c:(.text+0x3bc): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/phy/marvell/phy-armada38x-comphy.o: in function `a38x_comphy_probe':
>     phy-armada38x-comphy.c:(.text+0x126): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/phy/marvell/phy-pxa-usb.o: in function `pxa_usb_phy_probe':
>     phy-pxa-usb.c:(.text+0x2ce): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/phy/st/phy-stm32-usbphyc.o: in function `stm32_usbphyc_probe':
>     phy-stm32-usbphyc.c:(.text+0x358): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/phy/ti/phy-omap-control.o: in function `omap_control_phy_probe':
>     phy-omap-control.c:(.text+0x94): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: phy-omap-control.c:(.text+0xca): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/phy/ti/phy-omap-control.o:phy-omap-control.c:(.text+0x118): more undefined references to `devm_ioremap_resource' follow
>     s390-linux-ld: drivers/char/ipmi/bt-bmc.o: in function `bt_bmc_probe':
>     bt-bmc.c:(.text+0xa14): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/soc/bcm/brcmstb/common.o: in function `brcmstb_soc_device_early_init':
>     common.c:(.init.text+0x6e): undefined reference to `of_iomap'
>     s390-linux-ld: common.c:(.init.text+0xaa): undefined reference to `iounmap'
>     s390-linux-ld: drivers/soc/bcm/brcmstb/biuctrl.o: in function `brcmstb_biuctrl_init':
>     biuctrl.c:(.init.text+0x86): undefined reference to `of_iomap'
>     s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
>     dpaa2-console.c:(.text+0x74): undefined reference to `iounmap'
>     s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
>     dpaa2-console.c:(.text+0xc8): undefined reference to `of_address_to_resource'
>     s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.isra.0.constprop.0':
>     dpaa2-console.c:(.text+0x17e): undefined reference to `ioremap'
>     s390-linux-ld: dpaa2-console.c:(.text+0x1a6): undefined reference to `iounmap'
>     s390-linux-ld: dpaa2-console.c:(.text+0x1ba): undefined reference to `ioremap'
>     s390-linux-ld: dpaa2-console.c:(.text+0x210): undefined reference to `iounmap'
>     s390-linux-ld: drivers/soc/mediatek/mtk-pmic-wrap.o: in function `pwrap_probe':
>     mtk-pmic-wrap.c:(.text+0x146e): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: mtk-pmic-wrap.c:(.text+0x14fe): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/soc/mediatek/mtk-scpsys.o: in function `scpsys_probe':
>     mtk-scpsys.c:(.text+0x35c): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/soc/amlogic/meson-canvas.o: in function `meson_canvas_probe':
>     meson-canvas.c:(.text+0x5e): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/soc/amlogic/meson-clk-measure.o: in function `meson_msr_probe':
>     meson-clk-measure.c:(.text+0xde): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/soc/qcom/qcom-geni-se.o:qcom-geni-se.c:(.text+0x64): more undefined references to `devm_ioremap_resource' follow
>     s390-linux-ld: drivers/regulator/stm32-vrefbuf.o: in function `stm32_vrefbuf_probe':
>     stm32-vrefbuf.c:(.text+0x2e0): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-axs10x.o: in function `axs10x_reset_probe':
>     reset-axs10x.c:(.text+0xce): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-lpc18xx.o: in function `lpc18xx_rgu_probe':
>     reset-lpc18xx.c:(.text+0x23e): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-meson.o: in function `meson_reset_probe':
>     reset-meson.c:(.text+0x8e): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-meson-audio-arb.o: in function `meson_audio_arb_probe':
>     reset-meson-audio-arb.c:(.text+0x1b6): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-npcm.o: in function `npcm_rc_probe':
>     reset-npcm.c:(.text+0x10c): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-qcom-aoss.o: in function `qcom_aoss_reset_probe':
>     reset-qcom-aoss.c:(.text+0x1b8): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-qcom-pdc.o: in function `qcom_pdc_reset_probe':
>     reset-qcom-pdc.c:(.text+0x13e): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-simple.o: in function `reset_simple_probe':
>     reset-simple.c:(.text+0x180): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/reset/reset-uniphier-glue.o: in function `uniphier_glue_reset_probe':
>     reset-uniphier-glue.c:(.text+0x122): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
>     main.c:(.text+0x9a): undefined reference to `iounmap'
>     s390-linux-ld: main.c:(.text+0xe0): undefined reference to `iounmap'
>     s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
>     main.c:(.text+0x29a): undefined reference to `ioremap'
>     s390-linux-ld: main.c:(.text+0x34e): undefined reference to `ioremap'
>     s390-linux-ld: main.c:(.text+0x3a0): undefined reference to `iounmap'
>     s390-linux-ld: main.c:(.text+0x3e6): undefined reference to `iounmap'
>     s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_attach':
>     main.c:(.text+0x620): undefined reference to `iounmap'
>     s390-linux-ld: main.c:(.text+0x660): undefined reference to `iounmap'
>     s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
>     meson-rng.c:(.text+0x72): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
>     mtk-rng.c:(.text+0x246): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/char/hw_random/ks-sa-rng.o: in function `ks_sa_rng_probe':
>     ks-sa-rng.c:(.text+0x2fa): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
>     npcm-rng.c:(.text+0x1fc): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>     xillybus_of.c:(.text+0x1f0): undefined reference to `devm_platform_ioremap_resource'
>     s390-linux-ld: drivers/iommu/mtk_iommu.o: in function `mtk_iommu_probe':
>     mtk_iommu.c:(.text+0xb9c): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/iommu/qcom_iommu.o: in function `qcom_iommu_device_probe':
>     qcom_iommu.c:(.text+0x19c): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/iommu/qcom_iommu.o: in function `qcom_iommu_ctx_probe':
>     qcom_iommu.c:(.text+0x386): undefined reference to `devm_ioremap_resource'
>     s390-linux-ld: drivers/mfd/syscon.o: in function `syscon_probe':
>     syscon.c:(.text+0xa6): undefined reference to `devm_ioremap'
>     s390-linux-ld: drivers/mfd/syscon.o: in function `of_syscon_register.isra.0':
>     syscon.c:(.text+0x19e): undefined reference to `of_address_to_resource'
>     s390-linux-ld: syscon.c:(.text+0x1c0): undefined reference to `ioremap'
>     s390-linux-ld: syscon.c:(.text+0x2f4): undefined reference to `iounmap'
>     s390-linux-ld: drivers/mfd/stm32-timers.o: in function `stm32_timers_probe':
> 
> ---

Thanks.
