Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730364AbfHTOrC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 10:47:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEYZNE003208
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:47:00 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uggw2y0rh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:47:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 15:46:54 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/9] s390/qeth: propagate length of processed cmd IO data to callback
Date: Tue, 20 Aug 2019 16:46:36 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When an cmd IO completes in qeth_irq(), calculate how much data was
processed by the device and pass this value to the cmd's callback.

This allows cmds that retrieve data from the device to check whether
sufficient data was received, so we do that in qeth_read_conf_data_cb().

Suggested-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 40 ++++++++++++++++++++++++-------
 drivers/s390/net/qeth_l2_main.c   |  3 ++-
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 47e01cdd1775..4e21aa8edb13 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -580,7 +580,8 @@ struct qeth_cmd_buffer {
 	long timeout;
 	unsigned char *data;
 	void (*finalize)(struct qeth_card *card, struct qeth_cmd_buffer *iob);
-	void (*callback)(struct qeth_card *card, struct qeth_cmd_buffer *iob);
+	void (*callback)(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+			 unsigned int data_length);
 };
 
 static inline void qeth_get_cmd(struct qeth_cmd_buffer *iob)
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 50f2773a1f8c..f7a8b8301eb4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -63,7 +63,8 @@ static struct device *qeth_core_root_dev;
 static struct lock_class_key qdio_out_skb_queue_key;
 
 static void qeth_issue_next_read_cb(struct qeth_card *card,
-				    struct qeth_cmd_buffer *iob);
+				    struct qeth_cmd_buffer *iob,
+				    unsigned int data_length);
 static void qeth_free_buffer_pool(struct qeth_card *);
 static int qeth_qdio_establish(struct qeth_card *);
 static void qeth_free_qdio_queues(struct qeth_card *card);
@@ -702,7 +703,8 @@ void qeth_put_cmd(struct qeth_cmd_buffer *iob)
 EXPORT_SYMBOL_GPL(qeth_put_cmd);
 
 static void qeth_release_buffer_cb(struct qeth_card *card,
-				   struct qeth_cmd_buffer *iob)
+				   struct qeth_cmd_buffer *iob,
+				   unsigned int data_length)
 {
 	qeth_put_cmd(iob);
 }
@@ -745,7 +747,8 @@ struct qeth_cmd_buffer *qeth_alloc_cmd(struct qeth_channel *channel,
 EXPORT_SYMBOL_GPL(qeth_alloc_cmd);
 
 static void qeth_issue_next_read_cb(struct qeth_card *card,
-				    struct qeth_cmd_buffer *iob)
+				    struct qeth_cmd_buffer *iob,
+				    unsigned int data_length)
 {
 	struct qeth_ipa_cmd *cmd = NULL;
 	struct qeth_reply *reply = NULL;
@@ -1072,8 +1075,16 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		}
 	}
 
-	if (iob && iob->callback)
-		iob->callback(card, iob);
+	if (iob) {
+		/* sanity check: */
+		if (irb->scsw.cmd.count > iob->length) {
+			qeth_cancel_cmd(iob, -EIO);
+			goto out;
+		}
+		if (iob->callback)
+			iob->callback(card, iob,
+				      iob->length - irb->scsw.cmd.count);
+	}
 
 out:
 	wake_up(&card->wait_q);
@@ -1782,12 +1793,20 @@ struct qeth_node_desc {
 };
 
 static void qeth_read_conf_data_cb(struct qeth_card *card,
-				   struct qeth_cmd_buffer *iob)
+				   struct qeth_cmd_buffer *iob,
+				   unsigned int data_length)
 {
 	struct qeth_node_desc *nd = (struct qeth_node_desc *) iob->data;
+	int rc = 0;
 	u8 *tag;
 
 	QETH_CARD_TEXT(card, 2, "cfgunit");
+
+	if (data_length < sizeof(*nd)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	card->info.is_vm_nic = nd->nd1.plant[0] == _ascebc['V'] &&
 			       nd->nd1.plant[1] == _ascebc['M'];
 	tag = (u8 *)&nd->nd1.tag;
@@ -1802,7 +1821,8 @@ static void qeth_read_conf_data_cb(struct qeth_card *card,
 				 nd->nd3.model[2] >= 0xF1 &&
 				 nd->nd3.model[2] <= 0xF4;
 
-	qeth_notify_reply(iob->reply, 0);
+out:
+	qeth_notify_reply(iob->reply, rc);
 	qeth_put_cmd(iob);
 }
 
@@ -1865,7 +1885,8 @@ static int qeth_idx_check_activate_response(struct qeth_card *card,
 }
 
 static void qeth_idx_activate_read_channel_cb(struct qeth_card *card,
-					      struct qeth_cmd_buffer *iob)
+					      struct qeth_cmd_buffer *iob,
+					      unsigned int data_length)
 {
 	struct qeth_channel *channel = iob->channel;
 	u16 peer_level;
@@ -1898,7 +1919,8 @@ static void qeth_idx_activate_read_channel_cb(struct qeth_card *card,
 }
 
 static void qeth_idx_activate_write_channel_cb(struct qeth_card *card,
-					       struct qeth_cmd_buffer *iob)
+					       struct qeth_cmd_buffer *iob,
+					       unsigned int data_length)
 {
 	struct qeth_channel *channel = iob->channel;
 	u16 peer_level;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index cbead3d1b2fd..c524c8bff3c7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1000,7 +1000,8 @@ struct qeth_discipline qeth_l2_discipline = {
 EXPORT_SYMBOL_GPL(qeth_l2_discipline);
 
 static void qeth_osn_assist_cb(struct qeth_card *card,
-			       struct qeth_cmd_buffer *iob)
+			       struct qeth_cmd_buffer *iob,
+			       unsigned int data_length)
 {
 	qeth_notify_reply(iob->reply, 0);
 	qeth_put_cmd(iob);
-- 
2.17.1
