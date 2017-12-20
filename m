From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 13/15] s390/qeth: streamline l3_fill_header()
Date: Wed, 20 Dec 2017 20:11:07 +0100
Message-ID: <20171220191109.90487-14-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Consolidate the cast type translation, move the passthru path out of
the RCU-guarded section, and use the appropriate rtable helpers when
determining the next-hop address.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 99 ++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 56 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4723ed9831eb..39b41e24318b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -23,12 +23,15 @@
 #include <linux/inetdevice.h>
 #include <linux/igmp.h>
 #include <linux/slab.h>
+#include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/skbuff.h>
 
 #include <net/ip.h>
 #include <net/arp.h>
 #include <net/route.h>
 #include <net/ipv6.h>
+#include <net/ip6_route.h>
 #include <net/ip6_fib.h>
 #include <net/ip6_checksum.h>
 #include <net/iucv/af_iucv.h>
@@ -896,27 +899,6 @@ static int qeth_l3_deregister_addr_entry(struct qeth_card *card,
 	return rc;
 }
 
-static u8 qeth_l3_get_qeth_hdr_flags4(int cast_type)
-{
-	if (cast_type == RTN_MULTICAST)
-		return QETH_CAST_MULTICAST;
-	if (cast_type == RTN_BROADCAST)
-		return QETH_CAST_BROADCAST;
-	return QETH_CAST_UNICAST;
-}
-
-static u8 qeth_l3_get_qeth_hdr_flags6(int cast_type)
-{
-	u8 ct = QETH_HDR_PASSTHRU | QETH_HDR_IPV6;
-	if (cast_type == RTN_MULTICAST)
-		return ct | QETH_CAST_MULTICAST;
-	if (cast_type == RTN_ANYCAST)
-		return ct | QETH_CAST_ANYCAST;
-	if (cast_type == RTN_BROADCAST)
-		return ct | QETH_CAST_BROADCAST;
-	return ct | QETH_CAST_UNICAST;
-}
-
 static int qeth_l3_setadapter_parms(struct qeth_card *card)
 {
 	int rc = 0;
@@ -2411,14 +2393,23 @@ static void qeth_l3_fill_af_iucv_hdr(struct qeth_card *card,
 	memcpy(hdr->hdr.l3.next_hop.ipv6_addr, daddr, 16);
 }
 
-static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
-		struct sk_buff *skb, int ipv, int cast_type)
+static u8 qeth_l3_cast_type_to_flag(int cast_type)
 {
-	struct dst_entry *dst;
+	if (cast_type == RTN_MULTICAST)
+		return QETH_CAST_MULTICAST;
+	if (cast_type == RTN_ANYCAST)
+		return QETH_CAST_ANYCAST;
+	if (cast_type == RTN_BROADCAST)
+		return QETH_CAST_BROADCAST;
+	return QETH_CAST_UNICAST;
+}
 
+static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
+				struct sk_buff *skb, int ipv, int cast_type)
+{
 	memset(hdr, 0, sizeof(struct qeth_hdr));
 	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
-	hdr->hdr.l3.ext_flags = 0;
+	hdr->hdr.l3.length = skb->len - sizeof(struct qeth_hdr);
 
 	/*
 	 * before we're going to overwrite this location with next hop ip.
@@ -2432,44 +2423,40 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		hdr->hdr.l3.vlan_id = skb_vlan_tag_get(skb);
 	}
 
-	hdr->hdr.l3.length = skb->len - sizeof(struct qeth_hdr);
+	/* OSA only: */
+	if (!ipv) {
+		hdr->hdr.l3.flags = QETH_HDR_PASSTHRU;
+		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
+					    skb->dev->broadcast))
+			hdr->hdr.l3.flags |= QETH_CAST_BROADCAST;
+		else
+			hdr->hdr.l3.flags |= (cast_type == RTN_MULTICAST) ?
+				QETH_CAST_MULTICAST : QETH_CAST_UNICAST;
+		return;
+	}
 
+	hdr->hdr.l3.flags = qeth_l3_cast_type_to_flag(cast_type);
 	rcu_read_lock();
-	dst = skb_dst(skb);
 	if (ipv == 4) {
-		struct rtable *rt = (struct rtable *) dst;
-		__be32 *pkey = &ip_hdr(skb)->daddr;
-
-		if (rt && rt->rt_gateway)
-			pkey = &rt->rt_gateway;
+		struct rtable *rt = skb_rtable(skb);
 
-		/* IPv4 */
-		hdr->hdr.l3.flags = qeth_l3_get_qeth_hdr_flags4(cast_type);
-		memset(hdr->hdr.l3.next_hop.ipv4.res, 0, 12);
-		*((__be32 *) &hdr->hdr.l3.next_hop.ipv4.addr) = *pkey;
-	} else if (ipv == 6) {
-		struct rt6_info *rt = (struct rt6_info *) dst;
-		struct in6_addr *pkey = &ipv6_hdr(skb)->daddr;
+		*((__be32 *) &hdr->hdr.l3.next_hop.ipv4.addr) = (rt) ?
+				rt_nexthop(rt, ip_hdr(skb)->daddr) :
+				ip_hdr(skb)->daddr;
+	} else {
+		/* IPv6 */
+		const struct rt6_info *rt = skb_rt6_info(skb);
+		const struct in6_addr *next_hop;
 
 		if (rt && !ipv6_addr_any(&rt->rt6i_gateway))
-			pkey = &rt->rt6i_gateway;
+			next_hop = &rt->rt6i_gateway;
+		else
+			next_hop = &ipv6_hdr(skb)->daddr;
+		memcpy(hdr->hdr.l3.next_hop.ipv6_addr, next_hop, 16);
 
-		/* IPv6 */
-		hdr->hdr.l3.flags = qeth_l3_get_qeth_hdr_flags6(cast_type);
-		if (card->info.type == QETH_CARD_TYPE_IQD)
-			hdr->hdr.l3.flags &= ~QETH_HDR_PASSTHRU;
-		memcpy(hdr->hdr.l3.next_hop.ipv6_addr, pkey, 16);
-	} else {
-		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
-					    skb->dev->broadcast)) {
-			/* broadcast? */
-			hdr->hdr.l3.flags = QETH_CAST_BROADCAST |
-						QETH_HDR_PASSTHRU;
-		} else {
-			hdr->hdr.l3.flags = (cast_type == RTN_MULTICAST) ?
-				QETH_CAST_MULTICAST | QETH_HDR_PASSTHRU :
-				QETH_CAST_UNICAST | QETH_HDR_PASSTHRU;
-		}
+		hdr->hdr.l3.flags |= QETH_HDR_IPV6;
+		if (card->info.type != QETH_CARD_TYPE_IQD)
+			hdr->hdr.l3.flags |= QETH_HDR_PASSTHRU;
 	}
 	rcu_read_unlock();
 }
-- 
2.13.5
