From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/15] s390/qeth: pass card pointer in iob callback
Date: Wed, 26 Sep 2018 18:29:10 +0200
Message-ID: <20180926162916.102720-10-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This allows us to remove the CARD_FROM_CDEV calls in the iob callbacks.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 53 ++++++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 630a01b3212c..64bcb1237db0 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -582,7 +582,8 @@ struct qeth_cmd_buffer {
 	struct qeth_channel *channel;
 	unsigned char *data;
 	int rc;
-	void (*callback) (struct qeth_channel *, struct qeth_cmd_buffer *);
+	void (*callback)(struct qeth_card *card, struct qeth_channel *channel,
+			 struct qeth_cmd_buffer *iob);
 };
 
 static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 1b853f900720..86b9cce1f483 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -63,8 +63,9 @@ static struct kmem_cache *qeth_qdio_outbuf_cache;
 static struct device *qeth_core_root_dev;
 static struct lock_class_key qdio_out_skb_queue_key;
 
-static void qeth_send_control_data_cb(struct qeth_channel *,
-			struct qeth_cmd_buffer *);
+static void qeth_send_control_data_cb(struct qeth_card *card,
+				      struct qeth_channel *channel,
+				      struct qeth_cmd_buffer *iob);
 static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *);
 static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
@@ -787,6 +788,13 @@ void qeth_release_buffer(struct qeth_channel *channel,
 }
 EXPORT_SYMBOL_GPL(qeth_release_buffer);
 
+static void qeth_release_buffer_cb(struct qeth_card *card,
+				   struct qeth_channel *channel,
+				   struct qeth_cmd_buffer *iob)
+{
+	qeth_release_buffer(channel, iob);
+}
+
 static struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
 {
 	struct qeth_cmd_buffer *buffer = NULL;
@@ -817,17 +825,16 @@ void qeth_clear_cmd_buffers(struct qeth_channel *channel)
 }
 EXPORT_SYMBOL_GPL(qeth_clear_cmd_buffers);
 
-static void qeth_send_control_data_cb(struct qeth_channel *channel,
-		  struct qeth_cmd_buffer *iob)
+static void qeth_send_control_data_cb(struct qeth_card *card,
+				      struct qeth_channel *channel,
+				      struct qeth_cmd_buffer *iob)
 {
-	struct qeth_card *card;
 	struct qeth_reply *reply, *r;
 	struct qeth_ipa_cmd *cmd;
 	unsigned long flags;
 	int keep_reply;
 	int rc = 0;
 
-	card = CARD_FROM_CDEV(channel->ccwdev);
 	QETH_CARD_TEXT(card, 4, "sndctlcb");
 	rc = qeth_check_idx_response(card, iob->data);
 	switch (rc) {
@@ -1164,7 +1171,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		__qeth_issue_next_read(card);
 
 	if (iob && iob->callback)
-		iob->callback(iob->channel, iob);
+		iob->callback(card, iob->channel, iob);
 
 out:
 	wake_up(&card->wait_q);
@@ -1804,8 +1811,9 @@ static void qeth_init_func_level(struct qeth_card *card)
 }
 
 static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
-		void (*idx_reply_cb)(struct qeth_channel *,
-			struct qeth_cmd_buffer *))
+					void (*reply_cb)(struct qeth_card *,
+							 struct qeth_channel *,
+							 struct qeth_cmd_buffer *))
 {
 	struct qeth_cmd_buffer *iob;
 	int rc;
@@ -1816,7 +1824,7 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 	iob = qeth_get_buffer(channel);
 	if (!iob)
 		return -ENOMEM;
-	iob->callback = idx_reply_cb;
+	iob->callback = reply_cb;
 	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
 
 	wait_event(card->wait_q,
@@ -1847,8 +1855,9 @@ static int qeth_idx_activate_get_answer(struct qeth_channel *channel,
 }
 
 static int qeth_idx_activate_channel(struct qeth_channel *channel,
-		void (*idx_reply_cb)(struct qeth_channel *,
-			struct qeth_cmd_buffer *))
+				     void (*reply_cb)(struct qeth_card *,
+						      struct qeth_channel *,
+						      struct qeth_cmd_buffer *))
 {
 	struct qeth_card *card;
 	struct qeth_cmd_buffer *iob;
@@ -1864,7 +1873,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 	iob = qeth_get_buffer(channel);
 	if (!iob)
 		return -ENOMEM;
-	iob->callback = idx_reply_cb;
+	iob->callback = reply_cb;
 	qeth_setup_ccw(channel->ccw, CCW_CMD_WRITE, IDX_ACTIVATE_SIZE,
 		       iob->data);
 	if (channel == &card->write) {
@@ -1916,7 +1925,7 @@ static int qeth_idx_activate_channel(struct qeth_channel *channel,
 		QETH_DBF_TEXT_(SETUP, 2, "2err%d", -ETIME);
 		return -ETIME;
 	}
-	return qeth_idx_activate_get_answer(channel, idx_reply_cb);
+	return qeth_idx_activate_get_answer(channel, reply_cb);
 }
 
 static int qeth_peer_func_level(int level)
@@ -1928,10 +1937,10 @@ static int qeth_peer_func_level(int level)
 	return level;
 }
 
-static void qeth_idx_write_cb(struct qeth_channel *channel,
-		struct qeth_cmd_buffer *iob)
+static void qeth_idx_write_cb(struct qeth_card *card,
+			      struct qeth_channel *channel,
+			      struct qeth_cmd_buffer *iob)
 {
-	struct qeth_card *card;
 	__u16 temp;
 
 	QETH_DBF_TEXT(SETUP , 2, "idxwrcb");
@@ -1940,7 +1949,6 @@ static void qeth_idx_write_cb(struct qeth_channel *channel,
 		channel->state = CH_STATE_ACTIVATING;
 		goto out;
 	}
-	card = CARD_FROM_CDEV(channel->ccwdev);
 
 	if (!(QETH_IS_IDX_ACT_POS_REPLY(iob->data))) {
 		if (QETH_IDX_ACT_CAUSE_CODE(iob->data) == QETH_IDX_ACT_ERR_EXCL)
@@ -1966,10 +1974,10 @@ static void qeth_idx_write_cb(struct qeth_channel *channel,
 	qeth_release_buffer(channel, iob);
 }
 
-static void qeth_idx_read_cb(struct qeth_channel *channel,
-		struct qeth_cmd_buffer *iob)
+static void qeth_idx_read_cb(struct qeth_card *card,
+			     struct qeth_channel *channel,
+			     struct qeth_cmd_buffer *iob)
 {
-	struct qeth_card *card;
 	__u16 temp;
 
 	QETH_DBF_TEXT(SETUP , 2, "idxrdcb");
@@ -1978,7 +1986,6 @@ static void qeth_idx_read_cb(struct qeth_channel *channel,
 		goto out;
 	}
 
-	card = CARD_FROM_CDEV(channel->ccwdev);
 	if (qeth_check_idx_response(card, iob->data))
 			goto out;
 
@@ -2027,7 +2034,7 @@ void qeth_prepare_control_data(struct qeth_card *card, int len,
 		struct qeth_cmd_buffer *iob)
 {
 	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_WRITE, len, iob->data);
-	iob->callback = qeth_release_buffer;
+	iob->callback = qeth_release_buffer_cb;
 
 	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data),
 	       &card->seqno.trans_hdr, QETH_SEQ_NO_LENGTH);
-- 
2.16.4
