Return-Path: <linux-kernel-owner+w=401wt.eu-S1755522AbYK0KqP@vger.kernel.org>
Message-Id: <20081127103139.535319378@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:02 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 42/60] convert time printks to pr_xxx macros.
Content-Disposition: inline; filename=157-kmsg-time.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -12,6 +12,9 @@
  *    Copyright (C) 1991, 1992, 1995  Linus Torvalds
  */
 
+#define KMSG_COMPONENT "time"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/sched.h>
@@ -321,8 +324,8 @@ static unsigned long long adjust_time(un
 	}
 	sched_clock_base_cc += delta;
 	if (adjust.offset != 0) {
-		printk(KERN_NOTICE "etr: time adjusted by %li micro-seconds\n",
-		       adjust.offset);
+		pr_notice("The ETR interface has adjusted the clock "
+			  "by %li microseconds\n", adjust.offset);
 		adjust.modes = ADJ_OFFSET_SINGLESHOT;
 		do_adjtimex(&adjust);
 	}
@@ -483,8 +486,8 @@ static void etr_reset(void)
 		etr_tolec = get_clock();
 		set_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags);
 	} else if (etr_port0_online || etr_port1_online) {
-		printk(KERN_WARNING "Running on non ETR capable "
-		       "machine, only local mode available.\n");
+		pr_warning("The real or virtual hardware system does "
+			   "not provide an ETR interface\n");
 		etr_port0_online = etr_port1_online = 0;
 	}
 }
@@ -1425,7 +1428,8 @@ static void __init stp_reset(void)
 	if (rc == 0)
 		set_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags);
 	else if (stp_online) {
-		printk(KERN_WARNING "Running on non STP capable machine.\n");
+		pr_warning("The real or virtual hardware system does "
+			   "not provide an STP interface\n");
 		free_bootmem((unsigned long) stp_page, PAGE_SIZE);
 		stp_page = NULL;
 		stp_online = 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
