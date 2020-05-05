Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730664AbgEEQ0L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 12:26:11 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/11] s390/qeth: set TX IRQ marker on last buffer in a group
Date: Tue,  5 May 2020 18:25:56 +0200
Message-Id: <20200505162559.14138-9-jwi@linux.ibm.com>
In-Reply-To: <20200505162559.14138-1-jwi@linux.ibm.com>
References: <20200505162559.14138-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When qeth_flush_buffers() gets called for a group of TX buffers
(currently up to 2 for OSA-style devices), the code iterates over each
buffer for some final processing.

During this processing, it sets the TX IRQ marker on the leading buffer
rather than the last one. This can result in delayed TX completion of
the trailing buffers. So pull the IRQ marker code out of the loop, and
apply it to the final buffer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4d1d053eebb7..164cc7f377fc 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3617,11 +3617,11 @@ static int qeth_switch_to_nonpacking_if_needed(struct qeth_qdio_out_q *queue)
 static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 			       int count)
 {
+	struct qeth_qdio_out_buffer *buf = queue->bufs[index];
+	unsigned int qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
 	struct qeth_card *card = queue->card;
-	struct qeth_qdio_out_buffer *buf;
 	int rc;
 	int i;
-	unsigned int qdio_flags;
 
 	for (i = index; i < index + count; ++i) {
 		unsigned int bidx = QDIO_BUFNR(i);
@@ -3638,9 +3638,10 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 		if (IS_IQD(card)) {
 			skb_queue_walk(&buf->skb_list, skb)
 				skb_tx_timestamp(skb);
-			continue;
 		}
+	}
 
+	if (!IS_IQD(card)) {
 		if (!queue->do_pack) {
 			if ((atomic_read(&queue->used_buffers) >=
 				(QETH_HIGH_WATERMARK_PACK -
@@ -3665,12 +3666,12 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 				buf->buffer->element[0].sflags |= SBAL_SFLAGS0_PCI_REQ;
 			}
 		}
+
+		if (atomic_read(&queue->set_pci_flags_count))
+			qdio_flags |= QDIO_FLAG_PCI_OUT;
 	}
 
 	QETH_TXQ_STAT_INC(queue, doorbell);
-	qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
-	if (atomic_read(&queue->set_pci_flags_count))
-		qdio_flags |= QDIO_FLAG_PCI_OUT;
 	rc = do_QDIO(CARD_DDEV(queue->card), qdio_flags,
 		     queue->queue_no, index, count);
 
-- 
2.17.1
