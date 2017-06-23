From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 1/2] net/iucv: improve endianness handling
Date: Fri, 23 Jun 2017 19:32:27 +0200
Message-ID: <20170623173228.70128-2-jwi@linux.vnet.ibm.com>
References: <20170623173228.70128-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170623173228.70128-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hans Wippel <hwippel@linux.vnet.ibm.com>

Use proper endianness conversion for an skb protocol assignment. Given
that IUCV is only available on big endian systems (s390), this simply
avoids an endianness warning reported by sparse.

Signed-off-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 net/iucv/af_iucv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 2cf9d59f1b72..05112094d76b 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -362,7 +362,7 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 		else
 			skb_trim(skb, skb->dev->mtu);
 	}
-	skb->protocol = ETH_P_AF_IUCV;
+	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 	nskb = skb_clone(skb, GFP_ATOMIC);
 	if (!nskb)
 		return -ENOMEM;
-- 
2.11.2
