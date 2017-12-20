From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 12/15] s390/qeth: unionize next-hop field in qeth L3 header
Date: Wed, 20 Dec 2017 20:11:06 +0100
Message-ID: <20171220191109.90487-13-jwi@linux.vnet.ibm.com>
References: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171220191109.90487-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The L3 packet descriptor's 'dest_addr' field is used for a different
purpose in RX descriptors. Clean up the hard-coded byte accesses and
try to be more self-documenting.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h    | 19 +++++++++++++++++--
 drivers/s390/net/qeth_l3_main.c | 12 ++++++------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 100f7cce0260..db42107bf2f5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -297,8 +297,23 @@ struct qeth_hdr_layer3 {
 	__u8  ext_flags;
 	__u16 vlan_id;
 	__u16 frame_offset;
-	__u8  dest_addr[16];
-} __attribute__ ((packed));
+	union {
+		/* TX: */
+		u8 ipv6_addr[16];
+		struct ipv4 {
+			u8 res[12];
+			u32 addr;
+		} ipv4;
+		/* RX: */
+		struct rx {
+			u8 res1[2];
+			u8 src_mac[6];
+			u8 res2[4];
+			u16 vlan_id;
+			u8 res3[2];
+		} rx;
+	} next_hop;
+};
 
 struct qeth_hdr_layer2 {
 	__u8 id;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e168719c4b93..4723ed9831eb 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1637,7 +1637,7 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 		}
 		if (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_SRC_MAC_ADDR)
 			card->dev->header_ops->create(skb, card->dev, prot,
-				tg_addr, &hdr->hdr.l3.dest_addr[2],
+				tg_addr, &hdr->hdr.l3.next_hop.rx.src_mac,
 				card->dev->addr_len);
 		else
 			card->dev->header_ops->create(skb, card->dev, prot,
@@ -1652,7 +1652,7 @@ static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 				      QETH_HDR_EXT_INCLUDE_VLAN_TAG))) {
 		u16 tag = (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME) ?
 				hdr->hdr.l3.vlan_id :
-				*((u16 *)&hdr->hdr.l3.dest_addr[12]);
+				hdr->hdr.l3.next_hop.rx.vlan_id;
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tag);
 	}
 
@@ -2408,7 +2408,7 @@ static void qeth_l3_fill_af_iucv_hdr(struct qeth_card *card,
 	daddr[0] = 0xfe;
 	daddr[1] = 0x80;
 	memcpy(&daddr[8], iucv_hdr->destUserID, 8);
-	memcpy(hdr->hdr.l3.dest_addr, daddr, 16);
+	memcpy(hdr->hdr.l3.next_hop.ipv6_addr, daddr, 16);
 }
 
 static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
@@ -2445,8 +2445,8 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 
 		/* IPv4 */
 		hdr->hdr.l3.flags = qeth_l3_get_qeth_hdr_flags4(cast_type);
-		memset(hdr->hdr.l3.dest_addr, 0, 12);
-		*((__be32 *) (&hdr->hdr.l3.dest_addr[12])) = *pkey;
+		memset(hdr->hdr.l3.next_hop.ipv4.res, 0, 12);
+		*((__be32 *) &hdr->hdr.l3.next_hop.ipv4.addr) = *pkey;
 	} else if (ipv == 6) {
 		struct rt6_info *rt = (struct rt6_info *) dst;
 		struct in6_addr *pkey = &ipv6_hdr(skb)->daddr;
@@ -2458,7 +2458,7 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		hdr->hdr.l3.flags = qeth_l3_get_qeth_hdr_flags6(cast_type);
 		if (card->info.type == QETH_CARD_TYPE_IQD)
 			hdr->hdr.l3.flags &= ~QETH_HDR_PASSTHRU;
-		memcpy(hdr->hdr.l3.dest_addr, pkey, 16);
+		memcpy(hdr->hdr.l3.next_hop.ipv6_addr, pkey, 16);
 	} else {
 		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
 					    skb->dev->broadcast)) {
-- 
2.13.5
