From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 05/13] qeth: enable scatter/gather in layer 2 mode
Date: Thu, 16 Jun 2016 16:18:55 +0200
Message-ID: <1466086743-55484-6-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466086743-55484-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

The patch enables NETIF_F_SG flag for OSA in layer 2 mode.
It also adds performance accounting for fragmented sends,
adds a conditional skb_linearize() attempt if the skb had
too many fragments for QDIO SBAL, and fills netdevice->gso_*
attributes.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
Reviewed-by: Lakhvich Dmitriy <ldmitriy@ru.ibm.com>
Reviewed-by: Thomas Richter <tmricht@de.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index faab0b6..ec163e4 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -869,6 +869,7 @@ static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int data_offset = -1;
 	int elements_needed = 0;
 	int hd_len = 0;
+	int nr_frags;
 
 	if (card->qdio.do_prio_queueing || (cast_type &&
 					card->info.is_multicast_different))
@@ -892,6 +893,17 @@ static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 	netif_stop_queue(dev);
 
+	/* fix hardware limitation: as long as we do not have sbal
+	 * chaining we can not send long frag lists
+	 */
+	if ((card->info.type != QETH_CARD_TYPE_IQD) &&
+	    !qeth_get_elements_no(card, new_skb, 0)) {
+		if (skb_linearize(new_skb))
+			goto tx_drop;
+		if (card->options.performance_stats)
+			card->perf_stats.tx_lin++;
+	}
+
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		hdr = (struct qeth_hdr *)skb->data;
 	else {
@@ -943,6 +955,14 @@ static int qeth_l2_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!rc) {
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += tx_bytes;
+		if (card->options.performance_stats) {
+			nr_frags = skb_shinfo(new_skb)->nr_frags;
+			if (nr_frags) {
+				card->perf_stats.sg_skbs_sent++;
+				/* nr_frags + skb->data */
+				card->perf_stats.sg_frags_sent += nr_frags + 1;
+			}
+		}
 		if (new_skb != skb)
 			dev_kfree_skb_any(skb);
 		rc = NETDEV_TX_OK;
@@ -1118,12 +1138,16 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		&qeth_l2_ethtool_ops : &qeth_l2_osn_ops;
 	card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
-		card->dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
+		card->dev->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
+					 NETIF_F_SG;
 		/* Turn on RX offloading per default */
 		card->dev->features |= NETIF_F_RXCSUM;
 	}
 	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
+	card->dev->gso_max_size = (QETH_MAX_BUFFER_ELEMENTS(card) - 1) *
+				  PAGE_SIZE;
+	card->dev->gso_max_segs = (QETH_MAX_BUFFER_ELEMENTS(card) - 1);
 	SET_NETDEV_DEV(card->dev, &card->gdev->dev);
 	netif_napi_add(card->dev, &card->napi, qeth_l2_poll, QETH_NAPI_WEIGHT);
 	netif_carrier_off(card->dev);
-- 
2.6.6
