Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405608AbfFKQiP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGWRAE008652
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:14 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2ecpwkk7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:13 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:11 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/13] s390/qeth: remove 'channel' parameter from callbacks
Date: Tue, 11 Jun 2019 18:37:56 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-10-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Each cmd buffer maintains a pointer to the IO channel that it was/will
be issued on. So when dealing with cmd buffers, we don't need to pass
around a separate channel pointer.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  5 ++--
 drivers/s390/net/qeth_core_main.c | 38 ++++++++++++++-----------------
 drivers/s390/net/qeth_l2_main.c   |  5 ++--
 3 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index be50e701b744..c1292d3420a2 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -585,8 +585,7 @@ struct qeth_cmd_buffer {
 	unsigned char *data;
 	void (*finalize)(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			 unsigned int length);
-	void (*callback)(struct qeth_card *card, struct qeth_channel *channel,
-			 struct qeth_cmd_buffer *iob);
+	void (*callback)(struct qeth_card *card, struct qeth_cmd_buffer *iob);
 };
 
 static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
@@ -995,7 +994,7 @@ void qeth_drain_output_queues(struct qeth_card *card);
 void qeth_setadp_promisc_mode(struct qeth_card *);
 int qeth_setadpparms_change_macaddr(struct qeth_card *);
 void qeth_tx_timeout(struct net_device *);
-void qeth_release_buffer(struct qeth_channel *, struct qeth_cmd_buffer *);
+void qeth_release_buffer(struct qeth_cmd_buffer *iob);
 void qeth_notify_reply(struct qeth_reply *reply, int reason);
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			  u16 cmd_length);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index df86705bdc55..10f16ddeb71a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -63,7 +63,6 @@ static struct device *qeth_core_root_dev;
 static struct lock_class_key qdio_out_skb_queue_key;
 
 static void qeth_issue_next_read_cb(struct qeth_card *card,
-				    struct qeth_channel *channel,
 				    struct qeth_cmd_buffer *iob);
 static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
@@ -521,7 +520,7 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 		QETH_DBF_MESSAGE(2, "error %i on device %x when starting next read ccw!\n",
 				 rc, CARD_DEVID(card));
 		atomic_set(&channel->irq_pending, 0);
-		qeth_release_buffer(channel, iob);
+		qeth_release_buffer(iob);
 		card->read_or_write_problem = 1;
 		qeth_schedule_recovery(card);
 		wake_up(&card->wait_q);
@@ -713,9 +712,9 @@ static struct qeth_cmd_buffer *__qeth_get_buffer(struct qeth_channel *channel)
 	return NULL;
 }
 
-void qeth_release_buffer(struct qeth_channel *channel,
-		struct qeth_cmd_buffer *iob)
+void qeth_release_buffer(struct qeth_cmd_buffer *iob)
 {
+	struct qeth_channel *channel = iob->channel;
 	unsigned long flags;
 
 	spin_lock_irqsave(&channel->iob_lock, flags);
@@ -731,10 +730,9 @@ void qeth_release_buffer(struct qeth_channel *channel,
 EXPORT_SYMBOL_GPL(qeth_release_buffer);
 
 static void qeth_release_buffer_cb(struct qeth_card *card,
-				   struct qeth_channel *channel,
 				   struct qeth_cmd_buffer *iob)
 {
-	qeth_release_buffer(channel, iob);
+	qeth_release_buffer(iob);
 }
 
 static void qeth_cancel_cmd(struct qeth_cmd_buffer *iob, int rc)
@@ -743,7 +741,7 @@ static void qeth_cancel_cmd(struct qeth_cmd_buffer *iob, int rc)
 
 	if (reply)
 		qeth_notify_reply(reply, rc);
-	qeth_release_buffer(iob->channel, iob);
+	qeth_release_buffer(iob);
 }
 
 struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
@@ -763,13 +761,12 @@ void qeth_clear_cmd_buffers(struct qeth_channel *channel)
 	int cnt;
 
 	for (cnt = 0; cnt < QETH_CMD_BUFFER_NO; cnt++)
-		qeth_release_buffer(channel, &channel->iob[cnt]);
+		qeth_release_buffer(&channel->iob[cnt]);
 	channel->io_buf_no = 0;
 }
 EXPORT_SYMBOL_GPL(qeth_clear_cmd_buffers);
 
 static void qeth_issue_next_read_cb(struct qeth_card *card,
-				    struct qeth_channel *channel,
 				    struct qeth_cmd_buffer *iob)
 {
 	struct qeth_ipa_cmd *cmd = NULL;
@@ -842,7 +839,7 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 	memcpy(&card->seqno.pdu_hdr_ack,
 		QETH_PDU_HEADER_SEQ_NO(iob->data),
 		QETH_SEQ_NO_LENGTH);
-	qeth_release_buffer(channel, iob);
+	qeth_release_buffer(iob);
 	__qeth_issue_next_read(card);
 }
 
@@ -1110,7 +1107,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		return;
 
 	if (iob && iob->callback)
-		iob->callback(card, iob->channel, iob);
+		iob->callback(card, iob);
 
 out:
 	wake_up(&card->wait_q);
@@ -1834,7 +1831,7 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 
 	reply = qeth_alloc_reply(card);
 	if (!reply) {
-		qeth_release_buffer(channel, iob);
+		qeth_release_buffer(iob);
 		return -ENOMEM;
 	}
 	reply->callback = reply_cb;
@@ -1849,7 +1846,7 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 						   timeout);
 	if (timeout <= 0) {
 		qeth_put_reply(reply);
-		qeth_release_buffer(channel, iob);
+		qeth_release_buffer(iob);
 		return (timeout == -ERESTARTSYS) ? -EINTR : -ETIME;
 	}
 
@@ -1869,7 +1866,7 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 		QETH_CARD_TEXT_(card, 2, " err%d", rc);
 		qeth_dequeue_reply(card, reply);
 		qeth_put_reply(reply);
-		qeth_release_buffer(channel, iob);
+		qeth_release_buffer(iob);
 		atomic_set(&channel->irq_pending, 0);
 		wake_up(&card->wait_q);
 		return rc;
@@ -1922,9 +1919,9 @@ static int qeth_idx_check_activate_response(struct qeth_card *card,
 }
 
 static void qeth_idx_query_read_cb(struct qeth_card *card,
-				   struct qeth_channel *channel,
 				   struct qeth_cmd_buffer *iob)
 {
+	struct qeth_channel *channel = iob->channel;
 	u16 peer_level;
 	int rc;
 
@@ -1951,13 +1948,13 @@ static void qeth_idx_query_read_cb(struct qeth_card *card,
 
 out:
 	qeth_notify_reply(iob->reply, rc);
-	qeth_release_buffer(channel, iob);
+	qeth_release_buffer(iob);
 }
 
 static void qeth_idx_query_write_cb(struct qeth_card *card,
-				    struct qeth_channel *channel,
 				    struct qeth_cmd_buffer *iob)
 {
+	struct qeth_channel *channel = iob->channel;
 	u16 peer_level;
 	int rc;
 
@@ -1978,7 +1975,7 @@ static void qeth_idx_query_write_cb(struct qeth_card *card,
 
 out:
 	qeth_notify_reply(iob->reply, rc);
-	qeth_release_buffer(channel, iob);
+	qeth_release_buffer(iob);
 }
 
 static void qeth_idx_finalize_query_cmd(struct qeth_card *card,
@@ -1989,11 +1986,10 @@ static void qeth_idx_finalize_query_cmd(struct qeth_card *card,
 }
 
 static void qeth_idx_activate_cb(struct qeth_card *card,
-				 struct qeth_channel *channel,
 				 struct qeth_cmd_buffer *iob)
 {
 	qeth_notify_reply(iob->reply, 0);
-	qeth_release_buffer(channel, iob);
+	qeth_release_buffer(iob);
 }
 
 static void qeth_idx_setup_activate_cmd(struct qeth_card *card,
@@ -2852,7 +2848,7 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 	QETH_CARD_TEXT(card, 4, "sendipa");
 
 	if (card->read_or_write_problem) {
-		qeth_release_buffer(iob->channel, iob);
+		qeth_release_buffer(iob);
 		return -EIO;
 	}
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5fc36ed20c67..e1b25084dcd4 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1030,11 +1030,10 @@ struct qeth_discipline qeth_l2_discipline = {
 EXPORT_SYMBOL_GPL(qeth_l2_discipline);
 
 static void qeth_osn_assist_cb(struct qeth_card *card,
-			       struct qeth_channel *channel,
 			       struct qeth_cmd_buffer *iob)
 {
 	qeth_notify_reply(iob->reply, 0);
-	qeth_release_buffer(channel, iob);
+	qeth_release_buffer(iob);
 }
 
 int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
@@ -1812,7 +1811,7 @@ static int qeth_l2_vnicc_request(struct qeth_card *card,
 		req->getset_timeout.vnic_char = cbctl->param.vnic_char;
 		break;
 	default:
-		qeth_release_buffer(iob->channel, iob);
+		qeth_release_buffer(iob);
 		return -EOPNOTSUPP;
 	}
 
-- 
2.17.1
