Return-Path: <linux-kernel-owner+w=401wt.eu-S1758442AbZFDQVv@vger.kernel.org>
Message-Id: <20090604161903.508924779@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/38] pm: qeth driver power management callbacks
Content-Disposition: inline; filename=pm_qeth.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <frank.blaschka@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/net/qeth_core_main.c |   51 ++++++++++++++++++++++++++++++++++++-
 drivers/s390/net/qeth_l2_main.c   |   52 +++++++++++++++++++++++++++++++++++++-
 drivers/s390/net/qeth_l3_main.c   |   52 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 152 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/s390/net/qeth_core_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_core_main.c
+++ linux-2.6/drivers/s390/net/qeth_core_main.c
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/net/qeth_core_main.c
  *
- *    Copyright IBM Corp. 2007
+ *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
  *		 Frank Pavlic <fpavlic@de.ibm.com>,
  *		 Thomas Spatzier <tspat@de.ibm.com>,
@@ -4192,6 +4192,50 @@ static void qeth_core_shutdown(struct cc
 		card->discipline.ccwgdriver->shutdown(gdev);
 }
 
+static int qeth_core_prepare(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	if (card->discipline.ccwgdriver &&
+	    card->discipline.ccwgdriver->prepare)
+		return card->discipline.ccwgdriver->prepare(gdev);
+	return 0;
+}
+
+static void qeth_core_complete(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	if (card->discipline.ccwgdriver &&
+	    card->discipline.ccwgdriver->complete)
+		card->discipline.ccwgdriver->complete(gdev);
+}
+
+static int qeth_core_freeze(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	if (card->discipline.ccwgdriver &&
+	    card->discipline.ccwgdriver->freeze)
+		return card->discipline.ccwgdriver->freeze(gdev);
+	return 0;
+}
+
+static int qeth_core_thaw(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	if (card->discipline.ccwgdriver &&
+	    card->discipline.ccwgdriver->thaw)
+		return card->discipline.ccwgdriver->thaw(gdev);
+	return 0;
+}
+
+static int qeth_core_restore(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	if (card->discipline.ccwgdriver &&
+	    card->discipline.ccwgdriver->restore)
+		return card->discipline.ccwgdriver->restore(gdev);
+	return 0;
+}
+
 static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
 	.owner = THIS_MODULE,
 	.name = "qeth",
@@ -4201,6 +4245,11 @@ static struct ccwgroup_driver qeth_core_
 	.set_online = qeth_core_set_online,
 	.set_offline = qeth_core_set_offline,
 	.shutdown = qeth_core_shutdown,
+	.prepare = qeth_core_prepare,
+	.complete = qeth_core_complete,
+	.freeze = qeth_core_freeze,
+	.thaw = qeth_core_thaw,
+	.restore = qeth_core_restore,
 };
 
 static ssize_t
Index: linux-2.6/drivers/s390/net/qeth_l3_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_l3_main.c
+++ linux-2.6/drivers/s390/net/qeth_l3_main.c
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/net/qeth_l3_main.c
  *
- *    Copyright IBM Corp. 2007
+ *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
  *		 Frank Pavlic <fpavlic@de.ibm.com>,
  *		 Thomas Spatzier <tspat@de.ibm.com>,
@@ -3274,12 +3274,62 @@ static void qeth_l3_shutdown(struct ccwg
 	qeth_clear_qdio_buffers(card);
 }
 
+static int qeth_l3_pm_suspend(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+
+	if (card->dev)
+		netif_device_detach(card->dev);
+	qeth_set_allowed_threads(card, 0, 1);
+	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
+	if (gdev->state == CCWGROUP_OFFLINE)
+		return 0;
+	if (card->state == CARD_STATE_UP) {
+		card->use_hard_stop = 1;
+		__qeth_l3_set_offline(card->gdev, 1);
+	} else
+		__qeth_l3_set_offline(card->gdev, 0);
+	return 0;
+}
+
+static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	int rc = 0;
+
+	if (gdev->state == CCWGROUP_OFFLINE)
+		goto out;
+
+	if (card->state == CARD_STATE_RECOVER) {
+		rc = __qeth_l3_set_online(card->gdev, 1);
+		if (rc) {
+			if (card->dev) {
+				rtnl_lock();
+				dev_close(card->dev);
+				rtnl_unlock();
+			}
+		}
+	} else
+		rc = __qeth_l3_set_online(card->gdev, 0);
+out:
+	qeth_set_allowed_threads(card, 0xffffffff, 0);
+	if (card->dev)
+		netif_device_attach(card->dev);
+	if (rc)
+		dev_warn(&card->gdev->dev, "The qeth device driver "
+			"failed to recover an error on the device\n");
+	return rc;
+}
+
 struct ccwgroup_driver qeth_l3_ccwgroup_driver = {
 	.probe = qeth_l3_probe_device,
 	.remove = qeth_l3_remove_device,
 	.set_online = qeth_l3_set_online,
 	.set_offline = qeth_l3_set_offline,
 	.shutdown = qeth_l3_shutdown,
+	.freeze = qeth_l3_pm_suspend,
+	.thaw = qeth_l3_pm_resume,
+	.restore = qeth_l3_pm_resume,
 };
 EXPORT_SYMBOL_GPL(qeth_l3_ccwgroup_driver);
 
Index: linux-2.6/drivers/s390/net/qeth_l2_main.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/qeth_l2_main.c
+++ linux-2.6/drivers/s390/net/qeth_l2_main.c
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/net/qeth_l2_main.c
  *
- *    Copyright IBM Corp. 2007
+ *    Copyright IBM Corp. 2007, 2009
  *    Author(s): Utz Bacher <utz.bacher@de.ibm.com>,
  *		 Frank Pavlic <fpavlic@de.ibm.com>,
  *		 Thomas Spatzier <tspat@de.ibm.com>,
@@ -1113,12 +1113,62 @@ static void qeth_l2_shutdown(struct ccwg
 	qeth_clear_qdio_buffers(card);
 }
 
+static int qeth_l2_pm_suspend(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+
+	if (card->dev)
+		netif_device_detach(card->dev);
+	qeth_set_allowed_threads(card, 0, 1);
+	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
+	if (gdev->state == CCWGROUP_OFFLINE)
+		return 0;
+	if (card->state == CARD_STATE_UP) {
+		card->use_hard_stop = 1;
+		__qeth_l2_set_offline(card->gdev, 1);
+	} else
+		__qeth_l2_set_offline(card->gdev, 0);
+	return 0;
+}
+
+static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
+{
+	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
+	int rc = 0;
+
+	if (gdev->state == CCWGROUP_OFFLINE)
+		goto out;
+
+	if (card->state == CARD_STATE_RECOVER) {
+		rc = __qeth_l2_set_online(card->gdev, 1);
+		if (rc) {
+			if (card->dev) {
+				rtnl_lock();
+				dev_close(card->dev);
+				rtnl_unlock();
+			}
+		}
+	} else
+		rc = __qeth_l2_set_online(card->gdev, 0);
+out:
+	qeth_set_allowed_threads(card, 0xffffffff, 0);
+	if (card->dev)
+		netif_device_attach(card->dev);
+	if (rc)
+		dev_warn(&card->gdev->dev, "The qeth device driver "
+			"failed to recover an error on the device\n");
+	return rc;
+}
+
 struct ccwgroup_driver qeth_l2_ccwgroup_driver = {
 	.probe = qeth_l2_probe_device,
 	.remove = qeth_l2_remove_device,
 	.set_online = qeth_l2_set_online,
 	.set_offline = qeth_l2_set_offline,
 	.shutdown = qeth_l2_shutdown,
+	.freeze = qeth_l2_pm_suspend,
+	.thaw = qeth_l2_pm_resume,
+	.restore = qeth_l2_pm_resume,
 };
 EXPORT_SYMBOL_GPL(qeth_l2_ccwgroup_driver);
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
