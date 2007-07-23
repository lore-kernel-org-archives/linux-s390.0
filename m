Return-Path: <linux-kernel-owner+w=401wt.eu-S1765818AbXGWIze@vger.kernel.org>
Message-Id: <20070723085652.753447559@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 4/9] cio: Remove remains of _ccw_device_get_device_number().
Content-Disposition: inline; filename=004-cio-devno.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/device_ops.c |    7 -------
 1 file changed, 7 deletions(-)

Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -635,12 +635,6 @@ _ccw_device_get_subchannel_number(struct
 	return cdev->private->schid.sch_no;
 }
 
-int
-_ccw_device_get_device_number(struct ccw_device *cdev)
-{
-	return cdev->private->dev_id.devno;
-}
-
 
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_options_mask);
@@ -658,6 +652,5 @@ EXPORT_SYMBOL(ccw_device_get_path_mask);
 EXPORT_SYMBOL(read_conf_data);
 EXPORT_SYMBOL(read_dev_chars);
 EXPORT_SYMBOL(_ccw_device_get_subchannel_number);
-EXPORT_SYMBOL(_ccw_device_get_device_number);
 EXPORT_SYMBOL_GPL(ccw_device_get_chp_desc);
 EXPORT_SYMBOL_GPL(read_conf_data_lpm);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
