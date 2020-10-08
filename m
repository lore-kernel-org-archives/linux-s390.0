Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52038 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729795AbgJHNNn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 09:13:43 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v2 05/10] s390/dasd: Move duplicate code to separate function
Date: Thu,  8 Oct 2020 15:13:31 +0200
Message-Id: <20201008131336.61100-6-sth@linux.ibm.com>
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Jan Höppner <hoeppner@linux.ibm.com>

For storing retrieved path information both the if and else block in
dasd_eckd_read_conf() use the same code. To avoid duplicate code this
should be done after the if/else block. To further increase readability,
move the code to a new function, dasd_eckd_store_conf_data().

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 42 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2b39d2a5965f..497aa81778b6 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1000,6 +1000,22 @@ static unsigned char dasd_eckd_path_access(void *conf_data, int conf_len)
 		return 0;
 }
 
+static void dasd_eckd_store_conf_data(struct dasd_device *device,
+				      struct dasd_conf_data *conf_data, int chp)
+{
+	struct channel_path_desc_fmt0 *chp_desc;
+	struct subchannel_id sch_id;
+
+	ccw_device_get_schid(device->cdev, &sch_id);
+	device->path[chp].conf_data = conf_data;
+	device->path[chp].cssid = sch_id.cssid;
+	device->path[chp].ssid = sch_id.ssid;
+	chp_desc = ccw_device_get_chp_desc(device->cdev, chp);
+	if (chp_desc)
+		device->path[chp].chpid = chp_desc->chpid;
+	kfree(chp_desc);
+}
+
 static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
@@ -1016,7 +1032,6 @@ static void dasd_eckd_clear_conf_data(struct dasd_device *device)
 	}
 }
 
-
 static int dasd_eckd_read_conf(struct dasd_device *device)
 {
 	void *conf_data;
@@ -1026,12 +1041,9 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 	struct dasd_eckd_private *private, path_private;
 	struct dasd_uid *uid;
 	char print_path_uid[60], print_device_uid[60];
-	struct channel_path_desc_fmt0 *chp_desc;
-	struct subchannel_id sch_id;
 
 	private = device->private;
 	opm = ccw_device_get_path_mask(device->cdev);
-	ccw_device_get_schid(device->cdev, &sch_id);
 	conf_data_saved = 0;
 	path_err = 0;
 	/* get configuration data per operational path */
@@ -1066,15 +1078,6 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 				kfree(conf_data);
 				continue;
 			}
-			pos = pathmask_to_pos(lpm);
-			/* store per path conf_data */
-			device->path[pos].conf_data = conf_data;
-			device->path[pos].cssid = sch_id.cssid;
-			device->path[pos].ssid = sch_id.ssid;
-			chp_desc = ccw_device_get_chp_desc(device->cdev, pos);
-			if (chp_desc)
-				device->path[pos].chpid = chp_desc->chpid;
-			kfree(chp_desc);
 			/*
 			 * build device UID that other path data
 			 * can be compared to it
@@ -1132,18 +1135,13 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 				dasd_path_add_cablepm(device, lpm);
 				continue;
 			}
-			pos = pathmask_to_pos(lpm);
-			/* store per path conf_data */
-			device->path[pos].conf_data = conf_data;
-			device->path[pos].cssid = sch_id.cssid;
-			device->path[pos].ssid = sch_id.ssid;
-			chp_desc = ccw_device_get_chp_desc(device->cdev, pos);
-			if (chp_desc)
-				device->path[pos].chpid = chp_desc->chpid;
-			kfree(chp_desc);
 			path_private.conf_data = NULL;
 			path_private.conf_len = 0;
 		}
+
+		pos = pathmask_to_pos(lpm);
+		dasd_eckd_store_conf_data(device, conf_data, pos);
+
 		switch (dasd_eckd_path_access(conf_data, conf_len)) {
 		case 0x02:
 			dasd_path_add_nppm(device, lpm);
-- 
2.17.1
