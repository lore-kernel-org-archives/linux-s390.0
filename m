From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 13 Jul 2016 12:33:57 +0000
Subject: [PATCH] s390/char: Fix cdev_add usage
Message-Id: <20160713143357.2a90ef57@endymion>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

As I read the code in function cdev_add, it does set ->dev, so there
is no point in setting it prior to calling the function.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
Untested.

 drivers/s390/char/tape_class.c |    3 +--
 drivers/s390/char/vmlogrdr.c   |    3 +--
 drivers/s390/char/vmur.c       |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

--- linux-4.7-rc7.orig/drivers/s390/char/tape_class.c	2016-07-04 08:01:00.000000000 +0200
+++ linux-4.7-rc7/drivers/s390/char/tape_class.c	2016-07-13 14:23:16.029670246 +0200
@@ -68,9 +68,8 @@ struct tape_class_device *register_tape_
 
 	tcd->char_device->owner = fops->owner;
 	tcd->char_device->ops   = fops;
-	tcd->char_device->dev   = dev;
 
-	rc = cdev_add(tcd->char_device, tcd->char_device->dev, 1);
+	rc = cdev_add(tcd->char_device, dev, 1);
 	if (rc)
 		goto fail_with_cdev;
 
--- linux-4.7-rc7.orig/drivers/s390/char/vmlogrdr.c	2016-07-04 08:01:00.000000000 +0200
+++ linux-4.7-rc7/drivers/s390/char/vmlogrdr.c	2016-07-13 14:24:03.231116611 +0200
@@ -815,8 +815,7 @@ static int vmlogrdr_register_cdev(dev_t
 	}
 	vmlogrdr_cdev->owner = THIS_MODULE;
 	vmlogrdr_cdev->ops = &vmlogrdr_fops;
-	vmlogrdr_cdev->dev = dev;
-	rc = cdev_add(vmlogrdr_cdev, vmlogrdr_cdev->dev, MAXMINOR);
+	rc = cdev_add(vmlogrdr_cdev, dev, MAXMINOR);
 	if (!rc)
 		return 0;
 
--- linux-4.7-rc7.orig/drivers/s390/char/vmur.c	2016-07-04 08:01:00.000000000 +0200
+++ linux-4.7-rc7/drivers/s390/char/vmur.c	2016-07-13 14:24:29.123359167 +0200
@@ -891,10 +891,9 @@ static int ur_set_online(struct ccw_devi
 	}
 
 	urd->char_device->ops = &ur_fops;
-	urd->char_device->dev = MKDEV(major, minor);
 	urd->char_device->owner = ur_fops.owner;
 
-	rc = cdev_add(urd->char_device, urd->char_device->dev, 1);
+	rc = cdev_add(urd->char_device, MKDEV(major, minor), 1);
 	if (rc)
 		goto fail_free_cdev;
 	if (urd->cdev->id.cu_type == READER_PUNCH_DEVTYPE) {


-- 
Jean Delvare
SUSE L3 Support
