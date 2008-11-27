Return-Path: <linux-kernel-owner+w=401wt.eu-S1754603AbYK0KfQ@vger.kernel.org>
Message-Id: <20081127103128.739679001@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:24 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/60] convert etr/stp to stop_machine interface
Content-Disposition: inline; filename=103-stop-machine-etr.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This converts the etr and stp code to the new stop_machine interface
which allows to synchronize all cpus without allocating any memory.
This way we get rid of the only reason why we haven't converted s390
to the generic IPI interface yet.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |  212 +++++++++++++++++++++++++++++-------------------
 1 file changed, 131 insertions(+), 81 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -20,6 +20,8 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/cpu.h>
+#include <linux/stop_machine.h>
 #include <linux/time.h>
 #include <linux/sysdev.h>
 #include <linux/delay.h>
@@ -391,6 +393,15 @@ static void enable_sync_clock(void)
 	atomic_set_mask(0x80000000, sw_ptr);
 }
 
+/* Single threaded workqueue used for etr and stp sync events */
+static struct workqueue_struct *time_sync_wq;
+
+static void __init time_init_wq(void)
+{
+	if (!time_sync_wq)
+		time_sync_wq = create_singlethread_workqueue("timesync");
+}
+
 /*
  * External Time Reference (ETR) code.
  */
@@ -483,17 +494,18 @@ static int __init etr_init(void)
 
 	if (!test_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags))
 		return 0;
+	time_init_wq();
 	/* Check if this machine has the steai instruction. */
 	if (etr_steai(&aib, ETR_STEAI_STEPPING_PORT) == 0)
 		etr_steai_available = 1;
 	setup_timer(&etr_timer, etr_timeout, 0UL);
 	if (etr_port0_online) {
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
-		schedule_work(&etr_work);
+		queue_work(time_sync_wq, &etr_work);
 	}
 	if (etr_port1_online) {
 		set_bit(ETR_EVENT_PORT1_CHANGE, &etr_events);
-		schedule_work(&etr_work);
+		queue_work(time_sync_wq, &etr_work);
 	}
 	return 0;
 }
@@ -520,7 +532,7 @@ void etr_switch_to_local(void)
 	if (test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
 		disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SWITCH_LOCAL, &etr_events);
-	schedule_work(&etr_work);
+	queue_work(time_sync_wq, &etr_work);
 }
 
 /*
@@ -536,7 +548,7 @@ void etr_sync_check(void)
 	if (test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
 		disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SYNC_CHECK, &etr_events);
-	schedule_work(&etr_work);
+	queue_work(time_sync_wq, &etr_work);
 }
 
 /*
@@ -560,13 +572,13 @@ static void etr_timing_alert(struct etr_
 		 * Both ports are not up-to-date now.
 		 */
 		set_bit(ETR_EVENT_PORT_ALERT, &etr_events);
-	schedule_work(&etr_work);
+	queue_work(time_sync_wq, &etr_work);
 }
 
 static void etr_timeout(unsigned long dummy)
 {
 	set_bit(ETR_EVENT_UPDATE, &etr_events);
-	schedule_work(&etr_work);
+	queue_work(time_sync_wq, &etr_work);
 }
 
 /*
@@ -673,14 +685,16 @@ static int etr_aib_follows(struct etr_ai
 }
 
 struct clock_sync_data {
+	atomic_t cpus;
 	int in_sync;
 	unsigned long long fixup_cc;
+	int etr_port;
+	struct etr_aib *etr_aib;
 };
 
-static void clock_sync_cpu_start(void *dummy)
+static void clock_sync_cpu(struct clock_sync_data *sync)
 {
-	struct clock_sync_data *sync = dummy;
-
+	atomic_dec(&sync->cpus);
 	enable_sync_clock();
 	/*
 	 * This looks like a busy wait loop but it isn't. etr_sync_cpus
@@ -706,39 +720,35 @@ static void clock_sync_cpu_start(void *d
 	fixup_clock_comparator(sync->fixup_cc);
 }
 
-static void clock_sync_cpu_end(void *dummy)
-{
-}
-
 /*
  * Sync the TOD clock using the port refered to by aibp. This port
  * has to be enabled and the other port has to be disabled. The
  * last eacr update has to be more than 1.6 seconds in the past.
  */
-static int etr_sync_clock(struct etr_aib *aib, int port)
+static int etr_sync_clock(void *data)
 {
-	struct etr_aib *sync_port;
-	struct clock_sync_data etr_sync;
+	static int first;
 	unsigned long long clock, old_clock, delay, delta;
-	int follows;
+	struct clock_sync_data *etr_sync;
+	struct etr_aib *sync_port, *aib;
+	int port;
 	int rc;
 
-	/* Check if the current aib is adjacent to the sync port aib. */
-	sync_port = (port == 0) ? &etr_port0 : &etr_port1;
-	follows = etr_aib_follows(sync_port, aib, port);
-	memcpy(sync_port, aib, sizeof(*aib));
-	if (!follows)
-		return -EAGAIN;
+	etr_sync = data;
 
-	/*
-	 * Catch all other cpus and make them wait until we have
-	 * successfully synced the clock. smp_call_function will
-	 * return after all other cpus are in etr_sync_cpu_start.
-	 */
-	memset(&etr_sync, 0, sizeof(etr_sync));
-	preempt_disable();
-	smp_call_function(clock_sync_cpu_start, &etr_sync, 0);
-	local_irq_disable();
+	if (xchg(&first, 1) == 1) {
+		/* Slave */
+		clock_sync_cpu(etr_sync);
+		return 0;
+	}
+
+	/* Wait until all other cpus entered the sync function. */
+	while (atomic_read(&etr_sync->cpus) != 0)
+		cpu_relax();
+
+	port = etr_sync->etr_port;
+	aib = etr_sync->etr_aib;
+	sync_port = (port == 0) ? &etr_port0 : &etr_port1;
 	enable_sync_clock();
 
 	/* Set clock to next OTE. */
@@ -755,16 +765,16 @@ static int etr_sync_clock(struct etr_aib
 		delay = (unsigned long long)
 			(aib->edf2.etv - sync_port->edf2.etv) << 32;
 		delta = adjust_time(old_clock, clock, delay);
-		etr_sync.fixup_cc = delta;
+		etr_sync->fixup_cc = delta;
 		fixup_clock_comparator(delta);
 		/* Verify that the clock is properly set. */
 		if (!etr_aib_follows(sync_port, aib, port)) {
 			/* Didn't work. */
 			disable_sync_clock(NULL);
-			etr_sync.in_sync = -EAGAIN;
+			etr_sync->in_sync = -EAGAIN;
 			rc = -EAGAIN;
 		} else {
-			etr_sync.in_sync = 1;
+			etr_sync->in_sync = 1;
 			rc = 0;
 		}
 	} else {
@@ -772,12 +782,33 @@ static int etr_sync_clock(struct etr_aib
 		__ctl_clear_bit(0, 29);
 		__ctl_clear_bit(14, 21);
 		disable_sync_clock(NULL);
-		etr_sync.in_sync = -EAGAIN;
+		etr_sync->in_sync = -EAGAIN;
 		rc = -EAGAIN;
 	}
-	local_irq_enable();
-	smp_call_function(clock_sync_cpu_end, NULL, 0);
-	preempt_enable();
+	xchg(&first, 0);
+	return rc;
+}
+
+static int etr_sync_clock_stop(struct etr_aib *aib, int port)
+{
+	struct clock_sync_data etr_sync;
+	struct etr_aib *sync_port;
+	int follows;
+	int rc;
+
+	/* Check if the current aib is adjacent to the sync port aib. */
+	sync_port = (port == 0) ? &etr_port0 : &etr_port1;
+	follows = etr_aib_follows(sync_port, aib, port);
+	memcpy(sync_port, aib, sizeof(*aib));
+	if (!follows)
+		return -EAGAIN;
+	memset(&etr_sync, 0, sizeof(etr_sync));
+	etr_sync.etr_aib = aib;
+	etr_sync.etr_port = port;
+	get_online_cpus();
+	atomic_set(&etr_sync.cpus, num_online_cpus() - 1);
+	rc = stop_machine(etr_sync_clock, &etr_sync, &cpu_online_map);
+	put_online_cpus();
 	return rc;
 }
 
@@ -934,7 +965,7 @@ static void etr_update_eacr(struct etr_e
 }
 
 /*
- * ETR tasklet. In this function you'll find the main logic. In
+ * ETR work. In this function you'll find the main logic. In
  * particular this is the only function that calls etr_update_eacr(),
  * it "controls" the etr control register.
  */
@@ -1067,7 +1098,7 @@ static void etr_work_fn(struct work_stru
 	etr_update_eacr(eacr);
 	set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	if (now < etr_tolec + (1600000 << 12) ||
-	    etr_sync_clock(&aib, sync_port) != 0) {
+	    etr_sync_clock_stop(&aib, sync_port) != 0) {
 		/* Sync failed. Try again in 1/2 second. */
 		eacr.es = 0;
 		etr_update_eacr(eacr);
@@ -1156,13 +1187,13 @@ static ssize_t etr_online_store(struct s
 			return count;	/* Nothing to do. */
 		etr_port0_online = value;
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
-		schedule_work(&etr_work);
+		queue_work(time_sync_wq, &etr_work);
 	} else {
 		if (etr_port1_online == value)
 			return count;	/* Nothing to do. */
 		etr_port1_online = value;
 		set_bit(ETR_EVENT_PORT1_CHANGE, &etr_events);
-		schedule_work(&etr_work);
+		queue_work(time_sync_wq, &etr_work);
 	}
 	return count;
 }
@@ -1396,8 +1427,12 @@ static void __init stp_reset(void)
 
 static int __init stp_init(void)
 {
-	if (test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags) && stp_online)
-		schedule_work(&stp_work);
+	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
+		return 0;
+	time_init_wq();
+	if (!stp_online)
+		return 0;
+	queue_work(time_sync_wq, &stp_work);
 	return 0;
 }
 
@@ -1414,7 +1449,7 @@ arch_initcall(stp_init);
 static void stp_timing_alert(struct stp_irq_parm *intparm)
 {
 	if (intparm->tsc || intparm->lac || intparm->tcpc)
-		schedule_work(&stp_work);
+		queue_work(time_sync_wq, &stp_work);
 }
 
 /*
@@ -1428,7 +1463,7 @@ void stp_sync_check(void)
 	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
 		return;
 	disable_sync_clock(NULL);
-	schedule_work(&stp_work);
+	queue_work(time_sync_wq, &stp_work);
 }
 
 /*
@@ -1442,46 +1477,34 @@ void stp_island_check(void)
 	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
 		return;
 	disable_sync_clock(NULL);
-	schedule_work(&stp_work);
+	queue_work(time_sync_wq, &stp_work);
 }
 
-/*
- * STP tasklet. Check for the STP state and take over the clock
- * synchronization if the STP clock source is usable.
- */
-static void stp_work_fn(struct work_struct *work)
+
+static int stp_sync_clock(void *data)
 {
-	struct clock_sync_data stp_sync;
+	static int first;
 	unsigned long long old_clock, delta;
+	struct clock_sync_data *stp_sync;
 	int rc;
 
-	if (!stp_online) {
-		chsc_sstpc(stp_page, STP_OP_CTRL, 0x0000);
-		return;
-	}
+	stp_sync = data;
 
-	rc = chsc_sstpc(stp_page, STP_OP_CTRL, 0xb0e0);
-	if (rc)
-		return;
+	if (xchg(&first, 1) == 1) {
+		/* Slave */
+		clock_sync_cpu(stp_sync);
+		return 0;
+	}
 
-	rc = chsc_sstpi(stp_page, &stp_info, sizeof(struct stp_sstpi));
-	if (rc || stp_info.c == 0)
-		return;
+	/* Wait until all other cpus entered the sync function. */
+	while (atomic_read(&stp_sync->cpus) != 0)
+		cpu_relax();
 
-	/*
-	 * Catch all other cpus and make them wait until we have
-	 * successfully synced the clock. smp_call_function will
-	 * return after all other cpus are in clock_sync_cpu_start.
-	 */
-	memset(&stp_sync, 0, sizeof(stp_sync));
-	preempt_disable();
-	smp_call_function(clock_sync_cpu_start, &stp_sync, 0);
-	local_irq_disable();
 	enable_sync_clock();
 
 	set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
 	if (test_and_clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
-		schedule_work(&etr_work);
+		queue_work(time_sync_wq, &etr_work);
 
 	rc = 0;
 	if (stp_info.todoff[0] || stp_info.todoff[1] ||
@@ -1500,16 +1523,43 @@ static void stp_work_fn(struct work_stru
 	}
 	if (rc) {
 		disable_sync_clock(NULL);
-		stp_sync.in_sync = -EAGAIN;
+		stp_sync->in_sync = -EAGAIN;
 		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
 		if (etr_port0_online || etr_port1_online)
-			schedule_work(&etr_work);
+			queue_work(time_sync_wq, &etr_work);
 	} else
-		stp_sync.in_sync = 1;
+		stp_sync->in_sync = 1;
+	xchg(&first, 0);
+	return 0;
+}
 
-	local_irq_enable();
-	smp_call_function(clock_sync_cpu_end, NULL, 0);
-	preempt_enable();
+/*
+ * STP work. Check for the STP state and take over the clock
+ * synchronization if the STP clock source is usable.
+ */
+static void stp_work_fn(struct work_struct *work)
+{
+	struct clock_sync_data stp_sync;
+	int rc;
+
+	if (!stp_online) {
+		chsc_sstpc(stp_page, STP_OP_CTRL, 0x0000);
+		return;
+	}
+
+	rc = chsc_sstpc(stp_page, STP_OP_CTRL, 0xb0e0);
+	if (rc)
+		return;
+
+	rc = chsc_sstpi(stp_page, &stp_info, sizeof(struct stp_sstpi));
+	if (rc || stp_info.c == 0)
+		return;
+
+	memset(&stp_sync, 0, sizeof(stp_sync));
+	get_online_cpus();
+	atomic_set(&stp_sync.cpus, num_online_cpus() - 1);
+	stop_machine(stp_sync_clock, &stp_sync, &cpu_online_map);
+	put_online_cpus();
 }
 
 /*
@@ -1618,7 +1668,7 @@ static ssize_t stp_online_store(struct s
 	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
 		return -EOPNOTSUPP;
 	stp_online = value;
-	schedule_work(&stp_work);
+	queue_work(time_sync_wq, &stp_work);
 	return count;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
