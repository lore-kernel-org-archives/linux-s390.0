From: frank.blaschka@de.ibm.com
Subject: [patch 1/6] [PATCH] qeth: Fix retry logic in hardsetup
Date: Mon, 21 Jan 2013 13:30:18 +0100
Message-ID: <20130121123037.207719724@de.ibm.com>
References: <20130121123017.240686588@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=600-qeth-retry-logic.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

The previous code did never retry any idx setup unless retries were done
for device offline/online at the beginning of the function.

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Reviewed-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4765,14 +4765,14 @@ static struct ccw_driver qeth_ccw_driver
 
 int qeth_core_hardsetup_card(struct qeth_card *card)
 {
-	int retries = 0;
+	int retries = 3;
 	int rc;
 
 	QETH_DBF_TEXT(SETUP, 2, "hrdsetup");
 	atomic_set(&card->force_alloc_skb, 0);
 	qeth_update_from_chp_desc(card);
 retry:
-	if (retries)
+	if (retries < 3)
 		QETH_DBF_MESSAGE(2, "%s Retrying to do IDX activates.\n",
 			dev_name(&card->gdev->dev));
 	ccw_device_set_offline(CARD_DDEV(card));
@@ -4794,7 +4794,7 @@ retriable:
 		return rc;
 	} else if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
-		if (++retries > 3)
+		if (--retries < 0)
 			goto out;
 		else
 			goto retry;
