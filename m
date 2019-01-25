Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/8] s390/qeth: streamline TX buffer management
Date: Fri, 25 Jan 2019 15:44:16 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Consolidate the code that marks the current buffer to be flushed, and
let qeth_fill_buffer() advance the Output Queue's buffer cursor.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e63e03143ca7..e08b924f7454 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3928,7 +3928,6 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 {
 	struct qdio_buffer *buffer = buf->buffer;
 	bool is_first_elem = true;
-	int flush_cnt = 0;
 
 	__skb_queue_tail(&buf->skb_list, skb);
 
@@ -3949,24 +3948,22 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 
 	if (!queue->do_pack) {
 		QETH_CARD_TEXT(queue->card, 6, "fillbfnp");
-		/* set state to PRIMED -> will be flushed */
-		atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
-		flush_cnt = 1;
 	} else {
 		QETH_CARD_TEXT(queue->card, 6, "fillbfpa");
 		if (queue->card->options.performance_stats)
 			queue->card->perf_stats.skbs_sent_pack++;
-		if (buf->next_element_to_fill >=
-				QETH_MAX_BUFFER_ELEMENTS(queue->card)) {
-			/*
-			 * packed buffer if full -> set state PRIMED
-			 * -> will be flushed
-			 */
-			atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
-			flush_cnt = 1;
-		}
+
+		/* If the buffer still has free elements, keep using it. */
+		if (buf->next_element_to_fill <
+		    QETH_MAX_BUFFER_ELEMENTS(queue->card))
+			return 0;
 	}
-	return flush_cnt;
+
+	/* flush out the buffer */
+	atomic_set(&buf->state, QETH_QDIO_BUF_PRIMED);
+	queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
+				  QDIO_MAX_BUFFERS_PER_Q;
+	return 1;
 }
 
 static int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue,
@@ -3982,7 +3979,6 @@ static int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue,
 	 */
 	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY)
 		return -EBUSY;
-	queue->next_buf_to_fill = (index + 1) % QDIO_MAX_BUFFERS_PER_Q;
 	qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len);
 	qeth_flush_buffers(queue, index, 1);
 	return 0;
@@ -4040,10 +4036,9 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			}
 		}
 	}
-	tmp = qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len);
-	queue->next_buf_to_fill = (queue->next_buf_to_fill + tmp) %
-				  QDIO_MAX_BUFFERS_PER_Q;
-	flush_count += tmp;
+
+	flush_count += qeth_fill_buffer(queue, buffer, skb, hdr, offset,
+					hd_len);
 	if (flush_count)
 		qeth_flush_buffers(queue, start_index, flush_count);
 	else if (!atomic_read(&queue->set_pci_flags_count))
-- 
2.16.4
