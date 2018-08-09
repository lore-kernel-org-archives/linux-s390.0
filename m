From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/7] s390/qeth: clean up card initialization
Date: Thu,  9 Aug 2018 14:48:02 +0200
Message-ID: <20180809124804.20056-6-jwi@linux.ibm.com>
References: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180809124804.20056-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The qeth_card struct is kzalloc-ed, so remove all the redundant
0-initializations. While at it, split up what's left of
qeth_determine_card_type().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 44 +++++++++------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index eab8c4a182b0..99ba0f067eea 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1392,6 +1392,10 @@ static void qeth_init_qdio_info(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(SETUP, 4, "intqdinf");
 	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
+	card->qdio.do_prio_queueing = QETH_PRIOQ_DEFAULT;
+	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
+	card->qdio.no_out_queues = QETH_MAX_QUEUES;
+
 	/* inbound */
 	card->qdio.no_in_queues = 1;
 	card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
@@ -1404,12 +1408,10 @@ static void qeth_init_qdio_info(struct qeth_card *card)
 	INIT_LIST_HEAD(&card->qdio.init_pool.entry_list);
 }
 
-static void qeth_set_intial_options(struct qeth_card *card)
+static void qeth_set_initial_options(struct qeth_card *card)
 {
 	card->options.route4.type = NO_ROUTER;
 	card->options.route6.type = NO_ROUTER;
-	card->options.fake_broadcast = 0;
-	card->options.performance_stats = 0;
 	card->options.rx_sg_cb = QETH_RX_SG_CB;
 	card->options.isolation = ISOLATION_MODE_NONE;
 	card->options.cq = QETH_CQ_DISABLED;
@@ -1452,15 +1454,13 @@ static void qeth_start_kernel_thread(struct work_struct *work)
 }
 
 static void qeth_buffer_reclaim_work(struct work_struct *);
-static int qeth_setup_card(struct qeth_card *card)
+static void qeth_setup_card(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(SETUP, 2, "setupcrd");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
+	card->info.type = CARD_RDEV(card)->id.driver_info;
 	card->state = CARD_STATE_DOWN;
-	card->lan_online = 0;
-	card->read_or_write_problem = 0;
-	card->dev = NULL;
 	spin_lock_init(&card->mclock);
 	spin_lock_init(&card->lock);
 	spin_lock_init(&card->ip_lock);
@@ -1468,24 +1468,15 @@ static int qeth_setup_card(struct qeth_card *card)
 	mutex_init(&card->conf_mutex);
 	mutex_init(&card->discipline_mutex);
 	mutex_init(&card->vid_list_mutex);
-	card->thread_start_mask = 0;
-	card->thread_allowed_mask = 0;
-	card->thread_running_mask = 0;
 	INIT_WORK(&card->kernel_thread_starter, qeth_start_kernel_thread);
 	INIT_LIST_HEAD(&card->cmd_waiter_list);
 	init_waitqueue_head(&card->wait_q);
-	/* initial options */
-	qeth_set_intial_options(card);
+	qeth_set_initial_options(card);
 	/* IP address takeover */
 	INIT_LIST_HEAD(&card->ipato.entries);
-	card->ipato.enabled = false;
-	card->ipato.invert4 = false;
-	card->ipato.invert6 = false;
-	/* init QDIO stuff */
 	qeth_init_qdio_info(card);
 	INIT_DELAYED_WORK(&card->buffer_reclaim_work, qeth_buffer_reclaim_work);
 	INIT_WORK(&card->close_dev_work, qeth_close_dev_handler);
-	return 0;
 }
 
 static void qeth_core_sl_print(struct seq_file *m, struct service_level *slr)
@@ -1527,17 +1518,6 @@ static struct qeth_card *qeth_alloc_card(void)
 	return NULL;
 }
 
-static void qeth_determine_card_type(struct qeth_card *card)
-{
-	QETH_DBF_TEXT(SETUP, 2, "detcdtyp");
-
-	card->qdio.do_prio_queueing = QETH_PRIOQ_DEFAULT;
-	card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
-	card->info.type = CARD_RDEV(card)->id.driver_info;
-	card->qdio.no_out_queues = QETH_MAX_QUEUES;
-	qeth_update_from_chp_desc(card);
-}
-
 static int qeth_clear_channel(struct qeth_channel *channel)
 {
 	unsigned long flags;
@@ -5779,12 +5759,8 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	gdev->cdev[1]->handler = qeth_irq;
 	gdev->cdev[2]->handler = qeth_irq;
 
-	qeth_determine_card_type(card);
-	rc = qeth_setup_card(card);
-	if (rc) {
-		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
-		goto err_card;
-	}
+	qeth_setup_card(card);
+	qeth_update_from_chp_desc(card);
 
 	card->dev = qeth_alloc_netdev(card);
 	if (!card->dev)
-- 
2.16.4
