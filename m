Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727285AbgCYJfR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Mar 2020 05:35:17 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02P9Y13I128510
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:16 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuwgg5d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 25 Mar 2020 05:35:15 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Wed, 25 Mar 2020 09:35:10 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 02/11] s390/qeth: split out RX poll code
Date: Wed, 25 Mar 2020 10:34:58 +0100
In-Reply-To: <20200325093507.20831-1-jwi@linux.ibm.com>
References: <20200325093507.20831-1-jwi@linux.ibm.com>
Message-Id: <20200325093507.20831-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The main NAPI poll routine should eventually handle more types of work,
beyond just the RX ring.
Split off the RX poll logic into a separate function, and simplify the
nested while-loop.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 54 +++++++++++++++++++------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4f33e4ee49d7..7c98bc9e2c9a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5512,12 +5512,10 @@ static int qeth_extract_skb(struct qeth_card *card,
 	return 0;
 }
 
-static int qeth_extract_skbs(struct qeth_card *card, int budget,
-			     struct qeth_qdio_buffer *buf, bool *done)
+static unsigned int qeth_extract_skbs(struct qeth_card *card, int budget,
+				      struct qeth_qdio_buffer *buf, bool *done)
 {
-	int work_done = 0;
-
-	*done = false;
+	unsigned int work_done = 0;
 
 	while (budget) {
 		if (qeth_extract_skb(card, buf, &card->rx.buf_element,
@@ -5533,15 +5531,12 @@ static int qeth_extract_skbs(struct qeth_card *card, int budget,
 	return work_done;
 }
 
-int qeth_poll(struct napi_struct *napi, int budget)
+static unsigned int qeth_rx_poll(struct qeth_card *card, int budget)
 {
-	struct qeth_card *card = container_of(napi, struct qeth_card, napi);
-	int work_done = 0;
-	struct qeth_qdio_buffer *buffer;
-	int new_budget = budget;
-	bool done;
+	unsigned int work_done = 0;
 
-	while (1) {
+	while (budget > 0) {
+		/* Fetch completed RX buffers: */
 		if (!card->rx.b_count) {
 			card->rx.qdio_err = 0;
 			card->rx.b_count = qdio_get_next_buffers(
@@ -5553,16 +5548,24 @@ int qeth_poll(struct napi_struct *napi, int budget)
 			}
 		}
 
-		while (card->rx.b_count) {
+		/* Process one completed RX buffer: */
+		if (card->rx.b_count) {
+			struct qeth_qdio_buffer *buffer;
+			unsigned int skbs_done = 0;
+			bool done = false;
+
 			buffer = &card->qdio.in_q->bufs[card->rx.b_index];
 			if (!(card->rx.qdio_err &&
 			    qeth_check_qdio_errors(card, buffer->buffer,
 			    card->rx.qdio_err, "qinerr")))
-				work_done += qeth_extract_skbs(card, new_budget,
-							       buffer, &done);
+				skbs_done = qeth_extract_skbs(card, budget,
+							      buffer, &done);
 			else
 				done = true;
 
+			work_done += skbs_done;
+			budget -= skbs_done;
+
 			if (done) {
 				QETH_CARD_STAT_INC(card, rx_bufs);
 				qeth_put_buffer_pool_entry(card,
@@ -5576,18 +5579,27 @@ int qeth_poll(struct napi_struct *napi, int budget)
 				card->rx.buf_element = 0;
 				card->rx.e_offset = 0;
 			}
-
-			if (work_done >= budget)
-				goto out;
-			else
-				new_budget = budget - work_done;
 		}
 	}
 
+	return work_done;
+}
+
+int qeth_poll(struct napi_struct *napi, int budget)
+{
+	struct qeth_card *card = container_of(napi, struct qeth_card, napi);
+	unsigned int work_done;
+
+	work_done = qeth_rx_poll(card, budget);
+
+	/* Exhausted the RX budget. Keep IRQ disabled, we get called again. */
+	if (budget && work_done >= budget)
+		return work_done;
+
 	if (napi_complete_done(napi, work_done) &&
 	    qdio_start_irq(CARD_DDEV(card), 0))
 		napi_schedule(napi);
-out:
+
 	return work_done;
 }
 EXPORT_SYMBOL_GPL(qeth_poll);
-- 
2.17.1
