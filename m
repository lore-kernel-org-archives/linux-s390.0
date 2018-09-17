From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/15] s390/qeth: run non-offload L3 traffic over common xmit path
Date: Mon, 17 Sep 2018 17:35:56 +0200
Message-ID: <20180917153609.94628-3-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

L3 OSAs can only offload IPv4 traffic, use the common L2 transmit path
for all other traffic.
In particular there's no support for TX VLAN offload, so any such packet
needs to be manually de-accelerated via ndo_features_check().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 70 ++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ada258c01a08..2733eb901b04 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1983,21 +1983,23 @@ static int qeth_l3_get_cast_type(struct sk_buff *skb)
 	rcu_read_unlock();
 
 	/* no neighbour (eg AF_PACKET), fall back to target's IP address ... */
-	if (be16_to_cpu(skb->protocol) == ETH_P_IPV6)
-		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ?
-				RTN_MULTICAST : RTN_UNICAST;
-	else if (be16_to_cpu(skb->protocol) == ETH_P_IP)
+	switch (qeth_get_ip_version(skb)) {
+	case 4:
 		return ipv4_is_multicast(ip_hdr(skb)->daddr) ?
 				RTN_MULTICAST : RTN_UNICAST;
-
-	/* ... and MAC address */
-	if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest, skb->dev->broadcast))
-		return RTN_BROADCAST;
-	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
-		return RTN_MULTICAST;
-
-	/* default to unicast */
-	return RTN_UNICAST;
+	case 6:
+		return ipv6_addr_is_multicast(&ipv6_hdr(skb)->daddr) ?
+				RTN_MULTICAST : RTN_UNICAST;
+	default:
+		/* ... and MAC address */
+		if (ether_addr_equal_64bits(eth_hdr(skb)->h_dest,
+					    skb->dev->broadcast))
+			return RTN_BROADCAST;
+		if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
+			return RTN_MULTICAST;
+		/* default to unicast */
+		return RTN_UNICAST;
+	}
 }
 
 static void qeth_l3_fill_af_iucv_hdr(struct qeth_hdr *hdr, struct sk_buff *skb,
@@ -2034,20 +2036,21 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 				struct sk_buff *skb, int ipv, int cast_type,
 				unsigned int data_len)
 {
+	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
+
 	memset(hdr, 0, sizeof(struct qeth_hdr));
 	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 	hdr->hdr.l3.length = data_len;
 
-	/*
-	 * before we're going to overwrite this location with next hop ip.
-	 * v6 uses passthrough, v4 sets the tag in the QDIO header.
-	 */
-	if (skb_vlan_tag_present(skb)) {
-		if ((ipv == 4) || (card->info.type == QETH_CARD_TYPE_IQD))
-			hdr->hdr.l3.ext_flags = QETH_HDR_EXT_VLAN_FRAME;
-		else
-			hdr->hdr.l3.ext_flags = QETH_HDR_EXT_INCLUDE_VLAN_TAG;
-		hdr->hdr.l3.vlan_id = skb_vlan_tag_get(skb);
+	if (ipv == 4 || IS_IQD(card)) {
+		/* NETIF_F_HW_VLAN_CTAG_TX */
+		if (skb_vlan_tag_present(skb)) {
+			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_VLAN_FRAME;
+			hdr->hdr.l3.vlan_id = skb_vlan_tag_get(skb);
+		}
+	} else if (veth->h_vlan_proto == htons(ETH_P_8021Q)) {
+		hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_INCLUDE_VLAN_TAG;
+		hdr->hdr.l3.vlan_id = ntohs(veth->h_vlan_TCI);
 	}
 
 	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -2373,8 +2376,11 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 
 	if (IS_IQD(card) || (!skb_is_gso(skb) && ipv == 4))
 		rc = qeth_l3_xmit_offload(card, skb, queue, ipv, cast_type);
-	else
+	else if (skb_is_gso(skb))
 		rc = qeth_l3_xmit(card, skb, queue, ipv, cast_type);
+	else
+		rc = qeth_xmit(card, skb, queue, ipv, cast_type,
+			       qeth_l3_fill_header);
 
 	if (!rc) {
 		card->stats.tx_packets++;
@@ -2476,6 +2482,15 @@ qeth_l3_neigh_setup(struct net_device *dev, struct neigh_parms *np)
 	return 0;
 }
 
+static netdev_features_t qeth_l3_osa_features_check(struct sk_buff *skb,
+						    struct net_device *dev,
+						    netdev_features_t features)
+{
+	if (qeth_get_ip_version(skb) != 4)
+		features &= ~NETIF_F_HW_VLAN_CTAG_TX;
+	return qeth_features_check(skb, dev, features);
+}
+
 static const struct net_device_ops qeth_l3_netdev_ops = {
 	.ndo_open		= qeth_l3_open,
 	.ndo_stop		= qeth_l3_stop,
@@ -2496,7 +2511,7 @@ static const struct net_device_ops qeth_l3_osa_netdev_ops = {
 	.ndo_stop		= qeth_l3_stop,
 	.ndo_get_stats		= qeth_get_stats,
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
-	.ndo_features_check	= qeth_features_check,
+	.ndo_features_check	= qeth_l3_osa_features_check,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
@@ -2524,6 +2539,9 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		}
 
 		card->dev->netdev_ops = &qeth_l3_osa_netdev_ops;
+		card->dev->needed_headroom = sizeof(struct qeth_hdr);
+		/* allow for de-acceleration of NETIF_F_HW_VLAN_CTAG_TX: */
+		card->dev->needed_headroom += VLAN_HLEN;
 
 		/*IPv6 address autoconfiguration stuff*/
 		qeth_l3_get_unique_id(card);
@@ -2545,6 +2563,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
 		card->dev->flags |= IFF_NOARP;
 		card->dev->netdev_ops = &qeth_l3_netdev_ops;
+		card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
 
 		rc = qeth_l3_iqd_read_initial_mac(card);
 		if (rc)
@@ -2556,7 +2575,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		return -ENODEV;
 
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
-	card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
 	card->dev->features |=	NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
-- 
2.16.4
