Return-Path: <linux-kernel-owner+w=401wt.eu-S932081AbZFDQ1k@vger.kernel.org>
Message-Id: <20090604161903.277373455@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 16/38] pm: lcs driver power management callbacks
Content-Disposition: inline; filename=pm_lcs.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Klaus-Dieter Wacker <kdwacker@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Klaus-Dieter Wacket <kdwacker@de.ibm.com>

Signed-off-by: Klaus-Dieter Wacker <kdwacker@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/net/lcs.c |   74 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/s390/net/lcs.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/lcs.c
+++ linux-2.6/drivers/s390/net/lcs.c
@@ -1,15 +1,12 @@
 /*
- *  linux/drivers/s390/net/lcs.c
- *
  *  Linux for S/390 Lan Channel Station Network Driver
  *
- *  Copyright (C)  1999-2001 IBM Deutschland Entwicklung GmbH,
- *			     IBM Corporation
- *    Author(s): Original Code written by
- *			  DJ Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
- *		 Rewritten by
- *			  Frank Pavlic (fpavlic@de.ibm.com) and
- *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *  Copyright IBM Corp. 1999, 2009
+ *  Author(s): Original Code written by
+ *			DJ Barrow <djbarrow@de.ibm.com,barrow_dj@yahoo.com>
+ *	       Rewritten by
+ *			Frank Pavlic <fpavlic@de.ibm.com> and
+ *		 	Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -2313,6 +2310,60 @@ lcs_remove_device(struct ccwgroup_device
 	put_device(&ccwgdev->dev);
 }
 
+static int lcs_pm_suspend(struct lcs_card *card)
+{
+	if (card->dev)
+		netif_device_detach(card->dev);
+	lcs_set_allowed_threads(card, 0);
+	lcs_wait_for_threads(card, 0xffffffff);
+	if (card->state != DEV_STATE_DOWN)
+		__lcs_shutdown_device(card->gdev, 1);
+	return 0;
+}
+
+static int lcs_pm_resume(struct lcs_card *card)
+{
+	int rc = 0;
+
+	if (card->state == DEV_STATE_RECOVER)
+		rc = lcs_new_device(card->gdev);
+	if (card->dev)
+		netif_device_attach(card->dev);
+	if (rc) {
+		dev_warn(&card->gdev->dev, "The lcs device driver "
+			"failed to recover the device\n");
+	}
+	return rc;
+}
+
+static int lcs_prepare(struct ccwgroup_device *gdev)
+{
+	return 0;
+}
+
+static void lcs_complete(struct ccwgroup_device *gdev)
+{
+	return;
+}
+
+static int lcs_freeze(struct ccwgroup_device *gdev)
+{
+	struct lcs_card *card = dev_get_drvdata(&gdev->dev);
+	return lcs_pm_suspend(card);
+}
+
+static int lcs_thaw(struct ccwgroup_device *gdev)
+{
+	struct lcs_card *card = dev_get_drvdata(&gdev->dev);
+	return lcs_pm_resume(card);
+}
+
+static int lcs_restore(struct ccwgroup_device *gdev)
+{
+	struct lcs_card *card = dev_get_drvdata(&gdev->dev);
+	return lcs_pm_resume(card);
+}
+
 /**
  * LCS ccwgroup driver registration
  */
@@ -2325,6 +2376,11 @@ static struct ccwgroup_driver lcs_group_
 	.remove      = lcs_remove_device,
 	.set_online  = lcs_new_device,
 	.set_offline = lcs_shutdown_device,
+	.prepare     = lcs_prepare,
+	.complete    = lcs_complete,
+	.freeze	     = lcs_freeze,
+	.thaw	     = lcs_thaw,
+	.restore     = lcs_restore,
 };
 
 /**

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
