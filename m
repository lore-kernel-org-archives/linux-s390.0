From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/15] s390/qeth: re-use qeth_notify_skbs()
Date: Wed, 26 Sep 2018 18:29:09 +0200
Message-ID: <20180926162916.102720-9-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When not using the CQ, this allows us avoid the second skb queue walk
in qeth_release_skbs().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 012519ffd8de..1b853f900720 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1180,38 +1180,19 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
 	skb_queue_walk(&buf->skb_list, skb) {
 		QETH_CARD_TEXT_(q->card, 5, "skbn%d", notification);
 		QETH_CARD_TEXT_(q->card, 5, "%lx", (long) skb);
-		if (be16_to_cpu(skb->protocol) == ETH_P_AF_IUCV) {
-			if (skb->sk) {
-				struct iucv_sock *iucv = iucv_sk(skb->sk);
-				iucv->sk_txnotify(skb, notification);
-			}
-		}
+		if (skb->protocol == htons(ETH_P_AF_IUCV) && skb->sk)
+			iucv_sk(skb->sk)->sk_txnotify(skb, notification);
 	}
 }
 
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
 {
-	struct sk_buff *skb;
-	struct iucv_sock *iucv;
-	int notify_general_error = 0;
-
-	if (atomic_read(&buf->state) == QETH_QDIO_BUF_PENDING)
-		notify_general_error = 1;
-
 	/* release may never happen from within CQ tasklet scope */
 	WARN_ON_ONCE(atomic_read(&buf->state) == QETH_QDIO_BUF_IN_CQ);
 
-	skb_queue_walk(&buf->skb_list, skb) {
-		QETH_CARD_TEXT(buf->q->card, 5, "skbr");
-		QETH_CARD_TEXT_(buf->q->card, 5, "%lx", (long) skb);
-		if (notify_general_error &&
-		    be16_to_cpu(skb->protocol) == ETH_P_AF_IUCV) {
-			if (skb->sk) {
-				iucv = iucv_sk(skb->sk);
-				iucv->sk_txnotify(skb, TX_NOTIFY_GENERALERROR);
-			}
-		}
-	}
+	if (atomic_read(&buf->state) == QETH_QDIO_BUF_PENDING)
+		qeth_notify_skbs(buf->q, buf, TX_NOTIFY_GENERALERROR);
+
 	__skb_queue_purge(&buf->skb_list);
 }
 
-- 
2.16.4
