Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgIJJFa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 05:05:30 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net] s390/qeth: delay draining the TX buffers
Date: Thu, 10 Sep 2020 11:05:18 +0200
Message-Id: <20200910090518.71420-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Wait until the QDIO data connection is severed. Otherwise the device
might still be processing the buffers, and end up accessing skb data
that we already freed.

Fixes: 8b5026bc1693 ("s390/qeth: fix qdio teardown after early init error")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 2 +-
 drivers/s390/net/qeth_l3_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 3a94f6cad167..6384f7adba66 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -284,11 +284,11 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_clear_ipacmd_list(card);
-		qeth_drain_output_queues(card);
 		card->state = CARD_STATE_DOWN;
 	}
 
 	qeth_qdio_clear_card(card, 0);
+	qeth_drain_output_queues(card);
 	qeth_clear_working_pool_list(card);
 	flush_workqueue(card->event_wq);
 	qeth_flush_local_addrs(card);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4d461960370d..09ef518ca1ea 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1168,11 +1168,11 @@ static void qeth_l3_stop_card(struct qeth_card *card)
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
-		qeth_drain_output_queues(card);
 		card->state = CARD_STATE_DOWN;
 	}
 
 	qeth_qdio_clear_card(card, 0);
+	qeth_drain_output_queues(card);
 	qeth_clear_working_pool_list(card);
 	flush_workqueue(card->event_wq);
 	qeth_flush_local_addrs(card);
-- 
2.17.1
