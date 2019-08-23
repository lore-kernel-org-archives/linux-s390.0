Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26936 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394132AbfHWJtD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 05:49:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N9kWn0138983
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:02 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujcjvjv8n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 23 Aug 2019 10:49:00 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/7] s390/qeth: when in TX NAPI mode, use napi_consume_skb()
Date: Fri, 23 Aug 2019 11:48:51 +0200
In-Reply-To: <20190823094853.63814-1-jwi@linux.ibm.com>
References: <20190823094853.63814-1-jwi@linux.ibm.com>
Message-Id: <20190823094853.63814-6-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

This allows the stack to bulk-free our TX-completed skbs.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 3223ad80998c..70c7e675431e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -71,7 +71,8 @@ static void qeth_free_qdio_queues(struct qeth_card *card);
 static void qeth_notify_skbs(struct qeth_qdio_out_q *queue,
 		struct qeth_qdio_out_buffer *buf,
 		enum iucv_tx_notify notification);
-static void qeth_tx_complete_buf(struct qeth_qdio_out_buffer *buf, bool error);
+static void qeth_tx_complete_buf(struct qeth_qdio_out_buffer *buf, bool error,
+				 int budget);
 static int qeth_init_qdio_out_buf(struct qeth_qdio_out_q *, int);
 
 static void qeth_close_dev_handler(struct work_struct *work)
@@ -411,7 +412,7 @@ static void qeth_cleanup_handled_pending(struct qeth_qdio_out_q *q, int bidx,
 				/* release here to avoid interleaving between
 				   outbound tasklet and inbound tasklet
 				   regarding notifications and lifecycle */
-				qeth_tx_complete_buf(c, forced_cleanup);
+				qeth_tx_complete_buf(c, forced_cleanup, 0);
 
 				c = f->next_pending;
 				WARN_ON_ONCE(head->next_pending != f);
@@ -1077,7 +1078,8 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
 	}
 }
 
-static void qeth_tx_complete_buf(struct qeth_qdio_out_buffer *buf, bool error)
+static void qeth_tx_complete_buf(struct qeth_qdio_out_buffer *buf, bool error,
+				 int budget)
 {
 	struct qeth_qdio_out_q *queue = buf->q;
 	struct sk_buff *skb;
@@ -1115,13 +1117,13 @@ static void qeth_tx_complete_buf(struct qeth_qdio_out_buffer *buf, bool error)
 			}
 		}
 
-		consume_skb(skb);
+		napi_consume_skb(skb, budget);
 	}
 }
 
 static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 				     struct qeth_qdio_out_buffer *buf,
-				     bool error)
+				     bool error, int budget)
 {
 	int i;
 
@@ -1129,7 +1131,7 @@ static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 	if (buf->buffer->element[0].sflags & SBAL_SFLAGS0_PCI_REQ)
 		atomic_dec(&queue->set_pci_flags_count);
 
-	qeth_tx_complete_buf(buf, error);
+	qeth_tx_complete_buf(buf, error, budget);
 
 	for (i = 0; i < queue->max_elements; ++i) {
 		if (buf->buffer->element[i].addr && buf->is_header[i])
@@ -1151,7 +1153,7 @@ static void qeth_drain_output_queue(struct qeth_qdio_out_q *q, bool free)
 		if (!q->bufs[j])
 			continue;
 		qeth_cleanup_handled_pending(q, j, 1);
-		qeth_clear_output_buffer(q, q->bufs[j], true);
+		qeth_clear_output_buffer(q, q->bufs[j], true, 0);
 		if (free) {
 			kmem_cache_free(qeth_qdio_outbuf_cache, q->bufs[j]);
 			q->bufs[j] = NULL;
@@ -3471,7 +3473,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 		int bidx = i % QDIO_MAX_BUFFERS_PER_Q;
 		buffer = queue->bufs[bidx];
 		qeth_handle_send_error(card, buffer, qdio_error);
-		qeth_clear_output_buffer(queue, buffer, qdio_error);
+		qeth_clear_output_buffer(queue, buffer, qdio_error, 0);
 	}
 
 	atomic_sub(count, &queue->used_buffers);
@@ -5138,7 +5140,7 @@ int qeth_poll(struct napi_struct *napi, int budget)
 EXPORT_SYMBOL_GPL(qeth_poll);
 
 static void qeth_iqd_tx_complete(struct qeth_qdio_out_q *queue,
-				 unsigned int bidx, bool error)
+				 unsigned int bidx, bool error, int budget)
 {
 	struct qeth_qdio_out_buffer *buffer = queue->bufs[bidx];
 	u8 sflags = buffer->buffer->element[15].sflags;
@@ -5168,7 +5170,7 @@ static void qeth_iqd_tx_complete(struct qeth_qdio_out_q *queue,
 	if (card->options.cq == QETH_CQ_ENABLED)
 		qeth_notify_skbs(queue, buffer,
 				 qeth_compute_cq_notification(sflags, 0));
-	qeth_clear_output_buffer(queue, buffer, error);
+	qeth_clear_output_buffer(queue, buffer, error, budget);
 }
 
 static int qeth_tx_poll(struct napi_struct *napi, int budget)
@@ -5212,7 +5214,7 @@ static int qeth_tx_poll(struct napi_struct *napi, int budget)
 			unsigned int bidx = QDIO_BUFNR(i);
 
 			qeth_handle_send_error(card, queue->bufs[bidx], error);
-			qeth_iqd_tx_complete(queue, bidx, error);
+			qeth_iqd_tx_complete(queue, bidx, error, budget);
 			qeth_cleanup_handled_pending(queue, bidx, false);
 		}
 
-- 
2.17.1
