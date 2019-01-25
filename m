Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/8] s390/qeth: detach netdevice while card is offline
Date: Fri, 25 Jan 2019 15:44:22 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-8-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When a qeth card is offline, it has no connection to the HW. So none of
our control callbacks can run IO against it, and we can only cache the
input (eg a new MAC address) without providing proper feedback to the
caller. In this context, it seems much more reasonable to simply detach
the netdevice and let the kernel reject any interaction with it.

This also makes all sorts of internal state checks and locking obsolete.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  5 ----
 drivers/s390/net/qeth_core_main.c | 51 ++-------------------------------------
 drivers/s390/net/qeth_l2_main.c   | 47 +++++++++---------------------------
 drivers/s390/net/qeth_l3_main.c   | 19 ++++++---------
 4 files changed, 20 insertions(+), 102 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index ffec26ff512d..df270ef3964c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -802,7 +802,6 @@ struct qeth_card {
 	unsigned long thread_start_mask;
 	unsigned long thread_allowed_mask;
 	unsigned long thread_running_mask;
-	struct task_struct *recovery_task;
 	spinlock_t ip_lock;
 	struct qeth_ipato ipato;
 	struct list_head cmd_waiter_list;
@@ -976,11 +975,8 @@ extern struct qeth_dbf_info qeth_dbf[QETH_DBF_INFOS];
 
 struct net_device *qeth_clone_netdev(struct net_device *orig);
 struct qeth_card *qeth_get_card_by_busid(char *bus_id);
-void qeth_set_recovery_task(struct qeth_card *);
-void qeth_clear_recovery_task(struct qeth_card *);
 void qeth_set_allowed_threads(struct qeth_card *, unsigned long , int);
 int qeth_threads_running(struct qeth_card *, unsigned long);
-int qeth_wait_for_threads(struct qeth_card *, unsigned long);
 int qeth_do_run_thread(struct qeth_card *, unsigned long);
 void qeth_clear_thread_start_bit(struct qeth_card *, unsigned long);
 void qeth_clear_thread_running_bit(struct qeth_card *, unsigned long);
@@ -1047,7 +1043,6 @@ netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
 netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
-int qeth_open_internal(struct net_device *dev);
 int qeth_open(struct net_device *dev);
 int qeth_stop(struct net_device *dev);
 
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 06bd42a846fa..f7c097a613fc 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -193,23 +193,6 @@ const char *qeth_get_cardname_short(struct qeth_card *card)
 	return "n/a";
 }
 
-void qeth_set_recovery_task(struct qeth_card *card)
-{
-	card->recovery_task = current;
-}
-EXPORT_SYMBOL_GPL(qeth_set_recovery_task);
-
-void qeth_clear_recovery_task(struct qeth_card *card)
-{
-	card->recovery_task = NULL;
-}
-EXPORT_SYMBOL_GPL(qeth_clear_recovery_task);
-
-static bool qeth_is_recovery_task(const struct qeth_card *card)
-{
-	return card->recovery_task == current;
-}
-
 void qeth_set_allowed_threads(struct qeth_card *card, unsigned long threads,
 			 int clear_start_mask)
 {
@@ -236,15 +219,6 @@ int qeth_threads_running(struct qeth_card *card, unsigned long threads)
 }
 EXPORT_SYMBOL_GPL(qeth_threads_running);
 
-int qeth_wait_for_threads(struct qeth_card *card, unsigned long threads)
-{
-	if (qeth_is_recovery_task(card))
-		return 0;
-	return wait_event_interruptible(card->wait_q,
-			qeth_threads_running(card, threads) == 0);
-}
-EXPORT_SYMBOL_GPL(qeth_wait_for_threads);
-
 void qeth_clear_working_pool_list(struct qeth_card *card)
 {
 	struct qeth_buffer_pool_entry *pool_entry, *tmp;
@@ -5923,9 +5897,6 @@ int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	if (!card)
 		return -ENODEV;
 
-	if (!qeth_card_hw_is_reachable(card))
-		return -ENODEV;
-
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		return -EPERM;
 
@@ -6236,8 +6207,6 @@ int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* Check if we can obtain more accurate information.	 */
 	/* If QUERY_CARD_INFO command is not supported or fails, */
 	/* just return the heuristics that was filled above.	 */
-	if (!qeth_card_hw_is_reachable(card))
-		return -ENODEV;
 	rc = qeth_query_card_info(card, &carrier_info);
 	if (rc == -EOPNOTSUPP) /* for old hardware, return heuristic */
 		return 0;
@@ -6608,10 +6577,7 @@ netdev_features_t qeth_fix_features(struct net_device *dev,
 		features &= ~NETIF_F_TSO;
 	if (!qeth_is_supported6(card, IPA_OUTBOUND_TSO))
 		features &= ~NETIF_F_TSO6;
-	/* if the card isn't up, remove features that require hw changes */
-	if (card->state == CARD_STATE_DOWN ||
-	    card->state == CARD_STATE_RECOVER)
-		features &= ~QETH_HW_FEATURES;
+
 	QETH_DBF_HEX(SETUP, 2, &features, sizeof(features));
 	return features;
 }
@@ -6643,7 +6609,7 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(qeth_features_check);
 
-int qeth_open_internal(struct net_device *dev)
+int qeth_open(struct net_device *dev)
 {
 	struct qeth_card *card = dev->ml_priv;
 
@@ -6667,19 +6633,6 @@ int qeth_open_internal(struct net_device *dev)
 	local_bh_enable();
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qeth_open_internal);
-
-int qeth_open(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-
-	QETH_CARD_TEXT(card, 5, "qethope_");
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "openREC");
-		return -ERESTARTSYS;
-	}
-	return qeth_open_internal(dev);
-}
 EXPORT_SYMBOL_GPL(qeth_open);
 
 int qeth_stop(struct net_device *dev)
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 295ec94b226f..18dfb1b5e690 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -283,10 +283,7 @@ static int qeth_l2_vlan_rx_add_vid(struct net_device *dev,
 	QETH_CARD_TEXT_(card, 4, "aid:%d", vid);
 	if (!vid)
 		return 0;
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "aidREC");
-		return 0;
-	}
+
 	id = kmalloc(sizeof(*id), GFP_KERNEL);
 	if (id) {
 		id->vid = vid;
@@ -312,10 +309,7 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 	int rc = 0;
 
 	QETH_CARD_TEXT_(card, 4, "kid:%d", vid);
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "kidREC");
-		return 0;
-	}
+
 	mutex_lock(&card->vid_list_mutex);
 	list_for_each_entry(id, &card->vid_list, list) {
 		if (id->vid == vid) {
@@ -496,39 +490,22 @@ static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 	if (!is_valid_ether_addr(addr->sa_data))
 		return -EADDRNOTAVAIL;
 
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "setmcREC");
-		return -ERESTARTSYS;
-	}
-
-	/* avoid racing against concurrent state change: */
-	if (!mutex_trylock(&card->conf_mutex))
-		return -EAGAIN;
-
-	if (!qeth_card_hw_is_reachable(card)) {
-		ether_addr_copy(dev->dev_addr, addr->sa_data);
-		goto out_unlock;
-	}
-
 	/* don't register the same address twice */
 	if (ether_addr_equal_64bits(dev->dev_addr, addr->sa_data) &&
 	    (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
-		goto out_unlock;
+		return 0;
 
 	/* add the new address, switch over, drop the old */
 	rc = qeth_l2_send_setmac(card, addr->sa_data);
 	if (rc)
-		goto out_unlock;
+		return rc;
 	ether_addr_copy(old_addr, dev->dev_addr);
 	ether_addr_copy(dev->dev_addr, addr->sa_data);
 
 	if (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED)
 		qeth_l2_remove_mac(card, old_addr);
 	card->info.mac_bits |= QETH_LAYER2_MAC_REGISTERED;
-
-out_unlock:
-	mutex_unlock(&card->conf_mutex);
-	return rc;
+	return 0;
 }
 
 static void qeth_promisc_to_bridge(struct qeth_card *card)
@@ -603,9 +580,6 @@ static void qeth_l2_set_rx_mode(struct net_device *dev)
 		return;
 
 	QETH_CARD_TEXT(card, 3, "setmulti");
-	if (qeth_threads_running(card, QETH_RECOVER_THREAD) &&
-	    (card->state != CARD_STATE_UP))
-		return;
 
 	spin_lock_bh(&card->mclock);
 
@@ -959,12 +933,13 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		else
 			netif_carrier_off(dev);
 
+		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
 		if (recover_flag == CARD_STATE_RECOVER) {
 			if (recovery_mode && !IS_OSN(card)) {
 				if (!qeth_l2_validate_addr(dev)) {
-					qeth_open_internal(dev);
+					qeth_open(dev);
 					qeth_l2_set_rx_mode(dev);
 				}
 			} else {
@@ -1011,7 +986,11 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
+	rtnl_lock();
+	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
+	rtnl_unlock();
+
 	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
@@ -1052,7 +1031,6 @@ static int qeth_l2_recover(void *ptr)
 	QETH_CARD_TEXT(card, 2, "recover2");
 	dev_warn(&card->gdev->dev,
 		"A recovery process has been started for the device\n");
-	qeth_set_recovery_task(card);
 	__qeth_l2_set_offline(card->gdev, 1);
 	rc = __qeth_l2_set_online(card->gdev, 1);
 	if (!rc)
@@ -1063,7 +1041,6 @@ static int qeth_l2_recover(void *ptr)
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 				"failed to recover an error on the device\n");
 	}
-	qeth_clear_recovery_task(card);
 	qeth_clear_thread_start_bit(card, QETH_RECOVER_THREAD);
 	qeth_clear_thread_running_bit(card, QETH_RECOVER_THREAD);
 	return 0;
@@ -1084,7 +1061,6 @@ static int qeth_l2_pm_suspend(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 
-	netif_device_detach(card->dev);
 	qeth_set_allowed_threads(card, 0, 1);
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 	if (gdev->state == CCWGROUP_OFFLINE)
@@ -1114,7 +1090,6 @@ static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
 		rc = __qeth_l2_set_online(card->gdev, 0);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	netif_device_attach(card->dev);
 	if (rc)
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 			"failed to recover an error on the device\n");
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e60d2c44d479..59535ecb1487 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1280,10 +1280,6 @@ static int qeth_l3_vlan_rx_kill_vid(struct net_device *dev,
 
 	QETH_CARD_TEXT_(card, 4, "kid:%d", vid);
 
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "kidREC");
-		return 0;
-	}
 	clear_bit(vid, card->active_vlans);
 	qeth_l3_set_rx_mode(dev);
 	return 0;
@@ -1472,9 +1468,7 @@ static void qeth_l3_set_rx_mode(struct net_device *dev)
 	int i, rc;
 
 	QETH_CARD_TEXT(card, 3, "setmulti");
-	if (qeth_threads_running(card, QETH_RECOVER_THREAD) &&
-	    (card->state != CARD_STATE_UP))
-		return;
+
 	if (!card->options.sniffer) {
 		spin_lock_bh(&card->mclock);
 
@@ -2363,11 +2357,12 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		else
 			netif_carrier_off(dev);
 
+		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
 		if (recover_flag == CARD_STATE_RECOVER) {
 			if (recovery_mode) {
-				qeth_open_internal(dev);
+				qeth_open(dev);
 				qeth_l3_set_rx_mode(dev);
 			} else {
 				dev_open(dev, NULL);
@@ -2413,7 +2408,11 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
+	rtnl_lock();
+	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
+	rtnl_unlock();
+
 	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
@@ -2460,7 +2459,6 @@ static int qeth_l3_recover(void *ptr)
 	QETH_CARD_TEXT(card, 2, "recover2");
 	dev_warn(&card->gdev->dev,
 		"A recovery process has been started for the device\n");
-	qeth_set_recovery_task(card);
 	__qeth_l3_set_offline(card->gdev, 1);
 	rc = __qeth_l3_set_online(card->gdev, 1);
 	if (!rc)
@@ -2471,7 +2469,6 @@ static int qeth_l3_recover(void *ptr)
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 				"failed to recover an error on the device\n");
 	}
-	qeth_clear_recovery_task(card);
 	qeth_clear_thread_start_bit(card, QETH_RECOVER_THREAD);
 	qeth_clear_thread_running_bit(card, QETH_RECOVER_THREAD);
 	return 0;
@@ -2481,7 +2478,6 @@ static int qeth_l3_pm_suspend(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 
-	netif_device_detach(card->dev);
 	qeth_set_allowed_threads(card, 0, 1);
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 	if (gdev->state == CCWGROUP_OFFLINE)
@@ -2511,7 +2507,6 @@ static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
 		rc = __qeth_l3_set_online(card->gdev, 0);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
-	netif_device_attach(card->dev);
 	if (rc)
 		dev_warn(&card->gdev->dev, "The qeth device driver "
 			"failed to recover an error on the device\n");
-- 
2.16.4
