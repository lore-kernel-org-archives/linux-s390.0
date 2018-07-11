From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/10] s390/qeth: add a L3 xmit wrapper
Date: Wed, 11 Jul 2018 17:42:45 +0200
Message-ID: <20180711154247.5523-9-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

In preparation for future work, move the high-level xmit work into a
separate wrapper. This matches the L2 xmit code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 122 +++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 57 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d07803df460b..b5a54cc07017 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2156,48 +2156,21 @@ static int qeth_l3_get_elements_no_tso(struct qeth_card *card,
 	return elements;
 }
 
-static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
-					   struct net_device *dev)
+static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
+			struct qeth_qdio_out_q *queue, int ipv, int cast_type)
 {
 	int rc;
 	__be16 *tag;
 	struct qeth_hdr *hdr = NULL;
 	int hdr_elements = 0;
 	int elements;
-	struct qeth_card *card = dev->ml_priv;
 	struct sk_buff *new_skb = NULL;
-	int ipv = qeth_get_ip_version(skb);
-	int cast_type = qeth_l3_get_cast_type(skb);
-	struct qeth_qdio_out_q *queue;
 	int tx_bytes = skb->len;
 	unsigned int hd_len = 0;
 	bool use_tso;
 	int data_offset = -1;
 	unsigned int nr_frags;
 
-	if (((card->info.type == QETH_CARD_TYPE_IQD) &&
-	     (((card->options.cq != QETH_CQ_ENABLED) && !ipv) ||
-	      ((card->options.cq == QETH_CQ_ENABLED) &&
-	       (be16_to_cpu(skb->protocol) != ETH_P_AF_IUCV)))) ||
-	    card->options.sniffer)
-			goto tx_drop;
-
-	if ((card->state != CARD_STATE_UP) || !card->lan_online) {
-		card->stats.tx_carrier_errors++;
-		goto tx_drop;
-	}
-
-	if ((cast_type == RTN_BROADCAST) &&
-	    (card->info.broadcast_capable == 0))
-		goto tx_drop;
-
-	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
-
-	if (card->options.performance_stats) {
-		card->perf_stats.outbound_cnt++;
-		card->perf_stats.outbound_start_time = qeth_get_micros();
-	}
-
 	/* Ignore segment size from skb_is_gso(), 1 page is always used. */
 	use_tso = skb_is_gso(skb) &&
 		  (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4);
@@ -2208,14 +2181,14 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		hd_len = sizeof(*hdr);
 		hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
 		if (!hdr)
-			goto tx_drop;
+			return -ENOMEM;
 		hdr_elements++;
 	} else {
 		/* create a clone with writeable headroom */
 		new_skb = skb_realloc_headroom(skb, sizeof(struct qeth_hdr_tso)
 					+ VLAN_HLEN);
 		if (!new_skb)
-			goto tx_drop;
+			return -ENOMEM;
 
 		if (ipv == 4) {
 			skb_pull(new_skb, ETH_HLEN);
@@ -2234,24 +2207,22 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		}
 	}
 
-	netif_stop_queue(dev);
-
 	/* fix hardware limitation: as long as we do not have sbal
 	 * chaining we can not send long frag lists
 	 */
 	if ((card->info.type != QETH_CARD_TYPE_IQD) &&
 	    ((use_tso && !qeth_l3_get_elements_no_tso(card, new_skb, 1)) ||
 	     (!use_tso && !qeth_get_elements_no(card, new_skb, 0, 0)))) {
-		int lin_rc = skb_linearize(new_skb);
+		rc = skb_linearize(new_skb);
 
 		if (card->options.performance_stats) {
-			if (lin_rc)
+			if (rc)
 				card->perf_stats.tx_linfail++;
 			else
 				card->perf_stats.tx_lin++;
 		}
-		if (lin_rc)
-			goto tx_drop;
+		if (rc)
+			goto out;
 	}
 	nr_frags = skb_shinfo(new_skb)->nr_frags;
 
@@ -2290,9 +2261,8 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		   qeth_get_elements_no(card, new_skb, hdr_elements,
 					(data_offset > 0) ? data_offset : 0);
 	if (!elements) {
-		if (data_offset >= 0)
-			kmem_cache_free(qeth_core_header_cache, hdr);
-		goto tx_drop;
+		rc = -E2BIG;
+		goto out;
 	}
 	elements += hdr_elements;
 
@@ -2306,17 +2276,18 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 			len = sizeof(struct qeth_hdr_layer3);
 		}
 
-		if (qeth_hdr_chk_and_bounce(new_skb, &hdr, len))
-			goto tx_drop;
+		if (qeth_hdr_chk_and_bounce(new_skb, &hdr, len)) {
+			rc = -EINVAL;
+			goto out;
+		}
 		rc = qeth_do_send_packet(card, queue, new_skb, hdr, hd_len,
 					 hd_len, elements);
 	} else
 		rc = qeth_do_send_packet_fast(queue, new_skb, hdr, data_offset,
 					      hd_len);
 
+out:
 	if (!rc) {
-		card->stats.tx_packets++;
-		card->stats.tx_bytes += tx_bytes;
 		if (new_skb != skb)
 			dev_kfree_skb_any(skb);
 		if (card->options.performance_stats) {
@@ -2330,30 +2301,67 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 				card->perf_stats.sg_frags_sent += nr_frags + 1;
 			}
 		}
-		rc = NETDEV_TX_OK;
 	} else {
+		if (new_skb != skb)
+			dev_kfree_skb_any(new_skb);
 		if (data_offset >= 0)
 			kmem_cache_free(qeth_core_header_cache, hdr);
+	}
+	return rc;
+}
 
-		if (rc == -EBUSY) {
-			if (new_skb != skb)
-				dev_kfree_skb_any(new_skb);
-			return NETDEV_TX_BUSY;
-		} else
+static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
+					   struct net_device *dev)
+{
+	int cast_type = qeth_l3_get_cast_type(skb);
+	struct qeth_card *card = dev->ml_priv;
+	int ipv = qeth_get_ip_version(skb);
+	struct qeth_qdio_out_q *queue;
+	int tx_bytes = skb->len;
+	int rc;
+
+	if (IS_IQD(card)) {
+		if (card->options.sniffer)
+			goto tx_drop;
+		if ((card->options.cq != QETH_CQ_ENABLED && !ipv) ||
+		    (card->options.cq == QETH_CQ_ENABLED &&
+		     skb->protocol != htons(ETH_P_AF_IUCV)))
 			goto tx_drop;
 	}
 
-	netif_wake_queue(dev);
-	if (card->options.performance_stats)
-		card->perf_stats.outbound_time += qeth_get_micros() -
-			card->perf_stats.outbound_start_time;
-	return rc;
+	if (card->state != CARD_STATE_UP || !card->lan_online) {
+		card->stats.tx_carrier_errors++;
+		goto tx_drop;
+	}
+
+	if (cast_type == RTN_BROADCAST && !card->info.broadcast_capable)
+		goto tx_drop;
+
+	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
+
+	if (card->options.performance_stats) {
+		card->perf_stats.outbound_cnt++;
+		card->perf_stats.outbound_start_time = qeth_get_micros();
+	}
+	netif_stop_queue(dev);
+
+	rc = qeth_l3_xmit(card, skb, queue, ipv, cast_type);
+
+	if (!rc) {
+		card->stats.tx_packets++;
+		card->stats.tx_bytes += tx_bytes;
+		if (card->options.performance_stats)
+			card->perf_stats.outbound_time += qeth_get_micros() -
+				card->perf_stats.outbound_start_time;
+		netif_wake_queue(dev);
+		return NETDEV_TX_OK;
+	} else if (rc == -EBUSY) {
+		return NETDEV_TX_BUSY;
+	} /* else fall through */
 
 tx_drop:
 	card->stats.tx_dropped++;
 	card->stats.tx_errors++;
-	if ((new_skb != skb) && new_skb)
-		dev_kfree_skb_any(new_skb);
 	dev_kfree_skb_any(skb);
 	netif_wake_queue(dev);
 	return NETDEV_TX_OK;
-- 
2.16.4
