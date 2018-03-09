Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 01/12] s390/qeth: use __ipa_cmd() for casting an IPA cmd buffer
Date: Fri,  9 Mar 2018 18:12:52 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-2-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

"s390/qeth: fix SETIP command handling" introduced a new helper, apply
it driver-wide.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 24 +++++++++++-------------
 drivers/s390/net/qeth_l2_main.c   | 14 ++++++--------
 drivers/s390/net/qeth_l3_main.c   | 14 +++++++-------
 3 files changed, 24 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c8b308cfabf1..d4cb0eea06b6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2951,12 +2951,10 @@ struct qeth_cmd_buffer *qeth_get_ipacmd_buffer(struct qeth_card *card,
 		enum qeth_ipa_cmds ipacmd, enum qeth_prot_versions prot)
 {
 	struct qeth_cmd_buffer *iob;
-	struct qeth_ipa_cmd *cmd;
 
 	iob = qeth_get_buffer(&card->write);
 	if (iob) {
-		cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-		qeth_fill_ipacmd_header(card, cmd, ipacmd, prot);
+		qeth_fill_ipacmd_header(card, __ipa_cmd(iob), ipacmd, prot);
 	} else {
 		dev_warn(&card->gdev->dev,
 			 "The qeth driver ran out of channel command buffers\n");
@@ -3067,7 +3065,7 @@ static struct qeth_cmd_buffer *qeth_get_adapter_cmd(struct qeth_card *card,
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SETADAPTERPARMS,
 				     QETH_PROT_IPV4);
 	if (iob) {
-		cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+		cmd = __ipa_cmd(iob);
 		cmd->data.setadapterparms.hdr.cmdlength = cmdlen;
 		cmd->data.setadapterparms.hdr.command_code = command;
 		cmd->data.setadapterparms.hdr.used_total = 1;
@@ -3209,7 +3207,7 @@ static int qeth_query_setdiagass(struct qeth_card *card)
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SET_DIAG_ASS, 0);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.diagass.subcmd_len = 16;
 	cmd->data.diagass.subcmd = QETH_DIAGS_CMD_QUERY;
 	return qeth_send_ipa_cmd(card, iob, qeth_query_setdiagass_cb, NULL);
@@ -3262,7 +3260,7 @@ int qeth_hw_trap(struct qeth_card *card, enum qeth_diags_trap_action action)
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SET_DIAG_ASS, 0);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.diagass.subcmd_len = 80;
 	cmd->data.diagass.subcmd = QETH_DIAGS_CMD_TRAP;
 	cmd->data.diagass.type = 1;
@@ -4240,7 +4238,7 @@ void qeth_setadp_promisc_mode(struct qeth_card *card)
 			sizeof(struct qeth_ipacmd_setadpparms_hdr) + 8);
 	if (!iob)
 		return;
-	cmd = (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.setadapterparms.data.mode = mode;
 	qeth_send_ipa_cmd(card, iob, qeth_setadp_promisc_mode_cb, NULL);
 }
@@ -4307,7 +4305,7 @@ int qeth_setadpparms_change_macaddr(struct qeth_card *card)
 				   sizeof(struct qeth_change_addr));
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.setadapterparms.data.change_addr.cmd = CHANGE_ADDR_READ_MAC;
 	cmd->data.setadapterparms.data.change_addr.addr_size = ETH_ALEN;
 	ether_addr_copy(cmd->data.setadapterparms.data.change_addr.addr,
@@ -4422,7 +4420,7 @@ static int qeth_setadpparms_set_access_ctrl(struct qeth_card *card,
 				   sizeof(struct qeth_set_access_ctrl));
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	access_ctrl_req = &cmd->data.setadapterparms.data.set_access_ctrl;
 	access_ctrl_req->subcmd_code = isolation;
 
@@ -4668,7 +4666,7 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 		rc = -ENOMEM;
 		goto out;
 	}
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	memcpy(&cmd->data.setadapterparms.data.snmp, &ureq->cmd, req_len);
 	rc = qeth_send_ipa_snmp_cmd(card, iob, QETH_SETADP_BASE_LEN + req_len,
 				    qeth_snmp_command_cb, (void *)&qinfo);
@@ -4753,7 +4751,7 @@ static int qeth_query_oat_command(struct qeth_card *card, char __user *udata)
 		rc = -ENOMEM;
 		goto out_free;
 	}
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	oat_req = &cmd->data.setadapterparms.data.query_oat;
 	oat_req->subcmd_code = oat_data.command;
 
@@ -5494,7 +5492,7 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *card,
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SETASSPARMS, prot);
 
 	if (iob) {
-		cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+		cmd = __ipa_cmd(iob);
 		cmd->data.setassparms.hdr.assist_no = ipa_func;
 		cmd->data.setassparms.hdr.length = 8 + len;
 		cmd->data.setassparms.hdr.command_code = cmd_code;
@@ -5517,7 +5515,7 @@ int qeth_send_setassparms(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 4, "sendassp");
 
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	if (len <= sizeof(__u32))
 		cmd->data.setassparms.data.flags_32bit = (__u32) data;
 	else   /* (len > sizeof(__u32)) */
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7f236440483f..1cd583b69eaa 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -108,7 +108,7 @@ static int qeth_l2_send_setdelmac(struct qeth_card *card, __u8 *mac,
 	iob = qeth_get_ipacmd_buffer(card, ipacmd, QETH_PROT_IPV4);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.setdelmac.mac_length = ETH_ALEN;
 	ether_addr_copy(cmd->data.setdelmac.mac, mac);
 	return qeth_setdelmac_makerc(card, qeth_send_ipa_cmd(card, iob,
@@ -305,7 +305,7 @@ static int qeth_l2_send_setdelvlan(struct qeth_card *card, __u16 i,
 	iob = qeth_get_ipacmd_buffer(card, ipacmd, QETH_PROT_IPV4);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.setdelvlan.vlan_id = i;
 	return qeth_setdelvlan_makerc(card, qeth_send_ipa_cmd(card, iob,
 					    qeth_l2_send_setdelvlan_cb, NULL));
@@ -1374,7 +1374,6 @@ int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
 {
 	struct qeth_cmd_buffer *iob;
 	struct qeth_card *card;
-	int rc;
 
 	if (!dev)
 		return -ENODEV;
@@ -1385,9 +1384,8 @@ int qeth_osn_assist(struct net_device *dev, void *data, int data_len)
 	if (!qeth_card_hw_is_reachable(card))
 		return -ENODEV;
 	iob = qeth_wait_for_buffer(&card->write);
-	memcpy(iob->data+IPA_PDU_HEADER_SIZE, data, data_len);
-	rc = qeth_osn_send_ipa_cmd(card, iob, data_len);
-	return rc;
+	memcpy(__ipa_cmd(iob), data, data_len);
+	return qeth_osn_send_ipa_cmd(card, iob, data_len);
 }
 EXPORT_SYMBOL(qeth_osn_assist);
 
@@ -1764,7 +1762,7 @@ static struct qeth_cmd_buffer *qeth_sbp_build_cmd(struct qeth_card *card,
 	iob = qeth_get_ipacmd_buffer(card, ipa_cmd, 0);
 	if (!iob)
 		return iob;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.sbp.hdr.cmdlength = sizeof(struct qeth_ipacmd_sbp_hdr) +
 				      cmd_length;
 	cmd->data.sbp.hdr.command_code = sbp_cmd;
@@ -2129,7 +2127,7 @@ static int qeth_l2_vnicc_request(struct qeth_card *card,
 		return -ENOMEM;
 
 	/* create header for request */
-	cmd = (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	req = &cmd->data.vnicc;
 
 	/* create sub command header for request */
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 962a04b68dd2..e5f11cd64fec 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -352,7 +352,7 @@ static int qeth_l3_send_setdelmc(struct qeth_card *card,
 	iob = qeth_get_ipacmd_buffer(card, ipacmd, addr->proto);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	ether_addr_copy(cmd->data.setdelipm.mac, addr->mac);
 	if (addr->proto == QETH_PROT_IPV6)
 		memcpy(cmd->data.setdelipm.ip6, &addr->u.a6.addr,
@@ -393,7 +393,7 @@ static int qeth_l3_send_setdelip(struct qeth_card *card,
 	iob = qeth_get_ipacmd_buffer(card, ipacmd, addr->proto);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	if (addr->proto == QETH_PROT_IPV6) {
 		memcpy(cmd->data.setdelip6.ip_addr, &addr->u.a6.addr,
 		       sizeof(struct in6_addr));
@@ -423,7 +423,7 @@ static int qeth_l3_send_setrouting(struct qeth_card *card,
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SETRTG, prot);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.setrtg.type = (type);
 	rc = qeth_send_ipa_cmd(card, iob, NULL, NULL);
 
@@ -1072,7 +1072,7 @@ static int qeth_l3_iqd_read_initial_mac(struct qeth_card *card)
 				     QETH_PROT_IPV6);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	*((__u16 *) &cmd->data.create_destroy_addr.unique_id[6]) =
 			card->info.unique_id;
 
@@ -1117,7 +1117,7 @@ static int qeth_l3_get_unique_id(struct qeth_card *card)
 				     QETH_PROT_IPV6);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	*((__u16 *) &cmd->data.create_destroy_addr.unique_id[6]) =
 			card->info.unique_id;
 
@@ -1193,7 +1193,7 @@ qeth_diags_trace(struct qeth_card *card, enum qeth_diags_trace_cmds diags_cmd)
 	iob = qeth_get_ipacmd_buffer(card, IPA_CMD_SET_DIAG_ASS, 0);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.diagass.subcmd_len = 16;
 	cmd->data.diagass.subcmd = QETH_DIAGS_CMD_TRACE;
 	cmd->data.diagass.type = QETH_DIAGS_TYPE_HIPERSOCKET;
@@ -2004,7 +2004,7 @@ static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
 				       prot);
 	if (!iob)
 		return -ENOMEM;
-	cmd = (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
+	cmd = __ipa_cmd(iob);
 	cmd->data.setassparms.data.query_arp.request_bits = 0x000F;
 	cmd->data.setassparms.data.query_arp.reply_bits = 0;
 	cmd->data.setassparms.data.query_arp.no_entries = 0;
-- 
2.13.5
