From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/15] s390/qeth: prepare for copy-free TSO transmission
Date: Mon, 17 Sep 2018 17:36:02 +0200
Message-ID: <20180917153609.94628-9-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Add all the necessary TSO plumbing to the copy-less transmit path.
This includes calculating the right length of required protocol headers,
and always building a separate buffer element for the TSO headers.

A follow-up patch will then switch TSO traffic over to this path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 10 ++++-
 drivers/s390/net/qeth_l2_main.c   |  1 -
 drivers/s390/net/qeth_l3_main.c   | 93 ++++++++++++++++++++++++++++-----------
 4 files changed, 77 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index b47fb95a49e9..d86eea9db2a7 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -26,6 +26,7 @@
 #include <net/ipv6.h>
 #include <net/if_inet6.h>
 #include <net/addrconf.h>
+#include <net/tcp.h>
 
 #include <asm/debug.h>
 #include <asm/qdio.h>
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 79ebe8a5687b..460ffdf1b200 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3845,7 +3845,8 @@ int qeth_hdr_chk_and_bounce(struct sk_buff *skb, struct qeth_hdr **hdr, int len)
 }
 EXPORT_SYMBOL_GPL(qeth_hdr_chk_and_bounce);
 
-#define QETH_HDR_CACHE_OBJ_SIZE		(sizeof(struct qeth_hdr) + ETH_HLEN)
+#define QETH_HDR_CACHE_OBJ_SIZE		(sizeof(struct qeth_hdr_tso) + \
+					 MAX_TCP_HEADER)
 
 /**
  * qeth_add_hw_header() - add a HW header to an skb.
@@ -3880,7 +3881,11 @@ int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
 	if (qeth_get_elements_for_range(start, end + contiguous) == 1) {
 		/* Push HW header into same page as first protocol header. */
 		push_ok = true;
-		__elements = qeth_count_elements(skb, 0);
+		/* ... but TSO always needs a separate element for headers: */
+		if (skb_is_gso(skb))
+			__elements = 1 + qeth_count_elements(skb, proto_len);
+		else
+			__elements = qeth_count_elements(skb, 0);
 	} else if (!proto_len && qeth_get_elements_for_range(start, end) == 1) {
 		/* Push HW header into a new page. */
 		push_ok = true;
@@ -4193,6 +4198,7 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 		hd_len = hw_hdr_len + proto_len;
 		data_offset = proto_len;
 	}
+	memset(hdr, 0, hw_hdr_len);
 	fill_header(card, hdr, skb, ipv, cast_type, frame_len);
 
 	is_sg = skb_is_nonlinear(skb);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 87cb71d5dae8..24b531ca2827 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -199,7 +199,6 @@ static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 {
 	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)skb_mac_header(skb);
 
-	memset(hdr, 0, sizeof(struct qeth_hdr));
 	hdr->hdr.l2.id = QETH_HEADER_TYPE_LAYER2;
 	hdr->hdr.l2.pkt_length = data_len;
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 0c085f57f7e2..fe55218802d7 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2008,7 +2008,6 @@ static void qeth_l3_fill_af_iucv_hdr(struct qeth_hdr *hdr, struct sk_buff *skb,
 	char daddr[16];
 	struct af_iucv_trans_hdr *iucv_hdr;
 
-	memset(hdr, 0, sizeof(struct qeth_hdr));
 	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 	hdr->hdr.l3.length = data_len;
 	hdr->hdr.l3.flags = QETH_HDR_IPV6 | QETH_CAST_UNICAST;
@@ -2038,10 +2037,22 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 {
 	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
 
-	memset(hdr, 0, sizeof(struct qeth_hdr));
-	hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
 	hdr->hdr.l3.length = data_len;
 
+	if (skb_is_gso(skb)) {
+		hdr->hdr.l3.id = QETH_HEADER_TYPE_TSO;
+	} else {
+		hdr->hdr.l3.id = QETH_HEADER_TYPE_LAYER3;
+		if (skb->ip_summed == CHECKSUM_PARTIAL) {
+			qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
+			/* some HW requires combined L3+L4 csum offload: */
+			if (ipv == 4)
+				hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
+			if (card->options.performance_stats)
+				card->perf_stats.tx_csum++;
+		}
+	}
+
 	if (ipv == 4 || IS_IQD(card)) {
 		/* NETIF_F_HW_VLAN_CTAG_TX */
 		if (skb_vlan_tag_present(skb)) {
@@ -2053,15 +2064,6 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 		hdr->hdr.l3.vlan_id = ntohs(veth->h_vlan_TCI);
 	}
 
-	if (!skb_is_gso(skb) && skb->ip_summed == CHECKSUM_PARTIAL) {
-		qeth_tx_csum(skb, &hdr->hdr.l3.ext_flags, ipv);
-		/* some HW requires combined L3+L4 csum offload: */
-		if (ipv == 4)
-			hdr->hdr.l3.ext_flags |= QETH_HDR_EXT_CSUM_HDR_REQ;
-		if (card->options.performance_stats)
-			card->perf_stats.tx_csum++;
-	}
-
 	/* OSA only: */
 	if (!ipv) {
 		hdr->hdr.l3.flags = QETH_HDR_PASSTHRU;
@@ -2100,6 +2102,22 @@ static void qeth_l3_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	rcu_read_unlock();
 }
 
+static void qeth_l3_fill_tso_ext(struct qeth_hdr_tso *hdr,
+				 unsigned int payload_len, struct sk_buff *skb,
+				 unsigned int proto_len)
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
+
 static void qeth_tso_fill_header(struct qeth_card *card,
 		struct qeth_hdr *qhdr, struct sk_buff *skb)
 {
@@ -2108,8 +2126,6 @@ static void qeth_tso_fill_header(struct qeth_card *card,
 	struct iphdr *iph = ip_hdr(skb);
 	struct ipv6hdr *ip6h = ipv6_hdr(skb);
 
-	/*fix header to TSO values ...*/
-	hdr->hdr.hdr.l3.id = QETH_HEADER_TYPE_TSO;
 	/*set values which are fix for the first approach ...*/
 	hdr->ext.hdr_tot_len = (__u16) sizeof(struct qeth_hdr_ext_tso);
 	hdr->ext.imb_hdr_no  = 1;
@@ -2173,20 +2189,35 @@ static void qeth_l3_fixup_headers(struct sk_buff *skb)
 	/* this is safe, IPv6 traffic takes a different path */
 	if (skb->ip_summed == CHECKSUM_PARTIAL)
 		iph->check = 0;
+	if (skb_is_gso(skb)) {
+		iph->tot_len = 0;
+		tcp_hdr(skb)->check = ~tcp_v4_check(0, iph->saddr,
+						    iph->daddr, 0);
+	}
 }
 
 static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 				struct qeth_qdio_out_q *queue, int ipv,
 				int cast_type)
 {
-	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
-	unsigned int frame_len, elements;
+	unsigned int hw_hdr_len, proto_len, frame_len, elements;
 	unsigned char eth_hdr[ETH_HLEN];
+	bool is_tso = skb_is_gso(skb);
+	unsigned int data_offset = 0;
 	struct qeth_hdr *hdr = NULL;
 	unsigned int hd_len = 0;
 	int push_len, rc;
 	bool is_sg;
 
+	if (is_tso) {
+		hw_hdr_len = sizeof(struct qeth_hdr_tso);
+		proto_len = skb_transport_offset(skb) + tcp_hdrlen(skb) -
+			    ETH_HLEN;
+	} else {
+		hw_hdr_len = sizeof(struct qeth_hdr);
+		proto_len = 0;
+	}
+
 	/* re-use the L2 header area for the HW header: */
 	rc = skb_cow_head(skb, hw_hdr_len - ETH_HLEN);
 	if (rc)
@@ -2196,28 +2227,36 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	frame_len = skb->len;
 
 	qeth_l3_fixup_headers(skb);
-	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, 0,
+	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, proto_len,
 				      &elements);
 	if (push_len < 0)
 		return push_len;
-	if (!push_len) {
-		/* hdr was added discontiguous from skb->data */
-		hd_len = hw_hdr_len;
+	if (is_tso || !push_len) {
+		/* HW header needs its own buffer element. */
+		hd_len = hw_hdr_len + proto_len;
+		data_offset = push_len + proto_len;
 	}
+	memset(hdr, 0, hw_hdr_len);
 
-	if (skb->protocol == htons(ETH_P_AF_IUCV))
+	if (skb->protocol == htons(ETH_P_AF_IUCV)) {
 		qeth_l3_fill_af_iucv_hdr(hdr, skb, frame_len);
-	else
+	} else {
 		qeth_l3_fill_header(card, hdr, skb, ipv, cast_type, frame_len);
+		if (is_tso)
+			qeth_l3_fill_tso_ext((struct qeth_hdr_tso *) hdr,
+					     frame_len - proto_len, skb,
+					     proto_len);
+	}
 
 	is_sg = skb_is_nonlinear(skb);
 	if (IS_IQD(card)) {
-		rc = qeth_do_send_packet_fast(queue, skb, hdr, 0, hd_len);
+		rc = qeth_do_send_packet_fast(queue, skb, hdr, data_offset,
+					      hd_len);
 	} else {
 		/* TODO: drop skb_orphan() once TX completion is fast enough */
 		skb_orphan(skb);
-		rc = qeth_do_send_packet(card, queue, skb, hdr, 0, hd_len,
-					 elements);
+		rc = qeth_do_send_packet(card, queue, skb, hdr, data_offset,
+					 hd_len, elements);
 	}
 
 	if (!rc) {
@@ -2225,6 +2264,10 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
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
-- 
2.16.4
