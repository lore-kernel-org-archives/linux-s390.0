From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/15] s390/qeth: remove CARD_FROM_CDEV helper
Date: Wed, 26 Sep 2018 18:29:11 +0200
Message-ID: <20180926162916.102720-11-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The cdev-to-card translation walks through two layers of drvdata,
with no locking or refcounting (where eg. the ccwgroup core only
accesses a cdev's drvdata while holding the ccwlock).

This might be safe for now, but any careless usage of the helper has the
potential for subtle races and use-after-free's. Luckily there's only
one occurrence where we _really_ need it (in qeth_irq()), for any other
user we can just pass through an appropriate card pointer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 73 ++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 44 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 86b9cce1f483..caa5d109841c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -746,18 +746,10 @@ static int qeth_check_idx_response(struct qeth_card *card,
 	return 0;
 }
 
-static struct qeth_card *CARD_FROM_CDEV(struct ccw_device *cdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&((struct ccwgroup_device *)
-		dev_get_drvdata(&cdev->dev))->dev);
-	return card;
-}
-
 static struct qeth_cmd_buffer *__qeth_get_buffer(struct qeth_channel *channel)
 {
 	__u8 index;
 
-	QETH_CARD_TEXT(CARD_FROM_CDEV(channel->ccwdev), 6, "getbuff");
 	index = channel->io_buf_no;
 	do {
 		if (channel->iob[index].state == BUF_STATE_FREE) {
@@ -778,7 +770,6 @@ void qeth_release_buffer(struct qeth_channel *channel,
 {
 	unsigned long flags;
 
-	QETH_CARD_TEXT(CARD_FROM_CDEV(channel->ccwdev), 6, "relbuff");
 	spin_lock_irqsave(&channel->iob_lock, flags);
 	iob->state = BUF_STATE_FREE;
 	iob->callback = qeth_send_control_data_cb;
@@ -980,16 +971,15 @@ void qeth_schedule_recovery(struct qeth_card *card)
 }
 EXPORT_SYMBOL_GPL(qeth_schedule_recovery);
 
-static int qeth_get_problem(struct ccw_device *cdev, struct irb *irb)
+static int qeth_get_problem(struct qeth_card *card, struct ccw_device *cdev,
+			    struct irb *irb)
 {
 	int dstat, cstat;
 	char *sense;
-	struct qeth_card *card;
 
 	sense = (char *) irb->ecw;
 	cstat = irb->scsw.cmd.cstat;
 	dstat = irb->scsw.cmd.dstat;
-	card = CARD_FROM_CDEV(cdev);
 
 	if (cstat & (SCHN_STAT_CHN_CTRL_CHK | SCHN_STAT_INTF_CTRL_CHK |
 		     SCHN_STAT_CHN_DATA_CHK | SCHN_STAT_CHAIN_CHECK |
@@ -1029,14 +1019,11 @@ static int qeth_get_problem(struct ccw_device *cdev, struct irb *irb)
 	return 0;
 }
 
-static long __qeth_check_irb_error(struct ccw_device *cdev,
-		unsigned long intparm, struct irb *irb)
+static long qeth_check_irb_error(struct qeth_card *card,
+				 struct ccw_device *cdev, unsigned long intparm,
+				 struct irb *irb)
 {
-	struct qeth_card *card;
-
-	card = CARD_FROM_CDEV(cdev);
-
-	if (!card || !IS_ERR(irb))
+	if (!IS_ERR(irb))
 		return 0;
 
 	switch (PTR_ERR(irb)) {
@@ -1073,10 +1060,13 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	int rc;
 	int cstat, dstat;
 	struct qeth_cmd_buffer *iob = NULL;
+	struct ccwgroup_device *gdev;
 	struct qeth_channel *channel;
 	struct qeth_card *card;
 
-	card = CARD_FROM_CDEV(cdev);
+	/* while we hold the ccwdev lock, this stays valid: */
+	gdev = dev_get_drvdata(&cdev->dev);
+	card = dev_get_drvdata(&gdev->dev);
 	if (!card)
 		return;
 
@@ -1096,7 +1086,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	if (qeth_intparm_is_iob(intparm))
 		iob = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
 
-	if (__qeth_check_irb_error(cdev, intparm, irb)) {
+	if (qeth_check_irb_error(card, cdev, intparm, irb)) {
 		/* IO was terminated, free its resources. */
 		if (iob)
 			qeth_release_buffer(iob->channel, iob);
@@ -1151,7 +1141,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 			channel->state = CH_STATE_DOWN;
 			goto out;
 		}
-		rc = qeth_get_problem(cdev, irb);
+		rc = qeth_get_problem(card, cdev, irb);
 		if (rc) {
 			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
@@ -1514,12 +1504,11 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 	return NULL;
 }
 
-static int qeth_clear_channel(struct qeth_channel *channel)
+static int qeth_clear_channel(struct qeth_card *card,
+			      struct qeth_channel *channel)
 {
-	struct qeth_card *card;
 	int rc;
 
-	card = CARD_FROM_CDEV(channel->ccwdev);
 	QETH_CARD_TEXT(card, 3, "clearch");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_clear(channel->ccwdev, QETH_CLEAR_CHANNEL_PARM);
@@ -1537,12 +1526,11 @@ static int qeth_clear_channel(struct qeth_channel *channel)
 	return 0;
 }
 
-static int qeth_halt_channel(struct qeth_channel *channel)
+static int qeth_halt_channel(struct qeth_card *card,
+			     struct qeth_channel *channel)
 {
-	struct qeth_card *card;
 	int rc;
 
-	card = CARD_FROM_CDEV(channel->ccwdev);
 	QETH_CARD_TEXT(card, 3, "haltch");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_halt(channel->ccwdev, QETH_HALT_CHANNEL_PARM);
@@ -1564,9 +1552,9 @@ static int qeth_halt_channels(struct qeth_card *card)
 	int rc1 = 0, rc2 = 0, rc3 = 0;
 
 	QETH_CARD_TEXT(card, 3, "haltchs");
-	rc1 = qeth_halt_channel(&card->read);
-	rc2 = qeth_halt_channel(&card->write);
-	rc3 = qeth_halt_channel(&card->data);
+	rc1 = qeth_halt_channel(card, &card->read);
+	rc2 = qeth_halt_channel(card, &card->write);
+	rc3 = qeth_halt_channel(card, &card->data);
 	if (rc1)
 		return rc1;
 	if (rc2)
@@ -1579,9 +1567,9 @@ static int qeth_clear_channels(struct qeth_card *card)
 	int rc1 = 0, rc2 = 0, rc3 = 0;
 
 	QETH_CARD_TEXT(card, 3, "clearchs");
-	rc1 = qeth_clear_channel(&card->read);
-	rc2 = qeth_clear_channel(&card->write);
-	rc3 = qeth_clear_channel(&card->data);
+	rc1 = qeth_clear_channel(card, &card->read);
+	rc2 = qeth_clear_channel(card, &card->write);
+	rc3 = qeth_clear_channel(card, &card->data);
 	if (rc1)
 		return rc1;
 	if (rc2)
@@ -1810,17 +1798,16 @@ static void qeth_init_func_level(struct qeth_card *card)
 	}
 }
 
-static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
+static int qeth_idx_activate_get_answer(struct qeth_card *card,
+					struct qeth_channel *channel,
 					void (*reply_cb)(struct qeth_card *,
 							 struct qeth_channel *,
 							 struct qeth_cmd_buffer *))
 {
 	struct qeth_cmd_buffer *iob;
 	int rc;
-	struct qeth_card *card;
 
 	QETH_DBF_TEXT(SETUP, 2, "idxanswr");
-	card = CARD_FROM_CDEV(channel->ccwdev);
 	iob = qeth_get_buffer(channel);
 	if (!iob)
 		return -ENOMEM;
@@ -1854,20 +1841,18 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 	return rc;
 }
 
-static int qeth_idx_activate_channel(struct qeth_channel *channel,
+static int qeth_idx_activate_channel(struct qeth_card *card,
+				     struct qeth_channel *channel,
 				     void (*reply_cb)(struct qeth_card *,
 						      struct qeth_channel *,
 						      struct qeth_cmd_buffer *))
 {
-	struct qeth_card *card;
 	struct qeth_cmd_buffer *iob;
 	__u16 temp;
 	__u8 tmp;
 	int rc;
 	struct ccw_dev_id temp_devid;
 
-	card = CARD_FROM_CDEV(channel->ccwdev);
-
 	QETH_DBF_TEXT(SETUP, 2, "idxactch");
 
 	iob = qeth_get_buffer(channel);
@@ -1925,7 +1910,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", -ETIME);
 		return -ETIME;
 	}
-	return qeth_idx_activate_get_answer(channel, reply_cb);
+	return qeth_idx_activate_get_answer(card, channel, reply_cb);
 }
 
 static int qeth_peer_func_level(int level)
@@ -5131,7 +5116,7 @@ int qeth_core_hardsetup_card(struct qeth_card *card)
 	qeth_determine_capabilities(card);
 	qeth_init_tokens(card);
 	qeth_init_func_level(card);
-	rc = qeth_idx_activate_channel(&card->read, qeth_idx_read_cb);
+	rc = qeth_idx_activate_channel(card, &card->read, qeth_idx_read_cb);
 	if (rc == -ERESTARTSYS) {
 		QETH_DBF_TEXT(SETUP, 2, "break2");
 		return rc;
@@ -5142,7 +5127,7 @@ int qeth_core_hardsetup_card(struct qeth_card *card)
 		else
 			goto retry;
 	}
-	rc = qeth_idx_activate_channel(&card->write, qeth_idx_write_cb);
+	rc = qeth_idx_activate_channel(card, &card->write, qeth_idx_write_cb);
 	if (rc == -ERESTARTSYS) {
 		QETH_DBF_TEXT(SETUP, 2, "break3");
 		return rc;
-- 
2.16.4
