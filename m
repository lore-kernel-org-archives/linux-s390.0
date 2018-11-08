From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/8] s390/qeth: unify transmit code
Date: Thu,  8 Nov 2018 15:06:17 +0100
Message-ID: <20181108140622.35244-4-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Since commit 82bf5c0867f6 ("s390/qeth: add support for IPv6 TSO"),
qeth_xmit() also knows how to build TSO packets and is practically
identical to qeth_l3_xmit().
Convert qeth_l3_xmit() into a thin wrapper that merely strips the
L2 header off a packet, and calls qeth_xmit() for the actual
TX processing.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  8 -----
 drivers/s390/net/qeth_core_main.c | 22 ++++++------
 drivers/s390/net/qeth_l3_main.c   | 72 +++++----------------------------------
 3 files changed, 19 insertions(+), 83 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index d50d91219cf3..afe3662a4ad5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1024,9 +1024,6 @@ int qeth_send_control_data(struct qeth_card *, int, struct qeth_cmd_buffer *,
 	int (*reply_cb)(struct qeth_card *, struct qeth_reply*, unsigned long),
 	void *reply_param);
 unsigned int qeth_count_elements(struct sk_buff *skb, unsigned int data_offset);
-int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue, struct sk_buff *skb,
-			     struct qeth_hdr *hdr, unsigned int offset,
-			     unsigned int hd_len);
 int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			struct sk_buff *skb, struct qeth_hdr *hdr,
 			unsigned int offset, unsigned int hd_len,
@@ -1057,11 +1054,6 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
 int qeth_vm_request_mac(struct qeth_card *card);
-int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
-		       struct qeth_hdr **hdr, unsigned int hdr_len,
-		       unsigned int proto_len, unsigned int *elements);
-void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr, unsigned int payload_len,
-		       struct sk_buff *skb, unsigned int proto_len);
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
 	      void (*fill_header)(struct qeth_card *card, struct qeth_hdr *hdr,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index abeecffb6d2e..2568ddc1bbc3 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3777,9 +3777,9 @@ EXPORT_SYMBOL_GPL(qeth_count_elements);
  * The number of needed buffer elements is returned in @elements.
  * Error to create the hdr is indicated by returning with < 0.
  */
-int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
-		       struct qeth_hdr **hdr, unsigned int hdr_len,
-		       unsigned int proto_len, unsigned int *elements)
+static int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
+			      struct qeth_hdr **hdr, unsigned int hdr_len,
+			      unsigned int proto_len, unsigned int *elements)
 {
 	const unsigned int max_elements = QETH_MAX_BUFFER_ELEMENTS(card);
 	const unsigned int contiguous = proto_len ? proto_len : 1;
@@ -3849,7 +3849,6 @@ int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
 	skb_copy_from_linear_data(skb, ((char *)*hdr) + hdr_len, proto_len);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qeth_add_hw_header);
 
 static void __qeth_fill_buffer(struct sk_buff *skb,
 			       struct qeth_qdio_out_buffer *buf,
@@ -3972,9 +3971,9 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 	return flush_cnt;
 }
 
-int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue, struct sk_buff *skb,
-			     struct qeth_hdr *hdr, unsigned int offset,
-			     unsigned int hd_len)
+static int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue,
+				    struct sk_buff *skb, struct qeth_hdr *hdr,
+				    unsigned int offset, unsigned int hd_len)
 {
 	int index = queue->next_buf_to_fill;
 	struct qeth_qdio_out_buffer *buffer = queue->bufs[index];
@@ -3990,7 +3989,6 @@ int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue, struct sk_buff *skb,
 	qeth_flush_buffers(queue, index, 1);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qeth_do_send_packet_fast);
 
 int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			struct sk_buff *skb, struct qeth_hdr *hdr,
@@ -4082,8 +4080,9 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 }
 EXPORT_SYMBOL_GPL(qeth_do_send_packet);
 
-void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr, unsigned int payload_len,
-		       struct sk_buff *skb, unsigned int proto_len)
+static void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr,
+			      unsigned int payload_len, struct sk_buff *skb,
+			      unsigned int proto_len)
 {
 	struct qeth_hdr_ext_tso *ext = &hdr->ext;
 
@@ -4096,7 +4095,6 @@ void qeth_fill_tso_ext(struct qeth_hdr_tso *hdr, unsigned int payload_len,
 	ext->mss = skb_shinfo(skb)->gso_size;
 	ext->dg_hdr_len = proto_len;
 }
-EXPORT_SYMBOL_GPL(qeth_fill_tso_ext);
 
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
@@ -4119,7 +4117,7 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 		proto_len = skb_transport_offset(skb) + tcp_hdrlen(skb);
 	} else {
 		hw_hdr_len = sizeof(struct qeth_hdr);
-		proto_len = IS_IQD(card) ? ETH_HLEN : 0;
+		proto_len = (IS_IQD(card) && IS_LAYER2(card)) ? ETH_HLEN : 0;
 	}
 
 	rc = skb_cow_head(skb, hw_hdr_len);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 004085344e85..61d847d41cab 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2036,79 +2036,25 @@ static void qeth_l3_fixup_headers(struct sk_buff *skb)
 static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_qdio_out_q *queue, int ipv, int cast_type)
 {
-	unsigned int hw_hdr_len, proto_len, frame_len, elements;
 	unsigned char eth_hdr[ETH_HLEN];
-	bool is_tso = skb_is_gso(skb);
-	unsigned int data_offset = 0;
-	struct qeth_hdr *hdr = NULL;
-	unsigned int hd_len = 0;
-	int push_len, rc;
-	bool is_sg;
-
-	if (is_tso) {
-		hw_hdr_len = sizeof(struct qeth_hdr_tso);
-		proto_len = skb_transport_offset(skb) + tcp_hdrlen(skb) -
-			    ETH_HLEN;
-	} else {
-		hw_hdr_len = sizeof(struct qeth_hdr);
-		proto_len = 0;
-	}
+	unsigned int hw_hdr_len;
+	int rc;
 
 	/* re-use the L2 header area for the HW header: */
+	hw_hdr_len = skb_is_gso(skb) ? sizeof(struct qeth_hdr_tso) :
+				       sizeof(struct qeth_hdr);
 	rc = skb_cow_head(skb, hw_hdr_len - ETH_HLEN);
 	if (rc)
 		return rc;
 	skb_copy_from_linear_data(skb, eth_hdr, ETH_HLEN);
 	skb_pull(skb, ETH_HLEN);
-	frame_len = skb->len;
 
 	qeth_l3_fixup_headers(skb);
-	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, proto_len,
-				      &elements);
-	if (push_len < 0)
-		return push_len;
-	if (is_tso || !push_len) {
-		/* HW header needs its own buffer element. */
-		hd_len = hw_hdr_len + proto_len;
-		data_offset = push_len + proto_len;
-	}
-	memset(hdr, 0, hw_hdr_len);
-
-	qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
-	if (is_tso)
-		qeth_fill_tso_ext((struct qeth_hdr_tso *) hdr,
-				  frame_len - proto_len, skb, proto_len);
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
-			if (is_tso) {
-				card->perf_stats.large_send_bytes += frame_len;
-				card->perf_stats.large_send_cnt++;
-			}
-		}
-	} else {
-		if (!push_len)
-			kmem_cache_free(qeth_core_header_cache, hdr);
-		if (rc == -EBUSY) {
-			/* roll back to ETH header */
-			skb_pull(skb, push_len);
-			skb_push(skb, ETH_HLEN);
-			skb_copy_to_linear_data(skb, eth_hdr, ETH_HLEN);
-		}
+	rc = qeth_xmit(card, skb, queue, ipv, cast_type, qeth_l3_fill_header);
+	if (rc == -EBUSY) {
+		/* roll back to ETH header */
+		skb_push(skb, ETH_HLEN);
+		skb_copy_to_linear_data(skb, eth_hdr, ETH_HLEN);
 	}
 	return rc;
 }
-- 
2.16.4
