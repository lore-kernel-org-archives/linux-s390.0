Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/10] s390/qeth: cancel cmd on early error
Date: Tue, 12 Feb 2019 18:33:22 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When sending cmds via qeth_send_control_data(), qeth puts the request
on the IO channel and then blocks on the reply object until the response
has been received.

If the IO completes with error, there will never be a response and we
block until the reply-wait hits its timeout. For this case, connect the
request buffer to its reply object, so that we can immediately cancel
the wait.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 37 ++++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 07840f9c0bb3..83f710336685 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -595,6 +595,7 @@ struct qeth_channel;
 struct qeth_cmd_buffer {
 	enum qeth_cmd_buffer_state state;
 	struct qeth_channel *channel;
+	struct qeth_reply *reply;
 	unsigned char *data;
 	int rc;
 	void (*callback)(struct qeth_card *card, struct qeth_channel *channel,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 04beb0922b31..b1a7a35a086e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -743,6 +743,10 @@ void qeth_release_buffer(struct qeth_channel *channel,
 	spin_lock_irqsave(&channel->iob_lock, flags);
 	iob->state = BUF_STATE_FREE;
 	iob->callback = qeth_send_control_data_cb;
+	if (iob->reply) {
+		qeth_put_reply(iob->reply);
+		iob->reply = NULL;
+	}
 	iob->rc = 0;
 	spin_unlock_irqrestore(&channel->iob_lock, flags);
 	wake_up(&channel->wait_q);
@@ -756,6 +760,17 @@ static void qeth_release_buffer_cb(struct qeth_card *card,
 	qeth_release_buffer(channel, iob);
 }
 
+static void qeth_cancel_cmd(struct qeth_cmd_buffer *iob, int rc)
+{
+	struct qeth_reply *reply = iob->reply;
+
+	if (reply) {
+		reply->rc = rc;
+		qeth_notify_reply(reply);
+	}
+	qeth_release_buffer(iob->channel, iob);
+}
+
 static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
 {
 	struct qeth_cmd_buffer *buffer = NULL;
@@ -990,9 +1005,8 @@ static int qeth_get_problem(struct qeth_card *card, struct ccw_device *cdev,
 	return 0;
 }
 
-static long qeth_check_irb_error(struct qeth_card *card,
-				 struct ccw_device *cdev, unsigned long intparm,
-				 struct irb *irb)
+static int qeth_check_irb_error(struct qeth_card *card, struct ccw_device *cdev,
+				unsigned long intparm, struct irb *irb)
 {
 	if (!IS_ERR(irb))
 		return 0;
@@ -1003,7 +1017,7 @@ static long qeth_check_irb_error(struct qeth_card *card,
 				 CCW_DEVID(cdev));
 		QETH_CARD_TEXT(card, 2, "ckirberr");
 		QETH_CARD_TEXT_(card, 2, "  rc%d", -EIO);
-		break;
+		return -EIO;
 	case -ETIMEDOUT:
 		dev_warn(&cdev->dev, "A hardware operation timed out"
 			" on the device\n");
@@ -1015,14 +1029,14 @@ static long qeth_check_irb_error(struct qeth_card *card,
 				wake_up(&card->wait_q);
 			}
 		}
-		break;
+		return -ETIMEDOUT;
 	default:
 		QETH_DBF_MESSAGE(2, "unknown error %ld on channel %x\n",
 				 PTR_ERR(irb), CCW_DEVID(cdev));
 		QETH_CARD_TEXT(card, 2, "ckirberr");
 		QETH_CARD_TEXT(card, 2, "  rc???");
+		return PTR_ERR(irb);
 	}
-	return PTR_ERR(irb);
 }
 
 static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
@@ -1057,10 +1071,11 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	if (qeth_intparm_is_iob(intparm))
 		iob = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
 
-	if (qeth_check_irb_error(card, cdev, intparm, irb)) {
+	rc = qeth_check_irb_error(card, cdev, intparm, irb);
+	if (rc) {
 		/* IO was terminated, free its resources. */
 		if (iob)
-			qeth_release_buffer(iob->channel, iob);
+			qeth_cancel_cmd(iob, rc);
 		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
 		return;
@@ -1116,7 +1131,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		if (rc) {
 			card->read_or_write_problem = 1;
 			if (iob)
-				qeth_release_buffer(iob->channel, iob);
+				qeth_cancel_cmd(iob, rc);
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
@@ -2061,6 +2076,10 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 	reply->callback = reply_cb;
 	reply->param = reply_param;
 
+	/* pairs with qeth_release_buffer(): */
+	qeth_get_reply(reply);
+	iob->reply = reply;
+
 	while (atomic_cmpxchg(&channel->irq_pending, 0, 1)) ;
 
 	if (IS_IPA(iob->data)) {
-- 
2.16.4
