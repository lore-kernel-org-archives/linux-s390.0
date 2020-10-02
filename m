Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgJBTjs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:39:48 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 10/10] s390/dasd: Process FCES path event notification
Date: Fri,  2 Oct 2020 21:39:40 +0200
Message-Id: <20201002193940.24012-11-sth@linux.ibm.com>
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Jan Höppner <hoeppner@linux.ibm.com>

If the Fibre Channel Endpoint-Security status of a path changes, a
corresponding path event is received from the CIO layer.

Process this event by re-reading the FCES information.

As the information is retrieved for all paths on a single CU in one
call, the internal status can also be updated for all paths and no
processing per path is necessary.

Reference-ID: IO1812
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 19 +++++++++++----
 drivers/s390/block/dasd_eckd.c | 12 +++++++---
 drivers/s390/block/dasd_int.h  | 42 +++++++++++++++++++++++++++++++++-
 3 files changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 97c11d557052..7119a34fef5c 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2107,20 +2107,25 @@ static void __dasd_device_start_head(struct dasd_device *device)
 
 static void __dasd_device_check_path_events(struct dasd_device *device)
 {
+	__u8 tbvpm, fcsecpm;
 	int rc;
 
-	if (!dasd_path_get_tbvpm(device))
+	tbvpm = dasd_path_get_tbvpm(device);
+	fcsecpm = dasd_path_get_fcsecpm(device);
+
+	if (!tbvpm && !fcsecpm)
 		return;
 
 	if (device->stopped &
 	    ~(DASD_STOPPED_DC_WAIT | DASD_UNRESUMED_PM))
 		return;
-	rc = device->discipline->pe_handler(device,
-					    dasd_path_get_tbvpm(device));
-	if (rc)
+	rc = device->discipline->pe_handler(device, tbvpm, fcsecpm);
+	if (rc) {
 		dasd_device_set_timer(device, 50);
-	else
+	} else {
 		dasd_path_clear_all_verify(device);
+		dasd_path_clear_all_fcsec(device);
+	}
 };
 
 /*
@@ -3868,6 +3873,10 @@ void dasd_generic_path_event(struct ccw_device *cdev, int *path_event)
 			if (device->discipline->kick_validate)
 				device->discipline->kick_validate(device);
 		}
+		if (path_event[chp] & PE_PATH_FCES_EVENT) {
+			dasd_path_fcsec_update(device, chp);
+			dasd_schedule_device_bh(device);
+		}
 	}
 	hpfpm = dasd_path_get_hpfpm(device);
 	ifccpm = dasd_path_get_ifccpm(device);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 822a8ad4e338..40443f26a742 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -111,6 +111,7 @@ struct pe_handler_work_data {
 	__u8 rcd_buffer[DASD_ECKD_RCD_DATA_SIZE];
 	int isglobal;
 	__u8 tbvpm;
+	__u8 fcsecpm;
 };
 static struct pe_handler_work_data *pe_handler_worker;
 static DEFINE_MUTEX(dasd_pe_handler_mutex);
@@ -1461,7 +1462,10 @@ static void do_pe_handler_work(struct work_struct *work)
 		return;
 	}
 
-	dasd_eckd_path_available_action(device, data);
+	if (data->tbvpm)
+		dasd_eckd_path_available_action(device, data);
+	if (data->fcsecpm)
+		dasd_eckd_read_fc_security(device);
 
 	clear_bit(DASD_FLAG_PATH_VERIFY, &device->flags);
 	dasd_put_device(device);
@@ -1471,7 +1475,8 @@ static void do_pe_handler_work(struct work_struct *work)
 		kfree(data);
 }
 
-static int dasd_eckd_pe_handler(struct dasd_device *device, __u8 lpm)
+static int dasd_eckd_pe_handler(struct dasd_device *device,
+				__u8 tbvpm, __u8 fcsecpm)
 {
 	struct pe_handler_work_data *data;
 
@@ -1490,7 +1495,8 @@ static int dasd_eckd_pe_handler(struct dasd_device *device, __u8 lpm)
 	INIT_WORK(&data->worker, do_pe_handler_work);
 	dasd_get_device(device);
 	data->device = device;
-	data->tbvpm = lpm;
+	data->tbvpm = tbvpm;
+	data->fcsecpm = fcsecpm;
 	schedule_work(&data->worker);
 	return 0;
 }
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 3ae1c8d42b8a..8486ed3c877b 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -298,7 +298,7 @@ struct dasd_discipline {
 	 * configuration.
 	 */
 	int (*verify_path)(struct dasd_device *, __u8);
-	int (*pe_handler)(struct dasd_device *, __u8);
+	int (*pe_handler)(struct dasd_device *, __u8, __u8);
 
 	/*
 	 * Last things to do when a device is set online, and first things
@@ -423,6 +423,7 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_PATH_NOHPF        6
 #define DASD_PATH_CUIR	       7
 #define DASD_PATH_IFCC	       8
+#define DASD_PATH_FCSEC	       9
 
 #define DASD_THRHLD_MAX		4294967295U
 #define DASD_INTERVAL_MAX	4294967295U
@@ -965,6 +966,29 @@ static inline void dasd_path_clear_all_verify(struct dasd_device *device)
 		dasd_path_clear_verify(device, chp);
 }
 
+static inline void dasd_path_fcsec(struct dasd_device *device, int chp)
+{
+	__set_bit(DASD_PATH_FCSEC, &device->path[chp].flags);
+}
+
+static inline void dasd_path_clear_fcsec(struct dasd_device *device, int chp)
+{
+	__clear_bit(DASD_PATH_FCSEC, &device->path[chp].flags);
+}
+
+static inline int dasd_path_need_fcsec(struct dasd_device *device, int chp)
+{
+	return test_bit(DASD_PATH_FCSEC, &device->path[chp].flags);
+}
+
+static inline void dasd_path_clear_all_fcsec(struct dasd_device *device)
+{
+	int chp;
+
+	for (chp = 0; chp < 8; chp++)
+		dasd_path_clear_fcsec(device, chp);
+}
+
 static inline void dasd_path_operational(struct dasd_device *device, int chp)
 {
 	__set_bit(DASD_PATH_OPERATIONAL, &device->path[chp].flags);
@@ -1090,6 +1114,17 @@ static inline __u8 dasd_path_get_tbvpm(struct dasd_device *device)
 	return tbvpm;
 }
 
+static inline int dasd_path_get_fcsecpm(struct dasd_device *device)
+{
+	int chp;
+
+	for (chp = 0; chp < 8; chp++)
+		if (dasd_path_need_fcsec(device, chp))
+			return 1;
+
+	return 0;
+}
+
 static inline __u8 dasd_path_get_nppm(struct dasd_device *device)
 {
 	int chp;
@@ -1347,6 +1382,11 @@ static inline void dasd_path_notoper(struct dasd_device *device, int chp)
 	dasd_path_clear_nonpreferred(device, chp);
 }
 
+static inline void dasd_path_fcsec_update(struct dasd_device *device, int chp)
+{
+	dasd_path_fcsec(device, chp);
+}
+
 /*
  * remove all paths from normal operation
  */
-- 
2.17.1
