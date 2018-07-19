From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/11] s390/qeth: add support for constrained HW headers
Date: Thu, 19 Jul 2018 12:43:57 +0200
Message-ID: <20180719104358.79696-11-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some transmit modes require that the HW header is located in the same
page as the initial protocol headers in skb->data. Let callers specify
the size of this contiguous header range, and enforce it when building
the HW header.

While at it, apply some gentle renaming to the relevant L2 code so that
it matches the L3 code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 ++--
 drivers/s390/net/qeth_core_main.c | 33 +++++++++++++++++++--------------
 drivers/s390/net/qeth_l2_main.c   | 12 +++++++-----
 drivers/s390/net/qeth_l3_main.c   |  3 ++-
 4 files changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 2a5ec99643df..605ec4706773 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1048,8 +1048,8 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      netdev_features_t features);
 int qeth_vm_request_mac(struct qeth_card *card);
 int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
-		       struct qeth_hdr **hdr, unsigned int len,
-		       unsigned int *elements);
+		       struct qeth_hdr **hdr, unsigned int hdr_len,
+		       unsigned int proto_len, unsigned int *elements);
 
 /* exports for OSN */
 int qeth_osn_assist(struct net_device *, void *, int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e7b34624df1e..732b517369c7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3895,7 +3895,9 @@ EXPORT_SYMBOL_GPL(qeth_hdr_chk_and_bounce);
  * @skb: skb that the HW header should be added to.
  * @hdr: double pointer to a qeth_hdr. When returning with >= 0,
  *	 it contains a valid pointer to a qeth_hdr.
- * @len: length of the HW header.
+ * @hdr_len: length of the HW header.
+ * @proto_len: length of protocol headers that need to be in same page as the
+ *	       HW header.
  *
  * Returns the pushed length. If the header can't be pushed on
  * (eg. because it would cross a page boundary), it is allocated from
@@ -3904,31 +3906,32 @@ EXPORT_SYMBOL_GPL(qeth_hdr_chk_and_bounce);
  * Error to create the hdr is indicated by returning with < 0.
  */
 int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
-		       struct qeth_hdr **hdr, unsigned int len,
-		       unsigned int *elements)
+		       struct qeth_hdr **hdr, unsigned int hdr_len,
+		       unsigned int proto_len, unsigned int *elements)
 {
 	const unsigned int max_elements = QETH_MAX_BUFFER_ELEMENTS(card);
+	const unsigned int contiguous = proto_len ? proto_len : 1;
 	unsigned int __elements;
 	addr_t start, end;
 	bool push_ok;
 	int rc;
 
 check_layout:
-	start = (addr_t)skb->data - len;
+	start = (addr_t)skb->data - hdr_len;
 	end = (addr_t)skb->data;
 
-	if (qeth_get_elements_for_range(start, end + 1) == 1) {
+	if (qeth_get_elements_for_range(start, end + contiguous) == 1) {
 		/* Push HW header into same page as first protocol header. */
 		push_ok = true;
 		__elements = qeth_count_elements(skb, 0);
-	} else {
+	} else if (!proto_len && qeth_get_elements_for_range(start, end) == 1) {
+		/* Push HW header into a new page. */
+		push_ok = true;
 		__elements = 1 + qeth_count_elements(skb, 0);
-		if (qeth_get_elements_for_range(start, end) == 1)
-			/* Push HW header into a new page. */
-			push_ok = true;
-		else
-			/* Use header cache. */
-			push_ok = false;
+	} else {
+		/* Use header cache, copy protocol headers up. */
+		push_ok = false;
+		__elements = 1 + qeth_count_elements(skb, proto_len);
 	}
 
 	/* Compress skb to fit into one IO buffer: */
@@ -3957,13 +3960,15 @@ int qeth_add_hw_header(struct qeth_card *card, struct sk_buff *skb,
 	*elements = __elements;
 	/* Add the header: */
 	if (push_ok) {
-		*hdr = skb_push(skb, len);
-		return len;
+		*hdr = skb_push(skb, hdr_len);
+		return hdr_len;
 	}
 	/* fall back */
 	*hdr = kmem_cache_alloc(qeth_core_header_cache, GFP_ATOMIC);
 	if (!*hdr)
 		return -ENOMEM;
+	/* Copy protocol headers behind HW header: */
+	skb_copy_from_linear_data(skb, ((char *)*hdr) + hdr_len, proto_len);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qeth_add_hw_header);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 905f3bb3a87c..c302002e422f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -671,17 +671,19 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 			    struct qeth_qdio_out_q *queue, int cast_type,
 			    int ipv)
 {
-	int push_len = sizeof(struct qeth_hdr);
+	const unsigned int hw_hdr_len = sizeof(struct qeth_hdr);
 	struct qeth_hdr *hdr = NULL;
 	unsigned int hd_len = 0;
 	unsigned int elements;
+	int push_len, rc;
 	bool is_sg;
-	int rc;
 
-	rc = skb_cow_head(skb, push_len);
+	rc = skb_cow_head(skb, hw_hdr_len);
 	if (rc)
 		return rc;
-	push_len = qeth_add_hw_header(card, skb, &hdr, push_len, &elements);
+
+	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, 0,
+				      &elements);
 	if (push_len < 0)
 		return push_len;
 	if (!push_len) {
@@ -707,7 +709,7 @@ static int qeth_l2_xmit_osa(struct qeth_card *card, struct sk_buff *skb,
 				card->perf_stats.sg_skbs_sent++;
 		}
 	} else {
-		if (hd_len)
+		if (!push_len)
 			kmem_cache_free(qeth_core_header_cache, hdr);
 		if (rc == -EBUSY)
 			/* roll back to ETH header */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f7bcc4853c45..b8e828556cf6 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2181,7 +2181,8 @@ static int qeth_l3_xmit_offload(struct qeth_card *card, struct sk_buff *skb,
 	skb_pull(skb, ETH_HLEN);
 	frame_len = skb->len;
 
-	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, &elements);
+	push_len = qeth_add_hw_header(card, skb, &hdr, hw_hdr_len, 0,
+				      &elements);
 	if (push_len < 0)
 		return push_len;
 	if (!push_len) {
-- 
2.16.4
