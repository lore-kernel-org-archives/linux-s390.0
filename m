Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7822 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730234AbfHTOq6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 10:46:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KEXmYc098192
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ugh7f60uf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 20 Aug 2019 10:46:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Tue, 20 Aug 2019 15:46:55 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/9] s390/qeth: use correct length field in SNMP cmd callback
Date: Tue, 20 Aug 2019 16:46:37 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-4-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

qeth_snmp_command_cb() is the only cmd callback that pulls the reply's
data length from a low-level transport header field. This requires
additional complexity (ie. reply->offset) to make the header accessible
to what is supposed to be a pure IPA cmd callback.

Adapter cmds have a length field in their sub-cmd header, get the data
length from there instead.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 42 ++++++++++++-------------------
 2 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 4e21aa8edb13..f6e58a51c366 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -634,7 +634,6 @@ struct qeth_reply {
 	int (*callback)(struct qeth_card *, struct qeth_reply *,
 		unsigned long);
 	u32 seqno;
-	unsigned long offset;
 	int rc;
 	void *param;
 	refcount_t refcnt;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f7a8b8301eb4..49e85d2e79c2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -807,17 +807,12 @@ static void qeth_issue_next_read_cb(struct qeth_card *card,
 	}
 
 	spin_lock_irqsave(&reply->lock, flags);
-	if (reply->rc) {
+	if (reply->rc)
 		/* Bail out when the requestor has already left: */
 		rc = reply->rc;
-	} else {
-		if (cmd) {
-			reply->offset = (u16)((char *)cmd - (char *)iob->data);
-			rc = reply->callback(card, reply, (unsigned long)cmd);
-		} else {
-			rc = reply->callback(card, reply, (unsigned long)iob);
-		}
-	}
+	else
+		rc = reply->callback(card, reply, cmd ? (unsigned long)cmd :
+							(unsigned long)iob);
 	spin_unlock_irqrestore(&reply->lock, flags);
 
 no_callback:
@@ -4335,20 +4330,16 @@ static int qeth_mdio_read(struct net_device *dev, int phy_id, int regnum)
 }
 
 static int qeth_snmp_command_cb(struct qeth_card *card,
-		struct qeth_reply *reply, unsigned long sdata)
+				struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
-	struct qeth_arp_query_info *qinfo;
-	unsigned char *data;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+	struct qeth_arp_query_info *qinfo = reply->param;
+	struct qeth_ipacmd_setadpparms *adp_cmd;
+	unsigned int data_len;
 	void *snmp_data;
-	__u16 data_len;
 
 	QETH_CARD_TEXT(card, 3, "snpcmdcb");
 
-	cmd = (struct qeth_ipa_cmd *) sdata;
-	data = (unsigned char *)((char *)cmd - reply->offset);
-	qinfo = (struct qeth_arp_query_info *) reply->param;
-
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%x", cmd->hdr.return_code);
 		return -EIO;
@@ -4359,15 +4350,14 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 		QETH_CARD_TEXT_(card, 4, "scer2%x", cmd->hdr.return_code);
 		return -EIO;
 	}
-	data_len = *((__u16 *)QETH_IPA_PDU_LEN_PDU1(data));
-	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
-		snmp_data = &cmd->data.setadapterparms.data.snmp;
-		data_len -= offsetof(struct qeth_ipa_cmd,
-				     data.setadapterparms.data.snmp);
+
+	adp_cmd = &cmd->data.setadapterparms;
+	data_len = adp_cmd->hdr.cmdlength - sizeof(adp_cmd->hdr);
+	if (adp_cmd->hdr.seq_no == 1) {
+		snmp_data = &adp_cmd->data.snmp;
 	} else {
-		snmp_data = &cmd->data.setadapterparms.data.snmp.request;
-		data_len -= offsetof(struct qeth_ipa_cmd,
-				     data.setadapterparms.data.snmp.request);
+		snmp_data = &adp_cmd->data.snmp.request;
+		data_len -= offsetof(struct qeth_snmp_cmd, request);
 	}
 
 	/* check if there is enough room in userspace */
-- 
2.17.1
