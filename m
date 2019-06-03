Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/4] s390/qeth: don't use obsolete dst entry
Date: Mon,  3 Jun 2019 17:04:44 +0200
In-Reply-To: <20190603150446.23351-1-jwi@linux.ibm.com>
References: <20190603150446.23351-1-jwi@linux.ibm.com>
Message-Id: <20190603150446.23351-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

While qeth_l3 uses netif_keep_dst() to hold onto the dst, a skb's dst
may still have been obsoleted (via dst_dev_put()) by the time that we
end up using it. The dst then points to the loopback interface, which
means the neighbour lookup in qeth_l3_get_cast_type() determines a bogus
cast type of RTN_BROADCAST.
For IQD interfaces this causes us to place such skbs on the wrong
HW queue, resulting in TX errors.

Fix-up the various call sites to check whether the dst is obsolete, and
fall back accordingly.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  2 +-
 drivers/s390/net/qeth_l3_main.c | 57 ++++++++++++++++++++-------------
 2 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 784a2e76a1b0..f89f5b0a9805 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -275,7 +275,7 @@ struct qeth_hdr_layer3 {
 		struct in6_addr ipv6_addr;
 		struct ipv4 {
 			u8 res[12];
-			u32 addr;
+			__be32 addr;
 		} ipv4;
 		/* RX: */
 		struct rx {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2df67abdfde7..93bcfc272f20 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1893,8 +1893,9 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 
 	rcu_read_lock();
 	dst = skb_dst(skb);
-	if (dst)
+	if (dst && dst->obsolete <= 0)
 		n = dst_neigh_lookup_skb(dst, skb);
+
 	if (n) {
 		int cast_type = n->type;
 
@@ -1924,6 +1925,33 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	}
 }
 
+static void qeth_l3_get_next_hop_v4(struct sk_buff *skb, __be32 *next_hop)
+{
+	struct rtable *rt;
+
+	rcu_read_lock();
+	rt = skb_rtable(skb);
+	if (rt && rt->dst.obsolete <= 0)
+		*next_hop = rt_nexthop(rt, ip_hdr(skb)->daddr);
+	else
+		*next_hop = ip_hdr(skb)->daddr;
+	rcu_read_unlock();
+}
+
+static void qeth_l3_get_next_hop_v6(struct sk_buff *skb,
+				    struct in6_addr *next_hop)
+{
+	const struct rt6_info *rt;
+
+	rcu_read_lock();
+	rt = skb_rt6_info(skb);
+	if (rt && rt->dst.obsolete <= 0 && !ipv6_addr_any(&rt->rt6i_gateway))
+		*next_hop = rt->rt6i_gateway;
+	else
+		*next_hop = ipv6_hdr(skb)->daddr;
+	rcu_read_unlock();
+}
+
 static u8 qeth_l3_cast_type_to_flag(int cast_type)
 {
 	if (cast_type == RTN_MULTICAST)
@@ -1980,33 +2008,18 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 
 	l3_hdr->flags = qeth_l3_cast_type_to_flag(cast_type);
 
-	/* OSA only: */
-	if (!ipv) {
-		l3_hdr->flags |= QETH_HDR_PASSTHRU;
-		return;
-	}
-
-	rcu_read_lock();
 	if (ipv == 4) {
-		struct rtable *rt = skb_rtable(skb);
-
-		*((__be32 *) &hdr->hdr.l3.next_hop.ipv4.addr) = (rt) ?
-				rt_nexthop(rt, ip_hdr(skb)->daddr) :
-				ip_hdr(skb)->daddr;
-	} else {
-		/* IPv6 */
-		const struct rt6_info *rt = skb_rt6_info(skb);
-
-		if (rt && !ipv6_addr_any(&rt->rt6i_gateway))
-			l3_hdr->next_hop.ipv6_addr = rt->rt6i_gateway;
-		else
-			l3_hdr->next_hop.ipv6_addr = ipv6_hdr(skb)->daddr;
+		qeth_l3_get_next_hop_v4(skb, &l3_hdr->next_hop.ipv4.addr);
+	} else if (ipv == 6) {
+		qeth_l3_get_next_hop_v6(skb, &l3_hdr->next_hop.ipv6_addr);
 
 		hdr->hdr.l3.flags |= QETH_HDR_IPV6;
 		if (!IS_IQD(card))
 			hdr->hdr.l3.flags |= QETH_HDR_PASSTHRU;
+	} else {
+		/* OSA only */
+		l3_hdr->flags |= QETH_HDR_PASSTHRU;
 	}
-	rcu_read_unlock();
 }
 
 static void qeth_l3_fixup_headers(struct sk_buff *skb)
-- 
2.17.1
