From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/6] s390/qeth: fix error handling in adapter command callbacks
Date: Thu, 19 Apr 2018 12:52:06 +0200
Message-ID: <20180419105211.83935-2-jwi@linux.ibm.com>
References: <20180419105211.83935-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180419105211.83935-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

Make sure to check both return code fields before(!) processing the
command response. Otherwise we risk operating on invalid data.

This matches an earlier fix for SETASSPARMS commands, see
commit ad3cbf613329 ("s390/qeth: fix error handling in checksum cmd callback").

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 85 +++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 04fefa5bb08d..36bc94088de1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3033,28 +3033,23 @@ static int qeth_send_startlan(struct qeth_card *card)
 	return rc;
 }
 
-static int qeth_default_setadapterparms_cb(struct qeth_card *card,
-		struct qeth_reply *reply, unsigned long data)
+static int qeth_setadpparms_inspect_rc(struct qeth_ipa_cmd *cmd)
 {
-	struct qeth_ipa_cmd *cmd;
-
-	QETH_CARD_TEXT(card, 4, "defadpcb");
-
-	cmd = (struct qeth_ipa_cmd *) data;
-	if (cmd->hdr.return_code == 0)
+	if (!cmd->hdr.return_code)
 		cmd->hdr.return_code =
 			cmd->data.setadapterparms.hdr.return_code;
-	return 0;
+	return cmd->hdr.return_code;
 }
 
 static int qeth_query_setadapterparms_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
 	QETH_CARD_TEXT(card, 3, "quyadpcb");
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	if (cmd->data.setadapterparms.data.query_cmds_supp.lan_type & 0x7f) {
 		card->info.link_type =
 		      cmd->data.setadapterparms.data.query_cmds_supp.lan_type;
@@ -3062,7 +3057,7 @@ static int qeth_query_setadapterparms_cb(struct qeth_card *card,
 	}
 	card->options.adp.supported_funcs =
 		cmd->data.setadapterparms.data.query_cmds_supp.supported_cmds;
-	return qeth_default_setadapterparms_cb(card, reply, (unsigned long)cmd);
+	return 0;
 }
 
 static struct qeth_cmd_buffer *qeth_get_adapter_cmd(struct qeth_card *card,
@@ -3154,22 +3149,20 @@ EXPORT_SYMBOL_GPL(qeth_query_ipassists);
 static int qeth_query_switch_attributes_cb(struct qeth_card *card,
 				struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
-	struct qeth_switch_info *sw_info;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_query_switch_attributes *attrs;
+	struct qeth_switch_info *sw_info;
 
 	QETH_CARD_TEXT(card, 2, "qswiatcb");
-	cmd = (struct qeth_ipa_cmd *) data;
-	sw_info = (struct qeth_switch_info *)reply->param;
-	if (cmd->data.setadapterparms.hdr.return_code == 0) {
-		attrs = &cmd->data.setadapterparms.data.query_switch_attributes;
-		sw_info->capabilities = attrs->capabilities;
-		sw_info->settings = attrs->settings;
-		QETH_CARD_TEXT_(card, 2, "%04x%04x", sw_info->capabilities,
-							sw_info->settings);
-	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
+	sw_info = (struct qeth_switch_info *)reply->param;
+	attrs = &cmd->data.setadapterparms.data.query_switch_attributes;
+	sw_info->capabilities = attrs->capabilities;
+	sw_info->settings = attrs->settings;
+	QETH_CARD_TEXT_(card, 2, "%04x%04x", sw_info->capabilities,
+			sw_info->settings);
 	return 0;
 }
 
@@ -4207,16 +4200,13 @@ EXPORT_SYMBOL_GPL(qeth_do_send_packet);
 static int qeth_setadp_promisc_mode_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_ipacmd_setadpparms *setparms;
 
 	QETH_CARD_TEXT(card, 4, "prmadpcb");
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	setparms = &(cmd->data.setadapterparms);
-
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long)cmd);
-	if (cmd->hdr.return_code) {
+	if (qeth_setadpparms_inspect_rc(cmd)) {
 		QETH_CARD_TEXT_(card, 4, "prmrc%x", cmd->hdr.return_code);
 		setparms->data.mode = SET_PROMISC_MODE_OFF;
 	}
@@ -4286,18 +4276,18 @@ EXPORT_SYMBOL_GPL(qeth_get_stats);
 static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
 	QETH_CARD_TEXT(card, 4, "chgmaccb");
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	if (!card->options.layer2 ||
 	    !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {
 		ether_addr_copy(card->dev->dev_addr,
 				cmd->data.setadapterparms.data.change_addr.addr);
 		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
 	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
 
@@ -4328,13 +4318,15 @@ EXPORT_SYMBOL_GPL(qeth_setadpparms_change_macaddr);
 static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_set_access_ctrl *access_ctrl_req;
 	int fallback = *(int *)reply->param;
 
 	QETH_CARD_TEXT(card, 4, "setaccb");
+	if (cmd->hdr.return_code)
+		return 0;
+	qeth_setadpparms_inspect_rc(cmd);
 
-	cmd = (struct qeth_ipa_cmd *) data;
 	access_ctrl_req = &cmd->data.setadapterparms.data.set_access_ctrl;
 	QETH_DBF_TEXT_(SETUP, 2, "setaccb");
 	QETH_DBF_TEXT_(SETUP, 2, "%s", card->gdev->dev.kobj.name);
@@ -4407,7 +4399,6 @@ static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 			card->options.isolation = card->options.prev_isolation;
 		break;
 	}
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
 	return 0;
 }
 
@@ -4695,14 +4686,15 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 static int qeth_setadpparms_query_oat_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
 	struct qeth_qoat_priv *priv;
 	char *resdata;
 	int resdatalen;
 
 	QETH_CARD_TEXT(card, 3, "qoatcb");
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	cmd = (struct qeth_ipa_cmd *)data;
 	priv = (struct qeth_qoat_priv *)reply->param;
 	resdatalen = cmd->data.setadapterparms.hdr.cmdlength;
 	resdata = (char *)data + 28;
@@ -4796,21 +4788,18 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 static int qeth_query_card_info_cb(struct qeth_card *card,
 				   struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct carrier_info *carrier_info = (struct carrier_info *)reply->param;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
 	struct qeth_query_card_info *card_info;
-	struct carrier_info *carrier_info;
 
 	QETH_CARD_TEXT(card, 2, "qcrdincb");
-	carrier_info = (struct carrier_info *)reply->param;
-	cmd = (struct qeth_ipa_cmd *)data;
-	card_info = &cmd->data.setadapterparms.data.card_info;
-	if (cmd->data.setadapterparms.hdr.return_code == 0) {
-		carrier_info->card_type = card_info->card_type;
-		carrier_info->port_mode = card_info->port_mode;
-		carrier_info->port_speed = card_info->port_speed;
-	}
+	if (qeth_setadpparms_inspect_rc(cmd))
+		return 0;
 
-	qeth_default_setadapterparms_cb(card, reply, (unsigned long) cmd);
+	card_info = &cmd->data.setadapterparms.data.card_info;
+	carrier_info->card_type = card_info->card_type;
+	carrier_info->port_mode = card_info->port_mode;
+	carrier_info->port_speed = card_info->port_speed;
 	return 0;
 }
 
-- 
2.13.5
