Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728707AbgEFIKA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 May 2020 04:10:00 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH v2 net-next 06/10] s390/qeth: merge TX skb mapping code
Date: Wed,  6 May 2020 10:09:45 +0200
Message-Id: <20200506080949.3915-7-jwi@linux.ibm.com>
In-Reply-To: <20200506080949.3915-1-jwi@linux.ibm.com>
References: <20200506080949.3915-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Merge the __qeth_fill_buffer() helper into its only caller. This way all
mapping-related context is in one place, and we can make some more use
of it in a subsequent patch.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 64 +++++++++++++------------------
 1 file changed, 27 insertions(+), 37 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 1f18b38047a0..9c9a6edb5384 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4081,15 +4081,39 @@ static bool qeth_iqd_may_bulk(struct qeth_qdio_out_q *queue,
 	       qeth_l3_iqd_same_vlan(&prev_hdr->hdr.l3, &curr_hdr->hdr.l3);
 }
 
-static unsigned int __qeth_fill_buffer(struct sk_buff *skb,
-				       struct qeth_qdio_out_buffer *buf,
-				       bool is_first_elem, unsigned int offset)
+/**
+ * qeth_fill_buffer() - map skb into an output buffer
+ * @buf:	buffer to transport the skb
+ * @skb:	skb to map into the buffer
+ * @hdr:	qeth_hdr for this skb. Either at skb->data, or allocated
+ *		from qeth_core_header_cache.
+ * @offset:	when mapping the skb, start at skb->data + offset
+ * @hd_len:	if > 0, build a dedicated header element of this size
+ */
+static unsigned int qeth_fill_buffer(struct qeth_qdio_out_buffer *buf,
+				     struct sk_buff *skb, struct qeth_hdr *hdr,
+				     unsigned int offset, unsigned int hd_len)
 {
 	struct qdio_buffer *buffer = buf->buffer;
 	int element = buf->next_element_to_fill;
 	int length = skb_headlen(skb) - offset;
 	char *data = skb->data + offset;
 	unsigned int elem_length, cnt;
+	bool is_first_elem = true;
+
+	__skb_queue_tail(&buf->skb_list, skb);
+
+	/* build dedicated element for HW Header */
+	if (hd_len) {
+		is_first_elem = false;
+
+		buffer->element[element].addr = virt_to_phys(hdr);
+		buffer->element[element].length = hd_len;
+		buffer->element[element].eflags = SBAL_EFLAGS_FIRST_FRAG;
+		/* remember to free cache-allocated HW header: */
+		buf->is_header[element] = ((void *)hdr != skb->data);
+		element++;
+	}
 
 	/* map linear part into buffer element(s) */
 	while (length > 0) {
@@ -4143,40 +4167,6 @@ static unsigned int __qeth_fill_buffer(struct sk_buff *skb,
 	return element;
 }
 
-/**
- * qeth_fill_buffer() - map skb into an output buffer
- * @buf:	buffer to transport the skb
- * @skb:	skb to map into the buffer
- * @hdr:	qeth_hdr for this skb. Either at skb->data, or allocated
- *		from qeth_core_header_cache.
- * @offset:	when mapping the skb, start at skb->data + offset
- * @hd_len:	if > 0, build a dedicated header element of this size
- */
-static unsigned int qeth_fill_buffer(struct qeth_qdio_out_buffer *buf,
-				     struct sk_buff *skb, struct qeth_hdr *hdr,
-				     unsigned int offset, unsigned int hd_len)
-{
-	struct qdio_buffer *buffer = buf->buffer;
-	bool is_first_elem = true;
-
-	__skb_queue_tail(&buf->skb_list, skb);
-
-	/* build dedicated header element */
-	if (hd_len) {
-		int element = buf->next_element_to_fill;
-		is_first_elem = false;
-
-		buffer->element[element].addr = virt_to_phys(hdr);
-		buffer->element[element].length = hd_len;
-		buffer->element[element].eflags = SBAL_EFLAGS_FIRST_FRAG;
-		/* remember to free cache-allocated qeth_hdr: */
-		buf->is_header[element] = ((void *)hdr != skb->data);
-		buf->next_element_to_fill++;
-	}
-
-	return __qeth_fill_buffer(skb, buf, is_first_elem, offset);
-}
-
 static int __qeth_xmit(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 		       struct sk_buff *skb, unsigned int elements,
 		       struct qeth_hdr *hdr, unsigned int offset,
-- 
2.17.1
