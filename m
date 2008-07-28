Return-Path: <linux-kernel-owner+w=401wt.eu-S1760685AbYG1R50@vger.kernel.org>
Message-Id: <20080728175512.897614814@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:54:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/15] kmsg: convert time printk messages to kmsg api.
Content-Disposition: inline; filename=809-kmsg-time.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/time |   39 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/time.c      |   14 +++++++++-----
 2 files changed, 48 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -41,6 +41,9 @@
 #include <asm/timer.h>
 #include <asm/etr.h>
 #include <asm/cio.h>
+#include <asm/kmsg.h>
+
+#define KMSG_COMPONENT "time"
 
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY     ((unsigned long) 1000000/HZ)
@@ -289,8 +292,8 @@ static unsigned long long adjust_time(un
 	}
 	jiffies_timer_cc += delta;
 	if (adjust.offset != 0) {
-		printk(KERN_NOTICE "etr: time adjusted by %li micro-seconds\n",
-		       adjust.offset);
+		kmsg_notice(1, "The ETR interface has adjusted the clock "
+			    "by %li microseconds\n", adjust.offset);
 		adjust.modes = ADJ_OFFSET_SINGLESHOT;
 		do_adjtimex(&adjust);
 	}
@@ -441,8 +444,8 @@ static void etr_reset(void)
 		etr_tolec = get_clock();
 		set_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags);
 	} else if (etr_port0_online || etr_port1_online) {
-		printk(KERN_WARNING "Running on non ETR capable "
-		       "machine, only local mode available.\n");
+		kmsg_warn(2, "The real or virtual hardware system does "
+			  "not provide an ETR interface\n");
 		etr_port0_online = etr_port1_online = 0;
 	}
 }
@@ -1357,7 +1360,8 @@ static void stp_reset(void)
 	if (rc == 1)
 		set_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags);
 	else if (stp_online) {
-		printk(KERN_WARNING "Running on non STP capable machine.\n");
+		kmsg_warn(3, "The real or virtual hardware system does "
+			  "not provide an STP interface\n");
 		free_bootmem((unsigned long) stp_page, PAGE_SIZE);
 		stp_page = NULL;
 		stp_online = 0;
Index: quilt-2.6/Documentation/s390/kmsg/time
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/time
@@ -0,0 +1,39 @@
+/*?
+ * Tag: time.1
+ * Text: "The ETR interface has adjusted the clock by %li microseconds"
+ * Severity: Notice
+ * Parameter:
+ *   @1: number of microseconds
+ * Description:
+ * The external time reference (ETR) interface has synchronized the system
+ * clock  with the external reference and set it to a new value. The time
+ * difference between the old and new clock value has been passed to the
+ * network time protocol (NTP) as a single shot adjustment.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: time.2
+ * Text: "The real or virtual hardware system does not provide an ETR interface"
+ * Severity: Warning
+ * Description:
+ * The 'etr=' parameter has been passed on the kernel parameter line for
+ * a Linux instance that does not have access to the external time reference
+ * (ETR) facility.
+ * User action:
+ * To avoid this warning remove the 'etr=' kernel parameter.
+ */
+
+/*?
+ * Tag: time.3
+ * Text: "The real or virtual hardware system does not provide an STP interface"
+ * Severity: Warning
+ * Description:
+ * The 'stp=' parameter has been passed on the kernel parameter line for
+ * a Linux instance that does not have access to the server time protocol
+ * (STP) facility.
+ * User action:
+ * To avoid this warning remove the 'stp=' kernel parameter.
+ */
+

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
