From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 8/9] s390/qeth: fold VLAN handling into l3_rebuild_skb()
Date: Mon, 18 Sep 2017 21:18:21 +0200
Message-ID: <20170918191822.65142-9-jwi@linux.vnet.ibm.com>
References: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170918191822.65142-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Move the overly complicated VLAN processing from the L3 RX handler into
its l3_rebuild_skb() helper. No change in functionality.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 733f94cbd4d4..270ac9515f6b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1646,13 +1646,12 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 	return 0;
 }
 
-static int qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
-			       struct qeth_hdr *hdr, unsigned short *vlan_id)
+static void qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
+				struct qeth_hdr *hdr)
 {
 	__u16 prot;
 	struct iphdr *ip_hdr;
 	unsigned char tg_addr[MAX_ADDR_LEN];
-	int is_vlan = 0;
 
 	if (!(hdr->hdr.l3.flags & QETH_HDR_PASSTHRU)) {
 		prot = (hdr->hdr.l3.flags & QETH_HDR_IPV6) ? ETH_P_IPV6 :
@@ -1706,11 +1705,14 @@ static int qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 
 	skb->protocol = eth_type_trans(skb, card->dev);
 
-	if (hdr->hdr.l3.ext_flags &
-	    (QETH_HDR_EXT_VLAN_FRAME | QETH_HDR_EXT_INCLUDE_VLAN_TAG)) {
-		*vlan_id = (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME) ?
-		 hdr->hdr.l3.vlan_id : *((u16 *)&hdr->hdr.l3.dest_addr[12]);
-		is_vlan = 1;
+	/* copy VLAN tag from hdr into skb */
+	if (!card->options.sniffer &&
+	    (hdr->hdr.l3.ext_flags & (QETH_HDR_EXT_VLAN_FRAME |
+				      QETH_HDR_EXT_INCLUDE_VLAN_TAG))) {
+		u16 tag = (hdr->hdr.l3.ext_flags & QETH_HDR_EXT_VLAN_FRAME) ?
+				hdr->hdr.l3.vlan_id :
+				*((u16 *)&hdr->hdr.l3.dest_addr[12]);
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), tag);
 	}
 
 	if (card->dev->features & NETIF_F_RXCSUM) {
@@ -1724,7 +1726,6 @@ static int qeth_l3_rebuild_skb(struct qeth_card *card, struct sk_buff *skb,
 			skb->ip_summed = CHECKSUM_NONE;
 	} else
 		skb->ip_summed = CHECKSUM_NONE;
-	return is_vlan;
 }
 
 static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
@@ -1733,8 +1734,6 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 	int work_done = 0;
 	struct sk_buff *skb;
 	struct qeth_hdr *hdr;
-	__u16 vlan_tag = 0;
-	int is_vlan;
 	unsigned int len;
 	__u16 magic;
 
@@ -1764,12 +1763,8 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 					card->dev->addr_len);
 				netif_receive_skb(skb);
 			} else {
-				is_vlan = qeth_l3_rebuild_skb(card, skb, hdr,
-						      &vlan_tag);
+				qeth_l3_rebuild_skb(card, skb, hdr);
 				len = skb->len;
-				if (is_vlan && !card->options.sniffer)
-					__vlan_hwaccel_put_tag(skb,
-						htons(ETH_P_8021Q), vlan_tag);
 				napi_gro_receive(&card->napi, skb);
 			}
 			break;
-- 
2.13.5
