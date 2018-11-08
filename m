From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: replace open-coded cmd setup
Date: Thu,  8 Nov 2018 15:06:19 +0100
Message-ID: <20181108140622.35244-6-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Call qeth_prepare_ipa_cmd() during setup of a new IPA cmd buffer, so
that it is used for all commands. Thus ARP and SNMP requests don't have
to do their own initialization.

This will now also set the proper MPC protocol version for SNMP requests
on L2 devices.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 27 ++++++++++++---------------
 drivers/s390/net/qeth_core_mpc.c  |  1 -
 drivers/s390/net/qeth_l3_main.c   |  3 ---
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 508bad2dbd0b..c1315ac63041 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2835,6 +2835,17 @@ static void qeth_fill_ipacmd_header(struct qeth_card *card,
 	cmd->hdr.prot_version = prot;
 }
 
+void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob)
+{
+	u8 prot_type = qeth_mpc_select_prot_type(card);
+
+	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
+	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data), &prot_type, 1);
+	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
+	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
+}
+EXPORT_SYMBOL_GPL(qeth_prepare_ipa_cmd);
+
 struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 		enum qeth_ipa_cmds ipacmd, enum qeth_prot_versions prot)
 {
@@ -2842,6 +2853,7 @@ struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 
 	iob = qeth_get_buffer(&card->write);
 	if (iob) {
+		qeth_prepare_ipa_cmd(card, iob);
 		qeth_fill_ipacmd_header(card, __ipa_cmd(iob), ipacmd, prot);
 	} else {
 		dev_warn(&card->gdev->dev,
@@ -2854,17 +2866,6 @@ struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 }
 EXPORT_SYMBOL_GPL(qeth_get_ipacmd_buffer);
 
-void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob)
-{
-	u8 prot_type = qeth_mpc_select_prot_type(card);
-
-	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
-	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data), &prot_type, 1);
-	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
-	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
-}
-EXPORT_SYMBOL_GPL(qeth_prepare_ipa_cmd);
-
 /**
  * qeth_send_ipa_cmd() - send an IPA command
  *
@@ -2879,7 +2880,6 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 	int rc;
 
 	QETH_CARD_TEXT(card, 4, "sendipa");
-	qeth_prepare_ipa_cmd(card, iob);
 	rc = qeth_send_control_data(card, IPA_CMD_LENGTH,
 						iob, reply_cb, reply_param);
 	if (rc == -ETIME) {
@@ -4497,9 +4497,6 @@ static int qeth_send_ipa_snmp_cmd(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 4, "sendsnmp");
 
-	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
-	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
-	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
 	/* adjust PDU length fields in IPA_PDU_HEADER */
 	s1 = (u32) IPA_PDU_HEADER_SIZE + len;
 	s2 = (u32) len;
diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index e891c0b52f4c..16fc51ad0514 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -144,7 +144,6 @@ unsigned char IPA_PDU_HEADER[] = {
 		sizeof(struct qeth_ipa_cmd) % 256,
 	0x00, 0x00, 0x00, 0x40,
 };
-EXPORT_SYMBOL_GPL(IPA_PDU_HEADER);
 
 struct ipa_rc_msg {
 	enum qeth_ipa_return_codes rc;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 61d847d41cab..ce5ef6aca891 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1693,9 +1693,6 @@ static int qeth_l3_send_ipa_arp_cmd(struct qeth_card *card,
 {
 	QETH_CARD_TEXT(card, 4, "sendarp");
 
-	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
-	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
-	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
 	return qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
 				      reply_cb, reply_param);
 }
-- 
2.16.4
