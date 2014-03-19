From: frank.blaschka@de.ibm.com
Subject: [patch 3/4] qeth: Removed unused parameter
Date: Wed, 19 Mar 2014 07:58:01 +0100
Message-ID: <20140319065813.522729951@de.ibm.com>
References: <20140319065758.841490297@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=602-qeth-unused-param.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 908d825..8dea3f1 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -241,7 +241,7 @@ static inline int qeth_l2_get_cast_type(struct qeth_card *card,
 }
 
 static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
-			struct sk_buff *skb, int ipv, int cast_type)
+			struct sk_buff *skb, int cast_type)
 {
 	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 
@@ -762,7 +762,7 @@ static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 				goto tx_drop;
 			elements_needed++;
 			skb_reset_mac_header(new_skb);
-			qeth_l2_fill_header(card, hdr, new_skb, ipv, cast_type);
+			qeth_l2_fill_header(card, hdr, new_skb, cast_type);
 			hdr->hdr.l2.pkt_length = new_skb->len;
 			memcpy(((char *)hdr) + sizeof(struct qeth_hdr),
 				skb_mac_header(new_skb), ETH_HLEN);
@@ -775,7 +775,7 @@ static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 			hdr = (struct qeth_hdr *)skb_push(new_skb,
 						sizeof(struct qeth_hdr));
 			skb_set_mac_header(new_skb, sizeof(struct qeth_hdr));
-			qeth_l2_fill_header(card, hdr, new_skb, ipv, cast_type);
+			qeth_l2_fill_header(card, hdr, new_skb, cast_type);
 		}
 	}
 
