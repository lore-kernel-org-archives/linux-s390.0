Return-Path: <linux-kernel-owner+w=401wt.eu-S1757738AbYGAOHp@vger.kernel.org>
Message-Id: <20080701140625.176935785@de.ibm.com>
References: <20080701140551.168274793@de.ibm.com>
Date: Tue, 01 Jul 2008 16:05:55 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/5] qeth: adapt to new qdio driver
Content-Disposition: inline; filename=605-nqdio-qeth.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: jang@linux.vnet.ibm.com, Ursula Braun <braunu@de.ibm.com>, Frank Pavlic <fpavlic@de.ibm.com>, Jeff Garzik <jgarzik@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

- use new qdio_get_ssqd_desc() to determine the port count value.
- cleanup qdio interface error handling
- remove qdio threshold values
- remove do_QDIO unused last parameter
- remove qdio_synchronize()
- remove unused parameter from qdio_activate()
- remove QDIO_FLAG_UNDER_INTERRUPT

Cc: Ursula Braun <braunu@de.ibm.com>
Cc: Frank Pavlic <fpavlic@de.ibm.com>
Cc: Jeff Garzik <jgarzik@redhat.com>

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/net/qeth_core.h      |   12 -----
 drivers/s390/net/qeth_core_main.c |   87 +++++++++++++++-----------------------
 drivers/s390/net/qeth_l2_main.c   |   26 ++++-------
 drivers/s390/net/qeth_l3_main.c   |   25 ++++------
 4 files changed, 60 insertions(+), 90 deletions(-)

Index: quilt-2.6/drivers/s390/net/qeth_core.h
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core.h
+++ quilt-2.6/drivers/s390/net/qeth_core.h
@@ -239,11 +239,6 @@ static inline int qeth_is_ipa_enabled(st
 /*not used unless the microcode gets patched*/
 #define QETH_PCI_TIMER_VALUE(card) 3
 
-#define QETH_MIN_INPUT_THRESHOLD 1
-#define QETH_MAX_INPUT_THRESHOLD 500
-#define QETH_MIN_OUTPUT_THRESHOLD 1
-#define QETH_MAX_OUTPUT_THRESHOLD 300
-
 /* priority queing */
 #define QETH_PRIOQ_DEFAULT QETH_NO_PRIO_QUEUEING
 #define QETH_DEFAULT_QUEUE    2
@@ -812,17 +807,14 @@ int qeth_send_ipa_cmd(struct qeth_card *
 struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *,
 			enum qeth_ipa_cmds, enum qeth_prot_versions);
 int qeth_query_setadapterparms(struct qeth_card *);
-int qeth_check_qdio_errors(struct qdio_buffer *, unsigned int,
-		       unsigned int, const char *);
+int qeth_check_qdio_errors(struct qdio_buffer *, unsigned int, const char *);
 void qeth_queue_input_buffer(struct qeth_card *, int);
 struct sk_buff *qeth_core_get_next_skb(struct qeth_card *,
 		struct qdio_buffer *, struct qdio_buffer_element **, int *,
 		struct qeth_hdr **);
 void qeth_schedule_recovery(struct qeth_card *);
 void qeth_qdio_output_handler(struct ccw_device *, unsigned int,
-			unsigned int, unsigned int,
-			unsigned int, int, int,
-			unsigned long);
+			int, int, int, unsigned long);
 void qeth_clear_ipacmd_list(struct qeth_card *);
 int qeth_qdio_clear_card(struct qeth_card *, int);
 void qeth_clear_working_pool_list(struct qeth_card *);
Index: quilt-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ quilt-2.6/drivers/s390/net/qeth_core_main.c
@@ -2079,7 +2079,7 @@ static void qeth_create_qib_param_field_
 static int qeth_qdio_activate(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(SETUP, 3, "qdioact");
-	return qdio_activate(CARD_DDEV(card), 0);
+	return qdio_activate(CARD_DDEV(card));
 }
 
 static int qeth_dm_act(struct qeth_card *card)
@@ -2355,16 +2355,11 @@ int qeth_init_qdio_queues(struct qeth_ca
 	card->qdio.in_q->next_buf_to_init =
 		card->qdio.in_buf_pool.buf_count - 1;
 	rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0, 0,
-		     card->qdio.in_buf_pool.buf_count - 1, NULL);
+		     card->qdio.in_buf_pool.buf_count - 1);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 		return rc;
 	}
-	rc = qdio_synchronize(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0);
-	if (rc) {
-		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
-		return rc;
-	}
 	/* outbound queue */
 	for (i = 0; i < card->qdio.no_out_queues; ++i) {
 		memset(card->qdio.out_qs[i]->qdio_bufs, 0,
@@ -2565,9 +2560,9 @@ int qeth_query_setadapterparms(struct qe
 EXPORT_SYMBOL_GPL(qeth_query_setadapterparms);
 
 int qeth_check_qdio_errors(struct qdio_buffer *buf, unsigned int qdio_error,
-		unsigned int siga_error, const char *dbftext)
+		const char *dbftext)
 {
-	if (qdio_error || siga_error) {
+	if (qdio_error) {
 		QETH_DBF_TEXT(TRACE, 2, dbftext);
 		QETH_DBF_TEXT(QERR, 2, dbftext);
 		QETH_DBF_TEXT_(QERR, 2, " F15=%02X",
@@ -2575,7 +2570,6 @@ int qeth_check_qdio_errors(struct qdio_b
 		QETH_DBF_TEXT_(QERR, 2, " F14=%02X",
 			       buf->element[14].flags & 0xff);
 		QETH_DBF_TEXT_(QERR, 2, " qerr=%X", qdio_error);
-		QETH_DBF_TEXT_(QERR, 2, " serr=%X", siga_error);
 		return 1;
 	}
 	return 0;
@@ -2628,9 +2622,8 @@ void qeth_queue_input_buffer(struct qeth
 			card->perf_stats.inbound_do_qdio_start_time =
 				qeth_get_micros();
 		}
-		rc = do_QDIO(CARD_DDEV(card),
-			     QDIO_FLAG_SYNC_INPUT | QDIO_FLAG_UNDER_INTERRUPT,
-			     0, queue->next_buf_to_init, count, NULL);
+		rc = do_QDIO(CARD_DDEV(card), QDIO_FLAG_SYNC_INPUT, 0,
+			     queue->next_buf_to_init, count);
 		if (card->options.performance_stats)
 			card->perf_stats.inbound_do_qdio_time +=
 				qeth_get_micros() -
@@ -2649,14 +2642,13 @@ void qeth_queue_input_buffer(struct qeth
 EXPORT_SYMBOL_GPL(qeth_queue_input_buffer);
 
 static int qeth_handle_send_error(struct qeth_card *card,
-		struct qeth_qdio_out_buffer *buffer, unsigned int qdio_err,
-		unsigned int siga_err)
+		struct qeth_qdio_out_buffer *buffer, unsigned int qdio_err)
 {
 	int sbalf15 = buffer->buffer->element[15].flags & 0xff;
-	int cc = siga_err & 3;
+	int cc = qdio_err & 3;
 
 	QETH_DBF_TEXT(TRACE, 6, "hdsnderr");
-	qeth_check_qdio_errors(buffer->buffer, qdio_err, siga_err, "qouterr");
+	qeth_check_qdio_errors(buffer->buffer, qdio_err, "qouterr");
 	switch (cc) {
 	case 0:
 		if (qdio_err) {
@@ -2668,7 +2660,7 @@ static int qeth_handle_send_error(struct
 		}
 		return QETH_SEND_ERROR_NONE;
 	case 2:
-		if (siga_err & QDIO_SIGA_ERROR_B_BIT_SET) {
+		if (qdio_err & QDIO_ERROR_SIGA_BUSY) {
 			QETH_DBF_TEXT(TRACE, 1, "SIGAcc2B");
 			QETH_DBF_TEXT_(TRACE, 1, "%s", CARD_BUS_ID(card));
 			return QETH_SEND_ERROR_KICK_IT;
@@ -2764,8 +2756,8 @@ static int qeth_flush_buffers_on_no_pci(
 	return 0;
 }
 
-static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int under_int,
-		int index, int count)
+static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
+			       int count)
 {
 	struct qeth_qdio_out_buffer *buf;
 	int rc;
@@ -2813,12 +2805,10 @@ static void qeth_flush_buffers(struct qe
 			qeth_get_micros();
 	}
 	qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
-	if (under_int)
-		qdio_flags |= QDIO_FLAG_UNDER_INTERRUPT;
 	if (atomic_read(&queue->set_pci_flags_count))
 		qdio_flags |= QDIO_FLAG_PCI_OUT;
 	rc = do_QDIO(CARD_DDEV(queue->card), qdio_flags,
-		     queue->queue_no, index, count, NULL);
+		     queue->queue_no, index, count);
 	if (queue->card->options.performance_stats)
 		queue->card->perf_stats.outbound_do_qdio_time +=
 			qeth_get_micros() -
@@ -2872,16 +2862,15 @@ static void qeth_check_outbound_queue(st
 				queue->card->perf_stats.bufs_sent_pack +=
 					flush_cnt;
 			if (flush_cnt)
-				qeth_flush_buffers(queue, 1, index, flush_cnt);
+				qeth_flush_buffers(queue, index, flush_cnt);
 			atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 		}
 	}
 }
 
-void qeth_qdio_output_handler(struct ccw_device *ccwdev, unsigned int status,
-		unsigned int qdio_error, unsigned int siga_error,
-		unsigned int __queue, int first_element, int count,
-		unsigned long card_ptr)
+void qeth_qdio_output_handler(struct ccw_device *ccwdev,
+		unsigned int qdio_error, int __queue, int first_element,
+		int count, unsigned long card_ptr)
 {
 	struct qeth_card *card        = (struct qeth_card *) card_ptr;
 	struct qeth_qdio_out_q *queue = card->qdio.out_qs[__queue];
@@ -2889,15 +2878,12 @@ void qeth_qdio_output_handler(struct ccw
 	int i;
 
 	QETH_DBF_TEXT(TRACE, 6, "qdouhdl");
-	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
-		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION) {
-			QETH_DBF_TEXT(TRACE, 2, "achkcond");
-			QETH_DBF_TEXT_(TRACE, 2, "%s", CARD_BUS_ID(card));
-			QETH_DBF_TEXT_(TRACE, 2, "%08x", status);
-			netif_stop_queue(card->dev);
-			qeth_schedule_recovery(card);
-			return;
-		}
+	if (qdio_error & QDIO_ERROR_ACTIVATE_CHECK_CONDITION) {
+		QETH_DBF_TEXT(TRACE, 2, "achkcond");
+		QETH_DBF_TEXT_(TRACE, 2, "%s", CARD_BUS_ID(card));
+		netif_stop_queue(card->dev);
+		qeth_schedule_recovery(card);
+		return;
 	}
 	if (card->options.performance_stats) {
 		card->perf_stats.outbound_handler_cnt++;
@@ -2907,8 +2893,7 @@ void qeth_qdio_output_handler(struct ccw
 	for (i = first_element; i < (first_element + count); ++i) {
 		buffer = &queue->bufs[i % QDIO_MAX_BUFFERS_PER_Q];
 		/*we only handle the KICK_IT error by doing a recovery */
-		if (qeth_handle_send_error(card, buffer,
-					   qdio_error, siga_error)
+		if (qeth_handle_send_error(card, buffer, qdio_error)
 				== QETH_SEND_ERROR_KICK_IT){
 			netif_stop_queue(card->dev);
 			qeth_schedule_recovery(card);
@@ -3187,11 +3172,11 @@ int qeth_do_send_packet_fast(struct qeth
 	atomic_set(&queue->state, QETH_OUT_Q_UNLOCKED);
 	if (ctx == NULL) {
 		qeth_fill_buffer(queue, buffer, skb, hdr, offset, hd_len);
-		qeth_flush_buffers(queue, 0, index, 1);
+		qeth_flush_buffers(queue, index, 1);
 	} else {
 		flush_cnt = qeth_eddp_fill_buffer(queue, ctx, index);
 		WARN_ON(buffers_needed != flush_cnt);
-		qeth_flush_buffers(queue, 0, index, flush_cnt);
+		qeth_flush_buffers(queue, index, flush_cnt);
 	}
 	return 0;
 out:
@@ -3244,8 +3229,8 @@ int qeth_do_send_packet(struct qeth_card
 				 * again */
 				if (atomic_read(&buffer->state) !=
 						QETH_QDIO_BUF_EMPTY){
-					qeth_flush_buffers(queue, 0,
-						start_index, flush_count);
+					qeth_flush_buffers(queue, start_index,
+							   flush_count);
 					atomic_set(&queue->state,
 						QETH_OUT_Q_UNLOCKED);
 					return -EBUSY;
@@ -3276,7 +3261,7 @@ int qeth_do_send_packet(struct qeth_card
 	flush_count += tmp;
 out:
 	if (flush_count)
-		qeth_flush_buffers(queue, 0, start_index, flush_count);
+		qeth_flush_buffers(queue, start_index, flush_count);
 	else if (!atomic_read(&queue->set_pci_flags_count))
 		atomic_xchg(&queue->state, QETH_OUT_Q_LOCKED_FLUSH);
 	/*
@@ -3297,7 +3282,7 @@ out:
 		if (!flush_count && !atomic_read(&queue->set_pci_flags_count))
 			flush_count += qeth_flush_buffers_on_no_pci(queue);
 		if (flush_count)
-			qeth_flush_buffers(queue, 0, start_index, flush_count);
+			qeth_flush_buffers(queue, start_index, flush_count);
 	}
 	/* at this point the queue is UNLOCKED again */
 	if (queue->card->options.performance_stats && do_pack)
@@ -3709,10 +3694,6 @@ static int qeth_qdio_establish(struct qe
 	init_data.q_format               = qeth_get_qdio_q_format(card);
 	init_data.qib_param_field_format = 0;
 	init_data.qib_param_field        = qib_param_field;
-	init_data.min_input_threshold    = QETH_MIN_INPUT_THRESHOLD;
-	init_data.max_input_threshold    = QETH_MAX_INPUT_THRESHOLD;
-	init_data.min_output_threshold   = QETH_MIN_OUTPUT_THRESHOLD;
-	init_data.max_output_threshold   = QETH_MAX_OUTPUT_THRESHOLD;
 	init_data.no_input_qs            = 1;
 	init_data.no_output_qs           = card->qdio.no_out_queues;
 	init_data.input_handler          = card->discipline.input_handler;
@@ -3774,8 +3755,9 @@ static int qeth_core_driver_group(const 
 
 int qeth_core_hardsetup_card(struct qeth_card *card)
 {
+	struct qdio_ssqd_desc *qdio_ssqd;
 	int retries = 3;
-	int mpno;
+	int mpno = 0;
 	int rc;
 
 	QETH_DBF_TEXT(SETUP, 2, "hrdsetup");
@@ -3807,7 +3789,10 @@ retry:
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
 		return rc;
 	}
-	mpno = qdio_get_ssqd_pct(CARD_DDEV(card));
+
+	qdio_ssqd = qdio_get_ssqd_desc(CARD_DDEV(card));
+	if (qdio_ssqd)
+		mpno = qdio_ssqd->pcnt;
 	if (mpno)
 		mpno = min(mpno - 1, QETH_MAX_PORTNO);
 	if (card->info.portno > mpno) {
Index: quilt-2.6/drivers/s390/net/qeth_l2_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_l2_main.c
+++ quilt-2.6/drivers/s390/net/qeth_l2_main.c
@@ -754,8 +754,7 @@ tx_drop:
 }
 
 static void qeth_l2_qdio_input_handler(struct ccw_device *ccwdev,
-			unsigned int status, unsigned int qdio_err,
-			unsigned int siga_err, unsigned int queue,
+			unsigned int qdio_err, unsigned int queue,
 			int first_element, int count, unsigned long card_ptr)
 {
 	struct net_device *net_dev;
@@ -770,23 +769,20 @@ static void qeth_l2_qdio_input_handler(s
 		card->perf_stats.inbound_cnt++;
 		card->perf_stats.inbound_start_time = qeth_get_micros();
 	}
-	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
-		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION) {
-			QETH_DBF_TEXT(TRACE, 1, "qdinchk");
-			QETH_DBF_TEXT_(TRACE, 1, "%s", CARD_BUS_ID(card));
-			QETH_DBF_TEXT_(TRACE, 1, "%04X%04X", first_element,
-					count);
-			QETH_DBF_TEXT_(TRACE, 1, "%04X%04X", queue, status);
-			qeth_schedule_recovery(card);
-			return;
-		}
+	if (qdio_err & QDIO_ERROR_ACTIVATE_CHECK_CONDITION) {
+		QETH_DBF_TEXT(TRACE, 1, "qdinchk");
+		QETH_DBF_TEXT_(TRACE, 1, "%s", CARD_BUS_ID(card));
+		QETH_DBF_TEXT_(TRACE, 1, "%04X%04X", first_element,
+				count);
+		QETH_DBF_TEXT_(TRACE, 1, "%04X", queue);
+		qeth_schedule_recovery(card);
+		return;
 	}
 	for (i = first_element; i < (first_element + count); ++i) {
 		index = i % QDIO_MAX_BUFFERS_PER_Q;
 		buffer = &card->qdio.in_q->bufs[index];
-		if (!((status & QDIO_STATUS_LOOK_FOR_ERROR) &&
-		      qeth_check_qdio_errors(buffer->buffer,
-					     qdio_err, siga_err, "qinerr")))
+		if (!(qdio_err &&
+		      qeth_check_qdio_errors(buffer->buffer, qdio_err, "qinerr")))
 			qeth_l2_process_inbound_buffer(card, buffer, index);
 		/* clear buffer and give back to hardware */
 		qeth_put_buffer_pool_entry(card, buffer->pool_entry);
Index: quilt-2.6/drivers/s390/net/qeth_l3_main.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/qeth_l3_main.c
+++ quilt-2.6/drivers/s390/net/qeth_l3_main.c
@@ -2964,8 +2964,7 @@ static int qeth_l3_setup_netdev(struct q
 }
 
 static void qeth_l3_qdio_input_handler(struct ccw_device *ccwdev,
-		unsigned int status, unsigned int qdio_err,
-		unsigned int siga_err, unsigned int queue, int first_element,
+		unsigned int qdio_err, unsigned int queue, int first_element,
 		int count, unsigned long card_ptr)
 {
 	struct net_device *net_dev;
@@ -2980,23 +2979,21 @@ static void qeth_l3_qdio_input_handler(s
 		card->perf_stats.inbound_cnt++;
 		card->perf_stats.inbound_start_time = qeth_get_micros();
 	}
-	if (status & QDIO_STATUS_LOOK_FOR_ERROR) {
-		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION) {
-			QETH_DBF_TEXT(TRACE, 1, "qdinchk");
-			QETH_DBF_TEXT_(TRACE, 1, "%s", CARD_BUS_ID(card));
-			QETH_DBF_TEXT_(TRACE, 1, "%04X%04X",
-					first_element, count);
-			QETH_DBF_TEXT_(TRACE, 1, "%04X%04X", queue, status);
-			qeth_schedule_recovery(card);
-			return;
-		}
+	if (qdio_err & QDIO_ERROR_ACTIVATE_CHECK_CONDITION) {
+		QETH_DBF_TEXT(TRACE, 1, "qdinchk");
+		QETH_DBF_TEXT_(TRACE, 1, "%s", CARD_BUS_ID(card));
+		QETH_DBF_TEXT_(TRACE, 1, "%04X%04X",
+				first_element, count);
+		QETH_DBF_TEXT_(TRACE, 1, "%04X", queue);
+		qeth_schedule_recovery(card);
+		return;
 	}
 	for (i = first_element; i < (first_element + count); ++i) {
 		index = i % QDIO_MAX_BUFFERS_PER_Q;
 		buffer = &card->qdio.in_q->bufs[index];
-		if (!((status & QDIO_STATUS_LOOK_FOR_ERROR) &&
+		if (!(qdio_err &&
 		      qeth_check_qdio_errors(buffer->buffer,
-					     qdio_err, siga_err, "qinerr")))
+					     qdio_err, "qinerr")))
 			qeth_l3_process_inbound_buffer(card, buffer, index);
 		/* clear buffer and give back to hardware */
 		qeth_put_buffer_pool_entry(card, buffer->pool_entry);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
