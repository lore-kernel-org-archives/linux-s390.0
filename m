From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 01/15] s390/qeth: convert layer attribute to enum
Date: Wed, 26 Sep 2018 18:29:02 +0200
Message-ID: <20180926162916.102720-2-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

While the raw values are fixed due to their use in a sysfs attribute,
we can still use the proper QETH_DISCIPLINE_* enum within the driver.

Also move the initialization into qeth_set_initial_options(), along with
all other user-configurable fields.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      | 17 ++++++++++-------
 drivers/s390/net/qeth_core_main.c | 22 +++++++++-------------
 drivers/s390/net/qeth_core_sys.c  |  8 ++++----
 drivers/s390/net/qeth_l2_main.c   |  2 +-
 drivers/s390/net/qeth_l3_main.c   |  2 +-
 5 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 0dbe81f958f0..630a01b3212c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -671,6 +671,12 @@ struct qeth_card_info {
 	__u32 hwtrap;
 };
 
+enum qeth_discipline_id {
+	QETH_DISCIPLINE_UNDETERMINED = -1,
+	QETH_DISCIPLINE_LAYER3 = 0,
+	QETH_DISCIPLINE_LAYER2 = 1,
+};
+
 struct qeth_card_options {
 	struct qeth_routing_info route4;
 	struct qeth_ipa_info ipa4;
@@ -680,7 +686,7 @@ struct qeth_card_options {
 	struct qeth_sbp_info sbp; /* SETBRIDGEPORT options */
 	struct qeth_vnicc_info vnicc; /* VNICC options */
 	int fake_broadcast;
-	int layer2;
+	enum qeth_discipline_id layer;
 	int performance_stats;
 	int rx_sg_cb;
 	enum qeth_ipa_isolation_modes isolation;
@@ -690,6 +696,9 @@ struct qeth_card_options {
 	char hsuid[9];
 };
 
+#define	IS_LAYER2(card)	((card)->options.layer == QETH_DISCIPLINE_LAYER2)
+#define	IS_LAYER3(card)	((card)->options.layer == QETH_DISCIPLINE_LAYER3)
+
 /*
  * thread bits for qeth_card thread masks
  */
@@ -702,12 +711,6 @@ struct qeth_osn_info {
 	int (*data_cb)(struct sk_buff *skb);
 };
 
-enum qeth_discipline_id {
-	QETH_DISCIPLINE_UNDETERMINED = -1,
-	QETH_DISCIPLINE_LAYER3 = 0,
-	QETH_DISCIPLINE_LAYER2 = 1,
-};
-
 struct qeth_discipline {
 	const struct device_type *devtype;
 	int (*process_rx_buffer)(struct qeth_card *card, int budget, int *done);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 89e09e7b8fff..4fd9bdc2d0ae 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1429,6 +1429,7 @@ static void qeth_set_initial_options(struct qeth_card *card)
 	card->options.rx_sg_cb = QETH_RX_SG_CB;
 	card->options.isolation = ISOLATION_MODE_NONE;
 	card->options.cq = QETH_CQ_DISABLED;
+	card->options.layer = QETH_DISCIPLINE_UNDETERMINED;
 }
 
 static int qeth_do_start_thread(struct qeth_card *card, unsigned long thread)
@@ -1522,7 +1523,6 @@ static struct qeth_card *qeth_alloc_card(struct ccwgroup_device *gdev)
 		goto out_channel;
 	if (qeth_setup_channel(&card->data, false))
 		goto out_data;
-	card->options.layer2 = -1;
 	card->qeth_service_level.seq_print = qeth_core_sl_print;
 	register_service_level(&card->qeth_service_level);
 	return card;
@@ -2291,7 +2291,7 @@ static int qeth_update_max_mtu(struct qeth_card *card, unsigned int max_mtu)
 		if (dev->mtu)
 			new_mtu = dev->mtu;
 		/* default MTUs for first setup: */
-		else if (card->options.layer2)
+		else if (IS_LAYER2(card))
 			new_mtu = ETH_DATA_LEN;
 		else
 			new_mtu = ETH_DATA_LEN - 8; /* allow for LLC + SNAP */
@@ -2358,7 +2358,7 @@ static u8 qeth_mpc_select_prot_type(struct qeth_card *card)
 {
 	if (IS_OSN(card))
 		return QETH_PROT_OSN2;
-	return (card->options.layer2 == 1) ? QETH_PROT_LAYER2 : QETH_PROT_TCPIP;
+	return IS_LAYER2(card) ? QETH_PROT_LAYER2 : QETH_PROT_TCPIP;
 }
 
 static int qeth_ulp_enable(struct qeth_card *card)
@@ -2896,10 +2896,7 @@ static void qeth_fill_ipacmd_header(struct qeth_card *card,
 	/* cmd->hdr.seqno is set by qeth_send_control_data() */
 	cmd->hdr.adapter_type = qeth_get_ipa_adp_type(card->info.link_type);
 	cmd->hdr.rel_adapter_no = (u8) card->dev->dev_port;
-	if (card->options.layer2)
-		cmd->hdr.prim_version_no = 2;
-	else
-		cmd->hdr.prim_version_no = 1;
+	cmd->hdr.prim_version_no = IS_LAYER2(card) ? 2 : 1;
 	cmd->hdr.param_count = 1;
 	cmd->hdr.prot_version = prot;
 }
@@ -4278,8 +4275,7 @@ static int qeth_setadpparms_change_macaddr_cb(struct qeth_card *card,
 	if (qeth_setadpparms_inspect_rc(cmd))
 		return 0;
 
-	if (!card->options.layer2 ||
-	    !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {
+	if (IS_LAYER3(card) || !(card->info.mac_bits & QETH_LAYER2_MAC_READ)) {
 		ether_addr_copy(card->dev->dev_addr,
 				cmd->data.setadapterparms.data.change_addr.addr);
 		card->info.mac_bits |= QETH_LAYER2_MAC_READ;
@@ -4633,9 +4629,9 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 		return -EOPNOTSUPP;
 
 	if ((!qeth_adp_supported(card, IPA_SETADP_SET_SNMP_CONTROL)) &&
-	    (!card->options.layer2)) {
+	    IS_LAYER3(card))
 		return -EOPNOTSUPP;
-	}
+
 	/* skip 4 bytes (data_len struct member) to get req_len */
 	if (copy_from_user(&req_len, udata + sizeof(int), sizeof(int)))
 		return -EFAULT;
@@ -5623,7 +5619,7 @@ int qeth_core_load_discipline(struct qeth_card *card,
 
 void qeth_core_free_discipline(struct qeth_card *card)
 {
-	if (card->options.layer2)
+	if (IS_LAYER2(card))
 		symbol_put(qeth_l2_discipline);
 	else
 		symbol_put(qeth_l3_discipline);
@@ -6146,7 +6142,7 @@ void qeth_core_get_drvinfo(struct net_device *dev,
 {
 	struct qeth_card *card = dev->ml_priv;
 
-	strlcpy(info->driver, card->options.layer2 ? "qeth_l2" : "qeth_l3",
+	strlcpy(info->driver, IS_LAYER2(card) ? "qeth_l2" : "qeth_l3",
 		sizeof(info->driver));
 	strlcpy(info->version, "1.0", sizeof(info->version));
 	strlcpy(info->fw_version, card->info.mcl_level,
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 25d0be25bcb3..fdb67af811f4 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -228,7 +228,7 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		card->qdio.do_prio_queueing = QETH_PRIO_Q_ING_TOS;
 		card->qdio.default_out_queue = QETH_DEFAULT_QUEUE;
 	} else if (sysfs_streq(buf, "prio_queueing_vlan")) {
-		if (!card->options.layer2) {
+		if (IS_LAYER3(card)) {
 			rc = -ENOTSUPP;
 			goto out;
 		}
@@ -379,7 +379,7 @@ static ssize_t qeth_dev_layer2_show(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	return sprintf(buf, "%i\n", card->options.layer2);
+	return sprintf(buf, "%i\n", card->options.layer);
 }
 
 static ssize_t qeth_dev_layer2_store(struct device *dev,
@@ -413,7 +413,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 		goto out;
 	}
 
-	if (card->options.layer2 == newdis)
+	if (card->options.layer == newdis)
 		goto out;
 	if (card->info.layer_enforced) {
 		/* fixed layer, can't switch */
@@ -432,7 +432,7 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 
 		card->discipline->remove(card->gdev);
 		qeth_core_free_discipline(card);
-		card->options.layer2 = -1;
+		card->options.layer = QETH_DISCIPLINE_UNDETERMINED;
 
 		free_netdev(card->dev);
 		card->dev = ndev;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 12858ffa28cf..afa7a005b21e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -806,7 +806,7 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	}
 	INIT_LIST_HEAD(&card->vid_list);
 	hash_init(card->mac_htable);
-	card->options.layer2 = 1;
+	card->options.layer = QETH_DISCIPLINE_LAYER2;
 	card->info.hwtrap = 0;
 	qeth_l2_vnicc_set_defaults(card);
 	return 0;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 8930d2a9fcad..552bfad20f85 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2489,7 +2489,7 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	}
 	hash_init(card->ip_htable);
 	hash_init(card->ip_mc_htable);
-	card->options.layer2 = 0;
+	card->options.layer = QETH_DISCIPLINE_LAYER3;
 	card->info.hwtrap = 0;
 	return 0;
 }
-- 
2.16.4
