Return-Path: <linux-kernel-owner+w=401wt.eu-S2992954AbXDTLc1@vger.kernel.org>
Date: Fri, 20 Apr 2007 13:32:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 1/8] Kconfig: refine depends statements.
Message-ID: <20070420113228.GB3738@skybase>
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

Refine some depends statements to limit their visibility to the
environments that are actually supported.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/auxdisplay/Kconfig     |    1 +
 drivers/char/Kconfig           |    1 +
 drivers/ieee1394/Kconfig       |    1 +
 drivers/kvm/Kconfig            |    1 +
 drivers/message/fusion/Kconfig |    1 +
 drivers/message/i2o/Kconfig    |    1 +
 6 files changed, 6 insertions(+)

diff -urpN linux-2.6/drivers/auxdisplay/Kconfig linux-2.6-patched/drivers/auxdisplay/Kconfig
--- linux-2.6/drivers/auxdisplay/Kconfig	2007-04-19 15:23:55.000000000 +0200
+++ linux-2.6-patched/drivers/auxdisplay/Kconfig	2007-04-19 15:49:17.000000000 +0200
@@ -6,6 +6,7 @@
 #
 
 menu "Auxiliary Display support"
+	depends on PARPORT_PC
 
 config KS0108
 	tristate "KS0108 LCD Controller"
diff -urpN linux-2.6/drivers/char/Kconfig linux-2.6-patched/drivers/char/Kconfig
--- linux-2.6/drivers/char/Kconfig	2007-04-19 15:24:32.000000000 +0200
+++ linux-2.6-patched/drivers/char/Kconfig	2007-04-19 15:49:17.000000000 +0200
@@ -867,6 +867,7 @@ config COBALT_LCD
 
 config DTLK
 	tristate "Double Talk PC internal speech card support"
+	depends on ISA
 	help
 	  This driver is for the DoubleTalk PC, a speech synthesizer
 	  manufactured by RC Systems (<http://www.rcsys.com/>).  It is also
diff -urpN linux-2.6/drivers/ieee1394/Kconfig linux-2.6-patched/drivers/ieee1394/Kconfig
--- linux-2.6/drivers/ieee1394/Kconfig	2007-04-19 15:24:33.000000000 +0200
+++ linux-2.6-patched/drivers/ieee1394/Kconfig	2007-04-19 15:49:17.000000000 +0200
@@ -1,6 +1,7 @@
 # -*- shell-script -*-
 
 menu "IEEE 1394 (FireWire) support"
+	depends on PCI || BROKEN
 
 source "drivers/firewire/Kconfig"
 
diff -urpN linux-2.6/drivers/kvm/Kconfig linux-2.6-patched/drivers/kvm/Kconfig
--- linux-2.6/drivers/kvm/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/kvm/Kconfig	2007-04-19 15:49:17.000000000 +0200
@@ -2,6 +2,7 @@
 # KVM configuration
 #
 menu "Virtualization"
+	depends on X86
 
 config KVM
 	tristate "Kernel-based Virtual Machine (KVM) support"
diff -urpN linux-2.6/drivers/message/fusion/Kconfig linux-2.6-patched/drivers/message/fusion/Kconfig
--- linux-2.6/drivers/message/fusion/Kconfig	2007-04-19 15:24:00.000000000 +0200
+++ linux-2.6-patched/drivers/message/fusion/Kconfig	2007-04-19 15:49:17.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "Fusion MPT device support"
+	depends on PCI
 
 config FUSION
 	bool
diff -urpN linux-2.6/drivers/message/i2o/Kconfig linux-2.6-patched/drivers/message/i2o/Kconfig
--- linux-2.6/drivers/message/i2o/Kconfig	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6-patched/drivers/message/i2o/Kconfig	2007-04-19 15:49:17.000000000 +0200
@@ -1,5 +1,6 @@
 
 menu "I2O device support"
+	depends on PCI
 
 config I2O
 	tristate "I2O support"
