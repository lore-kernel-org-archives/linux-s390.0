Return-Path: <linux-kernel-owner+w=401wt.eu-S1762609AbXEJN71@vger.kernel.org>
Message-Id: <20070510135645.453943569@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:52:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/15] Kconfig: unwanted menus for s390.
Content-Disposition: inline; filename=102-kconfig-menu-s390.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
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

Index: quilt-2.6/drivers/dma/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/dma/Kconfig
+++ quilt-2.6/drivers/dma/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "DMA Engine support"
+	depends on !S390
 
 config DMA_ENGINE
 	bool "Support for DMA engines"
Index: quilt-2.6/drivers/input/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/input/Kconfig
+++ quilt-2.6/drivers/input/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Input device support"
+	depends on !S390
 
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
Index: quilt-2.6/drivers/isdn/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/isdn/Kconfig
+++ quilt-2.6/drivers/isdn/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "ISDN subsystem"
+	depends on !S390
 
 config ISDN
 	tristate "ISDN support"
Index: quilt-2.6/drivers/net/phy/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/net/phy/Kconfig
+++ quilt-2.6/drivers/net/phy/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "PHY device support"
+	depends on !S390
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
Index: quilt-2.6/drivers/rtc/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/rtc/Kconfig
+++ quilt-2.6/drivers/rtc/Kconfig
@@ -3,6 +3,7 @@
 #
 
 menu "Real Time Clock"
+	depends on !S390
 
 config RTC_LIB
 	tristate
Index: quilt-2.6/net/ax25/Kconfig
===================================================================
--- quilt-2.6.orig/net/ax25/Kconfig
+++ quilt-2.6/net/ax25/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig HAMRADIO
-	depends on NET
+	depends on NET && !S390
 	bool "Amateur Radio support"
 	help
 	  If you want to connect your Linux box to an amateur radio, answer Y
Index: quilt-2.6/net/bluetooth/Kconfig
===================================================================
--- quilt-2.6.orig/net/bluetooth/Kconfig
+++ quilt-2.6/net/bluetooth/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig BT
-	depends on NET
+	depends on NET && !S390
 	tristate "Bluetooth subsystem support"
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
Index: quilt-2.6/net/irda/Kconfig
===================================================================
--- quilt-2.6.orig/net/irda/Kconfig
+++ quilt-2.6/net/irda/Kconfig
@@ -3,7 +3,7 @@
 #
 
 menuconfig IRDA
-	depends on NET
+	depends on NET && !S390
 	tristate "IrDA (infrared) subsystem support"
 	select CRC_CCITT
 	---help---

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
