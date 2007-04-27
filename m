Return-Path: <linux-kernel-owner+w=401wt.eu-S1755941AbXD0OI3@vger.kernel.org>
Message-Id: <20070427140520.141259706@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:38 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 35/38] Switch etr from tasklet to workqueue.
Content-Disposition: inline; filename=138-etr-work.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The clock synchronization of the ETR code requires an smp_call_function
to synchronize all cpus. Calling smp_call_function from a tasklet is
illegal. Replace the tasklet with a job on the global workqueue.
ETR work is rare and can be postponed to a be done by a kernel thread.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/time.c	2007-04-27 16:05:01.000000000 +0200
@@ -280,7 +280,6 @@
 }
 
 static void etr_reset(void);
-static void etr_init(void);
 static void etr_ext_handler(__u16);
 
 /*
@@ -355,7 +354,6 @@
 #ifdef CONFIG_VIRT_TIMER
 	vtime_init();
 #endif
-	etr_init();
 }
 
 /*
@@ -426,11 +424,11 @@
 static int etr_port1_uptodate;
 static unsigned long etr_events;
 static struct timer_list etr_timer;
-static struct tasklet_struct etr_tasklet;
 static DEFINE_PER_CPU(atomic_t, etr_sync_word);
 
 static void etr_timeout(unsigned long dummy);
-static void etr_tasklet_fn(unsigned long dummy);
+static void etr_work_fn(struct work_struct *work);
+static DECLARE_WORK(etr_work, etr_work_fn);
 
 /*
  * The etr get_clock function. It will write the current clock value
@@ -507,29 +505,31 @@
 	}
 }
 
-static void etr_init(void)
+static int __init etr_init(void)
 {
 	struct etr_aib aib;
 
 	if (test_bit(ETR_FLAG_ENOSYS, &etr_flags))
-		return;
+		return 0;
 	/* Check if this machine has the steai instruction. */
 	if (etr_steai(&aib, ETR_STEAI_STEPPING_PORT) == 0)
 		set_bit(ETR_FLAG_STEAI, &etr_flags);
 	setup_timer(&etr_timer, etr_timeout, 0UL);
-	tasklet_init(&etr_tasklet, etr_tasklet_fn, 0);
 	if (!etr_port0_online && !etr_port1_online)
 		set_bit(ETR_FLAG_EACCES, &etr_flags);
 	if (etr_port0_online) {
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
-		tasklet_hi_schedule(&etr_tasklet);
+		schedule_work(&etr_work);
 	}
 	if (etr_port1_online) {
 		set_bit(ETR_EVENT_PORT1_CHANGE, &etr_events);
-		tasklet_hi_schedule(&etr_tasklet);
+		schedule_work(&etr_work);
 	}
+	return 0;
 }
 
+arch_initcall(etr_init);
+
 /*
  * Two sorts of ETR machine checks. The architecture reads:
  * "When a machine-check niterruption occurs and if a switch-to-local or
@@ -549,7 +549,7 @@
 		return;
 	etr_disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SWITCH_LOCAL, &etr_events);
-	tasklet_hi_schedule(&etr_tasklet);
+	schedule_work(&etr_work);
 }
 
 /*
@@ -564,7 +564,7 @@
 		return;
 	etr_disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SYNC_CHECK, &etr_events);
-	tasklet_hi_schedule(&etr_tasklet);
+	schedule_work(&etr_work);
 }
 
 /*
@@ -591,13 +591,13 @@
 		 * Both ports are not up-to-date now.
 		 */
 		set_bit(ETR_EVENT_PORT_ALERT, &etr_events);
-	tasklet_hi_schedule(&etr_tasklet);
+	schedule_work(&etr_work);
 }
 
 static void etr_timeout(unsigned long dummy)
 {
 	set_bit(ETR_EVENT_UPDATE, &etr_events);
-	tasklet_hi_schedule(&etr_tasklet);
+	schedule_work(&etr_work);
 }
 
 /*
@@ -927,7 +927,7 @@
 	if (!eacr.e0 && !eacr.e1)
 		return eacr;
 
-	/* Update port0 or port1 with aib stored in etr_tasklet_fn. */
+	/* Update port0 or port1 with aib stored in etr_work_fn. */
 	if (aib->esw.q == 0) {
 		/* Information for port 0 stored. */
 		if (eacr.p0 && !etr_port0_uptodate) {
@@ -1007,7 +1007,7 @@
  * particular this is the only function that calls etr_update_eacr(),
  * it "controls" the etr control register.
  */
-static void etr_tasklet_fn(unsigned long dummy)
+static void etr_work_fn(struct work_struct *work)
 {
 	unsigned long long now;
 	struct etr_eacr eacr;
@@ -1220,13 +1220,13 @@
 			return count;	/* Nothing to do. */
 		etr_port0_online = value;
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
-		tasklet_hi_schedule(&etr_tasklet);
+		schedule_work(&etr_work);
 	} else {
 		if (etr_port1_online == value)
 			return count;	/* Nothing to do. */
 		etr_port1_online = value;
 		set_bit(ETR_EVENT_PORT1_CHANGE, &etr_events);
-		tasklet_hi_schedule(&etr_tasklet);
+		schedule_work(&etr_work);
 	}
 	return count;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
