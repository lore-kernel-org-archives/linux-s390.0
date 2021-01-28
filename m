Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231422AbhA1L0q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Jan 2021 06:26:46 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/5] s390/qeth: make cast type selection for af_iucv skbs robust
Date: Thu, 28 Jan 2021 12:25:50 +0100
Message-Id: <20210128112551.18780-5-jwi@linux.ibm.com>
In-Reply-To: <20210128112551.18780-1-jwi@linux.ibm.com>
References: <20210128112551.18780-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

As part of the TX queue selection for af_iucv skbs,
qeth_l3_get_cast_type_rcu() ends up calling qeth_get_ether_cast_type().
Which is rather fragile, since such skbs don't have a proper ETH header
and we rely on it being zeroed out in the right places. Add a separate
case for ETH_P_AF_IUCV instead that does the right thing.

When later building the HW header for such skbs, don't hard-code the
cast type but follow the same path as for other protocol types. Here
the cast type should naturally come from the skb's queue mapping.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4921afb51a1c..dd441eaec66e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1604,8 +1604,10 @@ static int qeth_l3_get_cast_type_rcu(struct sk_buff *skb, struct dst_entry *dst,
 	case htons(ETH_P_IPV6):
 		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ?
 				RTN_MULTICAST : RTN_UNICAST;
+	case htons(ETH_P_AF_IUCV):
+		return RTN_UNICAST;
 	default:
-		/* ... and MAC address */
+		/* OSA only: ... and MAC address */
 		return qeth_get_ether_cast_type(skb);
 	}
 }
@@ -1651,14 +1653,6 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 	} else {
 		hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 
-		if (proto == htons(ETH_P_AF_IUCV)) {
-			l3_hdr->flags = QETH_HDR_IPV6 | QETH_CAST_UNICAST;
-			l3_hdr->next_hop.addr.s6_addr16[0] = htons(0xfe80);
-			memcpy(&l3_hdr->next_hop.addr.s6_addr32[2],
-			       iucv_trans_hdr(skb)->destUserID, 8);
-			return;
-		}
-
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
 			qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, proto);
 			/* some HW requires combined L3+L4 csum offload: */
@@ -1687,16 +1681,25 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 		cast_type = qeth_l3_get_cast_type_rcu(skb, dst, proto);
 	l3_hdr->flags |= qeth_l3_cast_type_to_flag(cast_type);
 
-	if (proto == htons(ETH_P_IP)) {
+	switch (proto) {
+	case htons(ETH_P_IP):
 		l3_hdr->next_hop.addr.s6_addr32[3] =
 					qeth_next_hop_v4_rcu(skb, dst);
-	} else if (proto == htons(ETH_P_IPV6)) {
+		break;
+	case htons(ETH_P_IPV6):
 		l3_hdr->next_hop.addr = *qeth_next_hop_v6_rcu(skb, dst);
 
 		hdr->hdr.l3.flags |= QETH_HDR_IPV6;
 		if (!IS_IQD(card))
 			hdr->hdr.l3.flags |= QETH_HDR_PASSTHRU;
-	} else {
+		break;
+	case htons(ETH_P_AF_IUCV):
+		l3_hdr->next_hop.addr.s6_addr16[0] = htons(0xfe80);
+		memcpy(&l3_hdr->next_hop.addr.s6_addr32[2],
+		       iucv_trans_hdr(skb)->destUserID, 8);
+		l3_hdr->flags |= QETH_HDR_IPV6;
+		break;
+	default:
 		/* OSA only: */
 		l3_hdr->flags |= QETH_HDR_PASSTHRU;
 	}
-- 
2.17.1
