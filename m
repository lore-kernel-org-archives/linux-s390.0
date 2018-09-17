From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/15] s390/qeth: move L2 xmit code to core module
Date: Mon, 17 Sep 2018 17:35:55 +0200
Message-ID: <20180917153609.94628-2-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We need the exact same transmit path for non-offload-eligible traffic on
L3 OSAs. So make it accessible from both sub-drivers.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  5 +++
 drivers/s390/net/qeth_core_main.c | 59 +++++++++++++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   | 74 ++++++---------------------------------
 3 files changed, 75 insertions(+), 63 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 34e0d476c5c6..2110fabdcc7a 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1052,6 +1052,11 @@ int qeth_vm_request_mac(struct qeth_card *card);
 int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
 		       struct qeth_hdr **hdr, unsigned int hdr_len,
 		       unsigned int proto_len, unsigned int *elements);
+int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
+	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
+	      void (*fill_header)(struct qeth_card *card, struct qeth_hdr *hdr,
+				  struct sk_buff *skb, int ipv, int cast_type,
+				  unsigned int data_len));
 
 /* exports for OSN */
 int qeth_osn_assist(struct net_device *, void *, int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index de8282420f96..d2ca33a9330a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4176,6 +4176,65 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 }
 EXPORT_SYMBOL_GPL(qeth_do_send_packet);
 
+int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
+	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
+	      void (*fill_header)(struct qeth_card *card, struct qeth_hdr *hdr,
+				  struct sk_buff *skb, int ipv, int cast_type,
+				  unsigned int data_len))
+{
+	const unsigned int proto_len = IS_IQD(card) ? ETH_HLEN : 0;
+	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
+	unsigned int frame_len = skb->len;
+	unsigned int data_offset = 0;
+	struct qeth_hdr *hdr = NULL;
+	unsigned int hd_len = 0;
+	unsigned int elements;
+	int push_len, rc;
+	bool is_sg;
+
+	rc = skb_cow_head(skb, hw_hdr_len);
+	if (rc)
+		return rc;
+
+	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, proto_len,
+				      &elements);
+	if (push_len < 0)
+		return push_len;
+	if (!push_len) {
+		/* HW header needs its own buffer element. */
+		hd_len = hw_hdr_len + proto_len;
+		data_offset = proto_len;
+	}
+	fill_header(card, hdr, skb, ipv, cast_type, frame_len);
+
+	is_sg = skb_is_nonlinear(skb);
+	if (IS_IQD(card)) {
+		rc = qeth_do_send_packet_fast(queue, skb, hdr, data_offset,
+					      hd_len);
+	} else {
+		/* TODO: drop skb_orphan() once TX completion is fast enough */
+		skb_orphan(skb);
+		rc = qeth_do_send_packet(card, queue, skb, hdr, data_offset,
+					 hd_len, elements);
+	}
+
+	if (!rc) {
+		if (card->options.performance_stats) {
+			card->perf_stats.buf_elements_sent += elements;
+			if (is_sg)
+				card->perf_stats.sg_skbs_sent++;
+		}
+	} else {
+		if (!push_len)
+			kmem_cache_free(qeth_core_header_cache, hdr);
+		if (rc == -EBUSY)
+			/* roll back to ETH header */
+			skb_pull(skb, push_len);
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(qeth_xmit);
+
 static int qeth_setadp_promisc_mode_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index b5e38531733f..715d58af5fc4 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -193,8 +193,9 @@ static int qeth_l2_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
 	return RTN_UNICAST;
 }
 
-static void qeth_l2_fill_header(struct qeth_hdr *hdr, struct sk_buff *skb,
-				int cast_type, unsigned int data_len)
+static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
+				struct sk_buff *skb, int ipv, int cast_type,
+				unsigned int data_len)
 {
 	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 
@@ -202,6 +203,12 @@ static void qeth_l2_fill_header(struct qeth_hdr *hdr, struct sk_buff *skb,
 	hdr->hdr.l2.id = QETH_HEADER_TYPE_LAYER2;
 	hdr->hdr.l2.pkt_length = data_len;
 
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
+		if (card->options.performance_stats)
+			card->perf_stats.tx_csum++;
+	}
+
 	/* set byte byte 3 to casting flags */
 	if (cast_type == RTN_MULTICAST)
 		hdr->hdr.l2.flags[2] |= QETH_LAYER2_FLAG_MULTICAST;
@@ -641,66 +648,6 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 		qeth_promisc_to_bridge(card);
 }
 
-static int qeth_l2_xmit(struct qeth_card *card, struct sk_buff *skb,
-			struct qeth_qdio_out_q *queue, int cast_type, int ipv)
-{
-	const unsigned int proto_len = IS_IQD(card) ? ETH_HLEN : 0;
-	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
-	unsigned int frame_len = skb->len;
-	unsigned int data_offset = 0;
-	struct qeth_hdr *hdr = NULL;
-	unsigned int hd_len = 0;
-	unsigned int elements;
-	int push_len, rc;
-	bool is_sg;
-
-	rc = skb_cow_head(skb, hw_hdr_len);
-	if (rc)
-		return rc;
-
-	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, proto_len,
-				      &elements);
-	if (push_len < 0)
-		return push_len;
-	if (!push_len) {
-		/* HW header needs its own buffer element. */
-		hd_len = hw_hdr_len + proto_len;
-		data_offset = proto_len;
-	}
-	qeth_l2_fill_header(hdr, skb, cast_type, frame_len);
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		qeth_tx_csum(skb, &hdr->hdr.l2.flags[1], ipv);
-		if (card->options.performance_stats)
-			card->perf_stats.tx_csum++;
-	}
-
-	is_sg = skb_is_nonlinear(skb);
-	if (IS_IQD(card)) {
-		rc = qeth_do_send_packet_fast(queue, skb, hdr, data_offset,
-					      hd_len);
-	} else {
-		/* TODO: drop skb_orphan() once TX completion is fast enough */
-		skb_orphan(skb);
-		rc = qeth_do_send_packet(card, queue, skb, hdr, data_offset,
-					 hd_len, elements);
-	}
-
-	if (!rc) {
-		if (card->options.performance_stats) {
-			card->perf_stats.buf_elements_sent += elements;
-			if (is_sg)
-				card->perf_stats.sg_skbs_sent++;
-		}
-	} else {
-		if (!push_len)
-			kmem_cache_free(qeth_core_header_cache, hdr);
-		if (rc == -EBUSY)
-			/* roll back to ETH header */
-			skb_pull(skb, push_len);
-	}
-	return rc;
-}
-
 static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
 			    struct qeth_qdio_out_q *queue)
 {
@@ -745,7 +692,8 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (IS_OSN(card))
 		rc = qeth_l2_xmit_osn(card, skb, queue);
 	else
-		rc = qeth_l2_xmit(card, skb, queue, cast_type, ipv);
+		rc = qeth_xmit(card, skb, queue, ipv, cast_type,
+			       qeth_l2_fill_header);
 
 	if (!rc) {
 		card->stats.tx_packets++;
-- 
2.16.4
