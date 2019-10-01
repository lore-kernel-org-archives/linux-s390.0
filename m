Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389331AbfJAPev (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Oct 2019 11:34:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91FUStM047367
        for <linux-s390@vger.kernel.org>; Tue, 1 Oct 2019 11:34:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc631ggsm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 01 Oct 2019 11:34:45 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Tue, 1 Oct 2019 16:34:43 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/2] s390/dasd: Fix error handling during online processing
Date: Tue,  1 Oct 2019 17:34:38 +0200
In-Reply-To: <20191001153439.62672-1-sth@linux.ibm.com>
References: <20191001153439.62672-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191001153439.62672-2-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Jan Höppner <hoeppner@linux.ibm.com>

It is possible that the CCW commands for reading volume and extent pool
information are not supported, either by the storage server (for
dedicated DASDs) or by z/VM (for virtual devices, such as MDISKs).

As a command reject will occur in such a case, the current error
handling leads to a failing online processing and thus the DASD can't be
used at all.

Since the data being read is not essential for an fully operational
DASD, the error handling can be removed. Information about the failing
command is sent to the s390dbf debug feature.

Fixes: c729696bcf8b ("s390/dasd: Recognise data for ESE volumes")
Cc: <stable@vger.kernel.org> # 5.3
Reported-by: Frank Heimes <frank.heimes@canonical.com>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index fc53e1e221f0..b213c40d1a51 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1553,8 +1553,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	if (rc == 0) {
 		memcpy(&private->vsq, vsq, sizeof(*vsq));
 	} else {
-		dev_warn(&device->cdev->dev,
-			 "Reading the volume storage information failed with rc=%d\n", rc);
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Reading the volume storage information failed with rc=%d", rc);
 	}
 
 	if (useglobal)
@@ -1737,8 +1737,8 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	if (rc == 0) {
 		dasd_eckd_cpy_ext_pool_data(device, lcq);
 	} else {
-		dev_warn(&device->cdev->dev,
-			 "Reading the logical configuration failed with rc=%d\n", rc);
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"Reading the logical configuration failed with rc=%d", rc);
 	}
 
 	dasd_sfree_request(cqr, cqr->memdev);
@@ -2020,14 +2020,10 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	dasd_eckd_read_features(device);
 
 	/* Read Volume Information */
-	rc = dasd_eckd_read_vol_info(device);
-	if (rc)
-		goto out_err3;
+	dasd_eckd_read_vol_info(device);
 
 	/* Read Extent Pool Information */
-	rc = dasd_eckd_read_ext_pool_info(device);
-	if (rc)
-		goto out_err3;
+	dasd_eckd_read_ext_pool_info(device);
 
 	/* Read Device Characteristics */
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
@@ -5663,14 +5659,10 @@ static int dasd_eckd_restore_device(struct dasd_device *device)
 	dasd_eckd_read_features(device);
 
 	/* Read Volume Information */
-	rc = dasd_eckd_read_vol_info(device);
-	if (rc)
-		goto out_err2;
+	dasd_eckd_read_vol_info(device);
 
 	/* Read Extent Pool Information */
-	rc = dasd_eckd_read_ext_pool_info(device);
-	if (rc)
-		goto out_err2;
+	dasd_eckd_read_ext_pool_info(device);
 
 	/* Read Device Characteristics */
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
-- 
2.17.1
