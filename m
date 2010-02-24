Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084449.264862886@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:41 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/32] [PATCH] qdio: account processed SBAL during queue scan
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=110-qdio-account-sbal.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

Add counters for the number of processed SBALs. The numbers summarize
how many SBALs were processed at each queue scan and indicate the
utilization of the queue. Furthermore the number of unsuccessfull
queue scans, SBAL errors and the total number of processed
SBALs are accounted.

Also regroup struct qdio_q to move read-mostly and write-mostly data
into different cachelines.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio.h       |   85 ++++++++++++++++++++++++++----------------
 drivers/s390/cio/qdio_debug.c |   23 ++++++++++-
 drivers/s390/cio/qdio_main.c  |   26 ++++++++++++
 3 files changed, 101 insertions(+), 33 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_debug.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_debug.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/qdio_debug.c	2010-02-24 09:44:25.000000000 +0100
@@ -60,7 +60,7 @@
 	seq_printf(m, "ftc: %d  last_move: %d\n", q->first_to_check, q->last_move);
 	seq_printf(m, "polling: %d  ack start: %d  ack count: %d\n",
 		   q->u.in.polling, q->u.in.ack_start, q->u.in.ack_count);
-	seq_printf(m, "slsb buffer states:\n");
+	seq_printf(m, "SBAL states:\n");
 	seq_printf(m, "|0      |8      |16     |24     |32     |40     |48     |56  63|\n");
 
 	for (i = 0; i < QDIO_MAX_BUFFERS_PER_Q; i++) {
@@ -97,6 +97,20 @@
 	}
 	seq_printf(m, "\n");
 	seq_printf(m, "|64     |72     |80     |88     |96     |104    |112    |   127|\n");
+
+	seq_printf(m, "\nSBAL statistics:");
+	if (!q->irq_ptr->perf_stat_enabled) {
+		seq_printf(m, " disabled\n");
+		return 0;
+	}
+
+	seq_printf(m, "\n1          2..        4..        8..        "
+		   "16..       32..       64..       127\n");
+	for (i = 0; i < ARRAY_SIZE(q->q_stats.nr_sbals); i++)
+		seq_printf(m, "%-10u ", q->q_stats.nr_sbals[i]);
+	seq_printf(m, "\nError      NOP        Total\n%-10u %-10u %-10u\n\n",
+		   q->q_stats.nr_sbal_error, q->q_stats.nr_sbal_nop,
+		   q->q_stats.nr_sbal_total);
 	return 0;
 }
 
@@ -181,9 +195,10 @@
 {
 	struct seq_file *seq = file->private_data;
 	struct qdio_irq *irq_ptr = seq->private;
+	struct qdio_q *q;
 	unsigned long val;
 	char buf[8];
-	int ret;
+	int ret, i;
 
 	if (!irq_ptr)
 		return 0;
@@ -201,6 +216,10 @@
 	case 0:
 		irq_ptr->perf_stat_enabled = 0;
 		memset(&irq_ptr->perf_stat, 0, sizeof(irq_ptr->perf_stat));
+		for_each_input_queue(irq_ptr, q, i)
+			memset(&q->q_stats, 0, sizeof(q->q_stats));
+		for_each_output_queue(irq_ptr, q, i)
+			memset(&q->q_stats, 0, sizeof(q->q_stats));
 		break;
 	case 1:
 		irq_ptr->perf_stat_enabled = 1;
Index: quilt-2.6/drivers/s390/cio/qdio.h
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/qdio.h	2010-02-24 09:44:25.000000000 +0100
@@ -210,16 +210,25 @@
 	unsigned int sqbs_partial;
 };
 
+struct qdio_queue_perf_stat {
+	/*
+	 * Sorted into order-2 buckets: 1, 2-3, 4-7, ... 64-127, 128.
+	 * Since max. 127 SBALs are scanned reuse entry for 128 as queue full
+	 * aka 127 SBALs found.
+	 */
+	unsigned int nr_sbals[8];
+	unsigned int nr_sbal_error;
+	unsigned int nr_sbal_nop;
+	unsigned int nr_sbal_total;
+};
+
 struct qdio_input_q {
 	/* input buffer acknowledgement flag */
 	int polling;
-
 	/* first ACK'ed buffer */
 	int ack_start;
-
 	/* how much sbals are acknowledged with qebsm */
 	int ack_count;
-
 	/* last time of noticing incoming data */
 	u64 timestamp;
 };
@@ -227,40 +236,27 @@
 struct qdio_output_q {
 	/* PCIs are enabled for the queue */
 	int pci_out_enabled;
-
 	/* IQDIO: output multiple buffers (enhanced SIGA) */
 	int use_enh_siga;
-
 	/* timer to check for more outbound work */
 	struct timer_list timer;
 };
 
+/*
+ * Note on cache alignment: grouped slsb and write mostly data at the beginning
+ * sbal[] is read-only and starts on a new cacheline followed by read mostly.
+ */
 struct qdio_q {
 	struct slsb slsb;
+
 	union {
 		struct qdio_input_q in;
 		struct qdio_output_q out;
 	} u;
 
-	/* queue number */
-	int nr;
-
-	/* bitmask of queue number */
-	int mask;
-
-	/* input or output queue */
-	int is_input_q;
-
-	/* list of thinint input queues */
-	struct list_head entry;
-
-	/* upper-layer program handler */
-	qdio_handler_t (*handler);
-
 	/*
 	 * inbound: next buffer the program should check for
-	 * outbound: next buffer to check for having been processed
-	 * by the card
+	 * outbound: next buffer to check if adapter processed it
 	 */
 	int first_to_check;
 
@@ -273,16 +269,32 @@
 	/* number of buffers in use by the adapter */
 	atomic_t nr_buf_used;
 
-	struct qdio_irq *irq_ptr;
-	struct dentry *debugfs_q;
-	struct tasklet_struct tasklet;
-
 	/* error condition during a data transfer */
 	unsigned int qdio_error;
 
-	struct sl *sl;
-	struct qdio_buffer *sbal[QDIO_MAX_BUFFERS_PER_Q];
+	struct tasklet_struct tasklet;
+	struct qdio_queue_perf_stat q_stats;
+
+	struct qdio_buffer *sbal[QDIO_MAX_BUFFERS_PER_Q] ____cacheline_aligned;
 
+	/* queue number */
+	int nr;
+
+	/* bitmask of queue number */
+	int mask;
+
+	/* input or output queue */
+	int is_input_q;
+
+	/* list of thinint input queues */
+	struct list_head entry;
+
+	/* upper-layer program handler */
+	qdio_handler_t (*handler);
+
+	struct dentry *debugfs_q;
+	struct qdio_irq *irq_ptr;
+	struct sl *sl;
 	/*
 	 * Warning: Leave this member at the end so it won't be cleared in
 	 * qdio_fill_qs. A page is allocated under this pointer and used for
@@ -341,9 +353,20 @@
 	(irq->qib.qfmt == QDIO_IQDIO_QFMT || \
 	 css_general_characteristics.aif_osa)
 
-#define qperf(qdev,attr)	qdev->perf_stat.attr
-#define qperf_inc(q,attr)	if (q->irq_ptr->perf_stat_enabled) \
-					q->irq_ptr->perf_stat.attr++
+#define qperf(__qdev, __attr)	((__qdev)->perf_stat.(__attr))
+
+#define qperf_inc(__q, __attr)						\
+({									\
+	struct qdio_irq *qdev = (__q)->irq_ptr;				\
+	if (qdev->perf_stat_enabled)					\
+		(qdev->perf_stat.__attr)++;				\
+})
+
+static inline void account_sbals_error(struct qdio_q *q, int count)
+{
+	q->q_stats.nr_sbal_error += count;
+	q->q_stats.nr_sbal_total += count;
+}
 
 /* the highest iqdio queue is used for multicast */
 static inline int multicast_outbound(struct qdio_q *q)
Index: quilt-2.6/drivers/s390/cio/qdio_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_main.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/qdio_main.c	2010-02-24 09:44:25.000000000 +0100
@@ -392,6 +392,20 @@
 		set_buf_state(q, q->u.in.ack_start, SLSB_P_INPUT_NOT_INIT);
 }
 
+static inline void account_sbals(struct qdio_q *q, int count)
+{
+	int pos = 0;
+
+	q->q_stats.nr_sbal_total += count;
+	if (count == QDIO_MAX_BUFFERS_MASK) {
+		q->q_stats.nr_sbals[7]++;
+		return;
+	}
+	while (count >>= 1)
+		pos++;
+	q->q_stats.nr_sbals[pos]++;
+}
+
 static void announce_buffer_error(struct qdio_q *q, int count)
 {
 	q->qdio_error |= QDIO_ERROR_SLSB_STATE;
@@ -487,16 +501,22 @@
 		q->first_to_check = add_buf(q->first_to_check, count);
 		if (atomic_sub(count, &q->nr_buf_used) == 0)
 			qperf_inc(q, inbound_queue_full);
+		if (q->irq_ptr->perf_stat_enabled)
+			account_sbals(q, count);
 		break;
 	case SLSB_P_INPUT_ERROR:
 		announce_buffer_error(q, count);
 		/* process the buffer, the upper layer will take care of it */
 		q->first_to_check = add_buf(q->first_to_check, count);
 		atomic_sub(count, &q->nr_buf_used);
+		if (q->irq_ptr->perf_stat_enabled)
+			account_sbals_error(q, count);
 		break;
 	case SLSB_CU_INPUT_EMPTY:
 	case SLSB_P_INPUT_NOT_INIT:
 	case SLSB_P_INPUT_ACK:
+		if (q->irq_ptr->perf_stat_enabled)
+			q->q_stats.nr_sbal_nop++;
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "in nop");
 		break;
 	default:
@@ -643,15 +663,21 @@
 
 		atomic_sub(count, &q->nr_buf_used);
 		q->first_to_check = add_buf(q->first_to_check, count);
+		if (q->irq_ptr->perf_stat_enabled)
+			account_sbals(q, count);
 		break;
 	case SLSB_P_OUTPUT_ERROR:
 		announce_buffer_error(q, count);
 		/* process the buffer, the upper layer will take care of it */
 		q->first_to_check = add_buf(q->first_to_check, count);
 		atomic_sub(count, &q->nr_buf_used);
+		if (q->irq_ptr->perf_stat_enabled)
+			account_sbals_error(q, count);
 		break;
 	case SLSB_CU_OUTPUT_PRIMED:
 		/* the adapter has not fetched the output yet */
+		if (q->irq_ptr->perf_stat_enabled)
+			q->q_stats.nr_sbal_nop++;
 		DBF_DEV_EVENT(DBF_INFO, q->irq_ptr, "out primed:%1d", q->nr);
 		break;
 	case SLSB_P_OUTPUT_NOT_INIT:
