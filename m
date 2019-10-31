Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/8] s390/qeth: consolidate some duplicated HW cmd code
Date: Thu, 31 Oct 2019 13:42:18 +0100
In-Reply-To: <20191031124221.34028-1-jwi@linux.ibm.com>
References: <20191031124221.34028-1-jwi@linux.ibm.com>
Message-Id: <20191031124221.34028-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When setting a device online, both subdrivers have the same code to
program the HW trap and Isolation mode. Move that code into a single
place.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 10 +++++++++-
 drivers/s390/net/qeth_l2_main.c   | 21 ---------------------
 drivers/s390/net/qeth_l3_main.c   |  9 ---------
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index d4e66707a03f..d51dcb3c5a01 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4293,7 +4293,6 @@ int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback)
 	}
 	return rc;
 }
-EXPORT_SYMBOL_GPL(qeth_set_access_ctrl_online);
 
 void qeth_tx_timeout(struct net_device *dev)
 {
@@ -5009,6 +5008,15 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 			goto out;
 		}
 	}
+
+	if (!qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP) ||
+	    (card->info.hwtrap && qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM)))
+		card->info.hwtrap = 0;
+
+	rc = qeth_set_access_ctrl_online(card, 0);
+	if (rc)
+		goto out;
+
 	return 0;
 out:
 	dev_warn(&card->gdev->dev, "The qeth device driver failed to recover "
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index bd8143e51747..8f3093d24b12 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -759,14 +759,6 @@ static int qeth_l2_setup_netdev(struct qeth_card *card, bool carrier_ok)
 	return rc;
 }
 
-static int qeth_l2_start_ipassists(struct qeth_card *card)
-{
-	/* configure isolation level */
-	if (qeth_set_access_ctrl_online(card, 0))
-		return -ENODEV;
-	return 0;
-}
-
 static void qeth_l2_trace_features(struct qeth_card *card)
 {
 	/* Set BridgePort features */
@@ -797,13 +789,6 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 		goto out_remove;
 	}
 
-	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
-		if (card->info.hwtrap &&
-		    qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM))
-			card->info.hwtrap = 0;
-	} else
-		card->info.hwtrap = 0;
-
 	qeth_bridgeport_query_support(card);
 	if (card->options.sbp.supported_funcs)
 		dev_info(&card->gdev->dev,
@@ -825,12 +810,6 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 	/* softsetup */
 	QETH_CARD_TEXT(card, 2, "softsetp");
 
-	if (IS_OSD(card) || IS_OSX(card)) {
-		rc = qeth_l2_start_ipassists(card);
-		if (rc)
-			goto out_remove;
-	}
-
 	rc = qeth_init_qdio_queues(card);
 	if (rc) {
 		QETH_CARD_TEXT_(card, 2, "6err%d", rc);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index d7bfc7a0e4c0..acae44a699ad 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -953,8 +953,6 @@ static int qeth_l3_start_ipassists(struct qeth_card *card)
 {
 	QETH_CARD_TEXT(card, 3, "strtipas");
 
-	if (qeth_set_access_ctrl_online(card, 0))
-		return -EIO;
 	qeth_l3_start_ipa_arp_processing(card);	/* go on*/
 	qeth_l3_start_ipa_source_mac(card);	/* go on*/
 	qeth_l3_start_ipa_vlan(card);		/* go on*/
@@ -2313,13 +2311,6 @@ static int qeth_l3_set_online(struct ccwgroup_device *gdev)
 		goto out_remove;
 	}
 
-	if (qeth_is_diagass_supported(card, QETH_DIAGS_CMD_TRAP)) {
-		if (card->info.hwtrap &&
-		    qeth_hw_trap(card, QETH_DIAGS_TRAP_ARM))
-			card->info.hwtrap = 0;
-	} else
-		card->info.hwtrap = 0;
-
 	card->state = CARD_STATE_HARDSETUP;
 	qeth_print_status_message(card);
 
-- 
2.17.1
