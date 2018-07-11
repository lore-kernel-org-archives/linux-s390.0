From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/10] s390/qeth: speed-up IPv4 OSA xmit
Date: Wed, 11 Jul 2018 17:42:47 +0200
Message-ID: <20180711154247.5523-11-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Move the xmit of offload-eligible (ie IPv4) traffic on OSA over to the
new, copy-free path.
As with L2, we'll need to preserve the skb_orphan() behaviour of the
old code path until TX completion is sufficiently fast.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0863ffa9ab59..062f62b49294 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2050,6 +2050,12 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		hdr->hdr.l3.vlan_id = skb_vlan_tag_get(skb);
 	}
 
+	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
+		qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
+		if (card->options.performance_stats)
+			card->perf_stats.tx_csum++;
+	}
+
 	/* OSA only: */
 	if (!ipv) {
 		hdr->hdr.l3.flags = QETH_HDR_PASSTHRU;
@@ -2164,8 +2170,8 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	unsigned char eth_hdr[ETH_HLEN];
 	unsigned int hdr_elements = 0;
 	struct qeth_hdr *hdr = NULL;
+	int elements, push_len, rc;
 	unsigned int hd_len = 0;
-	int push_len, rc;
 
 	/* compress skb to fit into one IO buffer: */
 	if (!qeth_get_elements_no(card, skb, 0, 0)) {
@@ -2199,17 +2205,26 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 		hdr_elements = 1;
 	}
 
-	if (!qeth_get_elements_no(card, skb, hdr_elements, 0)) {
+	elements = qeth_get_elements_no(card, skb, hdr_elements, 0);
+	if (!elements) {
 		rc = -E2BIG;
 		goto out;
 	}
+	elements += hdr_elements;
 
 	if (skb->protocol == htons(ETH_P_AF_IUCV))
 		qeth_l3_fill_af_iucv_hdr(hdr, skb, frame_len);
 	else
 		qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
 
-	rc = qeth_do_send_packet_fast(queue, skb, hdr, 0, hd_len);
+	if (IS_IQD(card)) {
+		rc = qeth_do_send_packet_fast(queue, skb, hdr, 0, hd_len);
+	} else {
+		/* TODO: drop skb_orphan() once TX completion is fast enough */
+		skb_orphan(skb);
+		rc = qeth_do_send_packet(card, queue, skb, hdr, 0, hd_len,
+					 elements);
+	}
 out:
 	if (!rc) {
 		if (card->options.performance_stats && nr_frags) {
@@ -2295,12 +2310,6 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 		hdr = skb_push(new_skb, sizeof(struct qeth_hdr));
 		qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type,
 				    new_skb->len - sizeof(struct qeth_hdr));
-
-		if (new_skb->ip_summed == CHECKSUM_PARTIAL) {
-			qeth_tx_csum(new_skb, &hdr->hdr.l3.ext_flags, ipv);
-			if (card->options.performance_stats)
-				card->perf_stats.tx_csum++;
-		}
 	}
 
 	elements = use_tso ?
@@ -2384,7 +2393,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	}
 	netif_stop_queue(dev);
 
-	if (IS_IQD(card))
+	if (IS_IQD(card) || (!skb_is_gso(skb) && ipv == 4))
 		rc = qeth_l3_xmit_offload(card, skb, queue, ipv, cast_type);
 	else
 		rc = qeth_l3_xmit(card, skb, queue, ipv, cast_type);
@@ -2563,9 +2572,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		if (!card->dev)
 			return -ENODEV;
 		card->dev->flags |= IFF_NOARP;
-		card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 		card->dev->netdev_ops = &qeth_l3_netdev_ops;
-		card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
 
 		rc = qeth_l3_iqd_read_initial_mac(card);
 		if (rc)
@@ -2582,6 +2589,8 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 	card->dev->max_mtu = ETH_MAX_MTU;
 	card->dev->dev_port = card->info.portno;
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
+	card->dev->priv_flags &= ~IFF_TX_SKB_SHARING;
+	card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
 	card->dev->features |=	NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
-- 
2.16.4
