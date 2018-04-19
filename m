From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 5/6] s390/qeth: fix request-side race during cmd IO timeout
Date: Thu, 19 Apr 2018 12:52:10 +0200
Message-ID: <20180419105211.83935-6-jwi@linux.ibm.com>
References: <20180419105211.83935-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419105211.83935-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

Submitting a cmd IO request (usually on the WRITE device, but for IDX
also on the READ device) is currently done with ccw_device_start()
and a manual timeout in the caller.
On timeout, the caller cleans up the related resources (eg. IO buffer).
But 1) the IO might still be active and utilize those resources, and
    2) when the IO completes, qeth_irq() will attempt to clean up the
       same resources again.

Instead of introducing additional resource locking, switch to
ccw_device_start_timeout() to ensure IO termination after timeout, and
let the IRQ handler alone deal with cleaning up after a request.

This also removes a stray write->irq_pending reset from
clear_ipacmd_list(). The routine doesn't terminate any pending IO on
the WRITE device, so this should be handled properly via IO timeout
in the IRQ handler.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 51 ++++++++++++++++++++-------------------
 drivers/s390/net/qeth_core_mpc.h  | 12 +++++++++
 drivers/s390/net/qeth_l2_main.c   |  4 +--
 3 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9a08b545d018..9b22d5d496ae 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -706,7 +706,6 @@ void qeth_clear_ipacmd_list(struct qeth_card *card)
 		qeth_put_reply(reply);
 	}
 	spin_unlock_irqrestore(&card->lock, flags);
-	atomic_set(&card->write.irq_pending, 0);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_ipacmd_list);
 
@@ -1098,14 +1097,9 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 {
 	int rc;
 	int cstat, dstat;
+	struct qeth_cmd_buffer *iob = NULL;
 	struct qeth_channel *channel;
 	struct qeth_card *card;
-	struct qeth_cmd_buffer *iob;
-
-	if (__qeth_check_irb_error(cdev, intparm, irb))
-		return;
-	cstat = irb->scsw.cmd.cstat;
-	dstat = irb->scsw.cmd.dstat;
 
 	card = CARD_FROM_CDEV(cdev);
 	if (!card)
@@ -1123,6 +1117,19 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		channel = &card->data;
 		QETH_CARD_TEXT(card, 5, "data");
 	}
+
+	if (qeth_intparm_is_iob(intparm))
+		iob = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
+
+	if (__qeth_check_irb_error(cdev, intparm, irb)) {
+		/* IO was terminated, free its resources. */
+		if (iob)
+			qeth_release_buffer(iob->channel, iob);
+		atomic_set(&channel->irq_pending, 0);
+		wake_up(&card->wait_q);
+		return;
+	}
+
 	atomic_set(&channel->irq_pending, 0);
 
 	if (irb->scsw.cmd.fctl & (SCSW_FCTL_CLEAR_FUNC))
@@ -1146,6 +1153,10 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		/* we don't have to handle this further */
 		intparm = 0;
 	}
+
+	cstat = irb->scsw.cmd.cstat;
+	dstat = irb->scsw.cmd.dstat;
+
 	if ((dstat & DEV_STAT_UNIT_EXCEP) ||
 	    (dstat & DEV_STAT_UNIT_CHECK) ||
 	    (cstat)) {
@@ -1184,11 +1195,8 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	    channel->state == CH_STATE_UP)
 		__qeth_issue_next_read(card);
 
-	if (intparm) {
-		iob = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
-		if (iob->callback)
-			iob->callback(iob->channel, iob);
-	}
+	if (iob && iob->callback)
+		iob->callback(iob->channel, iob);
 
 out:
 	wake_up(&card->wait_q);
@@ -1859,8 +1867,8 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_start(channel->ccwdev,
-			      &channel->ccw, (addr_t) iob, 0, 0);
+	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 
 	if (rc) {
@@ -1877,7 +1885,6 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 	if (channel->state != CH_STATE_UP) {
 		rc = -ETIME;
 		QETH_DBF_TEXT_(SETUP, 2, "3err%d", rc);
-		qeth_clear_cmd_buffers(channel);
 	} else
 		rc = 0;
 	return rc;
@@ -1931,8 +1938,8 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(channel->ccwdev), flags);
-	rc = ccw_device_start(channel->ccwdev,
-			      &channel->ccw, (addr_t) iob, 0, 0);
+	rc = ccw_device_start_timeout(channel->ccwdev, &channel->ccw,
+				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(channel->ccwdev), flags);
 
 	if (rc) {
@@ -1953,7 +1960,6 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 		QETH_DBF_MESSAGE(2, "%s IDX activate timed out\n",
 			dev_name(&channel->ccwdev->dev));
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", -ETIME);
-		qeth_clear_cmd_buffers(channel);
 		return -ETIME;
 	}
 	return qeth_idx_activate_get_answer(channel, idx_reply_cb);
@@ -2155,8 +2161,8 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
-	rc = ccw_device_start(card->write.ccwdev, &card->write.ccw,
-			      (addr_t) iob, 0, 0);
+	rc = ccw_device_start_timeout(CARD_WDEV(card), &card->write.ccw,
+				      (addr_t) iob, 0, 0, event_timeout);
 	spin_unlock_irqrestore(get_ccwdev_lock(card->write.ccwdev), flags);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "%s qeth_send_control_data: "
@@ -2188,8 +2194,6 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 		}
 	}
 
-	if (reply->rc == -EIO)
-		goto error;
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
@@ -2200,9 +2204,6 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	list_del_init(&reply->list);
 	spin_unlock_irqrestore(&reply->card->lock, flags);
 	atomic_inc(&reply->received);
-error:
-	atomic_set(&card->write.irq_pending, 0);
-	qeth_release_buffer(iob->channel, iob);
 	rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 619f897b4bb0..f4d1ec0b8f5a 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -35,6 +35,18 @@ extern unsigned char IPA_PDU_HEADER[];
 #define QETH_HALT_CHANNEL_PARM	-11
 #define QETH_RCD_PARM -12
 
+static inline bool qeth_intparm_is_iob(unsigned long intparm)
+{
+	switch (intparm) {
+	case QETH_CLEAR_CHANNEL_PARM:
+	case QETH_HALT_CHANNEL_PARM:
+	case QETH_RCD_PARM:
+	case 0:
+		return false;
+	}
+	return true;
+}
+
 /*****************************************************************************/
 /* IP Assist related definitions                                             */
 /*****************************************************************************/
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 830ca56a62e5..2f1c13226a7a 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1346,8 +1346,8 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 	qeth_prepare_control_data(card, len, iob);
 	QETH_CARD_TEXT(card, 6, "osnoirqp");
 	spin_lock_irqsave(get_ccwdev_lock(card->write.ccwdev), flags);
-	rc = ccw_device_start(card->write.ccwdev, &card->write.ccw,
-			      (addr_t) iob, 0, 0);
+	rc = ccw_device_start_timeout(CARD_WDEV(card), &card->write.ccw,
+				      (addr_t) iob, 0, 0, QETH_IPA_TIMEOUT);
 	spin_unlock_irqrestore(get_ccwdev_lock(card->write.ccwdev), flags);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "qeth_osn_send_control_data: "
-- 
2.13.5
