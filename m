Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726275AbgG3PDO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 11:03:14 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/4] s390/qeth: use all configured RX buffers
Date: Thu, 30 Jul 2020 17:01:21 +0200
Message-Id: <20200730150121.18005-5-jwi@linux.ibm.com>
In-Reply-To: <20200730150121.18005-1-jwi@linux.ibm.com>
References: <20200730150121.18005-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The (misplaced) comment doesn't make any sense, enforcing an
uninitialized RX buffer won't help with IRQ reduction.

So make the best use of all available RX buffers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c2e44853ac1a..bba1b54b8aa3 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3022,6 +3022,7 @@ static unsigned int qeth_tx_select_bulk_max(struct qeth_card *card,
 
 static int qeth_init_qdio_queues(struct qeth_card *card)
 {
+	unsigned int rx_bufs = card->qdio.in_buf_pool.buf_count;
 	unsigned int i;
 	int rc;
 
@@ -3033,16 +3034,14 @@ static int qeth_init_qdio_queues(struct qeth_card *card)
 
 	qeth_initialize_working_pool_list(card);
 	/*give only as many buffers to hardware as we have buffer pool entries*/
-	for (i = 0; i < card->qdio.in_buf_pool.buf_count - 1; i++) {
+	for (i = 0; i < rx_bufs; i++) {
 		rc = qeth_init_input_buffer(card, &card->qdio.in_q->bufs[i]);
 		if (rc)
 			return rc;
 	}
 
-	card->qdio.in_q->next_buf_to_init =
-		card->qdio.in_buf_pool.buf_count - 1;
-	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
-		     card->qdio.in_buf_pool.buf_count - 1);
+	card->qdio.in_q->next_buf_to_init = QDIO_BUFNR(rx_bufs);
+	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0, rx_bufs);
 	if (rc) {
 		QETH_CARD_TEXT_(card, 2, "1err%d", rc);
 		return rc;
@@ -3535,13 +3534,6 @@ static unsigned int qeth_rx_refill_queue(struct qeth_card *card,
 			return 0;
 		}
 
-		/*
-		 * according to old code it should be avoided to requeue all
-		 * 128 buffers in order to benefit from PCI avoidance.
-		 * this function keeps at least one buffer (the buffer at
-		 * 'index') un-requeued -> this buffer is the first buffer that
-		 * will be requeued the next time
-		 */
 		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0,
 			     queue->next_buf_to_init, count);
 		if (rc) {
-- 
2.17.1
