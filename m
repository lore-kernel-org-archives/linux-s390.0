From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 5/5] s390/qeth: consistently re-enable device features
Date: Fri, 29 Jun 2018 19:45:54 +0200
Message-ID: <20180629174554.53718-6-jwi@linux.ibm.com>
References: <20180629174554.53718-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180629174554.53718-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit e830baa9c3f0 ("qeth: restore device features after recovery") and
commit ce3443564145 ("s390/qeth: rely on kernel for feature recovery")
made sure that the HW functions for device features get re-programmed
after recovery.

But we missed that the same handling is also required when a card is
first set offline (destroying all HW context), and then online again.
Fix this by moving the re-enable action out of the recovery-only path.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 23 +++++++++++------------
 drivers/s390/net/qeth_l2_main.c   |  5 ++---
 drivers/s390/net/qeth_l3_main.c   |  3 ++-
 4 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 940fd7b558d3..a246a618f9a4 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1040,7 +1040,7 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *,
 						 __u16, __u16,
 						 enum qeth_prot_versions);
 int qeth_set_features(struct net_device *, netdev_features_t);
-void qeth_recover_features(struct net_device *dev);
+void qeth_enable_hw_features(struct net_device *dev);
 netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
 netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d20a69a3bc40..d01ac29fd986 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6469,28 +6469,27 @@ static int qeth_set_ipa_rx_csum(struct qeth_card *card, bool on)
 #define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO | \
 			  NETIF_F_IPV6_CSUM)
 /**
- * qeth_recover_features() - Restore device features after recovery
- * @dev:	the recovering net_device
- *
- * Caller must hold rtnl lock.
+ * qeth_enable_hw_features() - (Re-)Enable HW functions for device features
+ * @dev:	a net_device
  */
-void qeth_recover_features(struct net_device *dev)
+void qeth_enable_hw_features(struct net_device *dev)
 {
-	netdev_features_t features = dev->features;
 	struct qeth_card *card = dev->ml_priv;
+	netdev_features_t features;
 
+	rtnl_lock();
+	features = dev->features;
 	/* force-off any feature that needs an IPA sequence.
 	 * netdev_update_features() will restart them.
 	 */
 	dev->features &= ~QETH_HW_FEATURES;
 	netdev_update_features(dev);
-
-	if (features == dev->features)
-		return;
-	dev_warn(&card->gdev->dev,
-		 "Device recovery failed to restore all offload features\n");
+	if (features != dev->features)
+		dev_warn(&card->gdev->dev,
+			 "Device recovery failed to restore all offload features\n");
+	rtnl_unlock();
 }
-EXPORT_SYMBOL_GPL(qeth_recover_features);
+EXPORT_SYMBOL_GPL(qeth_enable_hw_features);
 
 int qeth_set_features(struct net_device *dev, netdev_features_t features)
 {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 5464515b71f1..2487f0aeb165 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1119,6 +1119,8 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		netif_carrier_off(card->dev);
 
 	qeth_set_allowed_threads(card, 0xffffffff, 0);
+
+	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
 		if (recovery_mode &&
 		    card->info.type != QETH_CARD_TYPE_OSN) {
@@ -1130,9 +1132,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		}
 		/* this also sets saved unicast addresses */
 		qeth_l2_set_rx_mode(card->dev);
-		rtnl_lock();
-		qeth_recover_features(card->dev);
-		rtnl_unlock();
 	}
 	/* let user_space know that device is online */
 	kobject_uevent(&gdev->dev.kobj, KOBJ_CHANGE);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e7fa479adf47..5905dc63e256 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2662,6 +2662,8 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		netif_carrier_on(card->dev);
 	else
 		netif_carrier_off(card->dev);
+
+	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
 		rtnl_lock();
 		if (recovery_mode)
@@ -2669,7 +2671,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		else
 			dev_open(card->dev);
 		qeth_l3_set_rx_mode(card->dev);
-		qeth_recover_features(card->dev);
 		rtnl_unlock();
 	}
 	qeth_trace_features(card);
-- 
2.16.4
