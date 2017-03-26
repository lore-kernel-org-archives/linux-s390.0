Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philippe Reynes <tremyfr@gmail.com>
Subject: [PATCH] net: s390: qeth: use new api ethtool_{get|set}_link_ksettings
Date: Sun, 26 Mar 2017 15:27:38 +0200
Message-Id: <1490534858-4049-1-git-send-email-tremyfr@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Philippe Reynes <tremyfr@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

The ethtool api {get|set}_settings is deprecated.
We move this driver to new api {get|set}_link_ksettings.

As I don't have the hardware, I'd be very pleased if
someone may test this patch.

Signed-off-by: Philippe Reynes <tremyfr@gmail.com>
---
 drivers/s390/net/qeth_core.h      |    3 +-
 drivers/s390/net/qeth_core_main.c |   45 ++++++++++++++++++++----------------
 drivers/s390/net/qeth_l2_main.c   |    2 +-
 drivers/s390/net/qeth_l3_main.c   |    2 +-
 4 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index e7addea..5da0319 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -973,7 +973,8 @@ void qeth_core_get_ethtool_stats(struct net_device *,
 void qeth_core_get_strings(struct net_device *, u32, u8 *);
 void qeth_core_get_drvinfo(struct net_device *, struct ethtool_drvinfo *);
 void qeth_dbf_longtext(debug_info_t *id, int level, char *text, ...);
-int qeth_core_ethtool_get_settings(struct net_device *, struct ethtool_cmd *);
+int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
+					 struct ethtool_link_ksettings *ecmd);
 int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback);
 int qeth_hdr_chk_and_bounce(struct sk_buff *, struct qeth_hdr **, int);
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 315d8a2..dced180 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5899,10 +5899,11 @@ void qeth_core_get_drvinfo(struct net_device *dev,
 /* Autoneg and full-duplex are supported and advertized uncondionally.	     */
 /* Always advertize and support all speeds up to specified, and only one     */
 /* specified port type.							     */
-static void qeth_set_ecmd_adv_sup(struct ethtool_cmd *ecmd,
+static void qeth_set_ecmd_adv_sup(struct ethtool_link_ksettings *ecmd,
 				int maxspeed, int porttype)
 {
 	int port_sup, port_adv, spd_sup, spd_adv;
+	u32 supported, advertising;
 
 	switch (porttype) {
 	case PORT_TP:
@@ -5944,12 +5945,17 @@ static void qeth_set_ecmd_adv_sup(struct ethtool_cmd *ecmd,
 		spd_adv = ADVERTISED_10baseT_Half | ADVERTISED_10baseT_Full;
 		WARN_ON_ONCE(1);
 	}
-	ecmd->advertising = ADVERTISED_Autoneg | port_adv | spd_adv;
-	ecmd->supported = SUPPORTED_Autoneg | port_sup | spd_sup;
+	advertising = ADVERTISED_Autoneg | port_adv | spd_adv;
+	supported = SUPPORTED_Autoneg | port_sup | spd_sup;
+
+	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
+						supported);
+	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.advertising,
+						advertising);
 }
 
-int qeth_core_ethtool_get_settings(struct net_device *netdev,
-					struct ethtool_cmd *ecmd)
+int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
+					 struct ethtool_link_ksettings *ecmd)
 {
 	struct qeth_card *card = netdev->ml_priv;
 	enum qeth_link_types link_type;
@@ -5962,37 +5968,36 @@ int qeth_core_ethtool_get_settings(struct net_device *netdev,
 	else
 		link_type = card->info.link_type;
 
-	ecmd->transceiver = XCVR_INTERNAL;
-	ecmd->duplex = DUPLEX_FULL;
-	ecmd->autoneg = AUTONEG_ENABLE;
+	ecmd->base.duplex = DUPLEX_FULL;
+	ecmd->base.autoneg = AUTONEG_ENABLE;
 
 	switch (link_type) {
 	case QETH_LINK_TYPE_FAST_ETH:
 	case QETH_LINK_TYPE_LANE_ETH100:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_100, PORT_TP);
 		speed = SPEED_100;
-		ecmd->port = PORT_TP;
+		ecmd->base.port = PORT_TP;
 		break;
 
 	case QETH_LINK_TYPE_GBIT_ETH:
 	case QETH_LINK_TYPE_LANE_ETH1000:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_1000, PORT_FIBRE);
 		speed = SPEED_1000;
-		ecmd->port = PORT_FIBRE;
+		ecmd->base.port = PORT_FIBRE;
 		break;
 
 	case QETH_LINK_TYPE_10GBIT_ETH:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_10000, PORT_FIBRE);
 		speed = SPEED_10000;
-		ecmd->port = PORT_FIBRE;
+		ecmd->base.port = PORT_FIBRE;
 		break;
 
 	default:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_10, PORT_TP);
 		speed = SPEED_10;
-		ecmd->port = PORT_TP;
+		ecmd->base.port = PORT_TP;
 	}
-	ethtool_cmd_speed_set(ecmd, speed);
+	ecmd->base.speed = speed;
 
 	/* Check if we can obtain more accurate information.	 */
 	/* If QUERY_CARD_INFO command is not supported or fails, */
@@ -6018,26 +6023,26 @@ int qeth_core_ethtool_get_settings(struct net_device *netdev,
 	case CARD_INFO_TYPE_1G_COPPER_A:
 	case CARD_INFO_TYPE_1G_COPPER_B:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_1000, PORT_TP);
-		ecmd->port = PORT_TP;
+		ecmd->base.port = PORT_TP;
 		break;
 	case CARD_INFO_TYPE_1G_FIBRE_A:
 	case CARD_INFO_TYPE_1G_FIBRE_B:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_1000, PORT_FIBRE);
-		ecmd->port = PORT_FIBRE;
+		ecmd->base.port = PORT_FIBRE;
 		break;
 	case CARD_INFO_TYPE_10G_FIBRE_A:
 	case CARD_INFO_TYPE_10G_FIBRE_B:
 		qeth_set_ecmd_adv_sup(ecmd, SPEED_10000, PORT_FIBRE);
-		ecmd->port = PORT_FIBRE;
+		ecmd->base.port = PORT_FIBRE;
 		break;
 	}
 
 	switch (carrier_info.port_mode) {
 	case CARD_INFO_PORTM_FULLDUPLEX:
-		ecmd->duplex = DUPLEX_FULL;
+		ecmd->base.duplex = DUPLEX_FULL;
 		break;
 	case CARD_INFO_PORTM_HALFDUPLEX:
-		ecmd->duplex = DUPLEX_HALF;
+		ecmd->base.duplex = DUPLEX_HALF;
 		break;
 	}
 
@@ -6055,11 +6060,11 @@ int qeth_core_ethtool_get_settings(struct net_device *netdev,
 		speed = SPEED_10000;
 		break;
 	}
-	ethtool_cmd_speed_set(ecmd, speed);
+	ecmd->base.speed = speed;
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qeth_core_ethtool_get_settings);
+EXPORT_SYMBOL_GPL(qeth_core_ethtool_get_link_ksettings);
 
 /* Callback to handle checksum offload command reply from OSA card.
  * Verify that required features have been enabled on the card.
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index bea4833..55b3ca1 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -1042,7 +1042,7 @@ static void qeth_l2_remove_device(struct ccwgroup_device *cgdev)
 	.get_ethtool_stats = qeth_core_get_ethtool_stats,
 	.get_sset_count = qeth_core_get_sset_count,
 	.get_drvinfo = qeth_core_get_drvinfo,
-	.get_settings = qeth_core_ethtool_get_settings,
+	.get_link_ksettings = qeth_core_ethtool_get_link_ksettings,
 };
 
 static const struct ethtool_ops qeth_l2_osn_ops = {
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 06d0add..63e6ae9 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3032,7 +3032,7 @@ static int qeth_l3_stop(struct net_device *dev)
 	.get_ethtool_stats = qeth_core_get_ethtool_stats,
 	.get_sset_count = qeth_core_get_sset_count,
 	.get_drvinfo = qeth_core_get_drvinfo,
-	.get_settings = qeth_core_ethtool_get_settings,
+	.get_link_ksettings = qeth_core_ethtool_get_link_ksettings,
 };
 
 /*
-- 
1.7.4.4
