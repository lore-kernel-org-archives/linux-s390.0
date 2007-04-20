Return-Path: <linux-kernel-owner+w=401wt.eu-S2993032AbXDTLch@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:32:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 2/8] Kconfig: unwanted menus for s390.
Message-ID: <20070420113248.GC3738@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: akpm@linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Disable all menus in the configuration that are of no interest
to a s390 machine. There are quite a few of them..

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/ata/Kconfig        |    1 +
 drivers/char/ipmi/Kconfig  |    2 ++
 drivers/char/tpm/Kconfig   |    1 +
 drivers/dma/Kconfig        |    1 +
 drivers/edac/Kconfig       |    1 +
 drivers/hwmon/Kconfig      |    1 +
 drivers/i2c/Kconfig        |    1 +
 drivers/ide/Kconfig        |    1 +
 drivers/infiniband/Kconfig |    1 +
 drivers/input/Kconfig      |    1 +
 drivers/isdn/Kconfig       |    1 +
 drivers/leds/Kconfig       |    1 +
 drivers/media/Kconfig      |    1 +
 drivers/mfd/Kconfig        |    1 +
 drivers/misc/Kconfig       |    1 +
 drivers/mmc/Kconfig        |    1 +
 drivers/mtd/Kconfig        |    1 +
 drivers/net/phy/Kconfig    |    1 +
 drivers/parport/Kconfig    |    1 +
 drivers/pnp/Kconfig        |    1 +
 drivers/rtc/Kconfig        |    1 +
 drivers/serial/Kconfig     |    1 +
 drivers/spi/Kconfig        |    1 +
 drivers/telephony/Kconfig  |    1 +
 drivers/usb/Kconfig        |    1 +
 drivers/video/Kconfig      |    1 +
 drivers/w1/Kconfig         |    1 +
 net/ax25/Kconfig           |    2 +-
 net/bluetooth/Kconfig      |    2 +-
 net/irda/Kconfig           |    2 +-
 sound/Kconfig              |    1 +
 31 files changed, 32 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/ata/Kconfig linux-2.6-patched/drivers/ata/Kconfig
--- linux-2.6/drivers/ata/Kconfig	2007-04-19 15:24:32.000000000 +0200
+++ linux-2.6-patched/drivers/ata/Kconfig	2007-04-19 15:49:54.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Serial ATA (prod) and Parallel ATA (experimental) drivers"
+	depends on !S390
 
 config ATA
 	tristate "ATA device support"
diff -urpN linux-2.6/drivers/char/ipmi/Kconfig linux-2.6-patched/drivers/char/ipmi/Kconfig
--- linux-2.6/drivers/char/ipmi/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/char/ipmi/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,8 @@
 #
 
 menu "IPMI"
+	depends on !S390
+
 config IPMI_HANDLER
        tristate 'IPMI top-level message handler'
        help
diff -urpN linux-2.6/drivers/char/tpm/Kconfig linux-2.6-patched/drivers/char/tpm/Kconfig
--- linux-2.6/drivers/char/tpm/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/char/tpm/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "TPM devices"
+	depends on !S390
 
 config TCG_TPM
 	tristate "TPM Hardware Support"
diff -urpN linux-2.6/drivers/dma/Kconfig linux-2.6-patched/drivers/dma/Kconfig
--- linux-2.6/drivers/dma/Kconfig	2007-04-19 15:24:33.000000000 +0200
+++ linux-2.6-patched/drivers/dma/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "DMA Engine support"
+	depends on !S390
 
 config DMA_ENGINE
 	bool "Support for DMA engines"
diff -urpN linux-2.6/drivers/edac/Kconfig linux-2.6-patched/drivers/edac/Kconfig
--- linux-2.6/drivers/edac/Kconfig	2007-04-19 15:24:33.000000000 +0200
+++ linux-2.6-patched/drivers/edac/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -7,6 +7,7 @@
 #
 
 menu 'EDAC - error detection and reporting (RAS) (EXPERIMENTAL)'
+	depends on !S390
 
 config EDAC
 	tristate "EDAC core system error reporting (EXPERIMENTAL)"
diff -urpN linux-2.6/drivers/hwmon/Kconfig linux-2.6-patched/drivers/hwmon/Kconfig
--- linux-2.6/drivers/hwmon/Kconfig	2007-04-19 15:24:33.000000000 +0200
+++ linux-2.6-patched/drivers/hwmon/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Hardware Monitoring support"
+	depends on !S390
 
 config HWMON
 	tristate "Hardware Monitoring support"
diff -urpN linux-2.6/drivers/i2c/Kconfig linux-2.6-patched/drivers/i2c/Kconfig
--- linux-2.6/drivers/i2c/Kconfig	2007-04-19 15:24:33.000000000 +0200
+++ linux-2.6-patched/drivers/i2c/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "I2C support"
+	depends on !S390
 
 config I2C
 	tristate "I2C support"
diff -urpN linux-2.6/drivers/ide/Kconfig linux-2.6-patched/drivers/ide/Kconfig
--- linux-2.6/drivers/ide/Kconfig	2007-04-19 15:24:33.000000000 +0200
+++ linux-2.6-patched/drivers/ide/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -7,6 +7,7 @@
 if BLOCK
 
 menu "ATA/ATAPI/MFM/RLL support"
+	depends on !S390
 
 config IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
diff -urpN linux-2.6/drivers/infiniband/Kconfig linux-2.6-patched/drivers/infiniband/Kconfig
--- linux-2.6/drivers/infiniband/Kconfig	2007-04-19 15:23:58.000000000 +0200
+++ linux-2.6-patched/drivers/infiniband/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -1,4 +1,5 @@
 menu "InfiniBand support"
+	depends on !S390
 
 config INFINIBAND
 	depends on PCI || BROKEN
diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-patched/drivers/input/Kconfig
--- linux-2.6/drivers/input/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/input/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Input device support"
+	depends on !S390
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-patched/drivers/isdn/Kconfig
--- linux-2.6/drivers/isdn/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/isdn/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "ISDN subsystem"
+	depends on !S390
 
 config ISDN
 	tristate "ISDN support"
diff -urpN linux-2.6/drivers/leds/Kconfig linux-2.6-patched/drivers/leds/Kconfig
--- linux-2.6/drivers/leds/Kconfig	2007-04-19 15:24:34.000000000 +0200
+++ linux-2.6-patched/drivers/leds/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "LED devices"
+	depends on !S390
 
 config NEW_LEDS
 	bool "LED Support"
diff -urpN linux-2.6/drivers/media/Kconfig linux-2.6-patched/drivers/media/Kconfig
--- linux-2.6/drivers/media/Kconfig	2007-04-19 15:23:59.000000000 +0200
+++ linux-2.6-patched/drivers/media/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Multimedia devices"
+	depends on !S390
 
 config VIDEO_DEV
 	tristate "Video For Linux"
diff -urpN linux-2.6/drivers/mfd/Kconfig linux-2.6-patched/drivers/mfd/Kconfig
--- linux-2.6/drivers/mfd/Kconfig	2007-04-19 15:24:00.000000000 +0200
+++ linux-2.6-patched/drivers/mfd/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Multifunction device drivers"
+	depends on !S390
 
 config MFD_SM501
 	tristate "Support for Silicon Motion SM501"
diff -urpN linux-2.6/drivers/misc/Kconfig linux-2.6-patched/drivers/misc/Kconfig
--- linux-2.6/drivers/misc/Kconfig	2007-04-19 15:24:35.000000000 +0200
+++ linux-2.6-patched/drivers/misc/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Misc devices"
+	depends on !S390
 
 config IBM_ASM
 	tristate "Device driver for IBM RSA service processor"
diff -urpN linux-2.6/drivers/mmc/Kconfig linux-2.6-patched/drivers/mmc/Kconfig
--- linux-2.6/drivers/mmc/Kconfig	2007-04-19 15:24:35.000000000 +0200
+++ linux-2.6-patched/drivers/mmc/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "MMC/SD Card support"
+	depends on !S390
 
 config MMC
 	tristate "MMC support"
diff -urpN linux-2.6/drivers/mtd/Kconfig linux-2.6-patched/drivers/mtd/Kconfig
--- linux-2.6/drivers/mtd/Kconfig	2007-04-19 15:24:35.000000000 +0200
+++ linux-2.6-patched/drivers/mtd/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -1,6 +1,7 @@
 # $Id: Kconfig,v 1.11 2005/11/07 11:14:19 gleixner Exp $
 
 menu "Memory Technology Devices (MTD)"
+	depends on !S390
 
 config MTD
 	tristate "Memory Technology Device (MTD) support"
diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-patched/drivers/net/phy/Kconfig
--- linux-2.6/drivers/net/phy/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/net/phy/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "PHY device support"
+	depends on !S390
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
diff -urpN linux-2.6/drivers/parport/Kconfig linux-2.6-patched/drivers/parport/Kconfig
--- linux-2.6/drivers/parport/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/parport/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -6,6 +6,7 @@
 #
 
 menu "Parallel port support"
+	depends on !S390
 
 config PARPORT
 	tristate "Parallel port support"
diff -urpN linux-2.6/drivers/pnp/Kconfig linux-2.6-patched/drivers/pnp/Kconfig
--- linux-2.6/drivers/pnp/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/pnp/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Plug and Play support"
+	depends on !S390
 
 config PNP
 	bool "Plug and Play support"
diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-patched/drivers/rtc/Kconfig
--- linux-2.6/drivers/rtc/Kconfig	2007-04-19 15:24:39.000000000 +0200
+++ linux-2.6-patched/drivers/rtc/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Real Time Clock"
+	depends on !S390
 
 config RTC_LIB
 	tristate
diff -urpN linux-2.6/drivers/serial/Kconfig linux-2.6-patched/drivers/serial/Kconfig
--- linux-2.6/drivers/serial/Kconfig	2007-04-19 15:24:40.000000000 +0200
+++ linux-2.6-patched/drivers/serial/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -5,6 +5,7 @@
 #
 
 menu "Serial drivers"
+	depends on !S390
 
 #
 # The new 8250/16550 serial drivers
diff -urpN linux-2.6/drivers/spi/Kconfig linux-2.6-patched/drivers/spi/Kconfig
--- linux-2.6/drivers/spi/Kconfig	2007-04-19 15:24:40.000000000 +0200
+++ linux-2.6-patched/drivers/spi/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -6,6 +6,7 @@
 # fully appropriate there, so it'd need some thought to do well.
 #
 menu "SPI support"
+	depends on !S390
 
 config SPI
 	bool "SPI support"
diff -urpN linux-2.6/drivers/telephony/Kconfig linux-2.6-patched/drivers/telephony/Kconfig
--- linux-2.6/drivers/telephony/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/telephony/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Telephony Support"
+	depends on !S390
 
 config PHONE
 	tristate "Linux telephony support"
diff -urpN linux-2.6/drivers/usb/Kconfig linux-2.6-patched/drivers/usb/Kconfig
--- linux-2.6/drivers/usb/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/usb/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "USB support"
+	depends on !S390
 
 # Host-side USB depends on having a host controller
 # NOTE:  dummy_hcd is always an option, but it's ignored here ...
diff -urpN linux-2.6/drivers/video/Kconfig linux-2.6-patched/drivers/video/Kconfig
--- linux-2.6/drivers/video/Kconfig	2007-04-19 15:24:43.000000000 +0200
+++ linux-2.6-patched/drivers/video/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Graphics support"
+	depends on !S390
 
 source "drivers/video/backlight/Kconfig"
 source "drivers/video/display/Kconfig"
diff -urpN linux-2.6/drivers/w1/Kconfig linux-2.6-patched/drivers/w1/Kconfig
--- linux-2.6/drivers/w1/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/w1/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -1,4 +1,5 @@
 menu "Dallas's 1-wire bus"
+	depends on !S390
 
 config W1
 	tristate "Dallas's 1-wire support"
diff -urpN linux-2.6/net/ax25/Kconfig linux-2.6-patched/net/ax25/Kconfig
--- linux-2.6/net/ax25/Kconfig	2007-04-19 15:24:18.000000000 +0200
+++ linux-2.6-patched/net/ax25/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig HAMRADIO
-	depends on NET
+	depends on NET && !S390
 	bool "Amateur Radio support"
 	help
 	  If you want to connect your Linux box to an amateur radio, answer Y
diff -urpN linux-2.6/net/bluetooth/Kconfig linux-2.6-patched/net/bluetooth/Kconfig
--- linux-2.6/net/bluetooth/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/net/bluetooth/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig BT
-	depends on NET
+	depends on NET && !S390
 	tristate "Bluetooth subsystem support"
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
diff -urpN linux-2.6/net/irda/Kconfig linux-2.6-patched/net/irda/Kconfig
--- linux-2.6/net/irda/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/net/irda/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig IRDA
-	depends on NET
+	depends on NET && !S390
 	tristate "IrDA (infrared) subsystem support"
 	select CRC_CCITT
 	---help---
diff -urpN linux-2.6/sound/Kconfig linux-2.6-patched/sound/Kconfig
--- linux-2.6/sound/Kconfig	2007-04-19 15:24:23.000000000 +0200
+++ linux-2.6-patched/sound/Kconfig	2007-04-19 15:49:55.000000000 +0200
@@ -2,6 +2,7 @@
 #
 
 menu "Sound"
+	depends on !S390
 
 config SOUND
 	tristate "Sound card support"
