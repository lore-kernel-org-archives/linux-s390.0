From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 01/13] s390/qeth: rely on kernel for feature recovery
Date: Wed, 18 Oct 2017 17:40:13 +0200
Message-ID: <20171018154025.73630-2-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When recovering a device, qeth needs to re-run the IPA commands that
enable all previously active HW features.
Instead of duplicating qeth_set_features(), let netdev_update_features()
recover the missing HW features from dev->wanted_features.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c | 40 ++++++++++++++++++---------------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 91fcadbede80..3b6aa0c48221 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -998,7 +998,7 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *,
 						 __u16, __u16,
 						 enum qeth_prot_versions);
 int qeth_set_features(struct net_device *, netdev_features_t);
-int qeth_recover_features(struct net_device *);
+void qeth_recover_features(struct net_device *dev);
 netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
 int qeth_vm_request_mac(struct qeth_card *card);
 int qeth_push_hdr(struct sk_buff *skb, struct qeth_hdr **hdr, unsigned int len);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 68e118f1202e..e10e5b8d476c 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6403,32 +6403,29 @@ static int qeth_set_ipa_tso(struct qeth_card *card, int on)
 	return rc;
 }
 
-/* try to restore device features on a device after recovery */
-int qeth_recover_features(struct net_device *dev)
+#define QETH_HW_FEATURES (NETIF_F_RXCSUM | NETIF_F_IP_CSUM | NETIF_F_TSO)
+
+/**
+ * qeth_recover_features() - Restore device features after recovery
+ * @dev:	the recovering net_device
+ *
+ * Caller must hold rtnl lock.
+ */
+void qeth_recover_features(struct net_device *dev)
 {
+	netdev_features_t features = dev->features;
 	struct qeth_card *card = dev->ml_priv;
-	netdev_features_t recover = dev->features;
-
-	if (recover & NETIF_F_IP_CSUM) {
-		if (qeth_set_ipa_csum(card, 1, IPA_OUTBOUND_CHECKSUM))
-			recover ^= NETIF_F_IP_CSUM;
-	}
-	if (recover & NETIF_F_RXCSUM) {
-		if (qeth_set_ipa_csum(card, 1, IPA_INBOUND_CHECKSUM))
-			recover ^= NETIF_F_RXCSUM;
-	}
-	if (recover & NETIF_F_TSO) {
-		if (qeth_set_ipa_tso(card, 1))
-			recover ^= NETIF_F_TSO;
-	}
 
-	if (recover == dev->features)
-		return 0;
+	/* force-off any feature that needs an IPA sequence.
+	 * netdev_update_features() will restart them.
+	 */
+	dev->features &= ~QETH_HW_FEATURES;
+	netdev_update_features(dev);
 
+	if (features == dev->features)
+		return;
 	dev_warn(&card->gdev->dev,
 		 "Device recovery failed to restore all offload features\n");
-	dev->features = recover;
-	return -EIO;
 }
 EXPORT_SYMBOL_GPL(qeth_recover_features);
 
@@ -6485,8 +6482,7 @@ netdev_features_t qeth_fix_features(struct net_device *dev,
 	/* if the card isn't up, remove features that require hw changes */
 	if (card->state == CARD_STATE_DOWN ||
 	    card->state == CARD_STATE_RECOVER)
-		features = features & ~(NETIF_F_IP_CSUM | NETIF_F_RXCSUM |
-					NETIF_F_TSO);
+		features &= ~QETH_HW_FEATURES;
 	QETH_DBF_HEX(SETUP, 2, &features, sizeof(features));
 	return features;
 }
-- 
2.13.5
