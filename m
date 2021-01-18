Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406684AbhARQ4H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 11:56:07 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/1] s390/dasd: Fix inconsistent kobject removal
Date: Mon, 18 Jan 2021 17:55:18 +0100
Message-Id: <20210118165518.14578-2-sth@linux.ibm.com>
In-Reply-To: <20210118165518.14578-1-sth@linux.ibm.com>
References: <20210118165518.14578-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Jan Höppner <hoeppner@linux.ibm.com>

Our intention was to only remove path kobjects whenever a device is
being set offline. However, one corner case was missing.

If a device is disabled and enabled (using the IOCTLs BIODASDDISABLE and
BIODASDENABLE respectively), the enabling process will call
dasd_eckd_reload_device() which itself calls dasd_eckd_read_conf() in
order to update path information. During that update,
dasd_eckd_clear_conf_data() clears all old data and also removes all
kobjects. This will leave us with an inconsistent state of path kobjects
and a subsequent path verification leads to a failing kobject creation.

Fix this by removing kobjects only in the context of offlining a device
as initially intended.

Fixes: 19508b204740 ("s390/dasd: Display FC Endpoint Security information via sysfs")
Reported-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 20 ++++++++++++++------
 drivers/s390/block/dasd_eckd.c   |  3 ++-
 drivers/s390/block/dasd_int.h    |  2 +-
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index 16bb135c20aa..03d27ee9cac6 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -1874,18 +1874,26 @@ void dasd_path_create_kobjects(struct dasd_device *device)
 }
 EXPORT_SYMBOL(dasd_path_create_kobjects);
 
-/*
- * As we keep kobjects for the lifetime of a device, this function must not be
- * called anywhere but in the context of offlining a device.
- */
-void dasd_path_remove_kobj(struct dasd_device *device, int chp)
+static void dasd_path_remove_kobj(struct dasd_device *device, int chp)
 {
 	if (device->path[chp].in_sysfs) {
 		kobject_put(&device->path[chp].kobj);
 		device->path[chp].in_sysfs = false;
 	}
 }
-EXPORT_SYMBOL(dasd_path_remove_kobj);
+
+/*
+ * As we keep kobjects for the lifetime of a device, this function must not be
+ * called anywhere but in the context of offlining a device.
+ */
+void dasd_path_remove_kobjects(struct dasd_device *device)
+{
+	int i;
+
+	for (i = 0; i < 8; i++)
+		dasd_path_remove_kobj(device, i);
+}
+EXPORT_SYMBOL(dasd_path_remove_kobjects);
 
 int dasd_add_sysfs_files(struct ccw_device *cdev)
 {
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 3caa1ee5f4b0..65eb87cbbb9b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1036,7 +1036,6 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 		device->path[i].ssid = 0;
 		device->path[i].chpid = 0;
 		dasd_path_notoper(device, i);
-		dasd_path_remove_kobj(device, i);
 	}
 }
 
@@ -2173,6 +2172,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	device->block = NULL;
 out_err1:
 	dasd_eckd_clear_conf_data(device);
+	dasd_path_remove_kobjects(device);
 	kfree(device->private);
 	device->private = NULL;
 	return rc;
@@ -2191,6 +2191,7 @@ static void dasd_eckd_uncheck_device(struct dasd_device *device)
 	private->vdsneq = NULL;
 	private->gneq = NULL;
 	dasd_eckd_clear_conf_data(device);
+	dasd_path_remove_kobjects(device);
 }
 
 static struct dasd_ccw_req *
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 3bc008f9136c..b8a04c42d1d2 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -858,7 +858,7 @@ int dasd_add_sysfs_files(struct ccw_device *);
 void dasd_remove_sysfs_files(struct ccw_device *);
 void dasd_path_create_kobj(struct dasd_device *, int);
 void dasd_path_create_kobjects(struct dasd_device *);
-void dasd_path_remove_kobj(struct dasd_device *, int);
+void dasd_path_remove_kobjects(struct dasd_device *);
 
 struct dasd_device *dasd_device_from_cdev(struct ccw_device *);
 struct dasd_device *dasd_device_from_cdev_locked(struct ccw_device *);
-- 
2.17.1
