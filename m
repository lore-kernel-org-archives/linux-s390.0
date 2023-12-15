Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBBA364D3;
	Fri, 15 Dec 2023 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jU0h0J0c"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEVfTm028210;
	Fri, 15 Dec 2023 15:28:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=FsDBn/f0pqi2JIhLRWKxsJ29yr3T+I8RIFAi6yJXrsI=;
 b=jU0h0J0cYnunBZXR10zQsL9oPgXb0spHGSBzrKuJx9EHVd70dkndNX8v1qJceRdFdozs
 tNEUo4ODCllS4GZpfu+OGtmU1SVMw1bO2bNcxnYoIHeN8l4bMgGA3JbsaQuDQPVeYQFf
 L9pHrtxuEJCj/BSRlr9I1CcCXrbKxBzMmraCHSDw2VV8BOC61kt1/+TYRaSL6BA0QcHW
 ty2r/RImRma3xlqXxnGgZkRL+3LnuPn9wSS79RHx7wkJE65G1eih/E+/JQgwnHmH5ptl
 TxqlTvwTQEhnpU538VEmaptdaGoj+jp9yK6OHVfVNte581I8+BztQQdVY6EiCX9lKqRe 0g== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0pymm63b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFEw0PI004390;
	Fri, 15 Dec 2023 15:28:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sm0huv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 15:28:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFFSAdl3146418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 15:28:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CCE42004D;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B0AA20043;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 Dec 2023 15:28:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id A4276E156A; Fri, 15 Dec 2023 16:28:09 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 09/10] s390/dasd: Use dev_*() for device log messages
Date: Fri, 15 Dec 2023 16:28:09 +0100
Message-Id: <20231215152809.882602-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215152809.882602-1-sth@linux.ibm.com>
References: <20231215152809.882602-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4w5KaVxDBl8b_1BXDOGZgY5O8wPoHddK
X-Proofpoint-GUID: 4w5KaVxDBl8b_1BXDOGZgY5O8wPoHddK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150105

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
index c6a5fddd4389..1af8edd6c509 100644
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
@@ -3387,8 +3384,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
 
 	ret = ccw_device_set_online(cdev);
 	if (ret)
-		pr_warn("%s: Setting the DASD online failed with rc=%d\n",
-			dev_name(&cdev->dev), ret);
+		dev_warn(&cdev->dev, "Setting the DASD online failed with rc=%d\n", ret);
 }
 
 /*
@@ -3475,8 +3471,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3489,11 +3488,10 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3501,8 +3499,7 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		/* Module init could have failed, so check again here after
 		 * request_module(). */
 		if (!dasd_diag_discipline_pointer) {
-			pr_warn("%s Setting the DASD online failed because of missing DIAG discipline\n",
-				dev_name(&cdev->dev));
+			dev_warn(dev, "Setting the DASD online failed because of missing DIAG discipline\n");
 			dasd_delete_device(device);
 			return -ENODEV;
 		}
@@ -3523,8 +3520,8 @@ int dasd_generic_set_online(struct ccw_device *cdev,
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
@@ -3533,16 +3530,15 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 
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
 
@@ -3553,10 +3549,13 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_online);
 
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
@@ -3577,11 +3576,10 @@ int dasd_generic_set_offline(struct ccw_device *cdev)
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
@@ -3941,8 +3939,8 @@ static int dasd_handle_autoquiesce(struct dasd_device *device,
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

