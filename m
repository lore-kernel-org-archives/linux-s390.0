Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5588 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgKTJJu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 04:09:50 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 4/4] s390/qeth: fix tear down of async TX buffers
Date: Fri, 20 Nov 2020 10:09:39 +0100
Message-Id: <20201120090939.101406-5-jwi@linux.ibm.com>
In-Reply-To: <20201120090939.101406-1-jwi@linux.ibm.com>
References: <20201120090939.101406-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When qeth_iqd_tx_complete() detects that a TX buffer requires additional
async completion via QAOB, it might fail to replace the queue entry's
metadata (and ends up triggering recovery).

Assume now that the device gets torn down, overruling the recovery.
If the QAOB notification then arrives before the tear down has
sufficiently progressed, the buffer state is changed to
QETH_QDIO_BUF_HANDLED_DELAYED by qeth_qdio_handle_aob().

The tear down code calls qeth_drain_output_queue(), where
qeth_cleanup_handled_pending() will then attempt to replace such a
buffer _again_. If it succeeds this time, the buffer ends up dangling in
its replacement's ->next_pending list ... where it will never be freed,
since there's no further call to qeth_cleanup_handled_pending().

But the second attempt isn't actually needed, we can simply leave the
buffer on the queue and re-use it after a potential recovery has
completed. The qeth_clear_output_buffer() in qeth_drain_output_queue()
will ensure that it's in a clean state again.

Fixes: 72861ae792c2 ("qeth: recovery through asynchronous delivery")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 48f9e4a027bf..e27319de7b00 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -500,12 +500,6 @@ static void qeth_cleanup_handled_pending(struct qeth_qdio_out_q *q, int bidx,
 
 		}
 	}
-	if (forced_cleanup && (atomic_read(&(q->bufs[bidx]->state)) ==
-					QETH_QDIO_BUF_HANDLED_DELAYED)) {
-		/* for recovery situations */
-		qeth_init_qdio_out_buf(q, bidx);
-		QETH_CARD_TEXT(q->card, 2, "clprecov");
-	}
 }
 
 static void qeth_qdio_handle_aob(struct qeth_card *card,
-- 
2.17.1
