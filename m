Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726761AbfJaMmb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 08:42:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9VCeEBl000980
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vyya3h6fe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 31 Oct 2019 08:42:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 31 Oct 2019 12:42:28 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/8] s390/qeth: use QDIO_BUFNR()
Date: Thu, 31 Oct 2019 13:42:16 +0100
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Message-Id: <20191031124221.34028-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qdio.h recently gained a new helper macro that handles wrap-around on a
QDIO queue, consistently use it across all of qeth.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 37 ++++++++++++++-----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 62054afd73cc..52e3adb7864a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3121,7 +3121,7 @@ static void qeth_queue_input_buffer(struct qeth_card *card, int index)
 		for (i = queue->next_buf_to_init;
 		     i < queue->next_buf_to_init + count; ++i) {
 			if (qeth_init_input_buffer(card,
-				&queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q])) {
+				&queue->bufs[QDIO_BUFNR(i)])) {
 				break;
 			} else {
 				newcount++;
@@ -3163,8 +3163,8 @@ static void qeth_queue_input_buffer(struct qeth_card *card, int index)
 		if (rc) {
 			QETH_CARD_TEXT(card, 2, "qinberr");
 		}
-		queue->next_buf_to_init = (queue->next_buf_to_init + count) %
-					  QDIO_MAX_BUFFERS_PER_Q;
+		queue->next_buf_to_init = QDIO_BUFNR(queue->next_buf_to_init +
+						     count);
 	}
 }
 
@@ -3212,7 +3212,7 @@ static int qeth_prep_flush_pack_buffer(struct qeth_qdio_out_q *queue)
 		/* it's a packing buffer */
 		atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
 		queue->next_buf_to_fill =
-			(queue->next_buf_to_fill + 1) % QDIO_MAX_BUFFERS_PER_Q;
+			QDIO_BUFNR(queue->next_buf_to_fill + 1);
 		return 1;
 	}
 	return 0;
@@ -3266,7 +3266,8 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 	unsigned int qdio_flags;
 
 	for (i = index; i < index + count; ++i) {
-		int bidx = i % QDIO_MAX_BUFFERS_PER_Q;
+		unsigned int bidx = QDIO_BUFNR(i);
+
 		buf = queue->bufs[bidx];
 		buf->buffer->element[buf->next_element_to_fill - 1].eflags |=
 				SBAL_EFLAGS_LAST_ENTRY;
@@ -3434,8 +3435,7 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 	}
 
 	for (i = first_element; i < first_element + count; ++i) {
-		int bidx = i % QDIO_MAX_BUFFERS_PER_Q;
-		struct qdio_buffer *buffer = cq->qdio_bufs[bidx];
+		struct qdio_buffer *buffer = cq->qdio_bufs[QDIO_BUFNR(i)];
 		int e = 0;
 
 		while ((e < QDIO_MAX_ELEMENTS_PER_BUFFER) &&
@@ -3456,8 +3456,8 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 			"QDIO reported an error, rc=%i\n", rc);
 		QETH_CARD_TEXT(card, 2, "qcqherr");
 	}
-	card->qdio.c_q->next_buf_to_init = (card->qdio.c_q->next_buf_to_init
-				   + count) % QDIO_MAX_BUFFERS_PER_Q;
+
+	cq->next_buf_to_init = QDIO_BUFNR(cq->next_buf_to_init + count);
 }
 
 static void qeth_qdio_input_handler(struct ccw_device *ccwdev,
@@ -3483,7 +3483,6 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 {
 	struct qeth_card *card        = (struct qeth_card *) card_ptr;
 	struct qeth_qdio_out_q *queue = card->qdio.out_qs[__queue];
-	struct qeth_qdio_out_buffer *buffer;
 	struct net_device *dev = card->dev;
 	struct netdev_queue *txq;
 	int i;
@@ -3497,10 +3496,10 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	}
 
 	for (i = first_element; i < (first_element + count); ++i) {
-		int bidx = i % QDIO_MAX_BUFFERS_PER_Q;
-		buffer = queue->bufs[bidx];
-		qeth_handle_send_error(card, buffer, qdio_error);
-		qeth_clear_output_buffer(queue, buffer, qdio_error, 0);
+		struct qeth_qdio_out_buffer *buf = queue->bufs[QDIO_BUFNR(i)];
+
+		qeth_handle_send_error(card, buf, qdio_error);
+		qeth_clear_output_buffer(queue, buf, qdio_error, 0);
 	}
 
 	atomic_sub(count, &queue->used_buffers);
@@ -3932,8 +3931,7 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
 			flush_count++;
 			queue->next_buf_to_fill =
-				(queue->next_buf_to_fill + 1) %
-				QDIO_MAX_BUFFERS_PER_Q;
+				QDIO_BUFNR(queue->next_buf_to_fill + 1);
 			buffer = queue->bufs[queue->next_buf_to_fill];
 
 			/* We stepped forward, so sanity-check again: */
@@ -3966,8 +3964,8 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 	if (!queue->do_pack || stopped || next_element >= queue->max_elements) {
 		flush_count++;
 		atomic_set(&buffer->state, QETH_QDIO_BUF_PRIMED);
-		queue->next_buf_to_fill = (queue->next_buf_to_fill + 1) %
-					  QDIO_MAX_BUFFERS_PER_Q;
+		queue->next_buf_to_fill =
+				QDIO_BUFNR(queue->next_buf_to_fill + 1);
 	}
 
 	if (flush_count)
@@ -5199,8 +5197,7 @@ int qeth_poll(struct napi_struct *napi, int budget)
 				card->rx.b_count--;
 				if (card->rx.b_count) {
 					card->rx.b_index =
-						(card->rx.b_index + 1) %
-						QDIO_MAX_BUFFERS_PER_Q;
+						QDIO_BUFNR(card->rx.b_index + 1);
 					card->rx.b_element =
 						&card->qdio.in_q
 						->bufs[card->rx.b_index]
-- 
2.17.1
