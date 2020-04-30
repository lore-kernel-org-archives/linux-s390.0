Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbgD3N4L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:11 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 02/14] net/smc: enqueue all received LLC messages
Date: Thu, 30 Apr 2020 15:55:39 +0200
Message-Id: <20200430135551.26267-3-kgraul@linux.ibm.com>
In-Reply-To: <20200430135551.26267-1-kgraul@linux.ibm.com>
References: <20200430135551.26267-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

Introduce smc_llc_enqueue() to enqueue LLC messages, and adapt
smc_llc_rx_handler() to enqueue all received LLC messages.
smc_llc_enqueue() also makes it possible to enqueue LLC messages from
local code.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_llc.c | 46 +++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 647cf1a2dfa5..a146b3b43580 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -719,11 +719,14 @@ static void smc_llc_event_work(struct work_struct *work)
 }
 
 /* process llc responses in tasklet context */
-static void smc_llc_rx_response(struct smc_link *link, union smc_llc_msg *llc)
+static void smc_llc_rx_response(struct smc_link *link,
+				struct smc_llc_qentry *qentry)
 {
+	u8 llc_type = qentry->msg.raw.hdr.common.type;
+	union smc_llc_msg *llc = &qentry->msg;
 	int rc = 0;
 
-	switch (llc->raw.hdr.common.type) {
+	switch (llc_type) {
 	case SMC_LLC_TEST_LINK:
 		if (link->state == SMC_LNK_ACTIVE)
 			complete(&link->llc_testlink_resp);
@@ -759,40 +762,49 @@ static void smc_llc_rx_response(struct smc_link *link, union smc_llc_msg *llc)
 		complete(&link->llc_delete_rkey_resp);
 		break;
 	}
+	kfree(qentry);
 }
 
-/* copy received msg and add it to the event queue */
-static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
+static void smc_llc_enqueue(struct smc_link *link, union smc_llc_msg *llc)
 {
-	struct smc_link *link = (struct smc_link *)wc->qp->qp_context;
 	struct smc_link_group *lgr = link->lgr;
 	struct smc_llc_qentry *qentry;
-	union smc_llc_msg *llc = buf;
 	unsigned long flags;
 
-	if (wc->byte_len < sizeof(*llc))
-		return; /* short message */
-	if (llc->raw.hdr.length != sizeof(*llc))
-		return; /* invalid message */
-
-	/* process responses immediately */
-	if (llc->raw.hdr.flags & SMC_LLC_FLAG_RESP) {
-		smc_llc_rx_response(link, llc);
-		return;
-	}
-
 	qentry = kmalloc(sizeof(*qentry), GFP_ATOMIC);
 	if (!qentry)
 		return;
 	qentry->link = link;
 	INIT_LIST_HEAD(&qentry->list);
 	memcpy(&qentry->msg, llc, sizeof(union smc_llc_msg));
+
+	/* process responses immediately */
+	if (llc->raw.hdr.flags & SMC_LLC_FLAG_RESP) {
+		smc_llc_rx_response(link, qentry);
+		return;
+	}
+
+	/* add requests to event queue */
 	spin_lock_irqsave(&lgr->llc_event_q_lock, flags);
 	list_add_tail(&qentry->list, &lgr->llc_event_q);
 	spin_unlock_irqrestore(&lgr->llc_event_q_lock, flags);
 	schedule_work(&link->lgr->llc_event_work);
 }
 
+/* copy received msg and add it to the event queue */
+static void smc_llc_rx_handler(struct ib_wc *wc, void *buf)
+{
+	struct smc_link *link = (struct smc_link *)wc->qp->qp_context;
+	union smc_llc_msg *llc = buf;
+
+	if (wc->byte_len < sizeof(*llc))
+		return; /* short message */
+	if (llc->raw.hdr.length != sizeof(*llc))
+		return; /* invalid message */
+
+	smc_llc_enqueue(link, llc);
+}
+
 /***************************** worker, utils *********************************/
 
 static void smc_llc_testlink_work(struct work_struct *work)
-- 
2.17.1
