From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 03/10] s390/qeth: fine-tune RX modesetting
Date: Wed, 11 Jul 2018 17:42:40 +0200
Message-ID: <20180711154247.5523-4-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Changing a device's address lists (or its promisc mode) already triggers
an RX modeset, there's no need to do it manually from the L2 driver's
ndo_vlan_rx_kill_vid() hook.

Also when setting a device online, dev_open() already calls
dev_set_rx_mode(). So a manual modeset is only necessary from the
recovery path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 5 +----
 drivers/s390/net/qeth_l3_main.c | 7 ++++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2487f0aeb165..730ab51fbac5 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -26,7 +26,6 @@
 
 static int qeth_l2_set_offline(struct ccwgroup_device *);
 static int qeth_l2_stop(struct net_device *);
-static void qeth_l2_set_rx_mode(struct net_device *);
 static void qeth_bridgeport_query_support(struct qeth_card *card);
 static void qeth_bridge_state_change(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd);
@@ -344,7 +343,6 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 		rc = qeth_l2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
 		kfree(tmpid);
 	}
-	qeth_l2_set_rx_mode(card->dev);
 	return rc;
 }
 
@@ -1125,13 +1123,12 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		if (recovery_mode &&
 		    card->info.type != QETH_CARD_TYPE_OSN) {
 			__qeth_l2_open(card->dev);
+			qeth_l2_set_rx_mode(card->dev);
 		} else {
 			rtnl_lock();
 			dev_open(card->dev);
 			rtnl_unlock();
 		}
-		/* this also sets saved unicast addresses */
-		qeth_l2_set_rx_mode(card->dev);
 	}
 	/* let user_space know that device is online */
 	kobject_uevent(&gdev->dev.kobj, KOBJ_CHANGE);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 5905dc63e256..a54881cdda82 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2666,11 +2666,12 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
 		rtnl_lock();
-		if (recovery_mode)
+		if (recovery_mode) {
 			__qeth_l3_open(card->dev);
-		else
+			qeth_l3_set_rx_mode(card->dev);
+		} else {
 			dev_open(card->dev);
-		qeth_l3_set_rx_mode(card->dev);
+		}
 		rtnl_unlock();
 	}
 	qeth_trace_features(card);
-- 
2.16.4
