Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/9] s390/qeth: wake up all waiters from qeth_irq()
Date: Wed, 18 Dec 2019 17:34:43 +0100
In-Reply-To: <20191218163450.36731-1-jwi@linux.ibm.com>
References: <20191218163450.36731-1-jwi@linux.ibm.com>
Message-Id: <20191218163450.36731-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

card->wait_q is shared by different users, for different wake-up
conditions. qeth_irq() can potentially trigger multiple of these
conditions:
1) A change to channel->irq_pending, which qeth_send_control_data() is
   waiting for.
2) A change to card->state, which qeth_clear_channel() and
   qeth_halt_channel() are waiting for.

As qeth_irq() does only a single wake_up(), we might miss to wake up
a second eligible waiter. Luckily all waiters are guarded with a
timeout, so this situation should recover on its own eventually.

To make things work robustly, add an additional wake_up() for changes
to channel->state. And extract a helper that updates
channel->irq_pending along with the needed wake_up().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  7 +++++++
 drivers/s390/net/qeth_core_main.c | 27 +++++++++++----------------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index a23875a4fa2b..b54ef12840a2 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -862,6 +862,13 @@ static inline bool qeth_card_hw_is_reachable(struct qeth_card *card)
 	return card->state == CARD_STATE_SOFTSETUP;
 }
 
+static inline void qeth_unlock_channel(struct qeth_card *card,
+				       struct qeth_channel *channel)
+{
+	atomic_set(&channel->irq_pending, 0);
+	wake_up(&card->wait_q);
+}
+
 struct qeth_trap_id {
 	__u16 lparnr;
 	char vmname[8];
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 3d2374801308..38f3ed7567bc 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -520,11 +520,10 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 	} else {
 		QETH_DBF_MESSAGE(2, "error %i on device %x when starting next read ccw!\n",
 				 rc, CARD_DEVID(card));
-		atomic_set(&channel->irq_pending, 0);
+		qeth_unlock_channel(card, channel);
 		qeth_put_cmd(iob);
 		card->read_or_write_problem = 1;
 		qeth_schedule_recovery(card);
-		wake_up(&card->wait_q);
 	}
 	return rc;
 }
@@ -1001,24 +1000,25 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	}
 
 	channel->active_cmd = NULL;
+	qeth_unlock_channel(card, channel);
 
 	rc = qeth_check_irb_error(card, cdev, irb);
 	if (rc) {
 		/* IO was terminated, free its resources. */
 		if (iob)
 			qeth_cancel_cmd(iob, rc);
-		atomic_set(&channel->irq_pending, 0);
-		wake_up(&card->wait_q);
 		return;
 	}
 
-	atomic_set(&channel->irq_pending, 0);
-
-	if (irb->scsw.cmd.fctl & (SCSW_FCTL_CLEAR_FUNC))
+	if (irb->scsw.cmd.fctl & SCSW_FCTL_CLEAR_FUNC) {
 		channel->state = CH_STATE_STOPPED;
+		wake_up(&card->wait_q);
+	}
 
-	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC))
+	if (irb->scsw.cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		channel->state = CH_STATE_HALTED;
+		wake_up(&card->wait_q);
+	}
 
 	if (iob && (irb->scsw.cmd.fctl & (SCSW_FCTL_CLEAR_FUNC |
 					  SCSW_FCTL_HALT_FUNC))) {
@@ -1052,7 +1052,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 				qeth_cancel_cmd(iob, rc);
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
-			goto out;
+			return;
 		}
 	}
 
@@ -1060,16 +1060,12 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		/* sanity check: */
 		if (irb->scsw.cmd.count > iob->length) {
 			qeth_cancel_cmd(iob, -EIO);
-			goto out;
+			return;
 		}
 		if (iob->callback)
 			iob->callback(card, iob,
 				      iob->length - irb->scsw.cmd.count);
 	}
-
-out:
-	wake_up(&card->wait_q);
-	return;
 }
 
 static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
@@ -1780,8 +1776,7 @@ static int qeth_send_control_data(struct qeth_card *card,
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
 		qeth_dequeue_cmd(card, iob);
 		qeth_put_cmd(iob);
-		atomic_set(&channel->irq_pending, 0);
-		wake_up(&card->wait_q);
+		qeth_unlock_channel(card, channel);
 		goto out;
 	}
 
-- 
2.17.1
