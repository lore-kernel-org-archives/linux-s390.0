Return-Path: <SRS0=K6TM=R7=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 06/10] s390/qeth: don't poll for cmd IO completion
Date: Thu, 28 Mar 2019 16:39:24 +0100
In-Reply-To: <20190328153928.87692-1-jwi@linux.ibm.com>
References: <20190328153928.87692-1-jwi@linux.ibm.com>
Message-Id: <20190328153928.87692-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

All callers are running in process context now, so we can safely sleep
in qeth_send_control_data() while waiting for a cmd to complete.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 11 +++++--
 drivers/s390/net/qeth_core_main.c | 60 ++++++++++++++++-----------------------
 drivers/s390/net/qeth_l2_main.c   |  5 ++--
 3 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 7dbc386fb834..30772d4abcbc 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -10,6 +10,7 @@
 #ifndef __QETH_CORE_H__
 #define __QETH_CORE_H__
 
+#include <linux/completion.h>
 #include <linux/if.h>
 #include <linux/if_arp.h>
 #include <linux/etherdevice.h>
@@ -21,6 +22,7 @@
 #include <linux/hashtable.h>
 #include <linux/ip.h>
 #include <linux/refcount.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 #include <net/ipv6.h>
@@ -585,6 +587,7 @@ struct qeth_cmd_buffer {
 	enum qeth_cmd_buffer_state state;
 	struct qeth_channel *channel;
 	struct qeth_reply *reply;
+	long timeout;
 	unsigned char *data;
 	void (*callback)(struct qeth_card *card, struct qeth_channel *channel,
 			 struct qeth_cmd_buffer *iob);
@@ -610,6 +613,11 @@ struct qeth_channel {
 	int io_buf_no;
 };
 
+static inline bool qeth_trylock_channel(struct qeth_channel *channel)
+{
+	return atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0;
+}
+
 /**
  *  OSA card related definitions
  */
@@ -636,12 +644,11 @@ struct qeth_seqno {
 
 struct qeth_reply {
 	struct list_head list;
-	wait_queue_head_t wait_q;
+	struct completion received;
 	int (*callback)(struct qeth_card *, struct qeth_reply *,
 		unsigned long);
 	u32 seqno;
 	unsigned long offset;
-	atomic_t received;
 	int rc;
 	void *param;
 	refcount_t refcnt;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b12c7c6deeab..b6c9861108ce 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -542,11 +542,10 @@ static struct qeth_reply *qeth_alloc_reply(struct qeth_card *card)
 {
 	struct qeth_reply *reply;
 
-	reply = kzalloc(sizeof(struct qeth_reply), GFP_ATOMIC);
+	reply = kzalloc(sizeof(*reply), GFP_KERNEL);
 	if (reply) {
 		refcount_set(&reply->refcnt, 1);
-		atomic_set(&reply->received, 0);
-		init_waitqueue_head(&reply->wait_q);
+		init_completion(&reply->received);
 	}
 	return reply;
 }
@@ -578,8 +577,7 @@ static void qeth_dequeue_reply(struct qeth_card *card, struct qeth_reply *reply)
 
 static void qeth_notify_reply(struct qeth_reply *reply)
 {
-	atomic_inc(&reply->received);
-	wake_up(&reply->wait_q);
+	complete(&reply->received);
 }
 
 static void qeth_issue_ipa_msg(struct qeth_ipa_cmd *cmd, int rc,
@@ -704,6 +702,7 @@ static struct qeth_cmd_buffer *__qeth_get_buffer(struct qeth_channel *channel)
 	do {
 		if (channel->iob[index].state == BUF_STATE_FREE) {
 			channel->iob[index].state = BUF_STATE_LOCKED;
+			channel->iob[index].timeout = QETH_TIMEOUT;
 			channel->io_buf_no = (channel->io_buf_no + 1) %
 				QETH_CMD_BUFFER_NO;
 			memset(channel->iob[index].data, 0, QETH_BUFSIZE);
@@ -1786,8 +1785,7 @@ static int qeth_idx_activate_get_answer(struct qeth_card *card,
 	iob->callback = reply_cb;
 	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
 
-	wait_event(card->wait_q,
-		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
+	wait_event(card->wait_q, qeth_trylock_channel(channel));
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
@@ -1855,8 +1853,7 @@ static int qeth_idx_activate_channel(struct qeth_card *card,
 	temp = (card->info.cula << 8) + card->info.unit_addr2;
 	memcpy(QETH_IDX_ACT_QDIO_DEV_REALADDR(iob->data), &temp, 2);
 
-	wait_event(card->wait_q,
-		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
+	wait_event(card->wait_q, qeth_trylock_channel(channel));
 	QETH_DBF_TEXT(SETUP, 6, "noirqpnd");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
@@ -2034,9 +2031,9 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 				  void *reply_param)
 {
 	struct qeth_channel *channel = iob->channel;
+	long timeout = iob->timeout;
 	int rc;
 	struct qeth_reply *reply = NULL;
-	unsigned long timeout, event_timeout;
 	struct qeth_ipa_cmd *cmd = NULL;
 
 	QETH_CARD_TEXT(card, 2, "sendctl");
@@ -2057,27 +2054,30 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 	qeth_get_reply(reply);
 	iob->reply = reply;
 
-	while (atomic_cmpxchg(&channel->irq_pending, 0, 1)) ;
+	timeout = wait_event_interruptible_timeout(card->wait_q,
+						   qeth_trylock_channel(channel),
+						   timeout);
+	if (timeout <= 0) {
+		qeth_put_reply(reply);
+		qeth_release_buffer(channel, iob);
+		return (timeout == -ERESTARTSYS) ? -EINTR : -ETIME;
+	}
 
 	if (IS_IPA(iob->data)) {
 		cmd = __ipa_cmd(iob);
 		cmd->hdr.seqno = card->seqno.ipa++;
 		reply->seqno = cmd->hdr.seqno;
-		event_timeout = QETH_IPA_TIMEOUT;
 	} else {
 		reply->seqno = QETH_IDX_COMMAND_SEQNO;
-		event_timeout = QETH_TIMEOUT;
 	}
 	qeth_prepare_control_data(card, len, iob);
 
 	qeth_enqueue_reply(card, reply);
 
-	timeout = jiffies + event_timeout;
-
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
-				      (addr_t) iob, 0, 0, event_timeout);
+				      (addr_t) iob, 0, 0, timeout);
 	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "qeth_send_control_data on device %x: ccw_device_start rc = %i\n",
@@ -2091,30 +2091,16 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 		return rc;
 	}
 
-	/* we have only one long running ipassist, since we can ensure
-	   process context of this command we can sleep */
-	if (cmd && cmd->hdr.command == IPA_CMD_SETIP &&
-	    cmd->hdr.prot_version == QETH_PROT_IPV4) {
-		if (!wait_event_timeout(reply->wait_q,
-		    atomic_read(&reply->received), event_timeout))
-			goto time_err;
-	} else {
-		while (!atomic_read(&reply->received)) {
-			if (time_after(jiffies, timeout))
-				goto time_err;
-			cpu_relax();
-		}
-	}
+	timeout = wait_for_completion_interruptible_timeout(&reply->received,
+							    timeout);
+	if (timeout <= 0)
+		rc = (timeout == -ERESTARTSYS) ? -EINTR : -ETIME;
 
 	qeth_dequeue_reply(card, reply);
-	rc = reply->rc;
+	if (!rc)
+		rc = reply->rc;
 	qeth_put_reply(reply);
 	return rc;
-
-time_err:
-	qeth_dequeue_reply(card, reply);
-	qeth_put_reply(reply);
-	return -ETIME;
 }
 
 static int qeth_cm_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
@@ -2810,6 +2796,8 @@ void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 	u16 total_length = IPA_PDU_HEADER_SIZE + cmd_length;
 	u8 prot_type = qeth_mpc_select_prot_type(card);
 
+	iob->timeout = QETH_IPA_TIMEOUT;
+
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
 	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &total_length, 2);
 	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data), &prot_type, 1);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 918c3e2e2c3d..e2b09472c482 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1050,13 +1050,12 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 
 	QETH_CARD_TEXT(card, 5, "osndctrd");
 
-	wait_event(card->wait_q,
-		   atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0);
+	wait_event(card->wait_q, qeth_trylock_channel(channel));
 	qeth_prepare_control_data(card, len, iob);
 	QETH_CARD_TEXT(card, 6, "osnoirqp");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
-				      (addr_t) iob, 0, 0, QETH_IPA_TIMEOUT);
+				      (addr_t) iob, 0, 0, iob->timeout);
 	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "qeth_osn_send_control_data: "
-- 
2.16.4
