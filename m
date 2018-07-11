From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 05/10] s390/qeth: consolidate ccwgroup driver definition
Date: Wed, 11 Jul 2018 17:42:42 +0200
Message-ID: <20180711154247.5523-6-jwi@linux.ibm.com>
References: <20180711154247.5523-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180711154247.5523-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Reshuffle the code a bit so that everything is in one place.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index e8b18a9e07d7..4ba40a64907a 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5848,31 +5848,13 @@ static int qeth_core_restore(struct ccwgroup_device *gdev)
 	return 0;
 }
 
-static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
-	.driver = {
-		.owner = THIS_MODULE,
-		.name = "qeth",
-	},
-	.ccw_driver = &qeth_ccw_driver,
-	.setup = qeth_core_probe_device,
-	.remove = qeth_core_remove_device,
-	.set_online = qeth_core_set_online,
-	.set_offline = qeth_core_set_offline,
-	.shutdown = qeth_core_shutdown,
-	.prepare = NULL,
-	.complete = NULL,
-	.freeze = qeth_core_freeze,
-	.thaw = qeth_core_thaw,
-	.restore = qeth_core_restore,
-};
-
 static ssize_t group_store(struct device_driver *ddrv, const char *buf,
 			   size_t count)
 {
 	int err;
 
-	err = ccwgroup_create_dev(qeth_core_root_dev,
-				  &qeth_core_ccwgroup_driver, 3, buf);
+	err = ccwgroup_create_dev(qeth_core_root_dev, to_ccwgroupdrv(ddrv), 3,
+				  buf);
 
 	return err ? err : count;
 }
@@ -5890,6 +5872,25 @@ static const struct attribute_group *qeth_drv_attr_groups[] = {
 	NULL,
 };
 
+static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
+	.driver = {
+		.groups = qeth_drv_attr_groups,
+		.owner = THIS_MODULE,
+		.name = "qeth",
+	},
+	.ccw_driver = &qeth_ccw_driver,
+	.setup = qeth_core_probe_device,
+	.remove = qeth_core_remove_device,
+	.set_online = qeth_core_set_online,
+	.set_offline = qeth_core_set_offline,
+	.shutdown = qeth_core_shutdown,
+	.prepare = NULL,
+	.complete = NULL,
+	.freeze = qeth_core_freeze,
+	.thaw = qeth_core_thaw,
+	.restore = qeth_core_restore,
+};
+
 int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct qeth_card *card = dev->ml_priv;
@@ -6581,7 +6582,6 @@ static int __init qeth_core_init(void)
 	rc = ccw_driver_register(&qeth_ccw_driver);
 	if (rc)
 		goto ccw_err;
-	qeth_core_ccwgroup_driver.driver.groups = qeth_drv_attr_groups;
 	rc = ccwgroup_driver_register(&qeth_core_ccwgroup_driver);
 	if (rc)
 		goto ccwgroup_err;
-- 
2.16.4
