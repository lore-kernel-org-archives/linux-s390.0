From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 14/15] s390/qeth: fine-tune spinlocks
Date: Mon, 17 Sep 2018 17:36:08 +0200
Message-ID: <20180917153609.94628-15-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

For quite a lot of code paths it's obvious that they will never run in
IRQ context. So replace their spin_lock_irqsave() calls with
spin_lock_irq().

While at it, get rid of the redundant card pointer in struct qeth_reply
that was used by qeth_send_control_data() to access the card's lock.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 53 ++++++++++++++++-----------------------
 drivers/s390/net/qeth_l2_main.c   |  5 ++--
 3 files changed, 24 insertions(+), 35 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index be213b5c2552..0dbe81f958f0 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -639,7 +639,6 @@ struct qeth_reply {
 	atomic_t received;
 	int rc;
 	void *param;
-	struct qeth_card *card;
 	refcount_t refcnt;
 };
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f09bef4a49ca..100b6f4a3fb8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -592,7 +592,6 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 	if (reply) {
 		refcount_set(&reply->refcnt, 1);
 		atomic_set(&reply->received, 0);
-		reply->card = card;
 	}
 	return reply;
 }
@@ -1541,15 +1540,14 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 
 static int qeth_clear_channel(struct qeth_channel *channel)
 {
-	unsigned long flags;
 	struct qeth_card *card;
 	int rc;
 
 	card = CARD_FROM_CDEV(channel->ccwdev);
 	QETH_CARD_TEXT(card, 3, "clearch");
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_clear(channel->ccwdev, QETH_CLEAR_CHANNEL_PARM);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 
 	if (rc)
 		return rc;
@@ -1565,15 +1563,14 @@ static int qeth_clear_channel(struct qeth_channel *channel)
 
 static int qeth_halt_channel(struct qeth_channel *channel)
 {
-	unsigned long flags;
 	struct qeth_card *card;
 	int rc;
 
 	card = CARD_FROM_CDEV(channel->ccwdev);
 	QETH_CARD_TEXT(card, 3, "haltch");
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_halt(channel->ccwdev, QETH_HALT_CHANNEL_PARM);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 
 	if (rc)
 		return rc;
@@ -1667,7 +1664,6 @@ static int qeth_read_conf_data(struct qeth_card *card, void **buffer,
 	char *rcd_buf;
 	int ret;
 	struct qeth_channel *channel = &card->data;
-	unsigned long flags;
 
 	/*
 	 * scan for RCD command in extended SenseID data
@@ -1681,11 +1677,11 @@ static int qeth_read_conf_data(struct qeth_card *card, void **buffer,
 
 	qeth_setup_ccw(channel->ccw, ciw->cmd, ciw->count, rcd_buf);
 	channel->state = CH_STATE_RCD;
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	ret = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				       QETH_RCD_PARM, LPM_ANYPATH, 0,
 				       QETH_RCD_TIMEOUT);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (!ret)
 		wait_event(card->wait_q,
 			   (channel->state == CH_STATE_RCD_DONE ||
@@ -1843,7 +1839,6 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 			struct qeth_cmd_buffer *))
 {
 	struct qeth_cmd_buffer *iob;
-	unsigned long flags;
 	int rc;
 	struct qeth_card *card;
 
@@ -1858,10 +1853,10 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 	wait_event(card->wait_q,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "Error2 in activating channel rc=%d\n", rc);
@@ -1888,7 +1883,6 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 {
 	struct qeth_card *card;
 	struct qeth_cmd_buffer *iob;
-	unsigned long flags;
 	__u16 temp;
 	__u8 tmp;
 	int rc;
@@ -1928,10 +1922,10 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 	wait_event(card->wait_q,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "Error1 in activating channel. rc=%d\n",
@@ -2112,7 +2106,6 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 {
 	struct qeth_channel *channel = iob->channel;
 	int rc;
-	unsigned long flags;
 	struct qeth_reply *reply = NULL;
 	unsigned long timeout, event_timeout;
 	struct qeth_ipa_cmd *cmd = NULL;
@@ -2145,26 +2138,26 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	}
 	qeth_prepare_control_data(card, len, iob);
 
-	spin_lock_irqsave(&card->lock, flags);
+	spin_lock_irq(&card->lock);
 	list_add_tail(&reply->list, &card->cmd_waiter_list);
-	spin_unlock_irqrestore(&card->lock, flags);
+	spin_unlock_irq(&card->lock);
 
 	timeout = jiffies + event_timeout;
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, event_timeout);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s qeth_send_control_data: "
 			"ccw_device_start rc = %i\n",
 			dev_name(&channel->ccwdev->dev), rc);
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
-		spin_lock_irqsave(&card->lock, flags);
+		spin_lock_irq(&card->lock);
 		list_del_init(&reply->list);
 		qeth_put_reply(reply);
-		spin_unlock_irqrestore(&card->lock, flags);
+		spin_unlock_irq(&card->lock);
 		qeth_release_buffer(channel, iob);
 		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
@@ -2192,9 +2185,9 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 
 time_err:
 	reply->rc = -ETIME;
-	spin_lock_irqsave(&reply->card->lock, flags);
+	spin_lock_irq(&card->lock);
 	list_del_init(&reply->list);
-	spin_unlock_irqrestore(&reply->card->lock, flags);
+	spin_unlock_irq(&card->lock);
 	atomic_inc(&reply->received);
 	rc = reply->rc;
 	qeth_put_reply(reply);
@@ -5776,7 +5769,6 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	struct device *dev;
 	int rc;
 	enum qeth_discipline_id enforced_disc;
-	unsigned long flags;
 	char dbf_name[DBF_NAME_LEN];
 
 	QETH_DBF_TEXT(SETUP, 2, "probedev");
@@ -5834,9 +5826,9 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		break;
 	}
 
-	write_lock_irqsave(&qeth_core_card_list.rwlock, flags);
+	write_lock_irq(&qeth_core_card_list.rwlock);
 	list_add_tail(&card->list, &qeth_core_card_list.list);
-	write_unlock_irqrestore(&qeth_core_card_list.rwlock, flags);
+	write_unlock_irq(&qeth_core_card_list.rwlock);
 	return 0;
 
 err_disc:
@@ -5852,7 +5844,6 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 
 static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 {
-	unsigned long flags;
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 
 	QETH_DBF_TEXT(SETUP, 2, "removedv");
@@ -5862,9 +5853,9 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 		qeth_core_free_discipline(card);
 	}
 
-	write_lock_irqsave(&qeth_core_card_list.rwlock, flags);
+	write_lock_irq(&qeth_core_card_list.rwlock);
 	list_del(&card->list);
-	write_unlock_irqrestore(&qeth_core_card_list.rwlock, flags);
+	write_unlock_irq(&qeth_core_card_list.rwlock);
 	free_netdev(card->dev);
 	qeth_core_free_card(card);
 	dev_set_drvdata(&gdev->dev, NULL);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 6285af373bdf..12858ffa28cf 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1209,7 +1209,6 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 			   struct qeth_cmd_buffer *iob)
 {
 	struct qeth_channel *channel = iob->channel;
-	unsigned long flags;
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 5, "osndctrd");
@@ -1218,10 +1217,10 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	qeth_prepare_control_data(card, len, iob);
 	QETH_CARD_TEXT(card, 6, "osnoirqp");
-	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_IPA_TIMEOUT);
-	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
+	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "qeth_osn_send_control_data: "
 			   "ccw_device_start rc = %i\n", rc);
-- 
2.16.4
