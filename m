Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgGNOXW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 10:23:22 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/10] s390/qeth: cleanup OAT code
Date: Tue, 14 Jul 2020 16:23:03 +0200
Message-Id: <20200714142305.29297-9-jwi@linux.ibm.com>
In-Reply-To: <20200714142305.29297-1-jwi@linux.ibm.com>
References: <20200714142305.29297-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

While initially just trying to fix up the indentation, condense a few
lines and get rid of a goto label.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 40 ++++++++++---------------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c5ff7edb4ba1..053a25e34e4b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4835,17 +4835,17 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 }
 
 static int qeth_setadpparms_query_oat_cb(struct qeth_card *card,
-		struct qeth_reply *reply, unsigned long data)
+					 struct qeth_reply *reply,
+					 unsigned long data)
 {
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
-	struct qeth_qoat_priv *priv;
+	struct qeth_qoat_priv *priv = reply->param;
 	int resdatalen;
 
 	QETH_CARD_TEXT(card, 3, "qoatcb");
 	if (qeth_setadpparms_inspect_rc(cmd))
 		return -EIO;
 
-	priv = (struct qeth_qoat_priv *)reply->param;
 	resdatalen = cmd->data.setadapterparms.hdr.cmdlength;
 
 	if (resdatalen > (priv->buffer_len - priv->response_len))
@@ -4873,24 +4873,17 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 
 	QETH_CARD_TEXT(card, 3, "qoatcmd");
 
-	if (!qeth_adp_supported(card, IPA_SETADP_QUERY_OAT)) {
-		rc = -EOPNOTSUPP;
-		goto out;
-	}
+	if (!qeth_adp_supported(card, IPA_SETADP_QUERY_OAT))
+		return -EOPNOTSUPP;
 
-	if (copy_from_user(&oat_data, udata,
-	    sizeof(struct qeth_query_oat_data))) {
-			rc = -EFAULT;
-			goto out;
-	}
+	if (copy_from_user(&oat_data, udata, sizeof(oat_data)))
+		return -EFAULT;
 
 	priv.buffer_len = oat_data.buffer_len;
 	priv.response_len = 0;
 	priv.buffer = vzalloc(oat_data.buffer_len);
-	if (!priv.buffer) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!priv.buffer)
+		return -ENOMEM;
 
 	iob = qeth_get_adapter_cmd(card, IPA_SETADP_QUERY_OAT,
 				   SETADP_DATA_SIZEOF(query_oat));
@@ -4902,28 +4895,19 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 	oat_req = &cmd->data.setadapterparms.data.query_oat;
 	oat_req->subcmd_code = oat_data.command;
 
-	rc = qeth_send_ipa_cmd(card, iob, qeth_setadpparms_query_oat_cb,
-			       &priv);
+	rc = qeth_send_ipa_cmd(card, iob, qeth_setadpparms_query_oat_cb, &priv);
 	if (!rc) {
 		tmp = is_compat_task() ? compat_ptr(oat_data.ptr) :
 					 u64_to_user_ptr(oat_data.ptr);
-
-		if (copy_to_user(tmp, priv.buffer,
-		    priv.response_len)) {
-			rc = -EFAULT;
-			goto out_free;
-		}
-
 		oat_data.response_len = priv.response_len;
 
-		if (copy_to_user(udata, &oat_data,
-		    sizeof(struct qeth_query_oat_data)))
+		if (copy_to_user(tmp, priv.buffer, priv.response_len) ||
+		    copy_to_user(udata, &oat_data, sizeof(oat_data)))
 			rc = -EFAULT;
 	}
 
 out_free:
 	vfree(priv.buffer);
-out:
 	return rc;
 }
 
-- 
2.17.1
