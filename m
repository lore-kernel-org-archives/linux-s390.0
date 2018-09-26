From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 13/15] s390/qeth: re-indent qeth_check_ipa_data()
Date: Wed, 26 Sep 2018 18:29:14 +0200
Message-ID: <20180926162916.102720-14-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Pull one level of checking up into qeth_send_control_data_cb(), and
clean up an else-after-return. No functional change.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 129 +++++++++++++++++---------------------
 1 file changed, 58 insertions(+), 71 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 880c15647442..954dc6c688e8 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -626,80 +626,64 @@ static void qeth_issue_ipa_msg(struct qeth_ipa_cmd *cmd, int rc,
 }
 
 static struct qeth_ipa_cmd *qeth_check_ipa_data(struct qeth_card *card,
-		struct qeth_cmd_buffer *iob)
+						struct qeth_ipa_cmd *cmd)
 {
-	struct qeth_ipa_cmd *cmd = NULL;
-
 	QETH_CARD_TEXT(card, 5, "chkipad");
-	if (IS_IPA(iob->data)) {
-		cmd = (struct qeth_ipa_cmd *) PDU_ENCAPSULATION(iob->data);
-		if (IS_IPA_REPLY(cmd)) {
-			if (cmd->hdr.command != IPA_CMD_SETCCID &&
-			    cmd->hdr.command != IPA_CMD_DELCCID &&
-			    cmd->hdr.command != IPA_CMD_MODCCID &&
-			    cmd->hdr.command != IPA_CMD_SET_DIAG_ASS)
-				qeth_issue_ipa_msg(cmd,
-						cmd->hdr.return_code, card);
-			return cmd;
+
+	if (IS_IPA_REPLY(cmd)) {
+		if (cmd->hdr.command != IPA_CMD_SETCCID &&
+		    cmd->hdr.command != IPA_CMD_DELCCID &&
+		    cmd->hdr.command != IPA_CMD_MODCCID &&
+		    cmd->hdr.command != IPA_CMD_SET_DIAG_ASS)
+			qeth_issue_ipa_msg(cmd, cmd->hdr.return_code, card);
+		return cmd;
+	}
+
+	/* handle unsolicited event: */
+	switch (cmd->hdr.command) {
+	case IPA_CMD_STOPLAN:
+		if (cmd->hdr.return_code == IPA_RC_VEPA_TO_VEB_TRANSITION) {
+			dev_err(&card->gdev->dev,
+				"Interface %s is down because the adjacent port is no longer in reflective relay mode\n",
+				QETH_CARD_IFNAME(card));
+			qeth_close_dev(card);
 		} else {
-			switch (cmd->hdr.command) {
-			case IPA_CMD_STOPLAN:
-				if (cmd->hdr.return_code ==
-						IPA_RC_VEPA_TO_VEB_TRANSITION) {
-					dev_err(&card->gdev->dev,
-					   "Interface %s is down because the "
-					   "adjacent port is no longer in "
-					   "reflective relay mode\n",
-					   QETH_CARD_IFNAME(card));
-					qeth_close_dev(card);
-				} else {
-					dev_warn(&card->gdev->dev,
-					   "The link for interface %s on CHPID"
-					   " 0x%X failed\n",
-					   QETH_CARD_IFNAME(card),
-					   card->info.chpid);
-					qeth_issue_ipa_msg(cmd,
-						cmd->hdr.return_code, card);
-				}
-				card->lan_online = 0;
-				netif_carrier_off(card->dev);
-				return NULL;
-			case IPA_CMD_STARTLAN:
-				dev_info(&card->gdev->dev,
-					   "The link for %s on CHPID 0x%X has"
-					   " been restored\n",
-					   QETH_CARD_IFNAME(card),
-					   card->info.chpid);
-				netif_carrier_on(card->dev);
-				card->lan_online = 1;
-				if (card->info.hwtrap)
-					card->info.hwtrap = 2;
-				qeth_schedule_recovery(card);
-				return NULL;
-			case IPA_CMD_SETBRIDGEPORT_IQD:
-			case IPA_CMD_SETBRIDGEPORT_OSA:
-			case IPA_CMD_ADDRESS_CHANGE_NOTIF:
-				if (card->discipline->control_event_handler
-								(card, cmd))
-					return cmd;
-				else
-					return NULL;
-			case IPA_CMD_MODCCID:
-				return cmd;
-			case IPA_CMD_REGISTER_LOCAL_ADDR:
-				QETH_CARD_TEXT(card, 3, "irla");
-				return NULL;
-			case IPA_CMD_UNREGISTER_LOCAL_ADDR:
-				QETH_CARD_TEXT(card, 3, "urla");
-				return NULL;
-			default:
-				QETH_DBF_MESSAGE(2, "Received data is IPA "
-					   "but not a reply!\n");
-				break;
-			}
+			dev_warn(&card->gdev->dev,
+				 "The link for interface %s on CHPID 0x%X failed\n",
+				 QETH_CARD_IFNAME(card), card->info.chpid);
+			qeth_issue_ipa_msg(cmd, cmd->hdr.return_code, card);
 		}
+		card->lan_online = 0;
+		netif_carrier_off(card->dev);
+		return NULL;
+	case IPA_CMD_STARTLAN:
+		dev_info(&card->gdev->dev,
+			 "The link for %s on CHPID 0x%X has been restored\n",
+			 QETH_CARD_IFNAME(card), card->info.chpid);
+		netif_carrier_on(card->dev);
+		card->lan_online = 1;
+		if (card->info.hwtrap)
+			card->info.hwtrap = 2;
+		qeth_schedule_recovery(card);
+		return NULL;
+	case IPA_CMD_SETBRIDGEPORT_IQD:
+	case IPA_CMD_SETBRIDGEPORT_OSA:
+	case IPA_CMD_ADDRESS_CHANGE_NOTIF:
+		if (card->discipline->control_event_handler(card, cmd))
+			return cmd;
+		return NULL;
+	case IPA_CMD_MODCCID:
+		return cmd;
+	case IPA_CMD_REGISTER_LOCAL_ADDR:
+		QETH_CARD_TEXT(card, 3, "irla");
+		return NULL;
+	case IPA_CMD_UNREGISTER_LOCAL_ADDR:
+		QETH_CARD_TEXT(card, 3, "urla");
+		return NULL;
+	default:
+		QETH_DBF_MESSAGE(2, "Received data is IPA but not a reply!\n");
+		return cmd;
 	}
-	return cmd;
 }
 
 void qeth_clear_ipacmd_list(struct qeth_card *card)
@@ -820,8 +804,8 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 				      struct qeth_channel *channel,
 				      struct qeth_cmd_buffer *iob)
 {
+	struct qeth_ipa_cmd *cmd = NULL;
 	struct qeth_reply *reply, *r;
-	struct qeth_ipa_cmd *cmd;
 	unsigned long flags;
 	int keep_reply;
 	int rc = 0;
@@ -839,7 +823,10 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 		goto out;
 	}
 
-	cmd = qeth_check_ipa_data(card, iob);
+	if (IS_IPA(iob->data)) {
+		cmd = (struct qeth_ipa_cmd *) PDU_ENCAPSULATION(iob->data);
+		cmd = qeth_check_ipa_data(card, cmd);
+	}
 	if ((cmd == NULL) && (card->state != CARD_STATE_DOWN))
 		goto out;
 	/*in case of OSN : check if cmd is set */
-- 
2.16.4
