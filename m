Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/9] s390/qeth: get vnicc sub-cmd type from reply data
Date: Tue, 20 Aug 2019 16:46:40 +0200
In-Reply-To: <20190820144643.64041-1-jwi@linux.ibm.com>
References: <20190820144643.64041-1-jwi@linux.ibm.com>
Message-Id: <20190820144643.64041-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When processing the reply for a vnicc cmd, there's no need to remember
which specific sub-cmd type we initially sent. The reply itself contains
all the needed information.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ad7ee3bfd63c..1f534f489a79 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1704,7 +1704,6 @@ static int qeth_l2_vnicc_makerc(struct qeth_card *card, u16 ipa_rc)
 
 /* generic VNICC request call back control */
 struct _qeth_l2_vnicc_request_cbctl {
-	u32 sub_cmd;
 	struct {
 		union{
 			u32 *sup_cmds;
@@ -1722,6 +1721,7 @@ static int qeth_l2_vnicc_request_cb(struct qeth_card *card,
 		(struct _qeth_l2_vnicc_request_cbctl *) reply->param;
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_ipacmd_vnicc *rep = &cmd->data.vnicc;
+	u32 sub_cmd = cmd->data.vnicc.hdr.sub_command;
 
 	QETH_CARD_TEXT(card, 2, "vniccrcb");
 	if (cmd->hdr.return_code)
@@ -1730,10 +1730,9 @@ static int qeth_l2_vnicc_request_cb(struct qeth_card *card,
 	card->options.vnicc.sup_chars = rep->vnicc_cmds.supported;
 	card->options.vnicc.cur_chars = rep->vnicc_cmds.enabled;
 
-	if (cbctl->sub_cmd == IPA_VNICC_QUERY_CMDS)
+	if (sub_cmd == IPA_VNICC_QUERY_CMDS)
 		*cbctl->result.sup_cmds = rep->data.query_cmds.sup_cmds;
-
-	if (cbctl->sub_cmd == IPA_VNICC_GET_TIMEOUT)
+	else if (sub_cmd == IPA_VNICC_GET_TIMEOUT)
 		*cbctl->result.timeout = rep->data.getset_timeout.timeout;
 
 	return 0;
@@ -1761,7 +1760,6 @@ static struct qeth_cmd_buffer *qeth_l2_vnicc_build_cmd(struct qeth_card *card,
 /* VNICC query VNIC characteristics request */
 static int qeth_l2_vnicc_query_chars(struct qeth_card *card)
 {
-	struct _qeth_l2_vnicc_request_cbctl cbctl;
 	struct qeth_cmd_buffer *iob;
 
 	QETH_CARD_TEXT(card, 2, "vniccqch");
@@ -1769,10 +1767,7 @@ static int qeth_l2_vnicc_query_chars(struct qeth_card *card)
 	if (!iob)
 		return -ENOMEM;
 
-	/* prepare callback control */
-	cbctl.sub_cmd = IPA_VNICC_QUERY_CHARS;
-
-	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, NULL);
 }
 
 /* VNICC query sub commands request */
@@ -1791,7 +1786,6 @@ static int qeth_l2_vnicc_query_cmds(struct qeth_card *card, u32 vnic_char,
 	__ipa_cmd(iob)->data.vnicc.data.query_cmds.vnic_char = vnic_char;
 
 	/* prepare callback control */
-	cbctl.sub_cmd = IPA_VNICC_QUERY_CMDS;
 	cbctl.result.sup_cmds = sup_cmds;
 
 	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
@@ -1801,7 +1795,6 @@ static int qeth_l2_vnicc_query_cmds(struct qeth_card *card, u32 vnic_char,
 static int qeth_l2_vnicc_set_char(struct qeth_card *card, u32 vnic_char,
 				      u32 cmd)
 {
-	struct _qeth_l2_vnicc_request_cbctl cbctl;
 	struct qeth_cmd_buffer *iob;
 
 	QETH_CARD_TEXT(card, 2, "vniccedc");
@@ -1811,10 +1804,7 @@ static int qeth_l2_vnicc_set_char(struct qeth_card *card, u32 vnic_char,
 
 	__ipa_cmd(iob)->data.vnicc.data.set_char.vnic_char = vnic_char;
 
-	/* prepare callback control */
-	cbctl.sub_cmd = cmd;
-
-	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, &cbctl);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, NULL);
 }
 
 /* VNICC get/set timeout for characteristic request */
@@ -1838,7 +1828,6 @@ static int qeth_l2_vnicc_getset_timeout(struct qeth_card *card, u32 vnicc,
 		getset_timeout->timeout = *timeout;
 
 	/* prepare callback control */
-	cbctl.sub_cmd = cmd;
 	if (cmd == IPA_VNICC_GET_TIMEOUT)
 		cbctl.result.timeout = timeout;
 
-- 
2.17.1
