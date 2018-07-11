From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/10] s390/qeth: remove unused buffer->aob pointer
Date: Wed, 11 Jul 2018 17:42:39 +0200
Message-ID: <20180711154247.5523-3-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Except for tracing, the pointer is not used.

At the same time, accessing it from qeth_qdio_output_handler() is racy:
whenever qeth_qdio_cq_handler() gets control, its call to
qeth_qdio_handle_aob() frees the AOB.

So the AOB pointer that qeth_qdio_output_handler() stores into 'buffer'
can go stale at any time, and trigger a use-after-free.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 1 -
 drivers/s390/net/qeth_core_main.c | 7 -------
 2 files changed, 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index a246a618f9a4..0ca6ea319d88 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -465,7 +465,6 @@ struct qeth_qdio_out_buffer {
 	struct sk_buff_head skb_list;
 	int is_header[QDIO_MAX_ELEMENTS_PER_BUFFER];
 
-	struct qaob *aob;
 	struct qeth_qdio_out_q *q;
 	struct qeth_qdio_out_buffer *next_pending;
 };
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 916c17d93ddb..cfe68e3bfe7a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -473,7 +473,6 @@ static void qeth_cleanup_handled_pending(struct qeth_qdio_out_q *q, int bidx,
 	if (forced_cleanup && (atomic_read(&(q->bufs[bidx]->state)) ==
 					QETH_QDIO_BUF_HANDLED_DELAYED)) {
 		/* for recovery situations */
-		q->bufs[bidx]->aob = q->bufstates[bidx].aob;
 		qeth_init_qdio_out_buf(q, bidx);
 		QETH_CARD_TEXT(q->card, 2, "clprecov");
 	}
@@ -510,7 +509,6 @@ static void qeth_qdio_handle_aob(struct qeth_card *card,
 	}
 	qeth_notify_skbs(buffer->q, buffer, notification);
 
-	buffer->aob = NULL;
 	/* Free dangling allocations. The attached skbs are handled by
 	 * qeth_cleanup_handled_pending().
 	 */
@@ -2478,7 +2476,6 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
 	skb_queue_head_init(&newbuf->skb_list);
 	lockdep_set_class(&newbuf->skb_list.lock, &qdio_out_skb_queue_key);
 	newbuf->q = q;
-	newbuf->aob = NULL;
 	newbuf->next_pending = q->bufs[bidx];
 	atomic_set(&newbuf->state, QETH_QDIO_BUF_EMPTY);
 	q->bufs[bidx] = newbuf;
@@ -3735,11 +3732,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 				qeth_notify_skbs(queue, buffer,
 						 TX_NOTIFY_PENDING);
 			}
-			buffer->aob = queue->bufstates[bidx].aob;
 			QETH_CARD_TEXT_(queue->card, 5, "pel%d", bidx);
-			QETH_CARD_TEXT(queue->card, 5, "aob");
-			QETH_CARD_TEXT_(queue->card, 5, "%lx",
-					virt_to_phys(buffer->aob));
 
 			/* prepare the queue slot for re-use: */
 			qeth_scrub_qdio_buffer(buffer->buffer,
-- 
2.16.4
