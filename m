From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 10/15] s390/qeth: clean up l3_get_cast_type()
Date: Wed, 20 Dec 2017 20:11:04 +0100
Message-ID: <20171220191109.90487-11-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Use the proper helpers to check for multicast IP addressing, and remove
some ancient Token Ring code.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  3 ---
 drivers/s390/net/qeth_l3_main.c | 52 ++++++++++++++++-------------------------
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index af9d1efd2e78..146e2df113a1 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -507,9 +507,6 @@ struct qeth_qdio_info {
 
 #define QETH_ETH_MAC_V4      0x0100 /* like v4 */
 #define QETH_ETH_MAC_V6      0x3333 /* like v6 */
-/* tr mc mac is longer, but that will be enough to detect mc frames */
-#define QETH_TR_MAC_NC       0xc000 /* non-canonical */
-#define QETH_TR_MAC_C        0x0300 /* canonical */
 
 /**
  * buffer stuff for read channel
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 64347ee116c8..d9d944d67eb1 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/etherdevice.h>
 #include <linux/ip.h>
+#include <linux/in.h>
 #include <linux/ipv6.h>
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
@@ -27,6 +28,7 @@
 #include <net/ip.h>
 #include <net/arp.h>
 #include <net/route.h>
+#include <net/ipv6.h>
 #include <net/ip6_fib.h>
 #include <net/ip6_checksum.h>
 #include <net/iucv/af_iucv.h>
@@ -2349,9 +2351,9 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	return rc;
 }
 
-static int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
+static int qeth_l3_get_cast_type(struct sk_buff *skb)
 {
-	int cast_type = RTN_UNSPEC;
+	u16 hdr_mac = *((u16 *)skb->data);
 	struct neighbour *n = NULL;
 	struct dst_entry *dst;
 
@@ -2360,48 +2362,34 @@ static int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
 	if (dst)
 		n = dst_neigh_lookup_skb(dst, skb);
 	if (n) {
-		cast_type = n->type;
+		int cast_type = n->type;
+
 		rcu_read_unlock();
 		neigh_release(n);
 		if ((cast_type == RTN_BROADCAST) ||
 		    (cast_type == RTN_MULTICAST) ||
 		    (cast_type == RTN_ANYCAST))
 			return cast_type;
-		else
-			return RTN_UNSPEC;
+		return RTN_UNSPEC;
 	}
 	rcu_read_unlock();
 
-	/* try something else */
+	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
 	if (be16_to_cpu(skb->protocol) == ETH_P_IPV6)
-		return (skb_network_header(skb)[24] == 0xff) ?
-				RTN_MULTICAST : 0;
+		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ?
+				RTN_MULTICAST : RTN_UNSPEC;
 	else if (be16_to_cpu(skb->protocol) == ETH_P_IP)
-		return ((skb_network_header(skb)[16] & 0xf0) == 0xe0) ?
-				RTN_MULTICAST : 0;
-	/* ... */
+		return ipv4_is_multicast(ip_hdr(skb)->daddr) ?
+				RTN_MULTICAST : RTN_UNSPEC;
+
+	/* ... and MAC address */
 	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, skb->dev->broadcast))
 		return RTN_BROADCAST;
-	else {
-		u16 hdr_mac;
-
-		hdr_mac = *((u16 *)skb->data);
-		/* tr multicast? */
-		switch (card->info.link_type) {
-		case QETH_LINK_TYPE_HSTR:
-		case QETH_LINK_TYPE_LANE_TR:
-			if ((hdr_mac == QETH_TR_MAC_NC) ||
-			    (hdr_mac == QETH_TR_MAC_C))
-				return RTN_MULTICAST;
-			break;
-		/* eth or so multicast? */
-		default:
-		if ((hdr_mac == QETH_ETH_MAC_V4) ||
-			    (hdr_mac == QETH_ETH_MAC_V6))
-				return RTN_MULTICAST;
-		}
-	}
-	return cast_type;
+	if (hdr_mac == QETH_ETH_MAC_V4 || hdr_mac == QETH_ETH_MAC_V6)
+		return RTN_MULTICAST;
+
+	/* default to unicast */
+	return RTN_UNSPEC;
 }
 
 static void qeth_l3_fill_af_iucv_hdr(struct qeth_card *card,
@@ -2582,7 +2570,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	struct qeth_card *card = dev->ml_priv;
 	struct sk_buff *new_skb = NULL;
 	int ipv = qeth_get_ip_version(skb);
-	int cast_type = qeth_l3_get_cast_type(card, skb);
+	int cast_type = qeth_l3_get_cast_type(skb);
 	struct qeth_qdio_out_q *queue =
 		card->qdio.out_qs[card->qdio.do_prio_queueing
 			|| (cast_type && card->info.is_multicast_different) ?
-- 
2.13.5
