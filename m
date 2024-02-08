Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4481ABB;
	Thu,  8 Feb 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410581; cv=none; b=hhM1mdXwx3rLKDYzLF1XU2ikI1G+BzsIPjgDRjkmVMB5AoKIBWlRXn0z1igQa/TPuNEWmpSr2KIBHqbNiEGFd0ScXQ1EJy5xKz3XtsOPco09rmHF2tZgK+n3jjt4KPUFzKgtW+He31OrqsLAkSTvdMdggvoXVIcWtO/+3mqCLEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410581; c=relaxed/simple;
	bh=KOChFrn13gEduWJ2I11m/xO+nDEoWvwhsKnZVLoEOQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIzqlTfS2a2zu1j/pAvHv3W9nKHA5mpgIl0C8+hoC2FpsyzLR5tCw6CMji9QGmipATtPa71colidYNmSoiskEz2lrTNa54hcwYuly1WCSArdASdzVUOgtKNsbS9qtkGu5b8oLTOsNDXGkccnUdufmuFcWg+QtuOpLaeuT87atnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B1q1umIA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B1q1umIA"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418EqCDp029229;
	Thu, 8 Feb 2024 16:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=zhN/rZi5jIl6WbzYlw0DZNL+AXSPD30BstDNdnvD+Mo=;
 b=B1q1umIAeG1U3ICNxZSn9KZUiQCTjw9ngtlZx6Z+ZNBrR2lLAXlUN8L9B5mCpxV+aqql
 hTXTmBFIuZEeTSDtBhclgYqSPBR2lmkQHAlVOzqobDCHajrFVf82DBH7PzJ3FH5x2mmg
 pHKQYC9Hl7yD5yGeSP6tGMy/qRg2C5K+QxQ85VYQFdQld0MW0zliGNiiT0Zhodo1w5sE
 S9T9PYWdnGCbGalcMAJPhwwXKvOdTNo+vW8ChP8BH/OUCB9duh65VpDAZROrZxImL0lG
 xYblfEENbrraTm9rTzgQ8og4egteZT4ABFH/QEFepqHpYfzmqOCjK59i/13SZn2l2zxK ug== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w4yk0p48c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:54 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418FEUnC008971;
	Thu, 8 Feb 2024 16:42:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w206ywsyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 16:42:53 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418GgmqL41156980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 16:42:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20BB20049;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B199F2004E;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Feb 2024 16:42:48 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 529F9E15C0; Thu,  8 Feb 2024 17:42:48 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Miroslav Franc <mfranc@suse.cz>
Subject: [PATCH RESEND 09/11] s390/dasd: Use dev_*() for device log messages
Date: Thu,  8 Feb 2024 17:42:48 +0100
Message-Id: <20240208164248.540985-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240208164248.540985-1-sth@linux.ibm.com>
References: <20240208164248.540985-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 91SL3dTgepDIQ4nTf4omHNiZcA4LAinj
X-Proofpoint-ORIG-GUID: 91SL3dTgepDIQ4nTf4omHNiZcA4LAinj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_07,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402080088

From: Jan Höppner <hoeppner@linux.ibm.com>

All log messages in dasd.c use the printk variants of pr_*(). They all
add the name of the affected device manually to the log message.
This can be simplified by using the dev_*() variants of printk, which
include the device information and make a separate call to dev_name()
unnecessary.

The KMSG_COMPONENT and the pr_fmt() definition can be dropped. Note that
this removes the "dasd: " prefix from the one pr_info() call in
dasd_init(). However, the log message already provides all relevant
information.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 50 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index d79e54279158..fdb6cb8d8abf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -8,9 +8,6 @@
  * Copyright IBM Corp. 1999, 2009
  */
 
-#define KMSG_COMPONENT "dasd"
-#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
-
 #include <linux/kmod.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -3381,8 +3378,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
 
 	ret = ccw_device_set_online(cdev);
 	if (ret)
-		pr_warn("%s: Setting the DASD online failed with rc=%d\n",
-			dev_name(&cdev->dev), ret);
+		dev_warn(&cdev->dev, "Setting the DASD online failed with rc=%d\n", ret);
 }
 
 /*
@@ -3469,8 +3465,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 {
 	struct dasd_discipline *discipline;
 	struct dasd_device *device;
+	struct device *dev;
 	int rc;
 
+	dev = &cdev->dev;
+
 	/* first online clears initial online feature flag */
 	dasd_set_feature(cdev, DASD_FEATURE_INITIAL_ONLINE, 0);
 	device = dasd_create_device(cdev);
@@ -3483,11 +3482,10 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 			/* Try to load the required module. */
 			rc = request_module(DASD_DIAG_MOD);
 			if (rc) {
-				pr_warn("%s Setting the DASD online failed "
-					"because the required module %s "
-					"could not be loaded (rc=%d)\n",
-					dev_name(&cdev->dev), DASD_DIAG_MOD,
-					rc);
+				dev_warn(dev, "Setting the DASD online failed "
+					 "because the required module %s "
+					 "could not be loaded (rc=%d)\n",
+					 DASD_DIAG_MOD, rc);
 				dasd_delete_device(device);
 				return -ENODEV;
 			}
@@ -3495,8 +3493,7 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		/* Module init could have failed, so check again here after
 		 * request_module(). */
 		if (!dasd_diag_discipline_pointer) {
-			pr_warn("%s Setting the DASD online failed because of missing DIAG discipline\n",
-				dev_name(&cdev->dev));
+			dev_warn(dev, "Setting the DASD online failed because of missing DIAG discipline\n");
 			dasd_delete_device(device);
 			return -ENODEV;
 		}
@@ -3517,8 +3514,8 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	/* check_device will allocate block device if necessary */
 	rc = discipline->check_device(device);
 	if (rc) {
-		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
-			dev_name(&cdev->dev), discipline->name, rc);
+		dev_warn(dev, "Setting the DASD online with discipline %s failed with rc=%i\n",
+			 discipline->name, rc);
 		module_put(discipline->owner);
 		module_put(base_discipline->owner);
 		dasd_delete_device(device);
@@ -3527,16 +3524,15 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 
 	dasd_set_target_state(device, DASD_STATE_ONLINE);
 	if (device->state <= DASD_STATE_KNOWN) {
-		pr_warn("%s Setting the DASD online failed because of a missing discipline\n",
-			dev_name(&cdev->dev));
+		dev_warn(dev, "Setting the DASD online failed because of a missing discipline\n");
 		rc = -ENODEV;
 		dasd_set_target_state(device, DASD_STATE_NEW);
 		if (device->block)
 			dasd_free_block(device->block);
 		dasd_delete_device(device);
-	} else
-		pr_debug("dasd_generic device %s found\n",
-				dev_name(&cdev->dev));
+	} else {
+		dev_dbg(dev, "dasd_generic device found\n");
+	}
 
 	wait_event(dasd_init_waitq, _wait_for_device(device));
 
@@ -3547,10 +3543,13 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 
 int dasd_generic_set_offline(struct ccw_device *cdev)
 {
+	int max_count, open_count, rc;
 	struct dasd_device *device;
 	struct dasd_block *block;
-	int max_count, open_count, rc;
 	unsigned long flags;
+	struct device *dev;
+
+	dev = &cdev->dev;
 
 	rc = 0;
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
@@ -3571,11 +3570,10 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
 		open_count = atomic_read(&device->block->open_count);
 		if (open_count > max_count) {
 			if (open_count > 0)
-				pr_warn("%s: The DASD cannot be set offline with open count %i\n",
-					dev_name(&cdev->dev), open_count);
+				dev_warn(dev, "The DASD cannot be set offline with open count %i\n",
+					 open_count);
 			else
-				pr_warn("%s: The DASD cannot be set offline while it is in use\n",
-					dev_name(&cdev->dev));
+				dev_warn(dev, "The DASD cannot be set offline while it is in use\n");
 			rc = -EBUSY;
 			goto out_err;
 		}
@@ -3935,8 +3933,8 @@ static int dasd_handle_autoquiesce(struct dasd_device *device,
 	if (dasd_eer_enabled(device))
 		dasd_eer_write(device, NULL, DASD_EER_AUTOQUIESCE);
 
-	pr_info("%s: The DASD has been put in the quiesce state\n",
-		dev_name(&device->cdev->dev));
+	dev_info(&device->cdev->dev,
+		 "The DASD has been put in the quiesce state\n");
 	dasd_device_set_stop_bits(device, DASD_STOPPED_QUIESCE);
 
 	if (device->features & DASD_FEATURE_REQUEUEQUIESCE)
-- 
2.40.1

