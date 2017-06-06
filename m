From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 2/9] s390/qeth: remove skb_is_nonlinear() check on IQD
Date: Tue,  6 Jun 2017 14:33:43 +0200
Message-ID: <20170606123350.13781-3-jwi@linux.vnet.ibm.com>
References: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170606123350.13781-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth doesn't advertise NETIF_F_SG for L3 IQDs. So trust the stack to
not hand us any nonlinear skbs, and remove an always-true condition.

With the fact that data_offset < 0 is no longer possible on IQDs,
apply a small cleanup to subsequent code.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ac8310fe2fb0..56e813972d77 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2676,8 +2676,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	use_tso = skb_is_gso(skb) &&
 		  (qeth_get_ip_protocol(skb) == IPPROTO_TCP) && (ipv == 4);
 
-	if ((card->info.type == QETH_CARD_TYPE_IQD) &&
-	    !skb_is_nonlinear(skb)) {
+	if (card->info.type == QETH_CARD_TYPE_IQD) {
 		new_skb = skb;
 		data_offset = ETH_HLEN;
 		hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
@@ -2690,12 +2689,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 					+ VLAN_HLEN);
 		if (!new_skb)
 			goto tx_drop;
-	}
 
-	if (card->info.type == QETH_CARD_TYPE_IQD) {
-		if (data_offset < 0)
-			skb_pull(new_skb, ETH_HLEN);
-	} else {
 		if (ipv == 4) {
 			skb_pull(new_skb, ETH_HLEN);
 		}
-- 
2.11.2
