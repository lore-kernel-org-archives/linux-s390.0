From: frank.blaschka@de.ibm.com
Subject: [patch 5/6] [PATCH] qeth: Consolidate tracing of card features
Date: Mon, 19 Nov 2012 13:46:49 +0100
Message-ID: <20121119124659.825371480@de.ibm.com>
References: <20121119124644.679089322@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=602-qeth-tracing.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

Trace all supported and enabled card features to s390dbf.

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Reviewed-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/qeth_core.h      |    1 +
 drivers/s390/net/qeth_core_main.c |   16 +++++++++++++---
 drivers/s390/net/qeth_l2_main.c   |    1 +
 drivers/s390/net/qeth_l3_main.c   |    1 +
 4 files changed, 16 insertions(+), 3 deletions(-)

--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -933,6 +933,7 @@ int qeth_hdr_chk_and_bounce(struct sk_bu
 int qeth_configure_cq(struct qeth_card *, enum qeth_cq);
 int qeth_hw_trap(struct qeth_card *, enum qeth_diags_trap_action);
 int qeth_query_ipassists(struct qeth_card *, enum qeth_prot_versions prot);
+void qeth_trace_features(struct qeth_card *);
 
 /* exports for OSN */
 int qeth_osn_assist(struct net_device *, void *, int);
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2968,9 +2968,6 @@ static int qeth_query_ipassists_cb(struc
 	} else
 		QETH_DBF_MESSAGE(1, "%s IPA_CMD_QIPASSIST: Flawed LIC detected"
 					"\n", dev_name(&card->gdev->dev));
-	QETH_DBF_TEXT(SETUP, 2, "suppenbl");
-	QETH_DBF_TEXT_(SETUP, 2, "%08x", (__u32)cmd->hdr.ipa_supported);
-	QETH_DBF_TEXT_(SETUP, 2, "%08x", (__u32)cmd->hdr.ipa_enabled);
 	return 0;
 }
 
@@ -4730,6 +4727,19 @@ static void qeth_core_free_card(struct q
 	kfree(card);
 }
 
+void qeth_trace_features(struct qeth_card *card)
+{
+	QETH_CARD_TEXT(card, 2, "features");
+	QETH_CARD_TEXT_(card, 2, "%x", card->options.ipa4.supported_funcs);
+	QETH_CARD_TEXT_(card, 2, "%x", card->options.ipa4.enabled_funcs);
+	QETH_CARD_TEXT_(card, 2, "%x", card->options.ipa6.supported_funcs);
+	QETH_CARD_TEXT_(card, 2, "%x", card->options.ipa6.enabled_funcs);
+	QETH_CARD_TEXT_(card, 2, "%x", card->options.adp.supported_funcs);
+	QETH_CARD_TEXT_(card, 2, "%x", card->options.adp.enabled_funcs);
+	QETH_CARD_TEXT_(card, 2, "%x", card->info.diagass_support);
+}
+EXPORT_SYMBOL_GPL(qeth_trace_features);
+
 static struct ccw_device_id qeth_ids[] = {
 	{CCW_DEVICE_DEVTYPE(0x1731, 0x01, 0x1732, 0x01),
 					.driver_info = QETH_CARD_TYPE_OSD},
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -986,6 +986,7 @@ static int __qeth_l2_set_online(struct c
 		rc = -ENODEV;
 		goto out_remove;
 	}
+	qeth_trace_features(card);
 
 	if (!card->dev && qeth_l2_setup_netdev(card)) {
 		rc = -ENODEV;
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3347,6 +3347,7 @@ static int __qeth_l3_set_online(struct c
 		rc = -ENODEV;
 		goto out_remove;
 	}
+	qeth_trace_features(card);
 
 	if (!card->dev && qeth_l3_setup_netdev(card)) {
 		rc = -ENODEV;
