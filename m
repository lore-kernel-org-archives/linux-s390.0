Return-Path: <SRS0=fYmv=S3=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/8] s390/qeth: use IS_* helpers for checking device type
Date: Thu, 25 Apr 2019 18:25:57 +0200
In-Reply-To: <20190425162601.91997-1-jwi@linux.ibm.com>
References: <20190425162601.91997-1-jwi@linux.ibm.com>
Message-Id: <20190425162601.91997-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We have helper macros for all possible device types, replace all
remaining open-coded accesses to the type fields.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 80 +++++++++++++++------------------------
 drivers/s390/net/qeth_core_mpc.h  |  2 +-
 drivers/s390/net/qeth_core_sys.c  |  3 +-
 drivers/s390/net/qeth_l2_main.c   | 15 +++-----
 drivers/s390/net/qeth_l3_main.c   | 24 ++++++------
 drivers/s390/net/qeth_l3_sys.c    |  6 +--
 7 files changed, 54 insertions(+), 78 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 16c8049672b7..92441593caf3 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -667,7 +667,7 @@ struct qeth_card_info {
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
 	u8 open_when_online:1;
-	int guestlan;
+	u8 is_vm_nic:1;
 	int mac_bits;
 	enum qeth_card_types type;
 	enum qeth_link_types link_type;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d057ead200b5..bdae99636dd4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -85,7 +85,7 @@ static void qeth_close_dev_handler(struct work_struct *work)
 
 static const char *qeth_get_cardname(struct qeth_card *card)
 {
-	if (card->info.guestlan) {
+	if (IS_VM_NIC(card)) {
 		switch (card->info.type) {
 		case QETH_CARD_TYPE_OSD:
 			return " Virtual NIC QDIO";
@@ -120,7 +120,7 @@ static const char *qeth_get_cardname(struct qeth_card *card)
 /* max length to be returned: 14 */
 const char *qeth_get_cardname_short(struct qeth_card *card)
 {
-	if (card->info.guestlan) {
+	if (IS_VM_NIC(card)) {
 		switch (card->info.type) {
 		case QETH_CARD_TYPE_OSD:
 			return "Virt.NIC QDIO";
@@ -1330,7 +1330,7 @@ static void qeth_init_qdio_info(struct qeth_card *card)
 	/* inbound */
 	card->qdio.no_in_queues = 1;
 	card->qdio.in_buf_size = QETH_IN_BUF_SIZE_DEFAULT;
-	if (card->info.type == QETH_CARD_TYPE_IQD)
+	if (IS_IQD(card))
 		card->qdio.init_pool.buf_count = QETH_IN_BUF_COUNT_HSDEFAULT;
 	else
 		card->qdio.init_pool.buf_count = QETH_IN_BUF_COUNT_DEFAULT;
@@ -1554,7 +1554,7 @@ int qeth_qdio_clear_card(struct qeth_card *card, int use_halt)
 	switch (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_ESTABLISHED,
 		QETH_QDIO_CLEANING)) {
 	case QETH_QDIO_ESTABLISHED:
-		if (card->info.type == QETH_CARD_TYPE_IQD)
+		if (IS_IQD(card))
 			rc = qdio_shutdown(CARD_DDEV(card),
 				QDIO_FLAG_CLEANUP_USING_HALT);
 		else
@@ -1627,8 +1627,8 @@ static void qeth_configure_unitaddr(struct qeth_card *card, char *prcd)
 	card->info.chpid = prcd[30];
 	card->info.unit_addr2 = prcd[31];
 	card->info.cula = prcd[63];
-	card->info.guestlan = ((prcd[0x10] == _ascebc['V']) &&
-			       (prcd[0x11] == _ascebc['M']));
+	card->info.is_vm_nic = ((prcd[0x10] == _ascebc['V']) &&
+				(prcd[0x11] == _ascebc['M']));
 }
 
 static enum qeth_discipline_id qeth_vm_detect_layer(struct qeth_card *card)
@@ -1692,13 +1692,11 @@ static enum qeth_discipline_id qeth_enforce_discipline(struct qeth_card *card)
 {
 	enum qeth_discipline_id disc = QETH_DISCIPLINE_UNDETERMINED;
 
-	if (card->info.type == QETH_CARD_TYPE_OSM ||
-	    card->info.type == QETH_CARD_TYPE_OSN)
+	if (IS_OSM(card) || IS_OSN(card))
 		disc = QETH_DISCIPLINE_LAYER2;
-	else if (card->info.guestlan)
-		disc = (card->info.type == QETH_CARD_TYPE_IQD) ?
-				QETH_DISCIPLINE_LAYER3 :
-				qeth_vm_detect_layer(card);
+	else if (IS_VM_NIC(card))
+		disc = IS_IQD(card) ? QETH_DISCIPLINE_LAYER3 :
+				      qeth_vm_detect_layer(card);
 
 	switch (disc) {
 	case QETH_DISCIPLINE_LAYER2:
@@ -2217,7 +2215,7 @@ static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 	memcpy(&card->token.ulp_filter_r,
 	       QETH_ULP_ENABLE_RESP_FILTER_TOKEN(iob->data),
 	       QETH_MPC_TOKEN_LENGTH);
-	if (card->info.type == QETH_CARD_TYPE_IQD) {
+	if (IS_IQD(card)) {
 		memcpy(&framesize, QETH_ULP_ENABLE_RESP_MAX_MTU(iob->data), 2);
 		mtu = qeth_get_mtu_outof_framesize(framesize);
 	} else {
@@ -2555,7 +2553,7 @@ static int qeth_mpc_initialize(struct qeth_card *card)
 
 	return 0;
 out_qdio:
-	qeth_qdio_clear_card(card, card->info.type != QETH_CARD_TYPE_IQD);
+	qeth_qdio_clear_card(card, !IS_IQD(card));
 	qdio_free(CARD_DDEV(card));
 	return rc;
 }
@@ -2578,8 +2576,7 @@ void qeth_print_status_message(struct qeth_card *card)
 		}
 		/* fallthrough */
 	case QETH_CARD_TYPE_IQD:
-		if ((card->info.guestlan) ||
-		    (card->info.mcl_level[0] & 0x80)) {
+		if (IS_VM_NIC(card) || (card->info.mcl_level[0] & 0x80)) {
 			card->info.mcl_level[0] = (char) _ebcasc[(__u8)
 				card->info.mcl_level[0]];
 			card->info.mcl_level[1] = (char) _ebcasc[(__u8)
@@ -3237,7 +3234,7 @@ static void qeth_handle_send_error(struct qeth_card *card,
 	int sbalf15 = buffer->buffer->element[15].sflags;
 
 	QETH_CARD_TEXT(card, 6, "hdsnderr");
-	if (card->info.type == QETH_CARD_TYPE_IQD) {
+	if (IS_IQD(card)) {
 		if (sbalf15 == 0) {
 			qdio_err = 0;
 		} else {
@@ -3334,7 +3331,7 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 		if (queue->bufstates)
 			queue->bufstates[bidx].user = buf;
 
-		if (queue->card->info.type == QETH_CARD_TYPE_IQD)
+		if (IS_IQD(queue->card))
 			continue;
 
 		if (!queue->do_pack) {
@@ -3585,7 +3582,7 @@ static void qeth_qdio_output_handler(struct ccw_device *ccwdev,
 	}
 	atomic_sub(count, &queue->used_buffers);
 	/* check if we need to do something on this outbound queue */
-	if (card->info.type != QETH_CARD_TYPE_IQD)
+	if (!IS_IQD(card))
 		qeth_check_outbound_queue(queue);
 
 	if (IS_IQD(card))
@@ -4336,9 +4333,8 @@ int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback)
 
 	QETH_CARD_TEXT(card, 4, "setactlo");
 
-	if ((card->info.type == QETH_CARD_TYPE_OSD ||
-	     card->info.type == QETH_CARD_TYPE_OSX) &&
-	     qeth_adp_supported(card, IPA_SETADP_SET_ACCESS_CONTROL)) {
+	if ((IS_OSD(card) || IS_OSX(card)) &&
+	    qeth_adp_supported(card, IPA_SETADP_SET_ACCESS_CONTROL)) {
 		rc = qeth_setadpparms_set_access_ctrl(card,
 			card->options.isolation, fallback);
 		if (rc) {
@@ -4503,7 +4499,7 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 
 	QETH_CARD_TEXT(card, 3, "snmpcmd");
 
-	if (card->info.guestlan)
+	if (IS_VM_NIC(card))
 		return -EOPNOTSUPP;
 
 	if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
@@ -4746,14 +4742,6 @@ int qeth_vm_request_mac(struct qeth_card *card)
 }
 EXPORT_SYMBOL_GPL(qeth_vm_request_mac);
 
-static int qeth_get_qdio_q_format(struct qeth_card *card)
-{
-	if (card->info.type == QETH_CARD_TYPE_IQD)
-		return QDIO_IQDIO_QFMT;
-	else
-		return QDIO_QETH_QFMT;
-}
-
 static void qeth_determine_capabilities(struct qeth_card *card)
 {
 	int rc;
@@ -4892,7 +4880,8 @@ static int qeth_qdio_establish(struct qeth_card *card)
 
 	memset(&init_data, 0, sizeof(struct qdio_initialize));
 	init_data.cdev                   = CARD_DDEV(card);
-	init_data.q_format               = qeth_get_qdio_q_format(card);
+	init_data.q_format		 = IS_IQD(card) ? QDIO_IQDIO_QFMT :
+							  QDIO_QETH_QFMT;
 	init_data.qib_param_field_format = 0;
 	init_data.qib_param_field        = qib_param_field;
 	init_data.no_input_qs            = card->qdio.no_in_queues;
@@ -4904,8 +4893,7 @@ static int qeth_qdio_establish(struct qeth_card *card)
 	init_data.input_sbal_addr_array  = in_sbal_ptrs;
 	init_data.output_sbal_addr_array = out_sbal_ptrs;
 	init_data.output_sbal_state_array = card->qdio.out_bufstates;
-	init_data.scan_threshold =
-		(card->info.type == QETH_CARD_TYPE_IQD) ? 1 : 32;
+	init_data.scan_threshold	 = IS_IQD(card) ? 1 : 32;
 
 	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_ALLOCATED,
 		QETH_QDIO_ESTABLISHED) == QETH_QDIO_ALLOCATED) {
@@ -5007,7 +4995,7 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 	if (retries < 3)
 		QETH_DBF_MESSAGE(2, "Retrying to do IDX activates on device %x.\n",
 				 CARD_DEVID(card));
-	rc = qeth_qdio_clear_card(card, card->info.type != QETH_CARD_TYPE_IQD);
+	rc = qeth_qdio_clear_card(card, !IS_IQD(card));
 	ccw_device_set_offline(CARD_DDEV(card));
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
@@ -5189,7 +5177,7 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 		return NULL;
 
 	if (((skb_len >= card->options.rx_sg_cb) &&
-	     (!(card->info.type == QETH_CARD_TYPE_OSN)) &&
+	     !IS_OSN(card) &&
 	     (!atomic_read(&card->force_alloc_skb))) ||
 	    (card->options.cq == QETH_CQ_ENABLED))
 		use_rx_sg = 1;
@@ -5687,9 +5675,8 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		if (rc)
 			goto err_load;
 
-		gdev->dev.type = (card->info.type != QETH_CARD_TYPE_OSN)
-					? card->discipline->devtype
-					: &qeth_osn_devtype;
+		gdev->dev.type = IS_OSN(card) ? &qeth_osn_devtype :
+						card->discipline->devtype;
 		rc = card->discipline->setup(card->gdev);
 		if (rc)
 			goto err_disc;
@@ -5733,10 +5720,8 @@ static int qeth_core_set_online(struct ccwgroup_device *gdev)
 	enum qeth_discipline_id def_discipline;
 
 	if (!card->discipline) {
-		if (card->info.type == QETH_CARD_TYPE_IQD)
-			def_discipline = QETH_DISCIPLINE_LAYER3;
-		else
-			def_discipline = QETH_DISCIPLINE_LAYER2;
+		def_discipline = IS_IQD(card) ? QETH_DISCIPLINE_LAYER3 :
+						QETH_DISCIPLINE_LAYER2;
 		rc = qeth_core_load_discipline(card, def_discipline);
 		if (rc)
 			goto err;
@@ -5864,13 +5849,10 @@ int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		rc = qeth_snmp_command(card, rq->ifr_ifru.ifru_data);
 		break;
 	case SIOC_QETH_GET_CARD_TYPE:
-		if ((card->info.type == QETH_CARD_TYPE_OSD ||
-		     card->info.type == QETH_CARD_TYPE_OSM ||
-		     card->info.type == QETH_CARD_TYPE_OSX) &&
-		    !card->info.guestlan)
+		if ((IS_OSD(card) || IS_OSM(card) || IS_OSX(card)) &&
+		    !IS_VM_NIC(card))
 			return 1;
-		else
-			return 0;
+		return 0;
 	case SIOCGMIIPHY:
 		mii_data = if_mii(rq);
 		mii_data->phy_id = 0;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index f8c5d4a9be13..f5237b7c14c4 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -82,7 +82,7 @@ enum qeth_card_types {
 #define IS_OSM(card)	((card)->info.type == QETH_CARD_TYPE_OSM)
 #define IS_OSN(card)	((card)->info.type == QETH_CARD_TYPE_OSN)
 #define IS_OSX(card)	((card)->info.type == QETH_CARD_TYPE_OSX)
-#define IS_VM_NIC(card)	((card)->info.guestlan)
+#define IS_VM_NIC(card)	((card)->info.is_vm_nic)
 
 #define QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE 0x18
 /* only the first two bytes are looked at in qeth_get_cardname_short */
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index cea4a0bbc303..9f392497d570 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -479,8 +479,7 @@ static ssize_t qeth_dev_isolation_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if (card->info.type != QETH_CARD_TYPE_OSD &&
-	    card->info.type != QETH_CARD_TYPE_OSX) {
+	if (!IS_OSD(card) && !IS_OSX(card)) {
 		rc = -EOPNOTSUPP;
 		dev_err(&card->gdev->dev, "Adapter does not "
 			"support QDIO data connection isolation\n");
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 07bfb110906d..fb21136c0ec2 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -336,7 +336,7 @@ static int qeth_l2_process_inbound_buffer(struct qeth_card *card,
 			napi_gro_receive(&card->napi, skb);
 			break;
 		case QETH_HEADER_TYPE_OSN:
-			if (card->info.type == QETH_CARD_TYPE_OSN) {
+			if (IS_OSN(card)) {
 				skb_push(skb, sizeof(struct qeth_hdr));
 				skb_copy_to_linear_data(skb, hdr,
 						sizeof(struct qeth_hdr));
@@ -387,8 +387,7 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 	}
 
 	/* some devices don't support a custom MAC address: */
-	if (card->info.type == QETH_CARD_TYPE_OSM ||
-	    card->info.type == QETH_CARD_TYPE_OSX)
+	if (IS_OSM(card) || IS_OSX(card))
 		return (rc) ? rc : -EADDRNOTAVAIL;
 	eth_hw_addr_random(card->dev);
 
@@ -733,7 +732,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 		card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 	}
 
-	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
+	if (IS_OSD(card) && !IS_VM_NIC(card)) {
 		card->dev->features |= NETIF_F_SG;
 		/* OSA 3S and earlier has no RX/TX support */
 		if (qeth_is_supported(card, IPA_OUTBOUND_CHECKSUM)) {
@@ -843,8 +842,7 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 	/* softsetup */
 	QETH_DBF_TEXT(SETUP, 2, "softsetp");
 
-	if ((card->info.type == QETH_CARD_TYPE_OSD) ||
-	    (card->info.type == QETH_CARD_TYPE_OSX)) {
+	if (IS_OSD(card) || IS_OSX(card)) {
 		rc = qeth_l2_start_ipassists(card);
 		if (rc)
 			goto out_remove;
@@ -1468,9 +1466,8 @@ static struct qeth_cmd_buffer *qeth_sbp_build_cmd(struct qeth_card *card,
 						  enum qeth_ipa_sbp_cmd sbp_cmd,
 						  unsigned int cmd_length)
 {
-	enum qeth_ipa_cmds ipa_cmd = (card->info.type == QETH_CARD_TYPE_IQD) ?
-					IPA_CMD_SETBRIDGEPORT_IQD :
-					IPA_CMD_SETBRIDGEPORT_OSA;
+	enum qeth_ipa_cmds ipa_cmd = IS_IQD(card) ? IPA_CMD_SETBRIDGEPORT_IQD :
+						    IPA_CMD_SETBRIDGEPORT_OSA;
 	struct qeth_cmd_buffer *iob;
 	struct qeth_ipa_cmd *cmd;
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 4c9394105138..8fd634229871 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -474,7 +474,7 @@ static int qeth_l3_send_setrouting(struct qeth_card *card,
 static int qeth_l3_correct_routing_type(struct qeth_card *card,
 		enum qeth_routing_types *type, enum qeth_prot_versions prot)
 {
-	if (card->info.type == QETH_CARD_TYPE_IQD) {
+	if (IS_IQD(card)) {
 		switch (*type) {
 		case NO_ROUTER:
 		case PRIMARY_CONNECTOR:
@@ -854,7 +854,7 @@ static int qeth_l3_softsetup_ipv6(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 3, "softipv6");
 
-	if (card->info.type == QETH_CARD_TYPE_IQD)
+	if (IS_IQD(card))
 		goto out;
 
 	rc = qeth_send_simple_setassparms(card, IPA_IPV6,
@@ -1380,8 +1380,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 		switch (hdr->hdr.l3.id) {
 		case QETH_HEADER_TYPE_LAYER3:
 			magic = *(__u16 *)skb->data;
-			if ((card->info.type == QETH_CARD_TYPE_IQD) &&
-			    (magic == ETH_P_AF_IUCV)) {
+			if (IS_IQD(card) && magic == ETH_P_AF_IUCV) {
 				len = skb->len;
 				dev_hard_header(skb, dev, ETH_P_AF_IUCV,
 						dev->dev_addr, "FAKELL", len);
@@ -1460,7 +1459,7 @@ qeth_l3_handle_promisc_mode(struct qeth_card *card)
 	     (card->info.promisc_mode == SET_PROMISC_MODE_OFF)))
 		return;
 
-	if (card->info.guestlan) {		/* Guestlan trace */
+	if (IS_VM_NIC(card)) {		/* Guestlan trace */
 		if (qeth_adp_supported(card, IPA_SETADP_SET_PROMISC_MODE))
 			qeth_setadp_promisc_mode(card);
 	} else if (card->options.sniffer &&	/* HiperSockets trace */
@@ -1557,7 +1556,7 @@ static int qeth_l3_arp_set_no_entries(struct qeth_card *card, int no_entries)
 	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_SET_NO_ENTRIES;
 	 * thus we say EOPNOTSUPP for this ARP function
 	 */
-	if (card->info.guestlan)
+	if (IS_VM_NIC(card))
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
 		return -EOPNOTSUPP;
@@ -1789,7 +1788,7 @@ static int qeth_l3_arp_modify_entry(struct qeth_card *card,
 	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_ADD_ENTRY;
 	 * thus we say EOPNOTSUPP for this ARP function
 	 */
-	if (card->info.guestlan)
+	if (IS_VM_NIC(card))
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
 		return -EOPNOTSUPP;
@@ -1822,7 +1821,7 @@ static int qeth_l3_arp_flush_cache(struct qeth_card *card)
 	 * IPA_CMD_ASS_ARP_QUERY_INFO, but not IPA_CMD_ASS_ARP_FLUSH_CACHE;
 	 * thus we say EOPNOTSUPP for this ARP function
 	*/
-	if (card->info.guestlan || (card->info.type == QETH_CARD_TYPE_IQD))
+	if (IS_VM_NIC(card) || IS_IQD(card))
 		return -EOPNOTSUPP;
 	if (!qeth_is_supported(card, IPA_ARP_PROCESSING)) {
 		return -EOPNOTSUPP;
@@ -2013,7 +2012,7 @@ static void qeth_l3_fill_header(struct qeth_qdio_out_q *queue,
 			l3_hdr->next_hop.ipv6_addr = ipv6_hdr(skb)->daddr;
 
 		hdr->hdr.l3.flags |= QETH_HDR_IPV6;
-		if (card->info.type != QETH_CARD_TYPE_IQD)
+		if (!IS_IQD(card))
 			hdr->hdr.l3.flags |= QETH_HDR_PASSTHRU;
 	}
 	rcu_read_unlock();
@@ -2195,8 +2194,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 	unsigned int headroom;
 	int rc;
 
-	if (card->info.type == QETH_CARD_TYPE_OSD ||
-	    card->info.type == QETH_CARD_TYPE_OSX) {
+	if (IS_OSD(card) || IS_OSX(card)) {
 		if ((card->info.link_type == QETH_LINK_TYPE_LANE_TR) ||
 		    (card->info.link_type == QETH_LINK_TYPE_HSTR)) {
 			pr_info("qeth_l3: ignoring TR device\n");
@@ -2210,7 +2208,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 		if (!(card->info.unique_id & UNIQUE_ID_NOT_BY_CARD))
 			card->dev->dev_id = card->info.unique_id & 0xffff;
 
-		if (!card->info.guestlan) {
+		if (!IS_VM_NIC(card)) {
 			card->dev->features |= NETIF_F_SG;
 			card->dev->hw_features |= NETIF_F_TSO |
 				NETIF_F_RXCSUM | NETIF_F_IP_CSUM;
@@ -2234,7 +2232,7 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 			headroom = sizeof(struct qeth_hdr_tso);
 		else
 			headroom = sizeof(struct qeth_hdr) + VLAN_HLEN;
-	} else if (card->info.type == QETH_CARD_TYPE_IQD) {
+	} else if (IS_IQD(card)) {
 		card->dev->flags |= IFF_NOARP;
 		card->dev->netdev_ops = &qeth_l3_netdev_ops;
 		headroom = sizeof(struct qeth_hdr) - ETH_HLEN;
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 327b25f9ca4a..2f73b33c9347 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -206,7 +206,7 @@ static ssize_t qeth_l3_dev_sniffer_store(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	if (card->info.type != QETH_CARD_TYPE_IQD)
+	if (!IS_IQD(card))
 		return -EPERM;
 	if (card->options.cq == QETH_CQ_ENABLED)
 		return -EPERM;
@@ -258,7 +258,7 @@ static ssize_t qeth_l3_dev_hsuid_show(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	if (card->info.type != QETH_CARD_TYPE_IQD)
+	if (!IS_IQD(card))
 		return -EPERM;
 
 	memcpy(tmp_hsuid, card->options.hsuid, sizeof(tmp_hsuid));
@@ -276,7 +276,7 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	if (card->info.type != QETH_CARD_TYPE_IQD)
+	if (!IS_IQD(card))
 		return -EPERM;
 	if (card->state != CARD_STATE_DOWN)
 		return -EPERM;
-- 
2.16.4
