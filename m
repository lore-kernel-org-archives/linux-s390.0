From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/3] af_iucv: remove fragment_skb() to use paged SKBs
Date: Mon, 13 Jun 2016 18:46:15 +0200
Message-ID: <1465836376-24452-3-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1465836376-24452-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1465836376-24452-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

Before introducing paged skbs in the receive path, get rid of the
function `iucv_fragment_skb()` that replaces one large linear skb
with several smaller linear skbs.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 net/iucv/af_iucv.c | 59 +++---------------------------------------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 38448d1..9ed2adf 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1231,44 +1231,6 @@ out:
 	return err;
 }
 
-/* iucv_fragment_skb() - Fragment a single IUCV message into multiple skb's
- *
- * Locking: must be called with message_q.lock held
- */
-static int iucv_fragment_skb(struct sock *sk, struct sk_buff *skb, int len)
-{
-	int dataleft, size, copied = 0;
-	struct sk_buff *nskb;
-
-	dataleft = len;
-	while (dataleft) {
-		if (dataleft >= sk->sk_rcvbuf / 4)
-			size = sk->sk_rcvbuf / 4;
-		else
-			size = dataleft;
-
-		nskb = alloc_skb(size, GFP_ATOMIC | GFP_DMA);
-		if (!nskb)
-			return -ENOMEM;
-
-		/* copy target class to control buffer of new skb */
-		IUCV_SKB_CB(nskb)->class = IUCV_SKB_CB(skb)->class;
-
-		/* copy data fragment */
-		memcpy(nskb->data, skb->data + copied, size);
-		copied += size;
-		dataleft -= size;
-
-		skb_reset_transport_header(nskb);
-		skb_reset_network_header(nskb);
-		nskb->len = size;
-
-		skb_queue_tail(&iucv_sk(sk)->backlog_skb_q, nskb);
-	}
-
-	return 0;
-}
-
 /* iucv_process_message() - Receive a single outstanding IUCV message
  *
  * Locking: must be called with message_q.lock held
@@ -1300,24 +1262,9 @@ static void iucv_process_message(struct sock *sk, struct sk_buff *skb,
 			kfree_skb(skb);
 			return;
 		}
-		/* we need to fragment iucv messages for SOCK_STREAM only;
-		 * for SOCK_SEQPACKET, it is only relevant if we support
-		 * record segmentation using MSG_EOR (see also recvmsg()) */
-		if (sk->sk_type == SOCK_STREAM &&
-		    skb->truesize >= sk->sk_rcvbuf / 4) {
-			rc = iucv_fragment_skb(sk, skb, len);
-			kfree_skb(skb);
-			skb = NULL;
-			if (rc) {
-				pr_iucv->path_sever(path, NULL);
-				return;
-			}
-			skb = skb_dequeue(&iucv_sk(sk)->backlog_skb_q);
-		} else {
-			skb_reset_transport_header(skb);
-			skb_reset_network_header(skb);
-			skb->len = len;
-		}
+		skb_reset_transport_header(skb);
+		skb_reset_network_header(skb);
+		skb->len = len;
 	}
 
 	IUCV_SKB_CB(skb)->offset = 0;
-- 
2.6.6
