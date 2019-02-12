Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 10/10] s390/qeth: convert remaining legacy cmd callbacks
Date: Tue, 12 Feb 2019 18:33:25 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-11-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This calls the existing errno translation helpers from the callbacks,
adding trivial wrappers where necessary. For cmds that have no
sophisticated errno translation, default to -EIO.

For IPA cmds with no callback, fall back to a minimal default. This is
currently being used by qeth_l3_send_setrouting().

Thus having all converted all callbacks, remove the legacy path in
qeth_send_control_data_cb().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 113 +++++++++++++++++++-------------------
 drivers/s390/net/qeth_l2_main.c   |  37 ++++++-------
 drivers/s390/net/qeth_l3_main.c   |  74 ++++++++++++++++---------
 3 files changed, 121 insertions(+), 103 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cdb65ba99888..5ca934775c42 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -867,12 +867,7 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 	}
 
 	if (rc <= 0) {
-		if (cmd)
-			reply->rc = (u16) cmd->hdr.return_code;
-
-		/* for callbacks with proper errnos: */
-		if (rc < 0)
-			reply->rc = rc;
+		reply->rc = rc;
 		qeth_notify_reply(reply);
 	}
 
@@ -2039,15 +2034,13 @@ EXPORT_SYMBOL_GPL(qeth_prepare_control_data);
  *				for the IPA commands.
  * @reply_param:		private pointer passed to the callback
  *
- * Returns the value of the `return_code' field of the response
- * block returned from the hardware, or other error indication.
- * Value of zero indicates successful execution of the command.
- *
  * Callback function gets called one or more times, with cb_cmd
  * pointing to the response returned by the hardware. Callback
- * function must return non-zero if more reply blocks are expected,
- * and zero if the last or only reply block is received. Callback
- * function can get the value of the reply_param pointer from the
+ * function must return
+ *   > 0 if more reply blocks are expected,
+ *     0 if the last or only reply block is received, and
+ *   < 0 on error.
+ * Callback function can get the value of the reply_param pointer from the
  * field 'param' of the structure qeth_reply.
  */
 
@@ -2876,6 +2869,14 @@ struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 }
 EXPORT_SYMBOL_GPL(qeth_get_ipacmd_buffer);
 
+static int qeth_send_ipa_cmd_cb(struct qeth_card *card,
+				struct qeth_reply *reply, unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+
+	return (cmd->hdr.return_code) ? -EIO : 0;
+}
+
 /**
  * qeth_send_ipa_cmd() - send an IPA command
  *
@@ -2891,6 +2892,9 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 	int rc;
 
 	QETH_CARD_TEXT(card, 4, "sendipa");
+
+	if (reply_cb == NULL)
+		reply_cb = qeth_send_ipa_cmd_cb;
 	memcpy(&length, QETH_IPA_PDU_LEN_TOTAL(iob->data), 2);
 	rc = qeth_send_control_data(card, length, iob, reply_cb, reply_param);
 	if (rc == -ETIME) {
@@ -2939,7 +2943,7 @@ static int qeth_query_setadapterparms_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 3, "quyadpcb");
 	if (qeth_setadpparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	if (cmd->data.setadapterparms.data.query_cmds_supp.lan_type & 0x7f) {
 		card->info.link_type =
@@ -2994,19 +2998,18 @@ static int qeth_query_ipassists_cb(struct qeth_card *card,
 	cmd = (struct qeth_ipa_cmd *) data;
 
 	switch (cmd->hdr.return_code) {
+	case IPA_RC_SUCCESS:
+		break;
 	case IPA_RC_NOTSUPP:
 	case IPA_RC_L2_UNSUPPORTED_CMD:
 		QETH_DBF_TEXT(SETUP, 2, "ipaunsup");
 		card->options.ipa4.supported_funcs |= IPA_SETADAPTERPARMS;
 		card->options.ipa6.supported_funcs |= IPA_SETADAPTERPARMS;
-		return 0;
+		return -EOPNOTSUPP;
 	default:
-		if (cmd->hdr.return_code) {
-			QETH_DBF_MESSAGE(1, "IPA_CMD_QIPASSIST on device %x: Unhandled rc=%#x\n",
-					 CARD_DEVID(card),
-					 cmd->hdr.return_code);
-			return 0;
-		}
+		QETH_DBF_MESSAGE(1, "IPA_CMD_QIPASSIST on device %x: Unhandled rc=%#x\n",
+				 CARD_DEVID(card), cmd->hdr.return_code);
+		return -EIO;
 	}
 
 	if (cmd->hdr.prot_version == QETH_PROT_IPV4) {
@@ -3044,7 +3047,7 @@ static int qeth_query_switch_attributes_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "qswiatcb");
 	if (qeth_setadpparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	sw_info = (struct qeth_switch_info *)reply->param;
 	attrs = &cmd->data.setadapterparms.data.query_switch_attributes;
@@ -3076,15 +3079,15 @@ int qeth_query_switch_attributes(struct qeth_card *card,
 static int qeth_query_setdiagass_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
-	__u16 rc;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+	u16 rc = cmd->hdr.return_code;
 
-	cmd = (struct qeth_ipa_cmd *)data;
-	rc = cmd->hdr.return_code;
-	if (rc)
+	if (rc) {
 		QETH_CARD_TEXT_(card, 2, "diagq:%x", rc);
-	else
-		card->info.diagass_support = cmd->data.diagass.ext;
+		return -EIO;
+	}
+
+	card->info.diagass_support = cmd->data.diagass.ext;
 	return 0;
 }
 
@@ -3131,13 +3134,13 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 static int qeth_hw_trap_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
-	__u16 rc;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+	u16 rc = cmd->hdr.return_code;
 
-	cmd = (struct qeth_ipa_cmd *)data;
-	rc = cmd->hdr.return_code;
-	if (rc)
+	if (rc) {
 		QETH_CARD_TEXT_(card, 2, "trapc:%x", rc);
+		return -EIO;
+	}
 	return 0;
 }
 
@@ -4196,7 +4199,7 @@ static int qeth_setadp_promisc_mode_cb(struct qeth_card *card,
 		setparms->data.mode = SET_PROMISC_MODE_OFF;
 	}
 	card->info.promisc_mode = setparms->data.mode;
-	return 0;
+	return (cmd->hdr.return_code) ? -EIO : 0;
 }
 
 void qeth_setadp_promisc_mode(struct qeth_card *card)
@@ -4295,7 +4298,7 @@ static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 4, "setaccb");
 	if (cmd->hdr.return_code)
-		return 0;
+		return -EIO;
 	qeth_setadpparms_inspect_rc(cmd);
 
 	access_ctrl_req = &cmd->data.setadapterparms.data.set_access_ctrl;
@@ -4369,7 +4372,7 @@ static int qeth_setadpparms_set_access_ctrl_cb(struct qeth_card *card,
 			card->options.isolation = card->options.prev_isolation;
 		break;
 	}
-	return 0;
+	return (cmd->hdr.return_code) ? -EIO : 0;
 }
 
 static int qeth_setadpparms_set_access_ctrl(struct qeth_card *card,
@@ -4734,7 +4737,7 @@ static int qeth_query_card_info_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "qcrdincb");
 	if (qeth_setadpparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	card_info = &cmd->data.setadapterparms.data.card_info;
 	carrier_info->card_type = card_info->card_type;
@@ -5409,7 +5412,7 @@ static int qeth_setassparms_get_caps_cb(struct qeth_card *card,
 	struct qeth_ipa_caps *caps = reply->param;
 
 	if (qeth_setassparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	caps->supported = cmd->data.setassparms.data.caps.supported;
 	caps->enabled = cmd->data.setassparms.data.caps.enabled;
@@ -5419,18 +5422,18 @@ static int qeth_setassparms_get_caps_cb(struct qeth_card *card,
 int qeth_setassparms_cb(struct qeth_card *card,
 			struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
 	QETH_CARD_TEXT(card, 4, "defadpcb");
 
-	cmd = (struct qeth_ipa_cmd *) data;
-	if (cmd->hdr.return_code == 0) {
-		cmd->hdr.return_code = cmd->data.setassparms.hdr.return_code;
-		if (cmd->hdr.prot_version == QETH_PROT_IPV4)
-			card->options.ipa4.enabled_funcs = cmd->hdr.ipa_enabled;
-		if (cmd->hdr.prot_version == QETH_PROT_IPV6)
-			card->options.ipa6.enabled_funcs = cmd->hdr.ipa_enabled;
-	}
+	if (cmd->hdr.return_code)
+		return -EIO;
+
+	cmd->hdr.return_code = cmd->data.setassparms.hdr.return_code;
+	if (cmd->hdr.prot_version == QETH_PROT_IPV4)
+		card->options.ipa4.enabled_funcs = cmd->hdr.ipa_enabled;
+	if (cmd->hdr.prot_version == QETH_PROT_IPV6)
+		card->options.ipa6.enabled_funcs = cmd->hdr.ipa_enabled;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(qeth_setassparms_cb);
@@ -6303,7 +6306,7 @@ static int qeth_start_csum_cb(struct qeth_card *card, struct qeth_reply *reply,
 	u32 *features = reply->param;
 
 	if (qeth_setassparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	*features = cmd->data.setassparms.data.flags_32bit;
 	return 0;
@@ -6379,9 +6382,8 @@ static int qeth_set_csum_on(struct qeth_card *card, enum qeth_ipa_funcs cstype,
 static int qeth_set_ipa_csum(struct qeth_card *card, bool on, int cstype,
 			     enum qeth_prot_versions prot)
 {
-	int rc = (on) ? qeth_set_csum_on(card, cstype, prot) :
-			qeth_set_csum_off(card, cstype, prot);
-	return rc ? -EIO : 0;
+	return on ? qeth_set_csum_on(card, cstype, prot) :
+		    qeth_set_csum_off(card, cstype, prot);
 }
 
 static int qeth_start_tso_cb(struct qeth_card *card, struct qeth_reply *reply,
@@ -6391,7 +6393,7 @@ static int qeth_start_tso_cb(struct qeth_card *card, struct qeth_reply *reply,
 	struct qeth_tso_start_data *tso_data = reply->param;
 
 	if (qeth_setassparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	tso_data->mss = cmd->data.setassparms.data.tso.mss;
 	tso_data->supported = cmd->data.setassparms.data.tso.supported;
@@ -6457,10 +6459,7 @@ static int qeth_set_tso_on(struct qeth_card *card,
 static int qeth_set_ipa_tso(struct qeth_card *card, bool on,
 			    enum qeth_prot_versions prot)
 {
-	int rc = on ? qeth_set_tso_on(card, prot) :
-		      qeth_set_tso_off(card, prot);
-
-	return rc ? -EIO : 0;
+	return on ? qeth_set_tso_on(card, prot) : qeth_set_tso_off(card, prot);
 }
 
 static int qeth_set_ipa_rx_csum(struct qeth_card *card, bool on)
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 955fb24af418..c566139da43d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -35,7 +35,7 @@ static void qeth_l2_vnicc_init(struct qeth_card *card);
 static bool qeth_l2_vnicc_recover_timeout(struct qeth_card *card, u32 vnicc,
 					  u32 *timeout);
 
-static int qeth_setdelmac_makerc(struct qeth_card *card, int retcode)
+static int qeth_l2_setdelmac_makerc(struct qeth_card *card, u16 retcode)
 {
 	int rc;
 
@@ -62,9 +62,6 @@ static int qeth_setdelmac_makerc(struct qeth_card *card, int retcode)
 	case IPA_RC_L2_MAC_NOT_FOUND:
 		rc = -ENOENT;
 		break;
-	case -ENOMEM:
-		rc = -ENOMEM;
-		break;
 	default:
 		rc = -EIO;
 		break;
@@ -72,6 +69,15 @@ static int qeth_setdelmac_makerc(struct qeth_card *card, int retcode)
 	return rc;
 }
 
+static int qeth_l2_send_setdelmac_cb(struct qeth_card *card,
+				     struct qeth_reply *reply,
+				     unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+
+	return qeth_l2_setdelmac_makerc(card, cmd->hdr.return_code);
+}
+
 static int qeth_l2_send_setdelmac(struct qeth_card *card, __u8 *mac,
 			   enum qeth_ipa_cmds ipacmd)
 {
@@ -85,8 +91,7 @@ static int qeth_l2_send_setdelmac(struct qeth_card *card, __u8 *mac,
 	cmd = __ipa_cmd(iob);
 	cmd->data.setdelmac.mac_length = ETH_ALEN;
 	ether_addr_copy(cmd->data.setdelmac.mac, mac);
-	return qeth_setdelmac_makerc(card, qeth_send_ipa_cmd(card, iob,
-					   NULL, NULL));
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_send_setdelmac_cb, NULL);
 }
 
 static int qeth_l2_send_setmac(struct qeth_card *card, __u8 *mac)
@@ -205,7 +210,7 @@ static void qeth_l2_fill_header(struct qeth_card *card, struct qeth_hdr *hdr,
 	}
 }
 
-static int qeth_setdelvlan_makerc(struct qeth_card *card, int retcode)
+static int qeth_l2_setdelvlan_makerc(struct qeth_card *card, u16 retcode)
 {
 	if (retcode)
 		QETH_CARD_TEXT_(card, 2, "err%04x", retcode);
@@ -221,8 +226,6 @@ static int qeth_setdelvlan_makerc(struct qeth_card *card, int retcode)
 		return -ENOENT;
 	case IPA_RC_L2_VLAN_ID_NOT_ALLOWED:
 		return -EPERM;
-	case -ENOMEM:
-		return -ENOMEM;
 	default:
 		return -EIO;
 	}
@@ -240,9 +243,8 @@ static int qeth_l2_send_setdelvlan_cb(struct qeth_card *card,
 				 cmd->data.setdelvlan.vlan_id,
 				 CARD_DEVID(card), cmd->hdr.return_code);
 		QETH_CARD_TEXT_(card, 2, "L2VL%4x", cmd->hdr.command);
-		QETH_CARD_TEXT_(card, 2, "err%d", cmd->hdr.return_code);
 	}
-	return 0;
+	return qeth_l2_setdelvlan_makerc(card, cmd->hdr.return_code);
 }
 
 static int qeth_l2_send_setdelvlan(struct qeth_card *card, __u16 i,
@@ -257,8 +259,7 @@ static int qeth_l2_send_setdelvlan(struct qeth_card *card, __u16 i,
 		return -ENOMEM;
 	cmd = __ipa_cmd(iob);
 	cmd->data.setdelvlan.vlan_id = i;
-	return qeth_setdelvlan_makerc(card, qeth_send_ipa_cmd(card, iob,
-					    qeth_l2_send_setdelvlan_cb, NULL));
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_send_setdelvlan_cb, NULL);
 }
 
 static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
@@ -1790,7 +1791,7 @@ static bool qeth_bridgeport_is_in_use(struct qeth_card *card)
 /* VNIC Characteristics support */
 
 /* handle VNICC IPA command return codes; convert to error codes */
-static int qeth_l2_vnicc_makerc(struct qeth_card *card, int ipa_rc)
+static int qeth_l2_vnicc_makerc(struct qeth_card *card, u16 ipa_rc)
 {
 	int rc;
 
@@ -1848,7 +1849,7 @@ static int qeth_l2_vnicc_request_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 2, "vniccrcb");
 	if (cmd->hdr.return_code)
-		return 0;
+		return qeth_l2_vnicc_makerc(card, cmd->hdr.return_code);
 	/* return results to caller */
 	card->options.vnicc.sup_chars = rep->hdr.sup;
 	card->options.vnicc.cur_chars = rep->hdr.cur;
@@ -1869,7 +1870,6 @@ static int qeth_l2_vnicc_request(struct qeth_card *card,
 	struct qeth_ipacmd_vnicc *req;
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
-	int rc;
 
 	QETH_CARD_TEXT(card, 2, "vniccreq");
 
@@ -1912,10 +1912,7 @@ static int qeth_l2_vnicc_request(struct qeth_card *card,
 	}
 
 	/* send request */
-	rc = qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb,
-			       (void *) cbctl);
-
-	return qeth_l2_vnicc_makerc(card, rc);
+	return qeth_send_ipa_cmd(card, iob, qeth_l2_vnicc_request_cb, cbctl);
 }
 
 /* VNICC query VNIC characteristics request */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 852bfd5cc3e9..8eb24c7f2750 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -957,12 +957,13 @@ static int qeth_l3_start_ipassists(struct qeth_card *card)
 static int qeth_l3_iqd_read_initial_mac_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
-	cmd = (struct qeth_ipa_cmd *) data;
-	if (cmd->hdr.return_code == 0)
-		ether_addr_copy(card->dev->dev_addr,
-				cmd->data.create_destroy_addr.unique_id);
+	if (cmd->hdr.return_code)
+		return -EIO;
+
+	ether_addr_copy(card->dev->dev_addr,
+			cmd->data.create_destroy_addr.unique_id);
 	return 0;
 }
 
@@ -990,19 +991,18 @@ static int qeth_l3_iqd_read_initial_mac(struct qeth_card *card)
 static int qeth_l3_get_unique_id_cb(struct qeth_card *card,
 		struct qeth_reply *reply, unsigned long data)
 {
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 
-	cmd = (struct qeth_ipa_cmd *) data;
-	if (cmd->hdr.return_code == 0)
+	if (cmd->hdr.return_code == 0) {
 		card->info.unique_id = *((__u16 *)
 				&cmd->data.create_destroy_addr.unique_id[6]);
-	else {
-		card->info.unique_id =  UNIQUE_ID_IF_CREATE_ADDR_FAILED |
-					UNIQUE_ID_NOT_BY_CARD;
-		dev_warn(&card->gdev->dev, "The network adapter failed to "
-			"generate a unique ID\n");
+		return 0;
 	}
-	return 0;
+
+	card->info.unique_id = UNIQUE_ID_IF_CREATE_ADDR_FAILED |
+			       UNIQUE_ID_NOT_BY_CARD;
+	dev_warn(&card->gdev->dev, "The network adapter failed to generate a unique ID\n");
+	return -EIO;
 }
 
 static int qeth_l3_get_unique_id(struct qeth_card *card)
@@ -1085,7 +1085,7 @@ qeth_diags_trace_cb(struct qeth_card *card, struct qeth_reply *reply,
 				 cmd->data.diagass.action, CARD_DEVID(card));
 	}
 
-	return 0;
+	return rc ? -EIO : 0;
 }
 
 static int
@@ -1524,7 +1524,7 @@ static void qeth_l3_set_rx_mode(struct net_device *dev)
 	qeth_l3_handle_promisc_mode(card);
 }
 
-static int qeth_l3_arp_makerc(int rc)
+static int qeth_l3_arp_makerc(u16 rc)
 {
 	switch (rc) {
 	case IPA_RC_SUCCESS:
@@ -1541,8 +1541,18 @@ static int qeth_l3_arp_makerc(int rc)
 	}
 }
 
+static int qeth_l3_arp_cmd_cb(struct qeth_card *card, struct qeth_reply *reply,
+			      unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+
+	qeth_setassparms_cb(card, reply, data);
+	return qeth_l3_arp_makerc(cmd->hdr.return_code);
+}
+
 static int qeth_l3_arp_set_no_entries(struct qeth_card *card, int no_entries)
 {
+	struct qeth_cmd_buffer *iob;
 	int rc;
 
 	QETH_CARD_TEXT(card, 3, "arpstnoe");
@@ -1557,13 +1567,19 @@ static int qeth_l3_arp_set_no_entries(struct qeth_card *card, int no_entries)
 	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
 		return -EOPNOTSUPP;
 	}
-	rc = qeth_send_simple_setassparms(card, IPA_ARP_PROCESSING,
-					  IPA_CMD_ASS_ARP_SET_NO_ENTRIES,
-					  no_entries);
+
+	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING,
+				       IPA_CMD_ASS_ARP_SET_NO_ENTRIES, 4,
+				       QETH_PROT_IPV4);
+	if (!iob)
+		return -ENOMEM;
+
+	__ipa_cmd(iob)->data.setassparms.data.flags_32bit = (u32) no_entries;
+	rc = qeth_send_ipa_cmd(card, iob, qeth_l3_arp_cmd_cb, NULL);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "Could not set number of ARP entries on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
-	return qeth_l3_arp_makerc(rc);
+	return rc;
 }
 
 static __u32 get_arp_entry_size(struct qeth_card *card,
@@ -1792,16 +1808,16 @@ static int qeth_l3_arp_modify_entry(struct qeth_card *card,
 	cmd_entry = &__ipa_cmd(iob)->data.setassparms.data.arp_entry;
 	ether_addr_copy(cmd_entry->macaddr, entry->macaddr);
 	memcpy(cmd_entry->ipaddr, entry->ipaddr, 4);
-	rc = qeth_send_ipa_cmd(card, iob, qeth_setassparms_cb, NULL);
+	rc = qeth_send_ipa_cmd(card, iob, qeth_l3_arp_cmd_cb, NULL);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "Could not modify (cmd: %#x) ARP entry on device %x: %#x\n",
 				 arp_cmd, CARD_DEVID(card), rc);
-
-	return qeth_l3_arp_makerc(rc);
+	return rc;
 }
 
 static int qeth_l3_arp_flush_cache(struct qeth_card *card)
 {
+	struct qeth_cmd_buffer *iob;
 	int rc;
 
 	QETH_CARD_TEXT(card, 3, "arpflush");
@@ -1816,12 +1832,18 @@ static int qeth_l3_arp_flush_cache(struct qeth_card *card)
 	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
 		return -EOPNOTSUPP;
 	}
-	rc = qeth_send_simple_setassparms(card, IPA_ARP_PROCESSING,
-					  IPA_CMD_ASS_ARP_FLUSH_CACHE, 0);
+
+	iob = qeth_get_setassparms_cmd(card, IPA_ARP_PROCESSING,
+				       IPA_CMD_ASS_ARP_FLUSH_CACHE, 0,
+				       QETH_PROT_IPV4);
+	if (!iob)
+		return -ENOMEM;
+
+	rc = qeth_send_ipa_cmd(card, iob, qeth_l3_arp_cmd_cb, NULL);
 	if (rc)
 		QETH_DBF_MESSAGE(2, "Could not flush ARP cache on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
-	return qeth_l3_arp_makerc(rc);
+	return rc;
 }
 
 static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
-- 
2.16.4
