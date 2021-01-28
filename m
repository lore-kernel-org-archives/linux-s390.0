Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26052 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhA1L0p (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:26:45 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/5] s390/qeth: remove qeth_get_ip_version()
Date: Thu, 28 Jan 2021 12:25:48 +0100
Message-Id: <20210128112551.18780-3-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
References: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Replace our home-grown helper with the more robust vlan_get_protocol().
This is pretty much a 1:1 replacement, we just need to pass around a
proper ETH_P_* everyhwere and convert the old value range.

For readability also convert the protocol checks in
qeth_l3_hard_start_xmit() to a switch statement.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 40 ++++++++-------------
 drivers/s390/net/qeth_core_main.c | 18 +++++-----
 drivers/s390/net/qeth_l2_main.c   |  6 ++--
 drivers/s390/net/qeth_l3_main.c   | 60 ++++++++++++++++++-------------
 4 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 331dcbbf3e25..a1da83b0b0ef 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -956,24 +956,6 @@ static inline int qeth_get_elements_for_range(addr_t start, addr_t end)
 	return PFN_UP(end) - PFN_DOWN(start);
 }
 
-static inline int qeth_get_ip_version(struct sk_buff *skb)
-{
-	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
-	__be16 prot = veth->h_vlan_proto;
-
-	if (prot == htons(ETH_P_8021Q))
-		prot = veth->h_vlan_encapsulated_proto;
-
-	switch (prot) {
-	case htons(ETH_P_IPV6):
-		return 6;
-	case htons(ETH_P_IP):
-		return 4;
-	default:
-		return 0;
-	}
-}
-
 static inline int qeth_get_ether_cast_type(struct sk_buff *skb)
 {
 	u8 *addr = eth_hdr(skb)->h_dest;
@@ -984,14 +966,20 @@ static inline int qeth_get_ether_cast_type(struct sk_buff *skb)
 	return RTN_UNICAST;
 }
 
-static inline struct dst_entry *qeth_dst_check_rcu(struct sk_buff *skb, int ipv)
+static inline struct dst_entry *qeth_dst_check_rcu(struct sk_buff *skb,
+						   __be16 proto)
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rt6_info *rt;
 
 	rt = (struct rt6_info *) dst;
-	if (dst)
-		dst = dst_check(dst, (ipv == 6) ? rt6_get_cookie(rt) : 0);
+	if (dst) {
+		if (proto == htons(ETH_P_IPV6))
+			dst = dst_check(dst, rt6_get_cookie(rt));
+		else
+			dst = dst_check(dst, 0);
+	}
+
 	return dst;
 }
 
@@ -1014,11 +1002,11 @@ static inline struct in6_addr *qeth_next_hop_v6_rcu(struct sk_buff *skb,
 		return &ipv6_hdr(skb)->daddr;
 }
 
-static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, int ipv)
+static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, __be16 proto)
 {
 	*flags |= QETH_HDR_EXT_CSUM_TRANSP_REQ;
-	if ((ipv == 4 && ip_hdr(skb)->protocol == IPPROTO_UDP) ||
-	    (ipv == 6 && ipv6_hdr(skb)->nexthdr == IPPROTO_UDP))
+	if ((proto == htons(ETH_P_IP) && ip_hdr(skb)->protocol == IPPROTO_UDP) ||
+	    (proto == htons(ETH_P_IPV6) && ipv6_hdr(skb)->nexthdr == IPPROTO_UDP))
 		*flags |= QETH_HDR_EXT_UDP;
 }
 
@@ -1145,10 +1133,10 @@ int qeth_stop(struct net_device *dev);
 
 int qeth_vm_request_mac(struct qeth_card *card);
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
-	      struct qeth_qdio_out_q *queue, int ipv,
+	      struct qeth_qdio_out_q *queue, __be16 proto,
 	      void (*fill_header)(struct qeth_qdio_out_q *queue,
 				  struct qeth_hdr *hdr, struct sk_buff *skb,
-				  int ipv, unsigned int data_len));
+				  __be16 proto, unsigned int data_len));
 
 /* exports for OSN */
 int qeth_osn_assist(struct net_device *, void *, int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0a65213ab606..de9d27e1c529 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -825,7 +825,8 @@ static bool qeth_next_hop_is_local_v4(struct qeth_card *card,
 		return false;
 
 	rcu_read_lock();
-	next_hop = qeth_next_hop_v4_rcu(skb, qeth_dst_check_rcu(skb, 4));
+	next_hop = qeth_next_hop_v4_rcu(skb,
+					qeth_dst_check_rcu(skb, htons(ETH_P_IP)));
 	key = ipv4_addr_hash(next_hop);
 
 	hash_for_each_possible_rcu(card->local_addrs4, tmp, hnode, key) {
@@ -851,7 +852,8 @@ static bool qeth_next_hop_is_local_v6(struct qeth_card *card,
 		return false;
 
 	rcu_read_lock();
-	next_hop = qeth_next_hop_v6_rcu(skb, qeth_dst_check_rcu(skb, 6));
+	next_hop = qeth_next_hop_v6_rcu(skb,
+					qeth_dst_check_rcu(skb, htons(ETH_P_IPV6)));
 	key = ipv6_addr_hash(next_hop);
 
 	hash_for_each_possible_rcu(card->local_addrs6, tmp, hnode, key) {
@@ -3896,11 +3898,11 @@ int qeth_get_priority_queue(struct qeth_card *card, struct sk_buff *skb)
 	switch (card->qdio.do_prio_queueing) {
 	case QETH_PRIO_Q_ING_TOS:
 	case QETH_PRIO_Q_ING_PREC:
-		switch (qeth_get_ip_version(skb)) {
-		case 4:
+		switch (vlan_get_protocol(skb)) {
+		case htons(ETH_P_IP):
 			tos = ipv4_get_dsfield(ip_hdr(skb));
 			break;
-		case 6:
+		case htons(ETH_P_IPV6):
 			tos = ipv6_get_dsfield(ipv6_hdr(skb));
 			break;
 		default:
@@ -4365,10 +4367,10 @@ static void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr,
 }
 
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
-	      struct qeth_qdio_out_q *queue, int ipv,
+	      struct qeth_qdio_out_q *queue, __be16 proto,
 	      void (*fill_header)(struct qeth_qdio_out_q *queue,
 				  struct qeth_hdr *hdr, struct sk_buff *skb,
-				  int ipv, unsigned int data_len))
+				  __be16 proto, unsigned int data_len))
 {
 	unsigned int proto_len, hw_hdr_len;
 	unsigned int frame_len = skb->len;
@@ -4401,7 +4403,7 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 		data_offset = push_len + proto_len;
 	}
 	memset(hdr, 0, hw_hdr_len);
-	fill_header(queue, hdr, skb, ipv, frame_len);
+	fill_header(queue, hdr, skb, proto, frame_len);
 	if (is_tso)
 		qeth_fill_tso_ext((struct qeth_hdr_tso *) hdr,
 				  frame_len - proto_len, skb, proto_len);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 4254caf1d9b6..ca44421a6d6e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -157,7 +157,7 @@ static void qeth_l2_drain_rx_mode_cache(struct qeth_card *card)
 
 static void qeth_l2_fill_header(struct qeth_qdio_out_q *queue,
 				struct qeth_hdr *hdr, struct sk_buff *skb,
-				int ipv, unsigned int data_len)
+				__be16 proto, unsigned int data_len)
 {
 	int cast_type = qeth_get_ether_cast_type(skb);
 	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
@@ -169,7 +169,7 @@ static void qeth_l2_fill_header(struct qeth_qdio_out_q *queue,
 	} else {
 		hdr->hdr.l2.id = QETH_HEADER_TYPE_LAYER2;
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
-			qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
+			qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], proto);
 	}
 
 	/* set byte byte 3 to casting flags */
@@ -551,7 +551,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (IS_OSN(card))
 		rc = qeth_l2_xmit_osn(card, skb, queue);
 	else
-		rc = qeth_xmit(card, skb, queue, qeth_get_ip_version(skb),
+		rc = qeth_xmit(card, skb, queue, vlan_get_protocol(skb),
 			       qeth_l2_fill_header);
 
 	if (!rc)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4c2cae7ae9a7..7a7465376e29 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1576,7 +1576,7 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 }
 
 static int qeth_l3_get_cast_type_rcu(struct sk_buff *skb, struct dst_entry *dst,
-				     int ipv)
+				     __be16 proto)
 {
 	struct neighbour *n = NULL;
 
@@ -1595,13 +1595,13 @@ static int qeth_l3_get_cast_type_rcu(struct sk_buff *skb, struct dst_entry *dst,
 	}
 
 	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
-	switch (ipv) {
-	case 4:
+	switch (proto) {
+	case htons(ETH_P_IP):
 		if (ipv4_is_lbcast(ip_hdr(skb)->daddr))
 			return RTN_BROADCAST;
 		return ipv4_is_multicast(ip_hdr(skb)->daddr) ?
 				RTN_MULTICAST : RTN_UNICAST;
-	case 6:
+	case htons(ETH_P_IPV6):
 		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ?
 				RTN_MULTICAST : RTN_UNICAST;
 	default:
@@ -1612,13 +1612,13 @@ static int qeth_l3_get_cast_type_rcu(struct sk_buff *skb, struct dst_entry *dst,
 
 static int qeth_l3_get_cast_type(struct sk_buff *skb)
 {
-	int ipv = qeth_get_ip_version(skb);
+	__be16 proto = vlan_get_protocol(skb);
 	struct dst_entry *dst;
 	int cast_type;
 
 	rcu_read_lock();
-	dst = qeth_dst_check_rcu(skb, ipv);
-	cast_type = qeth_l3_get_cast_type_rcu(skb, dst, ipv);
+	dst = qeth_dst_check_rcu(skb, proto);
+	cast_type = qeth_l3_get_cast_type_rcu(skb, dst, proto);
 	rcu_read_unlock();
 
 	return cast_type;
@@ -1637,7 +1637,7 @@ static u8 qeth_l3_cast_type_to_flag(int cast_type)
 
 static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 				struct qeth_hdr *hdr, struct sk_buff *skb,
-				int ipv, unsigned int data_len)
+				__be16 proto, unsigned int data_len)
 {
 	struct qeth_hdr_layer3 *l3_hdr = &hdr->hdr.l3;
 	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
@@ -1652,7 +1652,7 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 	} else {
 		hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 
-		if (skb->protocol == htons(ETH_P_AF_IUCV)) {
+		if (proto == htons(ETH_P_AF_IUCV)) {
 			l3_hdr->flags = QETH_HDR_IPV6 | QETH_CAST_UNICAST;
 			l3_hdr->next_hop.addr.s6_addr16[0] = htons(0xfe80);
 			memcpy(&l3_hdr->next_hop.addr.s6_addr32[2],
@@ -1661,14 +1661,14 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 		}
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
+			qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, proto);
 			/* some HW requires combined L3+L4 csum offload: */
-			if (ipv == 4)
+			if (proto == htons(ETH_P_IP))
 				hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
 		}
 	}
 
-	if (ipv == 4 || IS_IQD(card)) {
+	if (proto == htons(ETH_P_IP) || IS_IQD(card)) {
 		/* NETIF_F_HW_VLAN_CTAG_TX */
 		if (skb_vlan_tag_present(skb)) {
 			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_VLAN_FRAME;
@@ -1680,18 +1680,18 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 	}
 
 	rcu_read_lock();
-	dst = qeth_dst_check_rcu(skb, ipv);
+	dst = qeth_dst_check_rcu(skb, proto);
 
 	if (IS_IQD(card) && skb_get_queue_mapping(skb) != QETH_IQD_MCAST_TXQ)
 		cast_type = RTN_UNICAST;
 	else
-		cast_type = qeth_l3_get_cast_type_rcu(skb, dst, ipv);
+		cast_type = qeth_l3_get_cast_type_rcu(skb, dst, proto);
 	l3_hdr->flags |= qeth_l3_cast_type_to_flag(cast_type);
 
-	if (ipv == 4) {
+	if (proto == htons(ETH_P_IP)) {
 		l3_hdr->next_hop.addr.s6_addr32[3] =
 					qeth_next_hop_v4_rcu(skb, dst);
-	} else if (ipv == 6) {
+	} else if (proto == htons(ETH_P_IPV6)) {
 		l3_hdr->next_hop.addr = *qeth_next_hop_v6_rcu(skb, dst);
 
 		hdr->hdr.l3.flags |= QETH_HDR_IPV6;
@@ -1719,7 +1719,7 @@ static void qeth_l3_fixup_headers(struct sk_buff *skb)
 }
 
 static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
-			struct qeth_qdio_out_q *queue, int ipv)
+			struct qeth_qdio_out_q *queue, __be16 proto)
 {
 	unsigned int hw_hdr_len;
 	int rc;
@@ -1733,15 +1733,15 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 	skb_pull(skb, ETH_HLEN);
 
 	qeth_l3_fixup_headers(skb);
-	return qeth_xmit(card, skb, queue, ipv, qeth_l3_fill_header);
+	return qeth_xmit(card, skb, queue, proto, qeth_l3_fill_header);
 }
 
 static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 					   struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
+	__be16 proto = vlan_get_protocol(skb);
 	u16 txq = skb_get_queue_mapping(skb);
-	int ipv = qeth_get_ip_version(skb);
 	struct qeth_qdio_out_q *queue;
 	int rc;
 
@@ -1752,10 +1752,20 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 
 		if (card->options.sniffer)
 			goto tx_drop;
-		if ((card->options.cq != QETH_CQ_ENABLED && !ipv) ||
-		    (card->options.cq == QETH_CQ_ENABLED &&
-		     skb->protocol != htons(ETH_P_AF_IUCV)))
+
+		switch (proto) {
+		case htons(ETH_P_AF_IUCV):
+			if (card->options.cq != QETH_CQ_ENABLED)
+				goto tx_drop;
+			break;
+		case htons(ETH_P_IP):
+		case htons(ETH_P_IPV6):
+			if (card->options.cq == QETH_CQ_ENABLED)
+				goto tx_drop;
+			break;
+		default:
 			goto tx_drop;
+		}
 	} else {
 		queue = card->qdio.out_qs[txq];
 	}
@@ -1764,10 +1774,10 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	    qeth_l3_get_cast_type(skb) == RTN_BROADCAST)
 		goto tx_drop;
 
-	if (ipv == 4 || IS_IQD(card))
-		rc = qeth_l3_xmit(card, skb, queue, ipv);
+	if (proto == htons(ETH_P_IP) || IS_IQD(card))
+		rc = qeth_l3_xmit(card, skb, queue, proto);
 	else
-		rc = qeth_xmit(card, skb, queue, ipv, qeth_l3_fill_header);
+		rc = qeth_xmit(card, skb, queue, proto, qeth_l3_fill_header);
 
 	if (!rc)
 		return NETDEV_TX_OK;
-- 
2.17.1
