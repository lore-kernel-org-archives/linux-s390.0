Return-Path: <linux-kernel-owner+w=401wt.eu-S932943AbXEJOBb@vger.kernel.org>
Message-Id: <20070510135644.944670288@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:52:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/15] Kconfig: refine depends statements.
Content-Disposition: inline; filename=100-kconfig-refine.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Refine some depends statements to limit their visibility to the
environments that are actually supported.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/auxdisplay/Kconfig     |    1 +
 drivers/char/Kconfig           |    2 ++
 drivers/ieee1394/Kconfig       |    1 +
 drivers/kvm/Kconfig            |    1 +
 drivers/message/fusion/Kconfig |    1 +
 drivers/message/i2o/Kconfig    |    1 +
 6 files changed, 7 insertions(+)

Index: quilt-2.6/drivers/auxdisplay/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/auxdisplay/Kconfig
+++ quilt-2.6/drivers/auxdisplay/Kconfig
@@ -6,6 +6,7 @@
 #
 
 menu "Auxiliary Display support"
+	depends on PARPORT
 
 config KS0108
 	tristate "KS0108 LCD Controller"
Index: quilt-2.6/drivers/char/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/char/Kconfig
+++ quilt-2.6/drivers/char/Kconfig
@@ -81,6 +81,7 @@ config VT_HW_CONSOLE_BINDING
 
 config SERIAL_NONSTANDARD
 	bool "Non-standard serial port support"
+	depends on HAS_IOMEM
 	---help---
 	  Say Y here if you have any non-standard serial boards -- boards
 	  which aren't supported using the standard "dumb" serial driver.
@@ -858,6 +859,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
Index: quilt-2.6/drivers/ieee1394/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/ieee1394/Kconfig
+++ quilt-2.6/drivers/ieee1394/Kconfig
@@ -1,4 +1,5 @@
 menu "IEEE 1394 (FireWire) support"
+	depends on PCI || BROKEN
 
 config IEEE1394
 	tristate "IEEE 1394 (FireWire) support"
Index: quilt-2.6/drivers/kvm/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/kvm/Kconfig
+++ quilt-2.6/drivers/kvm/Kconfig
@@ -2,6 +2,7 @@
 # KVM configuration
 #
 menu "Virtualization"
+	depends on X86
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
Index: quilt-2.6/drivers/message/fusion/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/message/fusion/Kconfig
+++ quilt-2.6/drivers/message/fusion/Kconfig
@@ -1,5 +1,6 @@
 
 menu "Fusion MPT device support"
+	depends on PCI
 
 config FUSION
 	bool
Index: quilt-2.6/drivers/message/i2o/Kconfig
===================================================================
--- quilt-2.6.orig/drivers/message/i2o/Kconfig
+++ quilt-2.6/drivers/message/i2o/Kconfig
@@ -1,5 +1,6 @@
 
 menu "I2O device support"
+	depends on PCI
 
 config I2O
 	tristate "I2O support"

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
