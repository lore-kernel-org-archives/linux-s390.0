From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/10] s390/qeth: various buffer management cleanups
Date: Wed, 11 Jul 2018 17:42:38 +0200
Message-ID: <20180711154247.5523-2-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Use the new qeth_scrub_qdio_buffer() helper, remove an extra parameter
from qeth_clear_output_buffer(), init the bufstates.user field just once
(in qeth_flush_buffers()) and remove some noisy trace messages.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 66 ++++++++++++---------------------------
 1 file changed, 20 insertions(+), 46 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d01ac29fd986..916c17d93ddb 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1267,8 +1267,7 @@ static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
 }
 
 static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
-		struct qeth_qdio_out_buffer *buf,
-		enum qeth_qdio_buffer_states newbufstate)
+				     struct qeth_qdio_out_buffer *buf)
 {
 	int i;
 
@@ -1276,23 +1275,19 @@ static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 	if (buf->buffer->element[0].sflags & SBAL_SFLAGS0_PCI_REQ)
 		atomic_dec(&queue->set_pci_flags_count);
 
-	if (newbufstate == QETH_QDIO_BUF_EMPTY) {
-		qeth_release_skbs(buf);
-	}
+	qeth_release_skbs(buf);
+
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(queue->card); ++i) {
 		if (buf->buffer->element[i].addr && buf->is_header[i])
 			kmem_cache_free(qeth_core_header_cache,
 				buf->buffer->element[i].addr);
 		buf->is_header[i] = 0;
-		buf->buffer->element[i].length = 0;
-		buf->buffer->element[i].addr = NULL;
-		buf->buffer->element[i].eflags = 0;
-		buf->buffer->element[i].sflags = 0;
 	}
-	buf->buffer->element[15].eflags = 0;
-	buf->buffer->element[15].sflags = 0;
+
+	qeth_scrub_qdio_buffer(buf->buffer,
+			       QETH_MAX_BUFFER_ELEMENTS(queue->card));
 	buf->next_element_to_fill = 0;
-	atomic_set(&buf->state, newbufstate);
+	atomic_set(&buf->state, QETH_QDIO_BUF_EMPTY);
 }
 
 static void qeth_clear_outq_buffers(struct qeth_qdio_out_q *q, int free)
@@ -1303,7 +1298,7 @@ static void qeth_clear_outq_buffers(struct qeth_qdio_out_q *q, int free)
 		if (!q->bufs[j])
 			continue;
 		qeth_cleanup_handled_pending(q, j, 1);
-		qeth_clear_output_buffer(q, q->bufs[j], QETH_QDIO_BUF_EMPTY);
+		qeth_clear_output_buffer(q, q->bufs[j]);
 		if (free) {
 			kmem_cache_free(qeth_qdio_outbuf_cache, q->bufs[j]);
 			q->bufs[j] = NULL;
@@ -2473,15 +2468,12 @@ static int qeth_ulp_setup(struct qeth_card *card)
 
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
 {
-	int rc;
 	struct qeth_qdio_out_buffer *newbuf;
 
-	rc = 0;
 	newbuf = kmem_cache_zalloc(qeth_qdio_outbuf_cache, GFP_ATOMIC);
-	if (!newbuf) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!newbuf)
+		return -ENOMEM;
+
 	newbuf->buffer = q->qdio_bufs[bidx];
 	skb_queue_head_init(&newbuf->skb_list);
 	lockdep_set_class(&newbuf->skb_list.lock, &qdio_out_skb_queue_key);
@@ -2490,15 +2482,7 @@ static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *q, int bidx)
 	newbuf->next_pending = q->bufs[bidx];
 	atomic_set(&newbuf->state, QETH_QDIO_BUF_EMPTY);
 	q->bufs[bidx] = newbuf;
-	if (q->bufstates) {
-		q->bufstates[bidx].user = newbuf;
-		QETH_CARD_TEXT_(q->card, 2, "nbs%d", bidx);
-		QETH_CARD_TEXT_(q->card, 2, "%lx", (long) newbuf);
-		QETH_CARD_TEXT_(q->card, 2, "%lx",
-				(long) newbuf->next_pending);
-	}
-out:
-	return rc;
+	return 0;
 }
 
 static void qeth_free_qdio_out_buf(struct qeth_qdio_out_q *q)
@@ -2908,8 +2892,7 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 				   QDIO_MAX_BUFFERS_PER_Q);
 		for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
 			qeth_clear_output_buffer(card->qdio.out_qs[i],
-					card->qdio.out_qs[i]->bufs[j],
-					QETH_QDIO_BUF_EMPTY);
+						 card->qdio.out_qs[i]->bufs[j]);
 		}
 		card->qdio.out_qs[i]->card = card;
 		card->qdio.out_qs[i]->next_buf_to_fill = 0;
@@ -3634,10 +3617,10 @@ int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 }
 EXPORT_SYMBOL_GPL(qeth_configure_cq);
 
-
-static void qeth_qdio_cq_handler(struct qeth_card *card,
-		unsigned int qdio_err,
-		unsigned int queue, int first_element, int count) {
+static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
+				 unsigned int queue, int first_element,
+				 int count)
+{
 	struct qeth_qdio_q *cq = card->qdio.c_q;
 	int i;
 	int rc;
@@ -3663,25 +3646,17 @@ static void qeth_qdio_cq_handler(struct qeth_card *card,
 	for (i = first_element; i < first_element + count; ++i) {
 		int bidx = i % QDIO_MAX_BUFFERS_PER_Q;
 		struct qdio_buffer *buffer = cq->qdio_bufs[bidx];
-		int e;
+		int e = 0;
 
-		e = 0;
 		while ((e < QDIO_MAX_ELEMENTS_PER_BUFFER) &&
 		       buffer->element[e].addr) {
 			unsigned long phys_aob_addr;
 
 			phys_aob_addr = (unsigned long) buffer->element[e].addr;
 			qeth_qdio_handle_aob(card, phys_aob_addr);
-			buffer->element[e].addr = NULL;
-			buffer->element[e].eflags = 0;
-			buffer->element[e].sflags = 0;
-			buffer->element[e].length = 0;
-
 			++e;
 		}
-
-		buffer->element[15].eflags = 0;
-		buffer->element[15].sflags = 0;
+		qeth_scrub_qdio_buffer(buffer, QDIO_MAX_ELEMENTS_PER_BUFFER);
 	}
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, queue,
 		    card->qdio.c_q->next_buf_to_init,
@@ -3782,8 +3757,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 				qeth_notify_skbs(queue, buffer, n);
 			}
 
-			qeth_clear_output_buffer(queue, buffer,
-						QETH_QDIO_BUF_EMPTY);
+			qeth_clear_output_buffer(queue, buffer);
 		}
 		qeth_cleanup_handled_pending(queue, bidx, 0);
 	}
-- 
2.16.4
