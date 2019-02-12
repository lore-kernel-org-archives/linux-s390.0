Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 02/10] s390/qeth: consolidate filling of low-level cmd length fields
Date: Tue, 12 Feb 2019 18:33:17 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The code to fill the IPA length fields is duplicated three times across
the driver:
1. qeth_send_ipa_cmd() sets IPA_CMD_LENGTH, which matches the defaults
   in the IPA_PDU_HEADER template.
2. for OSN, qeth_osn_send_ipa_cmd() bypasses this logic and inserts the
   length passed by the caller.
3. SNMP commands (that can outgrow IPA_CMD_LENGTH) have their own way
   of setting the length fields, via qeth_send_ipa_snmp_cmd().

Consolidate this into qeth_prepare_ipa_cmd(), which all originators of
IPA cmds already call during setup of their cmd. Let qeth_send_ipa_cmd()
pull the length from the cmd instead of hard-coding IPA_CMD_LENGTH.

For now, the SNMP code still needs to fix-up its length fields manually.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  3 ++-
 drivers/s390/net/qeth_core_main.c | 43 +++++++++++++++------------------------
 drivers/s390/net/qeth_core_mpc.c  | 19 ++++-------------
 drivers/s390/net/qeth_core_mpc.h  |  2 --
 drivers/s390/net/qeth_l2_main.c   | 17 ++++++----------
 5 files changed, 28 insertions(+), 56 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index f35e0b58ba4e..07840f9c0bb3 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1000,7 +1000,8 @@ void qeth_tx_timeout(struct net_device *);
 void qeth_prepare_control_data(struct qeth_card *, int,
 				struct qeth_cmd_buffer *);
 void qeth_release_buffer(struct qeth_channel *, struct qeth_cmd_buffer *);
-void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob);
+void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+			  u16 cmd_length);
 struct qeth_cmd_buffer *qeth_wait_for_buffer(struct qeth_channel *);
 int qeth_query_switch_attributes(struct qeth_card *card,
 				  struct qeth_switch_info *sw_info);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 47927613d43c..5f450df886c6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2815,14 +2815,20 @@ static void qeth_fill_ipacmd_header(struct qeth_card *card,
 	cmd->hdr.prot_version = prot;
 }
 
-void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob)
+void qeth_prepare_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
+			  u16 cmd_length)
 {
+	u16 total_length = IPA_PDU_HEADER_SIZE + cmd_length;
 	u8 prot_type = qeth_mpc_select_prot_type(card);
 
 	memcpy(iob->data, IPA_PDU_HEADER, IPA_PDU_HEADER_SIZE);
+	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &total_length, 2);
 	memcpy(QETH_IPA_CMD_PROT_TYPE(iob->data), &prot_type, 1);
+	memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &cmd_length, 2);
+	memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &cmd_length, 2);
 	memcpy(QETH_IPA_CMD_DEST_ADDR(iob->data),
 	       &card->token.ulp_connection_r, QETH_MPC_TOKEN_LENGTH);
+	memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &cmd_length, 2);
 }
 EXPORT_SYMBOL_GPL(qeth_prepare_ipa_cmd);
 
@@ -2833,7 +2839,7 @@ struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 
 	iob = qeth_get_buffer(&card->write);
 	if (iob) {
-		qeth_prepare_ipa_cmd(card, iob);
+		qeth_prepare_ipa_cmd(card, iob, sizeof(struct qeth_ipa_cmd));
 		qeth_fill_ipacmd_header(card, __ipa_cmd(iob), ipacmd, prot);
 	} else {
 		dev_warn(&card->gdev->dev,
@@ -2857,11 +2863,12 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 			unsigned long),
 		void *reply_param)
 {
+	u16 length;
 	int rc;
 
 	QETH_CARD_TEXT(card, 4, "sendipa");
-	rc = qeth_send_control_data(card, IPA_CMD_LENGTH,
-						iob, reply_cb, reply_param);
+	memcpy(&length, QETH_IPA_PDU_LEN_TOTAL(iob->data), 2);
+	rc = qeth_send_control_data(card, length, iob, reply_cb, reply_param);
 	if (rc == -ETIME) {
 		qeth_clear_ipacmd_list(card);
 		qeth_schedule_recovery(card);
@@ -4460,27 +4467,6 @@ static int qeth_mdio_read(struct net_device *dev, int phy_id, int regnum)
 	return rc;
 }
 
-static int qeth_send_ipa_snmp_cmd(struct qeth_card *card,
-		struct qeth_cmd_buffer *iob, int len,
-		int (*reply_cb)(struct qeth_card *, struct qeth_reply *,
-			unsigned long),
-		void *reply_param)
-{
-	u16 s1, s2;
-
-	QETH_CARD_TEXT(card, 4, "sendsnmp");
-
-	/* adjust PDU length fields in IPA_PDU_HEADER */
-	s1 = (u32) IPA_PDU_HEADER_SIZE + len;
-	s2 = (u32) len;
-	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
-	return qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
-				      reply_cb, reply_param);
-}
-
 static int qeth_snmp_command_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long sdata)
 {
@@ -4586,10 +4572,13 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 		rc = -ENOMEM;
 		goto out;
 	}
+
+	/* for large requests, fix-up the length fields: */
+	qeth_prepare_ipa_cmd(card, iob, QETH_SETADP_BASE_LEN + req_len);
+
 	cmd = __ipa_cmd(iob);
 	memcpy(&cmd->data.setadapterparms.data.snmp, &ureq->cmd, req_len);
-	rc = qeth_send_ipa_snmp_cmd(card, iob, QETH_SETADP_BASE_LEN + req_len,
-				    qeth_snmp_command_cb, (void *)&qinfo);
+	rc = qeth_send_ipa_cmd(card, iob, qeth_snmp_command_cb, &qinfo);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "SNMP command failed on device %x: (%#x)\n",
 				 CARD_DEVID(card), rc);
diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index 16fc51ad0514..7ff221ae0a2e 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -125,24 +125,13 @@ unsigned char DM_ACT[] = {
 
 unsigned char IPA_PDU_HEADER[] = {
 	0x00, 0xe0, 0x00, 0x00,  0x77, 0x77, 0x77, 0x77,
-	0x00, 0x00, 0x00, 0x14,  0x00, 0x00,
-		(IPA_PDU_HEADER_SIZE+sizeof(struct qeth_ipa_cmd)) / 256,
-		(IPA_PDU_HEADER_SIZE+sizeof(struct qeth_ipa_cmd)) % 256,
+	0x00, 0x00, 0x00, 0x14,  0x00, 0x00, 0x00, 0x00,
 	0x10, 0x00, 0x00, 0x01,  0x00, 0x00, 0x00, 0x00,
 	0xc1, 0x03, 0x00, 0x01,  0x00, 0x00, 0x00, 0x00,
-	0x00, 0x00, 0x00, 0x00,  0x00, 0x24,
-		sizeof(struct qeth_ipa_cmd) / 256,
-		sizeof(struct qeth_ipa_cmd) % 256,
-	0x00,
-		sizeof(struct qeth_ipa_cmd) / 256,
-		sizeof(struct qeth_ipa_cmd) % 256,
-	0x05,
-	0x77, 0x77, 0x77, 0x77,
+	0x00, 0x00, 0x00, 0x00,  0x00, 0x24, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x05,  0x77, 0x77, 0x77, 0x77,
 	0x00, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0x00,
-	0x01, 0x00,
-		sizeof(struct qeth_ipa_cmd) / 256,
-		sizeof(struct qeth_ipa_cmd) % 256,
-	0x00, 0x00, 0x00, 0x40,
+	0x01, 0x00, 0x00, 0x00,  0x00, 0x00, 0x00, 0x40,
 };
 
 struct ipa_rc_msg {
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 07a48ee95dba..1ac88da91a40 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -21,8 +21,6 @@
 extern unsigned char IPA_PDU_HEADER[];
 #define QETH_IPA_CMD_DEST_ADDR(buffer) (buffer + 0x2c)
 
-#define IPA_CMD_LENGTH	(IPA_PDU_HEADER_SIZE + sizeof(struct qeth_ipa_cmd))
-
 #define QETH_SEQ_NO_LENGTH	4
 #define QETH_MPC_TOKEN_LENGTH	4
 #define QETH_MCL_LENGTH		4
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ef0b5eaf2532..453b3f7f272c 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1124,20 +1124,14 @@ static int qeth_osn_send_control_data(struct qeth_card *card, int len,
 }
 
 static int qeth_osn_send_ipa_cmd(struct qeth_card *card,
-			struct qeth_cmd_buffer *iob, int data_len)
+				 struct qeth_cmd_buffer *iob)
 {
-	u16 s1, s2;
+	u16 length;
 
 	QETH_CARD_TEXT(card, 4, "osndipa");
 
-	qeth_prepare_ipa_cmd(card, iob);
-	s1 = (u16)(IPA_PDU_HEADER_SIZE + data_len);
-	s2 = (u16)data_len;
-	memcpy(QETH_IPA_PDU_LEN_TOTAL(iob->data), &s1, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU1(iob->data), &s2, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU2(iob->data), &s2, 2);
-	memcpy(QETH_IPA_PDU_LEN_PDU3(iob->data), &s2, 2);
-	return qeth_osn_send_control_data(card, s1, iob);
+	memcpy(&length, QETH_IPA_PDU_LEN_TOTAL(iob->data), 2);
+	return qeth_osn_send_control_data(card, length, iob);
 }
 
 int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
@@ -1154,8 +1148,9 @@ int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
 	if (!qeth_card_hw_is_reachable(card))
 		return -ENODEV;
 	iob = qeth_wait_for_buffer(&card->write);
+	qeth_prepare_ipa_cmd(card, iob, (u16) data_len);
 	memcpy(__ipa_cmd(iob), data, data_len);
-	return qeth_osn_send_ipa_cmd(card, iob, data_len);
+	return qeth_osn_send_ipa_cmd(card, iob);
 }
 EXPORT_SYMBOL(qeth_osn_assist);
 
-- 
2.16.4
