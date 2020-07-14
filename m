Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728713AbgGNOXY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 10:23:24 -0400
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 04/10] s390/qeth: don't clear the configured isolation mode
Date: Tue, 14 Jul 2020 16:22:59 +0200
Message-Id: <20200714142305.29297-5-jwi@linux.ibm.com>
In-Reply-To: <20200714142305.29297-1-jwi@linux.ibm.com>
References: <20200714142305.29297-1-jwi@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

When qeth_set_access_ctrl_online() is called during the device's
initialization and discovers that isolation mode isn't supported, don't
clear the user's currently configured mode.
They intentionally choose to operate the device in this specific mode,
and degrading the isolation is not an option.

Only adjust the configuration when called via sysfs (ie. fallback = 1),
and here follow the common pattern and restore it from prev_isolation.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 514795c5eaad..782a5128ac04 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4663,19 +4663,19 @@ int qeth_set_access_ctrl_online(struct qeth_card *card, int fallback)
 
 	QETH_CARD_TEXT(card, 4, "setactlo");
 
-	if (qeth_adp_supported(card, IPA_SETADP_SET_ACCESS_CONTROL)) {
-		rc = qeth_setadpparms_set_access_ctrl(card,
-			card->options.isolation, fallback);
-		if (rc) {
-			QETH_DBF_MESSAGE(3, "IPA(SET_ACCESS_CTRL(%d) on device %x: sent failed\n",
-					 rc, CARD_DEVID(card));
-			rc = -EOPNOTSUPP;
-		}
-	} else if (card->options.isolation != ISOLATION_MODE_NONE) {
-		card->options.isolation = ISOLATION_MODE_NONE;
-
+	if (!qeth_adp_supported(card, IPA_SETADP_SET_ACCESS_CONTROL)) {
 		dev_err(&card->gdev->dev, "Adapter does not "
 			"support QDIO data connection isolation\n");
+		if (fallback)
+			card->options.isolation = card->options.prev_isolation;
+		return -EOPNOTSUPP;
+	}
+
+	rc = qeth_setadpparms_set_access_ctrl(card, card->options.isolation,
+					      fallback);
+	if (rc) {
+		QETH_DBF_MESSAGE(3, "IPA(SET_ACCESS_CTRL(%d) on device %x: sent failed\n",
+				 rc, CARD_DEVID(card));
 		rc = -EOPNOTSUPP;
 	}
 	return rc;
-- 
2.17.1
