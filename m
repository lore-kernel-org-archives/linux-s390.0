From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/11] s390/qeth: add statistics for consumed buffer elements
Date: Thu, 19 Jul 2018 12:43:55 +0200
Message-ID: <20180719104358.79696-9-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Nowadays an skb fragment typically spans over multiple pages. So replace
the obsolete, SG-only 'fragments' counter with one that tracks the
consumed buffer elements. This is what actually matters for performance.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c |  4 ++--
 drivers/s390/net/qeth_l2_main.c   | 13 +++++++------
 drivers/s390/net/qeth_l3_main.c   | 28 ++++++++++++++--------------
 4 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 994ac7f434d5..6d8005af67f5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -104,6 +104,7 @@ struct qeth_dbf_info {
 struct qeth_perf_stats {
 	unsigned int bufs_rec;
 	unsigned int bufs_sent;
+	unsigned int buf_elements_sent;
 
 	unsigned int skbs_sent_pack;
 	unsigned int bufs_sent_pack;
@@ -137,7 +138,6 @@ struct qeth_perf_stats {
 	unsigned int large_send_bytes;
 	unsigned int large_send_cnt;
 	unsigned int sg_skbs_sent;
-	unsigned int sg_frags_sent;
 	/* initial values when measuring starts */
 	unsigned long initial_rx_packets;
 	unsigned long initial_tx_packets;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 717511c167e7..84f1e1e33f3f 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5970,7 +5970,7 @@ static struct {
 	{"tx skbs packing"},
 	{"tx buffers packing"},
 	{"tx sg skbs"},
-	{"tx sg frags"},
+	{"tx buffer elements"},
 /* 10 */{"rx sg skbs"},
 	{"rx sg frags"},
 	{"rx sg page allocs"},
@@ -6029,7 +6029,7 @@ void qeth_core_get_ethtool_stats(struct net_device *dev,
 	data[6] = card->perf_stats.skbs_sent_pack;
 	data[7] = card->perf_stats.bufs_sent_pack;
 	data[8] = card->perf_stats.sg_skbs_sent;
-	data[9] = card->perf_stats.sg_frags_sent;
+	data[9] = card->perf_stats.buf_elements_sent;
 	data[10] = card->perf_stats.sg_skbs_rx;
 	data[11] = card->perf_stats.sg_frags_rx;
 	data[12] = card->perf_stats.sg_alloc_page_rx;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 668f80680575..a785c5ff73cd 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -672,10 +672,11 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 			    int ipv)
 {
 	int push_len = sizeof(struct qeth_hdr);
-	unsigned int elements, nr_frags;
 	unsigned int hdr_elements = 0;
 	struct qeth_hdr *hdr = NULL;
 	unsigned int hd_len = 0;
+	unsigned int elements;
+	bool is_sg;
 	int rc;
 
 	/* fix hardware limitation: as long as we do not have sbal
@@ -693,7 +694,6 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 		if (rc)
 			return rc;
 	}
-	nr_frags = skb_shinfo(skb)->nr_frags;
 
 	rc = skb_cow_head(skb, push_len);
 	if (rc)
@@ -720,15 +720,16 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 	}
 	elements += hdr_elements;
 
+	is_sg = skb_is_nonlinear(skb);
 	/* TODO: remove the skb_orphan() once TX completion is fast enough */
 	skb_orphan(skb);
 	rc = qeth_do_send_packet(card, queue, skb, hdr, 0, hd_len, elements);
 out:
 	if (!rc) {
-		if (card->options.performance_stats && nr_frags) {
-			card->perf_stats.sg_skbs_sent++;
-			/* nr_frags + skb->data */
-			card->perf_stats.sg_frags_sent += nr_frags + 1;
+		if (card->options.performance_stats) {
+			card->perf_stats.buf_elements_sent += elements;
+			if (is_sg)
+				card->perf_stats.sg_skbs_sent++;
 		}
 	} else {
 		if (hd_len)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 078b891a6d24..c12aeb7d8f26 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2166,12 +2166,13 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 				int cast_type)
 {
 	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
-	unsigned int frame_len, nr_frags;
 	unsigned char eth_hdr[ETH_HLEN];
 	unsigned int hdr_elements = 0;
 	struct qeth_hdr *hdr = NULL;
 	int elements, push_len, rc;
 	unsigned int hd_len = 0;
+	unsigned int frame_len;
+	bool is_sg;
 
 	/* compress skb to fit into one IO buffer: */
 	if (!qeth_get_elements_no(card, skb, 0, 0)) {
@@ -2194,7 +2195,6 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	skb_copy_from_linear_data(skb, eth_hdr, ETH_HLEN);
 	skb_pull(skb, ETH_HLEN);
 	frame_len = skb->len;
-	nr_frags = skb_shinfo(skb)->nr_frags;
 
 	push_len = qeth_push_hdr(skb, &hdr, hw_hdr_len);
 	if (push_len < 0)
@@ -2217,6 +2217,7 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	else
 		qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
 
+	is_sg = skb_is_nonlinear(skb);
 	if (IS_IQD(card)) {
 		rc = qeth_do_send_packet_fast(queue, skb, hdr, 0, hd_len);
 	} else {
@@ -2227,10 +2228,10 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	}
 out:
 	if (!rc) {
-		if (card->options.performance_stats && nr_frags) {
-			card->perf_stats.sg_skbs_sent++;
-			/* nr_frags + skb->data */
-			card->perf_stats.sg_frags_sent += nr_frags + 1;
+		if (card->options.performance_stats) {
+			card->perf_stats.buf_elements_sent += elements;
+			if (is_sg)
+				card->perf_stats.sg_skbs_sent++;
 		}
 	} else {
 		if (!push_len)
@@ -2248,14 +2249,14 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_qdio_out_q *queue, int ipv, int cast_type)
 {
-	unsigned int hd_len, nr_frags;
 	int elements, len, rc;
 	__be16 *tag;
 	struct qeth_hdr *hdr = NULL;
 	int hdr_elements = 0;
 	struct sk_buff *new_skb = NULL;
 	int tx_bytes = skb->len;
-	bool use_tso;
+	unsigned int hd_len;
+	bool use_tso, is_sg;
 
 	/* Ignore segment size from skb_is_gso(), 1 page is always used. */
 	use_tso = skb_is_gso(skb) &&
@@ -2297,7 +2298,6 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 		if (rc)
 			goto out;
 	}
-	nr_frags = skb_shinfo(new_skb)->nr_frags;
 
 	if (use_tso) {
 		hdr = skb_push(new_skb, sizeof(struct qeth_hdr_tso));
@@ -2334,6 +2334,8 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 		rc = -EINVAL;
 		goto out;
 	}
+
+	is_sg = skb_is_nonlinear(new_skb);
 	rc = qeth_do_send_packet(card, queue, new_skb, hdr, hd_len, hd_len,
 				 elements);
 out:
@@ -2341,15 +2343,13 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 		if (new_skb != skb)
 			dev_kfree_skb_any(skb);
 		if (card->options.performance_stats) {
+			card->perf_stats.buf_elements_sent += elements;
+			if (is_sg)
+				card->perf_stats.sg_skbs_sent++;
 			if (use_tso) {
 				card->perf_stats.large_send_bytes += tx_bytes;
 				card->perf_stats.large_send_cnt++;
 			}
-			if (nr_frags) {
-				card->perf_stats.sg_skbs_sent++;
-				/* nr_frags + skb->data */
-				card->perf_stats.sg_frags_sent += nr_frags + 1;
-			}
 		}
 	} else {
 		if (new_skb != skb)
-- 
2.16.4
