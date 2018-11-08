From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/8] s390/qeth: handle af_iucv skbs in qeth_l3_fill_header()
Date: Thu,  8 Nov 2018 15:06:16 +0100
Message-ID: <20181108140622.35244-3-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Filling the HW header from one single function will make it easier to
rip out all the duplicated transmit code in qeth_l3_xmit(). On top, this
saves one conditional branch in the TSO path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  2 +-
 drivers/s390/net/qeth_l3_main.c | 45 +++++++++++++++--------------------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 99af1a0a3314..d50d91219cf3 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -314,7 +314,7 @@ struct qeth_hdr_layer3 {
 	__u16 frame_offset;
 	union {
 		/* TX: */
-		u8 ipv6_addr[16];
+		struct in6_addr ipv6_addr;
 		struct ipv4 {
 			u8 res[12];
 			u32 addr;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f08b745c2007..004085344e85 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1929,22 +1929,6 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	}
 }
 
-static void qeth_l3_fill_af_iucv_hdr(struct qeth_hdr *hdr, struct sk_buff *skb,
-				     unsigned int data_len)
-{
-	char daddr[16];
-
-	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
-	hdr->hdr.l3.length = data_len;
-	hdr->hdr.l3.flags = QETH_HDR_IPV6 | QETH_CAST_UNICAST;
-
-	memset(daddr, 0, sizeof(daddr));
-	daddr[0] = 0xfe;
-	daddr[1] = 0x80;
-	memcpy(&daddr[8], iucv_trans_hdr(skb)->destUserID, 8);
-	memcpy(hdr->hdr.l3.next_hop.ipv6_addr, daddr, 16);
-}
-
 static u8 qeth_l3_cast_type_to_flag(int cast_type)
 {
 	if (cast_type == RTN_MULTICAST)
@@ -1960,6 +1944,7 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 				struct sk_buff *skb, int ipv, int cast_type,
 				unsigned int data_len)
 {
+	struct qeth_hdr_layer3 *l3_hdr = &hdr->hdr.l3;
 	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
 
 	hdr->hdr.l3.length = data_len;
@@ -1968,6 +1953,15 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		hdr->hdr.l3.id = QETH_HEADER_TYPE_L3_TSO;
 	} else {
 		hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
+
+		if (skb->protocol == htons(ETH_P_AF_IUCV)) {
+			l3_hdr->flags = QETH_HDR_IPV6 | QETH_CAST_UNICAST;
+			l3_hdr->next_hop.ipv6_addr.s6_addr16[0] = htons(0xfe80);
+			memcpy(&l3_hdr->next_hop.ipv6_addr.s6_addr32[2],
+			       iucv_trans_hdr(skb)->destUserID, 8);
+			return;
+		}
+
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
 			qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
 			/* some HW requires combined L3+L4 csum offload: */
@@ -2012,13 +2006,11 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	} else {
 		/* IPv6 */
 		const struct rt6_info *rt = skb_rt6_info(skb);
-		const struct in6_addr *next_hop;
 
 		if (rt && !ipv6_addr_any(&rt->rt6i_gateway))
-			next_hop = &rt->rt6i_gateway;
+			l3_hdr->next_hop.ipv6_addr = rt->rt6i_gateway;
 		else
-			next_hop = &ipv6_hdr(skb)->daddr;
-		memcpy(hdr->hdr.l3.next_hop.ipv6_addr, next_hop, 16);
+			l3_hdr->next_hop.ipv6_addr = ipv6_hdr(skb)->daddr;
 
 		hdr->hdr.l3.flags |= QETH_HDR_IPV6;
 		if (card->info.type != QETH_CARD_TYPE_IQD)
@@ -2082,15 +2074,10 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 	}
 	memset(hdr, 0, hw_hdr_len);
 
-	if (skb->protocol == htons(ETH_P_AF_IUCV)) {
-		qeth_l3_fill_af_iucv_hdr(hdr, skb, frame_len);
-	} else {
-		qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
-		if (is_tso)
-			qeth_fill_tso_ext((struct qeth_hdr_tso *) hdr,
-					  frame_len - proto_len, skb,
-					  proto_len);
-	}
+	qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
+	if (is_tso)
+		qeth_fill_tso_ext((struct qeth_hdr_tso *) hdr,
+				  frame_len - proto_len, skb, proto_len);
 
 	is_sg = skb_is_nonlinear(skb);
 	if (IS_IQD(card)) {
-- 
2.16.4
