Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404770AbfFKQiP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Jun 2019 12:38:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BGRLkd022172
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:14 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2enacfwu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Jun 2019 12:38:13 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 11 Jun 2019 17:38:12 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/13] s390/qeth: add support for dynamically allocated cmds
Date: Tue, 11 Jun 2019 18:37:57 +0200
In-Reply-To: <20190611163800.64730-1-jwi@linux.ibm.com>
References: <20190611163800.64730-1-jwi@linux.ibm.com>
Message-Id: <20190611163800.64730-11-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth currently uses a fixed set of statically allocated cmd buffers for
the read and write IO channels. This (1) doesn't play well with the single
RCD cmd we need to issue on the data channel, (2) doesn't provide the
necessary flexibility for certain IDX improvements, and (3) is also rather
wasteful since the buffers are idle most of the time.

Add a new type of cmd buffer that is dynamically allocated, and keeps
its ccw chain in the DMA data area. Since this touches most callers of
qeth_setup_ccw(), also add a new CCW flags parameter for future usage.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  9 +++++
 drivers/s390/net/qeth_core_main.c | 56 ++++++++++++++++++++++++++-----
 2 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c1292d3420a2..2fee41f773a1 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -560,6 +560,7 @@ enum qeth_prot_versions {
 enum qeth_cmd_buffer_state {
 	BUF_STATE_FREE,
 	BUF_STATE_LOCKED,
+	BUF_STATE_MALLOC,
 };
 
 enum qeth_cq {
@@ -579,6 +580,7 @@ struct qeth_channel;
 
 struct qeth_cmd_buffer {
 	enum qeth_cmd_buffer_state state;
+	unsigned int length;
 	struct qeth_channel *channel;
 	struct qeth_reply *reply;
 	long timeout;
@@ -608,6 +610,13 @@ struct qeth_channel {
 	int io_buf_no;
 };
 
+static inline struct ccw1 *__ccw_from_cmd(struct qeth_cmd_buffer *iob)
+{
+	if (iob->state != BUF_STATE_MALLOC)
+		return iob->channel->ccw;
+	return (struct ccw1 *)(iob->data + ALIGN(iob->length, 8));
+}
+
 static inline bool qeth_trylock_channel(struct qeth_channel *channel)
 {
 	return atomic_cmpxchg(&channel->irq_pending, 0, 1) == 0;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 10f16ddeb71a..e95cfc654ff8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -485,10 +485,11 @@ static inline int qeth_is_cq(struct qeth_card *card, unsigned int queue)
 	    queue == card->qdio.no_in_queues - 1;
 }
 
-static void qeth_setup_ccw(struct ccw1 *ccw, u8 cmd_code, u32 len, void *data)
+static void qeth_setup_ccw(struct ccw1 *ccw, u8 cmd_code, u8 flags, u32 len,
+			   void *data)
 {
 	ccw->cmd_code = cmd_code;
-	ccw->flags = CCW_FLAG_SLI;
+	ccw->flags = flags | CCW_FLAG_SLI;
 	ccw->count = len;
 	ccw->cda = (__u32) __pa(data);
 }
@@ -497,6 +498,7 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 {
 	struct qeth_channel *channel = &card->read;
 	struct qeth_cmd_buffer *iob;
+	struct ccw1 *ccw;
 	int rc;
 
 	QETH_CARD_TEXT(card, 5, "issnxrd");
@@ -511,11 +513,11 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 		return -ENOMEM;
 	}
 
-	qeth_setup_ccw(channel->ccw, CCW_CMD_READ, QETH_BUFSIZE, iob->data);
+	ccw = __ccw_from_cmd(iob);
+	qeth_setup_ccw(ccw, CCW_CMD_READ, 0, QETH_BUFSIZE, iob->data);
 	iob->callback = qeth_issue_next_read_cb;
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
-	rc = ccw_device_start(channel->ccwdev, channel->ccw,
-			      (addr_t) iob, 0, 0);
+	rc = ccw_device_start(channel->ccwdev, ccw, (addr_t) iob, 0, 0);
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "error %i on device %x when starting next read ccw!\n",
 				 rc, CARD_DEVID(card));
@@ -717,6 +719,14 @@ void qeth_release_buffer(struct qeth_cmd_buffer *iob)
 	struct qeth_channel *channel = iob->channel;
 	unsigned long flags;
 
+	if (iob->state == BUF_STATE_MALLOC) {
+		if (iob->reply)
+			qeth_put_reply(iob->reply);
+		kfree(iob->data);
+		kfree(iob);
+		return;
+	}
+
 	spin_lock_irqsave(&channel->iob_lock, flags);
 	iob->state = BUF_STATE_FREE;
 	iob->callback = NULL;
@@ -756,6 +766,33 @@ struct qeth_cmd_buffer *qeth_get_buffer(struct qeth_channel *channel)
 }
 EXPORT_SYMBOL_GPL(qeth_get_buffer);
 
+static struct qeth_cmd_buffer *qeth_alloc_cmd(struct qeth_channel *channel,
+					      unsigned int length,
+					      unsigned int ccws, long timeout)
+{
+	struct qeth_cmd_buffer *iob;
+
+	if (length > QETH_BUFSIZE)
+		return NULL;
+
+	iob = kzalloc(sizeof(*iob), GFP_KERNEL);
+	if (!iob)
+		return NULL;
+
+	iob->data = kzalloc(ALIGN(length, 8) + ccws * sizeof(struct ccw1),
+			    GFP_KERNEL | GFP_DMA);
+	if (!iob->data) {
+		kfree(iob);
+		return NULL;
+	}
+
+	iob->state = BUF_STATE_MALLOC;
+	iob->channel = channel;
+	iob->timeout = timeout;
+	iob->length = length;
+	return iob;
+}
+
 void qeth_clear_cmd_buffers(struct qeth_channel *channel)
 {
 	int cnt;
@@ -1587,7 +1624,7 @@ static int qeth_read_conf_data(struct qeth_card *card, void **buffer,
 	if (!rcd_buf)
 		return -ENOMEM;
 
-	qeth_setup_ccw(channel->ccw, ciw->cmd, ciw->count, rcd_buf);
+	qeth_setup_ccw(channel->ccw, ciw->cmd, 0, ciw->count, rcd_buf);
 	channel->state = CH_STATE_RCD;
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	ret = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
@@ -1749,7 +1786,8 @@ static void qeth_idx_finalize_cmd(struct qeth_card *card,
 				  struct qeth_cmd_buffer *iob,
 				  unsigned int length)
 {
-	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_WRITE, length, iob->data);
+	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_WRITE, 0, length,
+		       iob->data);
 
 	memcpy(QETH_TRANSPORT_HEADER_SEQ_NO(iob->data), &card->seqno.trans_hdr,
 	       QETH_SEQ_NO_LENGTH);
@@ -1857,7 +1895,7 @@ static int qeth_send_control_data(struct qeth_card *card, int len,
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
-	rc = ccw_device_start_timeout(channel->ccwdev, channel->ccw,
+	rc = ccw_device_start_timeout(channel->ccwdev, __ccw_from_cmd(iob),
 				      (addr_t) iob, 0, 0, timeout);
 	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (rc) {
@@ -1982,7 +2020,7 @@ static void qeth_idx_finalize_query_cmd(struct qeth_card *card,
 					struct qeth_cmd_buffer *iob,
 					unsigned int length)
 {
-	qeth_setup_ccw(iob->channel->ccw, CCW_CMD_READ, length, iob->data);
+	qeth_setup_ccw(__ccw_from_cmd(iob), CCW_CMD_READ, 0, length, iob->data);
 }
 
 static void qeth_idx_activate_cb(struct qeth_card *card,
-- 
2.17.1
