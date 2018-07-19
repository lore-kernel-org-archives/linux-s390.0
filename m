From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/11] s390/qeth: use core MTU range checking
Date: Thu, 19 Jul 2018 12:43:54 +0200
Message-ID: <20180719104358.79696-8-jwi@linux.ibm.com>
References: <20180719104358.79696-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180719104358.79696-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth's ndo_change_mtu() only applies some trivial bounds checking. Set
up dev->min_mtu properly, so that dev_set_mtu() can do this for us.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 -
 drivers/s390/net/qeth_core_main.c | 34 +---------------------------------
 drivers/s390/net/qeth_core_mpc.h  |  1 +
 drivers/s390/net/qeth_l2_main.c   |  1 -
 drivers/s390/net/qeth_l3_main.c   |  2 --
 5 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 6f02a6cbe59e..994ac7f434d5 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -993,7 +993,6 @@ void qeth_clear_cmd_buffers(struct qeth_channel *);
 void qeth_clear_qdio_buffers(struct qeth_card *);
 void qeth_setadp_promisc_mode(struct qeth_card *);
 struct net_device_stats *qeth_get_stats(struct net_device *);
-int qeth_change_mtu(struct net_device *, int);
 int qeth_setadpparms_change_macaddr(struct qeth_card *);
 void qeth_tx_timeout(struct net_device *);
 void qeth_prepare_control_data(struct qeth_card *, int,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ab3d63f98779..717511c167e7 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2332,20 +2332,6 @@ static int qeth_get_mtu_outof_framesize(int framesize)
 	}
 }
 
-static int qeth_mtu_is_valid(struct qeth_card *card, int mtu)
-{
-	switch (card->info.type) {
-	case QETH_CARD_TYPE_OSD:
-	case QETH_CARD_TYPE_OSM:
-	case QETH_CARD_TYPE_OSX:
-	case QETH_CARD_TYPE_IQD:
-		return ((mtu >= 576) && (mtu <= card->dev->max_mtu));
-	case QETH_CARD_TYPE_OSN:
-	default:
-		return 1;
-	}
-}
-
 static int qeth_ulp_enable_cb(struct qeth_card *card, struct qeth_reply *reply,
 		unsigned long data)
 {
@@ -4204,24 +4190,6 @@ void qeth_setadp_promisc_mode(struct qeth_card *card)
 }
 EXPORT_SYMBOL_GPL(qeth_setadp_promisc_mode);
 
-int qeth_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct qeth_card *card;
-	char dbf_text[15];
-
-	card = dev->ml_priv;
-
-	QETH_CARD_TEXT(card, 4, "chgmtu");
-	sprintf(dbf_text, "%8x", new_mtu);
-	QETH_CARD_TEXT(card, 4, dbf_text);
-
-	if (!qeth_mtu_is_valid(card, new_mtu))
-		return -EINVAL;
-	dev->mtu = new_mtu;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(qeth_change_mtu);
-
 struct net_device_stats *qeth_get_stats(struct net_device *dev)
 {
 	struct qeth_card *card;
@@ -5696,7 +5664,7 @@ static struct net_device *qeth_alloc_netdev(struct qeth_card *card)
 
 	dev->ml_priv = card;
 	dev->watchdog_timeo = QETH_TX_TIMEOUT;
-	dev->min_mtu = 64;
+	dev->min_mtu = IS_OSN(card) ? 64 : 576;
 	 /* initialized when device first goes online: */
 	dev->max_mtu = 0;
 	dev->mtu = 0;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 54c35224262a..cf5ad94e960a 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -65,6 +65,7 @@ enum qeth_card_types {
 };
 
 #define IS_IQD(card)	((card)->info.type == QETH_CARD_TYPE_IQD)
+#define IS_OSN(card)	((card)->info.type == QETH_CARD_TYPE_OSN)
 
 #define QETH_MPC_DIFINFO_LEN_INDICATES_LINK_TYPE 0x18
 /* only the first two bytes are looked at in qeth_get_cardname_short */
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 00d8bb1d2a41..668f80680575 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -928,7 +928,6 @@ static const struct net_device_ops qeth_l2_netdev_ops = {
 	.ndo_set_rx_mode	= qeth_l2_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
 	.ndo_set_mac_address    = qeth_l2_set_mac_address,
-	.ndo_change_mtu	   	= qeth_change_mtu,
 	.ndo_vlan_rx_add_vid	= qeth_l2_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid   = qeth_l2_vlan_rx_kill_vid,
 	.ndo_tx_timeout	   	= qeth_tx_timeout,
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index e5fa8e5ac1b3..078b891a6d24 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2506,7 +2506,6 @@ static const struct net_device_ops qeth_l3_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
-	.ndo_change_mtu		= qeth_change_mtu,
 	.ndo_fix_features	= qeth_fix_features,
 	.ndo_set_features	= qeth_set_features,
 	.ndo_vlan_rx_add_vid	= qeth_l3_vlan_rx_add_vid,
@@ -2523,7 +2522,6 @@ static const struct net_device_ops qeth_l3_osa_netdev_ops = {
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_rx_mode	= qeth_l3_set_rx_mode,
 	.ndo_do_ioctl		= qeth_do_ioctl,
-	.ndo_change_mtu		= qeth_change_mtu,
 	.ndo_fix_features	= qeth_fix_features,
 	.ndo_set_features	= qeth_set_features,
 	.ndo_vlan_rx_add_vid	= qeth_l3_vlan_rx_add_vid,
-- 
2.16.4
