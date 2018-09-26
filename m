From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/15] s390/qeth: replace open-coded skb_queue_walk()
Date: Wed, 26 Sep 2018 18:29:07 +0200
Message-ID: <20180926162916.102720-7-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

To match the use of __skb_queue_purge(), also make the skb's enqueue in
qeth_fill_buffer() lockless.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a6c632d36df8..c5c40c6d8b7d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1177,10 +1177,7 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
 {
 	struct sk_buff *skb;
 
-	if (skb_queue_empty(&buf->skb_list))
-		goto out;
-	skb = skb_peek(&buf->skb_list);
-	while (skb) {
+	skb_queue_walk(&buf->skb_list, skb) {
 		QETH_CARD_TEXT_(q->card, 5, "skbn%d", notification);
 		QETH_CARD_TEXT_(q->card, 5, "%lx", (long) skb);
 		if (be16_to_cpu(skb->protocol) == ETH_P_AF_IUCV) {
@@ -1189,13 +1186,7 @@ static void qeth_notify_skbs(struct qeth_qdio_out_q *q,
 				iucv->sk_txnotify(skb, notification);
 			}
 		}
-		if (skb_queue_is_last(&buf->skb_list, skb))
-			skb = NULL;
-		else
-			skb = skb_queue_next(&buf->skb_list, skb);
 	}
-out:
-	return;
 }
 
 static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
@@ -1210,8 +1201,7 @@ static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
 	/* release may never happen from within CQ tasklet scope */
 	WARN_ON_ONCE(atomic_read(&buf->state) == QETH_QDIO_BUF_IN_CQ);
 
-	skb = skb_dequeue(&buf->skb_list);
-	while (skb) {
+	skb_queue_walk(&buf->skb_list, skb) {
 		QETH_CARD_TEXT(buf->q->card, 5, "skbr");
 		QETH_CARD_TEXT_(buf->q->card, 5, "%lx", (long) skb);
 		if (notify_general_error &&
@@ -1222,9 +1212,8 @@ static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
 			}
 		}
 		refcount_dec(&skb->users);
-		dev_kfree_skb_any(skb);
-		skb = skb_dequeue(&buf->skb_list);
 	}
+	__skb_queue_purge(&buf->skb_list);
 }
 
 static void qeth_clear_output_buffer(struct qeth_qdio_out_q *queue,
@@ -4000,7 +3989,7 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 	int flush_cnt = 0;
 
 	refcount_inc(&skb->users);
-	skb_queue_tail(&buf->skb_list, skb);
+	__skb_queue_tail(&buf->skb_list, skb);
 
 	/* build dedicated header element */
 	if (hd_len) {
-- 
2.16.4
