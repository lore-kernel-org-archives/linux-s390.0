Return-Path: <linux-kernel-owner+w=401wt.eu-S1751600AbXDWOL7@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:12:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/9] Kconfig: menus with depends on HAS_IOMEM.
Message-ID: <20070423141213.GC21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com, arnd@arndb.de, maxextreme@gmail.com, gregkh@suse.de
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

diff -urpN linux-2.6/drivers/ata/Kconfig linux-2.6-patched/drivers/ata/Kconfig
--- linux-2.6/drivers/ata/Kconfig	2007-04-23 15:51:29.000000000 +0200
+++ linux-2.6-patched/drivers/ata/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
+	depends on HAS_IOMEM
 
 config ATA
 	tristate "ATA device support"
diff -urpN linux-2.6/drivers/char/ipmi/Kconfig linux-2.6-patched/drivers/char/ipmi/Kconfig
--- linux-2.6/drivers/char/ipmi/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/char/ipmi/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,8 @@
 #
 
 menu "IPMI"
+	depends on HAS_IOMEM
+
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
diff -urpN linux-2.6/drivers/char/tpm/Kconfig linux-2.6-patched/drivers/char/tpm/Kconfig
--- linux-2.6/drivers/char/tpm/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/char/tpm/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "TPM devices"
+	depends on HAS_IOMEM
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
diff -urpN linux-2.6/drivers/edac/Kconfig linux-2.6-patched/drivers/edac/Kconfig
--- linux-2.6/drivers/edac/Kconfig	2007-04-23 15:51:31.000000000 +0200
+++ linux-2.6-patched/drivers/edac/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -7,6 +7,7 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
+	depends on HAS_IOMEM
 
 config EDAC
 	tristate "EDAC core system error reporting (EXPERIMENTAL)"
diff -urpN linux-2.6/drivers/hwmon/Kconfig linux-2.6-patched/drivers/hwmon/Kconfig
--- linux-2.6/drivers/hwmon/Kconfig	2007-04-23 15:51:31.000000000 +0200
+++ linux-2.6-patched/drivers/hwmon/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Hardware Monitoring support"
+	depends on HAS_IOMEM
 
 config HWMON
 	tristate "Hardware Monitoring support"
diff -urpN linux-2.6/drivers/i2c/Kconfig linux-2.6-patched/drivers/i2c/Kconfig
--- linux-2.6/drivers/i2c/Kconfig	2007-04-23 15:51:31.000000000 +0200
+++ linux-2.6-patched/drivers/i2c/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "I2C support"
+	depends on HAS_IOMEM
 
 config I2C
 	tristate "I2C support"
diff -urpN linux-2.6/drivers/ide/Kconfig linux-2.6-patched/drivers/ide/Kconfig
--- linux-2.6/drivers/ide/Kconfig	2007-04-23 15:51:32.000000000 +0200
+++ linux-2.6-patched/drivers/ide/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -7,6 +7,7 @@
 if BLOCK
 
 menu "ATA/ATAPI/MFM/RLL support"
+	depends on HAS_IOMEM
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-patched/drivers/infiniband/Kconfig
--- linux-2.6/drivers/infiniband/Kconfig	2007-04-23 15:50:42.000000000 +0200
+++ linux-2.6-patched/drivers/infiniband/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -1,4 +1,5 @@
 menu "InfiniBand support"
+	depends on HAS_IOMEM
 
 config INFINIBAND
 	depends on PCI || BROKEN
diff -urpN linux-2.6/drivers/leds/Kconfig linux-2.6-patched/drivers/leds/Kconfig
--- linux-2.6/drivers/leds/Kconfig	2007-04-23 15:51:37.000000000 +0200
+++ linux-2.6-patched/drivers/leds/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "LED devices"
+	depends on HAS_IOMEM
 
 config NEW_LEDS
 	bool "LED Support"
diff -urpN linux-2.6/drivers/media/Kconfig linux-2.6-patched/drivers/media/Kconfig
--- linux-2.6/drivers/media/Kconfig	2007-04-23 15:50:43.000000000 +0200
+++ linux-2.6-patched/drivers/media/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia devices"
+	depends on HAS_IOMEM
 
 config VIDEO_DEV
 	tristate "Video For Linux"
diff -urpN linux-2.6/drivers/mfd/Kconfig linux-2.6-patched/drivers/mfd/Kconfig
--- linux-2.6/drivers/mfd/Kconfig	2007-04-23 15:50:43.000000000 +0200
+++ linux-2.6-patched/drivers/mfd/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Multifunction device drivers"
+	depends on HAS_IOMEM
 
 config MFD_SM501
 	tristate "Support for Silicon Motion SM501"
diff -urpN linux-2.6/drivers/mmc/Kconfig linux-2.6-patched/drivers/mmc/Kconfig
--- linux-2.6/drivers/mmc/Kconfig	2007-04-23 15:51:43.000000000 +0200
+++ linux-2.6-patched/drivers/mmc/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "MMC/SD Card support"
+	depends on HAS_IOMEM
 
 config MMC
 	tristate "MMC support"
diff -urpN linux-2.6/drivers/mtd/Kconfig linux-2.6-patched/drivers/mtd/Kconfig
--- linux-2.6/drivers/mtd/Kconfig	2007-04-23 15:51:44.000000000 +0200
+++ linux-2.6-patched/drivers/mtd/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -1,6 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
 
 menu "Memory Technology Devices (MTD)"
+	depends on HAS_IOMEM
 
 config MTD
 	tristate "Memory Technology Device (MTD) support"
diff -urpN linux-2.6/drivers/parport/Kconfig linux-2.6-patched/drivers/parport/Kconfig
--- linux-2.6/drivers/parport/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/parport/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -6,6 +6,7 @@
 #
 
 menu "Parallel port support"
+	depends on HAS_IOMEM
 
 config PARPORT
 	tristate "Parallel port support"
diff -urpN linux-2.6/drivers/pnp/Kconfig linux-2.6-patched/drivers/pnp/Kconfig
--- linux-2.6/drivers/pnp/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/pnp/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Plug and Play support"
+	depends on HAS_IOMEM
 
 config PNP
 	bool "Plug and Play support"
diff -urpN linux-2.6/drivers/serial/Kconfig linux-2.6-patched/drivers/serial/Kconfig
--- linux-2.6/drivers/serial/Kconfig	2007-04-23 15:51:57.000000000 +0200
+++ linux-2.6-patched/drivers/serial/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "Serial drivers"
+	depends on HAS_IOMEM
 
 #
 # The new 8250/16550 serial drivers
diff -urpN linux-2.6/drivers/spi/Kconfig linux-2.6-patched/drivers/spi/Kconfig
--- linux-2.6/drivers/spi/Kconfig	2007-04-23 15:51:57.000000000 +0200
+++ linux-2.6-patched/drivers/spi/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -6,6 +6,7 @@
 # fully appropriate there, so it'd need some thought to do well.
 #
 menu "SPI support"
+	depends on HAS_IOMEM
 
 config SPI
 	bool "SPI support"
diff -urpN linux-2.6/drivers/telephony/Kconfig linux-2.6-patched/drivers/telephony/Kconfig
--- linux-2.6/drivers/telephony/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/telephony/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Telephony Support"
+	depends on HAS_IOMEM
 
 config PHONE
 	tristate "Linux telephony support"
diff -urpN linux-2.6/drivers/usb/Kconfig linux-2.6-patched/drivers/usb/Kconfig
--- linux-2.6/drivers/usb/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/usb/Kconfig	2007-04-23 15:53:05.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "USB support"
+	depends on HAS_IOMEM
 
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
diff -urpN linux-2.6/drivers/video/Kconfig linux-2.6-patched/drivers/video/Kconfig
--- linux-2.6/drivers/video/Kconfig	2007-04-23 15:52:02.000000000 +0200
+++ linux-2.6-patched/drivers/video/Kconfig	2007-04-23 15:53:06.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Graphics support"
+	depends on HAS_IOMEM
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
diff -urpN linux-2.6/drivers/w1/Kconfig linux-2.6-patched/drivers/w1/Kconfig
--- linux-2.6/drivers/w1/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/w1/Kconfig	2007-04-23 15:53:06.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Dallas's 1-wire bus"
+	depends on HAS_IOMEM
 
 config W1
 	tristate "Dallas's 1-wire support"
diff -urpN linux-2.6/sound/Kconfig linux-2.6-patched/sound/Kconfig
--- linux-2.6/sound/Kconfig	2007-04-23 15:50:55.000000000 +0200
+++ linux-2.6-patched/sound/Kconfig	2007-04-23 15:53:06.000000000 +0200
@@ -2,6 +2,7 @@
 #
 
 menu "Sound"
+	depends on HAS_IOMEM
 
 config SOUND
 	tristate "Sound card support"
