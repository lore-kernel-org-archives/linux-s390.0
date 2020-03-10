Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgCJRiM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Mar 2020 13:38:12 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AHTJUB053349
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 13:38:11 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ym8n8w4sr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 10 Mar 2020 13:38:11 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 10 Mar 2020 17:38:09 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: cancel RX reclaim work earlier
Date: Tue, 10 Mar 2020 18:38:03 +0100
In-Reply-To: <20200310173803.91602-1-jwi@linux.ibm.com>
References: <20200310173803.91602-1-jwi@linux.ibm.com>
Message-Id: <20200310173803.91602-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When qeth's napi poll code fails to refill an entirely empty RX ring, it
kicks off buffer_reclaim_work to try again later.

Make sure that this worker is cancelled when setting the qeth device
offline. Otherwise a RX refill action can unexpectedly end up running
concurrently to bigger re-configurations (eg. resizing the buffer pool),
without any locking.

Fixes: b333293058aa ("qeth: add support for af_iucv HiperSockets transport")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 -
 drivers/s390/net/qeth_l2_main.c   | 1 +
 drivers/s390/net/qeth_l3_main.c   | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d8f0c610396e..a599801d7727 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2392,7 +2392,6 @@ static void qeth_free_qdio_queues(struct qeth_card *card)
 		return;
 
 	qeth_free_cq(card);
-	cancel_delayed_work_sync(&card->buffer_reclaim_work);
 	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
 		if (card->qdio.in_q->bufs[j].rx_skb)
 			dev_kfree_skb_any(card->qdio.in_q->bufs[j].rx_skb);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 9972d96820f3..8fb29371788b 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -284,6 +284,7 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_clear_ipacmd_list(card);
 		qeth_drain_output_queues(card);
+		cancel_delayed_work_sync(&card->buffer_reclaim_work);
 		card->state = CARD_STATE_DOWN;
 	}
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 317d56647a4a..82f800d1d7b3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1178,6 +1178,7 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
 		qeth_drain_output_queues(card);
+		cancel_delayed_work_sync(&card->buffer_reclaim_work);
 		card->state = CARD_STATE_DOWN;
 	}
 
-- 
2.17.1
