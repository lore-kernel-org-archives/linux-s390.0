From: Fengguang Wu <fengguang.wu@intel.com>
Date: Wed, 03 Jul 2013 01:57:55 +0000
Subject: [pinchartl-fbdev:vsp1 37/42] ERROR: "devm_request_threaded_irq" [drivers/media/platform/vsp1/vsp1.ko
Message-Id: <20130703015755.GA10631@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

tree:   git://linuxtv.org/pinchartl/fbdev.git vsp1
head:   c92ff9101f0c4cd60afcb5e443c17f6d942bef1f
commit: df0aa44af637e49dedb7ba6ae4e5482c718708d1 [37/42] v4l: Renesas VSP1 driver
config: make ARCH=s390 allmodconfig

All error/warnings:

   WARNING: could not open drivers/net/ethernet/atheros/alx/main.c: No such file or directory
   ERROR: "devm_request_threaded_irq" [drivers/staging/dwc2/dwc2.ko] undefined!
   ERROR: "devm_request_threaded_irq" [drivers/net/ethernet/marvell/mvmdio.ko] undefined!
   ERROR: "devm_request_threaded_irq" [drivers/mfd/si476x-core.ko] undefined!
   ERROR: "irq_create_mapping" [drivers/mfd/mfd-core.ko] undefined!
>> ERROR: "devm_request_threaded_irq" [drivers/media/platform/vsp1/vsp1.ko] undefined!
   ERROR: "devm_request_threaded_irq" [drivers/input/touchscreen/st1232.ko] undefined!
   ERROR: "devm_request_threaded_irq" [drivers/i2c/busses/i2c-designware-pci.ko] undefined!

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
