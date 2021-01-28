Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231409AbhA1L0o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:26:44 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/5] s390/qeth: don't fake a TX completion interrupt after TX error
Date: Thu, 28 Jan 2021 12:25:51 +0100
Message-Id: <20210128112551.18780-6-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
References: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When do_qdio() returns with an unexpected error, qeth_flush_buffers()
kicks off a recovery action.

In such a case there's no point in starting TX completion processing,
the device gets torn down anyway. So take a closer look at do_qdio()'s
return value, and skip the TX completion processing accordingly.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 34 ++++++++++++++++---------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index de9d27e1c529..ea2e139cd592 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3692,24 +3692,27 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 	rc = do_QDIO(CARD_DDEV(queue->card), qdio_flags,
 		     queue->queue_no, index, count);
 
-	/* Fake the TX completion interrupt: */
-	if (IS_IQD(card)) {
-		unsigned int frames = READ_ONCE(queue->max_coalesced_frames);
-		unsigned int usecs = READ_ONCE(queue->coalesce_usecs);
+	switch (rc) {
+	case 0:
+	case -ENOBUFS:
+		/* ignore temporary SIGA errors without busy condition */
 
-		if (frames && queue->coalesced_frames >= frames) {
-			napi_schedule(&queue->napi);
-			queue->coalesced_frames = 0;
-			QETH_TXQ_STAT_INC(queue, coal_frames);
-		} else if (usecs) {
-			qeth_tx_arm_timer(queue, usecs);
+		/* Fake the TX completion interrupt: */
+		if (IS_IQD(card)) {
+			unsigned int frames = READ_ONCE(queue->max_coalesced_frames);
+			unsigned int usecs = READ_ONCE(queue->coalesce_usecs);
+
+			if (frames && queue->coalesced_frames >= frames) {
+				napi_schedule(&queue->napi);
+				queue->coalesced_frames = 0;
+				QETH_TXQ_STAT_INC(queue, coal_frames);
+			} else if (usecs) {
+				qeth_tx_arm_timer(queue, usecs);
+			}
 		}
-	}
 
-	if (rc) {
-		/* ignore temporary SIGA errors without busy condition */
-		if (rc == -ENOBUFS)
-			return;
+		break;
+	default:
 		QETH_CARD_TEXT(queue->card, 2, "flushbuf");
 		QETH_CARD_TEXT_(queue->card, 2, " q%d", queue->queue_no);
 		QETH_CARD_TEXT_(queue->card, 2, " idx%d", index);
@@ -3719,7 +3722,6 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 		/* this must not happen under normal circumstances. if it
 		 * happens something is really wrong -> recover */
 		qeth_schedule_recovery(queue->card);
-		return;
 	}
 }
 
-- 
2.17.1
