Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/10] s390/qeth: simplify reply object handling
Date: Tue, 12 Feb 2019 18:33:21 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Current code enqueues & dequeues a reply object from the waiter list
in various places. In particular, the dequeue & enqueue in
qeth_send_control_data_cb() looks fragile - this can cause
qeth_clear_ipacmd_list() to skip the active object.
Add some helpers, and boil the logic down by giving
qeth_send_control_data() the sole responsibility to add and remove
objects.

qeth_send_control_data_cb() and qeth_clear_ipacmd_list() will now only
notify the reply object to interrupt its wait cycle. This can cause
a slight delay in the removal, but that's no concern.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 118 ++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 57 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ae2ea0a0edce..04beb0922b31 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -566,6 +566,7 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 	if (reply) {
 		refcount_set(&reply->refcnt, 1);
 		atomic_set(&reply->received, 0);
+		init_waitqueue_head(&reply->wait_q);
 	}
 	return reply;
 }
@@ -581,6 +582,26 @@ static void qeth_put_reply(struct qeth_reply *reply)
 		kfree(reply);
 }
 
+static void qeth_enqueue_reply(struct qeth_card *card, struct qeth_reply *reply)
+{
+	spin_lock_irq(&card->lock);
+	list_add_tail(&reply->list, &card->cmd_waiter_list);
+	spin_unlock_irq(&card->lock);
+}
+
+static void qeth_dequeue_reply(struct qeth_card *card, struct qeth_reply *reply)
+{
+	spin_lock_irq(&card->lock);
+	list_del(&reply->list);
+	spin_unlock_irq(&card->lock);
+}
+
+static void qeth_notify_reply(struct qeth_reply *reply)
+{
+	atomic_inc(&reply->received);
+	wake_up(&reply->wait_q);
+}
+
 static void qeth_issue_ipa_msg(struct qeth_ipa_cmd *cmd, int rc,
 		struct qeth_card *card)
 {
@@ -657,19 +678,15 @@ static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
 
 void qeth_clear_ipacmd_list(struct qeth_card *card)
 {
-	struct qeth_reply *reply, *r;
+	struct qeth_reply *reply;
 	unsigned long flags;
 
 	QETH_CARD_TEXT(card, 4, "clipalst");
 
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry_safe(reply, r, &card->cmd_waiter_list, list) {
-		qeth_get_reply(reply);
+	list_for_each_entry(reply, &card->cmd_waiter_list, list) {
 		reply->rc = -EIO;
-		atomic_inc(&reply->received);
-		list_del_init(&reply->list);
-		wake_up(&reply->wait_q);
-		qeth_put_reply(reply);
+		qeth_notify_reply(reply);
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
 }
@@ -774,9 +791,10 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 				      struct qeth_cmd_buffer *iob)
 {
 	struct qeth_ipa_cmd *cmd = NULL;
-	struct qeth_reply *reply, *r;
+	struct qeth_reply *reply = NULL;
+	struct qeth_reply *r;
 	unsigned long flags;
-	int keep_reply;
+	int keep_reply = 0;
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 4, "sndctlcb");
@@ -808,44 +826,40 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 			goto out;
 	}
 
+	/* match against pending cmd requests */
 	spin_lock_irqsave(&card->lock, flags);
-	list_for_each_entry_safe(reply, r, &card->cmd_waiter_list, list) {
-		if ((reply->seqno == QETH_IDX_COMMAND_SEQNO) ||
-		    ((cmd) && (reply->seqno == cmd->hdr.seqno))) {
+	list_for_each_entry(r, &card->cmd_waiter_list, list) {
+		if ((r->seqno == QETH_IDX_COMMAND_SEQNO) ||
+		    (cmd && (r->seqno == cmd->hdr.seqno))) {
+			reply = r;
+			/* take the object outside the lock */
 			qeth_get_reply(reply);
-			list_del_init(&reply->list);
-			spin_unlock_irqrestore(&card->lock, flags);
-			keep_reply = 0;
-			if (reply->callback != NULL) {
-				if (cmd) {
-					reply->offset = (__u16)((char *)cmd -
-							(char *)iob->data);
-					keep_reply = reply->callback(card,
-							reply,
-							(unsigned long)cmd);
-				} else
-					keep_reply = reply->callback(card,
-							reply,
-							(unsigned long)iob);
-			}
-			if (cmd)
-				reply->rc = (u16) cmd->hdr.return_code;
-			else if (iob->rc)
-				reply->rc = iob->rc;
-			if (keep_reply) {
-				spin_lock_irqsave(&card->lock, flags);
-				list_add_tail(&reply->list,
-					      &card->cmd_waiter_list);
-				spin_unlock_irqrestore(&card->lock, flags);
-			} else {
-				atomic_inc(&reply->received);
-				wake_up(&reply->wait_q);
-			}
-			qeth_put_reply(reply);
-			goto out;
+			break;
 		}
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
+
+	if (!reply)
+		goto out;
+
+	if (reply->callback) {
+		if (cmd) {
+			reply->offset = (u16)((char *)cmd - (char *)iob->data);
+			keep_reply = reply->callback(card, reply,
+						     (unsigned long)cmd);
+		} else
+			keep_reply = reply->callback(card, reply,
+						     (unsigned long)iob);
+	}
+	if (cmd)
+		reply->rc = (u16) cmd->hdr.return_code;
+	else if (iob->rc)
+		reply->rc = iob->rc;
+
+	if (!keep_reply)
+		qeth_notify_reply(reply);
+	qeth_put_reply(reply);
+
 out:
 	memcpy(&card->seqno.pdu_hdr_ack,
 		QETH_PDU_HEADER_SEQ_NO(iob->data),
@@ -2047,8 +2061,6 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 	reply->callback = reply_cb;
 	reply->param = reply_param;
 
-	init_waitqueue_head(&reply->wait_q);
-
 	while (atomic_cmpxchg(&channel->irq_pending, 0, 1)) ;
 
 	if (IS_IPA(iob->data)) {
@@ -2062,9 +2074,7 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 	}
 	qeth_prepare_control_data(card, len, iob);
 
-	spin_lock_irq(&card->lock);
-	list_add_tail(&reply->list, &card->cmd_waiter_list);
-	spin_unlock_irq(&card->lock);
+	qeth_enqueue_reply(card, reply);
 
 	timeout = jiffies + event_timeout;
 
@@ -2077,10 +2087,8 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 		QETH_DBF_MESSAGE(2, "qeth_send_control_data on device %x: ccw_device_start rc = %i\n",
 				 CARD_DEVID(card), rc);
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
-		spin_lock_irq(&card->lock);
-		list_del_init(&reply->list);
+		qeth_dequeue_reply(card, reply);
 		qeth_put_reply(reply);
-		spin_unlock_irq(&card->lock);
 		qeth_release_buffer(channel, iob);
 		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
@@ -2102,19 +2110,15 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 		}
 	}
 
+	qeth_dequeue_reply(card, reply);
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
 
 time_err:
-	reply->rc = -ETIME;
-	spin_lock_irq(&card->lock);
-	list_del_init(&reply->list);
-	spin_unlock_irq(&card->lock);
-	atomic_inc(&reply->received);
-	rc = reply->rc;
+	qeth_dequeue_reply(card, reply);
 	qeth_put_reply(reply);
-	return rc;
+	return -ETIME;
 }
 
 static int qeth_cm_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
-- 
2.16.4
