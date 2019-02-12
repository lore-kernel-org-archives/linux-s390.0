Return-Path: <SRS0=RTe9=QT=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 08/10] s390/qeth: allow cmd callbacks to return errnos
Date: Tue, 12 Feb 2019 18:33:23 +0100
In-Reply-To: <20190212173325.36555-1-jwi@linux.ibm.com>
References: <20190212173325.36555-1-jwi@linux.ibm.com>
Message-Id: <20190212173325.36555-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Error propagation from cmd callbacks currently works in a way where
qeth_send_control_data_cb() picks the raw HW code from the response,
and the cmd's originator later translates this into an errno.
The callback itself only returns 0 ("done") or 1 ("expect more data").

This is
1. limiting, as the only means for the callback to report an internal
error is to invent pseudo HW codes (such as IPA_RC_ENOMEM), that
the originator then needs to understand. For non-IPA callbacks, we
even provide a separate field in the IO buffer metadata (iob->rc) so
the callback can pass back a return value.
2. fragile, as the originator must take care to not translate any errno
that is returned by qeth's own IO code paths (eg -ENOMEM). Also, any
originator that forgets to translate the HW codes potentially passes
garbage back to its caller. For instance, see
commit 2aa4867198c2 ("s390/qeth: translate SETVLAN/DELVLAN errors").

Introduce a new model where all HW error translation is done within the
callback, and the callback returns
>  0, if it expects more data (as before)
== 0, on success
<  0, with an errno

Start off with converting all callbacks to the new model that either
a) pass back pseudo HW codes, or b) have a dependency on a specific
HW error code. Also convert c) the one callback that uses iob->rc, and
d) qeth_setadpparms_change_macaddr_cb() so that it can pass back an
error back to qeth_l2_request_initial_mac() even when the cmd itself
was successful.

The old model remains supported: if the callback returns 0, we still
propagate the response's HW error code back to the originator.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 82 +++++++++++++++++++++------------------
 drivers/s390/net/qeth_core_mpc.c  |  4 +-
 drivers/s390/net/qeth_core_mpc.h  |  1 -
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   | 50 ++++++++++++++----------
 6 files changed, 76 insertions(+), 64 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 83f710336685..18696ffb662d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -597,7 +597,6 @@ struct qeth_cmd_buffer {
 	struct qeth_channel *channel;
 	struct qeth_reply *reply;
 	unsigned char *data;
-	int rc;
 	void (*callback)(struct qeth_card *card, struct qeth_channel *channel,
 			 struct qeth_cmd_buffer *iob);
 };
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index b1a7a35a086e..cdb65ba99888 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -747,7 +747,6 @@ void qeth_release_buffer(struct qeth_channel *channel,
 		qeth_put_reply(iob->reply);
 		iob->reply = NULL;
 	}
-	iob->rc = 0;
 	spin_unlock_irqrestore(&channel->iob_lock, flags);
 	wake_up(&channel->wait_q);
 }
@@ -809,7 +808,6 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 	struct qeth_reply *reply = NULL;
 	struct qeth_reply *r;
 	unsigned long flags;
-	int keep_reply = 0;
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 4, "sndctlcb");
@@ -857,22 +855,27 @@ static void qeth_send_control_data_cb(struct qeth_card *card,
 	if (!reply)
 		goto out;
 
-	if (reply->callback) {
+	if (!reply->callback) {
+		rc = 0;
+	} else {
 		if (cmd) {
 			reply->offset = (u16)((char *)cmd - (char *)iob->data);
-			keep_reply = reply->callback(card, reply,
-						     (unsigned long)cmd);
-		} else
-			keep_reply = reply->callback(card, reply,
-						     (unsigned long)iob);
+			rc = reply->callback(card, reply, (unsigned long)cmd);
+		} else {
+			rc = reply->callback(card, reply, (unsigned long)iob);
+		}
 	}
-	if (cmd)
-		reply->rc = (u16) cmd->hdr.return_code;
-	else if (iob->rc)
-		reply->rc = iob->rc;
 
-	if (!keep_reply)
+	if (rc <= 0) {
+		if (cmd)
+			reply->rc = (u16) cmd->hdr.return_code;
+
+		/* for callbacks with proper errnos: */
+		if (rc < 0)
+			reply->rc = rc;
 		qeth_notify_reply(reply);
+	}
+
 	qeth_put_reply(reply);
 
 out:
@@ -1293,7 +1296,6 @@ static int qeth_setup_channel(struct qeth_channel *channel, bool alloc_buffers)
 		channel->iob[cnt].state = BUF_STATE_FREE;
 		channel->iob[cnt].channel = channel;
 		channel->iob[cnt].callback = qeth_send_control_data_cb;
-		channel->iob[cnt].rc = 0;
 	}
 	if (cnt < QETH_CMD_BUFFER_NO) {
 		qeth_clean_channel(channel);
@@ -2343,9 +2345,8 @@ static int qeth_ulp_setup_cb(struct qeth_card *card, struct qeth_reply *reply,
 		QETH_DBF_TEXT(SETUP, 2, "olmlimit");
 		dev_err(&card->gdev->dev, "A connection could not be "
 			"established because of an OLM limit\n");
-		iob->rc = -EMLINK;
+		return -EMLINK;
 	}
-	QETH_DBF_TEXT_(SETUP, 2, "  rc%d", iob->rc);
 	return 0;
 }
 
@@ -2900,9 +2901,19 @@ int qeth_send_ipa_cmd(struct qeth_card *card, struct qeth_cmd_buffer *iob,
 }
 EXPORT_SYMBOL_GPL(qeth_send_ipa_cmd);
 
+static int qeth_send_startlan_cb(struct qeth_card *card,
+				 struct qeth_reply *reply, unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+
+	if (cmd->hdr.return_code == IPA_RC_LAN_OFFLINE)
+		return -ENETDOWN;
+
+	return (cmd->hdr.return_code) ? -EIO : 0;
+}
+
 static int qeth_send_startlan(struct qeth_card *card)
 {
-	int rc;
 	struct qeth_cmd_buffer *iob;
 
 	QETH_DBF_TEXT(SETUP, 2, "strtlan");
@@ -2910,8 +2921,7 @@ static int qeth_send_startlan(struct qeth_card *card)
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_STARTLAN, 0);
 	if (!iob)
 		return -ENOMEM;
-	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
-	return rc;
+	return qeth_send_ipa_cmd(card, iob, qeth_send_startlan_cb, NULL);
 }
 
 static int qeth_setadpparms_inspect_rc(struct qeth_ipa_cmd *cmd)
@@ -4238,12 +4248,15 @@ static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 4, "chgmaccb");
 	if (qeth_setadpparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	adp_cmd = &cmd->data.setadapterparms;
+	if (!is_valid_ether_addr(adp_cmd->data.change_addr.addr))
+		return -EADDRNOTAVAIL;
+
 	if (IS_LAYER2(card) && IS_OSD(card) && !IS_VM_NIC(card) &&
 	    !(adp_cmd->hdr.flags & QETH_SETADP_FLAGS_VIRTUAL_MAC))
-		return 0;
+		return -EADDRNOTAVAIL;
 
 	ether_addr_copy(card->dev->dev_addr, adp_cmd->data.change_addr.addr);
 	return 0;
@@ -4507,13 +4520,13 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT_(card, 4, "scer1%x", cmd->hdr.return_code);
-		return 0;
+		return -EIO;
 	}
 	if (cmd->data.setadapterparms.hdr.return_code) {
 		cmd->hdr.return_code =
 			cmd->data.setadapterparms.hdr.return_code;
 		QETH_CARD_TEXT_(card, 4, "scer2%x", cmd->hdr.return_code);
-		return 0;
+		return -EIO;
 	}
 	data_len = *((__u16 *)QETH_IPA_PDU_LEN_PDU1(data));
 	if (cmd->data.setadapterparms.hdr.seq_no == 1) {
@@ -4528,9 +4541,8 @@ static int qeth_snmp_command_cb(struct qeth_card *card,
 
 	/* check if there is enough room in userspace */
 	if ((qinfo->udata_len - qinfo->udata_offset) < data_len) {
-		QETH_CARD_TEXT_(card, 4, "scer3%i", -ENOMEM);
-		cmd->hdr.return_code = IPA_RC_ENOMEM;
-		return 0;
+		QETH_CARD_TEXT_(card, 4, "scer3%i", -ENOSPC);
+		return -ENOSPC;
 	}
 	QETH_CARD_TEXT_(card, 4, "snore%i",
 		       cmd->data.setadapterparms.hdr.used_total);
@@ -4625,16 +4637,14 @@ static int qeth_setadpparms_query_oat_cb(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 3, "qoatcb");
 	if (qeth_setadpparms_inspect_rc(cmd))
-		return 0;
+		return -EIO;
 
 	priv = (struct qeth_qoat_priv *)reply->param;
 	resdatalen = cmd->data.setadapterparms.hdr.cmdlength;
 	resdata = (char *)data + 28;
 
-	if (resdatalen > (priv->buffer_len - priv->response_len)) {
-		cmd->hdr.return_code = IPA_RC_FFFF;
-		return 0;
-	}
+	if (resdatalen > (priv->buffer_len - priv->response_len))
+		return -ENOSPC;
 
 	memcpy((priv->buffer + priv->response_len), resdata,
 		resdatalen);
@@ -4707,9 +4717,7 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 		if (copy_to_user(udata, &oat_data,
 		    sizeof(struct qeth_query_oat_data)))
 			rc = -EFAULT;
-	} else
-		if (rc == IPA_RC_FFFF)
-			rc = -EFAULT;
+	}
 
 out_free:
 	vfree(priv.buffer);
@@ -5128,12 +5136,10 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	rc = qeth_send_startlan(card);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "6err%d", rc);
-		if (rc == IPA_RC_LAN_OFFLINE) {
-			dev_warn(&card->gdev->dev,
-				"The LAN is offline\n");
+		if (rc == -ENETDOWN) {
+			dev_warn(&card->gdev->dev, "The LAN is offline\n");
 			*carrier_ok = false;
 		} else {
-			rc = -ENODEV;
 			goto out;
 		}
 	} else {
diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index 7ff221ae0a2e..e3f4866c158e 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -201,12 +201,10 @@ static const struct ipa_rc_msg qeth_ipa_rc_msg[] = {
 	{IPA_RC_LAN_OFFLINE,		"STRTLAN_LAN_DISABLED - LAN offline"},
 	{IPA_RC_VEPA_TO_VEB_TRANSITION,	"Adj. switch disabled port mode RR"},
 	{IPA_RC_INVALID_IP_VERSION2,	"Invalid IP version"},
-	{IPA_RC_ENOMEM,			"Memory problem"},
+	/* default for qeth_get_ipa_msg(): */
 	{IPA_RC_FFFF,			"Unknown Error"}
 };
 
-
-
 const char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc)
 {
 	int x;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 7919a0c8109a..4b1690380ebe 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -229,7 +229,6 @@ enum qeth_ipa_return_codes {
 	IPA_RC_LAN_OFFLINE		= 0xe080,
 	IPA_RC_VEPA_TO_VEB_TRANSITION	= 0xe090,
 	IPA_RC_INVALID_IP_VERSION2	= 0xf001,
-	IPA_RC_ENOMEM			= 0xfffe,
 	IPA_RC_FFFF			= 0xffff
 };
 /* for VNIC Characteristics */
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 453b3f7f272c..6d9eb54ea3b0 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -393,7 +393,7 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 
 	if (!IS_OSN(card)) {
 		rc = qeth_setadpparms_change_macaddr(card);
-		if (!rc && is_valid_ether_addr(card->dev->dev_addr))
+		if (!rc)
 			goto out;
 		QETH_DBF_MESSAGE(2, "READ_MAC Assist failed on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index f0b790810ebc..852bfd5cc3e9 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -253,8 +253,7 @@ static int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 		} else
 			rc = qeth_l3_register_addr_entry(card, addr);
 
-		if (!rc || (rc == IPA_RC_DUPLICATE_IP_ADDRESS) ||
-				(rc == IPA_RC_LAN_OFFLINE)) {
+		if (!rc || rc == -EADDRINUSE || rc == -ENETDOWN) {
 			addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			if (addr->ref_counter < 1) {
 				qeth_l3_deregister_addr_entry(card, addr);
@@ -338,10 +337,28 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 
 }
 
+static int qeth_l3_setdelip_cb(struct qeth_card *card, struct qeth_reply *reply,
+			       unsigned long data)
+{
+	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
+
+	switch (cmd->hdr.return_code) {
+	case IPA_RC_SUCCESS:
+		return 0;
+	case IPA_RC_DUPLICATE_IP_ADDRESS:
+		return -EADDRINUSE;
+	case IPA_RC_MC_ADDR_NOT_FOUND:
+		return -ENOENT;
+	case IPA_RC_LAN_OFFLINE:
+		return -ENETDOWN;
+	default:
+		return -EIO;
+	}
+}
+
 static int qeth_l3_send_setdelmc(struct qeth_card *card,
 			struct qeth_ipaddr *addr, int ipacmd)
 {
-	int rc;
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
 
@@ -358,9 +375,7 @@ static int qeth_l3_send_setdelmc(struct qeth_card *card,
 	else
 		memcpy(&cmd->data.setdelipm.ip4, &addr->u.a4.addr, 4);
 
-	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
-
-	return rc;
+	return qeth_send_ipa_cmd(card, iob, qeth_l3_setdelip_cb, NULL);
 }
 
 static void qeth_l3_fill_netmask(u8 *netmask, unsigned int len)
@@ -422,7 +437,7 @@ static int qeth_l3_send_setdelip(struct qeth_card *card,
 		cmd->data.setdelip4.flags = flags;
 	}
 
-	return qeth_send_ipa_cmd(card, iob, NULL, NULL);
+	return qeth_send_ipa_cmd(card, iob, qeth_l3_setdelip_cb, NULL);
 }
 
 static int qeth_l3_send_setrouting(struct qeth_card *card,
@@ -1481,14 +1496,14 @@ static void qeth_l3_set_rx_mode(struct net_device *dev)
 			switch (addr->disp_flag) {
 			case QETH_DISP_ADDR_DELETE:
 				rc = qeth_l3_deregister_addr_entry(card, addr);
-				if (!rc || rc == IPA_RC_MC_ADDR_NOT_FOUND) {
+				if (!rc || rc == -ENOENT) {
 					hash_del(&addr->hnode);
 					kfree(addr);
 				}
 				break;
 			case QETH_DISP_ADDR_ADD:
 				rc = qeth_l3_register_addr_entry(card, addr);
-				if (rc && rc != IPA_RC_LAN_OFFLINE) {
+				if (rc && rc != -ENETDOWN) {
 					hash_del(&addr->hnode);
 					kfree(addr);
 					break;
@@ -1599,7 +1614,6 @@ static int qeth_l3_arp_query_cb(struct qeth_card *card,
 	struct qeth_ipa_cmd *cmd;
 	struct qeth_arp_query_data *qdata;
 	struct qeth_arp_query_info *qinfo;
-	int i;
 	int e;
 	int entrybytes_done;
 	int stripped_bytes;
@@ -1613,13 +1627,13 @@ static int qeth_l3_arp_query_cb(struct qeth_card *card,
 	if (cmd->hdr.return_code) {
 		QETH_CARD_TEXT(card, 4, "arpcberr");
 		QETH_CARD_TEXT_(card, 4, "%i", cmd->hdr.return_code);
-		return 0;
+		return qeth_l3_arp_makerc(cmd->hdr.return_code);
 	}
 	if (cmd->data.setassparms.hdr.return_code) {
 		cmd->hdr.return_code = cmd->data.setassparms.hdr.return_code;
 		QETH_CARD_TEXT(card, 4, "setaperr");
 		QETH_CARD_TEXT_(card, 4, "%i", cmd->hdr.return_code);
-		return 0;
+		return qeth_l3_arp_makerc(cmd->hdr.return_code);
 	}
 	qdata = &cmd->data.setassparms.data.query_arp;
 	QETH_CARD_TEXT_(card, 4, "anoen%i", qdata->no_entries);
@@ -1646,9 +1660,9 @@ static int qeth_l3_arp_query_cb(struct qeth_card *card,
 			break;
 
 		if ((qinfo->udata_len - qinfo->udata_offset) < esize) {
-			QETH_CARD_TEXT_(card, 4, "qaer3%i", -ENOMEM);
-			cmd->hdr.return_code = IPA_RC_ENOMEM;
-			goto out_error;
+			QETH_CARD_TEXT_(card, 4, "qaer3%i", -ENOSPC);
+			memset(qinfo->udata, 0, 4);
+			return -ENOSPC;
 		}
 
 		memcpy(qinfo->udata + qinfo->udata_offset,
@@ -1671,10 +1685,6 @@ static int qeth_l3_arp_query_cb(struct qeth_card *card,
 	memcpy(qinfo->udata + QETH_QARP_MASK_OFFSET, &qdata->reply_bits, 2);
 	QETH_CARD_TEXT_(card, 4, "rc%i", 0);
 	return 0;
-out_error:
-	i = 0;
-	memcpy(qinfo->udata, &i, 4);
-	return 0;
 }
 
 static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
@@ -1700,7 +1710,7 @@ static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
 	if (rc)
 		QETH_DBF_MESSAGE(2, "Error while querying ARP cache on device %x: %#x\n",
 				 CARD_DEVID(card), rc);
-	return qeth_l3_arp_makerc(rc);
+	return rc;
 }
 
 static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
-- 
2.16.4
