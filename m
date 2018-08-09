From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/7] s390/qeth: don't restrict qeth_card to DMA memory
Date: Thu,  9 Aug 2018 14:48:03 +0200
Message-ID: <20180809124804.20056-7-jwi@linux.ibm.com>
References: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180809124804.20056-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Allocating the main qeth_card struct with GFP_DMA blocks us from moving
it into netdev_priv(). But the only reason why we need DMA memory is the
ccw1 structs embedded into each ccw channel. So extract those into
separate allocations, like we already do for the cmd buffers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 29 +++++++++++++++++------------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 9a700a618b3d..34e0d476c5c6 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -594,7 +594,7 @@ static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
  */
 struct qeth_channel {
 	enum qeth_channel_states state;
-	struct ccw1 ccw;
+	struct ccw1 *ccw;
 	spinlock_t iob_lock;
 	wait_queue_head_t wait_q;
 	struct ccw_device *ccwdev;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 99ba0f067eea..49f64eb3eab0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -556,9 +556,9 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 			"available\n", dev_name(&card->gdev->dev));
 		return -ENOMEM;
 	}
-	qeth_setup_ccw(&channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
+	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
-	rc = ccw_device_start(channel->ccwdev, &channel->ccw,
+	rc = ccw_device_start(channel->ccwdev, channel->ccw,
 			      (addr_t) iob, 0, 0);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s error in starting next read ccw! "
@@ -905,6 +905,9 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 
 	QETH_DBF_TEXT(SETUP, 2, "setupch");
 
+	channel->ccw = kmalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
+	if (!channel->ccw)
+		return -ENOMEM;
 	channel->state = CH_STATE_DOWN;
 	atomic_set(&channel->irq_pending, 0);
 	init_waitqueue_head(&channel->wait_q);
@@ -923,6 +926,7 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 		channel->iob[cnt].rc = 0;
 	}
 	if (cnt < QETH_CMD_BUFFER_NO) {
+		kfree(channel->ccw);
 		while (cnt-- > 0)
 			kfree(channel->iob[cnt].data);
 		return -ENOMEM;
@@ -1336,6 +1340,7 @@ static void qeth_clean_channel(struct qeth_channel *channel)
 	QETH_DBF_TEXT(SETUP, 2, "freech");
 	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++)
 		kfree(channel->iob[cnt].data);
+	kfree(channel->ccw);
 }
 
 static void qeth_set_single_write_queues(struct qeth_card *card)
@@ -1493,7 +1498,7 @@ static struct qeth_card *qeth_alloc_card(void)
 	struct qeth_card *card;
 
 	QETH_DBF_TEXT(SETUP, 2, "alloccrd");
-	card = kzalloc(sizeof(struct qeth_card), GFP_DMA|GFP_KERNEL);
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
 	if (!card)
 		goto out;
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
@@ -1658,10 +1663,10 @@ static int qeth_read_conf_data(struct qeth_card *card, void **buffer,
 	if (!rcd_buf)
 		return -ENOMEM;
 
-	qeth_setup_ccw(&channel->ccw, ciw->cmd, ciw->count, rcd_buf);
+	qeth_setup_ccw(channel->ccw, ciw->cmd, ciw->count, rcd_buf);
 	channel->state = CH_STATE_RCD;
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	ret = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+	ret = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				       QETH_RCD_PARM, LPM_ANYPATH, 0,
 				       QETH_RCD_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
@@ -1832,13 +1837,13 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 	if (!iob)
 		return -ENOMEM;
 	iob->callback = idx_reply_cb;
-	qeth_setup_ccw(&channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
+	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
 
 	wait_event(card->wait_q,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 
@@ -1881,7 +1886,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 	if (!iob)
 		return -ENOMEM;
 	iob->callback = idx_reply_cb;
-	qeth_setup_ccw(&channel->ccw, CCW_CMD_WRITE, IDX_ACTIVATE_SIZE,
+	qeth_setup_ccw(channel->ccw, CCW_CMD_WRITE, IDX_ACTIVATE_SIZE,
 		       iob->data);
 	if (channel == &card->write) {
 		memcpy(iob->data, IDX_ACTIVATE_WRITE, IDX_ACTIVATE_SIZE);
@@ -1908,7 +1913,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 
@@ -2042,7 +2047,7 @@ static void qeth_idx_read_cb(struct qeth_channel *channel,
 void qeth_prepare_control_data(struct qeth_card *card, int len,
 		struct qeth_cmd_buffer *iob)
 {
-	qeth_setup_ccw(&iob->channel->ccw, CCW_CMD_WRITE, len, iob->data);
+	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_WRITE, len, iob->data);
 	iob->callback = qeth_release_buffer;
 
 	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
@@ -2132,7 +2137,7 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, event_timeout);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
@@ -5031,11 +5036,11 @@ static int qeth_qdio_establish(struct qeth_card *card)
 
 static void qeth_core_free_card(struct qeth_card *card)
 {
-
 	QETH_DBF_TEXT(SETUP, 2, "freecrd");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
+	qeth_clean_channel(&card->data);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
 	kfree(card);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index a86ba45ade05..710fa74892ae 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1250,7 +1250,7 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 	qeth_prepare_control_data(card, len, iob);
 	QETH_CARD_TEXT(card, 6, "osnoirqp");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_IPA_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 	if (rc) {
-- 
2.16.4
