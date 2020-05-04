Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63650 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729962AbgEDRjy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 May 2020 13:39:54 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net] s390/qeth: fix cancelling of TX timer on dev_close()
Date: Mon,  4 May 2020 19:39:42 +0200
Message-Id: <20200504173942.69298-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

With the introduction of TX coalescing, .ndo_start_xmit now potentially
starts the TX completion timer. So only kill the timer _after_ TX has
been disabled.

Fixes: ee1e52d1e4bb ("s390/qeth: add TX IRQ coalescing support for IQD devices")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f7689461c242..569966bdc513 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6717,17 +6717,17 @@ int qeth_stop(struct net_device *dev)
 		unsigned int i;
 
 		/* Quiesce the NAPI instances: */
-		qeth_for_each_output_queue(card, queue, i) {
+		qeth_for_each_output_queue(card, queue, i)
 			napi_disable(&queue->napi);
-			del_timer_sync(&queue->timer);
-		}
 
 		/* Stop .ndo_start_xmit, might still access queue->napi. */
 		netif_tx_disable(dev);
 
-		/* Queues may get re-allocated, so remove the NAPIs here. */
-		qeth_for_each_output_queue(card, queue, i)
+		qeth_for_each_output_queue(card, queue, i) {
+			del_timer_sync(&queue->timer);
+			/* Queues may get re-allocated, so remove the NAPIs. */
 			netif_napi_del(&queue->napi);
+		}
 	} else {
 		netif_tx_disable(dev);
 	}
-- 
2.17.1
