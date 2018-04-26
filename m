From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 11/13] s390/qeth: add IPv6 TX checksum offload support
Date: Thu, 26 Apr 2018 09:42:22 +0200
Message-ID: <20180426074224.100432-12-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

Check if a qeth device supports IPv6 TX checksum offload, and advertise
NETIF_F_IPV6_CSUM accordingly. Add support for setting the relevant bits
in IPv6 packet descriptors.

Currently this has only limited use (ie. UDP, or Jumbo Frames). For any
TCP traffic with a standard MSS, the TCP checksum gets calculated
as part of the linear GSO segmentation.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 13 ++++++++-----
 drivers/s390/net/qeth_core_main.c | 18 +++++++++++++-----
 drivers/s390/net/qeth_core_mpc.h  |  1 +
 drivers/s390/net/qeth_l2_main.c   | 14 ++++++++++----
 drivers/s390/net/qeth_l3_main.c   |  7 ++++++-
 5 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 7cbc9bf5d6b0..2a5fec55bf60 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -878,14 +878,17 @@ static inline void qeth_rx_csum(struct qeth_card *card, struct sk_buff *skb,
 	}
 }
 
-static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags)
+static inline void qeth_tx_csum(struct sk_buff *skb, u8 *flags, int ipv)
 {
 	*flags |= QETH_HDR_EXT_CSUM_TRANSP_REQ;
-	if (ip_hdr(skb)->protocol == IPPROTO_UDP)
+	if ((ipv == 4 && ip_hdr(skb)->protocol == IPPROTO_UDP) ||
+	    (ipv == 6 && ipv6_hdr(skb)->nexthdr == IPPROTO_UDP))
 		*flags |= QETH_HDR_EXT_UDP;
-	/* some HW requires combined L3+L4 csum offload: */
-	*flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
-	ip_hdr(skb)->check = 0;
+	if (ipv == 4) {
+		/* some HW requires combined L3+L4 csum offload: */
+		*flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
+		ip_hdr(skb)->check = 0;
+	}
 }
 
 static inline void qeth_put_buffer_pool_entry(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 5e4a509822f1..55b05d9c1cb6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6349,12 +6349,12 @@ static int qeth_ipa_checksum_run_cmd(struct qeth_card *card,
 static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
 				 enum qeth_prot_versions prot)
 {
-	const __u32 required_features = QETH_IPA_CHECKSUM_IP_HDR |
-					QETH_IPA_CHECKSUM_UDP |
-					QETH_IPA_CHECKSUM_TCP;
+	u32 required_features = QETH_IPA_CHECKSUM_UDP | QETH_IPA_CHECKSUM_TCP;
 	struct qeth_checksum_cmd chksum_cb;
 	int rc;
 
+	if (prot == QETH_PROT_IPV4)
+		required_features |= QETH_IPA_CHECKSUM_IP_HDR;
 	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_START, 0,
 				       &chksum_cb, prot);
 	if (!rc) {
@@ -6430,8 +6430,8 @@ static int qeth_set_ipa_tso(struct qeth_card *card, int on)
 	return rc;
 }
 
-#define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO)
-
+#define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO | \
+			  NETIF_F_IPV6_CSUM)
 /**
  * qeth_recover_features() - Restore device features after recovery
  * @dev:	the recovering net_device
@@ -6471,6 +6471,12 @@ int qeth_set_features(struct net_device *dev, netdev_features_t features)
 		if (rc)
 			changed ^= NETIF_F_IP_CSUM;
 	}
+	if (changed & NETIF_F_IPV6_CSUM) {
+		rc = qeth_set_ipa_csum(card, features & NETIF_F_IPV6_CSUM,
+				       IPA_OUTBOUND_CHECKSUM, QETH_PROT_IPV6);
+		if (rc)
+			changed ^= NETIF_F_IPV6_CSUM;
+	}
 	if ((changed & NETIF_F_RXCSUM)) {
 		rc = qeth_set_ipa_csum(card, features & NETIF_F_RXCSUM,
 				       IPA_INBOUND_CHECKSUM, QETH_PROT_IPV4);
@@ -6500,6 +6506,8 @@ netdev_features_t qeth_fix_features(struct net_device *dev,
 	QETH_DBF_TEXT(SETUP, 2, "fixfeat");
 	if (!qeth_is_supported(card, IPA_OUTBOUND_CHECKSUM))
 		features &= ~NETIF_F_IP_CSUM;
+	if (!qeth_is_supported6(card, IPA_OUTBOUND_CHECKSUM_V6))
+		features &= ~NETIF_F_IPV6_CSUM;
 	if (!qeth_is_supported(card, IPA_INBOUND_CHECKSUM))
 		features &= ~NETIF_F_RXCSUM;
 	if (!qeth_is_supported(card, IPA_OUTBOUND_TSO))
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index f4d1ec0b8f5a..af3c35fbfa9e 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -246,6 +246,7 @@ enum qeth_ipa_funcs {
 	IPA_QUERY_ARP_ASSIST	= 0x00040000L,
 	IPA_INBOUND_TSO         = 0x00080000L,
 	IPA_OUTBOUND_TSO        = 0x00100000L,
+	IPA_OUTBOUND_CHECKSUM_V6 = 0x00800000L,
 };
 
 /* SETIP/DELIP IPA Command: ***************************************************/
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 945df56434fd..5b1780fa4cb5 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -660,7 +660,8 @@ static int qeth_l2_xmit_iqd(struct qeth_card *card, struct sk_buff *skb,
 }
 
 static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
-			    struct qeth_qdio_out_q *queue, int cast_type)
+			    struct qeth_qdio_out_q *queue, int cast_type,
+			    int ipv)
 {
 	int push_len = sizeof(struct qeth_hdr);
 	unsigned int elements, nr_frags;
@@ -699,7 +700,7 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 	}
 	qeth_l2_fill_header(hdr, skb, cast_type, skb->len - push_len);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1]);
+		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
 		if (card->options.performance_stats)
 			card->perf_stats.tx_csum++;
 	}
@@ -754,6 +755,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 {
 	struct qeth_card *card = dev->ml_priv;
 	int cast_type = qeth_l2_get_cast_type(card, skb);
+	int ipv = qeth_get_ip_version(skb);
 	struct qeth_qdio_out_q *queue;
 	int tx_bytes = skb->len;
 	int rc;
@@ -761,7 +763,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (card->qdio.do_prio_queueing || (cast_type &&
 					card->info.is_multicast_different))
 		queue = card->qdio.out_qs[qeth_get_priority_queue(card, skb,
-					qeth_get_ip_version(skb), cast_type)];
+					ipv, cast_type)];
 	else
 		queue = card->qdio.out_qs[card->qdio.default_out_queue];
 
@@ -784,7 +786,7 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 		rc = qeth_l2_xmit_iqd(card, skb, queue, cast_type);
 		break;
 	default:
-		rc = qeth_l2_xmit_osa(card, skb, queue, cast_type);
+		rc = qeth_l2_xmit_osa(card, skb, queue, cast_type, ipv);
 	}
 
 	if (!rc) {
@@ -995,6 +997,10 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 			card->dev->vlan_features |= NETIF_F_RXCSUM;
 		}
 	}
+	if (qeth_is_supported6(card, IPA_OUTBOUND_CHECKSUM_V6)) {
+		card->dev->hw_features |= NETIF_F_IPV6_CSUM;
+		card->dev->vlan_features |= NETIF_F_IPV6_CSUM;
+	}
 
 	card->info.broadcast_capable = 1;
 	qeth_l2_request_initial_mac(card);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index dd233fe3d6c4..e7fa479adf47 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2281,7 +2281,7 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		}
 
 		if (new_skb->ip_summed == CHECKSUM_PARTIAL) {
-			qeth_tx_csum(new_skb, &hdr->hdr.l3.ext_flags);
+			qeth_tx_csum(new_skb, &hdr->hdr.l3.ext_flags, ipv);
 			if (card->options.performance_stats)
 				card->perf_stats.tx_csum++;
 		}
@@ -2507,6 +2507,11 @@ static int qeth_l3_setup_netdev(struct qeth_card *card)
 			card->dev->vlan_features |= NETIF_F_TSO |
 				NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
 		}
+
+		if (qeth_is_supported6(card, IPA_OUTBOUND_CHECKSUM_V6)) {
+			card->dev->hw_features |= NETIF_F_IPV6_CSUM;
+			card->dev->vlan_features |= NETIF_F_IPV6_CSUM;
+		}
 	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
 		card->dev = alloc_netdev(0, "hsi%d", NET_NAME_UNKNOWN,
 					 ether_setup);
-- 
2.13.5
