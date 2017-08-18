From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 6/7] s390/qeth: unify code to build header elements
Date: Fri, 18 Aug 2017 10:19:09 +0200
Message-ID: <20170818081910.48869-7-jwi@linux.vnet.ibm.com>
References: <20170818081910.48869-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170818081910.48869-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

After plenty of refactoring, use hd_len as single indication that
the skb needs a dedicated header element.

This preserves existing behaviour for TSO, as 'hdr' always points
to skb->data.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cef9f54d0eb9..ffefdd97abca 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3953,37 +3953,38 @@ static void __qeth_fill_buffer(struct sk_buff *skb,
 	buf->next_element_to_fill = element;
 }
 
+/**
+ * qeth_fill_buffer() - map skb into an output buffer
+ * @queue:	QDIO queue to submit the buffer on
+ * @buf:	buffer to transport the skb
+ * @skb:	skb to map into the buffer
+ * @hdr:	qeth_hdr for this skb. Either at skb->data, or allocated
+ *		from qeth_core_header_cache.
+ * @offset:	when mapping the skb, start at skb->data + offset
+ * @hd_len:	if > 0, build a dedicated header element of this size
+ */
 static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 			    struct qeth_qdio_out_buffer *buf,
 			    struct sk_buff *skb, struct qeth_hdr *hdr,
 			    unsigned int offset, unsigned int hd_len)
 {
-	struct qdio_buffer *buffer;
+	struct qdio_buffer *buffer = buf->buffer;
 	bool is_first_elem = true;
 	int flush_cnt = 0;
 
-	buffer = buf->buffer;
 	refcount_inc(&skb->users);
 	skb_queue_tail(&buf->skb_list, skb);
 
-	if (hdr->hdr.l3.id == QETH_HEADER_TYPE_TSO) {
-		int element = buf->next_element_to_fill;
-		is_first_elem = false;
-
-		/*fill first buffer entry only with header information */
-		buffer->element[element].addr = skb->data;
-		buffer->element[element].length = hd_len;
-		buffer->element[element].eflags = SBAL_EFLAGS_FIRST_FRAG;
-		buf->next_element_to_fill++;
-	/* IQD */
-	} else if (offset) {
+	/* build dedicated header element */
+	if (hd_len) {
 		int element = buf->next_element_to_fill;
 		is_first_elem = false;
 
 		buffer->element[element].addr = hdr;
 		buffer->element[element].length = hd_len;
 		buffer->element[element].eflags = SBAL_EFLAGS_FIRST_FRAG;
-		buf->is_header[element] = 1;
+		/* remember to free cache-allocated qeth_hdr: */
+		buf->is_header[element] = ((void *)hdr != skb->data);
 		buf->next_element_to_fill++;
 	}
 
-- 
2.11.2
