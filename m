Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404652AbfFKQiN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:13 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGR5VO110019
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:12 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2em1vvn3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:12 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:09 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/13] s390/qeth: remove qeth_wait_for_buffer()
Date: Tue, 11 Jun 2019 18:37:53 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-7-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The basic MPC initialization sequence is strictly sequential, and
waiting for an available cmd buffer should never be necessary.
So this change only affects the OSN path, where dangling waiters on an
unbounded wait_event() are not desirable. Switch to qeth_get_buffers(),
and let OSN callers deal with -ENOMEM.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 58 +++++++++++++++++--------------
 drivers/s390/net/qeth_l2_main.c   |  5 ++-
 3 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 5fab7b3396aa..14e8ab34ab2f 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -998,7 +998,7 @@ void qeth_tx_timeout(struct net_device *);
 void qeth_release_buffer(struct qeth_channel *, struct qeth_cmd_buffer *);
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			  u16 cmd_length);
-struct qeth_cmd_buffer *qeth_wait_for_buffer(struct qeth_channel *);
+struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel);
 int qeth_query_switch_attributes(struct qeth_card *card,
 				  struct qeth_switch_info *sw_info);
 int qeth_query_card_info(struct qeth_card *card,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0403a1405872..3d25cff404fe 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -65,7 +65,6 @@ static struct lock_class_key qdio_out_skb_queue_key;
 static void qeth_issue_next_read_cb(struct qeth_card *card,
 				    struct qeth_channel *channel,
 				    struct qeth_cmd_buffer *iob);
-static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *);
 static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
 static void qeth_free_qdio_queues(struct qeth_card *card);
@@ -746,7 +745,7 @@ static void qeth_cancel_cmd(struct qeth_cmd_buffer *iob, int rc)
 	qeth_release_buffer(iob->channel, iob);
 }
 
-static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
+struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
 {
 	struct qeth_cmd_buffer *buffer = NULL;
 	unsigned long flags;
@@ -756,15 +755,7 @@ static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
 	spin_unlock_irqrestore(&channel->iob_lock, flags);
 	return buffer;
 }
-
-struct qeth_cmd_buffer *qeth_wait_for_buffer(struct qeth_channel *channel)
-{
-	struct qeth_cmd_buffer *buffer;
-	wait_event(channel->wait_q,
-		   ((buffer = qeth_get_buffer(channel)) != NULL));
-	return buffer;
-}
-EXPORT_SYMBOL_GPL(qeth_wait_for_buffer);
+EXPORT_SYMBOL_GPL(qeth_get_buffer);
 
 void qeth_clear_cmd_buffers(struct qeth_channel *channel)
 {
@@ -1794,6 +1785,16 @@ static void qeth_mpc_finalize_cmd(struct qeth_card *card,
 	iob->callback = qeth_release_buffer_cb;
 }
 
+static struct qeth_cmd_buffer *qeth_mpc_get_cmd_buffer(struct qeth_card *card)
+{
+	struct qeth_cmd_buffer *iob;
+
+	iob = qeth_get_buffer(&card->write);
+	if (iob)
+		iob->finalize = qeth_mpc_finalize_cmd;
+	return iob;
+}
+
 /**
  * qeth_send_control_data() -	send control command to the card
  * @card:			qeth_card structure pointer
@@ -2102,10 +2103,11 @@ static int qeth_cm_enable(struct qeth_card *card)
 
 	QETH_DBF_TEXT(SETUP, 2, "cmenable");
 
-	iob = qeth_wait_for_buffer(&card->write);
-	iob->finalize = qeth_mpc_finalize_cmd;
-	memcpy(iob->data, CM_ENABLE, CM_ENABLE_SIZE);
+	iob = qeth_mpc_get_cmd_buffer(card);
+	if (!iob)
+		return -ENOMEM;
 
+	memcpy(iob->data, CM_ENABLE, CM_ENABLE_SIZE);
 	memcpy(QETH_CM_ENABLE_ISSUER_RM_TOKEN(iob->data),
 	       &card->token.issuer_rm_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_CM_ENABLE_FILTER_TOKEN(iob->data),
@@ -2137,10 +2139,11 @@ static int qeth_cm_setup(struct qeth_card *card)
 
 	QETH_DBF_TEXT(SETUP, 2, "cmsetup");
 
-	iob = qeth_wait_for_buffer(&card->write);
-	iob->finalize = qeth_mpc_finalize_cmd;
-	memcpy(iob->data, CM_SETUP, CM_SETUP_SIZE);
+	iob = qeth_mpc_get_cmd_buffer(card);
+	if (!iob)
+		return -ENOMEM;
 
+	memcpy(iob->data, CM_SETUP, CM_SETUP_SIZE);
 	memcpy(QETH_CM_SETUP_DEST_ADDR(iob->data),
 	       &card->token.issuer_rm_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_CM_SETUP_CONNECTION_TOKEN(iob->data),
@@ -2256,10 +2259,11 @@ static int qeth_ulp_enable(struct qeth_card *card)
 	/*FIXME: trace view callbacks*/
 	QETH_DBF_TEXT(SETUP, 2, "ulpenabl");
 
-	iob = qeth_wait_for_buffer(&card->write);
-	iob->finalize = qeth_mpc_finalize_cmd;
-	memcpy(iob->data, ULP_ENABLE, ULP_ENABLE_SIZE);
+	iob = qeth_mpc_get_cmd_buffer(card);
+	if (!iob)
+		return -ENOMEM;
 
+	memcpy(iob->data, ULP_ENABLE, ULP_ENABLE_SIZE);
 	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) = (u8) card->dev->dev_port;
 	memcpy(QETH_ULP_ENABLE_PROT_TYPE(iob->data), &prot_type, 1);
 	memcpy(QETH_ULP_ENABLE_DEST_ADDR(iob->data),
@@ -2303,10 +2307,11 @@ static int qeth_ulp_setup(struct qeth_card *card)
 
 	QETH_DBF_TEXT(SETUP, 2, "ulpsetup");
 
-	iob = qeth_wait_for_buffer(&card->write);
-	iob->finalize = qeth_mpc_finalize_cmd;
-	memcpy(iob->data, ULP_SETUP, ULP_SETUP_SIZE);
+	iob = qeth_mpc_get_cmd_buffer(card);
+	if (!iob)
+		return -ENOMEM;
 
+	memcpy(iob->data, ULP_SETUP, ULP_SETUP_SIZE);
 	memcpy(QETH_ULP_SETUP_DEST_ADDR(iob->data),
 	       &card->token.cm_connection_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_ULP_SETUP_CONNECTION_TOKEN(iob->data),
@@ -2492,10 +2497,11 @@ static int qeth_dm_act(struct qeth_card *card)
 
 	QETH_DBF_TEXT(SETUP, 2, "dmact");
 
-	iob = qeth_wait_for_buffer(&card->write);
-	iob->finalize = qeth_mpc_finalize_cmd;
-	memcpy(iob->data, DM_ACT, DM_ACT_SIZE);
+	iob = qeth_mpc_get_cmd_buffer(card);
+	if (!iob)
+		return -ENOMEM;
 
+	memcpy(iob->data, DM_ACT, DM_ACT_SIZE);
 	memcpy(QETH_DM_ACT_DEST_ADDR(iob->data),
 	       &card->token.cm_connection_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_DM_ACT_CONNECTION_TOKEN(iob->data),
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 40e2f6bd0f09..5fa217382480 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1084,7 +1084,10 @@ int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
 	QETH_CARD_TEXT(card, 2, "osnsdmc");
 	if (!qeth_card_hw_is_reachable(card))
 		return -ENODEV;
-	iob = qeth_wait_for_buffer(&card->write);
+	iob = qeth_get_buffer(&card->write);
+	if (!iob)
+		return -ENOMEM;
+
 	qeth_prepare_ipa_cmd(card, iob, (u16) data_len);
 	memcpy(__ipa_cmd(iob), data, data_len);
 	return qeth_osn_send_ipa_cmd(card, iob);
-- 
2.17.1
