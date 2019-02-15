Return-Path: <SRS0=4yje=QW=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/7] s390/qeth: reduce ethtool statistics
Date: Fri, 15 Feb 2019 19:22:27 +0100
In-Reply-To: <20190215182231.90709-1-jwi@linux.ibm.com>
References: <20190215182231.90709-1-jwi@linux.ibm.com>
Message-Id: <20190215182231.90709-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Counting the number of function calls and the time spent in functions
is best left to proper tracing facilities.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 29 -------------
 drivers/s390/net/qeth_core_main.c | 85 ++++-----------------------------------
 drivers/s390/net/qeth_l2_main.c   |  8 ----
 drivers/s390/net/qeth_l3_main.c   |  8 ----
 4 files changed, 7 insertions(+), 123 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 2ea5d7c0b94c..9928728649eb 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -126,30 +126,6 @@ struct qeth_perf_stats {
 
 	unsigned int sc_dp_p;
 	unsigned int sc_p_dp;
-	/* qdio_cq_handler: number of times called, time spent in */
-	__u64 cq_start_time;
-	unsigned int cq_cnt;
-	unsigned int cq_time;
-	/* qdio_input_handler: number of times called, time spent in */
-	__u64 inbound_start_time;
-	unsigned int inbound_cnt;
-	unsigned int inbound_time;
-	/* qeth_send_packet: number of times called, time spent in */
-	__u64 outbound_start_time;
-	unsigned int outbound_cnt;
-	unsigned int outbound_time;
-	/* qdio_output_handler: number of times called, time spent in */
-	__u64 outbound_handler_start_time;
-	unsigned int outbound_handler_cnt;
-	unsigned int outbound_handler_time;
-	/* number of calls to and time spent in do_QDIO for inbound queue */
-	__u64 inbound_do_qdio_start_time;
-	unsigned int inbound_do_qdio_cnt;
-	unsigned int inbound_do_qdio_time;
-	/* number of calls to and time spent in do_QDIO for outbound queues */
-	__u64 outbound_do_qdio_start_time;
-	unsigned int outbound_do_qdio_cnt;
-	unsigned int outbound_do_qdio_time;
 	unsigned int large_send_bytes;
 	unsigned int large_send_cnt;
 	unsigned int sg_skbs_sent;
@@ -859,11 +835,6 @@ static inline int qeth_get_elements_for_range(addr_t start, addr_t end)
 	return PFN_UP(end) - PFN_DOWN(start);
 }
 
-static inline int qeth_get_micros(void)
-{
-	return (int) (get_tod_clock() >> 12);
-}
-
 static inline int qeth_get_ip_version(struct sk_buff *skb)
 {
 	struct vlan_ethhdr *veth = vlan_eth_hdr(skb);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d01a4aded4cc..e3127e232fb2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3244,17 +3244,8 @@ static void qeth_queue_input_buffer(struct qeth_card *card, int index)
 		 * 'index') un-requeued -> this buffer is the first buffer that
 		 * will be requeued the next time
 		 */
-		if (card->options.performance_stats) {
-			card->perf_stats.inbound_do_qdio_cnt++;
-			card->perf_stats.inbound_do_qdio_start_time =
-				qeth_get_micros();
-		}
 		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0,
 			     queue->next_buf_to_init, count);
-		if (card->options.performance_stats)
-			card->perf_stats.inbound_do_qdio_time +=
-				qeth_get_micros() -
-				card->perf_stats.inbound_do_qdio_start_time;
 		if (rc) {
 			QETH_CARD_TEXT(card, 2, "qinberr");
 		}
@@ -3407,22 +3398,12 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 	}
 
 	netif_trans_update(queue->card->dev);
-	if (queue->card->options.performance_stats) {
-		queue->card->perf_stats.outbound_do_qdio_cnt++;
-		queue->card->perf_stats.outbound_do_qdio_start_time =
-			qeth_get_micros();
-	}
 	qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
 	if (atomic_read(&queue->set_pci_flags_count))
 		qdio_flags |= QDIO_FLAG_PCI_OUT;
 	atomic_add(count, &queue->used_buffers);
-
 	rc = do_QDIO(CARD_DDEV(queue->card), qdio_flags,
 		     queue->queue_no, index, count);
-	if (queue->card->options.performance_stats)
-		queue->card->perf_stats.outbound_do_qdio_time +=
-			qeth_get_micros() -
-			queue->card->perf_stats.outbound_do_qdio_start_time;
 	if (rc) {
 		queue->card->stats.tx_errors += count;
 		/* ignore temporary SIGA errors without busy condition */
@@ -3529,7 +3510,7 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 	int rc;
 
 	if (!qeth_is_cq(card, queue))
-		goto out;
+		return;
 
 	QETH_CARD_TEXT_(card, 5, "qcqhe%d", first_element);
 	QETH_CARD_TEXT_(card, 5, "qcqhc%d", count);
@@ -3538,12 +3519,7 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 	if (qdio_err) {
 		netif_stop_queue(card->dev);
 		qeth_schedule_recovery(card);
-		goto out;
-	}
-
-	if (card->options.performance_stats) {
-		card->perf_stats.cq_cnt++;
-		card->perf_stats.cq_start_time = qeth_get_micros();
+		return;
 	}
 
 	for (i = first_element; i < first_element + count; ++i) {
@@ -3571,14 +3547,6 @@ static void qeth_qdio_cq_handler(struct qeth_card *card, unsigned int qdio_err,
 	}
 	card->qdio.c_q->next_buf_to_init = (card->qdio.c_q->next_buf_to_init
 				   + count) % QDIO_MAX_BUFFERS_PER_Q;
-
-	if (card->options.performance_stats) {
-		int delta_t = qeth_get_micros();
-		delta_t -= card->perf_stats.cq_start_time;
-		card->perf_stats.cq_time += delta_t;
-	}
-out:
-	return;
 }
 
 static void qeth_qdio_input_handler(struct ccw_device *ccwdev,
@@ -3614,11 +3582,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 		qeth_schedule_recovery(card);
 		return;
 	}
-	if (card->options.performance_stats) {
-		card->perf_stats.outbound_handler_cnt++;
-		card->perf_stats.outbound_handler_start_time =
-			qeth_get_micros();
-	}
+
 	for (i = first_element; i < (first_element + count); ++i) {
 		int bidx = i % QDIO_MAX_BUFFERS_PER_Q;
 		buffer = queue->bufs[bidx];
@@ -3664,9 +3628,6 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 		qeth_check_outbound_queue(queue);
 
 	netif_wake_queue(queue->card->dev);
-	if (card->options.performance_stats)
-		card->perf_stats.outbound_handler_time += qeth_get_micros() -
-			card->perf_stats.outbound_handler_start_time;
 }
 
 /* We cannot use outbound queue 3 for unicast packets on HiperSockets */
@@ -5319,11 +5280,6 @@ int qeth_poll(struct napi_struct *napi, int budget)
 	int done;
 	int new_budget = budget;
 
-	if (card->options.performance_stats) {
-		card->perf_stats.inbound_cnt++;
-		card->perf_stats.inbound_start_time = qeth_get_micros();
-	}
-
 	while (1) {
 		if (!card->rx.b_count) {
 			card->rx.qdio_err = 0;
@@ -5381,9 +5337,6 @@ int qeth_poll(struct napi_struct *napi, int budget)
 	if (qdio_start_irq(card->data.ccwdev, 0))
 		napi_schedule(&card->napi);
 out:
-	if (card->options.performance_stats)
-		card->perf_stats.inbound_time += qeth_get_micros() -
-			card->perf_stats.inbound_start_time;
 	return work_done;
 }
 EXPORT_SYMBOL_GPL(qeth_poll);
@@ -5984,21 +5937,9 @@ static struct {
 /* 20 */{"queue 1 buffer usage"},
 	{"queue 2 buffer usage"},
 	{"queue 3 buffer usage"},
-	{"rx poll time"},
-	{"rx poll count"},
-	{"rx do_QDIO time"},
-	{"rx do_QDIO count"},
-	{"tx handler time"},
-	{"tx handler count"},
-	{"tx time"},
-/* 30 */{"tx count"},
-	{"tx do_QDIO time"},
-	{"tx do_QDIO count"},
 	{"tx csum"},
 	{"tx lin"},
 	{"tx linfail"},
-	{"cq handler count"},
-	{"cq handler time"},
 	{"rx csum"}
 };
 
@@ -6046,22 +5987,10 @@ void qeth_core_get_ethtool_stats(struct net_device *dev,
 			atomic_read(&card->qdio.out_qs[2]->used_buffers) : 0;
 	data[22] = (card->qdio.no_out_queues > 3) ?
 			atomic_read(&card->qdio.out_qs[3]->used_buffers) : 0;
-	data[23] = card->perf_stats.inbound_time;
-	data[24] = card->perf_stats.inbound_cnt;
-	data[25] = card->perf_stats.inbound_do_qdio_time;
-	data[26] = card->perf_stats.inbound_do_qdio_cnt;
-	data[27] = card->perf_stats.outbound_handler_time;
-	data[28] = card->perf_stats.outbound_handler_cnt;
-	data[29] = card->perf_stats.outbound_time;
-	data[30] = card->perf_stats.outbound_cnt;
-	data[31] = card->perf_stats.outbound_do_qdio_time;
-	data[32] = card->perf_stats.outbound_do_qdio_cnt;
-	data[33] = card->perf_stats.tx_csum;
-	data[34] = card->perf_stats.tx_lin;
-	data[35] = card->perf_stats.tx_linfail;
-	data[36] = card->perf_stats.cq_cnt;
-	data[37] = card->perf_stats.cq_time;
-	data[38] = card->perf_stats.rx_csum;
+	data[23] = card->perf_stats.tx_csum;
+	data[24] = card->perf_stats.tx_lin;
+	data[25] = card->perf_stats.tx_linfail;
+	data[26] = card->perf_stats.rx_csum;
 }
 EXPORT_SYMBOL_GPL(qeth_core_get_ethtool_stats);
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c566139da43d..8931dd6e2caa 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -632,11 +632,6 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	}
 
 	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
-
-	if (card->options.performance_stats) {
-		card->perf_stats.outbound_cnt++;
-		card->perf_stats.outbound_start_time = qeth_get_micros();
-	}
 	netif_stop_queue(dev);
 
 	if (IS_OSN(card))
@@ -648,9 +643,6 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	if (!rc) {
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += tx_bytes;
-		if (card->options.performance_stats)
-			card->perf_stats.outbound_time += qeth_get_micros() -
-				card->perf_stats.outbound_start_time;
 		netif_wake_queue(dev);
 		return NETDEV_TX_OK;
 	} else if (rc == -EBUSY) {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8eb24c7f2750..012a290f1f4b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2092,11 +2092,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 		goto tx_drop;
 
 	queue = qeth_get_tx_queue(card, skb, ipv, cast_type);
-
-	if (card->options.performance_stats) {
-		card->perf_stats.outbound_cnt++;
-		card->perf_stats.outbound_start_time = qeth_get_micros();
-	}
 	netif_stop_queue(dev);
 
 	if (ipv == 4 || IS_IQD(card))
@@ -2108,9 +2103,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	if (!rc) {
 		card->stats.tx_packets++;
 		card->stats.tx_bytes += tx_bytes;
-		if (card->options.performance_stats)
-			card->perf_stats.outbound_time += qeth_get_micros() -
-				card->perf_stats.outbound_start_time;
 		netif_wake_queue(dev);
 		return NETDEV_TX_OK;
 	} else if (rc == -EBUSY) {
-- 
2.16.4
