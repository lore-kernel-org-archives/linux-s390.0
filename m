Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 09/10] s390/qeth: convert bridgeport callbacks
Date: Tue, 12 Feb 2019 18:33:24 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-10-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

By letting the callbacks deal with error translation, we no longer need
to pass the raw error codes back to the originator. This allows us to
slim down the callback's private data, and nicely simplifies the code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 94 ++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 54 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 6d9eb54ea3b0..955fb24af418 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1407,8 +1407,6 @@ static void qeth_bridge_host_event(struct qeth_card *card,
 /* SETBRIDGEPORT support; sending commands */
 
 struct _qeth_sbp_cbctl {
-	u16 ipa_rc;
-	u16 cmd_rc;
 	union {
 		u32 supported;
 		struct {
@@ -1418,23 +1416,21 @@ struct _qeth_sbp_cbctl {
 	} data;
 };
 
-/**
- * qeth_bridgeport_makerc() - derive "traditional" error from hardware codes.
- * @card:		      qeth_card structure pointer, for debug messages.
- * @cbctl:		      state structure with hardware return codes.
- * @setcmd:		      IPA command code
- *
- * Returns negative errno-compatible error indication or 0 on success.
- */
 static int qeth_bridgeport_makerc(struct qeth_card *card,
-	struct _qeth_sbp_cbctl *cbctl, enum qeth_ipa_sbp_cmd setcmd)
+				  struct qeth_ipa_cmd *cmd)
 {
+	struct qeth_ipacmd_setbridgeport *sbp = &cmd->data.sbp;
+	enum qeth_ipa_sbp_cmd setcmd = sbp->hdr.command_code;
+	u16 ipa_rc = cmd->hdr.return_code;
+	u16 sbp_rc = sbp->hdr.return_code;
 	int rc;
-	int is_iqd = (card->info.type == QETH_CARD_TYPE_IQD);
 
-	if ((is_iqd && (cbctl->ipa_rc == IPA_RC_SUCCESS)) ||
-	    (!is_iqd && (cbctl->ipa_rc == cbctl->cmd_rc)))
-		switch (cbctl->cmd_rc) {
+	if (ipa_rc == IPA_RC_SUCCESS && sbp_rc == IPA_RC_SUCCESS)
+		return 0;
+
+	if ((IS_IQD(card) && ipa_rc == IPA_RC_SUCCESS) ||
+	    (!IS_IQD(card) && ipa_rc == sbp_rc)) {
+		switch (sbp_rc) {
 		case IPA_RC_SUCCESS:
 			rc = 0;
 			break;
@@ -1498,8 +1494,8 @@ static int qeth_bridgeport_makerc(struct qeth_card *card,
 		default:
 			rc = -EIO;
 		}
-	else
-		switch (cbctl->ipa_rc) {
+	} else {
+		switch (ipa_rc) {
 		case IPA_RC_NOTSUPP:
 			rc = -EOPNOTSUPP;
 			break;
@@ -1509,10 +1505,11 @@ static int qeth_bridgeport_makerc(struct qeth_card *card,
 		default:
 			rc = -EIO;
 		}
+	}
 
 	if (rc) {
-		QETH_CARD_TEXT_(card, 2, "SBPi%04x", cbctl->ipa_rc);
-		QETH_CARD_TEXT_(card, 2, "SBPc%04x", cbctl->cmd_rc);
+		QETH_CARD_TEXT_(card, 2, "SBPi%04x", ipa_rc);
+		QETH_CARD_TEXT_(card, 2, "SBPc%04x", sbp_rc);
 	}
 	return rc;
 }
@@ -1544,15 +1541,15 @@ static int qeth_bridgeport_query_support_cb(struct qeth_card *card,
 {
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct _qeth_sbp_cbctl *cbctl = (struct _qeth_sbp_cbctl *)reply->param;
+	int rc;
+
 	QETH_CARD_TEXT(card, 2, "brqsupcb");
-	cbctl->ipa_rc = cmd->hdr.return_code;
-	cbctl->cmd_rc = cmd->data.sbp.hdr.return_code;
-	if ((cbctl->ipa_rc == 0) && (cbctl->cmd_rc == 0)) {
-		cbctl->data.supported =
-			cmd->data.sbp.data.query_cmds_supp.supported_cmds;
-	} else {
-		cbctl->data.supported = 0;
-	}
+	rc = qeth_bridgeport_makerc(card, cmd);
+	if (rc)
+		return rc;
+
+	cbctl->data.supported =
+		cmd->data.sbp.data.query_cmds_supp.supported_cmds;
 	return 0;
 }
 
@@ -1573,12 +1570,11 @@ static void qeth_bridgeport_query_support(struct qeth_card *card)
 				 sizeof(struct qeth_sbp_query_cmds_supp));
 	if (!iob)
 		return;
+
 	if (qeth_send_ipa_cmd(card, iob, qeth_bridgeport_query_support_cb,
-							(void *)&cbctl) ||
-	    qeth_bridgeport_makerc(card, &cbctl,
-					IPA_SBP_QUERY_COMMANDS_SUPPORTED)) {
-		/* non-zero makerc signifies failure, and produce messages */
+			      &cbctl)) {
 		card->options.sbp.role = QETH_SBP_ROLE_NONE;
+		card->options.sbp.supported_funcs = 0;
 		return;
 	}
 	card->options.sbp.supported_funcs = cbctl.data.supported;
@@ -1590,16 +1586,16 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct qeth_sbp_query_ports *qports = &cmd->data.sbp.data.query_ports;
 	struct _qeth_sbp_cbctl *cbctl = (struct _qeth_sbp_cbctl *)reply->param;
+	int rc;
 
 	QETH_CARD_TEXT(card, 2, "brqprtcb");
-	cbctl->ipa_rc = cmd->hdr.return_code;
-	cbctl->cmd_rc = cmd->data.sbp.hdr.return_code;
-	if ((cbctl->ipa_rc != 0) || (cbctl->cmd_rc != 0))
-		return 0;
+	rc = qeth_bridgeport_makerc(card, cmd);
+	if (rc)
+		return rc;
+
 	if (qports->entry_length != sizeof(struct qeth_sbp_port_entry)) {
-		cbctl->cmd_rc = 0xffff;
 		QETH_CARD_TEXT_(card, 2, "SBPs%04x", qports->entry_length);
-		return 0;
+		return -EINVAL;
 	}
 	/* first entry contains the state of the local port */
 	if (qports->num_entries > 0) {
@@ -1624,7 +1620,6 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
 int qeth_bridgeport_query_ports(struct qeth_card *card,
 	enum qeth_sbp_roles *role, enum qeth_sbp_states *state)
 {
-	int rc = 0;
 	struct qeth_cmd_buffer *iob;
 	struct _qeth_sbp_cbctl cbctl = {
 		.data = {
@@ -1641,22 +1636,18 @@ int qeth_bridgeport_query_ports(struct qeth_card *card,
 	iob = qeth_sbp_build_cmd(card, IPA_SBP_QUERY_BRIDGE_PORTS, 0);
 	if (!iob)
 		return -ENOMEM;
-	rc = qeth_send_ipa_cmd(card, iob, qeth_bridgeport_query_ports_cb,
-				(void *)&cbctl);
-	if (rc < 0)
-		return rc;
-	return qeth_bridgeport_makerc(card, &cbctl, IPA_SBP_QUERY_BRIDGE_PORTS);
+
+	return qeth_send_ipa_cmd(card, iob, qeth_bridgeport_query_ports_cb,
+				 &cbctl);
 }
 
 static int qeth_bridgeport_set_cb(struct qeth_card *card,
 	struct qeth_reply *reply, unsigned long data)
 {
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *)data;
-	struct _qeth_sbp_cbctl *cbctl = (struct _qeth_sbp_cbctl *)reply->param;
+
 	QETH_CARD_TEXT(card, 2, "brsetrcb");
-	cbctl->ipa_rc = cmd->hdr.return_code;
-	cbctl->cmd_rc = cmd->data.sbp.hdr.return_code;
-	return 0;
+	return qeth_bridgeport_makerc(card, cmd);
 }
 
 /**
@@ -1668,10 +1659,8 @@ static int qeth_bridgeport_set_cb(struct qeth_card *card,
  */
 int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role)
 {
-	int rc = 0;
 	int cmdlength;
 	struct qeth_cmd_buffer *iob;
-	struct _qeth_sbp_cbctl cbctl;
 	enum qeth_ipa_sbp_cmd setcmd;
 
 	QETH_CARD_TEXT(card, 2, "brsetrol");
@@ -1696,11 +1685,8 @@ int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role)
 	iob = qeth_sbp_build_cmd(card, setcmd, cmdlength);
 	if (!iob)
 		return -ENOMEM;
-	rc = qeth_send_ipa_cmd(card, iob, qeth_bridgeport_set_cb,
-				(void *)&cbctl);
-	if (rc < 0)
-		return rc;
-	return qeth_bridgeport_makerc(card, &cbctl, setcmd);
+
+	return qeth_send_ipa_cmd(card, iob, qeth_bridgeport_set_cb, NULL);
 }
 
 /**
-- 
2.16.4
