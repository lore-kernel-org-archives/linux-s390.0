Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net] s390/qeth: serialize cmd reply with concurrent timeout
Date: Mon, 12 Aug 2019 16:44:35 +0200
Message-Id: <20190812144435.67451-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Callbacks for a cmd reply run outside the protection of card->lock, to
allow for additional cmds to be issued & enqueued in parallel.

When qeth_send_control_data() bails out for a cmd without having
received a reply (eg. due to timeout), its callback may concurrently be
processing a reply that just arrived. In this case, the callback
potentially accesses a stale reply->reply_param area that eg. was
on-stack and has already been released.

To avoid this race, add some locking so that qeth_send_control_data()
can (1) wait for a concurrently running callback, and (2) zap any
pending callback that still wants to run.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c7ee07ce3615..28db887d38ed 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -629,6 +629,7 @@ struct qeth_seqno {
 struct qeth_reply {
 	struct list_head list;
 	struct completion received;
+	spinlock_t lock;
 	int (*callback)(struct qeth_card *, struct qeth_reply *,
 		unsigned long);
 	u32 seqno;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4d0caeebc802..9c3310c4d61d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -544,6 +544,7 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 	if (reply) {
 		refcount_set(&reply->refcnt, 1);
 		init_completion(&reply->received);
+		spin_lock_init(&reply->lock);
 	}
 	return reply;
 }
@@ -799,6 +800,13 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 
 	if (!reply->callback) {
 		rc = 0;
+		goto no_callback;
+	}
+
+	spin_lock_irqsave(&reply->lock, flags);
+	if (reply->rc) {
+		/* Bail out when the requestor has already left: */
+		rc = reply->rc;
 	} else {
 		if (cmd) {
 			reply->offset = (u16)((char *)cmd - (char *)iob->data);
@@ -807,7 +815,9 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 			rc = reply->callback(card, reply, (unsigned long)iob);
 		}
 	}
+	spin_unlock_irqrestore(&reply->lock, flags);
 
+no_callback:
 	if (rc <= 0)
 		qeth_notify_reply(reply, rc);
 	qeth_put_reply(reply);
@@ -1749,6 +1759,16 @@ static int qeth_send_control_data(struct qeth_card *card,
 		rc = (timeout == -ERESTARTSYS) ? -EINTR : -ETIME;
 
 	qeth_dequeue_reply(card, reply);
+
+	if (reply_cb) {
+		/* Wait until the callback for a late reply has completed: */
+		spin_lock_irq(&reply->lock);
+		if (rc)
+			/* Zap any callback that's still pending: */
+			reply->rc = rc;
+		spin_unlock_irq(&reply->lock);
+	}
+
 	if (!rc)
 		rc = reply->rc;
 	qeth_put_reply(reply);
-- 
2.17.1
