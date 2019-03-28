Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/10] s390/qeth: send IDX cmds via qeth_send_control_data()
Date: Thu, 28 Mar 2019 16:39:28 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-11-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This converts the IDX code to use qeth_send_control_data(), replacing
a bunch of duplicated IO code and unbounded waits. It also allows the
IDX sequence to benefit from the improved timeout & notify
infrastructure, so that we can eliminate the DOWN -> ACTIVATING -> UP
transition in the channel state machine.

The patch looks rather big, but most of it is a straight-forward
conversion of the old IDX cmd setup & callbacks to the new model.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |   1 -
 drivers/s390/net/qeth_core_main.c | 417 +++++++++++++++++++-------------------
 2 files changed, 206 insertions(+), 212 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 9495ba74404d..4c3a2db0cf2e 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -540,7 +540,6 @@ struct qeth_qdio_info {
 enum qeth_channel_states {
 	CH_STATE_UP,
 	CH_STATE_DOWN,
-	CH_STATE_ACTIVATING,
 	CH_STATE_HALTED,
 	CH_STATE_STOPPED,
 	CH_STATE_RCD,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 431929d83f70..2b75f76f23fd 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -674,9 +674,6 @@ EXPORT_SYMBOL_GPL(qeth_clear_ipacmd_list);
 static int qeth_check_idx_response(struct qeth_card *card,
 	unsigned char *buffer)
 {
-	if (!buffer)
-		return 0;
-
 	QETH_DBF_HEX(CTRL, 2, buffer, QETH_DBF_CTRL_LEN);
 	if ((buffer[2] & 0xc0) == 0xc0) {
 		QETH_DBF_MESSAGE(2, "received an IDX TERMINATE with cause code %#04x\n",
@@ -1764,49 +1761,6 @@ static void qeth_init_func_level(struct qeth_card *card)
 	}
 }
 
-static int qeth_idx_activate_get_answer(struct qeth_card *card,
-					struct qeth_channel *channel,
-					void (*reply_cb)(struct qeth_card *,
-							 struct qeth_channel *,
-							 struct qeth_cmd_buffer *))
-{
-	struct qeth_cmd_buffer *iob;
-	int rc;
-
-	QETH_DBF_TEXT(SETUP, 2, "idxanswr");
-	iob = qeth_get_buffer(channel);
-	if (!iob)
-		return -ENOMEM;
-	iob->callback = reply_cb;
-	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
-
-	wait_event(card->wait_q, qeth_trylock_channel(channel));
-	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
-	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
-	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
-				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
-	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
-
-	if (rc) {
-		QETH_DBF_MESSAGE(2, "Error2 in activating channel rc=%d\n", rc);
-		QETH_DBF_TEXT_(SETUP, 2, "2err%d", rc);
-		atomic_set(&channel->irq_pending, 0);
-		qeth_release_buffer(channel, iob);
-		wake_up(&card->wait_q);
-		return rc;
-	}
-	rc = wait_event_interruptible_timeout(card->wait_q,
-			 channel->state == CH_STATE_UP, QETH_TIMEOUT);
-	if (rc == -ERESTARTSYS)
-		return rc;
-	if (channel->state != CH_STATE_UP) {
-		rc = -ETIME;
-		QETH_DBF_TEXT_(SETUP, 2, "3err%d", rc);
-	} else
-		rc = 0;
-	return rc;
-}
-
 static void qeth_idx_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob,
 				  unsigned int length)
@@ -1819,74 +1773,6 @@ static void qeth_idx_finalize_cmd(struct qeth_card *card,
 		card->seqno.trans_hdr++;
 }
 
-static int qeth_idx_activate_channel(struct qeth_card *card,
-				     struct qeth_channel *channel,
-				     void (*reply_cb)(struct qeth_card *,
-						      struct qeth_channel *,
-						      struct qeth_cmd_buffer *))
-{
-	struct qeth_cmd_buffer *iob;
-	__u16 temp;
-	__u8 tmp;
-	int rc;
-	struct ccw_dev_id temp_devid;
-
-	QETH_DBF_TEXT(SETUP, 2, "idxactch");
-
-	iob = qeth_get_buffer(channel);
-	if (!iob)
-		return -ENOMEM;
-	iob->callback = reply_cb;
-
-	if (channel == &card->write)
-		memcpy(iob->data, IDX_ACTIVATE_WRITE, IDX_ACTIVATE_SIZE);
-	else
-		memcpy(iob->data, IDX_ACTIVATE_READ, IDX_ACTIVATE_SIZE);
-
-	tmp = ((u8)card->dev->dev_port) | 0x80;
-	memcpy(QETH_IDX_ACT_PNO(iob->data), &tmp, 1);
-	memcpy(QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
-	       &card->token.issuer_rm_w, QETH_MPC_TOKEN_LENGTH);
-	memcpy(QETH_IDX_ACT_FUNC_LEVEL(iob->data),
-	       &card->info.func_level, sizeof(__u16));
-	ccw_device_get_id(CARD_DDEV(card), &temp_devid);
-	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(iob->data), &temp_devid.devno, 2);
-	temp = (card->info.cula << 8) + card->info.unit_addr2;
-	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(iob->data), &temp, 2);
-
-	wait_event(card->wait_q, qeth_trylock_channel(channel));
-	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
-	qeth_idx_finalize_cmd(card, iob, IDX_ACTIVATE_SIZE);
-
-	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
-	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
-				      (addr_t) iob, 0, 0, QETH_TIMEOUT);
-	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
-
-	if (rc) {
-		QETH_DBF_MESSAGE(2, "Error1 in activating channel. rc=%d\n",
-			rc);
-		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
-		atomic_set(&channel->irq_pending, 0);
-		qeth_release_buffer(channel, iob);
-		wake_up(&card->wait_q);
-		return rc;
-	}
-	rc = wait_event_interruptible_timeout(card->wait_q,
-			channel->state == CH_STATE_ACTIVATING, QETH_TIMEOUT);
-	if (rc == -ERESTARTSYS)
-		return rc;
-	if (channel->state != CH_STATE_ACTIVATING) {
-		dev_warn(&channel->ccwdev->dev, "The qeth device driver"
-			" failed to recover an error on the device\n");
-		QETH_DBF_MESSAGE(2, "IDX activate timed out on channel %x\n",
-				 CCW_DEVID(channel->ccwdev));
-		QETH_DBF_TEXT_(SETUP, 2, "2err%d", -ETIME);
-		return -ETIME;
-	}
-	return qeth_idx_activate_get_answer(card, channel, reply_cb);
-}
-
 static int qeth_peer_func_level(int level)
 {
 	if ((level & 0xff) == 8)
@@ -1896,95 +1782,6 @@ static int qeth_peer_func_level(int level)
 	return level;
 }
 
-static void qeth_idx_write_cb(struct qeth_card *card,
-			      struct qeth_channel *channel,
-			      struct qeth_cmd_buffer *iob)
-{
-	__u16 temp;
-
-	QETH_DBF_TEXT(SETUP , 2, "idxwrcb");
-
-	if (channel->state == CH_STATE_DOWN) {
-		channel->state = CH_STATE_ACTIVATING;
-		goto out;
-	}
-
-	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
-		if (QETH_IDX_ACT_CAUSE_CODE(iob->data) == QETH_IDX_ACT_ERR_EXCL)
-			dev_err(&channel->ccwdev->dev,
-				"The adapter is used exclusively by another "
-				"host\n");
-		else
-			QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: negative reply\n",
-					 CCW_DEVID(channel->ccwdev));
-		goto out;
-	}
-	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
-	if ((temp & ~0x0100) != qeth_peer_func_level(card->info.func_level)) {
-		QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: function level mismatch (sent: %#x, received: %#x)\n",
-				 CCW_DEVID(channel->ccwdev),
-				 card->info.func_level, temp);
-		goto out;
-	}
-	channel->state = CH_STATE_UP;
-out:
-	qeth_release_buffer(channel, iob);
-}
-
-static void qeth_idx_read_cb(struct qeth_card *card,
-			     struct qeth_channel *channel,
-			     struct qeth_cmd_buffer *iob)
-{
-	__u16 temp;
-
-	QETH_DBF_TEXT(SETUP , 2, "idxrdcb");
-	if (channel->state == CH_STATE_DOWN) {
-		channel->state = CH_STATE_ACTIVATING;
-		goto out;
-	}
-
-	if (qeth_check_idx_response(card, iob->data))
-			goto out;
-
-	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
-		switch (QETH_IDX_ACT_CAUSE_CODE(iob->data)) {
-		case QETH_IDX_ACT_ERR_EXCL:
-			dev_err(&channel->ccwdev->dev,
-				"The adapter is used exclusively by another "
-				"host\n");
-			break;
-		case QETH_IDX_ACT_ERR_AUTH:
-		case QETH_IDX_ACT_ERR_AUTH_USER:
-			dev_err(&channel->ccwdev->dev,
-				"Setting the device online failed because of "
-				"insufficient authorization\n");
-			break;
-		default:
-			QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: negative reply\n",
-					 CCW_DEVID(channel->ccwdev));
-		}
-		QETH_CARD_TEXT_(card, 2, "idxread%c",
-			QETH_IDX_ACT_CAUSE_CODE(iob->data));
-		goto out;
-	}
-
-	memcpy(&temp, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
-	if (temp != qeth_peer_func_level(card->info.func_level)) {
-		QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: function level mismatch (sent: %#x, received: %#x)\n",
-				 CCW_DEVID(channel->ccwdev),
-				 card->info.func_level, temp);
-		goto out;
-	}
-	memcpy(&card->token.issuer_rm_r,
-	       QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
-	       QETH_MPC_TOKEN_LENGTH);
-	memcpy(&card->info.mcl_level[0],
-	       QETH_IDX_REPLY_LEVEL(iob->data), QETH_MCL_LENGTH);
-	channel->state = CH_STATE_UP;
-out:
-	qeth_release_buffer(channel, iob);
-}
-
 static void qeth_mpc_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob,
 				  unsigned int length)
@@ -2038,10 +1835,6 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
 
-	if (card->read_or_write_problem) {
-		qeth_release_buffer(channel, iob);
-		return -EIO;
-	}
 	reply = qeth_alloc_reply(card);
 	if (!reply) {
 		qeth_release_buffer(channel, iob);
@@ -2097,6 +1890,201 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 	return rc;
 }
 
+static int qeth_idx_check_activate_response(struct qeth_card *card,
+					    struct qeth_channel *channel,
+					    struct qeth_cmd_buffer *iob)
+{
+	int rc;
+
+	rc = qeth_check_idx_response(card, iob->data);
+	if (rc)
+		return rc;
+
+	if (QETH_IS_IDX_ACT_POS_REPLY(iob->data))
+		return 0;
+
+	/* negative reply: */
+	QETH_DBF_TEXT_(SETUP, 2, "idxneg%c",
+		       QETH_IDX_ACT_CAUSE_CODE(iob->data));
+
+	switch (QETH_IDX_ACT_CAUSE_CODE(iob->data)) {
+	case QETH_IDX_ACT_ERR_EXCL:
+		dev_err(&channel->ccwdev->dev,
+			"The adapter is used exclusively by another host\n");
+		return -EBUSY;
+	case QETH_IDX_ACT_ERR_AUTH:
+	case QETH_IDX_ACT_ERR_AUTH_USER:
+		dev_err(&channel->ccwdev->dev,
+			"Setting the device online failed because of insufficient authorization\n");
+		return -EPERM;
+	default:
+		QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: negative reply\n",
+				 CCW_DEVID(channel->ccwdev));
+		return -EIO;
+	}
+}
+
+static void qeth_idx_query_read_cb(struct qeth_card *card,
+				   struct qeth_channel *channel,
+				   struct qeth_cmd_buffer *iob)
+{
+	u16 peer_level;
+	int rc;
+
+	QETH_DBF_TEXT(SETUP, 2, "idxrdcb");
+
+	rc = qeth_idx_check_activate_response(card, channel, iob);
+	if (rc)
+		goto out;
+
+	memcpy(&peer_level, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
+	if (peer_level != qeth_peer_func_level(card->info.func_level)) {
+		QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: function level mismatch (sent: %#x, received: %#x)\n",
+				 CCW_DEVID(channel->ccwdev),
+				 card->info.func_level, peer_level);
+		rc = -EINVAL;
+		goto out;
+	}
+
+	memcpy(&card->token.issuer_rm_r,
+	       QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
+	       QETH_MPC_TOKEN_LENGTH);
+	memcpy(&card->info.mcl_level[0],
+	       QETH_IDX_REPLY_LEVEL(iob->data), QETH_MCL_LENGTH);
+
+out:
+	qeth_notify_reply(iob->reply, rc);
+	qeth_release_buffer(channel, iob);
+}
+
+static void qeth_idx_query_write_cb(struct qeth_card *card,
+				    struct qeth_channel *channel,
+				    struct qeth_cmd_buffer *iob)
+{
+	u16 peer_level;
+	int rc;
+
+	QETH_DBF_TEXT(SETUP, 2, "idxwrcb");
+
+	rc = qeth_idx_check_activate_response(card, channel, iob);
+	if (rc)
+		goto out;
+
+	memcpy(&peer_level, QETH_IDX_ACT_FUNC_LEVEL(iob->data), 2);
+	if ((peer_level & ~0x0100) !=
+	    qeth_peer_func_level(card->info.func_level)) {
+		QETH_DBF_MESSAGE(2, "IDX_ACTIVATE on channel %x: function level mismatch (sent: %#x, received: %#x)\n",
+				 CCW_DEVID(channel->ccwdev),
+				 card->info.func_level, peer_level);
+		rc = -EINVAL;
+	}
+
+out:
+	qeth_notify_reply(iob->reply, rc);
+	qeth_release_buffer(channel, iob);
+}
+
+static void qeth_idx_finalize_query_cmd(struct qeth_card *card,
+					struct qeth_cmd_buffer *iob,
+					unsigned int length)
+{
+	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_READ, length, iob->data);
+}
+
+static void qeth_idx_activate_cb(struct qeth_card *card,
+				 struct qeth_channel *channel,
+				 struct qeth_cmd_buffer *iob)
+{
+	qeth_notify_reply(iob->reply, 0);
+	qeth_release_buffer(channel, iob);
+}
+
+static void qeth_idx_setup_activate_cmd(struct qeth_card *card,
+					struct qeth_cmd_buffer *iob)
+{
+	u16 addr = (card->info.cula << 8) + card->info.unit_addr2;
+	u8 port = ((u8)card->dev->dev_port) | 0x80;
+	struct ccw_dev_id dev_id;
+
+	ccw_device_get_id(CARD_DDEV(card), &dev_id);
+	iob->finalize = qeth_idx_finalize_cmd;
+	iob->callback = qeth_idx_activate_cb;
+
+	memcpy(QETH_IDX_ACT_PNO(iob->data), &port, 1);
+	memcpy(QETH_IDX_ACT_ISSUER_RM_TOKEN(iob->data),
+	       &card->token.issuer_rm_w, QETH_MPC_TOKEN_LENGTH);
+	memcpy(QETH_IDX_ACT_FUNC_LEVEL(iob->data),
+	       &card->info.func_level, 2);
+	memcpy(QETH_IDX_ACT_QDIO_DEV_CUA(iob->data), &dev_id.devno, 2);
+	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(iob->data), &addr, 2);
+}
+
+static int qeth_idx_activate_read_channel(struct qeth_card *card)
+{
+	struct qeth_channel *channel = &card->read;
+	struct qeth_cmd_buffer *iob;
+	int rc;
+
+	QETH_DBF_TEXT(SETUP, 2, "idxread");
+
+	iob = qeth_get_buffer(channel);
+	if (!iob)
+		return -ENOMEM;
+
+	memcpy(iob->data, IDX_ACTIVATE_READ, IDX_ACTIVATE_SIZE);
+	qeth_idx_setup_activate_cmd(card, iob);
+
+	rc = qeth_send_control_data(card, IDX_ACTIVATE_SIZE, iob, NULL, NULL);
+	if (rc)
+		return rc;
+
+	iob = qeth_get_buffer(channel);
+	if (!iob)
+		return -ENOMEM;
+
+	iob->finalize = qeth_idx_finalize_query_cmd;
+	iob->callback = qeth_idx_query_read_cb;
+	rc = qeth_send_control_data(card, QETH_BUFSIZE, iob, NULL, NULL);
+	if (rc)
+		return rc;
+
+	channel->state = CH_STATE_UP;
+	return 0;
+}
+
+static int qeth_idx_activate_write_channel(struct qeth_card *card)
+{
+	struct qeth_channel *channel = &card->write;
+	struct qeth_cmd_buffer *iob;
+	int rc;
+
+	QETH_DBF_TEXT(SETUP, 2, "idxwrite");
+
+	iob = qeth_get_buffer(channel);
+	if (!iob)
+		return -ENOMEM;
+
+	memcpy(iob->data, IDX_ACTIVATE_WRITE, IDX_ACTIVATE_SIZE);
+	qeth_idx_setup_activate_cmd(card, iob);
+
+	rc = qeth_send_control_data(card, IDX_ACTIVATE_SIZE, iob, NULL, NULL);
+	if (rc)
+		return rc;
+
+	iob = qeth_get_buffer(channel);
+	if (!iob)
+		return -ENOMEM;
+
+	iob->finalize = qeth_idx_finalize_query_cmd;
+	iob->callback = qeth_idx_query_write_cb;
+	rc = qeth_send_control_data(card, QETH_BUFSIZE, iob, NULL, NULL);
+	if (rc)
+		return rc;
+
+	channel->state = CH_STATE_UP;
+	return 0;
+}
+
 static int qeth_cm_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 		unsigned long data)
 {
@@ -2866,6 +2854,11 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 
 	QETH_CARD_TEXT(card, 4, "sendipa");
 
+	if (card->read_or_write_problem) {
+		qeth_release_buffer(iob->channel, iob);
+		return -EIO;
+	}
+
 	if (reply_cb == NULL)
 		reply_cb = qeth_send_ipa_cmd_cb;
 	memcpy(&length, QETH_IPA_PDU_LEN_TOTAL(iob->data), 2);
@@ -5019,8 +5012,9 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	qeth_determine_capabilities(card);
 	qeth_init_tokens(card);
 	qeth_init_func_level(card);
-	rc = qeth_idx_activate_channel(card, &card->read, qeth_idx_read_cb);
-	if (rc == -ERESTARTSYS) {
+
+	rc = qeth_idx_activate_read_channel(card);
+	if (rc == -EINTR) {
 		QETH_DBF_TEXT(SETUP, 2, "break2");
 		return rc;
 	} else if (rc) {
@@ -5030,8 +5024,9 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 		else
 			goto retry;
 	}
-	rc = qeth_idx_activate_channel(card, &card->write, qeth_idx_write_cb);
-	if (rc == -ERESTARTSYS) {
+
+	rc = qeth_idx_activate_write_channel(card);
+	if (rc == -EINTR) {
 		QETH_DBF_TEXT(SETUP, 2, "break3");
 		return rc;
 	} else if (rc) {
-- 
2.16.4
