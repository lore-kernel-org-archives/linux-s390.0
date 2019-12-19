Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbfLSIoA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Dec 2019 03:44:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJ8gTD0033684
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wyux3j4pr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2019 03:43:58 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 19 Dec 2019 08:43:56 -0000
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/3] s390/dasd/cio: Interpret ccw_device_get_mdc return value correctly
Date: Thu, 19 Dec 2019 09:43:50 +0100
In-Reply-To: <20191219084352.75114-1-sth@linux.ibm.com>
References: <20191219084352.75114-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191219084352.75114-2-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Jan Höppner <hoeppner@linux.ibm.com>

The max data count (mdc) is an unsigned 16-bit integer value as per AR
documentation and is received via ccw_device_get_mdc() for a specific
path mask from the CIO layer. The function itself also always returns a
positive mdc value or 0 in case mdc isn't supported or couldn't be
determined.

Though, the comment for this function describes a negative return value
to indicate failures.

As a result, the DASD device driver interprets the return value of
ccw_device_get_mdc() incorrectly. The error case is essentially a dead
code path.

To fix this behaviour, check explicitly for a return value of 0 and
change the comment for ccw_device_get_mdc() accordingly.

This fix merely enables the error code path in the DASD functions
get_fcx_max_data() and verify_fcx_max_data(). The actual functionality
stays the same and is still correct.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 9 +++++----
 drivers/s390/cio/device_ops.c  | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index c94184d080f8..f5622f4a2ecf 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1128,7 +1128,8 @@ static u32 get_fcx_max_data(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
 	int fcx_in_css, fcx_in_gneq, fcx_in_features;
-	int tpm, mdc;
+	unsigned int mdc;
+	int tpm;
 
 	if (dasd_nofcx)
 		return 0;
@@ -1142,7 +1143,7 @@ static u32 get_fcx_max_data(struct dasd_device *device)
 		return 0;
 
 	mdc = ccw_device_get_mdc(device->cdev, 0);
-	if (mdc < 0) {
+	if (mdc == 0) {
 		dev_warn(&device->cdev->dev, "Detecting the maximum supported data size for zHPF requests failed\n");
 		return 0;
 	} else {
@@ -1153,12 +1154,12 @@ static u32 get_fcx_max_data(struct dasd_device *device)
 static int verify_fcx_max_data(struct dasd_device *device, __u8 lpm)
 {
 	struct dasd_eckd_private *private = device->private;
-	int mdc;
+	unsigned int mdc;
 	u32 fcx_max_data;
 
 	if (private->fcx_max_data) {
 		mdc = ccw_device_get_mdc(device->cdev, lpm);
-		if ((mdc < 0)) {
+		if (mdc == 0) {
 			dev_warn(&device->cdev->dev,
 				 "Detecting the maximum data size for zHPF "
 				 "requests failed (rc=%d) for a new path %x\n",
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 65841af15748..ccecf6b9504e 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -635,7 +635,7 @@ EXPORT_SYMBOL(ccw_device_tm_start_timeout);
  * @mask: mask of paths to use
  *
  * Return the number of 64K-bytes blocks all paths at least support
- * for a transport command. Return values <= 0 indicate failures.
+ * for a transport command. Return value 0 indicates failure.
  */
 int ccw_device_get_mdc(struct ccw_device *cdev, u8 mask)
 {
-- 
2.17.1
