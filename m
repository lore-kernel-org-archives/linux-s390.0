From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/13] s390/qeth: skip QDIO queue handler indirection
Date: Thu, 26 Apr 2018 09:42:12 +0200
Message-ID: <20180426074224.100432-2-jwi@linux.ibm.com>
References: <20180426074224.100432-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180426074224.100432-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

Both qeth sub drivers use the same QDIO queue handlers, there's no need
to expose them via the driver's discipline. No functional change.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  9 ---------
 drivers/s390/net/qeth_core_main.c | 29 +++++++++++++----------------
 drivers/s390/net/qeth_l2_main.c   |  3 ---
 drivers/s390/net/qeth_l3_main.c   |  3 ---
 4 files changed, 13 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 78b98b3e7efa..8469446df62c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -712,9 +712,6 @@ enum qeth_discipline_id {
 
 struct qeth_discipline {
 	const struct device_type *devtype;
-	void (*start_poll)(struct ccw_device *, int, unsigned long);
-	qdio_handler_t *input_handler;
-	qdio_handler_t *output_handler;
 	int (*process_rx_buffer)(struct qeth_card *card, int budget, int *done);
 	int (*recover)(void *ptr);
 	int (*setup) (struct ccwgroup_device *);
@@ -921,13 +918,7 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *,
 		struct qeth_qdio_buffer *, struct qdio_buffer_element **, int *,
 		struct qeth_hdr **);
 void qeth_schedule_recovery(struct qeth_card *);
-void qeth_qdio_start_poll(struct ccw_device *, int, unsigned long);
 int qeth_poll(struct napi_struct *napi, int budget);
-void qeth_qdio_input_handler(struct ccw_device *,
-		unsigned int, unsigned int, int,
-		int, unsigned long);
-void qeth_qdio_output_handler(struct ccw_device *, unsigned int,
-			int, int, int, unsigned long);
 void qeth_clear_ipacmd_list(struct qeth_card *);
 int qeth_qdio_clear_card(struct qeth_card *, int);
 void qeth_clear_working_pool_list(struct qeth_card *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index dffd820731f2..5323c675e57c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3588,15 +3588,14 @@ static void qeth_check_outbound_queue(struct qeth_qdio_out_q *queue)
 	}
 }
 
-void qeth_qdio_start_poll(struct ccw_device *ccwdev, int queue,
-		unsigned long card_ptr)
+static void qeth_qdio_start_poll(struct ccw_device *ccwdev, int queue,
+				 unsigned long card_ptr)
 {
 	struct qeth_card *card = (struct qeth_card *)card_ptr;
 
 	if (card->dev && (card->dev->flags & IFF_UP))
 		napi_schedule(&card->napi);
 }
-EXPORT_SYMBOL_GPL(qeth_qdio_start_poll);
 
 int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 {
@@ -3698,9 +3697,10 @@ static void qeth_qdio_cq_handler(struct qeth_card *card,
 	return;
 }
 
-void qeth_qdio_input_handler(struct ccw_device *ccwdev, unsigned int qdio_err,
-		unsigned int queue, int first_elem, int count,
-		unsigned long card_ptr)
+static void qeth_qdio_input_handler(struct ccw_device *ccwdev,
+				    unsigned int qdio_err, int queue,
+				    int first_elem, int count,
+				    unsigned long card_ptr)
 {
 	struct qeth_card *card = (struct qeth_card *)card_ptr;
 
@@ -3711,14 +3711,12 @@ void qeth_qdio_input_handler(struct ccw_device *ccwdev, unsigned int qdio_err,
 		qeth_qdio_cq_handler(card, qdio_err, queue, first_elem, count);
 	else if (qdio_err)
 		qeth_schedule_recovery(card);
-
-
 }
-EXPORT_SYMBOL_GPL(qeth_qdio_input_handler);
 
-void qeth_qdio_output_handler(struct ccw_device *ccwdev,
-		unsigned int qdio_error, int __queue, int first_element,
-		int count, unsigned long card_ptr)
+static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
+				     unsigned int qdio_error, int __queue,
+				     int first_element, int count,
+				     unsigned long card_ptr)
 {
 	struct qeth_card *card        = (struct qeth_card *) card_ptr;
 	struct qeth_qdio_out_q *queue = card->qdio.out_qs[__queue];
@@ -3787,7 +3785,6 @@ void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 		card->perf_stats.outbound_handler_time += qeth_get_micros() -
 			card->perf_stats.outbound_handler_start_time;
 }
-EXPORT_SYMBOL_GPL(qeth_qdio_output_handler);
 
 /* We cannot use outbound queue 3 for unicast packets on HiperSockets */
 static inline int qeth_cut_iqd_prio(struct qeth_card *card, int queue_num)
@@ -4995,7 +4992,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 		goto out_free_in_sbals;
 	}
 	for (i = 0; i < card->qdio.no_in_queues; ++i)
-		queue_start_poll[i] = card->discipline->start_poll;
+		queue_start_poll[i] = qeth_qdio_start_poll;
 
 	qeth_qdio_establish_cq(card, in_sbal_ptrs, queue_start_poll);
 
@@ -5019,8 +5016,8 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	init_data.qib_param_field        = qib_param_field;
 	init_data.no_input_qs            = card->qdio.no_in_queues;
 	init_data.no_output_qs           = card->qdio.no_out_queues;
-	init_data.input_handler 	 = card->discipline->input_handler;
-	init_data.output_handler	 = card->discipline->output_handler;
+	init_data.input_handler		 = qeth_qdio_input_handler;
+	init_data.output_handler	 = qeth_qdio_output_handler;
 	init_data.queue_start_poll_array = queue_start_poll;
 	init_data.int_parm               = (unsigned long) card;
 	init_data.input_sbal_addr_array  = (void **) in_sbal_ptrs;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index b8079f2a65b3..dc9976064181 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1315,9 +1315,6 @@ static int qeth_l2_control_event(struct qeth_card *card,
 
 struct qeth_discipline qeth_l2_discipline = {
 	.devtype = &qeth_l2_devtype,
-	.start_poll = qeth_qdio_start_poll,
-	.input_handler = (qdio_handler_t *) qeth_qdio_input_handler,
-	.output_handler = (qdio_handler_t *) qeth_qdio_output_handler,
 	.process_rx_buffer = qeth_l2_process_inbound_buffer,
 	.recover = qeth_l2_recover,
 	.setup = qeth_l2_probe_device,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index c1a16a74aa83..f33df82f1237 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2960,9 +2960,6 @@ static int qeth_l3_control_event(struct qeth_card *card,
 
 struct qeth_discipline qeth_l3_discipline = {
 	.devtype = &qeth_l3_devtype,
-	.start_poll = qeth_qdio_start_poll,
-	.input_handler = (qdio_handler_t *) qeth_qdio_input_handler,
-	.output_handler = (qdio_handler_t *) qeth_qdio_output_handler,
 	.process_rx_buffer = qeth_l3_process_inbound_buffer,
 	.recover = qeth_l3_recover,
 	.setup = qeth_l3_probe_device,
-- 
2.13.5
