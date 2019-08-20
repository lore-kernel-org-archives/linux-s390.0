Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729810AbfHTOq5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 10:46:57 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEdcOO046800
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:56 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugjtsgcfc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:56 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 15:46:53 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/9] s390/qeth: use node_descriptor struct
Date: Tue, 20 Aug 2019 16:46:35 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-2-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Rather than fumbling with hard-coded offsets, use the proper struct to
access the retrieved RCD information.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 31 +++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 28db887d38ed..47e01cdd1775 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -651,7 +651,7 @@ struct qeth_card_blkt {
 struct qeth_card_info {
 	unsigned short unit_addr2;
 	unsigned short cula;
-	unsigned short chpid;
+	u8 chpid;
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
 	u8 open_when_online:1;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 0803070246aa..50f2773a1f8c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1775,19 +1775,32 @@ static int qeth_send_control_data(struct qeth_card *card,
 	return rc;
 }
 
+struct qeth_node_desc {
+	struct node_descriptor nd1;
+	struct node_descriptor nd2;
+	struct node_descriptor nd3;
+};
+
 static void qeth_read_conf_data_cb(struct qeth_card *card,
 				   struct qeth_cmd_buffer *iob)
 {
-	unsigned char *prcd = iob->data;
+	struct qeth_node_desc *nd = (struct qeth_node_desc *) iob->data;
+	u8 *tag;
 
 	QETH_CARD_TEXT(card, 2, "cfgunit");
-	card->info.chpid = prcd[30];
-	card->info.unit_addr2 = prcd[31];
-	card->info.cula = prcd[63];
-	card->info.is_vm_nic = ((prcd[0x10] == _ascebc['V']) &&
-				(prcd[0x11] == _ascebc['M']));
-	card->info.use_v1_blkt = prcd[74] == 0xF0 && prcd[75] == 0xF0 &&
-				 prcd[76] >= 0xF1 && prcd[76] <= 0xF4;
+	card->info.is_vm_nic = nd->nd1.plant[0] == _ascebc['V'] &&
+			       nd->nd1.plant[1] == _ascebc['M'];
+	tag = (u8 *)&nd->nd1.tag;
+	card->info.chpid = tag[0];
+	card->info.unit_addr2 = tag[1];
+
+	tag = (u8 *)&nd->nd2.tag;
+	card->info.cula = tag[1];
+
+	card->info.use_v1_blkt = nd->nd3.model[0] == 0xF0 &&
+				 nd->nd3.model[1] == 0xF0 &&
+				 nd->nd3.model[2] >= 0xF1 &&
+				 nd->nd3.model[2] <= 0xF4;
 
 	qeth_notify_reply(iob->reply, 0);
 	qeth_put_cmd(iob);
@@ -1803,6 +1816,8 @@ static int qeth_read_conf_data(struct qeth_card *card)
 	ciw = ccw_device_get_ciw(channel->ccwdev, CIW_TYPE_RCD);
 	if (!ciw || ciw->cmd == 0)
 		return -EOPNOTSUPP;
+	if (ciw->count < sizeof(struct qeth_node_desc))
+		return -EINVAL;
 
 	iob = qeth_alloc_cmd(channel, ciw->count, 1, QETH_RCD_TIMEOUT);
 	if (!iob)
-- 
2.17.1
