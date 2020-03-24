Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/11] s390/qeth: simplify RX buffer tracking
Date: Tue, 24 Mar 2020 19:24:38 +0100
In-Reply-To: <20200324182448.95362-1-jwi@linux.ibm.com>
References: <20200324182448.95362-1-jwi@linux.ibm.com>
Message-Id: <20200324182448.95362-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Since RX buffers may contain multiple packets, qeth's NAPI poll code can
exhaust its budget in the middle of an RX buffer. Thus we keep track of
our current position within the active RX buffer, so we can resume
processing here in the next NAPI poll period.

Clean up that code by tracking the index of the active buffer element,
instead of a pointer to it.
Also simplify the code that advances to the next RX buffer when the
current buffer has been fully processed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 arch/s390/include/asm/qdio.h      |  2 ++
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 30 ++++++++++++------------------
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index 1e3517b0518b..6ea3a1d5fe7f 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -222,6 +222,8 @@ struct qdio_buffer {
 	struct qdio_buffer_element element[QDIO_MAX_ELEMENTS_PER_BUFFER];
 } __attribute__ ((packed, aligned(256)));
 
+#define QDIO_ELEMENT_NO(buf, element)	(element - &buf->element[0])
+
 /**
  * struct sl_element - storage list entry
  * @sbal: absolute SBAL address
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 6eb431c194bd..9840d4fab010 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -752,7 +752,7 @@ enum qeth_addr_disposition {
 struct qeth_rx {
 	int b_count;
 	int b_index;
-	struct qdio_buffer_element *b_element;
+	u8 buf_element;
 	int e_offset;
 	int qdio_err;
 };
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bd3adbb6ad50..b25d44c83997 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5332,14 +5332,13 @@ static inline int qeth_is_last_sbale(struct qdio_buffer_element *sbale)
 }
 
 static int qeth_extract_skb(struct qeth_card *card,
-			    struct qeth_qdio_buffer *qethbuffer,
-			    struct qdio_buffer_element **__element,
+			    struct qeth_qdio_buffer *qethbuffer, u8 *element_no,
 			    int *__offset)
 {
-	struct qdio_buffer_element *element = *__element;
 	struct qeth_priv *priv = netdev_priv(card->dev);
 	struct qdio_buffer *buffer = qethbuffer->buffer;
 	struct napi_struct *napi = &card->napi;
+	struct qdio_buffer_element *element;
 	unsigned int linear_len = 0;
 	bool uses_frags = false;
 	int offset = *__offset;
@@ -5349,6 +5348,8 @@ static int qeth_extract_skb(struct qeth_card *card,
 	struct sk_buff *skb;
 	int skb_len = 0;
 
+	element = &buffer->element[*element_no];
+
 next_packet:
 	/* qeth_hdr must not cross element boundaries */
 	while (element->length < offset + sizeof(struct qeth_hdr)) {
@@ -5504,7 +5505,7 @@ static int qeth_extract_skb(struct qeth_card *card,
 	if (!skb)
 		goto next_packet;
 
-	*__element = element;
+	*element_no = QDIO_ELEMENT_NO(buffer, element);
 	*__offset = offset;
 
 	qeth_receive_skb(card, skb, hdr, uses_frags);
@@ -5519,7 +5520,7 @@ static int qeth_extract_skbs(struct qeth_card *card, int budget,
 	*done = false;
 
 	while (budget) {
-		if (qeth_extract_skb(card, buf, &card->rx.b_element,
+		if (qeth_extract_skb(card, buf, &card->rx.buf_element,
 				     &card->rx.e_offset)) {
 			*done = true;
 			break;
@@ -5550,10 +5551,6 @@ int qeth_poll(struct napi_struct *napi, int budget)
 				card->rx.b_count = 0;
 				break;
 			}
-			card->rx.b_element =
-				&card->qdio.in_q->bufs[card->rx.b_index]
-				.buffer->element[0];
-			card->rx.e_offset = 0;
 		}
 
 		while (card->rx.b_count) {
@@ -5572,15 +5569,12 @@ int qeth_poll(struct napi_struct *napi, int budget)
 					buffer->pool_entry);
 				qeth_queue_input_buffer(card, card->rx.b_index);
 				card->rx.b_count--;
-				if (card->rx.b_count) {
-					card->rx.b_index =
-						QDIO_BUFNR(card->rx.b_index + 1);
-					card->rx.b_element =
-						&card->qdio.in_q
-						->bufs[card->rx.b_index]
-						.buffer->element[0];
-					card->rx.e_offset = 0;
-				}
+
+				/* Step forward to next buffer: */
+				card->rx.b_index =
+					QDIO_BUFNR(card->rx.b_index + 1);
+				card->rx.buf_element = 0;
+				card->rx.e_offset = 0;
 			}
 
 			if (work_done >= budget)
-- 
2.17.1
