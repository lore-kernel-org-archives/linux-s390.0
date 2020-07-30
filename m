Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729684AbgG3PBd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 11:01:33 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/4] s390/qeth: integrate RX refill worker with NAPI
Date: Thu, 30 Jul 2020 17:01:19 +0200
Message-Id: <20200730150121.18005-3-jwi@linux.ibm.com>
In-Reply-To: <20200730150121.18005-1-jwi@linux.ibm.com>
References: <20200730150121.18005-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Running a RX refill outside of NAPI context is inherently racy, even
though the worker is only started for an entirely idle RX ring.
From the moment that the worker has replenished parts of the RX ring,
the HW can use those RX buffers, raise an IRQ and cause our NAPI code to
run concurrently to the RX refill worker.

Instead let the worker schedule our NAPI instance, and refill the RX
ring from there. Keeping accurate count of how many buffers still need
to be refilled also removes some quirky arithmetic from the low-level
code.

Fixes: b333293058aa ("qeth: add support for af_iucv HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 40 +++++++++++++++++++------------
 drivers/s390/net/qeth_l2_main.c   |  1 -
 drivers/s390/net/qeth_l3_main.c   |  1 -
 4 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 3d54c8bbfa86..ecfd6d152e86 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -764,6 +764,7 @@ struct qeth_rx {
 	u8 buf_element;
 	int e_offset;
 	int qdio_err;
+	u8 bufs_refill;
 };
 
 struct carrier_info {
@@ -833,7 +834,6 @@ struct qeth_card {
 	struct napi_struct napi;
 	struct qeth_rx rx;
 	struct delayed_work buffer_reclaim_work;
-	int reclaim_index;
 	struct work_struct close_dev_work;
 };
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b356ee5de9f8..c2e44853ac1a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3492,20 +3492,15 @@ static int qeth_check_qdio_errors(struct qeth_card *card,
 	return 0;
 }
 
-static void qeth_queue_input_buffer(struct qeth_card *card, int index)
+static unsigned int qeth_rx_refill_queue(struct qeth_card *card,
+					 unsigned int count)
 {
 	struct qeth_qdio_q *queue = card->qdio.in_q;
 	struct list_head *lh;
-	int count;
 	int i;
 	int rc;
 	int newcount = 0;
 
-	count = (index < queue->next_buf_to_init)?
-		card->qdio.in_buf_pool.buf_count -
-		(queue->next_buf_to_init - index) :
-		card->qdio.in_buf_pool.buf_count -
-		(queue->next_buf_to_init + QDIO_MAX_BUFFERS_PER_Q - index);
 	/* only requeue at a certain threshold to avoid SIGAs */
 	if (count >= QETH_IN_BUF_REQUEUE_THRESHOLD(card)) {
 		for (i = queue->next_buf_to_init;
@@ -3533,12 +3528,11 @@ static void qeth_queue_input_buffer(struct qeth_card *card, int index)
 				i++;
 			if (i == card->qdio.in_buf_pool.buf_count) {
 				QETH_CARD_TEXT(card, 2, "qsarbw");
-				card->reclaim_index = index;
 				schedule_delayed_work(
 					&card->buffer_reclaim_work,
 					QETH_RECLAIM_WORK_TIME);
 			}
-			return;
+			return 0;
 		}
 
 		/*
@@ -3555,7 +3549,10 @@ static void qeth_queue_input_buffer(struct qeth_card *card, int index)
 		}
 		queue->next_buf_to_init = QDIO_BUFNR(queue->next_buf_to_init +
 						     count);
+		return count;
 	}
+
+	return 0;
 }
 
 static void qeth_buffer_reclaim_work(struct work_struct *work)
@@ -3563,8 +3560,10 @@ static void qeth_buffer_reclaim_work(struct work_struct *work)
 	struct qeth_card *card = container_of(work, struct qeth_card,
 		buffer_reclaim_work.work);
 
-	QETH_CARD_TEXT_(card, 2, "brw:%x", card->reclaim_index);
-	qeth_queue_input_buffer(card, card->reclaim_index);
+	local_bh_disable();
+	napi_schedule(&card->napi);
+	/* kick-start the NAPI softirq: */
+	local_bh_enable();
 }
 
 static void qeth_handle_send_error(struct qeth_card *card,
@@ -5743,6 +5742,7 @@ static unsigned int qeth_extract_skbs(struct qeth_card *card, int budget,
 
 static unsigned int qeth_rx_poll(struct qeth_card *card, int budget)
 {
+	struct qeth_rx *ctx = &card->rx;
 	unsigned int work_done = 0;
 
 	while (budget > 0) {
@@ -5779,8 +5779,10 @@ static unsigned int qeth_rx_poll(struct qeth_card *card, int budget)
 			QETH_CARD_STAT_INC(card, rx_bufs);
 			qeth_put_buffer_pool_entry(card, buffer->pool_entry);
 			buffer->pool_entry = NULL;
-			qeth_queue_input_buffer(card, card->rx.b_index);
 			card->rx.b_count--;
+			ctx->bufs_refill++;
+			ctx->bufs_refill -= qeth_rx_refill_queue(card,
+								 ctx->bufs_refill);
 
 			/* Step forward to next buffer: */
 			card->rx.b_index = QDIO_BUFNR(card->rx.b_index + 1);
@@ -5820,9 +5822,16 @@ int qeth_poll(struct napi_struct *napi, int budget)
 	if (card->options.cq == QETH_CQ_ENABLED)
 		qeth_cq_poll(card);
 
-	/* Exhausted the RX budget. Keep IRQ disabled, we get called again. */
-	if (budget && work_done >= budget)
-		return work_done;
+	if (budget) {
+		struct qeth_rx *ctx = &card->rx;
+
+		/* Process any substantial refill backlog: */
+		ctx->bufs_refill -= qeth_rx_refill_queue(card, ctx->bufs_refill);
+
+		/* Exhausted the RX budget. Keep IRQ disabled, we get called again. */
+		if (work_done >= budget)
+			return work_done;
+	}
 
 	if (napi_complete_done(napi, work_done) &&
 	    qdio_start_irq(CARD_DDEV(card)))
@@ -7009,6 +7018,7 @@ int qeth_stop(struct net_device *dev)
 	}
 
 	napi_disable(&card->napi);
+	cancel_delayed_work_sync(&card->buffer_reclaim_work);
 	qdio_stop_irq(CARD_DDEV(card));
 
 	return 0;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ef7a2db7a724..38e97bbde9ed 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -285,7 +285,6 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_clear_ipacmd_list(card);
 		qeth_drain_output_queues(card);
-		cancel_delayed_work_sync(&card->buffer_reclaim_work);
 		card->state = CARD_STATE_DOWN;
 	}
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 15a12487ff7a..fe44b0249e34 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1169,7 +1169,6 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
 		qeth_drain_output_queues(card);
-		cancel_delayed_work_sync(&card->buffer_reclaim_work);
 		card->state = CARD_STATE_DOWN;
 	}
 
-- 
2.17.1
