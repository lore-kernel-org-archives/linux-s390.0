Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/8] s390/qeth: cache max number of available buffer elements
Date: Thu, 25 Apr 2019 18:25:59 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The QETH_MAX_BUFFER_ELEMENTS() macro effectively returns a constant
value. To avoid some redundant pointer chasing and computations in the
xmit hot path, cache this value in the queue struct.

Take this as opportunity to shrink some of the queue struct's fields to
their appropriate value range, slightly reducing its total size.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 10 ++++------
 drivers/s390/net/qeth_core_main.c | 34 +++++++++++++++++-----------------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 3 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 92441593caf3..73afbb8b69e5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -484,14 +484,12 @@ struct qeth_qdio_out_q {
 	struct qeth_qdio_out_buffer *bufs[QDIO_MAX_BUFFERS_PER_Q];
 	struct qdio_outbuf_state *bufstates; /* convenience pointer */
 	struct qeth_out_q_stats stats;
-	int queue_no;
+	u8 next_buf_to_fill;
+	u8 max_elements;
+	u8 queue_no;
+	u8 do_pack;
 	struct qeth_card *card;
 	atomic_t state;
-	int do_pack;
-	/*
-	 * index of buffer to be filled by driver; state EMPTY or PACKING
-	 */
-	int next_buf_to_fill;
 	/*
 	 * number of buffers that are currently filled (PRIMED)
 	 * -> these buffers are hardware-owned
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5d8777c4d1a6..009f2c0ec504 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1165,15 +1165,14 @@ static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 
 	qeth_release_skbs(buf);
 
-	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(queue->card); ++i) {
+	for (i = 0; i < queue->max_elements; ++i) {
 		if (buf->buffer->element[i].addr && buf->is_header[i])
 			kmem_cache_free(qeth_core_header_cache,
 				buf->buffer->element[i].addr);
 		buf->is_header[i] = 0;
 	}
 
-	qeth_scrub_qdio_buffer(buf->buffer,
-			       QETH_MAX_BUFFER_ELEMENTS(queue->card));
+	qeth_scrub_qdio_buffer(buf->buffer, queue->max_elements);
 	buf->next_element_to_fill = 0;
 	atomic_set(&buf->state, QETH_QDIO_BUF_EMPTY);
 }
@@ -2727,14 +2726,15 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 
 	/* outbound queue */
 	for (i = 0; i < card->qdio.no_out_queues; ++i) {
-		qdio_reset_buffers(card->qdio.out_qs[i]->qdio_bufs,
-				   QDIO_MAX_BUFFERS_PER_Q);
-		card->qdio.out_qs[i]->next_buf_to_fill = 0;
-		card->qdio.out_qs[i]->do_pack = 0;
-		atomic_set(&card->qdio.out_qs[i]->used_buffers, 0);
-		atomic_set(&card->qdio.out_qs[i]->set_pci_flags_count, 0);
-		atomic_set(&card->qdio.out_qs[i]->state,
-			   QETH_OUT_Q_UNLOCKED);
+		struct qeth_qdio_out_q *queue = card->qdio.out_qs[i];
+
+		qdio_reset_buffers(queue->qdio_bufs, QDIO_MAX_BUFFERS_PER_Q);
+		queue->max_elements = QETH_MAX_BUFFER_ELEMENTS(card);
+		queue->next_buf_to_fill = 0;
+		queue->do_pack = 0;
+		atomic_set(&queue->used_buffers, 0);
+		atomic_set(&queue->set_pci_flags_count, 0);
+		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 	}
 	return 0;
 }
@@ -3558,7 +3558,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 
 			/* prepare the queue slot for re-use: */
 			qeth_scrub_qdio_buffer(buffer->buffer,
-					       QETH_MAX_BUFFER_ELEMENTS(card));
+					       queue->max_elements);
 			if (qeth_init_qdio_out_buf(queue, bidx)) {
 				QETH_CARD_TEXT(card, 2, "outofbuf");
 				qeth_schedule_recovery(card);
@@ -3705,8 +3705,8 @@ static int qeth_add_hw_header(struct qeth_qdio_out_q *queue,
 			      unsigned int hdr_len, unsigned int proto_len,
 			      unsigned int *elements)
 {
-	const unsigned int max_elements = QETH_MAX_BUFFER_ELEMENTS(queue->card);
 	const unsigned int contiguous = proto_len ? proto_len : 1;
+	const unsigned int max_elements = queue->max_elements;
 	unsigned int __elements;
 	addr_t start, end;
 	bool push_ok;
@@ -3878,8 +3878,8 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 
 		QETH_TXQ_STAT_INC(queue, skbs_pack);
 		/* If the buffer still has free elements, keep using it. */
-		if (!flush && buf->next_element_to_fill <
-			      QETH_MAX_BUFFER_ELEMENTS(queue->card))
+		if (!flush &&
+		    buf->next_element_to_fill < queue->max_elements)
 			return 0;
 	}
 
@@ -3959,8 +3959,8 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 	if (queue->do_pack) {
 		do_pack = 1;
 		/* does packet fit in current buffer? */
-		if ((QETH_MAX_BUFFER_ELEMENTS(card) -
-		    buffer->next_element_to_fill) < elements_needed) {
+		if (buffer->next_element_to_fill + elements_needed >
+		    queue->max_elements) {
 			/* ... no -> set state PRIMED */
 			atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
 			flush_count++;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index fb21136c0ec2..cee9a99dd463 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -581,7 +581,7 @@ static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
 	}
 
 	elements += qeth_count_elements(skb, hd_len);
-	if (elements > QETH_MAX_BUFFER_ELEMENTS(card)) {
+	if (elements > queue->max_elements) {
 		rc = -E2BIG;
 		goto out;
 	}
-- 
2.16.4
