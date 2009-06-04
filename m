Return-Path: <linux-kernel-owner+w=401wt.eu-S1757626AbZFDQUX@vger.kernel.org>
Message-Id: <20090604161901.589303552@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:18:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/38] pm: io subchannel driver power management callbacks
Content-Disposition: inline; filename=pm_io_sch.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/cio/device.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-2.6/drivers/s390/cio/device.c
===================================================================
--- linux-2.6.orig/drivers/s390/cio/device.c
+++ linux-2.6/drivers/s390/cio/device.c
@@ -138,6 +138,19 @@ static struct css_device_id io_subchanne
 };
 MODULE_DEVICE_TABLE(css, io_subchannel_ids);
 
+static int io_subchannel_prepare(struct subchannel *sch)
+{
+	struct ccw_device *cdev;
+	/*
+	 * Don't allow suspend while a ccw device registration
+	 * is still outstanding.
+	 */
+	cdev = sch_get_cdev(sch);
+	if (cdev && !device_is_registered(&cdev->dev))
+		return -EAGAIN;
+	return 0;
+}
+
 static struct css_driver io_subchannel_driver = {
 	.owner = THIS_MODULE,
 	.subchannel_type = io_subchannel_ids,
@@ -148,6 +161,7 @@ static struct css_driver io_subchannel_d
 	.probe = io_subchannel_probe,
 	.remove = io_subchannel_remove,
 	.shutdown = io_subchannel_shutdown,
+	.prepare = io_subchannel_prepare,
 };
 
 struct workqueue_struct *ccw_device_work;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
