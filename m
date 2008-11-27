Return-Path: <linux-kernel-owner+w=401wt.eu-S1754952AbYK0KlG@vger.kernel.org>
Message-Id: <20081127103130.797148818@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:31 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/60] qdio: add eqbs/sqbs instruction counters
Content-Disposition: inline; filename=110-qdio-counters.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Add counters for the eqbs and sqbs instructions that indicate how often
we issued the instructions and how often the instructions returned with
less buffers than specified.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_main.c |    7 ++++++-
 drivers/s390/cio/qdio_perf.c |    6 ++++++
 drivers/s390/cio/qdio_perf.h |    4 ++++
 3 files changed, 16 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c
+++ quilt-2.6/drivers/s390/cio/qdio_main.c
@@ -129,6 +129,7 @@ static int qdio_do_eqbs(struct qdio_q *q
 	char dbf_text[15];
 
 	BUG_ON(!q->irq_ptr->sch_token);
+	qdio_perf_stat_inc(&perf_stats.debug_eqbs_all);
 
 	if (!q->is_input_q)
 		nr += q->irq_ptr->nr_input_qs;
@@ -139,8 +140,10 @@ again:
 	/* At least one buffer was processed, return and extract the remaining
 	 * buffers later.
 	 */
-	if ((ccq == 96) && (count != tmp_count))
+	if ((ccq == 96) && (count != tmp_count)) {
+		qdio_perf_stat_inc(&perf_stats.debug_eqbs_incomplete);
 		return (count - tmp_count);
+	}
 	if (rc == 1) {
 		QDIO_DBF_TEXT5(1, trace, "eqAGAIN");
 		goto again;
@@ -179,6 +182,7 @@ static int qdio_do_sqbs(struct qdio_q *q
 	char dbf_text[15];
 
 	BUG_ON(!q->irq_ptr->sch_token);
+	qdio_perf_stat_inc(&perf_stats.debug_sqbs_all);
 
 	if (!q->is_input_q)
 		nr += q->irq_ptr->nr_input_qs;
@@ -187,6 +191,7 @@ again:
 	rc = qdio_check_ccq(q, ccq);
 	if (rc == 1) {
 		QDIO_DBF_TEXT5(1, trace, "sqAGAIN");
+		qdio_perf_stat_inc(&perf_stats.debug_sqbs_incomplete);
 		goto again;
 	}
 	if (rc < 0) {
Index: quilt-2.6/drivers/s390/cio/qdio_perf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_perf.c
+++ quilt-2.6/drivers/s390/cio/qdio_perf.c
@@ -80,6 +80,12 @@ static int qdio_perf_proc_show(struct se
 		   (long)atomic_long_read(&perf_stats.debug_stop_polling));
 	seq_printf(m, "AI inbound tasklet loops after stop polling\t: %li\n",
 		   (long)atomic_long_read(&perf_stats.thinint_inbound_loop2));
+	seq_printf(m, "QEBSM EQBS total/incomplete\t\t\t: %li/%li\n",
+		   (long)atomic_long_read(&perf_stats.debug_eqbs_all),
+		   (long)atomic_long_read(&perf_stats.debug_eqbs_incomplete));
+	seq_printf(m, "QEBSM SQBS total/incomplete\t\t\t: %li/%li\n",
+		   (long)atomic_long_read(&perf_stats.debug_sqbs_all),
+		   (long)atomic_long_read(&perf_stats.debug_sqbs_incomplete));
 	seq_printf(m, "\n");
 	return 0;
 }
Index: quilt-2.6/drivers/s390/cio/qdio_perf.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_perf.h
+++ quilt-2.6/drivers/s390/cio/qdio_perf.h
@@ -40,6 +40,10 @@ struct qdio_perf_stats {
 	/* for debugging */
 	atomic_long_t debug_tl_out_timer;
 	atomic_long_t debug_stop_polling;
+	atomic_long_t debug_eqbs_all;
+	atomic_long_t debug_eqbs_incomplete;
+	atomic_long_t debug_sqbs_all;
+	atomic_long_t debug_sqbs_incomplete;
 };
 
 extern struct qdio_perf_stats perf_stats;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
