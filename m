Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/8] s390/qeth: remove VLAN tracking for L2 devices
Date: Fri, 25 Jan 2019 15:44:23 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-9-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

For recovery purposes, qeth keeps track of all registered VIDs. Replace
this by using the infrastructure introduced in
commit 9daae9bd47cf ("net: Call add/kill vid ndo on vlan filter feature toggling").

By managing NETIF_F_HW_VLAN_CTAG_FILTER as a hw_feature,
netdev_update_features() will select it from dev->wanted_features
and replay all of the netdevice's VIDs to its ndo_vlan_rx_add_vid()
callback.
z/VM NICs strictly require VLAN registration, so don't expose it as
hw_feature there but add a little hack in qeth_enable_hw_features()
to make things work regardless.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  7 -----
 drivers/s390/net/qeth_core_main.c | 12 ++++----
 drivers/s390/net/qeth_core_mpc.h  |  1 +
 drivers/s390/net/qeth_l2_main.c   | 61 +++++++--------------------------------
 4 files changed, 18 insertions(+), 63 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index df270ef3964c..d65650ef6b41 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -741,11 +741,6 @@ struct qeth_discipline {
 					struct qeth_ipa_cmd *cmd);
 };
 
-struct qeth_vlan_vid {
-	struct list_head list;
-	unsigned short vid;
-};
-
 enum qeth_addr_disposition {
 	QETH_DISP_ADDR_DELETE = 0,
 	QETH_DISP_ADDR_DO_NOTHING = 1,
@@ -792,8 +787,6 @@ struct qeth_card {
 	wait_queue_head_t wait_q;
 	spinlock_t mclock;
 	unsigned long active_vlans[BITS_TO_LONGS(VLAN_N_VID)];
-	struct mutex vid_list_mutex;		/* vid_list */
-	struct list_head vid_list;
 	DECLARE_HASHTABLE(mac_htable, 4);
 	DECLARE_HASHTABLE(ip_htable, 4);
 	DECLARE_HASHTABLE(ip_mc_htable, 4);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f7c097a613fc..dcc06e48b70b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1404,7 +1404,6 @@ static void qeth_setup_card(struct qeth_card *card)
 	spin_lock_init(&card->thread_mask_lock);
 	mutex_init(&card->conf_mutex);
 	mutex_init(&card->discipline_mutex);
-	mutex_init(&card->vid_list_mutex);
 	INIT_WORK(&card->kernel_thread_starter, qeth_start_kernel_thread);
 	INIT_LIST_HEAD(&card->cmd_waiter_list);
 	init_waitqueue_head(&card->wait_q);
@@ -6489,8 +6488,6 @@ static int qeth_set_ipa_rx_csum(struct qeth_card *card, bool on)
 	return (rc_ipv6) ? rc_ipv6 : rc_ipv4;
 }
 
-#define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO | \
-			  NETIF_F_IPV6_CSUM | NETIF_F_TSO6)
 /**
  * qeth_enable_hw_features() - (Re-)Enable HW functions for device features
  * @dev:	a net_device
@@ -6501,10 +6498,15 @@ void qeth_enable_hw_features(struct net_device *dev)
 	netdev_features_t features;
 
 	features = dev->features;
-	/* force-off any feature that needs an IPA sequence.
+	/* force-off any feature that might need an IPA sequence.
 	 * netdev_update_features() will restart them.
 	 */
-	dev->features &= ~QETH_HW_FEATURES;
+	dev->features &= ~dev->hw_features;
+	/* toggle VLAN filter, so that VIDs are re-programmed: */
+	if (IS_LAYER2(card) && IS_VM_NIC(card)) {
+		dev->features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
+		dev->wanted_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
 	netdev_update_features(dev);
 	if (features != dev->features)
 		dev_warn(&card->gdev->dev,
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 1ab321926f64..c7fb14a61eed 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -81,6 +81,7 @@ enum qeth_card_types {
 
 #define IS_IQD(card)	((card)->info.type == QETH_CARD_TYPE_IQD)
 #define IS_OSD(card)	((card)->info.type == QETH_CARD_TYPE_OSD)
+#define IS_OSM(card)	((card)->info.type == QETH_CARD_TYPE_OSM)
 #define IS_OSN(card)	((card)->info.type == QETH_CARD_TYPE_OSN)
 #define IS_VM_NIC(card)	((card)->info.guestlan)
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 18dfb1b5e690..82f50cc30b0a 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -261,69 +261,28 @@ static int qeth_l2_send_setdelvlan(struct qeth_card *card, __u16 i,
 					    qeth_l2_send_setdelvlan_cb, NULL));
 }
 
-static void qeth_l2_process_vlans(struct qeth_card *card)
-{
-	struct qeth_vlan_vid *id;
-
-	QETH_CARD_TEXT(card, 3, "L2prcvln");
-	mutex_lock(&card->vid_list_mutex);
-	list_for_each_entry(id, &card->vid_list, list) {
-		qeth_l2_send_setdelvlan(card, id->vid, IPA_CMD_SETVLAN);
-	}
-	mutex_unlock(&card->vid_list_mutex);
-}
-
 static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
 				   __be16 proto, u16 vid)
 {
 	struct qeth_card *card = dev->ml_priv;
-	struct qeth_vlan_vid *id;
-	int rc;
 
 	QETH_CARD_TEXT_(card, 4, "aid:%d", vid);
 	if (!vid)
 		return 0;
 
-	id = kmalloc(sizeof(*id), GFP_KERNEL);
-	if (id) {
-		id->vid = vid;
-		rc = qeth_l2_send_setdelvlan(card, vid, IPA_CMD_SETVLAN);
-		if (rc) {
-			kfree(id);
-			return rc;
-		}
-		mutex_lock(&card->vid_list_mutex);
-		list_add_tail(&id->list, &card->vid_list);
-		mutex_unlock(&card->vid_list_mutex);
-	} else {
-		return -ENOMEM;
-	}
-	return 0;
+	return qeth_l2_send_setdelvlan(card, vid, IPA_CMD_SETVLAN);
 }
 
 static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 				    __be16 proto, u16 vid)
 {
-	struct qeth_vlan_vid *id, *tmpid = NULL;
 	struct qeth_card *card = dev->ml_priv;
-	int rc = 0;
 
 	QETH_CARD_TEXT_(card, 4, "kid:%d", vid);
+	if (!vid)
+		return 0;
 
-	mutex_lock(&card->vid_list_mutex);
-	list_for_each_entry(id, &card->vid_list, list) {
-		if (id->vid == vid) {
-			list_del(&id->list);
-			tmpid = id;
-			break;
-		}
-	}
-	mutex_unlock(&card->vid_list_mutex);
-	if (tmpid) {
-		rc = qeth_l2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
-		kfree(tmpid);
-	}
-	return rc;
+	return qeth_l2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
 }
 
 static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
@@ -718,7 +677,7 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 		if (rc)
 			return rc;
 	}
-	INIT_LIST_HEAD(&card->vid_list);
+
 	hash_init(card->mac_htable);
 	card->info.hwtrap = 0;
 	qeth_l2_vnicc_set_defaults(card);
@@ -787,10 +746,13 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 		card->dev->needed_headroom = sizeof(struct qeth_hdr);
 	}
 
-	if (card->info.type == QETH_CARD_TYPE_OSM)
+	if (IS_OSM(card)) {
 		card->dev->features |= NETIF_F_VLAN_CHALLENGED;
-	else
+	} else {
+		if (!IS_VM_NIC(card))
+			card->dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		card->dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
+	}
 
 	if (card->info.type == QETH_CARD_TYPE_OSD && !card->info.guestlan) {
 		card->dev->features |= NETIF_F_SG;
@@ -909,9 +871,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 			goto out_remove;
 	}
 
-	if (card->info.type != QETH_CARD_TYPE_OSN)
-		qeth_l2_process_vlans(card);
-
 	rc = qeth_init_qdio_queues(card);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "6err%d", rc);
-- 
2.16.4
