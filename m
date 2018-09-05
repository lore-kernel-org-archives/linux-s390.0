From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/3] net/af_iucv: fix skb handling on HiperTransport xmit error
Date: Wed,  5 Sep 2018 16:55:11 +0200
Message-ID: <20180905145512.30165-3-jwi@linux.ibm.com>
References: <20180905145512.30165-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180905145512.30165-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When sending an skb, afiucv_hs_send() bails out on various error
conditions. But currently the caller has no way of telling whether the
skb was freed or not - resulting in potentially either
a) leaked skbs from iucv_send_ctrl(), or
b) double-free's from iucv_sock_sendmsg().

As dev_queue_xmit() will always consume the skb (even on error), be
consistent and also free the skb from all other error paths. This way
callers no longer need to care about managing the skb.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/iucv/af_iucv.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 01000c14417f..e2f16a0173a9 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -351,20 +351,28 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 		memcpy(&phs_hdr->iucv_hdr, imsg, sizeof(struct iucv_message));
 
 	skb->dev = iucv->hs_dev;
-	if (!skb->dev)
-		return -ENODEV;
-	if (!(skb->dev->flags & IFF_UP) || !netif_carrier_ok(skb->dev))
-		return -ENETDOWN;
+	if (!skb->dev) {
+		err = -ENODEV;
+		goto err_free;
+	}
+	if (!(skb->dev->flags & IFF_UP) || !netif_carrier_ok(skb->dev)) {
+		err = -ENETDOWN;
+		goto err_free;
+	}
 	if (skb->len > skb->dev->mtu) {
-		if (sock->sk_type == SOCK_SEQPACKET)
-			return -EMSGSIZE;
-		else
-			skb_trim(skb, skb->dev->mtu);
+		if (sock->sk_type == SOCK_SEQPACKET) {
+			err = -EMSGSIZE;
+			goto err_free;
+		}
+		skb_trim(skb, skb->dev->mtu);
 	}
 	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 	nskb = skb_clone(skb, GFP_ATOMIC);
-	if (!nskb)
-		return -ENOMEM;
+	if (!nskb) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+
 	skb_queue_tail(&iucv->send_skb_q, nskb);
 	err = dev_queue_xmit(skb);
 	if (net_xmit_eval(err)) {
@@ -375,6 +383,10 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
 	}
 	return net_xmit_eval(err);
+
+err_free:
+	kfree_skb(skb);
+	return err;
 }
 
 static struct sock *__iucv_get_sock_by_name(char *nm)
@@ -1167,7 +1179,7 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = afiucv_hs_send(&txmsg, sk, skb, 0);
 		if (err) {
 			atomic_dec(&iucv->msg_sent);
-			goto fail;
+			goto out;
 		}
 	} else { /* Classic VM IUCV transport */
 		skb_queue_tail(&iucv->send_skb_q, skb);
-- 
2.16.4
