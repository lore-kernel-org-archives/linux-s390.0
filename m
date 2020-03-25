Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727469AbgCYJfR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:17 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9WuO6121914
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:16 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywchxyw4x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:15 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:10 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 03/11] s390/qeth: remove redundant if-clause in RX poll code
Date: Wed, 25 Mar 2020 10:34:59 +0100
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Message-Id: <20200325093507.20831-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
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
index 7c98bc9e2c9a..13facf2d602b 100644
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
