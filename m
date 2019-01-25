Return-Path: <SRS0=Yw43=QB=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/8] s390/qeth: consolidate open/stop netdev ops
Date: Fri, 25 Jan 2019 15:44:18 +0100
In-Reply-To: <20190125144423.81443-1-jwi@linux.ibm.com>
References: <20190125144423.81443-1-jwi@linux.ibm.com>
Message-Id: <20190125144423.81443-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The L2 and L3 code for these ops is almost identical, we only need to
provide a custom ndo_validate_addr() for L2 that checks whether
programming the MAC address succeeded.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  4 ++
 drivers/s390/net/qeth_core_main.c | 53 +++++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   | 88 ++++++++++-----------------------------
 drivers/s390/net/qeth_l3_main.c   | 63 +++-------------------------
 4 files changed, 84 insertions(+), 124 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 0ee026947f20..ffec26ff512d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1047,6 +1047,10 @@ netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
 netdev_features_t qeth_features_check(struct sk_buff *skb,
 				      struct net_device *dev,
 				      netdev_features_t features);
+int qeth_open_internal(struct net_device *dev);
+int qeth_open(struct net_device *dev);
+int qeth_stop(struct net_device *dev);
+
 int qeth_vm_request_mac(struct qeth_card *card);
 int qeth_xmit(struct qeth_card *card, struct sk_buff *skb,
 	      struct qeth_qdio_out_q *queue, int ipv, int cast_type,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index f784d5c528a9..db1aaa796bef 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6652,6 +6652,59 @@ netdev_features_t qeth_features_check(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(qeth_features_check);
 
+int qeth_open_internal(struct net_device *dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	QETH_CARD_TEXT(card, 4, "qethopen");
+	if (card->state == CARD_STATE_UP)
+		return 0;
+	if (card->state != CARD_STATE_SOFTSETUP)
+		return -ENODEV;
+
+	if (qdio_stop_irq(CARD_DDEV(card), 0) < 0)
+		return -EIO;
+
+	card->data.state = CH_STATE_UP;
+	card->state = CARD_STATE_UP;
+	netif_start_queue(dev);
+
+	napi_enable(&card->napi);
+	local_bh_disable();
+	napi_schedule(&card->napi);
+	/* kick-start the NAPI softirq: */
+	local_bh_enable();
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qeth_open_internal);
+
+int qeth_open(struct net_device *dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	QETH_CARD_TEXT(card, 5, "qethope_");
+	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
+		QETH_CARD_TEXT(card, 3, "openREC");
+		return -ERESTARTSYS;
+	}
+	return qeth_open_internal(dev);
+}
+EXPORT_SYMBOL_GPL(qeth_open);
+
+int qeth_stop(struct net_device *dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	QETH_CARD_TEXT(card, 4, "qethstop");
+	netif_tx_disable(dev);
+	if (card->state == CARD_STATE_UP) {
+		card->state = CARD_STATE_SOFTSETUP;
+		napi_disable(&card->napi);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qeth_stop);
+
 static int __init qeth_core_init(void)
 {
 	int rc;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f108d4b44605..8b9181c8bc7e 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -25,7 +25,6 @@
 #include "qeth_l2.h"
 
 static int qeth_l2_set_offline(struct ccwgroup_device *);
-static int qeth_l2_stop(struct net_device *);
 static void qeth_bridgeport_query_support(struct qeth_card *card);
 static void qeth_bridge_state_change(struct qeth_card *card,
 					struct qeth_ipa_cmd *cmd);
@@ -343,9 +342,8 @@ static void qeth_l2_stop_card(struct qeth_card *card, int recovery_mode)
 	if (card->read.state == CH_STATE_UP &&
 	    card->write.state == CH_STATE_UP &&
 	    (card->state == CARD_STATE_UP)) {
-		if (recovery_mode &&
-		    card->info.type != QETH_CARD_TYPE_OSN) {
-			qeth_l2_stop(card->dev);
+		if (recovery_mode && !IS_OSN(card)) {
+			qeth_stop(card->dev);
 		} else {
 			rtnl_lock();
 			dev_close(card->dev);
@@ -460,6 +458,17 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 	return 0;
 }
 
+static int qeth_l2_validate_addr(struct net_device *dev)
+{
+	struct qeth_card *card = dev->ml_priv;
+
+	if (IS_OSN(card) || (card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))
+		return eth_validate_addr(dev);
+
+	QETH_CARD_TEXT(card, 4, "nomacadr");
+	return -EPERM;
+}
+
 static int qeth_l2_set_mac_address(struct net_device *dev, void *p)
 {
 	struct sockaddr *addr = p;
@@ -712,62 +721,6 @@ static netdev_tx_t qeth_l2_hard_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int __qeth_l2_open(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-	int rc = 0;
-
-	QETH_CARD_TEXT(card, 4, "qethopen");
-	if (card->state == CARD_STATE_UP)
-		return rc;
-	if (card->state != CARD_STATE_SOFTSETUP)
-		return -ENODEV;
-
-	if ((card->info.type != QETH_CARD_TYPE_OSN) &&
-	     (!(card->info.mac_bits & QETH_LAYER2_MAC_REGISTERED))) {
-		QETH_CARD_TEXT(card, 4, "nomacadr");
-		return -EPERM;
-	}
-	card->data.state = CH_STATE_UP;
-	card->state = CARD_STATE_UP;
-	netif_start_queue(dev);
-
-	if (qdio_stop_irq(card->data.ccwdev, 0) >= 0) {
-		napi_enable(&card->napi);
-		local_bh_disable();
-		napi_schedule(&card->napi);
-		/* kick-start the NAPI softirq: */
-		local_bh_enable();
-	} else
-		rc = -EIO;
-	return rc;
-}
-
-static int qeth_l2_open(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-
-	QETH_CARD_TEXT(card, 5, "qethope_");
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "openREC");
-		return -ERESTARTSYS;
-	}
-	return __qeth_l2_open(dev);
-}
-
-static int qeth_l2_stop(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-
-	QETH_CARD_TEXT(card, 4, "qethstop");
-	netif_tx_disable(dev);
-	if (card->state == CARD_STATE_UP) {
-		card->state = CARD_STATE_SOFTSETUP;
-		napi_disable(&card->napi);
-	}
-	return 0;
-}
-
 static const struct device_type qeth_l2_devtype = {
 	.name = "qeth_layer2",
 	.groups = qeth_l2_attr_groups,
@@ -822,12 +775,12 @@ static const struct ethtool_ops qeth_l2_osn_ops = {
 };
 
 static const struct net_device_ops qeth_l2_netdev_ops = {
-	.ndo_open		= qeth_l2_open,
-	.ndo_stop		= qeth_l2_stop,
+	.ndo_open		= qeth_open,
+	.ndo_stop		= qeth_stop,
 	.ndo_get_stats		= qeth_get_stats,
 	.ndo_start_xmit		= qeth_l2_hard_start_xmit,
 	.ndo_features_check	= qeth_features_check,
-	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_validate_addr	= qeth_l2_validate_addr,
 	.ndo_set_rx_mode	= qeth_l2_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
 	.ndo_set_mac_address    = qeth_l2_set_mac_address,
@@ -1001,10 +954,11 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 
 	qeth_enable_hw_features(card->dev);
 	if (recover_flag == CARD_STATE_RECOVER) {
-		if (recovery_mode &&
-		    card->info.type != QETH_CARD_TYPE_OSN) {
-			__qeth_l2_open(card->dev);
-			qeth_l2_set_rx_mode(card->dev);
+		if (recovery_mode && !IS_OSN(card)) {
+			if (!qeth_l2_validate_addr(card->dev)) {
+				qeth_open_internal(card->dev);
+				qeth_l2_set_rx_mode(card->dev);
+			}
 		} else {
 			rtnl_lock();
 			dev_open(card->dev, NULL);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 42a7cdc59b76..b8a2493a6607 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -40,7 +40,6 @@
 
 
 static int qeth_l3_set_offline(struct ccwgroup_device *);
-static int qeth_l3_stop(struct net_device *);
 static void qeth_l3_set_rx_mode(struct net_device *dev);
 static int qeth_l3_register_addr_entry(struct qeth_card *,
 		struct qeth_ipaddr *);
@@ -1410,7 +1409,7 @@ static void qeth_l3_stop_card(struct qeth_card *card, int recovery_mode)
 	    card->write.state == CH_STATE_UP &&
 	    (card->state == CARD_STATE_UP)) {
 		if (recovery_mode)
-			qeth_l3_stop(card->dev);
+			qeth_stop(card->dev);
 		else {
 			rtnl_lock();
 			dev_close(card->dev);
@@ -2100,56 +2099,6 @@ static netdev_tx_t qeth_l3_hard_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static int __qeth_l3_open(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-	int rc = 0;
-
-	QETH_CARD_TEXT(card, 4, "qethopen");
-	if (card->state == CARD_STATE_UP)
-		return rc;
-	if (card->state != CARD_STATE_SOFTSETUP)
-		return -ENODEV;
-	card->data.state = CH_STATE_UP;
-	card->state = CARD_STATE_UP;
-	netif_start_queue(dev);
-
-	if (qdio_stop_irq(card->data.ccwdev, 0) >= 0) {
-		napi_enable(&card->napi);
-		local_bh_disable();
-		napi_schedule(&card->napi);
-		/* kick-start the NAPI softirq: */
-		local_bh_enable();
-	} else
-		rc = -EIO;
-	return rc;
-}
-
-static int qeth_l3_open(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-
-	QETH_CARD_TEXT(card, 5, "qethope_");
-	if (qeth_wait_for_threads(card, QETH_RECOVER_THREAD)) {
-		QETH_CARD_TEXT(card, 3, "openREC");
-		return -ERESTARTSYS;
-	}
-	return __qeth_l3_open(dev);
-}
-
-static int qeth_l3_stop(struct net_device *dev)
-{
-	struct qeth_card *card = dev->ml_priv;
-
-	QETH_CARD_TEXT(card, 4, "qethstop");
-	netif_tx_disable(dev);
-	if (card->state == CARD_STATE_UP) {
-		card->state = CARD_STATE_SOFTSETUP;
-		napi_disable(&card->napi);
-	}
-	return 0;
-}
-
 static const struct ethtool_ops qeth_l3_ethtool_ops = {
 	.get_link = ethtool_op_get_link,
 	.get_strings = qeth_core_get_strings,
@@ -2193,8 +2142,8 @@ static netdev_features_t qeth_l3_osa_features_check(struct sk_buff *skb,
 }
 
 static const struct net_device_ops qeth_l3_netdev_ops = {
-	.ndo_open		= qeth_l3_open,
-	.ndo_stop		= qeth_l3_stop,
+	.ndo_open		= qeth_open,
+	.ndo_stop		= qeth_stop,
 	.ndo_get_stats		= qeth_get_stats,
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -2208,8 +2157,8 @@ static const struct net_device_ops qeth_l3_netdev_ops = {
 };
 
 static const struct net_device_ops qeth_l3_osa_netdev_ops = {
-	.ndo_open		= qeth_l3_open,
-	.ndo_stop		= qeth_l3_stop,
+	.ndo_open		= qeth_open,
+	.ndo_stop		= qeth_stop,
 	.ndo_get_stats		= qeth_get_stats,
 	.ndo_start_xmit		= qeth_l3_hard_start_xmit,
 	.ndo_features_check	= qeth_l3_osa_features_check,
@@ -2414,7 +2363,7 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	if (recover_flag == CARD_STATE_RECOVER) {
 		rtnl_lock();
 		if (recovery_mode) {
-			__qeth_l3_open(card->dev);
+			qeth_open_internal(card->dev);
 			qeth_l3_set_rx_mode(card->dev);
 		} else {
 			dev_open(card->dev, NULL);
-- 
2.16.4
