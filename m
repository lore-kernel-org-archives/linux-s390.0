Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404460AbfHWJtF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Aug 2019 05:49:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N9kkdb100512
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ujbwgvgmv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 23 Aug 2019 05:49:03 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 23 Aug 2019 10:49:02 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/7] s390/qeth: add BQL support for IQD devices
Date: Fri, 23 Aug 2019 11:48:52 +0200
In-Reply-To: <20190823094853.63814-1-jwi@linux.ibm.com>
References: <20190823094853.63814-1-jwi@linux.ibm.com>
Message-Id: <20190823094853.63814-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Each TX buffer may contain multiple skbs. So just accumulate the sent
byte count in the buffer struct, and later use the same count when
completing the buffer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index ae2ae17e3e76..d5f796380cd0 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -426,6 +426,7 @@ struct qeth_qdio_out_buffer {
 	struct qdio_buffer *buffer;
 	atomic_t state;
 	int next_element_to_fill;
+	unsigned int bytes;
 	struct sk_buff_head skb_list;
 	int is_header[QDIO_MAX_ELEMENTS_PER_BUFFER];
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 70c7e675431e..4c7c7d320c9c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1142,6 +1142,7 @@ static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
 
 	qeth_scrub_qdio_buffer(buf->buffer, queue->max_elements);
 	buf->next_element_to_fill = 0;
+	buf->bytes = 0;
 	atomic_set(&buf->state, QETH_QDIO_BUF_EMPTY);
 }
 
@@ -2673,6 +2674,7 @@ int qeth_init_qdio_queues(struct qeth_card *card)
 		atomic_set(&queue->used_buffers, 0);
 		atomic_set(&queue->set_pci_flags_count, 0);
 		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
+		netdev_tx_reset_queue(netdev_get_tx_queue(card->dev, i));
 	}
 	return 0;
 }
@@ -3790,6 +3792,7 @@ static int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue,
 {
 	int index = queue->next_buf_to_fill;
 	struct qeth_qdio_out_buffer *buffer = queue->bufs[index];
+	unsigned int bytes = qdisc_pkt_len(skb);
 	struct netdev_queue *txq;
 	bool stopped = false;
 
@@ -3811,6 +3814,9 @@ static int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue,
 	}
 
 	qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len, stopped);
+	netdev_tx_sent_queue(txq, bytes);
+	buffer->bytes += bytes;
+
 	qeth_flush_buffers(queue, index, 1);
 
 	if (stopped && !qeth_out_queue_is_full(queue))
@@ -5186,6 +5192,8 @@ static int qeth_tx_poll(struct napi_struct *napi, int budget)
 
 	while (1) {
 		unsigned int start, error, i;
+		unsigned int packets = 0;
+		unsigned int bytes = 0;
 		int completed;
 
 		if (qeth_out_queue_is_empty(queue)) {
@@ -5211,13 +5219,19 @@ static int qeth_tx_poll(struct napi_struct *napi, int budget)
 		}
 
 		for (i = start; i < start + completed; i++) {
+			struct qeth_qdio_out_buffer *buffer;
 			unsigned int bidx = QDIO_BUFNR(i);
 
-			qeth_handle_send_error(card, queue->bufs[bidx], error);
+			buffer = queue->bufs[bidx];
+			packets += skb_queue_len(&buffer->skb_list);
+			bytes += buffer->bytes;
+
+			qeth_handle_send_error(card, buffer, error);
 			qeth_iqd_tx_complete(queue, bidx, error, budget);
 			qeth_cleanup_handled_pending(queue, bidx, false);
 		}
 
+		netdev_tx_completed_queue(txq, packets, bytes);
 		atomic_sub(completed, &queue->used_buffers);
 		work_done += completed;
 
-- 
2.17.1
