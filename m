Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/8] s390/qeth: stop/wake TX queues based on their fill level
Date: Wed, 17 Apr 2019 18:17:35 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Current xmit code only stops the txq after attempting to fill an
IO buffer that hasn't been TX-completed yet. In many-connection
scenarios, this can result in frequent rejected TX attempts, requeuing
of skbs with NETDEV_TX_BUSY and extra overhead.

Now that we have a proper 1-to-1 relation between stack-side txqs and
our HW Queues, overhaul the stop/wake logic so that the xmit code
stops the txq as needed.
Given that we might map multiple skbs into a single buffer, it's crucial
to ensure that the queue always provides an _entirely_ empty IO buffer.
Otherwise large skbs (eg TSO) might not fit into the last available
buffer. So whenever qeth_do_send_packet() first utilizes an _empty_
buffer, it updates & checks the used_buffers count.

This now ensures that an skb passed to qeth_xmit() can always be mapped
into an IO buffer, so remove all of the -EBUSY roll-back handling in the
TX path. We preserve the minimal safety-checks ("Is this IO buffer
really available?"), just in case some nasty future bug ever attempts to
corrupt an in-use buffer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  6 +++
 drivers/s390/net/qeth_core_main.c | 81 ++++++++++++++++++++++++++++-----------
 drivers/s390/net/qeth_ethtool.c   |  1 +
 drivers/s390/net/qeth_l2_main.c   | 13 ++-----
 drivers/s390/net/qeth_l3_main.c   | 18 +--------
 5 files changed, 71 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 4989dc7b58c1..fbaf434e2e34 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -481,6 +481,7 @@ struct qeth_out_q_stats {
 	u64 skbs_linearized_fail;
 	u64 tso_bytes;
 	u64 packing_mode_switch;
+	u64 stopped;
 
 	/* rtnl_link_stats64 */
 	u64 tx_packets;
@@ -511,6 +512,11 @@ struct qeth_qdio_out_q {
 	atomic_t set_pci_flags_count;
 };
 
+static inline bool qeth_out_queue_is_full(struct qeth_qdio_out_q *queue)
+{
+	return atomic_read(&queue->used_buffers) >= QDIO_MAX_BUFFERS_PER_Q;
+}
+
 struct qeth_qdio_info {
 	atomic_t state;
 	/* input */
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d23ad6e3bb45..d057ead200b5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3367,7 +3367,6 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 	qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
 	if (atomic_read(&queue->set_pci_flags_count))
 		qdio_flags |= QDIO_FLAG_PCI_OUT;
-	atomic_add(count, &queue->used_buffers);
 	rc = do_QDIO(CARD_DDEV(queue->card), qdio_flags,
 		     queue->queue_no, index, count);
 	if (rc) {
@@ -3407,7 +3406,6 @@ static void qeth_check_outbound_queue(struct qeth_qdio_out_q *queue)
 			 * do_send_packet. So, we check if there is a
 			 * packing buffer to be flushed here.
 			 */
-			netif_stop_subqueue(queue->card->dev, queue->queue_no);
 			index = queue->next_buf_to_fill;
 			q_was_packing = queue->do_pack;
 			/* queue->do_pack may change */
@@ -3535,7 +3533,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	struct qeth_qdio_out_q *queue = card->qdio.out_qs[__queue];
 	struct qeth_qdio_out_buffer *buffer;
 	struct net_device *dev = card->dev;
-	u16 txq;
+	struct netdev_queue *txq;
 	int i;
 
 	QETH_CARD_TEXT(card, 6, "qdouhdl");
@@ -3590,8 +3588,15 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	if (card->info.type != QETH_CARD_TYPE_IQD)
 		qeth_check_outbound_queue(queue);
 
-	txq = IS_IQD(card) ? qeth_iqd_translate_txq(dev, __queue) : __queue;
-	netif_wake_subqueue(dev, txq);
+	if (IS_IQD(card))
+		__queue = qeth_iqd_translate_txq(dev, __queue);
+	txq = netdev_get_tx_queue(dev, __queue);
+	/* xmit may have observed the full-condition, but not yet stopped the
+	 * txq. In which case the code below won't trigger. So before returning,
+	 * xmit will re-check the txq's fill level and wake it up if needed.
+	 */
+	if (netif_tx_queue_stopped(txq) && !qeth_out_queue_is_full(queue))
+		netif_tx_wake_queue(txq);
 }
 
 /**
@@ -3845,11 +3850,13 @@ static void __qeth_fill_buffer(struct sk_buff *skb,
  *		from qeth_core_header_cache.
  * @offset:	when mapping the skb, start at skb->data + offset
  * @hd_len:	if > 0, build a dedicated header element of this size
+ * flush:	Prepare the buffer to be flushed, regardless of its fill level.
  */
 static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 			    struct qeth_qdio_out_buffer *buf,
 			    struct sk_buff *skb, struct qeth_hdr *hdr,
-			    unsigned int offset, unsigned int hd_len)
+			    unsigned int offset, unsigned int hd_len,
+			    bool flush)
 {
 	struct qdio_buffer *buffer = buf->buffer;
 	bool is_first_elem = true;
@@ -3878,8 +3885,8 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 
 		QETH_TXQ_STAT_INC(queue, skbs_pack);
 		/* If the buffer still has free elements, keep using it. */
-		if (buf->next_element_to_fill <
-		    QETH_MAX_BUFFER_ELEMENTS(queue->card))
+		if (!flush && buf->next_element_to_fill <
+			      QETH_MAX_BUFFER_ELEMENTS(queue->card))
 			return 0;
 	}
 
@@ -3896,15 +3903,31 @@ static int qeth_do_send_packet_fast(struct qeth_qdio_out_q *queue,
 {
 	int index = queue->next_buf_to_fill;
 	struct qeth_qdio_out_buffer *buffer = queue->bufs[index];
+	struct netdev_queue *txq;
+	bool stopped = false;
 
-	/*
-	 * check if buffer is empty to make sure that we do not 'overtake'
-	 * ourselves and try to fill a buffer that is already primed
+	/* Just a sanity check, the wake/stop logic should ensure that we always
+	 * get a free buffer.
 	 */
 	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY)
 		return -EBUSY;
-	qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len);
+
+	txq = netdev_get_tx_queue(queue->card->dev, skb_get_queue_mapping(skb));
+
+	if (atomic_inc_return(&queue->used_buffers) >= QDIO_MAX_BUFFERS_PER_Q) {
+		/* If a TX completion happens right _here_ and misses to wake
+		 * the txq, then our re-check below will catch the race.
+		 */
+		QETH_TXQ_STAT_INC(queue, stopped);
+		netif_tx_stop_queue(txq);
+		stopped = true;
+	}
+
+	qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len, stopped);
 	qeth_flush_buffers(queue, index, 1);
+
+	if (stopped && !qeth_out_queue_is_full(queue))
+		netif_tx_start_queue(txq);
 	return 0;
 }
 
@@ -3914,6 +3937,8 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			int elements_needed)
 {
 	struct qeth_qdio_out_buffer *buffer;
+	struct netdev_queue *txq;
+	bool stopped = false;
 	int start_index;
 	int flush_count = 0;
 	int do_pack = 0;
@@ -3925,14 +3950,17 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 			      QETH_OUT_Q_LOCKED) != QETH_OUT_Q_UNLOCKED);
 	start_index = queue->next_buf_to_fill;
 	buffer = queue->bufs[queue->next_buf_to_fill];
-	/*
-	 * check if buffer is empty to make sure that we do not 'overtake'
-	 * ourselves and try to fill a buffer that is already primed
+
+	/* Just a sanity check, the wake/stop logic should ensure that we always
+	 * get a free buffer.
 	 */
 	if (atomic_read(&buffer->state) != QETH_QDIO_BUF_EMPTY) {
 		atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 		return -EBUSY;
 	}
+
+	txq = netdev_get_tx_queue(card->dev, skb_get_queue_mapping(skb));
+
 	/* check if we need to switch packing state of this queue */
 	qeth_switch_to_packing_if_needed(queue);
 	if (queue->do_pack) {
@@ -3947,8 +3975,8 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 				(queue->next_buf_to_fill + 1) %
 				QDIO_MAX_BUFFERS_PER_Q;
 			buffer = queue->bufs[queue->next_buf_to_fill];
-			/* we did a step forward, so check buffer state
-			 * again */
+
+			/* We stepped forward, so sanity-check again: */
 			if (atomic_read(&buffer->state) !=
 			    QETH_QDIO_BUF_EMPTY) {
 				qeth_flush_buffers(queue, start_index,
@@ -3961,8 +3989,18 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 		}
 	}
 
-	flush_count += qeth_fill_buffer(queue, buffer, skb, hdr, offset,
-					hd_len);
+	if (buffer->next_element_to_fill == 0 &&
+	    atomic_inc_return(&queue->used_buffers) >= QDIO_MAX_BUFFERS_PER_Q) {
+		/* If a TX completion happens right _here_ and misses to wake
+		 * the txq, then our re-check below will catch the race.
+		 */
+		QETH_TXQ_STAT_INC(queue, stopped);
+		netif_tx_stop_queue(txq);
+		stopped = true;
+	}
+
+	flush_count += qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len,
+					stopped);
 	if (flush_count)
 		qeth_flush_buffers(queue, start_index, flush_count);
 	else if (!atomic_read(&queue->set_pci_flags_count))
@@ -3993,6 +4031,8 @@ int qeth_do_send_packet(struct qeth_card *card, struct qeth_qdio_out_q *queue,
 	if (do_pack)
 		QETH_TXQ_STAT_ADD(queue, bufs_pack, flush_count);
 
+	if (stopped && !qeth_out_queue_is_full(queue))
+		netif_tx_start_queue(txq);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(qeth_do_send_packet);
@@ -4079,9 +4119,6 @@ int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	} else {
 		if (!push_len)
 			kmem_cache_free(qeth_core_header_cache, hdr);
-		if (rc == -EBUSY)
-			/* roll back to ETH header */
-			skb_pull(skb, push_len);
 	}
 	return rc;
 }
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index a443e5f86ab7..4166eb29f0bd 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -38,6 +38,7 @@ static const struct qeth_stats txq_stats[] = {
 	QETH_TXQ_STAT("linearized+error skbs", skbs_linearized_fail),
 	QETH_TXQ_STAT("TSO bytes", tso_bytes),
 	QETH_TXQ_STAT("Packing mode switches", packing_mode_switch),
+	QETH_TXQ_STAT("Queue stopped", stopped),
 };
 
 static const struct qeth_stats card_stats[] = {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7381917f76dd..e26a6dff286f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -607,11 +607,8 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	int rc;
 
 	if (IS_IQD(card))
-		queue = card->qdio.out_qs[qeth_iqd_translate_txq(dev, txq)];
-	else
-		queue = card->qdio.out_qs[txq];
-
-	netif_stop_subqueue(dev, txq);
+		txq = qeth_iqd_translate_txq(dev, txq);
+	queue = card->qdio.out_qs[txq];
 
 	if (IS_OSN(card))
 		rc = qeth_l2_xmit_osn(card, skb, queue);
@@ -622,15 +619,11 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (!rc) {
 		QETH_TXQ_STAT_INC(queue, tx_packets);
 		QETH_TXQ_STAT_ADD(queue, tx_bytes, tx_bytes);
-		netif_wake_subqueue(dev, txq);
 		return NETDEV_TX_OK;
-	} else if (rc == -EBUSY) {
-		return NETDEV_TX_BUSY;
-	} /* else fall through */
+	}
 
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
 	kfree_skb(skb);
-	netif_wake_subqueue(dev, txq);
 	return NETDEV_TX_OK;
 }
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 65244da4f415..4c9394105138 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2036,7 +2036,6 @@ static void qeth_l3_fixup_headers(struct sk_buff *skb)
 static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 			struct qeth_qdio_out_q *queue, int ipv, int cast_type)
 {
-	unsigned char eth_hdr[ETH_HLEN];
 	unsigned int hw_hdr_len;
 	int rc;
 
@@ -2046,17 +2045,10 @@ static int qeth_l3_xmit(struct qeth_card *card, struct sk_buff *skb,
 	rc = skb_cow_head(skb, hw_hdr_len - ETH_HLEN);
 	if (rc)
 		return rc;
-	skb_copy_from_linear_data(skb, eth_hdr, ETH_HLEN);
 	skb_pull(skb, ETH_HLEN);
 
 	qeth_l3_fixup_headers(skb);
-	rc = qeth_xmit(card, skb, queue, ipv, cast_type, qeth_l3_fill_header);
-	if (rc == -EBUSY) {
-		/* roll back to ETH header */
-		skb_push(skb, ETH_HLEN);
-		skb_copy_to_linear_data(skb, eth_hdr, ETH_HLEN);
-	}
-	return rc;
+	return qeth_xmit(card, skb, queue, ipv, cast_type, qeth_l3_fill_header);
 }
 
 static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
@@ -2091,8 +2083,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	if (cast_type == RTN_BROADCAST && !card->info.broadcast_capable)
 		goto tx_drop;
 
-	netif_stop_subqueue(dev, txq);
-
 	if (ipv == 4 || IS_IQD(card))
 		rc = qeth_l3_xmit(card, skb, queue, ipv, cast_type);
 	else
@@ -2102,16 +2092,12 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	if (!rc) {
 		QETH_TXQ_STAT_INC(queue, tx_packets);
 		QETH_TXQ_STAT_ADD(queue, tx_bytes, tx_bytes);
-		netif_wake_subqueue(dev, txq);
 		return NETDEV_TX_OK;
-	} else if (rc == -EBUSY) {
-		return NETDEV_TX_BUSY;
-	} /* else fall through */
+	}
 
 tx_drop:
 	QETH_TXQ_STAT_INC(queue, tx_dropped);
 	kfree_skb(skb);
-	netif_wake_subqueue(dev, txq);
 	return NETDEV_TX_OK;
 }
 
-- 
2.16.4
