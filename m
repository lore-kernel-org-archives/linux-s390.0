Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726034AbgCFINZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Mar 2020 03:13:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02689rsS126489
        for <linux-s390@vger.kernel.org>; Fri, 6 Mar 2020 03:13:24 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jps74x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 06 Mar 2020 03:13:24 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <jwi@linux.ibm.com>;
        Fri, 6 Mar 2020 08:13:21 -0000
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/2] s390/qeth: remove VNICC callback parameter struct
Date: Fri,  6 Mar 2020 09:13:11 +0100
In-Reply-To: <20200306081311.50635-1-jwi@linux.ibm.com>
References: <20200306081311.50635-1-jwi@linux.ibm.com>
Message-Id: <20200306081311.50635-3-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

After recent cleanups this is just a complicated wrapper around an u32*.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 29 ++++-------------------------
 1 file changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 9972d96820f3..0bf5e7133229 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1567,23 +1567,11 @@ static int qeth_l2_vnicc_makerc(struct qeth_card *card, u16 ipa_rc)
 	return rc;
 }
 
-/* generic VNICC request call back control */
-struct _qeth_l2_vnicc_request_cbctl {
-	struct {
-		union{
-			u32 *sup_cmds;
-			u32 *timeout;
-		};
-	} result;
-};
-
 /* generic VNICC request call back */
 static int qeth_l2_vnicc_request_cb(struct qeth_card *card,
 				    struct qeth_reply *reply,
 				    unsigned long data)
 {
-	struct _qeth_l2_vnicc_request_cbctl *cbctl =
-		(struct _qeth_l2_vnicc_request_cbctl *) reply->param;
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_ipacmd_vnicc *rep = &cmd->data.vnicc;
 	u32 sub_cmd = cmd->data.vnicc.hdr.sub_command;
@@ -1596,9 +1584,9 @@ static int qeth_l2_vnicc_request_cb(struct qeth_card *card,
 	card->options.vnicc.cur_chars = rep->vnicc_cmds.enabled;
 
 	if (sub_cmd == IPA_VNICC_QUERY_CMDS)
-		*cbctl->result.sup_cmds = rep->data.query_cmds.sup_cmds;
+		*(u32 *)reply->param = rep->data.query_cmds.sup_cmds;
 	else if (sub_cmd == IPA_VNICC_GET_TIMEOUT)
-		*cbctl->result.timeout = rep->data.getset_timeout.timeout;
+		*(u32 *)reply->param = rep->data.getset_timeout.timeout;
 
 	return 0;
 }
@@ -1639,7 +1627,6 @@ static int qeth_l2_vnicc_query_chars(struct qeth_card *card)
 static int qeth_l2_vnicc_query_cmds(struct qeth_card *card, u32 vnic_char,
 				    u32 *sup_cmds)
 {
-	struct _qeth_l2_vnicc_request_cbctl cbctl;
 	struct qeth_cmd_buffer *iob;
 
 	QETH_CARD_TEXT(card, 2, "vniccqcm");
@@ -1650,10 +1637,7 @@ static int qeth_l2_vnicc_query_cmds(struct qeth_card *card, u32 vnic_char,
 
 	__ipa_cmd(iob)->data.vnicc.data.query_cmds.vnic_char = vnic_char;
 
-	/* prepare callback control */
-	cbctl.result.sup_cmds = sup_cmds;
-
-	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, sup_cmds);
 }
 
 /* VNICC enable/disable characteristic request */
@@ -1677,7 +1661,6 @@ static int qeth_l2_vnicc_getset_timeout(struct qeth_card *card, u32 vnicc,
 					u32 cmd, u32 *timeout)
 {
 	struct qeth_vnicc_getset_timeout *getset_timeout;
-	struct _qeth_l2_vnicc_request_cbctl cbctl;
 	struct qeth_cmd_buffer *iob;
 
 	QETH_CARD_TEXT(card, 2, "vniccgst");
@@ -1692,11 +1675,7 @@ static int qeth_l2_vnicc_getset_timeout(struct qeth_card *card, u32 vnicc,
 	if (cmd == IPA_VNICC_SET_TIMEOUT)
 		getset_timeout->timeout = *timeout;
 
-	/* prepare callback control */
-	if (cmd == IPA_VNICC_GET_TIMEOUT)
-		cbctl.result.timeout = timeout;
-
-	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, timeout);
 }
 
 /* set current VNICC flag state; called from sysfs store function */
-- 
2.17.1
