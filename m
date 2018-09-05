From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/3] net/af_iucv: drop inbound packets with invalid flags
Date: Wed,  5 Sep 2018 16:55:10 +0200
Message-ID: <20180905145512.30165-2-jwi@linux.ibm.com>
References: <20180905145512.30165-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180905145512.30165-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Inbound packets may have any combination of flag bits set in their iucv
header. If we don't know how to handle a specific combination, drop the
skb instead of leaking it.

To clarify what error is returned in this case, replace the hard-coded
0 with the corresponding macro.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 net/iucv/af_iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index a21d8ed0a325..01000c14417f 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -2155,8 +2155,8 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct sock *sk;
 	struct iucv_sock *iucv;
 	struct af_iucv_trans_hdr *trans_hdr;
+	int err = NET_RX_SUCCESS;
 	char nullstring[8];
-	int err = 0;
 
 	if (skb->len < (ETH_HLEN + sizeof(struct af_iucv_trans_hdr))) {
 		WARN_ONCE(1, "AF_IUCV too short skb, len=%d, min=%d",
@@ -2254,7 +2254,7 @@ static int afiucv_hs_rcv(struct sk_buff *skb, struct net_device *dev,
 		err = afiucv_hs_callback_rx(sk, skb);
 		break;
 	default:
-		;
+		kfree_skb(skb);
 	}
 
 	return err;
-- 
2.16.4
