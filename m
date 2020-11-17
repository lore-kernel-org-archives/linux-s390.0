Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9402 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727185AbgKQQPh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Nov 2020 11:15:37 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 6/9] s390/qeth: set static link info during initialization
Date: Tue, 17 Nov 2020 17:15:17 +0100
Message-Id: <20201117161520.1089-7-jwi@linux.ibm.com>
In-Reply-To: <20201117161520.1089-1-jwi@linux.ibm.com>
References: <20201117161520.1089-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

Hard-code the minimal link info at initialization time, after we
obtained the link_type. qeth_get_link_ksettings() can still override
this with more accurate data from QUERY CARD INFO later on.

Don't set arbitrary defaults for unknown OSA link types, they
certainly won't match any future type.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 38 +++++++++++++++++++++++++++++++
 drivers/s390/net/qeth_ethtool.c   | 34 +++------------------------
 3 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 1c9ed498c2b6..c604e20a5e48 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -738,6 +738,7 @@ struct qeth_card_info {
 	struct qeth_card_blkt blkt;
 	__u32 diagass_support;
 	__u32 hwtrap;
+	struct qeth_link_info link_info;
 };
 
 enum qeth_discipline_id {
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e7c226c6c989..aac38ade024b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4950,6 +4950,42 @@ int qeth_query_card_info(struct qeth_card *card,
 	return qeth_send_ipa_cmd(card, iob, qeth_query_card_info_cb, link_info);
 }
 
+static void qeth_init_link_info(struct qeth_card *card)
+{
+	card->info.link_info.duplex = DUPLEX_FULL;
+
+	if (IS_IQD(card) || IS_VM_NIC(card)) {
+		card->info.link_info.speed = SPEED_10000;
+		card->info.link_info.port = PORT_FIBRE;
+	} else {
+		switch (card->info.link_type) {
+		case QETH_LINK_TYPE_FAST_ETH:
+		case QETH_LINK_TYPE_LANE_ETH100:
+			card->info.link_info.speed = SPEED_100;
+			card->info.link_info.port = PORT_TP;
+			break;
+		case QETH_LINK_TYPE_GBIT_ETH:
+		case QETH_LINK_TYPE_LANE_ETH1000:
+			card->info.link_info.speed = SPEED_1000;
+			card->info.link_info.port = PORT_FIBRE;
+			break;
+		case QETH_LINK_TYPE_10GBIT_ETH:
+			card->info.link_info.speed = SPEED_10000;
+			card->info.link_info.port = PORT_FIBRE;
+			break;
+		case QETH_LINK_TYPE_25GBIT_ETH:
+			card->info.link_info.speed = SPEED_25000;
+			card->info.link_info.port = PORT_FIBRE;
+			break;
+		default:
+			dev_info(&card->gdev->dev, "Unknown link type %x\n",
+				 card->info.link_type);
+			card->info.link_info.speed = SPEED_UNKNOWN;
+			card->info.link_info.port = PORT_OTHER;
+		}
+	}
+}
+
 /**
  * qeth_vm_request_mac() - Request a hypervisor-managed MAC address
  * @card: pointer to a qeth_card
@@ -5334,6 +5370,8 @@ static int qeth_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 			goto out;
 	}
 
+	qeth_init_link_info(card);
+
 	rc = qeth_init_qdio_queues(card);
 	if (rc) {
 		QETH_CARD_TEXT_(card, 2, "9err%d", rc);
diff --git a/drivers/s390/net/qeth_ethtool.c b/drivers/s390/net/qeth_ethtool.c
index a6455819f403..b8e74018b44f 100644
--- a/drivers/s390/net/qeth_ethtool.c
+++ b/drivers/s390/net/qeth_ethtool.c
@@ -410,44 +410,16 @@ static int qeth_get_link_ksettings(struct net_device *netdev,
 {
 	struct qeth_card *card = netdev->ml_priv;
 	struct qeth_link_info link_info;
-	enum qeth_link_types link_type;
 
-	if (IS_IQD(card) || IS_VM_NIC(card))
-		link_type = QETH_LINK_TYPE_10GBIT_ETH;
-	else
-		link_type = card->info.link_type;
-
-	cmd->base.duplex = DUPLEX_FULL;
+	cmd->base.speed = card->info.link_info.speed;
+	cmd->base.duplex = card->info.link_info.duplex;
+	cmd->base.port = card->info.link_info.port;
 	cmd->base.autoneg = AUTONEG_ENABLE;
 	cmd->base.phy_address = 0;
 	cmd->base.mdio_support = 0;
 	cmd->base.eth_tp_mdix = ETH_TP_MDI_INVALID;
 	cmd->base.eth_tp_mdix_ctrl = ETH_TP_MDI_INVALID;
 
-	switch (link_type) {
-	case QETH_LINK_TYPE_FAST_ETH:
-	case QETH_LINK_TYPE_LANE_ETH100:
-		cmd->base.speed = SPEED_100;
-		cmd->base.port = PORT_TP;
-		break;
-	case QETH_LINK_TYPE_GBIT_ETH:
-	case QETH_LINK_TYPE_LANE_ETH1000:
-		cmd->base.speed = SPEED_1000;
-		cmd->base.port = PORT_FIBRE;
-		break;
-	case QETH_LINK_TYPE_10GBIT_ETH:
-		cmd->base.speed = SPEED_10000;
-		cmd->base.port = PORT_FIBRE;
-		break;
-	case QETH_LINK_TYPE_25GBIT_ETH:
-		cmd->base.speed = SPEED_25000;
-		cmd->base.port = PORT_FIBRE;
-		break;
-	default:
-		cmd->base.speed = SPEED_10;
-		cmd->base.port = PORT_TP;
-	}
-
 	/* Check if we can obtain more accurate information.	 */
 	if (!qeth_query_card_info(card, &link_info)) {
 		if (link_info.speed != SPEED_UNKNOWN)
-- 
2.17.1
