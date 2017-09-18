Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Sep 2017 11:13:13 +0200
From: Jean Delvare <jdelvare@suse.de>
Subject: [PATCH v2] s390/char: Fix cdev_add usage
Message-ID: <20170918111313.1fc7126e@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Function cdev_add does set cdev->dev, so there is no point in setting
it prior to calling this function.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
Untested. Changes since v1 (2016-07-13):
 * Improved description
 * Added a few blank lines to make the code more readable

 drivers/s390/char/tape_class.c |    3 +--
 drivers/s390/char/vmlogrdr.c   |    4 ++--
 drivers/s390/char/vmur.c       |    4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

--- linux-4.14-rc1.orig/drivers/s390/char/tape_class.c	2017-09-18 10:53:53.361665102 +0200
+++ linux-4.14-rc1/drivers/s390/char/tape_class.c	2017-09-18 10:58:10.630332486 +0200
@@ -68,9 +68,8 @@ struct tape_class_device *register_tape_
 
 	tcd->char_device->owner = fops->owner;
 	tcd->char_device->ops   = fops;
-	tcd->char_device->dev   = dev;
 
-	rc = cdev_add(tcd->char_device, tcd->char_device->dev, 1);
+	rc = cdev_add(tcd->char_device, dev, 1);
 	if (rc)
 		goto fail_with_cdev;
 
--- linux-4.14-rc1.orig/drivers/s390/char/vmlogrdr.c	2017-09-18 10:53:53.361665102 +0200
+++ linux-4.14-rc1/drivers/s390/char/vmlogrdr.c	2017-09-18 11:01:02.044184499 +0200
@@ -812,8 +812,8 @@ static int vmlogrdr_register_cdev(dev_t
 	}
 	vmlogrdr_cdev->owner = THIS_MODULE;
 	vmlogrdr_cdev->ops = &vmlogrdr_fops;
-	vmlogrdr_cdev->dev = dev;
-	rc = cdev_add(vmlogrdr_cdev, vmlogrdr_cdev->dev, MAXMINOR);
+
+	rc = cdev_add(vmlogrdr_cdev, dev, MAXMINOR);
 	if (!rc)
 		return 0;
 
--- linux-4.14-rc1.orig/drivers/s390/char/vmur.c	2017-09-18 10:53:53.361665102 +0200
+++ linux-4.14-rc1/drivers/s390/char/vmur.c	2017-09-18 11:09:13.111606357 +0200
@@ -892,12 +892,12 @@ static int ur_set_online(struct ccw_devi
 	}
 
 	urd->char_device->ops = &ur_fops;
-	urd->char_device->dev = MKDEV(major, minor);
 	urd->char_device->owner = ur_fops.owner;
 
-	rc = cdev_add(urd->char_device, urd->char_device->dev, 1);
+	rc = cdev_add(urd->char_device, MKDEV(major, minor), 1);
 	if (rc)
 		goto fail_free_cdev;
+
 	if (urd->cdev->id.cu_type == READER_PUNCH_DEVTYPE) {
 		if (urd->class == DEV_CLASS_UR_I)
 			sprintf(node_id, "vmrdr-%s", dev_name(&cdev->dev));

-- 
Jean Delvare
SUSE L3 Support
