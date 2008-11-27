Return-Path: <linux-kernel-owner+w=401wt.eu-S1756845AbYK0KoU@vger.kernel.org>
Message-Id: <20081127103137.001911355@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:53 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 33/60] cio: move irritating comment.
Content-Disposition: inline; filename=132-cio-comment.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Due to former patches a comment and device id initialization were
split from the addressed function call in io_subchannel_probe.

Move it back to where it belongs.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device.c
+++ quilt-2.6/drivers/s390/cio/device.c
@@ -1179,12 +1179,6 @@ static int io_subchannel_probe(struct su
 		return 0;
 	}
 	io_subchannel_init_fields(sch);
-	/*
-	 * First check if a fitting device may be found amongst the
-	 * disconnected devices or in the orphanage.
-	 */
-	dev_id.devno = sch->schib.pmcw.dev;
-	dev_id.ssid = sch->schid.ssid;
 	rc = sysfs_create_group(&sch->dev.kobj,
 				&io_subchannel_attr_group);
 	if (rc)
@@ -1196,6 +1190,12 @@ static int io_subchannel_probe(struct su
 		rc = -ENOMEM;
 		goto out_err;
 	}
+	/*
+	 * First check if a fitting device may be found amongst the
+	 * disconnected devices or in the orphanage.
+	 */
+	dev_id.devno = sch->schib.pmcw.dev;
+	dev_id.ssid = sch->schid.ssid;
 	cdev = get_disc_ccwdev_by_dev_id(&dev_id, NULL);
 	if (!cdev)
 		cdev = get_orphaned_ccwdev_by_dev_id(to_css(sch->dev.parent),

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
