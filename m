From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 6/6] s390/qeth: report 25Gbit link speed
Date: Fri,  2 Nov 2018 19:04:13 +0100
Message-ID: <20181102180413.53020-7-jwi@linux.ibm.com>
References: <20181102180413.53020-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181102180413.53020-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This adds the various identifiers for 25Gbit cards, and wires them up
into sysfs and ethtool.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 20 ++++++++++++++++++--
 drivers/s390/net/qeth_core_mpc.h  |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 82282b2092d8..4bce5ae65a55 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -167,6 +167,8 @@ const char *qeth_get_cardname_short(struct qeth_card *card)
 				return "OSD_1000";
 			case QETH_LINK_TYPE_10GBIT_ETH:
 				return "OSD_10GIG";
+			case QETH_LINK_TYPE_25GBIT_ETH:
+				return "OSD_25GIG";
 			case QETH_LINK_TYPE_LANE_ETH100:
 				return "OSD_FE_LANE";
 			case QETH_LINK_TYPE_LANE_TR:
@@ -4432,7 +4434,8 @@ static int qeth_mdio_read(struct net_device *dev, int phy_id, int regnum)
 		rc = BMCR_FULLDPLX;
 		if ((card->info.link_type != QETH_LINK_TYPE_GBIT_ETH) &&
 		    (card->info.link_type != QETH_LINK_TYPE_OSN) &&
-		    (card->info.link_type != QETH_LINK_TYPE_10GBIT_ETH))
+		    (card->info.link_type != QETH_LINK_TYPE_10GBIT_ETH) &&
+		    (card->info.link_type != QETH_LINK_TYPE_25GBIT_ETH))
 			rc |= BMCR_SPEED100;
 		break;
 	case MII_BMSR: /* Basic mode status register */
@@ -6166,8 +6169,14 @@ static void qeth_set_cmd_adv_sup(struct ethtool_link_ksettings *cmd,
 		WARN_ON_ONCE(1);
 	}
 
-	/* fallthrough from high to low, to select all legal speeds: */
+	/* partially does fall through, to also select lower speeds */
 	switch (maxspeed) {
+	case SPEED_25000:
+		ethtool_link_ksettings_add_link_mode(cmd, supported,
+						     25000baseSR_Full);
+		ethtool_link_ksettings_add_link_mode(cmd, advertising,
+						     25000baseSR_Full);
+		break;
 	case SPEED_10000:
 		ethtool_link_ksettings_add_link_mode(cmd, supported,
 						     10000baseT_Full);
@@ -6250,6 +6259,10 @@ int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
 		cmd->base.speed = SPEED_10000;
 		cmd->base.port = PORT_FIBRE;
 		break;
+	case QETH_LINK_TYPE_25GBIT_ETH:
+		cmd->base.speed = SPEED_25000;
+		cmd->base.port = PORT_FIBRE;
+		break;
 	default:
 		cmd->base.speed = SPEED_10;
 		cmd->base.port = PORT_TP;
@@ -6316,6 +6329,9 @@ int qeth_core_ethtool_get_link_ksettings(struct net_device *netdev,
 	case CARD_INFO_PORTS_10G:
 		cmd->base.speed = SPEED_10000;
 		break;
+	case CARD_INFO_PORTS_25G:
+		cmd->base.speed = SPEED_25000;
+		break;
 	}
 
 	return 0;
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index 80c036acf563..3e54be201b27 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -90,6 +90,7 @@ enum qeth_link_types {
 	QETH_LINK_TYPE_GBIT_ETH     = 0x03,
 	QETH_LINK_TYPE_OSN          = 0x04,
 	QETH_LINK_TYPE_10GBIT_ETH   = 0x10,
+	QETH_LINK_TYPE_25GBIT_ETH   = 0x12,
 	QETH_LINK_TYPE_LANE_ETH100  = 0x81,
 	QETH_LINK_TYPE_LANE_TR      = 0x82,
 	QETH_LINK_TYPE_LANE_ETH1000 = 0x83,
@@ -347,6 +348,7 @@ enum qeth_card_info_port_speed {
 	CARD_INFO_PORTS_100M		= 0x00000006,
 	CARD_INFO_PORTS_1G		= 0x00000007,
 	CARD_INFO_PORTS_10G		= 0x00000008,
+	CARD_INFO_PORTS_25G		= 0x0000000A,
 };
 
 /* (SET)DELIP(M) IPA stuff ***************************************************/
-- 
2.16.4
