Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26958 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgG3PGR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Jul 2020 11:06:17 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/4] s390/qeth: tolerate pre-filled RX buffer
Date: Thu, 30 Jul 2020 17:01:18 +0200
Message-Id: <20200730150121.18005-2-jwi@linux.ibm.com>
In-Reply-To: <20200730150121.18005-1-jwi@linux.ibm.com>
References: <20200730150121.18005-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When preparing a buffer for RX refill, tolerate that it already has a
pool_entry attached. Otherwise we could easily leak such a pool_entry
when re-driving the RX refill after an error (from eg. do_qdio()).

This needs some minor adjustment in the code that drains RX buffer(s)
prior to RX refill and during teardown, so that ->pool_entry is NULLed
accordingly.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8a76022fceda..b356ee5de9f8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -204,12 +204,17 @@ EXPORT_SYMBOL_GPL(qeth_threads_running);
 void qeth_clear_working_pool_list(struct qeth_card *card)
 {
 	struct qeth_buffer_pool_entry *pool_entry, *tmp;
+	struct qeth_qdio_q *queue = card->qdio.in_q;
+	unsigned int i;
 
 	QETH_CARD_TEXT(card, 5, "clwrklst");
 	list_for_each_entry_safe(pool_entry, tmp,
 			    &card->qdio.in_buf_pool.entry_list, list){
 			list_del(&pool_entry->list);
 	}
+
+	for (i = 0; i < ARRAY_SIZE(queue->bufs); i++)
+		queue->bufs[i].pool_entry = NULL;
 }
 EXPORT_SYMBOL_GPL(qeth_clear_working_pool_list);
 
@@ -2965,7 +2970,7 @@ static struct qeth_buffer_pool_entry *qeth_find_free_buffer_pool_entry(
 static int qeth_init_input_buffer(struct qeth_card *card,
 		struct qeth_qdio_buffer *buf)
 {
-	struct qeth_buffer_pool_entry *pool_entry;
+	struct qeth_buffer_pool_entry *pool_entry = buf->pool_entry;
 	int i;
 
 	if ((card->options.cq == QETH_CQ_ENABLED) && (!buf->rx_skb)) {
@@ -2976,9 +2981,13 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 			return -ENOMEM;
 	}
 
-	pool_entry = qeth_find_free_buffer_pool_entry(card);
-	if (!pool_entry)
-		return -ENOBUFS;
+	if (!pool_entry) {
+		pool_entry = qeth_find_free_buffer_pool_entry(card);
+		if (!pool_entry)
+			return -ENOBUFS;
+
+		buf->pool_entry = pool_entry;
+	}
 
 	/*
 	 * since the buffer is accessed only from the input_tasklet
@@ -2986,8 +2995,6 @@ static int qeth_init_input_buffer(struct qeth_card *card,
 	 * the QETH_IN_BUF_REQUEUE_THRESHOLD we should never run  out off
 	 * buffers
 	 */
-
-	buf->pool_entry = pool_entry;
 	for (i = 0; i < QETH_MAX_BUFFER_ELEMENTS(card); ++i) {
 		buf->buffer->element[i].length = PAGE_SIZE;
 		buf->buffer->element[i].addr =
@@ -5771,6 +5778,7 @@ static unsigned int qeth_rx_poll(struct qeth_card *card, int budget)
 		if (done) {
 			QETH_CARD_STAT_INC(card, rx_bufs);
 			qeth_put_buffer_pool_entry(card, buffer->pool_entry);
+			buffer->pool_entry = NULL;
 			qeth_queue_input_buffer(card, card->rx.b_index);
 			card->rx.b_count--;
 
-- 
2.17.1
