Return-Path: <linux-kernel-owner+w=401wt.eu-S1762603AbXEJOBH@vger.kernel.org>
Message-Id: <20070510135645.185110826@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:52:02 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/15] Kconfig: menus with depends on HAS_IOMEM.
Content-Disposition: inline; filename=101-kconfig-menu-iomem.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add "depends on HAS_IOMEM" to a number of menus to make them
disappear for s390 which does not have I/O memory.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/ata/Kconfig        |    1 +
 drivers/char/ipmi/Kconfig  |    2 ++
 drivers/char/tpm/Kconfig   |    1 +
 drivers/edac/Kconfig       |    1 +
 drivers/hwmon/Kconfig      |    1 +
 drivers/i2c/Kconfig        |    1 +
 drivers/ide/Kconfig        |    1 +
 drivers/infiniband/Kconfig |    1 +
 drivers/leds/Kconfig       |    1 +
 drivers/media/Kconfig      |    1 +
 drivers/mfd/Kconfig        |    1 +
 drivers/mmc/Kconfig        |    1 +
 drivers/mtd/Kconfig        |    1 +
 drivers/parport/Kconfig    |    1 +
 drivers/pnp/Kconfig        |    1 +
 drivers/serial/Kconfig     |    1 +
 drivers/spi/Kconfig        |    1 +
 drivers/telephony/Kconfig  |    1 +
 drivers/usb/Kconfig        |    1 +
 drivers/video/Kconfig      |    1 +
 drivers/w1/Kconfig         |    1 +
 sound/Kconfig              |    1 +
 22 files changed, 23 insertions(+)

Index: quilt-2.6/drivers/ata/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/ata/Kconfig
+++ quilt-2.6/drivers/ata/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
+	depends on HAS_IOMEM
 
 config ATA
 	tristate "ATA device support"
Index: quilt-2.6/drivers/char/ipmi/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/char/ipmi/Kconfig
+++ quilt-2.6/drivers/char/ipmi/Kconfig
@@ -3,6 +3,8 @@
 #
 
 menu "IPMI"
+	depends on HAS_IOMEM
+
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
Index: quilt-2.6/drivers/char/tpm/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/char/tpm/Kconfig
+++ quilt-2.6/drivers/char/tpm/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "TPM devices"
+	depends on HAS_IOMEM
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
Index: quilt-2.6/drivers/edac/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/edac/Kconfig
+++ quilt-2.6/drivers/edac/Kconfig
@@ -7,6 +7,7 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
+	depends on HAS_IOMEM
 
 config EDAC
 	tristate "EDAC core system error reporting (EXPERIMENTAL)"
Index: quilt-2.6/drivers/hwmon/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/hwmon/Kconfig
+++ quilt-2.6/drivers/hwmon/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig HWMON
 	tristate "Hardware Monitoring support"
+	depends on HAS_IOMEM
 	default y
 	help
 	  Hardware monitoring devices let you monitor the hardware health
Index: quilt-2.6/drivers/i2c/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/i2c/Kconfig
+++ quilt-2.6/drivers/i2c/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig I2C
 	tristate "I2C support"
+	depends on HAS_IOMEM
 	---help---
 	  I2C (pronounce: I-square-C) is a slow serial bus protocol used in
 	  many micro controller applications and developed by Philips.  SMBus,
Index: quilt-2.6/drivers/ide/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/ide/Kconfig
+++ quilt-2.6/drivers/ide/Kconfig
@@ -7,6 +7,7 @@
 if BLOCK
 
 menu "ATA/ATAPI/MFM/RLL support"
+	depends on HAS_IOMEM
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
Index: quilt-2.6/drivers/infiniband/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/infiniband/Kconfig
+++ quilt-2.6/drivers/infiniband/Kconfig
@@ -1,4 +1,5 @@
 menu "InfiniBand support"
+	depends on HAS_IOMEM
 
 config INFINIBAND
 	depends on PCI || BROKEN
Index: quilt-2.6/drivers/leds/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/leds/Kconfig
+++ quilt-2.6/drivers/leds/Kconfig
@@ -1,5 +1,6 @@
 
 menu "LED devices"
+	depends on HAS_IOMEM
 
 config NEW_LEDS
 	bool "LED Support"
Index: quilt-2.6/drivers/media/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/media/Kconfig
+++ quilt-2.6/drivers/media/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia devices"
+	depends on HAS_IOMEM
 
 config VIDEO_DEV
 	tristate "Video For Linux"
Index: quilt-2.6/drivers/mfd/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/mfd/Kconfig
+++ quilt-2.6/drivers/mfd/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Multifunction device drivers"
+	depends on HAS_IOMEM
 
 config MFD_SM501
 	tristate "Support for Silicon Motion SM501"
Index: quilt-2.6/drivers/mmc/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/mmc/Kconfig
+++ quilt-2.6/drivers/mmc/Kconfig
@@ -4,6 +4,7 @@
 
 menuconfig MMC
 	tristate "MMC/SD card support"
+	depends on HAS_IOMEM
 	help
 	  MMC is the "multi-media card" bus protocol.
 
Index: quilt-2.6/drivers/mtd/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/mtd/Kconfig
+++ quilt-2.6/drivers/mtd/Kconfig
@@ -2,6 +2,7 @@
 
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
+	depends on HAS_IOMEM
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
Index: quilt-2.6/drivers/parport/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/parport/Kconfig
+++ quilt-2.6/drivers/parport/Kconfig
@@ -6,6 +6,7 @@
 #
 
 menu "Parallel port support"
+	depends on HAS_IOMEM
 
 config PARPORT
 	tristate "Parallel port support"
Index: quilt-2.6/drivers/pnp/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/pnp/Kconfig
+++ quilt-2.6/drivers/pnp/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Plug and Play support"
+	depends on HAS_IOMEM
 
 config PNP
 	bool "Plug and Play support"
Index: quilt-2.6/drivers/serial/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/serial/Kconfig
+++ quilt-2.6/drivers/serial/Kconfig
@@ -5,6 +5,7 @@
 #
 
 menu "Serial drivers"
+	depends on HAS_IOMEM
 
 #
 # The new 8250/16550 serial drivers
Index: quilt-2.6/drivers/spi/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/spi/Kconfig
+++ quilt-2.6/drivers/spi/Kconfig
@@ -6,6 +6,7 @@
 # fully appropriate there, so it'd need some thought to do well.
 #
 menu "SPI support"
+	depends on HAS_IOMEM
 
 config SPI
 	bool "SPI support"
Index: quilt-2.6/drivers/telephony/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/telephony/Kconfig
+++ quilt-2.6/drivers/telephony/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Telephony Support"
+	depends on HAS_IOMEM
 
 config PHONE
 	tristate "Linux telephony support"
Index: quilt-2.6/drivers/usb/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/usb/Kconfig
+++ quilt-2.6/drivers/usb/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "USB support"
+	depends on HAS_IOMEM
 
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
Index: quilt-2.6/drivers/video/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/video/Kconfig
+++ quilt-2.6/drivers/video/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Graphics support"
+	depends on HAS_IOMEM
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
Index: quilt-2.6/drivers/w1/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/w1/Kconfig
+++ quilt-2.6/drivers/w1/Kconfig
@@ -1,4 +1,5 @@
 menu "Dallas's 1-wire bus"
+	depends on HAS_IOMEM
 
 config W1
 	tristate "Dallas's 1-wire support"
Index: quilt-2.6/sound/Kconfig
===================================================================
--- quilt-2.6.orig/sound/Kconfig
+++ quilt-2.6/sound/Kconfig
@@ -2,6 +2,7 @@
 #
 
 menu "Sound"
+	depends on HAS_IOMEM
 
 config SOUND
 	tristate "Sound card support"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
