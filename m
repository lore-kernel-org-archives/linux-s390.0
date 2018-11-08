From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/8] s390/qeth: remove two IPA command helpers
Date: Thu,  8 Nov 2018 15:06:20 +0100
Message-ID: <20181108140622.35244-7-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_l3_send_ipa_arp_cmd() is merely a wrapper around
qeth_send_control_data() now. So push the length adjustment into
QETH_SETASS_BASE_LEN, and remove the wrapper. While at it, also remove
some redundant 0-initializations.

qeth_send_setassparms() requires that callers prepare their command
parameters, so that they can be copied into the parameter area in one
go. Skip the indirection, and just let callers set up the command
themselves.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 51 ++++++++++-----------------------------
 drivers/s390/net/qeth_core_mpc.h  |  7 +++---
 drivers/s390/net/qeth_l3_main.c   | 20 +++------------
 3 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c1315ac63041..ae972461860e 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5475,34 +5475,11 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *card,
 }
 EXPORT_SYMBOL_GPL(qeth_get_setassparms_cmd);
 
-static int qeth_send_setassparms(struct qeth_card *card,
-				 struct qeth_cmd_buffer *iob, u16 len,
-				 long data, int (*reply_cb)(struct qeth_card *,
-							    struct qeth_reply *,
-							    unsigned long),
-				 void *reply_param)
-{
-	int rc;
-	struct qeth_ipa_cmd *cmd;
-
-	QETH_CARD_TEXT(card, 4, "sendassp");
-
-	cmd = __ipa_cmd(iob);
-	if (len <= sizeof(__u32))
-		cmd->data.setassparms.data.flags_32bit = (__u32) data;
-	else   /* (len > sizeof(__u32)) */
-		memcpy(&cmd->data.setassparms.data, (void *) data, len);
-
-	rc = qeth_send_ipa_cmd(card, iob, reply_cb, reply_param);
-	return rc;
-}
-
 int qeth_send_simple_setassparms_prot(struct qeth_card *card,
 				      enum qeth_ipa_funcs ipa_func,
 				      u16 cmd_code, long data,
 				      enum qeth_prot_versions prot)
 {
-	int rc;
 	int length = 0;
 	struct qeth_cmd_buffer *iob;
 
@@ -5512,9 +5489,9 @@ int qeth_send_simple_setassparms_prot(struct qeth_card *card,
 	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code, length, prot);
 	if (!iob)
 		return -ENOMEM;
-	rc = qeth_send_setassparms(card, iob, length, data,
-				   qeth_setassparms_cb, NULL);
-	return rc;
+
+	__ipa_cmd(iob)->data.setassparms.data.flags_32bit = (__u32) data;
+	return qeth_send_ipa_cmd(card, iob, qeth_setassparms_cb, NULL);
 }
 EXPORT_SYMBOL_GPL(qeth_send_simple_setassparms_prot);
 
@@ -6385,16 +6362,16 @@ static int qeth_ipa_checksum_run_cmd(struct qeth_card *card,
 				     enum qeth_prot_versions prot)
 {
 	struct qeth_cmd_buffer *iob;
-	int rc = -ENOMEM;
 
 	QETH_CARD_TEXT(card, 4, "chkdocmd");
 	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code,
 				       sizeof(__u32), prot);
-	if (iob)
-		rc = qeth_send_setassparms(card, iob, sizeof(__u32), data,
-					   qeth_ipa_checksum_run_cmd_cb,
-					   chksum_cb);
-	return rc;
+	if (!iob)
+		return -ENOMEM;
+
+	__ipa_cmd(iob)->data.setassparms.data.flags_32bit = (__u32) data;
+	return qeth_send_ipa_cmd(card, iob, qeth_ipa_checksum_run_cmd_cb,
+				 chksum_cb);
 }
 
 static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
@@ -6492,8 +6469,7 @@ static int qeth_set_tso_on(struct qeth_card *card,
 	if (!iob)
 		return -ENOMEM;
 
-	rc = qeth_send_setassparms(card, iob, 0, 0 /* unused */,
-				   qeth_start_tso_cb, &tso_data);
+	rc = qeth_send_ipa_cmd(card, iob, qeth_start_tso_cb, &tso_data);
 	if (rc)
 		return rc;
 
@@ -6510,10 +6486,9 @@ static int qeth_set_tso_on(struct qeth_card *card,
 	}
 
 	/* enable TSO capability */
-	caps.supported = 0;
-	caps.enabled = QETH_IPA_LARGE_SEND_TCP;
-	rc = qeth_send_setassparms(card, iob, sizeof(caps), (long) &caps,
-				   qeth_setassparms_get_caps_cb, &caps);
+	__ipa_cmd(iob)->data.setassparms.data.caps.enabled =
+		QETH_IPA_LARGE_SEND_TCP;
+	rc = qeth_send_ipa_cmd(card, iob, qeth_setassparms_get_caps_cb, &caps);
 	if (rc) {
 		qeth_set_tso_off(card, prot);
 		return rc;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 10cc487c16d6..1ab321926f64 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -833,10 +833,9 @@ enum qeth_ipa_arp_return_codes {
 extern const char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc);
 extern const char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd);
 
-#define QETH_SETASS_BASE_LEN (sizeof(struct qeth_ipacmd_hdr) + \
-			       sizeof(struct qeth_ipacmd_setassparms_hdr))
-#define QETH_IPA_ARP_DATA_POS(buffer) (buffer + IPA_PDU_HEADER_SIZE + \
-				       QETH_SETASS_BASE_LEN)
+#define QETH_SETASS_BASE_LEN (IPA_PDU_HEADER_SIZE + \
+			      sizeof(struct qeth_ipacmd_hdr) + \
+			      sizeof(struct qeth_ipacmd_setassparms_hdr))
 #define QETH_SETADP_BASE_LEN (sizeof(struct qeth_ipacmd_hdr) + \
 			      sizeof(struct qeth_ipacmd_setadpparms_hdr))
 #define QETH_SNMP_SETADP_CMDLENGTH 16
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ce5ef6aca891..89d5e6fb21ac 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1685,18 +1685,6 @@ static int qeth_l3_arp_query_cb(struct qeth_card *card,
 	return 0;
 }
 
-static int qeth_l3_send_ipa_arp_cmd(struct qeth_card *card,
-		struct qeth_cmd_buffer *iob, int len,
-		int (*reply_cb)(struct qeth_card *, struct qeth_reply *,
-			unsigned long),
-		void *reply_param)
-{
-	QETH_CARD_TEXT(card, 4, "sendarp");
-
-	return qeth_send_control_data(card, IPA_PDU_HEADER_SIZE + len, iob,
-				      reply_cb, reply_param);
-}
-
 static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
 	enum qeth_prot_versions prot,
 	struct qeth_arp_query_info *qinfo)
@@ -1716,11 +1704,9 @@ static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
 		return -ENOMEM;
 	cmd = __ipa_cmd(iob);
 	cmd->data.setassparms.data.query_arp.request_bits = 0x000F;
-	cmd->data.setassparms.data.query_arp.reply_bits = 0;
-	cmd->data.setassparms.data.query_arp.no_entries = 0;
-	rc = qeth_l3_send_ipa_arp_cmd(card, iob,
-			   QETH_SETASS_BASE_LEN+QETH_ARP_CMD_LEN,
-			   qeth_l3_arp_query_cb, (void *)qinfo);
+	rc = qeth_send_control_data(card,
+				    QETH_SETASS_BASE_LEN + QETH_ARP_CMD_LEN,
+				    iob, qeth_l3_arp_query_cb, qinfo);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "Error while querying ARP cache on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
-- 
2.16.4
