From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/4] s390/qeth: add support for IPv6 TSO
Date: Fri, 12 Oct 2018 17:27:14 +0200
Message-ID: <20181012152715.6153-4-jwi@linux.ibm.com>
References: <20181012152715.6153-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181012152715.6153-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This adds TSO6 support for L3 qeth devices.
Just like for standard IPv6 traffic, TSO6 doesn't use IP offload and
thus runs over the normal qeth_xmit() path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 ++
 drivers/s390/net/qeth_core_main.c | 49 +++++++++++++++++++++++++++++++++++----
 drivers/s390/net/qeth_l3_main.c   | 45 +++++++++++++++--------------------
 3 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index cd44ff2df6fe..c1278785a13c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1047,6 +1047,8 @@ int qeth_vm_request_mac(struct qeth_card *card);
 int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
 		       struct qeth_hdr **hdr, unsigned int hdr_len,
 		       unsigned int proto_len, unsigned int *elements);
+void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr, unsigned int payload_len,
+		       struct sk_buff *skb, unsigned int proto_len);
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
 	      void (*fill_header)(struct qeth_card *card, struct qeth_hdr *hdr,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ab022b6a41ea..3274f13aad57 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4088,15 +4088,31 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 }
 EXPORT_SYMBOL_GPL(qeth_do_send_packet);
 
+void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr, unsigned int payload_len,
+		       struct sk_buff *skb, unsigned int proto_len)
+{
+	struct qeth_hdr_ext_tso *ext = &hdr->ext;
+
+	ext->hdr_tot_len = sizeof(*ext);
+	ext->imb_hdr_no = 1;
+	ext->hdr_type = 1;
+	ext->hdr_version = 1;
+	ext->hdr_len = 28;
+	ext->payload_len = payload_len;
+	ext->mss = skb_shinfo(skb)->gso_size;
+	ext->dg_hdr_len = proto_len;
+}
+EXPORT_SYMBOL_GPL(qeth_fill_tso_ext);
+
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
 	      void (*fill_header)(struct qeth_card *card, struct qeth_hdr *hdr,
 				  struct sk_buff *skb, int ipv, int cast_type,
 				  unsigned int data_len))
 {
-	const unsigned int proto_len = IS_IQD(card) ? ETH_HLEN : 0;
-	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
+	unsigned int proto_len, hw_hdr_len;
 	unsigned int frame_len = skb->len;
+	bool is_tso = skb_is_gso(skb);
 	unsigned int data_offset = 0;
 	struct qeth_hdr *hdr = NULL;
 	unsigned int hd_len = 0;
@@ -4104,6 +4120,14 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	int push_len, rc;
 	bool is_sg;
 
+	if (is_tso) {
+		hw_hdr_len = sizeof(struct qeth_hdr_tso);
+		proto_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
+	} else {
+		hw_hdr_len = sizeof(struct qeth_hdr);
+		proto_len = IS_IQD(card) ? ETH_HLEN : 0;
+	}
+
 	rc = skb_cow_head(skb, hw_hdr_len);
 	if (rc)
 		return rc;
@@ -4112,13 +4136,16 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 				      &elements);
 	if (push_len < 0)
 		return push_len;
-	if (!push_len) {
+	if (is_tso || !push_len) {
 		/* HW header needs its own buffer element. */
 		hd_len = hw_hdr_len + proto_len;
-		data_offset = proto_len;
+		data_offset = push_len + proto_len;
 	}
 	memset(hdr, 0, hw_hdr_len);
 	fill_header(card, hdr, skb, ipv, cast_type, frame_len);
+	if (is_tso)
+		qeth_fill_tso_ext((struct qeth_hdr_tso *) hdr,
+				  frame_len - proto_len, skb, proto_len);
 
 	is_sg = skb_is_nonlinear(skb);
 	if (IS_IQD(card)) {
@@ -4136,6 +4163,10 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 			card->perf_stats.buf_elements_sent += elements;
 			if (is_sg)
 				card->perf_stats.sg_skbs_sent++;
+			if (is_tso) {
+				card->perf_stats.large_send_bytes += frame_len;
+				card->perf_stats.large_send_cnt++;
+			}
 		}
 	} else {
 		if (!push_len)
@@ -6516,7 +6547,7 @@ static int qeth_set_ipa_rx_csum(struct qeth_card *card, bool on)
 }
 
 #define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO | \
-			  NETIF_F_IPV6_CSUM)
+			  NETIF_F_IPV6_CSUM | NETIF_F_TSO6)
 /**
  * qeth_enable_hw_features() - (Re-)Enable HW functions for device features
  * @dev:	a net_device
@@ -6572,6 +6603,12 @@ int qeth_set_features(struct net_device *dev, netdev_features_t features)
 		if (rc)
 			changed ^= NETIF_F_TSO;
 	}
+	if (changed & NETIF_F_TSO6) {
+		rc = qeth_set_ipa_tso(card, features & NETIF_F_TSO6,
+				      QETH_PROT_IPV6);
+		if (rc)
+			changed ^= NETIF_F_TSO6;
+	}
 
 	/* everything changed successfully? */
 	if ((dev->features ^ features) == changed)
@@ -6597,6 +6634,8 @@ netdev_features_t qeth_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_RXCSUM;
 	if (!qeth_is_supported(card, IPA_OUTBOUND_TSO))
 		features &= ~NETIF_F_TSO;
+	if (!qeth_is_supported6(card, IPA_OUTBOUND_TSO))
+		features &= ~NETIF_F_TSO6;
 	/* if the card isn't up, remove features that require hw changes */
 	if (card->state == CARD_STATE_DOWN ||
 	    card->state == CARD_STATE_RECOVER)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 80893481bb85..ac7c8ae123c3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2099,22 +2099,6 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	rcu_read_unlock();
 }
 
-static void qeth_l3_fill_tso_ext(struct qeth_hdr_tso *hdr,
-				 unsigned int payload_len, struct sk_buff *skb,
-				 unsigned int proto_len)
-{
-	struct qeth_hdr_ext_tso *ext = &hdr->ext;
-
-	ext->hdr_tot_len = sizeof(*ext);
-	ext->imb_hdr_no = 1;
-	ext->hdr_type = 1;
-	ext->hdr_version = 1;
-	ext->hdr_len = 28;
-	ext->payload_len = payload_len;
-	ext->mss = skb_shinfo(skb)->gso_size;
-	ext->dg_hdr_len = proto_len;
-}
-
 static void qeth_l3_fixup_headers(struct sk_buff *skb)
 {
 	struct iphdr *iph = ip_hdr(skb);
@@ -2175,9 +2159,9 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 	} else {
 		qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
 		if (is_tso)
-			qeth_l3_fill_tso_ext((struct qeth_hdr_tso *) hdr,
-					     frame_len - proto_len, skb,
-					     proto_len);
+			qeth_fill_tso_ext((struct qeth_hdr_tso *) hdr,
+					  frame_len - proto_len, skb,
+					  proto_len);
 	}
 
 	is_sg = skb_is_nonlinear(skb);
@@ -2401,6 +2385,7 @@ static const struct net_device_ops qeth_l3_osa_netdev_ops = {
 
 static int qeth_l3_setup_netdev(struct qeth_card *card)
 {
+	unsigned int headroom;
 	int rc;
 
 	if (card->dev->netdev_ops)
@@ -2415,11 +2400,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 		}
 
 		card->dev->netdev_ops = &qeth_l3_osa_netdev_ops;
-		card->dev->needed_headroom = sizeof(struct qeth_hdr);
-		/* allow for de-acceleration of NETIF_F_HW_VLAN_CTAG_TX: */
-		card->dev->needed_headroom += VLAN_HLEN;
-		if (qeth_is_supported(card, IPA_OUTBOUND_TSO))
-			card->dev->needed_headroom = sizeof(struct qeth_hdr_tso);
 
 		/*IPv6 address autoconfiguration stuff*/
 		qeth_l3_get_unique_id(card);
@@ -2438,10 +2418,22 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 			card->dev->hw_features |= NETIF_F_IPV6_CSUM;
 			card->dev->vlan_features |= NETIF_F_IPV6_CSUM;
 		}
+		if (qeth_is_supported6(card, IPA_OUTBOUND_TSO)) {
+			card->dev->hw_features |= NETIF_F_TSO6;
+			card->dev->vlan_features |= NETIF_F_TSO6;
+		}
+
+		/* allow for de-acceleration of NETIF_F_HW_VLAN_CTAG_TX: */
+		if (card->dev->hw_features & NETIF_F_TSO6)
+			headroom = sizeof(struct qeth_hdr_tso) + VLAN_HLEN;
+		else if (card->dev->hw_features & NETIF_F_TSO)
+			headroom = sizeof(struct qeth_hdr_tso);
+		else
+			headroom = sizeof(struct qeth_hdr) + VLAN_HLEN;
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
 		card->dev->flags |= IFF_NOARP;
 		card->dev->netdev_ops = &qeth_l3_netdev_ops;
-		card->dev->needed_headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
+		headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
 
 		rc = qeth_l3_iqd_read_initial_mac(card);
 		if (rc)
@@ -2452,13 +2444,14 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 	} else
 		return -ENODEV;
 
+	card->dev->needed_headroom = headroom;
 	card->dev->ethtool_ops = &qeth_l3_ethtool_ops;
 	card->dev->features |=	NETIF_F_HW_VLAN_CTAG_TX |
 				NETIF_F_HW_VLAN_CTAG_RX |
 				NETIF_F_HW_VLAN_CTAG_FILTER;
 
 	netif_keep_dst(card->dev);
-	if (card->dev->hw_features & NETIF_F_TSO)
+	if (card->dev->hw_features & (NETIF_F_TSO | NETIF_F_TSO6))
 		netif_set_gso_max_size(card->dev,
 				       PAGE_SIZE * (QETH_MAX_BUFFER_ELEMENTS(card) - 1));
 
-- 
2.16.4
