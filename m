Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20476 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388358AbgJBTjr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Oct 2020 15:39:47 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 06/10] s390/dasd: Store path configuration data during path handling
Date: Fri,  2 Oct 2020 21:39:36 +0200
Message-Id: <20201002193940.24012-7-sth@linux.ibm.com>
In-Reply-To: <20201002193940.24012-1-sth@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Jan Höppner <hoeppner@linux.ibm.com>

Currently, the configuration data for a path is retrieved during a path
verification and used only temporarily. If a path is newly added to the
I/O setup after a boot, no configuration data will be stored for this
particular path.
However, this data is required for later use and should be present for
a valid I/O path anyway. Store this data during the path verification so
that newly added paths can provide all information necessary.

Reference-ID: IO1812
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 497aa81778b6..274f79869b7c 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1263,9 +1263,10 @@ static void do_path_verification_work(struct work_struct *work)
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
@@ -1395,6 +1396,14 @@ static void do_path_verification_work(struct work_struct *work)
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
