Return-Path: <linux-kernel-owner+w=401wt.eu-S1763947AbZBYPUj@vger.kernel.org>
Message-Id: <20090225150835.829559275@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 31/46] clock sync mode flags
Content-Disposition: inline; filename=130-stp-hang.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The clock sync mode flag CLOCK_SYNC_STP is not cleared when stp
is set offline. In this case the get_sync_clock() function returns
-EACCESS and the dasd driver will block all i/o until stp is enabled
again. In addition get_sync_clock can return -EACCESS if the clock is
not in sync instead of -EAGAIN.

Rework the stp/etr online handling to fix these problems.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |   71 +++++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 27 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -331,6 +331,7 @@ static unsigned long long adjust_time(un
 }
 
 static DEFINE_PER_CPU(atomic_t, clock_sync_word);
+static DEFINE_MUTEX(clock_sync_mutex);
 static unsigned long clock_sync_flags;
 
 #define CLOCK_SYNC_HAS_ETR	0
@@ -394,6 +395,20 @@ static void enable_sync_clock(void)
 	atomic_set_mask(0x80000000, sw_ptr);
 }
 
+/*
+ * Function to check if the clock is in sync.
+ */
+static inline int check_sync_clock(void)
+{
+	atomic_t *sw_ptr;
+	int rc;
+
+	sw_ptr = &get_cpu_var(clock_sync_word);
+	rc = (atomic_read(sw_ptr) & 0x80000000U) != 0;
+	put_cpu_var(clock_sync_sync);
+	return rc;
+}
+
 /* Single threaded workqueue used for etr and stp sync events */
 static struct workqueue_struct *time_sync_wq;
 
@@ -485,6 +500,8 @@ static void etr_reset(void)
 	if (etr_setr(&etr_eacr) == 0) {
 		etr_tolec = get_clock();
 		set_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags);
+		if (etr_port0_online && etr_port1_online)
+			set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	} else if (etr_port0_online || etr_port1_online) {
 		pr_warning("The real or virtual hardware system does "
 			   "not provide an ETR interface\n");
@@ -533,8 +550,7 @@ void etr_switch_to_local(void)
 {
 	if (!etr_eacr.sl)
 		return;
-	if (test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
-		disable_sync_clock(NULL);
+	disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SWITCH_LOCAL, &etr_events);
 	queue_work(time_sync_wq, &etr_work);
 }
@@ -549,8 +565,7 @@ void etr_sync_check(void)
 {
 	if (!etr_eacr.es)
 		return;
-	if (test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
-		disable_sync_clock(NULL);
+	disable_sync_clock(NULL);
 	set_bit(ETR_EVENT_SYNC_CHECK, &etr_events);
 	queue_work(time_sync_wq, &etr_work);
 }
@@ -914,7 +929,7 @@ static struct etr_eacr etr_handle_update
 	 * Do not try to get the alternate port aib if the clock
 	 * is not in sync yet.
 	 */
-	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags) && !eacr.es)
+	if (!check_sync_clock())
 		return eacr;
 
 	/*
@@ -997,7 +1012,6 @@ static void etr_work_fn(struct work_stru
 		on_each_cpu(disable_sync_clock, NULL, 1);
 		del_timer_sync(&etr_timer);
 		etr_update_eacr(eacr);
-		clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 		goto out_unlock;
 	}
 
@@ -1071,18 +1085,13 @@ static void etr_work_fn(struct work_stru
 		/* Both ports not usable. */
 		eacr.es = eacr.sl = 0;
 		sync_port = -1;
-		clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	}
 
-	if (!test_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
-		eacr.es = 0;
-
 	/*
 	 * If the clock is in sync just update the eacr and return.
 	 * If there is no valid sync port wait for a port update.
 	 */
-	if (test_bit(CLOCK_SYNC_STP, &clock_sync_flags) ||
-	    eacr.es || sync_port < 0) {
+	if (check_sync_clock() || sync_port < 0) {
 		etr_update_eacr(eacr);
 		etr_set_tolec_timeout(now);
 		goto out_unlock;
@@ -1103,13 +1112,11 @@ static void etr_work_fn(struct work_stru
 	 * and set up a timer to try again after 0.5 seconds
 	 */
 	etr_update_eacr(eacr);
-	set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 	if (now < etr_tolec + (1600000 << 12) ||
 	    etr_sync_clock_stop(&aib, sync_port) != 0) {
 		/* Sync failed. Try again in 1/2 second. */
 		eacr.es = 0;
 		etr_update_eacr(eacr);
-		clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 		etr_set_sync_timeout();
 	} else
 		etr_set_tolec_timeout(now);
@@ -1191,19 +1198,30 @@ static ssize_t etr_online_store(struct s
 		return -EINVAL;
 	if (!test_bit(CLOCK_SYNC_HAS_ETR, &clock_sync_flags))
 		return -EOPNOTSUPP;
+	mutex_lock(&clock_sync_mutex);
 	if (dev == &etr_port0_dev) {
 		if (etr_port0_online == value)
-			return count;	/* Nothing to do. */
+			goto out;	/* Nothing to do. */
 		etr_port0_online = value;
+		if (etr_port0_online && etr_port1_online)
+			set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
+		else
+			clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 		set_bit(ETR_EVENT_PORT0_CHANGE, &etr_events);
 		queue_work(time_sync_wq, &etr_work);
 	} else {
 		if (etr_port1_online == value)
-			return count;	/* Nothing to do. */
+			goto out;	/* Nothing to do. */
 		etr_port1_online = value;
+		if (etr_port0_online && etr_port1_online)
+			set_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
+		else
+			clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags);
 		set_bit(ETR_EVENT_PORT1_CHANGE, &etr_events);
 		queue_work(time_sync_wq, &etr_work);
 	}
+out:
+	mutex_unlock(&clock_sync_mutex);
 	return count;
 }
 
@@ -1471,8 +1489,6 @@ static void stp_timing_alert(struct stp_
  */
 void stp_sync_check(void)
 {
-	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
-		return;
 	disable_sync_clock(NULL);
 	queue_work(time_sync_wq, &stp_work);
 }
@@ -1485,8 +1501,6 @@ void stp_sync_check(void)
  */
 void stp_island_check(void)
 {
-	if (!test_bit(CLOCK_SYNC_STP, &clock_sync_flags))
-		return;
 	disable_sync_clock(NULL);
 	queue_work(time_sync_wq, &stp_work);
 }
@@ -1513,10 +1527,6 @@ static int stp_sync_clock(void *data)
 
 	enable_sync_clock();
 
-	set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
-	if (test_and_clear_bit(CLOCK_SYNC_ETR, &clock_sync_flags))
-		queue_work(time_sync_wq, &etr_work);
-
 	rc = 0;
 	if (stp_info.todoff[0] || stp_info.todoff[1] ||
 	    stp_info.todoff[2] || stp_info.todoff[3] ||
@@ -1535,9 +1545,6 @@ static int stp_sync_clock(void *data)
 	if (rc) {
 		disable_sync_clock(NULL);
 		stp_sync->in_sync = -EAGAIN;
-		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
-		if (etr_port0_online || etr_port1_online)
-			queue_work(time_sync_wq, &etr_work);
 	} else
 		stp_sync->in_sync = 1;
 	xchg(&first, 0);
@@ -1569,6 +1576,10 @@ static void stp_work_fn(struct work_stru
 	if (rc || stp_info.c == 0)
 		goto out_unlock;
 
+	/* Skip synchronization if the clock is already in sync. */
+	if (check_sync_clock())
+		goto out_unlock;
+
 	memset(&stp_sync, 0, sizeof(stp_sync));
 	get_online_cpus();
 	atomic_set(&stp_sync.cpus, num_online_cpus() - 1);
@@ -1684,8 +1695,14 @@ static ssize_t stp_online_store(struct s
 		return -EINVAL;
 	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
 		return -EOPNOTSUPP;
+	mutex_lock(&clock_sync_mutex);
 	stp_online = value;
+	if (stp_online)
+		set_bit(CLOCK_SYNC_STP, &clock_sync_flags);
+	else
+		clear_bit(CLOCK_SYNC_STP, &clock_sync_flags);
 	queue_work(time_sync_wq, &stp_work);
+	mutex_unlock(&clock_sync_mutex);
 	return count;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
