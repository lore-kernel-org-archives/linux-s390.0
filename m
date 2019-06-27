Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40262 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbfF0PEs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 11:04:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RF4WfP114807
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:04:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcy16c42b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:04:43 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Jun 2019 16:01:42 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/12] s390/qeth: streamline SNMP cmd code
Date: Thu, 27 Jun 2019 17:01:29 +0200
In-Reply-To: <20190627150133.58746-1-jwi@linux.ibm.com>
References: <20190627150133.58746-1-jwi@linux.ibm.com>
Message-Id: <20190627150133.58746-9-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Apply some cleanups to qeth_snmp_command() and its callback:
1. when accessing the user data, use the proper struct instead of
   hard-coded offsets. Also copy the request data straight into the
   allocated cmd, skipping the extra memdup_user() to a tmp buffer.
2. capping the request length is no longer needed, the same check gets
   applied at a base level in qeth_alloc_cmd().
3. clean up some duplicated (and misindented) trace statements.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 49 ++++++++++++-------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 3875f70118e4..efb9a27b916e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4320,18 +4320,13 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 		return -ENOSPC;
 	}
 	QETH_CARD_TEXT_(card, 4, "snore%i",
-		       cmd->data.setadapterparms.hdr.used_total);
+			cmd->data.setadapterparms.hdr.used_total);
 	QETH_CARD_TEXT_(card, 4, "sseqn%i",
-		cmd->data.setadapterparms.hdr.seq_no);
+			cmd->data.setadapterparms.hdr.seq_no);
 	/*copy entries to user buffer*/
 	memcpy(qinfo->udata + qinfo->udata_offset, snmp_data, data_len);
 	qinfo->udata_offset += data_len;
 
-	/* check if all replies received ... */
-		QETH_CARD_TEXT_(card, 4, "srtot%i",
-			       cmd->data.setadapterparms.hdr.used_total);
-		QETH_CARD_TEXT_(card, 4, "srseq%i",
-			       cmd->data.setadapterparms.hdr.seq_no);
 	if (cmd->data.setadapterparms.hdr.seq_no <
 	    cmd->data.setadapterparms.hdr.used_total)
 		return 1;
@@ -4340,9 +4335,8 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 
 static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 {
+	struct qeth_snmp_ureq __user *ureq;
 	struct qeth_cmd_buffer *iob;
-	struct qeth_ipa_cmd *cmd;
-	struct qeth_snmp_ureq *ureq;
 	unsigned int req_len;
 	struct qeth_arp_query_info qinfo = {0, };
 	int rc = 0;
@@ -4356,34 +4350,28 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	    IS_LAYER3(card))
 		return -EOPNOTSUPP;
 
-	/* skip 4 bytes (data_len struct member) to get req_len */
-	if (copy_from_user(&req_len, udata + sizeof(int), sizeof(int)))
+	ureq = (struct qeth_snmp_ureq __user *) udata;
+	if (get_user(qinfo.udata_len, &ureq->hdr.data_len) ||
+	    get_user(req_len, &ureq->hdr.req_len))
+		return -EFAULT;
+
+	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
+	if (!iob)
+		return -ENOMEM;
+
+	if (copy_from_user(&__ipa_cmd(iob)->data.setadapterparms.data.snmp,
+			   &ureq->cmd, req_len)) {
+		qeth_put_cmd(iob);
 		return -EFAULT;
-	if (req_len + offsetof(struct qeth_ipacmd_setadpparms, data) +
-	    offsetof(struct qeth_ipa_cmd, data) + IPA_PDU_HEADER_SIZE >
-	    QETH_BUFSIZE)
-		return -EINVAL;
-	ureq = memdup_user(udata, req_len + sizeof(struct qeth_snmp_ureq_hdr));
-	if (IS_ERR(ureq)) {
-		QETH_CARD_TEXT(card, 2, "snmpnome");
-		return PTR_ERR(ureq);
 	}
-	qinfo.udata_len = ureq->hdr.data_len;
+
 	qinfo.udata = kzalloc(qinfo.udata_len, GFP_KERNEL);
 	if (!qinfo.udata) {
-		kfree(ureq);
+		qeth_put_cmd(iob);
 		return -ENOMEM;
 	}
 	qinfo.udata_offset = sizeof(struct qeth_snmp_ureq_hdr);
 
-	iob = qeth_get_adapter_cmd(card, IPA_SETADP_SET_SNMP_CONTROL, req_len);
-	if (!iob) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	cmd = __ipa_cmd(iob);
-	memcpy(&cmd->data.setadapterparms.data.snmp, &ureq->cmd, req_len);
 	rc = qeth_send_ipa_cmd(card, iob, qeth_snmp_command_cb, &qinfo);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "SNMP command failed on device %x: (%#x)\n",
@@ -4392,8 +4380,7 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 		if (copy_to_user(udata, qinfo.udata, qinfo.udata_len))
 			rc = -EFAULT;
 	}
-out:
-	kfree(ureq);
+
 	kfree(qinfo.udata);
 	return rc;
 }
-- 
2.17.1
