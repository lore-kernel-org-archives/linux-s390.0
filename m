From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 11/15] s390/qeth: recognize non-IP multicast on L3 transmit
Date: Wed, 20 Dec 2017 20:11:05 +0100
Message-ID: <20171220191109.90487-12-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When
1. an skb has no neighbour, and
2. skb->protocol is not IP[V6],

we select the skb's cast type based on its destination MAC address.

The multicast check is currently restricted to Multicast IP-mapped MACs.
Extend it to also cover non-IP Multicast MACs.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 3 ---
 drivers/s390/net/qeth_l3_main.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 146e2df113a1..100f7cce0260 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -505,9 +505,6 @@ struct qeth_qdio_info {
 	int default_out_queue;
 };
 
-#define QETH_ETH_MAC_V4      0x0100 /* like v4 */
-#define QETH_ETH_MAC_V6      0x3333 /* like v6 */
-
 /**
  * buffer stuff for read channel
  */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d9d944d67eb1..e168719c4b93 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2353,7 +2353,6 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 
 static int qeth_l3_get_cast_type(struct sk_buff *skb)
 {
-	u16 hdr_mac = *((u16 *)skb->data);
 	struct neighbour *n = NULL;
 	struct dst_entry *dst;
 
@@ -2385,7 +2384,7 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	/* ... and MAC address */
 	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, skb->dev->broadcast))
 		return RTN_BROADCAST;
-	if (hdr_mac == QETH_ETH_MAC_V4 || hdr_mac == QETH_ETH_MAC_V6)
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
 		return RTN_MULTICAST;
 
 	/* default to unicast */
-- 
2.13.5
