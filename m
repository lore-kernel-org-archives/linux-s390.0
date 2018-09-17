From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/15] s390/qeth: remove unused L3 xmit code
Date: Mon, 17 Sep 2018 17:35:57 +0200
Message-ID: <20180917153609.94628-4-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_l3_xmit() is now only used for TSOv4 traffic, shrink it down.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 71 ++++++++++-------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2733eb901b04..00e6e7471f5d 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2230,44 +2230,24 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_qdio_out_q *queue, int ipv, int cast_type)
 {
-	int elements, len, rc;
-	__be16 *tag;
 	struct qeth_hdr *hdr = NULL;
-	int hdr_elements = 0;
 	struct sk_buff *new_skb = NULL;
 	int tx_bytes = skb->len;
 	unsigned int hd_len;
-	bool use_tso, is_sg;
-
-	/* Ignore segment size from skb_is_gso(), 1 page is always used. */
-	use_tso = skb_is_gso(skb) &&
-		  (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4);
+	int elements, rc;
+	bool is_sg;
 
 	/* create a clone with writeable headroom */
-	new_skb = skb_realloc_headroom(skb, sizeof(struct qeth_hdr_tso) +
-					    VLAN_HLEN);
+	new_skb = skb_realloc_headroom(skb, sizeof(struct qeth_hdr_tso));
 	if (!new_skb)
 		return -ENOMEM;
 
-	if (ipv == 4) {
-		skb_pull(new_skb, ETH_HLEN);
-	} else if (skb_vlan_tag_present(new_skb)) {
-		skb_push(new_skb, VLAN_HLEN);
-		skb_copy_to_linear_data(new_skb, new_skb->data + 4, 4);
-		skb_copy_to_linear_data_offset(new_skb, 4,
-					       new_skb->data + 8, 4);
-		skb_copy_to_linear_data_offset(new_skb, 8,
-					       new_skb->data + 12, 4);
-		tag = (__be16 *)(new_skb->data + 12);
-		*tag = cpu_to_be16(ETH_P_8021Q);
-		*(tag + 1) = cpu_to_be16(skb_vlan_tag_get(new_skb));
-	}
+	skb_pull(new_skb, ETH_HLEN);
 
 	/* fix hardware limitation: as long as we do not have sbal
 	 * chaining we can not send long frag lists
 	 */
-	if ((use_tso && !qeth_l3_get_elements_no_tso(card, new_skb, 1)) ||
-	    (!use_tso && !qeth_get_elements_no(card, new_skb, 0, 0))) {
+	if (!qeth_l3_get_elements_no_tso(card, new_skb, 1)) {
 		rc = skb_linearize(new_skb);
 
 		if (card->options.performance_stats) {
@@ -2280,38 +2260,23 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 			goto out;
 	}
 
-	if (use_tso) {
-		hdr = skb_push(new_skb, sizeof(struct qeth_hdr_tso));
-		memset(hdr, 0, sizeof(struct qeth_hdr_tso));
-		qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type,
-				    new_skb->len - sizeof(struct qeth_hdr_tso));
-		qeth_tso_fill_header(card, hdr, new_skb);
-		hdr_elements++;
-	} else {
-		hdr = skb_push(new_skb, sizeof(struct qeth_hdr));
-		qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type,
-				    new_skb->len - sizeof(struct qeth_hdr));
-	}
+	hdr = skb_push(new_skb, sizeof(struct qeth_hdr_tso));
+	memset(hdr, 0, sizeof(struct qeth_hdr_tso));
+	qeth_l3_fill_header(card, hdr, new_skb, ipv, cast_type,
+			    new_skb->len - sizeof(struct qeth_hdr_tso));
+	qeth_tso_fill_header(card, hdr, new_skb);
 
-	elements = use_tso ?
-		   qeth_l3_get_elements_no_tso(card, new_skb, hdr_elements) :
-		   qeth_get_elements_no(card, new_skb, hdr_elements, 0);
+	elements = qeth_l3_get_elements_no_tso(card, new_skb, 1);
 	if (!elements) {
 		rc = -E2BIG;
 		goto out;
 	}
-	elements += hdr_elements;
+	elements++;
 
-	if (use_tso) {
-		hd_len = sizeof(struct qeth_hdr_tso) +
-			 ip_hdrlen(new_skb) + tcp_hdrlen(new_skb);
-		len = hd_len;
-	} else {
-		hd_len = 0;
-		len = sizeof(struct qeth_hdr_layer3);
-	}
+	hd_len = sizeof(struct qeth_hdr_tso) + ip_hdrlen(new_skb) +
+		 tcp_hdrlen(new_skb);
 
-	if (qeth_hdr_chk_and_bounce(new_skb, &hdr, len)) {
+	if (qeth_hdr_chk_and_bounce(new_skb, &hdr, hd_len)) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -2327,10 +2292,8 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 			card->perf_stats.buf_elements_sent += elements;
 			if (is_sg)
 				card->perf_stats.sg_skbs_sent++;
-			if (use_tso) {
-				card->perf_stats.large_send_bytes += tx_bytes;
-				card->perf_stats.large_send_cnt++;
-			}
+			card->perf_stats.large_send_bytes += tx_bytes;
+			card->perf_stats.large_send_cnt++;
 		}
 	} else {
 		if (new_skb != skb)
-- 
2.16.4
