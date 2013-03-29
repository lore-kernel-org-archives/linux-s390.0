From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 02:31:43 +0000
Subject: drivers/usb/musb/tusb6010.c:946:2: error: implicit declaration of function 'irq_set_irq_type'
Message-Id: <20130329023143.GA9840@localhost>
To: linux-s390@vger.kernel.org, linux-usb@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,

These *huge number* of *long standing* errors make me wonder whether
the below USB driver code should be disabled on s390?

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   9064171268d838b8f283fe111ef086b9479d059a
commit: dced35aeb0367dda2636ee9ee914bda14510dcc9 drivers: Final irq namespace conversion
date:   2 years ago
config: make ARCH=s390 allmodconfig

All error/warnings (The >> prefixed ones are introduced by above commit):

   drivers/usb/musb/tusb6010.c: In function 'tusb_wbus_quirk':
   drivers/usb/musb/tusb6010.c:101:36: error: 'TUSB_PHY_OTG_CTRL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:102:35: error: 'TUSB_PHY_OTG_CTRL_ENABLE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:103:9: error: 'TUSB_PHY_OTG_CTRL_WRPROTECT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:104:21: error: 'TUSB_PHY_OTG_CTRL_TESTM2' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:104:21: error: 'TUSB_PHY_OTG_CTRL_TESTM1' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:104:21: error: 'TUSB_PHY_OTG_CTRL_TESTM0' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'musb_write_fifo':
   drivers/usb/musb/tusb6010.c:175:31: error: 'struct musb_hw_ep' has no member named 'conf'
   drivers/usb/musb/tusb6010.c:185:24: error: 'TUSB_EP_TX_OFFSET' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:186:4: error: implicit declaration of function 'TUSB_EP_CONFIG_XFR_SIZE' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:188:27: error: 'TUSB_EP0_CONFIG_DIR_TX' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:189:4: error: implicit declaration of function 'TUSB_EP0_CONFIG_XFR_SIZE' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c: In function 'musb_read_fifo':
   drivers/usb/musb/tusb6010.c:224:31: error: 'struct musb_hw_ep' has no member named 'conf'
   drivers/usb/musb/tusb6010.c:232:24: error: 'TUSB_EP_RX_OFFSET' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_set_clock_source':
   drivers/usb/musb/tusb6010.c:324:26: error: 'TUSB_PRCM_CONF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:325:2: error: implicit declaration of function 'TUSB_PRCM_CONF_SYS_CLKSEL' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c: In function 'tusb_allow_idle':
   drivers/usb/musb/tusb6010.c:351:24: error: 'TUSB_PRCM_WBUS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:352:35: error: 'TUSB_REV_30' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:357:20: error: 'TUSB_PRCM_WNORCS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:358:21: error: 'TUSB_PRCM_WAKEUP_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:365:26: error: 'TUSB_PRCM_MNGMT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:368:10: error: 'TUSB_PRCM_MNGMT_OTG_VBUS_DET_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:369:11: error: 'TUSB_PRCM_MNGMT_OTG_SESS_END_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:374:9: error: 'TUSB_PRCM_MNGMT_PM_IDLE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:374:35: error: 'TUSB_PRCM_MNGMT_DEV_IDLE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_vbus_status':
   drivers/usb/musb/tusb6010.c:389:31: error: 'TUSB_DEV_OTG_STAT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:390:33: error: 'TUSB_PRCM_MNGMT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:396:21: error: 'TUSB_PRCM_MNGMT_OTG_VBUS_DET_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:404:17: error: 'TUSB_DEV_OTG_STAT_VBUS_VALID' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'musb_do_idle':
   drivers/usb/musb/tusb6010.c:452:13: error: 'TUSB_PRCM_WHOSTDISCON' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:452:37: error: 'TUSB_PRCM_WBUS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_set_vbus':
   drivers/usb/musb/tusb6010.c:524:27: error: 'TUSB_PRCM_MNGMT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:525:27: error: 'TUSB_DEV_CONF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:529:3: error: implicit declaration of function 'TUSB_DEV_OTG_TIMER_VAL' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:529:11: error: 'TUSB_DEV_OTG_TIMER_ENABLE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:534:11: error: 'TUSB_DEV_CONF_USB_HOST_MODE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:542:32: error: 'TUSB_DEV_OTG_STAT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:543:20: error: 'TUSB_DEV_OTG_STAT_ID_STATUS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:568:12: error: 'TUSB_PRCM_MNGMT_15_SW_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:568:39: error: 'TUSB_PRCM_MNGMT_33_SW_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:571:21: error: 'TUSB_DEV_OTG_TIMER' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_set_mode':
   drivers/usb/musb/tusb6010.c:603:31: error: 'TUSB_DEV_OTG_STAT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:604:35: error: 'TUSB_PHY_OTG_CTRL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:605:34: error: 'TUSB_PHY_OTG_CTRL_ENABLE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:606:31: error: 'TUSB_DEV_CONF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:641:4: error: 'TUSB_PHY_OTG_CTRL_WRPROTECT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:648:16: error: 'TUSB_DEV_OTG_STAT_ID_STATUS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_otg_ints':
   drivers/usb/musb/tusb6010.c:658:36: error: 'TUSB_DEV_OTG_STAT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:662:17: error: 'TUSB_INT_SRC_ID_STATUS_CHNG' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:666:29: error: 'TUSB_DEV_OTG_STAT_ID_STATUS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:679:16: error: 'TUSB_INT_SRC_VBUS_SENSE_CHNG' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:695:19: error: 'TUSB_DEV_OTG_STAT_SESS_END' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:756:16: error: 'TUSB_INT_SRC_OTG_TIMEOUT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:767:19: error: 'TUSB_DEV_OTG_STAT_VBUS_VALID' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_interrupt':
   drivers/usb/musb/tusb6010.c:811:31: error: 'TUSB_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:812:37: error: 'TUSB_INT_MASK_RESERVED_BITS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:814:30: error: 'TUSB_INT_SRC' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:814:47: error: 'TUSB_INT_SRC_RESERVED_BITS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:820:16: error: 'TUSB_INT_SRC_DEV_WAKEUP' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:824:34: error: 'TUSB_REV_30' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:831:23: error: 'TUSB_SCRATCH_PAD' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:842:27: error: 'TUSB_PRCM_WAKEUP_SOURCE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:843:22: error: 'TUSB_PRCM_WAKEUP_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:844:14: error: 'TUSB_PRCM_WNORCS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:854:16: error: 'TUSB_INT_SRC_USB_IP_CONN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:858:17: error: 'TUSB_INT_SRC_VBUS_SENSE_CHNG' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:859:7: error: 'TUSB_INT_SRC_OTG_TIMEOUT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:860:7: error: 'TUSB_INT_SRC_ID_STATUS_CHNG' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:866:17: error: 'TUSB_INT_SRC_TXRX_DMA_DONE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:867:35: error: 'TUSB_DMA_INT_SRC' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:868:40: error: 'TUSB_DMA_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:883:22: error: 'TUSB_DMA_INT_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:887:17: error: 'TUSB_INT_SRC_USB_IP_TX' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:887:42: error: 'TUSB_INT_SRC_USB_IP_RX' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:888:36: error: 'TUSB_USBIP_INT_SRC' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:890:22: error: 'TUSB_USBIP_INT_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:902:21: error: 'TUSB_INT_SRC_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_enable':
   drivers/usb/musb/tusb6010.c:926:21: error: 'TUSB_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:926:36: error: 'TUSB_INT_SRC_USB_IP_SOF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:929:21: error: 'TUSB_USBIP_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:930:21: error: 'TUSB_DMA_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:931:21: error: 'TUSB_GPIO_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:934:21: error: 'TUSB_USBIP_INT_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:935:21: error: 'TUSB_DMA_INT_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:936:21: error: 'TUSB_GPIO_INT_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:939:21: error: 'TUSB_INT_SRC_CLEAR' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:939:42: error: 'TUSB_INT_MASK_RESERVED_BITS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:943:21: error: 'TUSB_INT_CTRL_CONF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:944:4: error: implicit declaration of function 'TUSB_INT_CTRL_CONF_INT_RELCYC' [-Werror=implicit-function-declaration]
>> drivers/usb/musb/tusb6010.c:946:2: error: implicit declaration of function 'irq_set_irq_type' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:946:31: error: 'IRQ_TYPE_LEVEL_LOW' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:949:26: error: 'TUSB_DEV_OTG_STAT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:950:6: error: 'TUSB_DEV_OTG_STAT_ID_STATUS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:951:22: error: 'TUSB_INT_SRC_SET' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:952:5: error: 'TUSB_INT_SRC_ID_STATUS_CHNG' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_disable':
   drivers/usb/musb/tusb6010.c:971:21: error: 'TUSB_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:971:37: error: 'TUSB_INT_MASK_RESERVED_BITS' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:972:21: error: 'TUSB_USBIP_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:973:21: error: 'TUSB_DMA_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:974:21: error: 'TUSB_GPIO_INT_MASK' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_setup_cpu_interface':
   drivers/usb/musb/tusb6010.c:997:21: error: 'TUSB_PULLUP_1_CTRL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1000:21: error: 'TUSB_PULLUP_2_CTRL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1003:21: error: 'TUSB_GPIO_CONF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1003:2: error: implicit declaration of function 'TUSB_GPIO_CONF_DMAREQ' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:1007:21: error: 'TUSB_DMA_REQ_CONF' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1008:3: error: implicit declaration of function 'TUSB_DMA_REQ_CONF_BURST_SIZE' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:1009:3: error: implicit declaration of function 'TUSB_DMA_REQ_CONF_DMA_REQ_EN' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:1010:3: error: implicit declaration of function 'TUSB_DMA_REQ_CONF_DMA_REQ_ASSER' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:1013:21: error: 'TUSB_WAIT_COUNT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_start':
   drivers/usb/musb/tusb6010.c:1032:24: error: 'TUSB_PROD_TEST_RESET' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1033:3: error: 'TUSB_PROD_TEST_RESET_VAL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1047:21: error: 'TUSB_VLYNQ_CTRL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1055:21: error: 'TUSB_PRCM_MNGMT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1056:3: error: implicit declaration of function 'TUSB_PRCM_MNGMT_VBUS_VALID_TIMER' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:1057:3: error: 'TUSB_PRCM_MNGMT_VBUS_VALID_FLT_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1058:3: error: 'TUSB_PRCM_MNGMT_OTG_SESS_END_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1059:3: error: 'TUSB_PRCM_MNGMT_OTG_VBUS_DET_EN' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1060:3: error: 'TUSB_PRCM_MNGMT_OTG_ID_PULLUP' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1064:26: error: 'TUSB_PHY_OTG_CTRL_ENABLE' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1065:9: error: 'TUSB_PHY_OTG_CTRL_WRPROTECT' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1065:39: error: 'TUSB_PHY_OTG_CTRL_OTG_ID_PULLUP' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1068:26: error: 'TUSB_PHY_OTG_CTRL' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_init':
   drivers/usb/musb/tusb6010.c:1101:6: error: 'struct musb' has no member named 'async'
   drivers/usb/musb/tusb6010.c:1110:6: error: 'struct musb' has no member named 'sync'
   drivers/usb/musb/tusb6010.c:1112:2: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c:1112:7: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/usb/musb/tusb6010.c:1118:6: error: 'struct musb' has no member named 'sync_va'
   drivers/usb/musb/tusb6010.c:1123:17: error: 'TUSB_BASE_OFFSET' undeclared (first use in this function)
   drivers/usb/musb/tusb6010.c:1143:4: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
   drivers/usb/musb/tusb6010.c: In function 'tusb_musb_exit':
   drivers/usb/musb/tusb6010.c:1159:14: error: 'struct musb' has no member named 'sync_va'
   cc1: some warnings being treated as errors
--
   drivers/usb/host/oxu210hp-hcd.c: In function 'oxu_readl':
   drivers/usb/host/oxu210hp-hcd.c:253:2: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
   drivers/usb/host/oxu210hp-hcd.c: In function 'oxu_writel':
   drivers/usb/host/oxu210hp-hcd.c:258:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
   drivers/usb/host/oxu210hp-hcd.c: In function 'submit_async':
   drivers/usb/host/oxu210hp-hcd.c:1618:19: warning: variable 'qtd' set but not used [-Wunused-but-set-variable]
   drivers/usb/host/oxu210hp-hcd.c: In function 'scan_periodic':
   drivers/usb/host/oxu210hp-hcd.c:2294:8: warning: variable 'live' set but not used [-Wunused-but-set-variable]
   drivers/usb/host/oxu210hp-hcd.c:2272:13: warning: variable 'uframes' set but not used [-Wunused-but-set-variable]
   drivers/usb/host/oxu210hp-hcd.c: In function 'oxu_urb_enqueue':
   drivers/usb/host/oxu210hp-hcd.c:2857:6: warning: variable 'transfer_buffer_length' set but not used [-Wunused-but-set-variable]
   drivers/usb/host/oxu210hp-hcd.c: In function 'oxu_drv_probe':
>> drivers/usb/host/oxu210hp-hcd.c:3835:2: error: implicit declaration of function 'irq_set_irq_type' [-Werror=implicit-function-declaration]
   drivers/usb/host/oxu210hp-hcd.c:3842:2: error: implicit declaration of function 'ioremap' [-Werror=implicit-function-declaration]
   drivers/usb/host/oxu210hp-hcd.c:3842:7: warning: assignment makes pointer from integer without a cast [enabled by default]
   drivers/usb/host/oxu210hp-hcd.c:3876:2: error: implicit declaration of function 'iounmap' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/irq_set_irq_type +946 drivers/usb/musb/tusb6010.c

550a7375 Felipe Balbi    2008-07-24  938  	/* Acknowledge pending interrupt(s) */
550a7375 Felipe Balbi    2008-07-24  939  	musb_writel(tbase, TUSB_INT_SRC_CLEAR, ~TUSB_INT_MASK_RESERVED_BITS);
550a7375 Felipe Balbi    2008-07-24  940  
550a7375 Felipe Balbi    2008-07-24  941  	/* Only 0 clock cycles for minimum interrupt de-assertion time and
550a7375 Felipe Balbi    2008-07-24  942  	 * interrupt polarity active low seems to work reliably here */
550a7375 Felipe Balbi    2008-07-24  943  	musb_writel(tbase, TUSB_INT_CTRL_CONF,
550a7375 Felipe Balbi    2008-07-24 @944  			TUSB_INT_CTRL_CONF_INT_RELCYC(0));
550a7375 Felipe Balbi    2008-07-24  945  
dced35ae Thomas Gleixner 2011-03-28 @946  	irq_set_irq_type(musb->nIrq, IRQ_TYPE_LEVEL_LOW);
550a7375 Felipe Balbi    2008-07-24  947  
550a7375 Felipe Balbi    2008-07-24  948  	/* maybe force into the Default-A OTG state machine */
550a7375 Felipe Balbi    2008-07-24  949  	if (!(musb_readl(tbase, TUSB_DEV_OTG_STAT)

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
