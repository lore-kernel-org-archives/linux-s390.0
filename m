Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 2/9] s390/qeth: enable/disable the HW trap a little earlier
Date: Thu, 28 Feb 2019 18:59:37 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When setting a L2 qeth device online, enable the HW trap as soon as the
control plane is available. This allows us to catch any error that
occurs during the very first commands.

In the same spirit, the offline code should disable the HW trap as the
very first step of its processing.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 22 ++++++++++++----------
 drivers/s390/net/qeth_l3_main.c |  9 +++++----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index f621656f9ea7..72e6d08444a7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -820,12 +820,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		rc = -ENODEV;
 		goto out_remove;
 	}
-	qeth_bridgeport_query_support(card);
-	if (card->options.sbp.supported_funcs)
-		dev_info(&card->gdev->dev,
-		"The device represents a Bridge Capable Port\n");
-
-	qeth_l2_register_dev_addr(card);
 
 	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
 		if (card->info.hwtrap &&
@@ -834,6 +828,13 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	} else
 		card->info.hwtrap = 0;
 
+	qeth_bridgeport_query_support(card);
+	if (card->options.sbp.supported_funcs)
+		dev_info(&card->gdev->dev,
+		"The device represents a Bridge Capable Port\n");
+
+	qeth_l2_register_dev_addr(card);
+
 	/* for the rx_bcast characteristic, init VNICC after setmac */
 	qeth_l2_vnicc_init(card);
 
@@ -927,16 +928,17 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
+	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
+		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
+		card->info.hwtrap = 1;
+	}
+
 	rtnl_lock();
 	card->info.open_when_online = card->dev->flags & IFF_UP;
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
 
-	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
-		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
-		card->info.hwtrap = 1;
-	}
 	qeth_l2_stop_card(card, recovery_mode);
 	rc  = ccw_device_set_offline(CARD_DDEV(card));
 	rc2 = ccw_device_set_offline(CARD_WDEV(card));
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index fe6b9a82f69e..c299e84cf5d1 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2419,16 +2419,17 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_TEXT(SETUP, 3, "setoffl");
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
+	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
+		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
+		card->info.hwtrap = 1;
+	}
+
 	rtnl_lock();
 	card->info.open_when_online = card->dev->flags & IFF_UP;
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
 
-	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
-		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
-		card->info.hwtrap = 1;
-	}
 	qeth_l3_stop_card(card, recovery_mode);
 	if ((card->options.cq == QETH_CQ_ENABLED) && card->dev) {
 		rtnl_lock();
-- 
2.16.4
