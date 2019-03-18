Return-Path: <SRS0=pZ4W=RV=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: be drop monitor friendly
Date: Mon, 18 Mar 2019 16:40:56 +0100
In-Reply-To: <20190318154056.4231-1-jwi@linux.ibm.com>
References: <20190318154056.4231-1-jwi@linux.ibm.com>
Message-Id: <20190318154056.4231-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As part of the TX completion path, qeth_release_skbs() frees the completed
skbs with __skb_queue_purge(). This ends in kfree_skb(), reporting every
completed skb as dropped.
On the other hand when dropping an skb in .ndo_start_xmit, we end up
calling consume_skb()... where we should be using kfree_skb() so that
drop monitors get notified.

Switch the drop/consume logic around, and also don't accumulate dropped
packets in the tx_errors statistics.

Fixes: dc149e3764d8 ("s390/qeth: replace open-coded skb_queue_walk()")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 5 ++++-
 drivers/s390/net/qeth_l2_main.c   | 3 +--
 drivers/s390/net/qeth_l3_main.c   | 3 +--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 197b0f5b63e7..44bd6f04c145 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1150,13 +1150,16 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
 
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
 {
+	struct sk_buff *skb;
+
 	/* release may never happen from within CQ tasklet scope */
 	WARN_ON_ONCE(atomic_read(&buf->state) == QETH_QDIO_BUF_IN_CQ);
 
 	if (atomic_read(&buf->state) == QETH_QDIO_BUF_PENDING)
 		qeth_notify_skbs(buf->q, buf, TX_NOTIFY_GENERALERROR);
 
-	__skb_queue_purge(&buf->skb_list);
+	while ((skb = __skb_dequeue(&buf->skb_list)) != NULL)
+		consume_skb(skb);
 }
 
 static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 3bfdd8545776..c3067fd3bd9e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -629,8 +629,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	} /* else fall through */
 
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
-	QETH_TXQ_STAT_INC(queue, tx_errors);
-	dev_kfree_skb_any(skb);
+	kfree_skb(skb);
 	netif_wake_queue(dev);
 	return NETDEV_TX_OK;
 }
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d805e72edb58..53712cf26406 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2096,8 +2096,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 
 tx_drop:
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
-	QETH_TXQ_STAT_INC(queue, tx_errors);
-	dev_kfree_skb_any(skb);
+	kfree_skb(skb);
 	netif_wake_queue(dev);
 	return NETDEV_TX_OK;
 }
-- 
2.16.4
