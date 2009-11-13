Return-Path: <linux-kernel-owner+w=401wt.eu-S1756468AbZKMPP5@vger.kernel.org>
Message-Id: <20091113150913.390066682@de.ibm.com>
Date: Fri, 13 Nov 2009 16:08:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 23/52] [PATCH] dasd: remove strings from s390dbf
References: <20091113150824.351347652@de.ibm.com>
Content-Disposition: inline; filename=122-dasd-s390dbf-strings.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

Remove strings from s390 debugfeature entries that could lead to a
crash when the data is read from dbf because the strings do not exist
any more.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c      |   22 ++++++++++----------
 drivers/s390/block/dasd_eckd.c |   44 +++++++++++++++++------------------------
 drivers/s390/block/dasd_fba.c  |   10 +++------
 drivers/s390/block/dasd_int.h  |   10 +++++++++
 4 files changed, 44 insertions(+), 42 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd.c	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd.c	2009-11-13 16:08:17.000000000 +0100
@@ -994,10 +994,9 @@
 		return;
 	cqr = (struct dasd_ccw_req *) intparm;
 	if (cqr->status != DASD_CQR_IN_IO) {
-		DBF_EVENT(DBF_DEBUG,
-			"invalid status in handle_killed_request: "
-			"bus_id %s, status %02x",
-			dev_name(&cdev->dev), cqr->status);
+		DBF_EVENT_DEVID(DBF_DEBUG, cdev,
+				"invalid status in handle_killed_request: "
+				"%02x", cqr->status);
 		return;
 	}
 
@@ -1045,12 +1044,13 @@
 		case -EIO:
 			break;
 		case -ETIMEDOUT:
-			DBF_EVENT(DBF_WARNING, "%s(%s): request timed out\n",
-			       __func__, dev_name(&cdev->dev));
+			DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s: "
+					"request timed out\n", __func__);
 			break;
 		default:
-			DBF_EVENT(DBF_WARNING, "%s(%s): unknown error %ld\n",
-			       __func__, dev_name(&cdev->dev), PTR_ERR(irb));
+			DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s: "
+					"unknown error %ld\n", __func__,
+					PTR_ERR(irb));
 		}
 		dasd_handle_killed_request(cdev, intparm);
 		return;
@@ -2310,9 +2310,9 @@
 	}
 	ret = dasd_add_sysfs_files(cdev);
 	if (ret) {
-		DBF_EVENT(DBF_WARNING,
-		       "dasd_generic_probe: could not add sysfs entries "
-		       "for %s\n", dev_name(&cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s",
+				"dasd_generic_probe: could not add "
+				"sysfs entries");
 		return ret;
 	}
 	cdev->handler = &dasd_int_handler;
Index: quilt-2.6/drivers/s390/block/dasd_eckd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_eckd.c	2009-11-13 16:08:17.000000000 +0100
@@ -92,9 +92,9 @@
 	/* set ECKD specific ccw-device options */
 	ret = ccw_device_set_options(cdev, CCWDEV_ALLOW_FORCE);
 	if (ret) {
-		DBF_EVENT(DBF_WARNING,
-		       "dasd_eckd_probe: could not set ccw-device options "
-		       "for %s\n", dev_name(&cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s",
+				"dasd_eckd_probe: could not set "
+				"ccw-device options");
 		return ret;
 	}
 	ret = dasd_generic_probe(cdev, &dasd_eckd_discipline);
@@ -888,16 +888,15 @@
 			rc = dasd_eckd_read_conf_lpm(device, &conf_data,
 						     &conf_len, lpm);
 			if (rc && rc != -EOPNOTSUPP) {	/* -EOPNOTSUPP is ok */
-				DBF_EVENT(DBF_WARNING,
+				DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
 					  "Read configuration data returned "
-					  "error %d for device: %s", rc,
-					  dev_name(&device->cdev->dev));
+					  "error %d", rc);
 				return rc;
 			}
 			if (conf_data == NULL) {
-				DBF_EVENT(DBF_WARNING, "No configuration "
-					  "data retrieved for device: %s",
-					  dev_name(&device->cdev->dev));
+				DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+						"No configuration data "
+						"retrieved");
 				continue;	/* no error */
 			}
 			/* save first valid configuration data */
@@ -944,9 +943,8 @@
 				    sizeof(struct dasd_rssd_features)),
 				   device);
 	if (IS_ERR(cqr)) {
-		DBF_EVENT(DBF_WARNING, "Could not allocate initialization "
-			  "request for device: %s",
-			  dev_name(&device->cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s", "Could not "
+				"allocate initialization request");
 		return PTR_ERR(cqr);
 	}
 	cqr->startdev = device;
@@ -1075,10 +1073,8 @@
 	/* may be requested feature is not available on server,
 	 * therefore just report error and go ahead */
 	private = (struct dasd_eckd_private *) device->private;
-	DBF_EVENT(DBF_WARNING, "PSF-SSC on storage subsystem %s.%s.%04x "
-		  "returned rc=%d for device: %s",
-		  private->uid.vendor, private->uid.serial,
-		  private->uid.ssid, rc, dev_name(&device->cdev->dev));
+	DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "PSF-SSC for SSID %04x "
+			"returned rc=%d", private->uid.ssid, rc);
 	/* RE-Read Configuration Data */
 	return dasd_eckd_read_conf(device);
 }
@@ -1127,9 +1123,9 @@
 	if (private->uid.type == UA_BASE_DEVICE) {
 		block = dasd_alloc_block();
 		if (IS_ERR(block)) {
-			DBF_EVENT(DBF_WARNING, "could not allocate dasd "
-				  "block structure for device: %s",
-				  dev_name(&device->cdev->dev));
+			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+					"could not allocate dasd "
+					"block structure");
 			rc = PTR_ERR(block);
 			goto out_err1;
 		}
@@ -1157,9 +1153,8 @@
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
 					 &private->rdc_data, 64);
 	if (rc) {
-		DBF_EVENT(DBF_WARNING,
-			  "Read device characteristics failed, rc=%d for "
-			  "device: %s", rc, dev_name(&device->cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Read device characteristic failed, rc=%d", rc);
 		goto out_err3;
 	}
 	/* find the vaild cylinder size */
@@ -3290,9 +3285,8 @@
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
 					 &temp_rdc_data, 64);
 	if (rc) {
-		DBF_EVENT(DBF_WARNING,
-			  "Read device characteristics failed, rc=%d for "
-			  "device: %s", rc, dev_name(&device->cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Read device characteristic failed, rc=%d", rc);
 		goto out_err;
 	}
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
Index: quilt-2.6/drivers/s390/block/dasd_fba.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_fba.c	2009-11-13 16:08:14.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_fba.c	2009-11-13 16:08:17.000000000 +0100
@@ -140,9 +140,8 @@
 	}
 	block = dasd_alloc_block();
 	if (IS_ERR(block)) {
-		DBF_EVENT(DBF_WARNING, "could not allocate dasd block "
-			  "structure for device: %s",
-			  dev_name(&device->cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, cdev, "%s", "could not allocate "
+				"dasd block structure");
 		device->private = NULL;
 		kfree(private);
 		return PTR_ERR(block);
@@ -154,9 +153,8 @@
 	rc = dasd_generic_read_dev_chars(device, DASD_FBA_MAGIC,
 					 &private->rdc_data, 32);
 	if (rc) {
-		DBF_EVENT(DBF_WARNING, "Read device characteristics returned "
-			  "error %d for device: %s",
-			  rc, dev_name(&device->cdev->dev));
+		DBF_EVENT_DEVID(DBF_WARNING, cdev, "Read device "
+				"characteristics returned error %d", rc);
 		device->block = NULL;
 		dasd_free_block(block);
 		device->private = NULL;
Index: quilt-2.6/drivers/s390/block/dasd_int.h
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_int.h	2009-11-13 16:08:16.000000000 +0100
+++ quilt-2.6/drivers/s390/block/dasd_int.h	2009-11-13 16:08:17.000000000 +0100
@@ -108,6 +108,16 @@
 			    d_data); \
 } while(0)
 
+#define DBF_EVENT_DEVID(d_level, d_cdev, d_str, d_data...)	\
+do { \
+	struct ccw_dev_id __dev_id;			\
+	ccw_device_get_id(d_cdev, &__dev_id);		\
+	debug_sprintf_event(dasd_debug_area,		\
+			    d_level,					\
+			    "0.%x.%04x " d_str "\n",			\
+			    __dev_id.ssid, __dev_id.devno, d_data);	\
+} while (0)
+
 #define DBF_EXC(d_level, d_str, d_data...)\
 do { \
 	debug_sprintf_exception(dasd_debug_area, \
