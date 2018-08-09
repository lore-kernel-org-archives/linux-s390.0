From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/7] s390/qeth: extract helper for MPC protocol type
Date: Thu,  9 Aug 2018 14:47:58 +0200
Message-ID: <20180809124804.20056-2-jwi@linux.ibm.com>
References: <20180809124804.20056-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180809124804.20056-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Just a little code deduplication.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 35 +++++++++++++----------------------
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 3 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 605ec4706773..24e4f31a0f36 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -998,7 +998,7 @@ void qeth_tx_timeout(struct net_device *);
 void qeth_prepare_control_data(struct qeth_card *, int,
 				struct qeth_cmd_buffer *);
 void qeth_release_buffer(struct qeth_channel *, struct qeth_cmd_buffer *);
-void qeth_prepare_ipa_cmd(struct qeth_card *, struct qeth_cmd_buffer *, char);
+void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob);
 struct qeth_cmd_buffer *qeth_wait_for_buffer(struct qeth_channel *);
 int qeth_query_switch_attributes(struct qeth_card *card,
 				  struct qeth_switch_info *sw_info);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d09a7110b381..da9ac2129869 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2367,12 +2367,19 @@ static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 	return 0;
 }
 
+static u8 qeth_mpc_select_prot_type(struct qeth_card *card)
+{
+	if (IS_OSN(card))
+		return QETH_PROT_OSN2;
+	return (card->options.layer2 == 1) ? QETH_PROT_LAYER2 : QETH_PROT_TCPIP;
+}
+
 static int qeth_ulp_enable(struct qeth_card *card)
 {
-	int rc;
-	char prot_type;
+	u8 prot_type = qeth_mpc_select_prot_type(card);
 	struct qeth_cmd_buffer *iob;
 	u16 max_mtu;
+	int rc;
 
 	/*FIXME: trace view callbacks*/
 	QETH_DBF_TEXT(SETUP, 2, "ulpenabl");
@@ -2381,14 +2388,6 @@ static int qeth_ulp_enable(struct qeth_card *card)
 	memcpy(iob->data, ULP_ENABLE, ULP_ENABLE_SIZE);
 
 	*(QETH_ULP_ENABLE_LINKNUM(iob->data)) = (u8) card->dev->dev_port;
-	if (card->options.layer2)
-		if (card->info.type == QETH_CARD_TYPE_OSN)
-			prot_type = QETH_PROT_OSN2;
-		else
-			prot_type = QETH_PROT_LAYER2;
-	else
-		prot_type = QETH_PROT_TCPIP;
-
 	memcpy(QETH_ULP_ENABLE_PROT_TYPE(iob->data), &prot_type, 1);
 	memcpy(QETH_ULP_ENABLE_DEST_ADDR(iob->data),
 	       &card->token.cm_connection_r, QETH_MPC_TOKEN_LENGTH);
@@ -2939,9 +2938,10 @@ struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 }
 EXPORT_SYMBOL_GPL(qeth_get_ipacmd_buffer);
 
-void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
-		char prot_type)
+void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob)
 {
+	u8 prot_type = qeth_mpc_select_prot_type(card);
+
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
 	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data), &prot_type, 1);
 	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
@@ -2961,18 +2961,9 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 		void *reply_param)
 {
 	int rc;
-	char prot_type;
 
 	QETH_CARD_TEXT(card, 4, "sendipa");
-
-	if (card->options.layer2)
-		if (card->info.type == QETH_CARD_TYPE_OSN)
-			prot_type = QETH_PROT_OSN2;
-		else
-			prot_type = QETH_PROT_LAYER2;
-	else
-		prot_type = QETH_PROT_TCPIP;
-	qeth_prepare_ipa_cmd(card, iob, prot_type);
+	qeth_prepare_ipa_cmd(card, iob);
 	rc = qeth_send_control_data(card, IPA_CMD_LENGTH,
 						iob, reply_cb, reply_param);
 	if (rc == -ETIME) {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index c1829a4b955d..efb84a75dd80 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1270,7 +1270,7 @@ static int qeth_osn_send_ipa_cmd(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 4, "osndipa");
 
-	qeth_prepare_ipa_cmd(card, iob, QETH_PROT_OSN2);
+	qeth_prepare_ipa_cmd(card, iob);
 	s1 = (u16)(IPA_PDU_HEADER_SIZE + data_len);
 	s2 = (u16)data_len;
 	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
-- 
2.16.4
