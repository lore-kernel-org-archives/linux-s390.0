Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10630 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729718AbgJHNNn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 09:13:43 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v2 06/10] s390/dasd: Store path configuration data during path handling
Date: Thu,  8 Oct 2020 15:13:32 +0200
Message-Id: <20201008131336.61100-7-sth@linux.ibm.com>
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Jan Höppner <hoeppner@linux.ibm.com>

Currently, the configuration data for a path is retrieved during a path
verification and used only temporarily. If a path is newly added to the
I/O setup after a boot, no configuration data will be stored for this
particular path.
However, this data is required for later use and should be present for
a valid I/O path anyway. Store this data during the path verification so
that newly added paths can provide all information necessary.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
[sth@linux.ibm.com: fix conf_data memleak]
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 497aa81778b6..3ff7b532a5bf 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1007,6 +1007,11 @@ static void dasd_eckd_store_conf_data(struct dasd_device *device,
 	struct subchannel_id sch_id;
 
 	ccw_device_get_schid(device->cdev, &sch_id);
+	/*
+	 * path handling and read_conf allocate data
+	 * free it before replacing the pointer
+	 */
+	kfree(device->path[chp].conf_data);
 	device->path[chp].conf_data = conf_data;
 	device->path[chp].cssid = sch_id.cssid;
 	device->path[chp].ssid = sch_id.ssid;
@@ -1263,9 +1268,10 @@ static void do_path_verification_work(struct work_struct *work)
 	struct dasd_uid *uid;
 	__u8 path_rcd_buf[DASD_ECKD_RCD_DATA_SIZE];
 	__u8 lpm, opm, npm, ppm, epm, hpfpm, cablepm;
+	struct dasd_conf_data *conf_data;
 	unsigned long flags;
 	char print_uid[60];
-	int rc;
+	int rc, pos;
 
 	data = container_of(work, struct path_verification_work_data, worker);
 	device = data->device;
@@ -1395,6 +1401,14 @@ static void do_path_verification_work(struct work_struct *work)
 			}
 		}
 
+		conf_data = kzalloc(DASD_ECKD_RCD_DATA_SIZE, GFP_KERNEL);
+		if (conf_data) {
+			memcpy(conf_data, data->rcd_buffer,
+			       DASD_ECKD_RCD_DATA_SIZE);
+		}
+		pos = pathmask_to_pos(lpm);
+		dasd_eckd_store_conf_data(device, conf_data, pos);
+
 		/*
 		 * There is a small chance that a path is lost again between
 		 * above path verification and the following modification of
-- 
2.17.1
