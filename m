Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/10] s390/qeth: align csum offload with TSO control logic
Date: Tue, 12 Feb 2019 18:33:19 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

csum offload and TSO have similar programming requirements. The TSO code
was reworked with commit "s390/qeth: enhance TSO control sequence",
adjust the csum control flow accordingly. Primarily this means replacing
custom helpers with more generic infrastructure.

Also, change the LP2LP check so that it warns on TX offload (not RX).
This is where reduced csum capability actually matters.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 129 ++++++++++++++------------------------
 drivers/s390/net/qeth_core_mpc.h  |   7 ---
 2 files changed, 47 insertions(+), 89 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 31720044656a..428175e1cb5d 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6267,66 +6267,33 @@ int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
 }
 EXPORT_SYMBOL_GPL(qeth_core_ethtool_get_link_ksettings);
 
-/* Callback to handle checksum offload command reply from OSA card.
- * Verify that required features have been enabled on the card.
- * Return error in hdr->return_code as this value is checked by caller.
- *
- * Always returns zero to indicate no further messages from the OSA card.
- */
-static int qeth_ipa_checksum_run_cmd_cb(struct qeth_card *card,
-					struct qeth_reply *reply,
-					unsigned long data)
+static int qeth_start_csum_cb(struct qeth_card *card, struct qeth_reply *reply,
+			      unsigned long data)
 {
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
-	struct qeth_checksum_cmd *chksum_cb =
-				(struct qeth_checksum_cmd *)reply->param;
+	u32 *features = reply->param;
 
-	QETH_CARD_TEXT(card, 4, "chkdoccb");
 	if (qeth_setassparms_inspect_rc(cmd))
 		return 0;
 
-	memset(chksum_cb, 0, sizeof(*chksum_cb));
-	if (cmd->data.setassparms.hdr.command_code == IPA_CMD_ASS_START) {
-		chksum_cb->supported =
-				cmd->data.setassparms.data.chksum.supported;
-		QETH_CARD_TEXT_(card, 3, "strt:%x", chksum_cb->supported);
-	}
-	if (cmd->data.setassparms.hdr.command_code == IPA_CMD_ASS_ENABLE) {
-		chksum_cb->supported =
-				cmd->data.setassparms.data.chksum.supported;
-		chksum_cb->enabled =
-				cmd->data.setassparms.data.chksum.enabled;
-		QETH_CARD_TEXT_(card, 3, "supp:%x", chksum_cb->supported);
-		QETH_CARD_TEXT_(card, 3, "enab:%x", chksum_cb->enabled);
-	}
+	*features = cmd->data.setassparms.data.flags_32bit;
 	return 0;
 }
 
-/* Send command to OSA card and check results. */
-static int qeth_ipa_checksum_run_cmd(struct qeth_card *card,
-				     enum qeth_ipa_funcs ipa_func,
-				     __u16 cmd_code, long data,
-				     struct qeth_checksum_cmd *chksum_cb,
-				     enum qeth_prot_versions prot)
+static int qeth_set_csum_off(struct qeth_card *card, enum qeth_ipa_funcs cstype,
+			     enum qeth_prot_versions prot)
 {
-	struct qeth_cmd_buffer *iob;
-
-	QETH_CARD_TEXT(card, 4, "chkdocmd");
-	iob = qeth_get_setassparms_cmd(card, ipa_func, cmd_code,
-				       sizeof(__u32), prot);
-	if (!iob)
-		return -ENOMEM;
-
-	__ipa_cmd(iob)->data.setassparms.data.flags_32bit = (__u32) data;
-	return qeth_send_ipa_cmd(card, iob, qeth_ipa_checksum_run_cmd_cb,
-				 chksum_cb);
+	return qeth_send_simple_setassparms_prot(card, cstype,
+						 IPA_CMD_ASS_STOP, 0, prot);
 }
 
-static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
-				 enum qeth_prot_versions prot)
+static int qeth_set_csum_on(struct qeth_card *card, enum qeth_ipa_funcs cstype,
+			    enum qeth_prot_versions prot)
 {
 	u32 required_features = QETH_IPA_CHECKSUM_UDP | QETH_IPA_CHECKSUM_TCP;
-	struct qeth_checksum_cmd chksum_cb;
+	struct qeth_cmd_buffer *iob;
+	struct qeth_ipa_caps caps;
+	u32 features;
 	int rc;
 
 	/* some L3 HW requires combined L3+L4 csum offload: */
@@ -6334,59 +6301,57 @@ static int qeth_send_checksum_on(struct qeth_card *card, int cstype,
 	    cstype == IPA_OUTBOUND_CHECKSUM)
 		required_features |= QETH_IPA_CHECKSUM_IP_HDR;
 
-	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_START, 0,
-				       &chksum_cb, prot);
-	if (!rc) {
-		if ((required_features & chksum_cb.supported) !=
-		    required_features)
-			rc = -EIO;
-		else if (!(QETH_IPA_CHECKSUM_LP2LP & chksum_cb.supported) &&
-			 cstype == IPA_INBOUND_CHECKSUM)
-			dev_warn(&card->gdev->dev,
-				 "Hardware checksumming is performed only if %s and its peer use different OSA Express 3 ports\n",
-				 QETH_CARD_IFNAME(card));
-	}
-	if (rc) {
-		qeth_send_simple_setassparms_prot(card, cstype,
-						  IPA_CMD_ASS_STOP, 0, prot);
-		dev_warn(&card->gdev->dev,
-			 "Starting HW IPv%d checksumming for %s failed, using SW checksumming\n",
-			 prot, QETH_CARD_IFNAME(card));
+	iob = qeth_get_setassparms_cmd(card, cstype, IPA_CMD_ASS_START, 0,
+				       prot);
+	if (!iob)
+		return -ENOMEM;
+
+	rc = qeth_send_ipa_cmd(card, iob, qeth_start_csum_cb, &features);
+	if (rc)
 		return rc;
-	}
 
-	if (chksum_cb.supported & QETH_IPA_CHECKSUM_LP2LP)
-		required_features |= QETH_IPA_CHECKSUM_LP2LP;
+	if ((required_features & features) != required_features) {
+		qeth_set_csum_off(card, cstype, prot);
+		return -EOPNOTSUPP;
+	}
 
-	rc = qeth_ipa_checksum_run_cmd(card, cstype, IPA_CMD_ASS_ENABLE,
-				       required_features, &chksum_cb,
+	iob = qeth_get_setassparms_cmd(card, cstype, IPA_CMD_ASS_ENABLE, 4,
 				       prot);
-	if (!rc) {
-		if ((required_features & chksum_cb.enabled) !=
-		    required_features)
-			rc = -EIO;
+	if (!iob) {
+		qeth_set_csum_off(card, cstype, prot);
+		return -ENOMEM;
 	}
+
+	if (features & QETH_IPA_CHECKSUM_LP2LP)
+		required_features |= QETH_IPA_CHECKSUM_LP2LP;
+	__ipa_cmd(iob)->data.setassparms.data.flags_32bit = required_features;
+	rc = qeth_send_ipa_cmd(card, iob, qeth_setassparms_get_caps_cb, &caps);
 	if (rc) {
-		qeth_send_simple_setassparms_prot(card, cstype,
-						  IPA_CMD_ASS_STOP, 0, prot);
-		dev_warn(&card->gdev->dev,
-			 "Enabling HW IPv%d checksumming for %s failed, using SW checksumming\n",
-			 prot, QETH_CARD_IFNAME(card));
+		qeth_set_csum_off(card, cstype, prot);
 		return rc;
 	}
 
+	if (!qeth_ipa_caps_supported(&caps, required_features) ||
+	    !qeth_ipa_caps_enabled(&caps, required_features)) {
+		qeth_set_csum_off(card, cstype, prot);
+		return -EOPNOTSUPP;
+	}
+
 	dev_info(&card->gdev->dev, "HW Checksumming (%sbound IPv%d) enabled\n",
 		 cstype == IPA_INBOUND_CHECKSUM ? "in" : "out", prot);
+	if (!qeth_ipa_caps_enabled(&caps, QETH_IPA_CHECKSUM_LP2LP) &&
+	    cstype == IPA_OUTBOUND_CHECKSUM)
+		dev_warn(&card->gdev->dev,
+			 "Hardware checksumming is performed only if %s and its peer use different OSA Express 3 ports\n",
+			 QETH_CARD_IFNAME(card));
 	return 0;
 }
 
 static int qeth_set_ipa_csum(struct qeth_card *card, bool on, int cstype,
 			     enum qeth_prot_versions prot)
 {
-	int rc = (on) ? qeth_send_checksum_on(card, cstype, prot)
-		      : qeth_send_simple_setassparms_prot(card, cstype,
-							  IPA_CMD_ASS_STOP, 0,
-							  prot);
+	int rc = (on) ? qeth_set_csum_on(card, cstype, prot) :
+			qeth_set_csum_off(card, cstype, prot);
 	return rc ? -EIO : 0;
 }
 
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 1ac88da91a40..7919a0c8109a 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -417,12 +417,6 @@ enum qeth_ipa_checksum_bits {
 	QETH_IPA_CHECKSUM_LP2LP		= 0x0020
 };
 
-/* IPA Assist checksum offload reply layout. */
-struct qeth_checksum_cmd {
-	__u32 supported;
-	__u32 enabled;
-} __packed;
-
 enum qeth_ipa_large_send_caps {
 	QETH_IPA_LARGE_SEND_TCP		= 0x00000001,
 };
@@ -438,7 +432,6 @@ struct qeth_ipacmd_setassparms {
 	union {
 		__u32 flags_32bit;
 		struct qeth_ipa_caps caps;
-		struct qeth_checksum_cmd chksum;
 		struct qeth_arp_cache_entry arp_entry;
 		struct qeth_arp_query_data query_arp;
 		struct qeth_tso_start_data tso;
-- 
2.16.4
