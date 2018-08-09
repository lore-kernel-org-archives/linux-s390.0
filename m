From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/7] s390/qeth: reduce hard-coded access to ccw channels
Date: Thu,  9 Aug 2018 14:47:59 +0200
Message-ID: <20180809124804.20056-3-jwi@linux.ibm.com>
References: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180809124804.20056-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Where possible use accessor macros and local pointers to access the ccw
channels. This makes it less likely to miss a spot.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 46 ++++++++++++++++++++-------------------
 drivers/s390/net/qeth_l2_main.c   | 13 ++++++-----
 2 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index da9ac2129869..e459894e1926 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -534,13 +534,14 @@ static inline int qeth_is_cq(struct qeth_card *card, unsigned int queue)
 
 static int __qeth_issue_next_read(struct qeth_card *card)
 {
-	int rc;
+	struct qeth_channel *channel = &card->read;
 	struct qeth_cmd_buffer *iob;
+	int rc;
 
 	QETH_CARD_TEXT(card, 5, "issnxrd");
-	if (card->read.state != CH_STATE_UP)
+	if (channel->state != CH_STATE_UP)
 		return -EIO;
-	iob = qeth_get_buffer(&card->read);
+	iob = qeth_get_buffer(channel);
 	if (!iob) {
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 			"failed to recover an error on the device\n");
@@ -548,14 +549,14 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 			"available\n", dev_name(&card->gdev->dev));
 		return -ENOMEM;
 	}
-	qeth_setup_ccw(&card->read, iob->data, QETH_BUFSIZE);
+	qeth_setup_ccw(channel, iob->data, QETH_BUFSIZE);
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
-	rc = ccw_device_start(card->read.ccwdev, &card->read.ccw,
+	rc = ccw_device_start(channel->ccwdev, &channel->ccw,
 			      (addr_t) iob, 0, 0);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s error in starting next read ccw! "
 			"rc=%i\n", dev_name(&card->gdev->dev), rc);
-		atomic_set(&card->read.irq_pending, 0);
+		atomic_set(&channel->irq_pending, 0);
 		card->read_or_write_problem = 1;
 		qeth_schedule_recovery(card);
 		wake_up(&card->wait_q);
@@ -1987,20 +1988,20 @@ static void qeth_idx_write_cb(struct qeth_channel *channel,
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
 		if (QETH_IDX_ACT_CAUSE_CODE(iob->data) == QETH_IDX_ACT_ERR_EXCL)
-			dev_err(&card->write.ccwdev->dev,
+			dev_err(&channel->ccwdev->dev,
 				"The adapter is used exclusively by another "
 				"host\n");
 		else
 			QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on write channel:"
 				" negative reply\n",
-				dev_name(&card->write.ccwdev->dev));
+				dev_name(&channel->ccwdev->dev));
 		goto out;
 	}
 	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
 	if ((temp & ~0x0100) != qeth_peer_func_level(card->info.func_level)) {
 		QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on write channel: "
 			"function level mismatch (sent: 0x%x, received: "
-			"0x%x)\n", dev_name(&card->write.ccwdev->dev),
+			"0x%x)\n", dev_name(&channel->ccwdev->dev),
 			card->info.func_level, temp);
 		goto out;
 	}
@@ -2028,20 +2029,20 @@ static void qeth_idx_read_cb(struct qeth_channel *channel,
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
 		switch (QETH_IDX_ACT_CAUSE_CODE(iob->data)) {
 		case QETH_IDX_ACT_ERR_EXCL:
-			dev_err(&card->write.ccwdev->dev,
+			dev_err(&channel->ccwdev->dev,
 				"The adapter is used exclusively by another "
 				"host\n");
 			break;
 		case QETH_IDX_ACT_ERR_AUTH:
 		case QETH_IDX_ACT_ERR_AUTH_USER:
-			dev_err(&card->read.ccwdev->dev,
+			dev_err(&channel->ccwdev->dev,
 				"Setting the device online failed because of "
 				"insufficient authorization\n");
 			break;
 		default:
 			QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on read channel:"
 				" negative reply\n",
-				dev_name(&card->read.ccwdev->dev));
+				dev_name(&channel->ccwdev->dev));
 		}
 		QETH_CARD_TEXT_(card, 2, "idxread%c",
 			QETH_IDX_ACT_CAUSE_CODE(iob->data));
@@ -2052,7 +2053,7 @@ static void qeth_idx_read_cb(struct qeth_channel *channel,
 	if (temp != qeth_peer_func_level(card->info.func_level)) {
 		QETH_DBF_MESSAGE(2, "%s IDX_ACTIVATE on read channel: function "
 			"level mismatch (sent: 0x%x, received: 0x%x)\n",
-			dev_name(&card->read.ccwdev->dev),
+			dev_name(&channel->ccwdev->dev),
 			card->info.func_level, temp);
 		goto out;
 	}
@@ -2069,7 +2070,7 @@ static void qeth_idx_read_cb(struct qeth_channel *channel,
 void qeth_prepare_control_data(struct qeth_card *card, int len,
 		struct qeth_cmd_buffer *iob)
 {
-	qeth_setup_ccw(&card->write, iob->data, len);
+	qeth_setup_ccw(iob->channel, iob->data, len);
 	iob->callback = qeth_release_buffer;
 
 	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
@@ -2116,6 +2117,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 				unsigned long cb_cmd),
 		void *reply_param)
 {
+	struct qeth_channel *channel = iob->channel;
 	int rc;
 	unsigned long flags;
 	struct qeth_reply *reply = NULL;
@@ -2125,7 +2127,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
 	if (card->read_or_write_problem) {
-		qeth_release_buffer(iob->channel, iob);
+		qeth_release_buffer(channel, iob);
 		return -EIO;
 	}
 	reply = qeth_alloc_reply(card);
@@ -2137,7 +2139,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 
 	init_waitqueue_head(&reply->wait_q);
 
-	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
+	while (atomic_cmpxchg(&channel->irq_pending, 0, 1)) ;
 
 	if (IS_IPA(iob->data)) {
 		cmd = __ipa_cmd(iob);
@@ -2157,21 +2159,21 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	timeout = jiffies + event_timeout;
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
-	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
-	rc = ccw_device_start_timeout(CARD_WDEV(card), &card->write.ccw,
+	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
 				      (addr_t) iob, 0, 0, event_timeout);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->write.ccwdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s qeth_send_control_data: "
 			"ccw_device_start rc = %i\n",
-			dev_name(&card->write.ccwdev->dev), rc);
+			dev_name(&channel->ccwdev->dev), rc);
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
 		spin_lock_irqsave(&card->lock, flags);
 		list_del_init(&reply->list);
 		qeth_put_reply(reply);
 		spin_unlock_irqrestore(&card->lock, flags);
-		qeth_release_buffer(iob->channel, iob);
-		atomic_set(&card->write.irq_pending, 0);
+		qeth_release_buffer(channel, iob);
+		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
 		return rc;
 	}
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index efb84a75dd80..a86ba45ade05 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1239,25 +1239,26 @@ EXPORT_SYMBOL_GPL(qeth_l2_discipline);
 static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 			   struct qeth_cmd_buffer *iob)
 {
+	struct qeth_channel *channel = iob->channel;
 	unsigned long flags;
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 5, "osndctrd");
 
 	wait_event(card->wait_q,
-		   atomic_cmpxchg(&card->write.irq_pending, 0, 1) == 0);
+		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	qeth_prepare_control_data(card, len, iob);
 	QETH_CARD_TEXT(card, 6, "osnoirqp");
-	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
-	rc = ccw_device_start_timeout(CARD_WDEV(card), &card->write.ccw,
+	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
+	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_IPA_TIMEOUT);
-	spin_unlock_irqrestore(get_ccwdev_lock(card->write.ccwdev), flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "qeth_osn_send_control_data: "
 			   "ccw_device_start rc = %i\n", rc);
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
-		qeth_release_buffer(iob->channel, iob);
-		atomic_set(&card->write.irq_pending, 0);
+		qeth_release_buffer(channel, iob);
+		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
 	}
 	return rc;
-- 
2.16.4
