Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727399AbgCYJfQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9YucW074189
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:15 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywf3g48f4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:15 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:10 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 01/11] s390/qeth: simplify RX buffer tracking
Date: Wed, 25 Mar 2020 10:34:57 +0100
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Message-Id: <20200325093507.20831-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
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

v2: - remove QDIO_ELEMENT_NO() macro (davem)

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 30 ++++++++++++------------------
 2 files changed, 13 insertions(+), 19 deletions(-)

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
index bd3adbb6ad50..4f33e4ee49d7 100644
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
+	*element_no = element - &buffer->element[0];
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
