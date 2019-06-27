Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbfF0PBp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 11:01:45 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5REwGSY046052
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:01:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tcy7xb0a5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 11:01:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Thu, 27 Jun 2019 16:01:40 +0100
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/12] s390/qeth: dynamically allocate vnicc cmds
Date: Thu, 27 Jun 2019 17:01:26 +0200
In-Reply-To: <20190627150133.58746-1-jwi@linux.ibm.com>
References: <20190627150133.58746-1-jwi@linux.ibm.com>
Message-Id: <20190627150133.58746-6-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The VNICC code is somewhat quirky in that it defers the whole cmd setup
to a common helper qeth_l2_vnicc_request(). Some of the cmd specifics
are then passed in via parameter, while others are simply hard-coded.

Split the whole machinery up into the usual format: one helper that
allocates the cmd & fills in the common fields, while all the cmd
originators take care of their sub-cmd type specific work.
This makes it much easier to calculate the cmd's precise length, and
reduces code complexity.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_core_mpc.h |  13 ++--
 drivers/s390/net/qeth_l2_main.c  | 123 ++++++++++++++-----------------
 2 files changed, 62 insertions(+), 74 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 5cec877d972f..75b5834ed28d 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -630,12 +630,6 @@ struct qeth_ipacmd_diagass {
 
 /* VNICC header */
 struct qeth_ipacmd_vnicc_hdr {
-	u32 sup;
-	u32 cur;
-};
-
-/* VNICC sub command header */
-struct qeth_vnicc_sub_hdr {
 	u16 data_length;
 	u16 reserved;
 	u32 sub_command;
@@ -660,15 +654,18 @@ struct qeth_vnicc_getset_timeout {
 
 /* complete VNICC IPA command message */
 struct qeth_ipacmd_vnicc {
+	struct qeth_ipa_caps vnicc_cmds;
 	struct qeth_ipacmd_vnicc_hdr hdr;
-	struct qeth_vnicc_sub_hdr sub_hdr;
 	union {
 		struct qeth_vnicc_query_cmds query_cmds;
 		struct qeth_vnicc_set_char set_char;
 		struct qeth_vnicc_getset_timeout getset_timeout;
-	};
+	} data;
 };
 
+#define VNICC_DATA_SIZEOF(field)	FIELD_SIZEOF(struct qeth_ipacmd_vnicc,\
+						     data.field)
+
 /* SETBRIDGEPORT IPA Command:	 *********************************************/
 enum qeth_ipa_sbp_cmd {
 	IPA_SBP_QUERY_COMMANDS_SUPPORTED	= 0x00000000L,
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f762d22a3272..68c6f4080745 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1735,10 +1735,6 @@ static int qeth_l2_vnicc_makerc(struct qeth_card *card, u16 ipa_rc)
 /* generic VNICC request call back control */
 struct _qeth_l2_vnicc_request_cbctl {
 	u32 sub_cmd;
-	struct {
-		u32 vnic_char;
-		u32 timeout;
-	} param;
 	struct {
 		union{
 			u32 *sup_cmds;
@@ -1761,80 +1757,52 @@ static int qeth_l2_vnicc_request_cb(struct qeth_card *card,
 	if (cmd->hdr.return_code)
 		return qeth_l2_vnicc_makerc(card, cmd->hdr.return_code);
 	/* return results to caller */
-	card->options.vnicc.sup_chars = rep->hdr.sup;
-	card->options.vnicc.cur_chars = rep->hdr.cur;
+	card->options.vnicc.sup_chars = rep->vnicc_cmds.supported;
+	card->options.vnicc.cur_chars = rep->vnicc_cmds.enabled;
 
 	if (cbctl->sub_cmd == IPA_VNICC_QUERY_CMDS)
-		*cbctl->result.sup_cmds = rep->query_cmds.sup_cmds;
+		*cbctl->result.sup_cmds = rep->data.query_cmds.sup_cmds;
 
 	if (cbctl->sub_cmd == IPA_VNICC_GET_TIMEOUT)
-		*cbctl->result.timeout = rep->getset_timeout.timeout;
+		*cbctl->result.timeout = rep->data.getset_timeout.timeout;
 
 	return 0;
 }
 
-/* generic VNICC request */
-static int qeth_l2_vnicc_request(struct qeth_card *card,
-				 struct _qeth_l2_vnicc_request_cbctl *cbctl)
+static struct qeth_cmd_buffer *qeth_l2_vnicc_build_cmd(struct qeth_card *card,
+						       u32 vnicc_cmd,
+						       unsigned int data_length)
 {
-	struct qeth_ipacmd_vnicc *req;
+	struct qeth_ipacmd_vnicc_hdr *hdr;
 	struct qeth_cmd_buffer *iob;
-	struct qeth_ipa_cmd *cmd;
-
-	QETH_CARD_TEXT(card, 2, "vniccreq");
 
-	/* get new buffer for request */
-	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_VNICC, 0);
+	iob = qeth_ipa_alloc_cmd(card, IPA_CMD_VNICC, QETH_PROT_NONE,
+				 data_length +
+				 offsetof(struct qeth_ipacmd_vnicc, data));
 	if (!iob)
-		return -ENOMEM;
-
-	/* create header for request */
-	cmd = __ipa_cmd(iob);
-	req = &cmd->data.vnicc;
-
-	/* create sub command header for request */
-	req->sub_hdr.data_length = sizeof(req->sub_hdr);
-	req->sub_hdr.sub_command = cbctl->sub_cmd;
-
-	/* create sub command specific request fields */
-	switch (cbctl->sub_cmd) {
-	case IPA_VNICC_QUERY_CHARS:
-		break;
-	case IPA_VNICC_QUERY_CMDS:
-		req->sub_hdr.data_length += sizeof(req->query_cmds);
-		req->query_cmds.vnic_char = cbctl->param.vnic_char;
-		break;
-	case IPA_VNICC_ENABLE:
-	case IPA_VNICC_DISABLE:
-		req->sub_hdr.data_length += sizeof(req->set_char);
-		req->set_char.vnic_char = cbctl->param.vnic_char;
-		break;
-	case IPA_VNICC_SET_TIMEOUT:
-		req->getset_timeout.timeout = cbctl->param.timeout;
-		/* fallthrough */
-	case IPA_VNICC_GET_TIMEOUT:
-		req->sub_hdr.data_length += sizeof(req->getset_timeout);
-		req->getset_timeout.vnic_char = cbctl->param.vnic_char;
-		break;
-	default:
-		qeth_release_buffer(iob);
-		return -EOPNOTSUPP;
-	}
+		return NULL;
 
-	/* send request */
-	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, cbctl);
+	hdr = &__ipa_cmd(iob)->data.vnicc.hdr;
+	hdr->data_length = sizeof(*hdr) + data_length;
+	hdr->sub_command = vnicc_cmd;
+	return iob;
 }
 
 /* VNICC query VNIC characteristics request */
 static int qeth_l2_vnicc_query_chars(struct qeth_card *card)
 {
 	struct _qeth_l2_vnicc_request_cbctl cbctl;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_CARD_TEXT(card, 2, "vniccqch");
+	iob = qeth_l2_vnicc_build_cmd(card, IPA_VNICC_QUERY_CHARS, 0);
+	if (!iob)
+		return -ENOMEM;
 
 	/* prepare callback control */
 	cbctl.sub_cmd = IPA_VNICC_QUERY_CHARS;
 
-	QETH_CARD_TEXT(card, 2, "vniccqch");
-	return qeth_l2_vnicc_request(card, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
 }
 
 /* VNICC query sub commands request */
@@ -1842,14 +1810,21 @@ static int qeth_l2_vnicc_query_cmds(struct qeth_card *card, u32 vnic_char,
 				    u32 *sup_cmds)
 {
 	struct _qeth_l2_vnicc_request_cbctl cbctl;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_CARD_TEXT(card, 2, "vniccqcm");
+	iob = qeth_l2_vnicc_build_cmd(card, IPA_VNICC_QUERY_CMDS,
+				      VNICC_DATA_SIZEOF(query_cmds));
+	if (!iob)
+		return -ENOMEM;
+
+	__ipa_cmd(iob)->data.vnicc.data.query_cmds.vnic_char = vnic_char;
 
 	/* prepare callback control */
 	cbctl.sub_cmd = IPA_VNICC_QUERY_CMDS;
-	cbctl.param.vnic_char = vnic_char;
 	cbctl.result.sup_cmds = sup_cmds;
 
-	QETH_CARD_TEXT(card, 2, "vniccqcm");
-	return qeth_l2_vnicc_request(card, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
 }
 
 /* VNICC enable/disable characteristic request */
@@ -1857,31 +1832,47 @@ static int qeth_l2_vnicc_set_char(struct qeth_card *card, u32 vnic_char,
 				      u32 cmd)
 {
 	struct _qeth_l2_vnicc_request_cbctl cbctl;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_CARD_TEXT(card, 2, "vniccedc");
+	iob = qeth_l2_vnicc_build_cmd(card, cmd, VNICC_DATA_SIZEOF(set_char));
+	if (!iob)
+		return -ENOMEM;
+
+	__ipa_cmd(iob)->data.vnicc.data.set_char.vnic_char = vnic_char;
 
 	/* prepare callback control */
 	cbctl.sub_cmd = cmd;
-	cbctl.param.vnic_char = vnic_char;
 
-	QETH_CARD_TEXT(card, 2, "vniccedc");
-	return qeth_l2_vnicc_request(card, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
 }
 
 /* VNICC get/set timeout for characteristic request */
 static int qeth_l2_vnicc_getset_timeout(struct qeth_card *card, u32 vnicc,
 					u32 cmd, u32 *timeout)
 {
+	struct qeth_vnicc_getset_timeout *getset_timeout;
 	struct _qeth_l2_vnicc_request_cbctl cbctl;
+	struct qeth_cmd_buffer *iob;
+
+	QETH_CARD_TEXT(card, 2, "vniccgst");
+	iob = qeth_l2_vnicc_build_cmd(card, cmd,
+				      VNICC_DATA_SIZEOF(getset_timeout));
+	if (!iob)
+		return -ENOMEM;
+
+	getset_timeout = &__ipa_cmd(iob)->data.vnicc.data.getset_timeout;
+	getset_timeout->vnic_char = vnicc;
+
+	if (cmd == IPA_VNICC_SET_TIMEOUT)
+		getset_timeout->timeout = *timeout;
 
 	/* prepare callback control */
 	cbctl.sub_cmd = cmd;
-	cbctl.param.vnic_char = vnicc;
-	if (cmd == IPA_VNICC_SET_TIMEOUT)
-		cbctl.param.timeout = *timeout;
 	if (cmd == IPA_VNICC_GET_TIMEOUT)
 		cbctl.result.timeout = timeout;
 
-	QETH_CARD_TEXT(card, 2, "vniccgst");
-	return qeth_l2_vnicc_request(card, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
 }
 
 /* set current VNICC flag state; called from sysfs store function */
-- 
2.17.1
