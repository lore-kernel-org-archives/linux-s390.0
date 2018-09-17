From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/15] s390/qeth: remove qeth_get_elements_no()
Date: Mon, 17 Sep 2018 17:35:58 +0200
Message-ID: <20180917153609.94628-5-jwi@linux.ibm.com>
References: <20180917153609.94628-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180917153609.94628-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Convert the last remaining user of qeth_get_elements_no() to
qeth_count_elements(), so this helper can be removed.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  3 +--
 drivers/s390/net/qeth_core_main.c | 39 +++++++++++----------------------------
 drivers/s390/net/qeth_l2_main.c   |  4 ++--
 drivers/s390/net/qeth_l3_main.c   |  1 -
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 2110fabdcc7a..0857b1286660 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1007,8 +1007,7 @@ int qeth_query_switch_attributes(struct qeth_card *card,
 int qeth_send_control_data(struct qeth_card *, int, struct qeth_cmd_buffer *,
 	int (*reply_cb)(struct qeth_card *, struct qeth_reply*, unsigned long),
 	void *reply_param);
-int qeth_get_elements_no(struct qeth_card *card, struct sk_buff *skb,
-			 int extra_elems, int data_offset);
+unsigned int qeth_count_elements(struct sk_buff *skb, unsigned int data_offset);
 int qeth_get_elements_for_frags(struct sk_buff *);
 int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue, struct sk_buff *skb,
 			     struct qeth_hdr *hdr, unsigned int offset,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d2ca33a9330a..eaf01dc62e91 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3802,7 +3802,16 @@ int qeth_get_elements_for_frags(struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(qeth_get_elements_for_frags);
 
-static unsigned int qeth_count_elements(struct sk_buff *skb, int data_offset)
+/**
+ * qeth_count_elements() -	Counts the number of QDIO buffer elements needed
+ *				to transmit an skb.
+ * @skb:			the skb to operate on.
+ * @data_offset:		skip this part of the skb's linear data
+ *
+ * Returns the number of pages, and thus QDIO buffer elements, needed to map the
+ * skb's data (both its linear part and paged fragments).
+ */
+unsigned int qeth_count_elements(struct sk_buff *skb, unsigned int data_offset)
 {
 	unsigned int elements = qeth_get_elements_for_frags(skb);
 	addr_t end = (addr_t)skb->data + skb_headlen(skb);
@@ -3812,33 +3821,7 @@ static unsigned int qeth_count_elements(struct sk_buff *skb, int data_offset)
 		elements += qeth_get_elements_for_range(start, end);
 	return elements;
 }
-
-/**
- * qeth_get_elements_no() -	find number of SBALEs for skb data, inc. frags.
- * @card:			qeth card structure, to check max. elems.
- * @skb:			SKB address
- * @extra_elems:		extra elems needed, to check against max.
- * @data_offset:		range starts at skb->data + data_offset
- *
- * Returns the number of pages, and thus QDIO buffer elements, needed to cover
- * skb data, including linear part and fragments. Checks if the result plus
- * extra_elems fits under the limit for the card. Returns 0 if it does not.
- * Note: extra_elems is not included in the returned result.
- */
-int qeth_get_elements_no(struct qeth_card *card,
-		     struct sk_buff *skb, int extra_elems, int data_offset)
-{
-	int elements = qeth_count_elements(skb, data_offset);
-
-	if ((elements + extra_elems) > QETH_MAX_BUFFER_ELEMENTS(card)) {
-		QETH_DBF_MESSAGE(2, "Invalid size of IP packet "
-			"(Number=%d / Length=%d). Discarded.\n",
-			elements + extra_elems, skb->len);
-		return 0;
-	}
-	return elements;
-}
-EXPORT_SYMBOL_GPL(qeth_get_elements_no);
+EXPORT_SYMBOL_GPL(qeth_count_elements);
 
 int qeth_hdr_chk_and_bounce(struct sk_buff *skb, struct qeth_hdr **hdr, int len)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 715d58af5fc4..87cb71d5dae8 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -658,8 +658,8 @@ static int qeth_l2_xmit_osn(struct qeth_card *card, struct sk_buff *skb,
 		return -EPROTONOSUPPORT;
 
 	hdr = (struct qeth_hdr *)skb->data;
-	elements = qeth_get_elements_no(card, skb, 0, 0);
-	if (!elements)
+	elements = qeth_count_elements(skb, 0);
+	if (elements > QETH_MAX_BUFFER_ELEMENTS(card))
 		return -E2BIG;
 	if (qeth_hdr_chk_and_bounce(skb, &hdr, sizeof(*hdr)))
 		return -EINVAL;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 00e6e7471f5d..1d92584e01b3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2140,7 +2140,6 @@ static void qeth_tso_fill_header(struct qeth_card *card,
  *
  * Returns the number of pages, and thus QDIO buffer elements, needed to cover
  * skb data, including linear part and fragments, but excluding TCP header.
- * (Exclusion of TCP header distinguishes it from qeth_get_elements_no().)
  * Checks if the result plus extra_elems fits under the limit for the card.
  * Returns 0 if it does not.
  * Note: extra_elems is not included in the returned result.
-- 
2.16.4
