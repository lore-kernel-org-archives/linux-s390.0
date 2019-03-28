Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/10] s390/qeth: use callback to finalize cmd
Date: Thu, 28 Mar 2019 16:39:27 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-10-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

To avoid concurrency issues, some parts of the cmd setup are delayed
until qeth_send_control_data() holds the IO channel's irq_pending
"lock". Rather than hard-coding those setup steps for each cmd type,
have the cmd provide a callback. This will make it easier to also issue
IDX commands via qeth_send_control_data().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 +--
 drivers/s390/net/qeth_core_main.c | 74 ++++++++++++++++++++++++---------------
 drivers/s390/net/qeth_l2_main.c   |  3 +-
 3 files changed, 50 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 30772d4abcbc..9495ba74404d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -589,6 +589,8 @@ struct qeth_cmd_buffer {
 	struct qeth_reply *reply;
 	long timeout;
 	unsigned char *data;
+	void (*finalize)(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+			 unsigned int length);
 	void (*callback)(struct qeth_card *card, struct qeth_channel *channel,
 			 struct qeth_cmd_buffer *iob);
 };
@@ -991,8 +993,6 @@ void qeth_clear_qdio_buffers(struct qeth_card *);
 void qeth_setadp_promisc_mode(struct qeth_card *);
 int qeth_setadpparms_change_macaddr(struct qeth_card *);
 void qeth_tx_timeout(struct net_device *);
-void qeth_prepare_control_data(struct qeth_card *, int,
-				struct qeth_cmd_buffer *);
 void qeth_release_buffer(struct qeth_channel *, struct qeth_cmd_buffer *);
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			  u16 cmd_length);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index fee787fbc1d4..431929d83f70 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1807,6 +1807,18 @@ static int qeth_idx_activate_get_answer(struct qeth_card *card,
 	return rc;
 }
 
+static void qeth_idx_finalize_cmd(struct qeth_card *card,
+				  struct qeth_cmd_buffer *iob,
+				  unsigned int length)
+{
+	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_WRITE, length, iob->data);
+
+	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data), &card->seqno.trans_hdr,
+	       QETH_SEQ_NO_LENGTH);
+	if (iob->channel == &card->write)
+		card->seqno.trans_hdr++;
+}
+
 static int qeth_idx_activate_channel(struct qeth_card *card,
 				     struct qeth_channel *channel,
 				     void (*reply_cb)(struct qeth_card *,
@@ -1825,18 +1837,12 @@ static int qeth_idx_activate_channel(struct qeth_card *card,
 	if (!iob)
 		return -ENOMEM;
 	iob->callback = reply_cb;
-	qeth_setup_ccw(channel->ccw, CCW_CMD_WRITE, IDX_ACTIVATE_SIZE,
-		       iob->data);
-	if (channel == &card->write) {
+
+	if (channel == &card->write)
 		memcpy(iob->data, IDX_ACTIVATE_WRITE, IDX_ACTIVATE_SIZE);
-		memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
-		       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
-		card->seqno.trans_hdr++;
-	} else {
+	else
 		memcpy(iob->data, IDX_ACTIVATE_READ, IDX_ACTIVATE_SIZE);
-		memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
-		       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
-	}
+
 	tmp = ((u8)card->dev->dev_port) | 0x80;
 	memcpy(QETH_IDX_ACT_PNO(iob->data), &tmp, 1);
 	memcpy(QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
@@ -1850,6 +1856,8 @@ static int qeth_idx_activate_channel(struct qeth_card *card,
 
 	wait_event(card->wait_q, qeth_trylock_channel(channel));
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
+	qeth_idx_finalize_cmd(card, iob, IDX_ACTIVATE_SIZE);
+
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
 				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
@@ -1977,23 +1985,21 @@ static void qeth_idx_read_cb(struct qeth_card *card,
 	qeth_release_buffer(channel, iob);
 }
 
-void qeth_prepare_control_data(struct qeth_card *card, int len,
-		struct qeth_cmd_buffer *iob)
+static void qeth_mpc_finalize_cmd(struct qeth_card *card,
+				  struct qeth_cmd_buffer *iob,
+				  unsigned int length)
 {
-	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_WRITE, len, iob->data);
-	iob->callback = qeth_release_buffer_cb;
+	qeth_idx_finalize_cmd(card, iob, length);
 
-	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
-	       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
-	card->seqno.trans_hdr++;
 	memcpy(QETH_PDU_HEADER_SEQ_NO(iob->data),
 	       &card->seqno.pdu_hdr, QETH_SEQ_NO_LENGTH);
 	card->seqno.pdu_hdr++;
 	memcpy(QETH_PDU_HEADER_ACK_SEQ_NO(iob->data),
 	       &card->seqno.pdu_hdr_ack, QETH_SEQ_NO_LENGTH);
-	QETH_DBF_HEX(CTRL, 2, iob->data, min(len, QETH_DBF_CTRL_LEN));
+
+	iob->reply->seqno = QETH_IDX_COMMAND_SEQNO;
+	iob->callback = qeth_release_buffer_cb;
 }
-EXPORT_SYMBOL_GPL(qeth_prepare_control_data);
 
 /**
  * qeth_send_control_data() -	send control command to the card
@@ -2029,7 +2035,6 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 	long timeout = iob->timeout;
 	int rc;
 	struct qeth_reply *reply = NULL;
-	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
@@ -2058,14 +2063,8 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 		return (timeout == -ERESTARTSYS) ? -EINTR : -ETIME;
 	}
 
-	if (IS_IPA(iob->data)) {
-		cmd = __ipa_cmd(iob);
-		cmd->hdr.seqno = card->seqno.ipa++;
-		reply->seqno = cmd->hdr.seqno;
-	} else {
-		reply->seqno = QETH_IDX_COMMAND_SEQNO;
-	}
-	qeth_prepare_control_data(card, len, iob);
+	iob->finalize(card, iob, len);
+	QETH_DBF_HEX(CTRL, 2, iob->data, min(len, QETH_DBF_CTRL_LEN));
 
 	qeth_enqueue_reply(card, reply);
 
@@ -2120,7 +2119,9 @@ static int qeth_cm_enable(struct qeth_card *card)
 	QETH_DBF_TEXT(SETUP, 2, "cmenable");
 
 	iob = qeth_wait_for_buffer(&card->write);
+	iob->finalize = qeth_mpc_finalize_cmd;
 	memcpy(iob->data, CM_ENABLE, CM_ENABLE_SIZE);
+
 	memcpy(QETH_CM_ENABLE_ISSUER_RM_TOKEN(iob->data),
 	       &card->token.issuer_rm_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_CM_ENABLE_FILTER_TOKEN(iob->data),
@@ -2153,7 +2154,9 @@ static int qeth_cm_setup(struct qeth_card *card)
 	QETH_DBF_TEXT(SETUP, 2, "cmsetup");
 
 	iob = qeth_wait_for_buffer(&card->write);
+	iob->finalize = qeth_mpc_finalize_cmd;
 	memcpy(iob->data, CM_SETUP, CM_SETUP_SIZE);
+
 	memcpy(QETH_CM_SETUP_DEST_ADDR(iob->data),
 	       &card->token.issuer_rm_r, QETH_MPC_TOKEN_LENGTH);
 	memcpy(QETH_CM_SETUP_CONNECTION_TOKEN(iob->data),
@@ -2270,6 +2273,7 @@ static int qeth_ulp_enable(struct qeth_card *card)
 	QETH_DBF_TEXT(SETUP, 2, "ulpenabl");
 
 	iob = qeth_wait_for_buffer(&card->write);
+	iob->finalize = qeth_mpc_finalize_cmd;
 	memcpy(iob->data, ULP_ENABLE, ULP_ENABLE_SIZE);
 
 	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) = (u8) card->dev->dev_port;
@@ -2316,6 +2320,7 @@ static int qeth_ulp_setup(struct qeth_card *card)
 	QETH_DBF_TEXT(SETUP, 2, "ulpsetup");
 
 	iob = qeth_wait_for_buffer(&card->write);
+	iob->finalize = qeth_mpc_finalize_cmd;
 	memcpy(iob->data, ULP_SETUP, ULP_SETUP_SIZE);
 
 	memcpy(QETH_ULP_SETUP_DEST_ADDR(iob->data),
@@ -2503,6 +2508,7 @@ static int qeth_dm_act(struct qeth_card *card)
 	QETH_DBF_TEXT(SETUP, 2, "dmact");
 
 	iob = qeth_wait_for_buffer(&card->write);
+	iob->finalize = qeth_mpc_finalize_cmd;
 	memcpy(iob->data, DM_ACT, DM_ACT_SIZE);
 
 	memcpy(QETH_DM_ACT_DEST_ADDR(iob->data),
@@ -2785,12 +2791,24 @@ static void qeth_fill_ipacmd_header(struct qeth_card *card,
 	cmd->hdr.prot_version = prot;
 }
 
+static void qeth_ipa_finalize_cmd(struct qeth_card *card,
+				  struct qeth_cmd_buffer *iob,
+				  unsigned int length)
+{
+	qeth_mpc_finalize_cmd(card, iob, length);
+
+	/* override with IPA-specific values: */
+	__ipa_cmd(iob)->hdr.seqno = card->seqno.ipa;
+	iob->reply->seqno = card->seqno.ipa++;
+}
+
 void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			  u16 cmd_length)
 {
 	u16 total_length = IPA_PDU_HEADER_SIZE + cmd_length;
 	u8 prot_type = qeth_mpc_select_prot_type(card);
 
+	iob->finalize = qeth_ipa_finalize_cmd;
 	iob->timeout = QETH_IPA_TIMEOUT;
 
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index e2b09472c482..5549c66c6b5d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1051,7 +1051,8 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 	QETH_CARD_TEXT(card, 5, "osndctrd");
 
 	wait_event(card->wait_q, qeth_trylock_channel(channel));
-	qeth_prepare_control_data(card, len, iob);
+	iob->finalize(card, iob, len);
+	QETH_DBF_HEX(CTRL, 2, iob->data, min(len, QETH_DBF_CTRL_LEN));
 	QETH_CARD_TEXT(card, 6, "osnoirqp");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
-- 
2.16.4
