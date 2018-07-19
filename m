From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 11/11] s390/qeth: speed up L2 IQD xmit
Date: Thu, 19 Jul 2018 12:43:58 +0200
Message-ID: <20180719104358.79696-12-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Modify the L2 OSA xmit path so that it also supports L2 IQD devices
(in particular, their HW header requirements). This allows IQD devices
to advertise NETIF_F_SG support, and eliminates the allocation overhead
for the HW header.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  7 ++++
 drivers/s390/net/qeth_l2_main.c   | 76 ++++++++++++---------------------------
 drivers/s390/net/qeth_l3_main.c   |  3 --
 3 files changed, 30 insertions(+), 56 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 732b517369c7..d09a7110b381 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5731,6 +5731,13 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 	dev->mtu = 0;
 	SET_NETDEV_DEV(dev, &card->gdev->dev);
 	netif_carrier_off(dev);
+
+	if (!IS_OSN(card)) {
+		dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+		dev->hw_features |= NETIF_F_SG;
+		dev->vlan_features |= NETIF_F_SG;
+	}
+
 	return dev;
 }
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c302002e422f..c1829a4b955d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -641,37 +641,13 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 		qeth_promisc_to_bridge(card);
 }
 
-static int qeth_l2_xmit_iqd(struct qeth_card *card, struct sk_buff *skb,
-			    struct qeth_qdio_out_q *queue, int cast_type)
-{
-	unsigned int data_offset = ETH_HLEN;
-	struct qeth_hdr *hdr;
-	int rc;
-
-	hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
-	if (!hdr)
-		return -ENOMEM;
-	qeth_l2_fill_header(hdr, skb, cast_type, skb->len);
-	skb_copy_from_linear_data(skb, ((char *)hdr) + sizeof(*hdr),
-				  data_offset);
-
-	if (!qeth_get_elements_no(card, skb, 1, data_offset)) {
-		rc = -E2BIG;
-		goto out;
-	}
-	rc = qeth_do_send_packet_fast(queue, skb, hdr, data_offset,
-				      sizeof(*hdr) + data_offset);
-out:
-	if (rc)
-		kmem_cache_free(qeth_core_header_cache, hdr);
-	return rc;
-}
-
-static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
-			    struct qeth_qdio_out_q *queue, int cast_type,
-			    int ipv)
+static int qeth_l2_xmit(struct qeth_card *card, struct sk_buff *skb,
+			struct qeth_qdio_out_q *queue, int cast_type, int ipv)
 {
+	const unsigned int proto_len = IS_IQD(card) ? ETH_HLEN : 0;
 	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
+	unsigned int frame_len = skb->len;
+	unsigned int data_offset = 0;
 	struct qeth_hdr *hdr = NULL;
 	unsigned int hd_len = 0;
 	unsigned int elements;
@@ -682,15 +658,16 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 	if (rc)
 		return rc;
 
-	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, 0,
+	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, proto_len,
 				      &elements);
 	if (push_len < 0)
 		return push_len;
 	if (!push_len) {
-		/* hdr was allocated from cache */
-		hd_len = sizeof(*hdr);
+		/* HW header needs its own buffer element. */
+		hd_len = hw_hdr_len + proto_len;
+		data_offset = proto_len;
 	}
-	qeth_l2_fill_header(hdr, skb, cast_type, skb->len - push_len);
+	qeth_l2_fill_header(hdr, skb, cast_type, frame_len);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
 		if (card->options.performance_stats)
@@ -698,9 +675,15 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 	}
 
 	is_sg = skb_is_nonlinear(skb);
-	/* TODO: remove the skb_orphan() once TX completion is fast enough */
-	skb_orphan(skb);
-	rc = qeth_do_send_packet(card, queue, skb, hdr, 0, hd_len, elements);
+	if (IS_IQD(card)) {
+		rc = qeth_do_send_packet_fast(queue, skb, hdr, data_offset,
+					      hd_len);
+	} else {
+		/* TODO: drop skb_orphan() once TX completion is fast enough */
+		skb_orphan(skb);
+		rc = qeth_do_send_packet(card, queue, skb, hdr, data_offset,
+					 hd_len, elements);
+	}
 
 	if (!rc) {
 		if (card->options.performance_stats) {
@@ -759,16 +742,10 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	}
 	netif_stop_queue(dev);
 
-	switch (card->info.type) {
-	case QETH_CARD_TYPE_OSN:
+	if (IS_OSN(card))
 		rc = qeth_l2_xmit_osn(card, skb, queue);
-		break;
-	case QETH_CARD_TYPE_IQD:
-		rc = qeth_l2_xmit_iqd(card, skb, queue, cast_type);
-		break;
-	default:
-		rc = qeth_l2_xmit_osa(card, skb, queue, cast_type, ipv);
-	}
+	else
+		rc = qeth_l2_xmit(card, skb, queue, cast_type, ipv);
 
 	if (!rc) {
 		card->stats.tx_packets++;
@@ -927,6 +904,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		card->dev->flags |= IFF_NOARP;
 	} else {
 		card->dev->ethtool_ops = &qeth_l2_ethtool_ops;
+		card->dev->needed_headroom = sizeof(struct qeth_hdr);
 	}
 
 	if (card->info.type == QETH_CARD_TYPE_OSM)
@@ -934,14 +912,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 	else
 		card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 
-	if (card->info.type != QETH_CARD_TYPE_OSN &&
-	    card->info.type != QETH_CARD_TYPE_IQD) {
-		card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
-		card->dev->needed_headroom = sizeof(struct qeth_hdr);
-		card->dev->hw_features |= NETIF_F_SG;
-		card->dev->vlan_features |= NETIF_F_SG;
-	}
-
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
 		card->dev->features |= NETIF_F_SG;
 		/* OSA 3S and earlier has no RX/TX support */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index b8e828556cf6..1833e7505aca 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2556,13 +2556,10 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		return -ENODEV;
 
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
-	card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
 	card->dev->features |=	NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
-	card->dev->hw_features |= NETIF_F_SG;
-	card->dev->vlan_features |= NETIF_F_SG;
 
 	netif_keep_dst(card->dev);
 	if (card->dev->hw_features & NETIF_F_TSO)
-- 
2.16.4
