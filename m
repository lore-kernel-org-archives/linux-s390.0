From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/4] s390/qeth: add TSO support for L2 devices
Date: Fri, 12 Oct 2018 17:27:15 +0200
Message-ID: <20181012152715.6153-5-jwi@linux.ibm.com>
References: <20181012152715.6153-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181012152715.6153-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Except for the new HW header id, this works just like TSO6 on L3 devices
and reuses all the existing data path support in qeth_xmit().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h    |  3 ++-
 drivers/s390/net/qeth_l2_main.c | 30 ++++++++++++++++++++++++------
 drivers/s390/net/qeth_l3_main.c |  2 +-
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c1278785a13c..6843bc7ee9f2 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -390,8 +390,9 @@ enum qeth_layer2_frame_flags {
 enum qeth_header_ids {
 	QETH_HEADER_TYPE_LAYER3 = 0x01,
 	QETH_HEADER_TYPE_LAYER2 = 0x02,
-	QETH_HEADER_TYPE_TSO	= 0x03,
+	QETH_HEADER_TYPE_L3_TSO	= 0x03,
 	QETH_HEADER_TYPE_OSN    = 0x04,
+	QETH_HEADER_TYPE_L2_TSO	= 0x06,
 };
 /* flags for qeth_hdr.ext_flags */
 #define QETH_HDR_EXT_VLAN_FRAME       0x01
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c810d53fff51..23aaf373f631 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -197,15 +197,19 @@ static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 				struct sk_buff *skb, int ipv, int cast_type,
 				unsigned int data_len)
 {
-	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb_mac_header(skb);
+	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
 
-	hdr->hdr.l2.id = QETH_HEADER_TYPE_LAYER2;
 	hdr->hdr.l2.pkt_length = data_len;
 
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
-		if (card->options.performance_stats)
-			card->perf_stats.tx_csum++;
+	if (skb_is_gso(skb)) {
+		hdr->hdr.l2.id = QETH_HEADER_TYPE_L2_TSO;
+	} else {
+		hdr->hdr.l2.id = QETH_HEADER_TYPE_LAYER2;
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
+			if (card->options.performance_stats)
+				card->perf_stats.tx_csum++;
+		}
 	}
 
 	/* set byte byte 3 to casting flags */
@@ -897,6 +901,20 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		card->dev->hw_features |= NETIF_F_RXCSUM;
 		card->dev->vlan_features |= NETIF_F_RXCSUM;
 	}
+	if (qeth_is_supported(card, IPA_OUTBOUND_TSO)) {
+		card->dev->hw_features |= NETIF_F_TSO;
+		card->dev->vlan_features |= NETIF_F_TSO;
+	}
+	if (qeth_is_supported6(card, IPA_OUTBOUND_TSO)) {
+		card->dev->hw_features |= NETIF_F_TSO6;
+		card->dev->vlan_features |= NETIF_F_TSO6;
+	}
+
+	if (card->dev->hw_features & (NETIF_F_TSO | NETIF_F_TSO6)) {
+		card->dev->needed_headroom = sizeof(struct qeth_hdr_tso);
+		netif_set_gso_max_size(card->dev,
+				       PAGE_SIZE * (QDIO_MAX_ELEMENTS_PER_BUFFER - 1));
+	}
 
 	qeth_l2_request_initial_mac(card);
 	netif_napi_add(card->dev, &card->napi, qeth_poll, QETH_NAPI_WEIGHT);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ac7c8ae123c3..0b161cc1fd2e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2037,7 +2037,7 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	hdr->hdr.l3.length = data_len;
 
 	if (skb_is_gso(skb)) {
-		hdr->hdr.l3.id = QETH_HEADER_TYPE_TSO;
+		hdr->hdr.l3.id = QETH_HEADER_TYPE_L3_TSO;
 	} else {
 		hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-- 
2.16.4
