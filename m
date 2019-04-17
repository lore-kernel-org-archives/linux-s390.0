Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/8] s390/qeth: clarify naming for some QDIO helpers
Date: Wed, 17 Apr 2019 18:17:28 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The naming of several QDIO helpers doesn't match their actual
functionality, or the structures they operate on. Clean this up.

s/qeth_alloc_qdio_buffers/qeth_alloc_qdio_queues
s/qeth_free_qdio_buffers/qeth_free_qdio_queues
s/qeth_alloc_qdio_out_buf/qeth_alloc_output_queue
s/qeth_clear_outq_buffers/qeth_drain_output_queue
s/qeth_clear_qdio_buffers/qeth_drain_output_queues

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 39 +++++++++++++++++++--------------------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 4c3a2db0cf2e..41e3bc4887fe 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -988,7 +988,7 @@ void qeth_clear_ipacmd_list(struct qeth_card *);
 int qeth_qdio_clear_card(struct qeth_card *, int);
 void qeth_clear_working_pool_list(struct qeth_card *);
 void qeth_clear_cmd_buffers(struct qeth_channel *);
-void qeth_clear_qdio_buffers(struct qeth_card *);
+void qeth_drain_output_queues(struct qeth_card *card);
 void qeth_setadp_promisc_mode(struct qeth_card *);
 int qeth_setadpparms_change_macaddr(struct qeth_card *);
 void qeth_tx_timeout(struct net_device *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 2b75f76f23fd..ca71632a4fa0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -67,7 +67,7 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *);
 static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
-static void qeth_free_qdio_buffers(struct qeth_card *);
+static void qeth_free_qdio_queues(struct qeth_card *card);
 static void qeth_notify_skbs(struct qeth_qdio_out_q *queue,
 		struct qeth_qdio_out_buffer *buf,
 		enum iucv_tx_notify notification);
@@ -1178,7 +1178,7 @@ static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 	atomic_set(&buf->state, QETH_QDIO_BUF_EMPTY);
 }
 
-static void qeth_clear_outq_buffers(struct qeth_qdio_out_q *q, int free)
+static void qeth_drain_output_queue(struct qeth_qdio_out_q *q, bool free)
 {
 	int j;
 
@@ -1194,19 +1194,18 @@ static void qeth_clear_outq_buffers(struct qeth_qdio_out_q *q, int free)
 	}
 }
 
-void qeth_clear_qdio_buffers(struct qeth_card *card)
+void qeth_drain_output_queues(struct qeth_card *card)
 {
 	int i;
 
 	QETH_CARD_TEXT(card, 2, "clearqdbf");
 	/* clear outbound buffers to free skbs */
 	for (i = 0; i < card->qdio.no_out_queues; ++i) {
-		if (card->qdio.out_qs[i]) {
-			qeth_clear_outq_buffers(card->qdio.out_qs[i], 0);
-		}
+		if (card->qdio.out_qs[i])
+			qeth_drain_output_queue(card->qdio.out_qs[i], false);
 	}
 }
-EXPORT_SYMBOL_GPL(qeth_clear_qdio_buffers);
+EXPORT_SYMBOL_GPL(qeth_drain_output_queues);
 
 static void qeth_free_buffer_pool(struct qeth_card *card)
 {
@@ -1280,7 +1279,7 @@ static void qeth_set_single_write_queues(struct qeth_card *card)
 {
 	if ((atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED) &&
 	    (card->qdio.no_out_queues == 4))
-		qeth_free_qdio_buffers(card);
+		qeth_free_qdio_queues(card);
 
 	card->qdio.no_out_queues = 1;
 	if (card->qdio.default_out_queue != 0)
@@ -1293,7 +1292,7 @@ static void qeth_set_multiple_write_queues(struct qeth_card *card)
 {
 	if ((atomic_read(&card->qdio.state) != QETH_QDIO_UNINITIALIZED) &&
 	    (card->qdio.no_out_queues == 1)) {
-		qeth_free_qdio_buffers(card);
+		qeth_free_qdio_queues(card);
 		card->qdio.default_out_queue = 2;
 	}
 	card->qdio.no_out_queues = 4;
@@ -2177,7 +2176,7 @@ static int qeth_update_max_mtu(struct qeth_card *card, unsigned int max_mtu)
 		/* adjust RX buffer size to new max MTU: */
 		card->qdio.in_buf_size = max_mtu + 2 * PAGE_SIZE;
 		if (dev->max_mtu && dev->max_mtu != max_mtu)
-			qeth_free_qdio_buffers(card);
+			qeth_free_qdio_queues(card);
 	} else {
 		if (dev->mtu)
 			new_mtu = dev->mtu;
@@ -2350,12 +2349,12 @@ static void qeth_free_output_queue(struct qeth_qdio_out_q *q)
 	if (!q)
 		return;
 
-	qeth_clear_outq_buffers(q, 1);
+	qeth_drain_output_queue(q, true);
 	qdio_free_buffers(q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
 	kfree(q);
 }
 
-static struct qeth_qdio_out_q *qeth_alloc_qdio_out_buf(void)
+static struct qeth_qdio_out_q *qeth_alloc_output_queue(void)
 {
 	struct qeth_qdio_out_q *q = kzalloc(sizeof(*q), GFP_KERNEL);
 
@@ -2369,7 +2368,7 @@ static struct qeth_qdio_out_q *qeth_alloc_qdio_out_buf(void)
 	return q;
 }
 
-static int qeth_alloc_qdio_buffers(struct qeth_card *card)
+static int qeth_alloc_qdio_queues(struct qeth_card *card)
 {
 	int i, j;
 
@@ -2390,7 +2389,7 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
 
 	/* outbound */
 	for (i = 0; i < card->qdio.no_out_queues; ++i) {
-		card->qdio.out_qs[i] = qeth_alloc_qdio_out_buf();
+		card->qdio.out_qs[i] = qeth_alloc_output_queue();
 		if (!card->qdio.out_qs[i])
 			goto out_freeoutq;
 		QETH_DBF_TEXT_(SETUP, 2, "outq %i", i);
@@ -2431,7 +2430,7 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
 	return -ENOMEM;
 }
 
-static void qeth_free_qdio_buffers(struct qeth_card *card)
+static void qeth_free_qdio_queues(struct qeth_card *card)
 {
 	int i, j;
 
@@ -2538,7 +2537,7 @@ static int qeth_mpc_initialize(struct qeth_card *card)
 		QETH_DBF_TEXT_(SETUP, 2, "5err%d", rc);
 		goto out_qdio;
 	}
-	rc = qeth_alloc_qdio_buffers(card);
+	rc = qeth_alloc_qdio_queues(card);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "5err%d", rc);
 		goto out_qdio;
@@ -2546,7 +2545,7 @@ static int qeth_mpc_initialize(struct qeth_card *card)
 	rc = qeth_qdio_establish(card);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "6err%d", rc);
-		qeth_free_qdio_buffers(card);
+		qeth_free_qdio_queues(card);
 		goto out_qdio;
 	}
 	rc = qeth_qdio_activate(card);
@@ -3460,7 +3459,7 @@ int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 			goto out;
 		}
 
-		qeth_free_qdio_buffers(card);
+		qeth_free_qdio_queues(card);
 		card->options.cq = cq;
 		rc = 0;
 	}
@@ -4930,7 +4929,7 @@ static void qeth_core_free_card(struct qeth_card *card)
 	qeth_clean_channel(&card->write);
 	qeth_clean_channel(&card->data);
 	destroy_workqueue(card->event_wq);
-	qeth_free_qdio_buffers(card);
+	qeth_free_qdio_queues(card);
 	unregister_service_level(&card->qeth_service_level);
 	dev_set_drvdata(&card->gdev->dev, NULL);
 	kfree(card);
@@ -5732,7 +5731,7 @@ static void qeth_core_shutdown(struct ccwgroup_device *gdev)
 	if ((gdev->state == CCWGROUP_ONLINE) && card->info.hwtrap)
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
 	qeth_qdio_clear_card(card, 0);
-	qeth_clear_qdio_buffers(card);
+	qeth_drain_output_queues(card);
 	qdio_free(CARD_DDEV(card));
 }
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5549c66c6b5d..641dc17e3b79 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -299,7 +299,7 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	}
 	if (card->state == CARD_STATE_HARDSETUP) {
 		qeth_qdio_clear_card(card, 0);
-		qeth_clear_qdio_buffers(card);
+		qeth_drain_output_queues(card);
 		qeth_clear_working_pool_list(card);
 		card->state = CARD_STATE_DOWN;
 	}
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f804d27eb569..102be697f5db 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1433,7 +1433,7 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	}
 	if (card->state == CARD_STATE_HARDSETUP) {
 		qeth_qdio_clear_card(card, 0);
-		qeth_clear_qdio_buffers(card);
+		qeth_drain_output_queues(card);
 		qeth_clear_working_pool_list(card);
 		card->state = CARD_STATE_DOWN;
 	}
-- 
2.16.4
