Return-Path: <linux-kernel-owner+w=401wt.eu-S1760437AbXEJN51@vger.kernel.org>
Message-Id: <20070510135643.069622319@de.ibm.com>
References: <20070510135152.178104939@de.ibm.com>
Date: Thu, 10 May 2007 15:51:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/15] cio: Get rid of _ccw_device_get_device_number().
Content-Disposition: inline; filename=002-cio-devid.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

The function shouldn't have existed in the first place (not MSS-aware).
Introduce a new function ccw_device_get_id() that extracts the
ccw_dev_id structure of a ccw device and convert all users of
_ccw_device_get_device_number to ccw_device_get_id.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_diag.c  |   10 ++++++----
 drivers/s390/block/dasd_ioctl.c |    4 +++-
 drivers/s390/char/raw3270.c     |    5 +++--
 drivers/s390/cio/device_ops.c   |   11 +++++++++++
 include/asm-s390/ccwdev.h       |    3 ++-
 5 files changed, 25 insertions(+), 8 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c
+++ quilt-2.6/drivers/s390/block/dasd_diag.c
@@ -50,6 +50,7 @@ struct dasd_diag_private {
 	struct dasd_diag_rw_io iob;
 	struct dasd_diag_init_io iib;
 	blocknum_t pt_block;
+	struct ccw_dev_id dev_id;
 };
 
 struct dasd_diag_req {
@@ -102,7 +103,7 @@ mdsk_init_io(struct dasd_device *device,
 	iib = &private->iib;
 	memset(iib, 0, sizeof (struct dasd_diag_init_io));
 
-	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
+	iib->dev_nr = private->dev_id.devno;
 	iib->block_size = blocksize;
 	iib->offset = offset;
 	iib->flaga = DASD_DIAG_FLAGA_DEFAULT;
@@ -127,7 +128,7 @@ mdsk_term_io(struct dasd_device * device
 	private = (struct dasd_diag_private *) device->private;
 	iib = &private->iib;
 	memset(iib, 0, sizeof (struct dasd_diag_init_io));
-	iib->dev_nr = _ccw_device_get_device_number(device->cdev);
+	iib->dev_nr = private->dev_id.devno;
 	rc = dia250(iib, TERM_BIO);
 	return rc;
 }
@@ -166,7 +167,7 @@ dasd_start_diag(struct dasd_ccw_req * cq
 	private = (struct dasd_diag_private *) device->private;
 	dreq = (struct dasd_diag_req *) cqr->data;
 
-	private->iob.dev_nr = _ccw_device_get_device_number(device->cdev);
+	private->iob.dev_nr = private->dev_id.devno;
 	private->iob.key = 0;
 	private->iob.flags = DASD_DIAG_RWFLAG_ASYNC;
 	private->iob.block_count = dreq->block_count;
@@ -323,11 +324,12 @@ dasd_diag_check_device(struct dasd_devic
 				"memory allocation failed for private data");
 			return -ENOMEM;
 		}
+		ccw_device_get_id(device->cdev, &private->dev_id);
 		device->private = (void *) private;
 	}
 	/* Read Device Characteristics */
 	rdc_data = (void *) &(private->rdc_data);
-	rdc_data->dev_nr = _ccw_device_get_device_number(device->cdev);
+	rdc_data->dev_nr = private->dev_id.devno;
 	rdc_data->rdc_len = sizeof (struct dasd_diag_characteristics);
 
 	rc = diag210((struct diag210 *) rdc_data);
Index: quilt-2.6/drivers/s390/block/dasd_ioctl.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_ioctl.c
+++ quilt-2.6/drivers/s390/block/dasd_ioctl.c
@@ -255,6 +255,7 @@ dasd_ioctl_information(struct dasd_devic
 	unsigned long flags;
 	int rc;
 	struct ccw_device *cdev;
+	struct ccw_dev_id dev_id;
 
 	if (!device->discipline->fill_info)
 		return -EINVAL;
@@ -270,8 +271,9 @@ dasd_ioctl_information(struct dasd_devic
 	}
 
 	cdev = device->cdev;
+	ccw_device_get_id(cdev, &dev_id);
 
-	dasd_info->devno = _ccw_device_get_device_number(device->cdev);
+	dasd_info->devno = dev_id.devno;
 	dasd_info->schid = _ccw_device_get_subchannel_number(device->cdev);
 	dasd_info->cu_type = cdev->id.cu_type;
 	dasd_info->cu_model = cdev->id.cu_model;
Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -589,9 +589,10 @@ static int
 __raw3270_size_device_vm(struct raw3270 *rp)
 {
 	int rc, model;
+	struct ccw_dev_id dev_id;
 
-	raw3270_init_diag210.vrdcdvno = 
-		_ccw_device_get_device_number(rp->cdev);
+	ccw_device_get_id(rp->cdev, &dev_id);
+	raw3270_init_diag210.vrdcdvno = dev_id.devno;
 	raw3270_init_diag210.vrdclen = sizeof(struct diag210);
 	rc = diag210(&raw3270_init_diag210);
 	if (rc)
Index: quilt-2.6/drivers/s390/cio/device_ops.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_ops.c
+++ quilt-2.6/drivers/s390/cio/device_ops.c
@@ -616,6 +616,17 @@ ccw_device_get_chp_desc(struct ccw_devic
 	return chp_get_chp_desc(chpid);
 }
 
+/**
+ * ccw_device_get_id - obtain a ccw device id
+ * @cdev: device to obtain the id for
+ * @dev_id: where to fill in the values
+ */
+void ccw_device_get_id(struct ccw_device *cdev, struct ccw_dev_id *dev_id)
+{
+	*dev_id = cdev->private->dev_id;
+}
+EXPORT_SYMBOL(ccw_device_get_id);
+
 // FIXME: these have to go:
 
 int
Index: quilt-2.6/include/asm-s390/ccwdev.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ccwdev.h
+++ quilt-2.6/include/asm-s390/ccwdev.h
@@ -16,6 +16,7 @@
 /* structs from asm/cio.h */
 struct irb;
 struct ccw1;
+struct ccw_dev_id;
 
 /* simplified initializers for struct ccw_device:
  * CCW_DEVICE and CCW_DEVICE_DEVTYPE initialize one
@@ -175,6 +176,7 @@ extern int ccw_device_set_offline(struct
 
 extern struct ciw *ccw_device_get_ciw(struct ccw_device *, __u32 cmd);
 extern __u8 ccw_device_get_path_mask(struct ccw_device *);
+extern void ccw_device_get_id(struct ccw_device *, struct ccw_dev_id *);
 
 #define get_ccwdev_lock(x) (x)->ccwlock
 
@@ -184,7 +186,6 @@ extern __u8 ccw_device_get_path_mask(str
 extern struct ccw_device *ccw_device_probe_console(void);
 
 // FIXME: these have to go
-extern int _ccw_device_get_device_number(struct ccw_device *);
 extern int _ccw_device_get_subchannel_number(struct ccw_device *);
 
 extern void *ccw_device_get_chp_desc(struct ccw_device *, int);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
