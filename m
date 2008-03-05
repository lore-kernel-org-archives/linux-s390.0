Return-Path: <linux-kernel-owner+w=401wt.eu-S932658AbYCEL71@vger.kernel.org>
Message-Id: <20080305115714.023087298@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:37 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/10] dasd: fix reference counting in display method for proc/dasd/devices
Content-Disposition: inline; filename=005-dasd-refcount.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Stefan Weinhuber <wein@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Weinhuber <wein@de.ibm.com>

Using the /proc/dasd/devices interface leaves the reference counter
of alias devices in an inconsistent state. A process that tries to set
such a device offline afterwards will hang.
The dasd_devices_show function returns immediately for alias devices
and this code path was missing a dasd_put_device call.

Signed-off-by: Stefan Weinhuber <wein@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_proc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/block/dasd_proc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_proc.c
+++ quilt-2.6/drivers/s390/block/dasd_proc.c
@@ -62,8 +62,10 @@ dasd_devices_show(struct seq_file *m, vo
 		return 0;
 	if (device->block)
 		block = device->block;
-	else
+	else {
+		dasd_put_device(device);
 		return 0;
+	}
 	/* Print device number. */
 	seq_printf(m, "%s", device->cdev->dev.bus_id);
 	/* Print discipline string. */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
