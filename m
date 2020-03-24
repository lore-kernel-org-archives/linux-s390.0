Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/11] s390/qeth: remove redundant if-clause in RX poll code
Date: Tue, 24 Mar 2020 19:24:40 +0100
In-Reply-To: <20200324182448.95362-1-jwi@linux.ibm.com>
References: <20200324182448.95362-1-jwi@linux.ibm.com>
Message-Id: <20200324182448.95362-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Whenever all completed RX buffers have been processed
(ie. rx->b_count == 0), we call down to the HW layer to scan for
additional buffers. If no further buffers are available, the code
breaks out of the while-loop.

So we never reach the 'process an RX buffer' step with rx->b_count == 0,
eliminate that check and one level of indentation.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 56 ++++++++++++++-----------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f818d9db32ac..dd9bee620f46 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5536,6 +5536,10 @@ static unsigned int qeth_rx_poll(struct qeth_card *card, int budget)
 	unsigned int work_done = 0;
 
 	while (budget > 0) {
+		struct qeth_qdio_buffer *buffer;
+		unsigned int skbs_done = 0;
+		bool done = false;
+
 		/* Fetch completed RX buffers: */
 		if (!card->rx.b_count) {
 			card->rx.qdio_err = 0;
@@ -5549,36 +5553,28 @@ static unsigned int qeth_rx_poll(struct qeth_card *card, int budget)
 		}
 
 		/* Process one completed RX buffer: */
-		if (card->rx.b_count) {
-			struct qeth_qdio_buffer *buffer;
-			unsigned int skbs_done = 0;
-			bool done = false;
-
-			buffer = &card->qdio.in_q->bufs[card->rx.b_index];
-			if (!(card->rx.qdio_err &&
-			    qeth_check_qdio_errors(card, buffer->buffer,
-			    card->rx.qdio_err, "qinerr")))
-				skbs_done = qeth_extract_skbs(card, budget,
-							      buffer, &done);
-			else
-				done = true;
-
-			work_done += skbs_done;
-			budget -= skbs_done;
-
-			if (done) {
-				QETH_CARD_STAT_INC(card, rx_bufs);
-				qeth_put_buffer_pool_entry(card,
-					buffer->pool_entry);
-				qeth_queue_input_buffer(card, card->rx.b_index);
-				card->rx.b_count--;
-
-				/* Step forward to next buffer: */
-				card->rx.b_index =
-					QDIO_BUFNR(card->rx.b_index + 1);
-				card->rx.buf_element = 0;
-				card->rx.e_offset = 0;
-			}
+		buffer = &card->qdio.in_q->bufs[card->rx.b_index];
+		if (!(card->rx.qdio_err &&
+		      qeth_check_qdio_errors(card, buffer->buffer,
+					     card->rx.qdio_err, "qinerr")))
+			skbs_done = qeth_extract_skbs(card, budget, buffer,
+						      &done);
+		else
+			done = true;
+
+		work_done += skbs_done;
+		budget -= skbs_done;
+
+		if (done) {
+			QETH_CARD_STAT_INC(card, rx_bufs);
+			qeth_put_buffer_pool_entry(card, buffer->pool_entry);
+			qeth_queue_input_buffer(card, card->rx.b_index);
+			card->rx.b_count--;
+
+			/* Step forward to next buffer: */
+			card->rx.b_index = QDIO_BUFNR(card->rx.b_index + 1);
+			card->rx.buf_element = 0;
+			card->rx.e_offset = 0;
 		}
 	}
 
-- 
2.17.1
