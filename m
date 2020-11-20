Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726739AbgKTJJv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Nov 2020 04:09:51 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/4] s390/qeth: Remove pnso workaround
Date: Fri, 20 Nov 2020 10:09:36 +0100
Message-Id: <20201120090939.101406-2-jwi@linux.ibm.com>
In-Reply-To: <20201120090939.101406-1-jwi@linux.ibm.com>
References: <20201120090939.101406-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>

From: Alexandra Winter <wintera@linux.ibm.com>

Remove workaround that supported early hardware implementations
of PNSO OC3. Rely on the 'enarf' feature bit instead.

Fixes: fa115adff2c1 ("s390/qeth: Detect PNSO OC3 capability")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
[jwi: use logical instead of bit-wise AND]
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 28f6dda95736..79939ba5d523 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -985,32 +985,19 @@ static void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
  *	change notification' and thus can support the learning_sync bridgeport
  *	attribute
  *	@card: qeth_card structure pointer
- *
- *	This is a destructive test and must be called before dev2br or
- *	bridgeport address notification is enabled!
  */
 static void qeth_l2_detect_dev2br_support(struct qeth_card *card)
 {
 	struct qeth_priv *priv = netdev_priv(card->dev);
 	bool dev2br_supported;
-	int rc;
 
 	QETH_CARD_TEXT(card, 2, "d2brsup");
 	if (!IS_IQD(card))
 		return;
 
 	/* dev2br requires valid cssid,iid,chid */
-	if (!card->info.ids_valid) {
-		dev2br_supported = false;
-	} else if (css_general_characteristics.enarf) {
-		dev2br_supported = true;
-	} else {
-		/* Old machines don't have the feature bit:
-		 * Probe by testing whether a disable succeeds
-		 */
-		rc = qeth_l2_pnso(card, PNSO_OC_NET_ADDR_INFO, 0, NULL, NULL);
-		dev2br_supported = !rc;
-	}
+	dev2br_supported = card->info.ids_valid &&
+			   css_general_characteristics.enarf;
 	QETH_CARD_TEXT_(card, 2, "D2Bsup%02x", dev2br_supported);
 
 	if (dev2br_supported)
@@ -2233,7 +2220,6 @@ static int qeth_l2_set_online(struct qeth_card *card, bool carrier_ok)
 	struct net_device *dev = card->dev;
 	int rc = 0;
 
-	/* query before bridgeport_notification may be enabled */
 	qeth_l2_detect_dev2br_support(card);
 
 	mutex_lock(&card->sbp_lock);
-- 
2.17.1
