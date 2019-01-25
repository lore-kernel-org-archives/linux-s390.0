Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/8] s390/qeth: delay netdevice registration
Date: Fri, 25 Jan 2019 15:44:21 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-7-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Re-order the code flow a bit so that all initial HW setup is done before
putting the netdevice into play. For a netdevice that hasn't been
registered before, we also don't need to re-enable its HW features or
check for recovery actions.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  9 ---------
 drivers/s390/net/qeth_l2_main.c   | 40 ++++++++++++++++++++++-----------------
 drivers/s390/net/qeth_l3_main.c   | 34 +++++++++++++++++++--------------
 3 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index db1aaa796bef..06bd42a846fa 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5147,13 +5147,6 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 		*carrier_ok = true;
 	}
 
-	if (qeth_netdev_is_registered(card->dev)) {
-		if (*carrier_ok)
-			netif_carrier_on(card->dev);
-		else
-			netif_carrier_off(card->dev);
-	}
-
 	card->options.ipa4.supported_funcs = 0;
 	card->options.ipa6.supported_funcs = 0;
 	card->options.adp.supported_funcs = 0;
@@ -6538,7 +6531,6 @@ void qeth_enable_hw_features(struct net_device *dev)
 	struct qeth_card *card = dev->ml_priv;
 	netdev_features_t features;
 
-	rtnl_lock();
 	features = dev->features;
 	/* force-off any feature that needs an IPA sequence.
 	 * netdev_update_features() will restart them.
@@ -6548,7 +6540,6 @@ void qeth_enable_hw_features(struct net_device *dev)
 	if (features != dev->features)
 		dev_warn(&card->gdev->dev,
 			 "Device recovery failed to restore all offload features\n");
-	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(qeth_enable_hw_features);
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 0d04e5a89341..295ec94b226f 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -803,9 +803,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 {
 	int rc;
 
-	if (qeth_netdev_is_registered(card->dev))
-		return 0;
-
 	card->dev->priv_flags |= IFF_UNICAST_FLT;
 	card->dev->netdev_ops = &qeth_l2_netdev_ops;
 	if (card->info.type == QETH_CARD_TYPE_OSN) {
@@ -886,6 +883,7 @@ static void qeth_l2_trace_features(struct qeth_card *card)
 static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	struct net_device *dev = card->dev;
 	int rc = 0;
 	enum qeth_card_states recover_flag;
 	bool carrier_ok;
@@ -909,10 +907,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 
 	qeth_l2_register_dev_addr(card);
 
-	rc = qeth_l2_setup_netdev(card, carrier_ok);
-	if (rc)
-		goto out_remove;
-
 	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
 		if (card->info.hwtrap &&
 		    qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM))
@@ -954,18 +948,30 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 
-	qeth_enable_hw_features(card->dev);
-	if (recover_flag == CARD_STATE_RECOVER) {
-		if (recovery_mode && !IS_OSN(card)) {
-			if (!qeth_l2_validate_addr(card->dev)) {
-				qeth_open_internal(card->dev);
-				qeth_l2_set_rx_mode(card->dev);
+	if (!qeth_netdev_is_registered(dev)) {
+		rc = qeth_l2_setup_netdev(card, carrier_ok);
+		if (rc)
+			goto out_remove;
+	} else {
+		rtnl_lock();
+		if (carrier_ok)
+			netif_carrier_on(dev);
+		else
+			netif_carrier_off(dev);
+
+		qeth_enable_hw_features(dev);
+
+		if (recover_flag == CARD_STATE_RECOVER) {
+			if (recovery_mode && !IS_OSN(card)) {
+				if (!qeth_l2_validate_addr(dev)) {
+					qeth_open_internal(dev);
+					qeth_l2_set_rx_mode(dev);
+				}
+			} else {
+				dev_open(dev, NULL);
 			}
-		} else {
-			rtnl_lock();
-			dev_open(card->dev, NULL);
-			rtnl_unlock();
 		}
+		rtnl_unlock();
 	}
 	/* let user_space know that device is online */
 	kobject_uevent(&gdev->dev.kobj, KOBJ_CHANGE);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2065030e1a62..e60d2c44d479 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2178,9 +2178,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 	unsigned int headroom;
 	int rc;
 
-	if (qeth_netdev_is_registered(card->dev))
-		return 0;
-
 	if (card->info.type == QETH_CARD_TYPE_OSD ||
 	    card->info.type == QETH_CARD_TYPE_OSX) {
 		if ((card->info.link_type == QETH_LINK_TYPE_LANE_TR) ||
@@ -2296,6 +2293,7 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	struct net_device *dev = card->dev;
 	int rc = 0;
 	enum qeth_card_states recover_flag;
 	bool carrier_ok;
@@ -2313,10 +2311,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		goto out_remove;
 	}
 
-	rc = qeth_l3_setup_netdev(card, carrier_ok);
-	if (rc)
-		goto out_remove;
-
 	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
 		if (card->info.hwtrap &&
 		    qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM))
@@ -2358,14 +2352,26 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	qeth_l3_recover_ip(card);
 
-	qeth_enable_hw_features(card->dev);
-	if (recover_flag == CARD_STATE_RECOVER) {
+	if (!qeth_netdev_is_registered(dev)) {
+		rc = qeth_l3_setup_netdev(card, carrier_ok);
+		if (rc)
+			goto out_remove;
+	} else {
 		rtnl_lock();
-		if (recovery_mode) {
-			qeth_open_internal(card->dev);
-			qeth_l3_set_rx_mode(card->dev);
-		} else {
-			dev_open(card->dev, NULL);
+		if (carrier_ok)
+			netif_carrier_on(dev);
+		else
+			netif_carrier_off(dev);
+
+		qeth_enable_hw_features(dev);
+
+		if (recover_flag == CARD_STATE_RECOVER) {
+			if (recovery_mode) {
+				qeth_open_internal(dev);
+				qeth_l3_set_rx_mode(dev);
+			} else {
+				dev_open(dev, NULL);
+			}
 		}
 		rtnl_unlock();
 	}
-- 
2.16.4
