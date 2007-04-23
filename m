Return-Path: <linux-kernel-owner+w=401wt.eu-S932409AbXDWOMh@vger.kernel.org>
Date: Mon, 23 Apr 2007 16:12:51 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 3/9] Kconfig: unwanted menus for s390.
Message-ID: <20070423141251.GD21174@skybase>
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

Disable some more menus in the configuration files that are of no
interest to a s390 machine.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/dma/Kconfig     |    1 +
 drivers/input/Kconfig   |    1 +
 drivers/isdn/Kconfig    |    1 +
 drivers/net/phy/Kconfig |    1 +
 drivers/rtc/Kconfig     |    1 +
 net/ax25/Kconfig        |    2 +-
 net/bluetooth/Kconfig   |    2 +-
 net/irda/Kconfig        |    2 +-
 8 files changed, 8 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/dma/Kconfig linux-2.6-patched/drivers/dma/Kconfig
--- linux-2.6/drivers/dma/Kconfig	2007-04-23 15:51:31.000000000 +0200
+++ linux-2.6-patched/drivers/dma/Kconfig	2007-04-23 15:53:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "DMA Engine support"
+	depends on !S390
 
 config DMA_ENGINE
 	bool "Support for DMA engines"
diff -urpN linux-2.6/drivers/input/Kconfig linux-2.6-patched/drivers/input/Kconfig
--- linux-2.6/drivers/input/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/input/Kconfig	2007-04-23 15:53:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Input device support"
+	depends on !S390
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
diff -urpN linux-2.6/drivers/isdn/Kconfig linux-2.6-patched/drivers/isdn/Kconfig
--- linux-2.6/drivers/isdn/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/isdn/Kconfig	2007-04-23 15:53:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "ISDN subsystem"
+	depends on !S390
 
 config ISDN
 	tristate "ISDN support"
diff -urpN linux-2.6/drivers/net/phy/Kconfig linux-2.6-patched/drivers/net/phy/Kconfig
--- linux-2.6/drivers/net/phy/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/net/phy/Kconfig	2007-04-23 15:53:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "PHY device support"
+	depends on !S390
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
diff -urpN linux-2.6/drivers/rtc/Kconfig linux-2.6-patched/drivers/rtc/Kconfig
--- linux-2.6/drivers/rtc/Kconfig	2007-04-23 15:51:51.000000000 +0200
+++ linux-2.6-patched/drivers/rtc/Kconfig	2007-04-23 15:53:07.000000000 +0200
@@ -3,6 +3,7 @@
 #
 
 menu "Real Time Clock"
+	depends on !S390
 
 config RTC_LIB
 	tristate
diff -urpN linux-2.6/net/ax25/Kconfig linux-2.6-patched/net/ax25/Kconfig
--- linux-2.6/net/ax25/Kconfig	2007-04-23 15:50:54.000000000 +0200
+++ linux-2.6-patched/net/ax25/Kconfig	2007-04-23 15:53:07.000000000 +0200
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
+++ linux-2.6-patched/net/bluetooth/Kconfig	2007-04-23 15:53:08.000000000 +0200
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
+++ linux-2.6-patched/net/irda/Kconfig	2007-04-23 15:53:08.000000000 +0200
@@ -3,7 +3,7 @@
 #
 
 menuconfig IRDA
-	depends on NET
+	depends on NET && !S390
 	tristate "IrDA (infrared) subsystem support"
 	select CRC_CCITT
 	---help---
