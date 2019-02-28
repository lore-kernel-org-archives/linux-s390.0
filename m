Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/9] s390/qeth: call dev_close() during recovery
Date: Thu, 28 Feb 2019 18:59:39 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-5-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When resetting an interface ("recovery"), qeth currently attempts to
elide the call to dev_close(). We initially only call .ndo_close to
quiesce the data path, and then offline & online the ccwgroup device.
If the reset succeeded, a call to .ndo_open then resumes the data path
along with some internal setup (dev_addr validation, RX modeset) that
dev_open() would have usually triggered.
dev_close() only gets called (via the close_dev worker) if the reset
action fails.

It's unclear whether this was initially done due to locking concerns, or
rather to execute the reset transparently. Either way, temporarily
closing the interface without dev_close() is fragile, and means we're
susceptible to various races and unexpected behaviour. For instance:

- Bypassing dev_deactivate_many() means that the qdiscs are not set to
__QDISC_STATE_DEACTIVATED. Consequently any intermittent TX completion
can wake up the txq, resulting in calls to .ndo_start_xmit while the
data path is down. We have custom state checking to detect this case
and drop such packets.

- Because the IFF_UP flag doesn't reflect the interface's actual state
during a reset, we have custom state checking in .ndo_open and
.ndo_close to guard against invalid calls.

- Considering that the reset might take a considerable amount of time
(in particular if an IO fails and we end up waiting for its timeout), we
_do_ want NETDEV_GOING_DOWN and NETDEV_DOWN events so that components
like bonding, team, bridge, macvlan, vlan, ... can take appropriate
action.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |  3 ---
 drivers/s390/net/qeth_l2_main.c   | 47 +++++++++------------------------------
 drivers/s390/net/qeth_l3_main.c   | 45 +++++++++----------------------------
 3 files changed, 20 insertions(+), 75 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index a69e31e9bdf1..a1a66467b06b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -89,9 +89,6 @@ static void qeth_close_dev_handler(struct work_struct *work)
 
 	card = container_of(work, struct qeth_card, close_dev_work);
 	QETH_CARD_TEXT(card, 2, "cldevhdl");
-	rtnl_lock();
-	dev_close(card->dev);
-	rtnl_unlock();
 	ccwgroup_set_offline(card->gdev);
 }
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f71d45ea30da..a42285b1daa3 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -285,7 +285,7 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 	return qeth_l2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
 }
 
-static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
+static void qeth_l2_stop_card(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(SETUP , 2, "stopcard");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
@@ -293,16 +293,8 @@ static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 	qeth_set_allowed_threads(card, 0, 1);
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
-	    (card->state == CARD_STATE_UP)) {
-		if (recovery_mode && !IS_OSN(card)) {
-			qeth_stop(card->dev);
-		} else {
-			rtnl_lock();
-			dev_close(card->dev);
-			rtnl_unlock();
-		}
+	    card->state == CARD_STATE_UP)
 		card->state = CARD_STATE_SOFTSETUP;
-	}
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_l2_del_all_macs(card);
 		qeth_clear_ipacmd_list(card);
@@ -802,7 +794,7 @@ static void qeth_l2_trace_features(struct qeth_card *card)
 		      sizeof(card->options.vnicc.sup_chars));
 }
 
-static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
+static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	struct net_device *dev = card->dev;
@@ -882,14 +874,7 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 
 		if (card->info.open_when_online) {
 			card->info.open_when_online = 0;
-			if (recovery_mode && !IS_OSN(card)) {
-				if (!qeth_l2_validate_addr(dev)) {
-					qeth_open(dev);
-					qeth_l2_set_rx_mode(dev);
-				}
-			} else {
-				dev_open(dev, NULL);
-			}
+			dev_open(dev, NULL);
 		}
 		rtnl_unlock();
 	}
@@ -900,7 +885,7 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	return 0;
 
 out_remove:
-	qeth_l2_stop_card(card, 0);
+	qeth_l2_stop_card(card);
 	ccw_device_set_offline(CARD_DDEV(card));
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
@@ -912,11 +897,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	return rc;
 }
 
-static int qeth_l2_set_online(struct ccwgroup_device *gdev)
-{
-	return __qeth_l2_set_online(gdev, 0);
-}
-
 static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 					int recovery_mode)
 {
@@ -935,11 +915,12 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 
 	rtnl_lock();
 	card->info.open_when_online = card->dev->flags & IFF_UP;
+	dev_close(card->dev);
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
 
-	qeth_l2_stop_card(card, recovery_mode);
+	qeth_l2_stop_card(card);
 	rc  = ccw_device_set_offline(CARD_DDEV(card));
 	rc2 = ccw_device_set_offline(CARD_WDEV(card));
 	rc3 = ccw_device_set_offline(CARD_RDEV(card));
@@ -974,7 +955,7 @@ static int qeth_l2_recover(void *ptr)
 	dev_warn(&card->gdev->dev,
 		"A recovery process has been started for the device\n");
 	__qeth_l2_set_offline(card->gdev, 1);
-	rc = __qeth_l2_set_online(card->gdev, 1);
+	rc = qeth_l2_set_online(card->gdev);
 	if (!rc)
 		dev_info(&card->gdev->dev,
 			"Device successfully recovered!\n");
@@ -1019,17 +1000,9 @@ static int qeth_l2_pm_suspend(struct ccwgroup_device *gdev)
 static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	int rc = 0;
+	int rc;
 
-	if (card->info.open_when_online) {
-		rc = __qeth_l2_set_online(card->gdev, 1);
-		if (rc) {
-			rtnl_lock();
-			dev_close(card->dev);
-			rtnl_unlock();
-		}
-	} else
-		rc = __qeth_l2_set_online(card->gdev, 0);
+	rc = qeth_l2_set_online(gdev);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (rc)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index c299e84cf5d1..1381e7e312cd 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1406,7 +1406,7 @@ static int qeth_l3_process_inbound_buffer(struct qeth_card *card,
 	return work_done;
 }
 
-static void qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
+static void qeth_l3_stop_card(struct qeth_card *card)
 {
 	QETH_DBF_TEXT(SETUP, 2, "stopcard");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
@@ -1417,16 +1417,8 @@ static void qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
 		qeth_diags_trace(card, QETH_DIAGS_CMD_TRACE_DISABLE);
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
-	    (card->state == CARD_STATE_UP)) {
-		if (recovery_mode)
-			qeth_stop(card->dev);
-		else {
-			rtnl_lock();
-			dev_close(card->dev);
-			rtnl_unlock();
-		}
+	    card->state == CARD_STATE_UP)
 		card->state = CARD_STATE_SOFTSETUP;
-	}
 	if (card->state == CARD_STATE_SOFTSETUP) {
 		qeth_l3_clear_ip_htable(card, 1);
 		qeth_clear_ipacmd_list(card);
@@ -2299,7 +2291,7 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	qeth_l3_clear_ipato_list(card);
 }
 
-static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
+static int qeth_l3_set_online(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	struct net_device *dev = card->dev;
@@ -2375,12 +2367,7 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 
 		if (card->info.open_when_online) {
 			card->info.open_when_online = 0;
-			if (recovery_mode) {
-				qeth_open(dev);
-				qeth_l3_set_rx_mode(dev);
-			} else {
-				dev_open(dev, NULL);
-			}
+			dev_open(dev, NULL);
 		}
 		rtnl_unlock();
 	}
@@ -2391,7 +2378,7 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	mutex_unlock(&card->discipline_mutex);
 	return 0;
 out_remove:
-	qeth_l3_stop_card(card, 0);
+	qeth_l3_stop_card(card);
 	ccw_device_set_offline(CARD_DDEV(card));
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
@@ -2403,11 +2390,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	return rc;
 }
 
-static int qeth_l3_set_online(struct ccwgroup_device *gdev)
-{
-	return __qeth_l3_set_online(gdev, 0);
-}
-
 static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 			int recovery_mode)
 {
@@ -2426,11 +2408,12 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 
 	rtnl_lock();
 	card->info.open_when_online = card->dev->flags & IFF_UP;
+	dev_close(card->dev);
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
 
-	qeth_l3_stop_card(card, recovery_mode);
+	qeth_l3_stop_card(card);
 	if ((card->options.cq == QETH_CQ_ENABLED) && card->dev) {
 		rtnl_lock();
 		call_netdevice_notifiers(NETDEV_REBOOT, card->dev);
@@ -2471,7 +2454,7 @@ static int qeth_l3_recover(void *ptr)
 	dev_warn(&card->gdev->dev,
 		"A recovery process has been started for the device\n");
 	__qeth_l3_set_offline(card->gdev, 1);
-	rc = __qeth_l3_set_online(card->gdev, 1);
+	rc = qeth_l3_set_online(card->gdev);
 	if (!rc)
 		dev_info(&card->gdev->dev,
 			"Device successfully recovered!\n");
@@ -2505,17 +2488,9 @@ static int qeth_l3_pm_suspend(struct ccwgroup_device *gdev)
 static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	int rc = 0;
+	int rc;
 
-	if (card->info.open_when_online) {
-		rc = __qeth_l3_set_online(card->gdev, 1);
-		if (rc) {
-			rtnl_lock();
-			dev_close(card->dev);
-			rtnl_unlock();
-		}
-	} else
-		rc = __qeth_l3_set_online(card->gdev, 0);
+	rc = qeth_l3_set_online(gdev);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
 	if (rc)
-- 
2.16.4
