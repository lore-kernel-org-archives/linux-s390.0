Return-Path: <linux-kernel-owner+w=401wt.eu-S1031414AbXEDQxk@vger.kernel.org>
Message-Id: <20070504165241.845526167@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/9] qdio: make qdio statistics SMP-capable
Content-Disposition: inline; filename=004-qdio-stats.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ursula Braun <braunu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <braunu@de.ibm.com>

Use atomic_t/atomic64_t to make qdio performance statistics smp safe.
Remove temporarily calculation of "total time of inbound actions".

Signed-off-by: Ursula Braun <braunu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.c |  240 +++++++++++++++++++++++++++---------------------
 drivers/s390/cio/qdio.h |   50 +++++++---
 2 files changed, 173 insertions(+), 117 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/qdio.c	2007-05-04 18:50:15.000000000 +0200
@@ -69,7 +69,6 @@
 
 static int qdio_performance_stats = 0;
 static int proc_perf_file_registration;
-static unsigned long i_p_c, i_p_nc, o_p_c, o_p_nc, ii_p_c, ii_p_nc;
 static struct qdio_perf_stats perf_stats;
 
 static int hydra_thinints;
@@ -111,6 +110,31 @@
 }
 
 /***************** SCRUBBER HELPER ROUTINES **********************/
+#ifdef CONFIG_64BIT
+static inline void qdio_perf_stat_inc(atomic64_t *count)
+{
+	if (qdio_performance_stats)
+		atomic64_inc(count);
+}
+
+static inline void qdio_perf_stat_dec(atomic64_t *count)
+{
+	if (qdio_performance_stats)
+		atomic64_dec(count);
+}
+#else /* CONFIG_64BIT */
+static inline void qdio_perf_stat_inc(atomic_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_inc(count);
+}
+
+static inline void qdio_perf_stat_dec(atomic_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_dec(count);
+}
+#endif /* CONFIG_64BIT */
 
 static inline __u64 
 qdio_get_micros(void)
@@ -277,8 +301,7 @@
 	QDIO_DBF_TEXT4(0,trace,"sigasync");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	if (qdio_performance_stats)
-		perf_stats.siga_syncs++;
+	qdio_perf_stat_inc(&perf_stats.siga_syncs);
 
 	cc = do_siga_sync(q->schid, gpr2, gpr3);
 	if (cc)
@@ -323,8 +346,7 @@
 	__u32 busy_bit;
 	__u64 start_time=0;
 
-	if (qdio_performance_stats)
-		perf_stats.siga_outs++;
+	qdio_perf_stat_inc(&perf_stats.siga_outs);
 
 	QDIO_DBF_TEXT4(0,trace,"sigaout");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
@@ -358,8 +380,7 @@
 	QDIO_DBF_TEXT4(0,trace,"sigain");
 	QDIO_DBF_HEX4(0,trace,&q,sizeof(void*));
 
-	if (qdio_performance_stats)
-		perf_stats.siga_ins++;
+	qdio_perf_stat_inc(&perf_stats.siga_ins);
 
 	cc = do_siga_input(q->schid, q->mask);
 	
@@ -953,8 +974,7 @@
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			o_p_c++;
+		qdio_perf_stat_inc(&perf_stats.outbound_tl_runs_resched);
 		/* as we're sissies, we'll check next time */
 		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
@@ -962,10 +982,8 @@
 		}
 		return;
 	}
-	if (qdio_performance_stats) {
-		o_p_nc++;
-		perf_stats.tl_runs++;
-	}
+	qdio_perf_stat_inc(&perf_stats.outbound_tl_runs);
+	qdio_perf_stat_inc(&perf_stats.tl_runs);
 
 	/* see comment in qdio_kick_outbound_q */
 	siga_attempts=atomic_read(&q->busy_siga_counter);
@@ -1139,17 +1157,6 @@
 {
 	int i;
 
-	static int old_pcis=0;
-	static int old_thinints=0;
-
-	if (qdio_performance_stats) {
-		if ((old_pcis==perf_stats.pcis)&&
-		    (old_thinints==perf_stats.thinints))
-			perf_stats.start_time_inbound=NOW;
-		else
-			old_pcis=perf_stats.pcis;
-	}
-
 	i=qdio_get_inbound_buffer_frontier(q);
 	if ( (i!=GET_SAVED_FRONTIER(q)) ||
 	     (q->error_status_flags&QDIO_STATUS_LOOK_FOR_ERROR) ) {
@@ -1337,10 +1344,7 @@
 	q->siga_error=0;
 	q->error_status_flags=0;
 
-	if (qdio_performance_stats) {
-		perf_stats.inbound_time+=NOW-perf_stats.start_time_inbound;
-		perf_stats.inbound_cnt++;
-	}
+	qdio_perf_stat_inc(&perf_stats.inbound_cnt);
 }
 
 static void
@@ -1360,8 +1364,7 @@
 	 */
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			ii_p_c++;
+		qdio_perf_stat_inc(&perf_stats.inbound_thin_tl_runs_resched);
 		/* 
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
@@ -1369,8 +1372,7 @@
 		tiqdio_sched_tl();
 		return;
 	}
-	if (qdio_performance_stats)
-		ii_p_nc++;
+	qdio_perf_stat_inc(&perf_stats.inbound_thin_tl_runs);
 	if (unlikely(atomic_read(&q->is_in_shutdown))) {
 		qdio_unmark_q(q);
 		goto out;
@@ -1412,8 +1414,7 @@
 		for (i=0;i<irq_ptr->no_output_qs;i++) {
 			oq = irq_ptr->output_qs[i];
 			if (!qdio_is_outbound_q_done(oq)) {
-				if (qdio_performance_stats)
-					perf_stats.tl_runs--;
+				qdio_perf_stat_dec(&perf_stats.tl_runs);
 				__qdio_outbound_processing(oq);
 			}
 		}
@@ -1452,8 +1453,7 @@
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			i_p_c++;
+		qdio_perf_stat_inc(&perf_stats.inbound_tl_runs_resched);
 		/* as we're sissies, we'll check next time */
 		if (likely(!atomic_read(&q->is_in_shutdown))) {
 			qdio_mark_q(q);
@@ -1461,10 +1461,8 @@
 		}
 		return;
 	}
-	if (qdio_performance_stats) {
-		i_p_nc++;
-		perf_stats.tl_runs++;
-	}
+	qdio_perf_stat_inc(&perf_stats.inbound_tl_runs);
+	qdio_perf_stat_inc(&perf_stats.tl_runs);
 
 again:
 	if (qdio_has_inbound_q_moved(q)) {
@@ -1510,8 +1508,7 @@
 
 	if (unlikely(qdio_reserve_q(q))) {
 		qdio_release_q(q);
-		if (qdio_performance_stats)
-			ii_p_c++;
+		qdio_perf_stat_inc(&perf_stats.inbound_thin_tl_runs_resched);
 		/* 
 		 * as we might just be about to stop polling, we make
 		 * sure that we check again at least once more 
@@ -1602,8 +1599,7 @@
 {
 	QDIO_DBF_TEXT4(0,trace,"iqdio_tl");
 
-	if (qdio_performance_stats)
-		perf_stats.tl_runs++;
+	qdio_perf_stat_inc(&perf_stats.tl_runs);
 
 	tiqdio_inbound_checks();
 }
@@ -1914,10 +1910,7 @@
 {
 	QDIO_DBF_TEXT4(0,trace,"thin_int");
 
-	if (qdio_performance_stats) {
-		perf_stats.thinints++;
-		perf_stats.start_time_inbound=NOW;
-	}
+	qdio_perf_stat_inc(&perf_stats.thinints);
 
 	/* SVS only when needed:
 	 * issue SVS to benefit from iqdio interrupt avoidance
@@ -1972,17 +1965,12 @@
 	int i;
 	struct qdio_q *q;
 
-	if (qdio_performance_stats) {
-		perf_stats.pcis++;
-		perf_stats.start_time_inbound=NOW;
-	}
+	qdio_perf_stat_inc(&perf_stats.pcis);
 	for (i=0;i<irq_ptr->no_input_qs;i++) {
 		q=irq_ptr->input_qs[i];
 		if (q->is_input_q&QDIO_FLAG_NO_INPUT_INTERRUPT_CONTEXT)
 			qdio_mark_q(q);
 		else {
-			if (qdio_performance_stats)
-				perf_stats.tl_runs--;
 			__qdio_inbound_processing(q);
 		}
 	}
@@ -1992,8 +1980,7 @@
 		q=irq_ptr->output_qs[i];
 		if (qdio_is_outbound_q_done(q))
 			continue;
-		if (qdio_performance_stats)
-			perf_stats.tl_runs--;
+		qdio_perf_stat_dec(&perf_stats.tl_runs);
 		if (!irq_ptr->sync_done_on_outb_pcis)
 			SYNC_MEMORY;
 		__qdio_outbound_processing(q);
@@ -3463,18 +3450,12 @@
 	struct qdio_irq *irq = (struct qdio_irq *) q->irq_ptr;
 
 	/* This is the outbound handling of queues */
-	if (qdio_performance_stats)
-		perf_stats.start_time_outbound=NOW;
-
 	qdio_do_qdio_fill_output(q,qidx,count,buffers);
 
 	used_elements=atomic_add_return(count, &q->number_of_buffers_used) - count;
 
 	if (callflags&QDIO_FLAG_DONT_SIGA) {
-		if (qdio_performance_stats) {
-			perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
-			perf_stats.outbound_cnt++;
-		}
+		qdio_perf_stat_inc(&perf_stats.outbound_cnt);
 		return;
 	}
 	if (q->is_iqdio_q) {
@@ -3504,8 +3485,7 @@
 				qdio_kick_outbound_q(q);
 			} else {
 				QDIO_DBF_TEXT3(0,trace, "fast-req");
-				if (qdio_performance_stats)
-					perf_stats.fast_reqs++;
+				qdio_perf_stat_inc(&perf_stats.fast_reqs);
 			}
 		}
 		/* 
@@ -3516,10 +3496,7 @@
 		__qdio_outbound_processing(q);
 	}
 
-	if (qdio_performance_stats) {
-		perf_stats.outbound_time+=NOW-perf_stats.start_time_outbound;
-		perf_stats.outbound_cnt++;
-	}
+	qdio_perf_stat_inc(&perf_stats.outbound_cnt);
 }
 
 /* count must be 1 in iqdio */
@@ -3589,33 +3566,67 @@
 		return 0;
 
 #define _OUTP_IT(x...) c+=sprintf(buffer+c,x)
-	_OUTP_IT("i_p_nc/c=%lu/%lu\n",i_p_nc,i_p_c);
-	_OUTP_IT("ii_p_nc/c=%lu/%lu\n",ii_p_nc,ii_p_c);
-	_OUTP_IT("o_p_nc/c=%lu/%lu\n",o_p_nc,o_p_c);
-	_OUTP_IT("Number of tasklet runs (total)                  : %lu\n",
-		 perf_stats.tl_runs);
+#ifdef CONFIG_64BIT
+	_OUTP_IT("Number of tasklet runs (total)                  : %li\n",
+		 (long)atomic64_read(&perf_stats.tl_runs));
+	_OUTP_IT("Inbound tasklet runs      tried/retried         : %li/%li\n",
+		 (long)atomic64_read(&perf_stats.inbound_tl_runs),
+		 (long)atomic64_read(&perf_stats.inbound_tl_runs_resched));
+	_OUTP_IT("Inbound-thin tasklet runs tried/retried         : %li/%li\n",
+		 (long)atomic64_read(&perf_stats.inbound_thin_tl_runs),
+		 (long)atomic64_read(&perf_stats.inbound_thin_tl_runs_resched));
+	_OUTP_IT("Outbound tasklet runs     tried/retried         : %li/%li\n",
+		 (long)atomic64_read(&perf_stats.outbound_tl_runs),
+		 (long)atomic64_read(&perf_stats.outbound_tl_runs_resched));
 	_OUTP_IT("\n");
-	_OUTP_IT("Number of SIGA sync's issued                    : %lu\n",
-		 perf_stats.siga_syncs);
-	_OUTP_IT("Number of SIGA in's issued                      : %lu\n",
-		 perf_stats.siga_ins);
-	_OUTP_IT("Number of SIGA out's issued                     : %lu\n",
-		 perf_stats.siga_outs);
-	_OUTP_IT("Number of PCIs caught                           : %lu\n",
-		 perf_stats.pcis);
-	_OUTP_IT("Number of adapter interrupts caught             : %lu\n",
-		 perf_stats.thinints);
-	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %lu\n",
-		 perf_stats.fast_reqs);
+	_OUTP_IT("Number of SIGA sync's issued                    : %li\n",
+		 (long)atomic64_read(&perf_stats.siga_syncs));
+	_OUTP_IT("Number of SIGA in's issued                      : %li\n",
+		 (long)atomic64_read(&perf_stats.siga_ins));
+	_OUTP_IT("Number of SIGA out's issued                     : %li\n",
+		 (long)atomic64_read(&perf_stats.siga_outs));
+	_OUTP_IT("Number of PCIs caught                           : %li\n",
+		 (long)atomic64_read(&perf_stats.pcis));
+	_OUTP_IT("Number of adapter interrupts caught             : %li\n",
+		 (long)atomic64_read(&perf_stats.thinints));
+	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %li\n",
+		 (long)atomic64_read(&perf_stats.fast_reqs));
 	_OUTP_IT("\n");
-	_OUTP_IT("Total time of all inbound actions (us) incl. UL : %lu\n",
-		 perf_stats.inbound_time);
-	_OUTP_IT("Number of inbound transfers                     : %lu\n",
-		 perf_stats.inbound_cnt);
-	_OUTP_IT("Total time of all outbound do_QDIOs (us)        : %lu\n",
-		 perf_stats.outbound_time);
-	_OUTP_IT("Number of do_QDIOs outbound                     : %lu\n",
-		 perf_stats.outbound_cnt);
+	_OUTP_IT("Number of inbound transfers                     : %li\n",
+		 (long)atomic64_read(&perf_stats.inbound_cnt));
+	_OUTP_IT("Number of do_QDIOs outbound                     : %li\n",
+		 (long)atomic64_read(&perf_stats.outbound_cnt));
+#else /* CONFIG_64BIT */
+	_OUTP_IT("Number of tasklet runs (total)                  : %i\n",
+		 atomic_read(&perf_stats.tl_runs));
+	_OUTP_IT("Inbound tasklet runs      tried/retried         : %i/%i\n",
+		 atomic_read(&perf_stats.inbound_tl_runs),
+		 atomic_read(&perf_stats.inbound_tl_runs_resched));
+	_OUTP_IT("Inbound-thin tasklet runs tried/retried         : %i/%i\n",
+		 atomic_read(&perf_stats.inbound_thin_tl_runs),
+		 atomic_read(&perf_stats.inbound_thin_tl_runs_resched));
+	_OUTP_IT("Outbound tasklet runs     tried/retried         : %i/%i\n",
+		 atomic_read(&perf_stats.outbound_tl_runs),
+		 atomic_read(&perf_stats.outbound_tl_runs_resched));
+	_OUTP_IT("\n");
+	_OUTP_IT("Number of SIGA sync's issued                    : %i\n",
+		 atomic_read(&perf_stats.siga_syncs));
+	_OUTP_IT("Number of SIGA in's issued                      : %i\n",
+		 atomic_read(&perf_stats.siga_ins));
+	_OUTP_IT("Number of SIGA out's issued                     : %i\n",
+		 atomic_read(&perf_stats.siga_outs));
+	_OUTP_IT("Number of PCIs caught                           : %i\n",
+		 atomic_read(&perf_stats.pcis));
+	_OUTP_IT("Number of adapter interrupts caught             : %i\n",
+		 atomic_read(&perf_stats.thinints));
+	_OUTP_IT("Number of fast requeues (outg. SBALs w/o SIGA)  : %i\n",
+		 atomic_read(&perf_stats.fast_reqs));
+	_OUTP_IT("\n");
+	_OUTP_IT("Number of inbound transfers                     : %i\n",
+		 atomic_read(&perf_stats.inbound_cnt));
+	_OUTP_IT("Number of do_QDIOs outbound                     : %i\n",
+		 atomic_read(&perf_stats.outbound_cnt));
+#endif /* CONFIG_64BIT */
 	_OUTP_IT("\n");
 
         return c;
@@ -3642,8 +3653,6 @@
 static void
 qdio_remove_procfs_entry(void)
 {
-	perf_stats.tl_runs=0;
-
         if (!proc_perf_file_registration) /* means if it went ok earlier */
 		remove_proc_entry(QDIO_PERF,&proc_root);
 }
@@ -3671,13 +3680,38 @@
 		qdio_performance_stats = i;
 		if (i==0) {
 			/* reset perf. stat. info */
-			i_p_nc = 0;
-			i_p_c = 0;
-			ii_p_nc = 0;
-			ii_p_c = 0;
-			o_p_nc = 0;
-			o_p_c = 0;
-			memset(&perf_stats, 0, sizeof(struct qdio_perf_stats));
+#ifdef CONFIG_64BIT
+			atomic64_set(&perf_stats.tl_runs, 0);
+			atomic64_set(&perf_stats.outbound_tl_runs, 0);
+			atomic64_set(&perf_stats.inbound_tl_runs, 0);
+			atomic64_set(&perf_stats.inbound_tl_runs_resched, 0);
+			atomic64_set(&perf_stats.inbound_thin_tl_runs, 0);
+			atomic64_set(&perf_stats.inbound_thin_tl_runs_resched,
+				     0);
+			atomic64_set(&perf_stats.siga_outs, 0);
+			atomic64_set(&perf_stats.siga_ins, 0);
+			atomic64_set(&perf_stats.siga_syncs, 0);
+			atomic64_set(&perf_stats.pcis, 0);
+			atomic64_set(&perf_stats.thinints, 0);
+			atomic64_set(&perf_stats.fast_reqs, 0);
+			atomic64_set(&perf_stats.outbound_cnt, 0);
+			atomic64_set(&perf_stats.inbound_cnt, 0);
+#else /* CONFIG_64BIT */
+			atomic_set(&perf_stats.tl_runs, 0);
+			atomic_set(&perf_stats.outbound_tl_runs, 0);
+			atomic_set(&perf_stats.inbound_tl_runs, 0);
+			atomic_set(&perf_stats.inbound_tl_runs_resched, 0);
+			atomic_set(&perf_stats.inbound_thin_tl_runs, 0);
+			atomic_set(&perf_stats.inbound_thin_tl_runs_resched, 0);
+			atomic_set(&perf_stats.siga_outs, 0);
+			atomic_set(&perf_stats.siga_ins, 0);
+			atomic_set(&perf_stats.siga_syncs, 0);
+			atomic_set(&perf_stats.pcis, 0);
+			atomic_set(&perf_stats.thinints, 0);
+			atomic_set(&perf_stats.fast_reqs, 0);
+			atomic_set(&perf_stats.outbound_cnt, 0);
+			atomic_set(&perf_stats.inbound_cnt, 0);
+#endif /* CONFIG_64BIT */
 		}
 	} else {
 		QDIO_PRINT_WARN("QDIO performance_stats: write 0 or 1 to this file!\n");
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/qdio.h	2007-05-04 18:50:15.000000000 +0200
@@ -406,21 +406,43 @@
 #define CHSC_FLAG_SIGA_SYNC_DONE_ON_OUTB_PCIS 0x04
 
 struct qdio_perf_stats {
-	unsigned long tl_runs;
+#ifdef CONFIG_64BIT
+	atomic64_t tl_runs;
+	atomic64_t outbound_tl_runs;
+	atomic64_t outbound_tl_runs_resched;
+	atomic64_t inbound_tl_runs;
+	atomic64_t inbound_tl_runs_resched;
+	atomic64_t inbound_thin_tl_runs;
+	atomic64_t inbound_thin_tl_runs_resched;
+
+	atomic64_t siga_outs;
+	atomic64_t siga_ins;
+	atomic64_t siga_syncs;
+	atomic64_t pcis;
+	atomic64_t thinints;
+	atomic64_t fast_reqs;
+
+	atomic64_t outbound_cnt;
+	atomic64_t inbound_cnt;
+#else /* CONFIG_64BIT */
+	atomic_t tl_runs;
+	atomic_t outbound_tl_runs;
+	atomic_t outbound_tl_runs_resched;
+	atomic_t inbound_tl_runs;
+	atomic_t inbound_tl_runs_resched;
+	atomic_t inbound_thin_tl_runs;
+	atomic_t inbound_thin_tl_runs_resched;
+
+	atomic_t siga_outs;
+	atomic_t siga_ins;
+	atomic_t siga_syncs;
+	atomic_t pcis;
+	atomic_t thinints;
+	atomic_t fast_reqs;
 
-	unsigned long siga_outs;
-	unsigned long siga_ins;
-	unsigned long siga_syncs;
-	unsigned long pcis;
-	unsigned long thinints;
-	unsigned long fast_reqs;
-
-	__u64 start_time_outbound;
-	unsigned long outbound_cnt;
-	unsigned long outbound_time;
-	__u64 start_time_inbound;
-	unsigned long inbound_cnt;
-	unsigned long inbound_time;
+	atomic_t outbound_cnt;
+	atomic_t inbound_cnt;
+#endif /* CONFIG_64BIT */
 };
 
 /* unlikely as the later the better */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
