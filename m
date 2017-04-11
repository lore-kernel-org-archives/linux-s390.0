From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 10/10] s390/qeth: remove unimplemented gdev routines
Date: Tue, 11 Apr 2017 16:11:19 +0200
Message-ID: <20170411141119.82526-11-jwi@linux.vnet.ibm.com>
References: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170411141119.82526-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

prepare() and complete() are not implemented by any discipline, so just
drop all the indirection.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Hans Wippel <hwippel@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 --
 drivers/s390/net/qeth_core_main.c | 19 ++-----------------
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index a634ec2a08f3..f6aa21176d89 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -710,8 +710,6 @@ struct qeth_discipline {
 	void (*remove) (struct ccwgroup_device *);
 	int (*set_online) (struct ccwgroup_device *);
 	int (*set_offline) (struct ccwgroup_device *);
-	int (*prepare) (struct ccwgroup_device *);
-	void (*complete) (struct ccwgroup_device *);
 	int (*freeze)(struct ccwgroup_device *);
 	int (*thaw) (struct ccwgroup_device *);
 	int (*restore)(struct ccwgroup_device *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 88f4c6cff9a4..38114a8d56e0 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5756,21 +5756,6 @@ static void qeth_core_shutdown(struct ccwgroup_device *gdev)
 	qdio_free(CARD_DDEV(card));
 }
 
-static int qeth_core_prepare(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	if (card->discipline && card->discipline->prepare)
-		return card->discipline->prepare(gdev);
-	return 0;
-}
-
-static void qeth_core_complete(struct ccwgroup_device *gdev)
-{
-	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
-	if (card->discipline && card->discipline->complete)
-		card->discipline->complete(gdev);
-}
-
 static int qeth_core_freeze(struct ccwgroup_device *gdev)
 {
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
@@ -5805,8 +5790,8 @@ static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
 	.set_online = qeth_core_set_online,
 	.set_offline = qeth_core_set_offline,
 	.shutdown = qeth_core_shutdown,
-	.prepare = qeth_core_prepare,
-	.complete = qeth_core_complete,
+	.prepare = NULL,
+	.complete = NULL,
 	.freeze = qeth_core_freeze,
 	.thaw = qeth_core_thaw,
 	.restore = qeth_core_restore,
-- 
2.10.2
