Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38862 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbgKTJJw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 04:09:52 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/4] s390/qeth: fix af_iucv notification race
Date: Fri, 20 Nov 2020 10:09:38 +0100
Message-Id: <20201120090939.101406-4-jwi@linux.ibm.com>
In-Reply-To: <20201120090939.101406-1-jwi@linux.ibm.com>
References: <20201120090939.101406-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The two expected notification sequences are
1. TX_NOTIFY_PENDING with a subsequent TX_NOTIFY_DELAYED_*, when
   our TX completion code first observed the pending TX and the QAOB
   then completes at a later time; or
2. TX_NOTIFY_OK, when qeth_qdio_handle_aob() picked up the QAOB
   completion before our TX completion code even noticed that the TX
   was pending.

But as qeth_iqd_tx_complete() and qeth_qdio_handle_aob() can run
concurrently, we may end up with a race that results in a sequence of
TX_NOTIFY_DELAYED_* followed by TX_NOTIFY_PENDING. Which would confuse
the af_iucv code in its tracking of pending transmits.

Rework the notification code, so that qeth_qdio_handle_aob() defers its
notification if the TX completion code is still active.

Fixes: b333293058aa ("qeth: add support for af_iucv HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  9 ++--
 drivers/s390/net/qeth_core_main.c | 73 ++++++++++++++++++++++---------
 2 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f73b4756ed5e..b235393e091c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -417,10 +417,13 @@ enum qeth_qdio_out_buffer_state {
 	QETH_QDIO_BUF_EMPTY,
 	/* Filled by driver; owned by hardware in order to be sent. */
 	QETH_QDIO_BUF_PRIMED,
-	/* Identified to be pending in TPQ. */
+	/* Discovered by the TX completion code: */
 	QETH_QDIO_BUF_PENDING,
-	/* Found in completion queue. */
-	QETH_QDIO_BUF_IN_CQ,
+	/* Finished by the TX completion code: */
+	QETH_QDIO_BUF_NEED_QAOB,
+	/* Received QAOB notification on CQ: */
+	QETH_QDIO_BUF_QAOB_OK,
+	QETH_QDIO_BUF_QAOB_ERROR,
 	/* Handled via transfer pending / completion queue. */
 	QETH_QDIO_BUF_HANDLED_DELAYED,
 };
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 715f440bdc7c..48f9e4a027bf 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -511,6 +511,7 @@ static void qeth_cleanup_handled_pending(struct qeth_qdio_out_q *q, int bidx,
 static void qeth_qdio_handle_aob(struct qeth_card *card,
 				 unsigned long phys_aob_addr)
 {
+	enum qeth_qdio_out_buffer_state new_state = QETH_QDIO_BUF_QAOB_OK;
 	struct qaob *aob;
 	struct qeth_qdio_out_buffer *buffer;
 	enum iucv_tx_notify notification;
@@ -522,22 +523,6 @@ static void qeth_qdio_handle_aob(struct qeth_card *card,
 	buffer = (struct qeth_qdio_out_buffer *) aob->user1;
 	QETH_CARD_TEXT_(card, 5, "%lx", aob->user1);
 
-	if (atomic_cmpxchg(&buffer->state, QETH_QDIO_BUF_PRIMED,
-			   QETH_QDIO_BUF_IN_CQ) == QETH_QDIO_BUF_PRIMED) {
-		notification = TX_NOTIFY_OK;
-	} else {
-		WARN_ON_ONCE(atomic_read(&buffer->state) !=
-							QETH_QDIO_BUF_PENDING);
-		atomic_set(&buffer->state, QETH_QDIO_BUF_IN_CQ);
-		notification = TX_NOTIFY_DELAYED_OK;
-	}
-
-	if (aob->aorc != 0)  {
-		QETH_CARD_TEXT_(card, 2, "aorc%02X", aob->aorc);
-		notification = qeth_compute_cq_notification(aob->aorc, 1);
-	}
-	qeth_notify_skbs(buffer->q, buffer, notification);
-
 	/* Free dangling allocations. The attached skbs are handled by
 	 * qeth_cleanup_handled_pending().
 	 */
@@ -549,7 +534,33 @@ static void qeth_qdio_handle_aob(struct qeth_card *card,
 		if (data && buffer->is_header[i])
 			kmem_cache_free(qeth_core_header_cache, data);
 	}
-	atomic_set(&buffer->state, QETH_QDIO_BUF_HANDLED_DELAYED);
+
+	if (aob->aorc) {
+		QETH_CARD_TEXT_(card, 2, "aorc%02X", aob->aorc);
+		new_state = QETH_QDIO_BUF_QAOB_ERROR;
+	}
+
+	switch (atomic_xchg(&buffer->state, new_state)) {
+	case QETH_QDIO_BUF_PRIMED:
+		/* Faster than TX completion code. */
+		notification = qeth_compute_cq_notification(aob->aorc, 0);
+		qeth_notify_skbs(buffer->q, buffer, notification);
+		atomic_set(&buffer->state, QETH_QDIO_BUF_HANDLED_DELAYED);
+		break;
+	case QETH_QDIO_BUF_PENDING:
+		/* TX completion code is active and will handle the async
+		 * completion for us.
+		 */
+		break;
+	case QETH_QDIO_BUF_NEED_QAOB:
+		/* TX completion code is already finished. */
+		notification = qeth_compute_cq_notification(aob->aorc, 1);
+		qeth_notify_skbs(buffer->q, buffer, notification);
+		atomic_set(&buffer->state, QETH_QDIO_BUF_HANDLED_DELAYED);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
 
 	qdio_release_aob(aob);
 }
@@ -1417,9 +1428,6 @@ static void qeth_tx_complete_buf(struct qeth_qdio_out_buffer *buf, bool error,
 	struct qeth_qdio_out_q *queue = buf->q;
 	struct sk_buff *skb;
 
-	/* release may never happen from within CQ tasklet scope */
-	WARN_ON_ONCE(atomic_read(&buf->state) == QETH_QDIO_BUF_IN_CQ);
-
 	if (atomic_read(&buf->state) == QETH_QDIO_BUF_PENDING)
 		qeth_notify_skbs(queue, buf, TX_NOTIFY_GENERALERROR);
 
@@ -5870,9 +5878,32 @@ static void qeth_iqd_tx_complete(struct qeth_qdio_out_q *queue,
 
 		if (atomic_cmpxchg(&buffer->state, QETH_QDIO_BUF_PRIMED,
 						   QETH_QDIO_BUF_PENDING) ==
-		    QETH_QDIO_BUF_PRIMED)
+		    QETH_QDIO_BUF_PRIMED) {
 			qeth_notify_skbs(queue, buffer, TX_NOTIFY_PENDING);
 
+			/* Handle race with qeth_qdio_handle_aob(): */
+			switch (atomic_xchg(&buffer->state,
+					    QETH_QDIO_BUF_NEED_QAOB)) {
+			case QETH_QDIO_BUF_PENDING:
+				/* No concurrent QAOB notification. */
+				break;
+			case QETH_QDIO_BUF_QAOB_OK:
+				qeth_notify_skbs(queue, buffer,
+						 TX_NOTIFY_DELAYED_OK);
+				atomic_set(&buffer->state,
+					   QETH_QDIO_BUF_HANDLED_DELAYED);
+				break;
+			case QETH_QDIO_BUF_QAOB_ERROR:
+				qeth_notify_skbs(queue, buffer,
+						 TX_NOTIFY_DELAYED_GENERALERROR);
+				atomic_set(&buffer->state,
+					   QETH_QDIO_BUF_HANDLED_DELAYED);
+				break;
+			default:
+				WARN_ON_ONCE(1);
+			}
+		}
+
 		QETH_CARD_TEXT_(card, 5, "pel%u", bidx);
 
 		/* prepare the queue slot for re-use: */
-- 
2.17.1
