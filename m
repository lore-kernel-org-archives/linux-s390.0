Return-Path: <linux-kernel-owner+w=401wt.eu-S1755353AbZDWLuY@vger.kernel.org>
Message-Id: <20090423114725.916538072@de.ibm.com>
References: <20090423114638.865214111@de.ibm.com>
Date: Thu, 23 Apr 2009 13:46:42 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/6] Use tape_generic_offline directly.
Content-Disposition: inline; filename=004-tape-generic-offline.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Munzert <munzert@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Frank Munzert <munzert@de.ibm.com>

tape_3590_offline and tape_34xx_offline are removed and tape_generic_offline
is called directly instead.

Signed-off-by: Frank Munzert <munzert@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tape.h      |    2 +-
 drivers/s390/char/tape_34xx.c |    8 +-------
 drivers/s390/char/tape_3590.c |    8 +-------
 drivers/s390/char/tape_core.c |    5 ++++-
 4 files changed, 7 insertions(+), 16 deletions(-)

Index: quilt-2.6/drivers/s390/char/tape_34xx.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_34xx.c
+++ quilt-2.6/drivers/s390/char/tape_34xx.c
@@ -1294,12 +1294,6 @@ tape_34xx_online(struct ccw_device *cdev
 	);
 }
 
-static int
-tape_34xx_offline(struct ccw_device *cdev)
-{
-	return tape_generic_offline(cdev->dev.driver_data);
-}
-
 static struct ccw_driver tape_34xx_driver = {
 	.name = "tape_34xx",
 	.owner = THIS_MODULE,
@@ -1307,7 +1301,7 @@ static struct ccw_driver tape_34xx_drive
 	.probe = tape_generic_probe,
 	.remove = tape_generic_remove,
 	.set_online = tape_34xx_online,
-	.set_offline = tape_34xx_offline,
+	.set_offline = tape_generic_offline,
 };
 
 static int
Index: quilt-2.6/drivers/s390/char/tape_3590.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_3590.c
+++ quilt-2.6/drivers/s390/char/tape_3590.c
@@ -1707,19 +1707,13 @@ tape_3590_online(struct ccw_device *cdev
 				   &tape_discipline_3590);
 }
 
-static int
-tape_3590_offline(struct ccw_device *cdev)
-{
-	return tape_generic_offline(cdev->dev.driver_data);
-}
-
 static struct ccw_driver tape_3590_driver = {
 	.name = "tape_3590",
 	.owner = THIS_MODULE,
 	.ids = tape_3590_ids,
 	.probe = tape_generic_probe,
 	.remove = tape_generic_remove,
-	.set_offline = tape_3590_offline,
+	.set_offline = tape_generic_offline,
 	.set_online = tape_3590_online,
 };
 
Index: quilt-2.6/drivers/s390/char/tape_core.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape_core.c
+++ quilt-2.6/drivers/s390/char/tape_core.c
@@ -387,8 +387,11 @@ tape_cleanup_device(struct tape_device *
  * Manual offline is only allowed while the drive is not in use.
  */
 int
-tape_generic_offline(struct tape_device *device)
+tape_generic_offline(struct ccw_device *cdev)
 {
+	struct tape_device *device;
+
+	device = cdev->dev.driver_data;
 	if (!device) {
 		return -ENODEV;
 	}
Index: quilt-2.6/drivers/s390/char/tape.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tape.h
+++ quilt-2.6/drivers/s390/char/tape.h
@@ -285,7 +285,7 @@ extern int tape_mtop(struct tape_device 
 extern void tape_state_set(struct tape_device *, enum tape_state);
 
 extern int tape_generic_online(struct tape_device *, struct tape_discipline *);
-extern int tape_generic_offline(struct tape_device *device);
+extern int tape_generic_offline(struct ccw_device *);
 
 /* Externals from tape_devmap.c */
 extern int tape_generic_probe(struct ccw_device *);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
