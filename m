Return-Path: <SRS0=ZPcH=QL=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/4] s390/qeth: fix use-after-free in error path
Date: Mon,  4 Feb 2019 17:40:07 +0100
In-Reply-To: <20190204164009.7245-1-jwi@linux.ibm.com>
References: <20190204164009.7245-1-jwi@linux.ibm.com>
Message-Id: <20190204164009.7245-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The error path in qeth_alloc_qdio_buffers() that takes care of
cleaning up the Output Queues is buggy. It first frees the queue, but
then calls qeth_clear_outq_buffers() with that very queue struct.

Make the call to qeth_clear_outq_buffers() part of the free action
(in the correct order), and while at it fix the naming of the helper.

Fixes: 0da9581ddb0f ("qeth: exploit asynchronous delivery of storage blocks")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ca62e7d3ee93..30679bfc8a1b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2395,11 +2395,12 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
 	return 0;
 }
 
-static void qeth_free_qdio_out_buf(struct qeth_qdio_out_q *q)
+static void qeth_free_output_queue(struct qeth_qdio_out_q *q)
 {
 	if (!q)
 		return;
 
+	qeth_clear_outq_buffers(q, 1);
 	qdio_free_buffers(q->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
 	kfree(q);
 }
@@ -2473,10 +2474,8 @@ static int qeth_alloc_qdio_buffers(struct qeth_card *card)
 		card->qdio.out_qs[i]->bufs[j] = NULL;
 	}
 out_freeoutq:
-	while (i > 0) {
-		qeth_free_qdio_out_buf(card->qdio.out_qs[--i]);
-		qeth_clear_outq_buffers(card->qdio.out_qs[i], 1);
-	}
+	while (i > 0)
+		qeth_free_output_queue(card->qdio.out_qs[--i]);
 	kfree(card->qdio.out_qs);
 	card->qdio.out_qs = NULL;
 out_freepool:
@@ -2509,10 +2508,8 @@ static void qeth_free_qdio_buffers(struct qeth_card *card)
 	qeth_free_buffer_pool(card);
 	/* free outbound qdio_qs */
 	if (card->qdio.out_qs) {
-		for (i = 0; i < card->qdio.no_out_queues; ++i) {
-			qeth_clear_outq_buffers(card->qdio.out_qs[i], 1);
-			qeth_free_qdio_out_buf(card->qdio.out_qs[i]);
-		}
+		for (i = 0; i < card->qdio.no_out_queues; i++)
+			qeth_free_output_queue(card->qdio.out_qs[i]);
 		kfree(card->qdio.out_qs);
 		card->qdio.out_qs = NULL;
 	}
-- 
2.16.4
