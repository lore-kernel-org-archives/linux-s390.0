Return-Path: <linux-kernel-owner+w=401wt.eu-S1756487AbYGAMuP@vger.kernel.org>
Message-Id: <20080701124957.732938086@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/14] cio: Introduce abstract isc definitions.
Content-Disposition: inline; filename=121-cio-isc-defs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Replace the numeric values for I/O interruption subclass usage
with abstract definitions and collect them all in asm/isc.h.
This gives us a better overview of which iscs are actually used
and makes it possible to better spread out isc usage in the
future.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c    |   13 +++++++------
 drivers/s390/cio/css.c    |    4 +++-
 drivers/s390/cio/device.c |    3 ++-
 drivers/s390/cio/qdio.h   |    3 ++-
 include/asm-s390/isc.h    |   18 ++++++++++++++++++
 5 files changed, 32 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -24,6 +24,7 @@
 #include <asm/ipl.h>
 #include <asm/chpid.h>
 #include <asm/airq.h>
+#include <asm/isc.h>
 #include <asm/cpu.h>
 #include <asm/fcx.h>
 #include "cio.h"
@@ -699,9 +700,9 @@ void wait_cons_dev(void)
 	if (!console_subchannel_in_use)
 		return;
 
-	/* disable all but isc 1 (console device) */
+	/* disable all but the console isc */
 	__ctl_store (save_cr6, 6, 6);
-	cr6 = 0x40000000;
+	cr6 = 1UL << (31 - CONSOLE_ISC);
 	__ctl_load (cr6, 6, 6);
 
 	do {
@@ -783,10 +784,10 @@ cio_probe_console(void)
 	}
 
 	/*
-	 * enable console I/O-interrupt subclass 1
+	 * enable console I/O-interrupt subclass
 	 */
-	ctl_set_bit(6, 30);
-	console_subchannel.schib.pmcw.isc = 1;
+	ctl_set_bit(6, 31 - CONSOLE_ISC);
+	console_subchannel.schib.pmcw.isc = CONSOLE_ISC;
 	console_subchannel.schib.pmcw.intparm =
 		(u32)(addr_t)&console_subchannel;
 	ret = cio_modify(&console_subchannel);
@@ -802,7 +803,7 @@ cio_release_console(void)
 {
 	console_subchannel.schib.pmcw.intparm = 0;
 	cio_modify(&console_subchannel);
-	ctl_clear_bit(6, 30);
+	ctl_clear_bit(6, 31 - CONSOLE_ISC);
 	console_subchannel_in_use = 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -13,6 +13,7 @@
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/reboot.h>
+#include <asm/isc.h>
 
 #include "../s390mach.h"
 #include "css.h"
@@ -804,7 +805,8 @@ init_channel_subsystem (void)
 		goto out_pseudo;
 	css_init_done = 1;
 
-	ctl_set_bit(6, 28);
+	/* Enable default isc for I/O subchannels. */
+	ctl_set_bit(6, 31 - IO_SCH_ISC);
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -22,6 +22,7 @@
 #include <asm/cio.h>
 #include <asm/param.h>		/* HZ */
 #include <asm/cmb.h>
+#include <asm/isc.h>
 
 #include "chp.h"
 #include "cio.h"
@@ -1121,7 +1122,7 @@ static void io_subchannel_init_fields(st
 	else
 		sch->opm = chp_get_sch_opm(sch);
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
-	sch->isc = cio_is_console(sch->schid) ? 1 : 3;
+	sch->isc = cio_is_console(sch->schid) ? CONSOLE_ISC : IO_SCH_ISC;
 
 	CIO_MSG_EVENT(6, "Detected device %04x on subchannel 0.%x.%04X"
 		      " - PIM = %02X, PAM = %02X, POM = %02X\n",
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h
+++ quilt-2.6/drivers/s390/cio/qdio.h
@@ -2,6 +2,7 @@
 #define _CIO_QDIO_H
 
 #include <asm/page.h>
+#include <asm/isc.h>
 
 #include "schid.h"
 
@@ -26,7 +27,7 @@
  */
 #define IQDIO_FILL_LEVEL_TO_POLL 4
 
-#define TIQDIO_THININT_ISC 3
+#define TIQDIO_THININT_ISC QDIO_AIRQ_ISC
 #define TIQDIO_DELAY_TARGET 0
 #define QDIO_BUSY_BIT_PATIENCE 100 /* in microsecs */
 #define QDIO_BUSY_BIT_GIVE_UP 10000000 /* 10 seconds */
Index: quilt-2.6/include/asm-s390/isc.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/isc.h
@@ -0,0 +1,18 @@
+#ifndef _ASM_S390_ISC_H
+#define _ASM_S390_ISC_H
+
+/*
+ * I/O interruption subclasses used by drivers.
+ * Please add all used iscs here so that it is possible to distribute
+ * isc usage between drivers.
+ * Reminder: 0 is highest priority, 7 lowest.
+ */
+#define MAX_ISC 7
+
+/* Regular I/O interrupts. */
+#define IO_SCH_ISC 3			/* regular I/O subchannels */
+#define CONSOLE_ISC 1			/* console I/O subchannel */
+/* Adapter interrupts. */
+#define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
+
+#endif /* _ASM_S390_ISC_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
