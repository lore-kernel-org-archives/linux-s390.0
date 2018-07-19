From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/11] s390/qeth: merge linearize-check into HW header construction
Date: Thu, 19 Jul 2018 12:43:56 +0200
Message-ID: <20180719104358.79696-10-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When checking whether an skb needs to be linearized to fit into an IO
buffer, it's desirable to consider the skb's final size and layout
(ie. after the HW header was added). But a subsequent linearization can
then cause the re-positioned HW header to violate its alignment
restrictions.

Dealing with this situation in two different code paths is quite tricky.
This patch integrates a) linearize-check and b) HW header construction
into one 3 step-sequence:
1. evaluate how the HW header needs to be added (to identify if it takes
   up an additional buffer element), then
2. check if the required buffer elements exceed the device's limit.
   Linearize when necessary and re-evaluate the HW header placement.
3. Add the HW header in the best-possible way:
   a) push, without taking up an additional buffer element
   b) push, but consume another buffer element
   c) allocate a header object from the cache.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 +-
 drivers/s390/net/qeth_core_main.c | 86 ++++++++++++++++++++++++++++++++-------
 drivers/s390/net/qeth_l2_main.c   | 29 +------------
 drivers/s390/net/qeth_l3_main.c   | 31 ++------------
 4 files changed, 80 insertions(+), 70 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 6d8005af67f5..2a5ec99643df 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1047,7 +1047,9 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
 int qeth_vm_request_mac(struct qeth_card *card);
-int qeth_push_hdr(struct sk_buff *skb, struct qeth_hdr **hdr, unsigned int len);
+int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
+		       struct qeth_hdr **hdr, unsigned int len,
+		       unsigned int *elements);
 
 /* exports for OSN */
 int qeth_osn_assist(struct net_device *, void *, int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 84f1e1e33f3f..e7b34624df1e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3831,6 +3831,17 @@ int qeth_get_elements_for_frags(struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(qeth_get_elements_for_frags);
 
+static unsigned int qeth_count_elements(struct sk_buff *skb, int data_offset)
+{
+	unsigned int elements = qeth_get_elements_for_frags(skb);
+	addr_t end = (addr_t)skb->data + skb_headlen(skb);
+	addr_t start = (addr_t)skb->data + data_offset;
+
+	if (start != end)
+		elements += qeth_get_elements_for_range(start, end);
+	return elements;
+}
+
 /**
  * qeth_get_elements_no() -	find number of SBALEs for skb data, inc. frags.
  * @card:			qeth card structure, to check max. elems.
@@ -3846,12 +3857,7 @@ EXPORT_SYMBOL_GPL(qeth_get_elements_for_frags);
 int qeth_get_elements_no(struct qeth_card *card,
 		     struct sk_buff *skb, int extra_elems, int data_offset)
 {
-	addr_t end = (addr_t)skb->data + skb_headlen(skb);
-	int elements = qeth_get_elements_for_frags(skb);
-	addr_t start = (addr_t)skb->data + data_offset;
-
-	if (start != end)
-		elements += qeth_get_elements_for_range(start, end);
+	int elements = qeth_count_elements(skb, data_offset);
 
 	if ((elements + extra_elems) > QETH_MAX_BUFFER_ELEMENTS(card)) {
 		QETH_DBF_MESSAGE(2, "Invalid size of IP packet "
@@ -3885,22 +3891,72 @@ int qeth_hdr_chk_and_bounce(struct sk_buff *skb, struct qeth_hdr **hdr, int len)
 EXPORT_SYMBOL_GPL(qeth_hdr_chk_and_bounce);
 
 /**
- * qeth_push_hdr() - push a qeth_hdr onto an skb.
- * @skb: skb that the qeth_hdr should be pushed onto.
+ * qeth_add_hw_header() - add a HW header to an skb.
+ * @skb: skb that the HW header should be added to.
  * @hdr: double pointer to a qeth_hdr. When returning with >= 0,
  *	 it contains a valid pointer to a qeth_hdr.
- * @len: length of the hdr that needs to be pushed on.
+ * @len: length of the HW header.
  *
  * Returns the pushed length. If the header can't be pushed on
  * (eg. because it would cross a page boundary), it is allocated from
  * the cache instead and 0 is returned.
+ * The number of needed buffer elements is returned in @elements.
  * Error to create the hdr is indicated by returning with < 0.
  */
-int qeth_push_hdr(struct sk_buff *skb, struct qeth_hdr **hdr, unsigned int len)
-{
-	if (skb_headroom(skb) >= len &&
-	    qeth_get_elements_for_range((addr_t)skb->data - len,
-					(addr_t)skb->data) == 1) {
+int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
+		       struct qeth_hdr **hdr, unsigned int len,
+		       unsigned int *elements)
+{
+	const unsigned int max_elements = QETH_MAX_BUFFER_ELEMENTS(card);
+	unsigned int __elements;
+	addr_t start, end;
+	bool push_ok;
+	int rc;
+
+check_layout:
+	start = (addr_t)skb->data - len;
+	end = (addr_t)skb->data;
+
+	if (qeth_get_elements_for_range(start, end + 1) == 1) {
+		/* Push HW header into same page as first protocol header. */
+		push_ok = true;
+		__elements = qeth_count_elements(skb, 0);
+	} else {
+		__elements = 1 + qeth_count_elements(skb, 0);
+		if (qeth_get_elements_for_range(start, end) == 1)
+			/* Push HW header into a new page. */
+			push_ok = true;
+		else
+			/* Use header cache. */
+			push_ok = false;
+	}
+
+	/* Compress skb to fit into one IO buffer: */
+	if (__elements > max_elements) {
+		if (!skb_is_nonlinear(skb)) {
+			/* Drop it, no easy way of shrinking it further. */
+			QETH_DBF_MESSAGE(2, "Dropped an oversized skb (Max Elements=%u / Actual=%u / Length=%u).\n",
+					 max_elements, __elements, skb->len);
+			return -E2BIG;
+		}
+
+		rc = skb_linearize(skb);
+		if (card->options.performance_stats) {
+			if (rc)
+				card->perf_stats.tx_linfail++;
+			else
+				card->perf_stats.tx_lin++;
+		}
+		if (rc)
+			return rc;
+
+		/* Linearization changed the layout, re-evaluate: */
+		goto check_layout;
+	}
+
+	*elements = __elements;
+	/* Add the header: */
+	if (push_ok) {
 		*hdr = skb_push(skb, len);
 		return len;
 	}
@@ -3910,7 +3966,7 @@ int qeth_push_hdr(struct sk_buff *skb, struct qeth_hdr **hdr, unsigned int len)
 		return -ENOMEM;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qeth_push_hdr);
+EXPORT_SYMBOL_GPL(qeth_add_hw_header);
 
 static void __qeth_fill_buffer(struct sk_buff *skb,
 			       struct qeth_qdio_out_buffer *buf,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index a785c5ff73cd..905f3bb3a87c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -672,39 +672,21 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 			    int ipv)
 {
 	int push_len = sizeof(struct qeth_hdr);
-	unsigned int hdr_elements = 0;
 	struct qeth_hdr *hdr = NULL;
 	unsigned int hd_len = 0;
 	unsigned int elements;
 	bool is_sg;
 	int rc;
 
-	/* fix hardware limitation: as long as we do not have sbal
-	 * chaining we can not send long frag lists
-	 */
-	if (!qeth_get_elements_no(card, skb, 0, 0)) {
-		rc = skb_linearize(skb);
-
-		if (card->options.performance_stats) {
-			if (rc)
-				card->perf_stats.tx_linfail++;
-			else
-				card->perf_stats.tx_lin++;
-		}
-		if (rc)
-			return rc;
-	}
-
 	rc = skb_cow_head(skb, push_len);
 	if (rc)
 		return rc;
-	push_len = qeth_push_hdr(skb, &hdr, push_len);
+	push_len = qeth_add_hw_header(card, skb, &hdr, push_len, &elements);
 	if (push_len < 0)
 		return push_len;
 	if (!push_len) {
 		/* hdr was allocated from cache */
 		hd_len = sizeof(*hdr);
-		hdr_elements = 1;
 	}
 	qeth_l2_fill_header(hdr, skb, cast_type, skb->len - push_len);
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -713,18 +695,11 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 			card->perf_stats.tx_csum++;
 	}
 
-	elements = qeth_get_elements_no(card, skb, hdr_elements, 0);
-	if (!elements) {
-		rc = -E2BIG;
-		goto out;
-	}
-	elements += hdr_elements;
-
 	is_sg = skb_is_nonlinear(skb);
 	/* TODO: remove the skb_orphan() once TX completion is fast enough */
 	skb_orphan(skb);
 	rc = qeth_do_send_packet(card, queue, skb, hdr, 0, hd_len, elements);
-out:
+
 	if (!rc) {
 		if (card->options.performance_stats) {
 			card->perf_stats.buf_elements_sent += elements;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index c12aeb7d8f26..f7bcc4853c45 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2166,28 +2166,13 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 				int cast_type)
 {
 	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
+	unsigned int frame_len, elements;
 	unsigned char eth_hdr[ETH_HLEN];
-	unsigned int hdr_elements = 0;
 	struct qeth_hdr *hdr = NULL;
-	int elements, push_len, rc;
 	unsigned int hd_len = 0;
-	unsigned int frame_len;
+	int push_len, rc;
 	bool is_sg;
 
-	/* compress skb to fit into one IO buffer: */
-	if (!qeth_get_elements_no(card, skb, 0, 0)) {
-		rc = skb_linearize(skb);
-
-		if (card->options.performance_stats) {
-			if (rc)
-				card->perf_stats.tx_linfail++;
-			else
-				card->perf_stats.tx_lin++;
-		}
-		if (rc)
-			return rc;
-	}
-
 	/* re-use the L2 header area for the HW header: */
 	rc = skb_cow_head(skb, hw_hdr_len - ETH_HLEN);
 	if (rc)
@@ -2196,22 +2181,14 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	skb_pull(skb, ETH_HLEN);
 	frame_len = skb->len;
 
-	push_len = qeth_push_hdr(skb, &hdr, hw_hdr_len);
+	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, &elements);
 	if (push_len < 0)
 		return push_len;
 	if (!push_len) {
 		/* hdr was added discontiguous from skb->data */
 		hd_len = hw_hdr_len;
-		hdr_elements = 1;
 	}
 
-	elements = qeth_get_elements_no(card, skb, hdr_elements, 0);
-	if (!elements) {
-		rc = -E2BIG;
-		goto out;
-	}
-	elements += hdr_elements;
-
 	if (skb->protocol == htons(ETH_P_AF_IUCV))
 		qeth_l3_fill_af_iucv_hdr(hdr, skb, frame_len);
 	else
@@ -2226,7 +2203,7 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 		rc = qeth_do_send_packet(card, queue, skb, hdr, 0, hd_len,
 					 elements);
 	}
-out:
+
 	if (!rc) {
 		if (card->options.performance_stats) {
 			card->perf_stats.buf_elements_sent += elements;
-- 
2.16.4
