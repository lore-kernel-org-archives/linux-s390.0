Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E34C7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 15:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbjDEP3w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbjDEP3t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 11:29:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B932A59DD;
        Wed,  5 Apr 2023 08:29:39 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335CuZgR023779;
        Wed, 5 Apr 2023 14:20:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IrDZJw2fCLRTr14dXbQ4KvW190waCP1kaXxrbRkdRMs=;
 b=pFNMvrKj5GdNQgcgi9pd0VNY32zQi/AKdqGFt6zOYCtlHUd2nU8U0ZHuXUj/jWCbpNS6
 BLnT3h15em6khQLKzg6QHB+PSum3HipqFNKZMqb+Dhr+IPYzb4TglH0T3B+cd2o0C+HD
 iU3bIDGIv8aeO8Je2jCNmm6OhgpaU17DzV5wPj3f4atZ8jhttI+kSuDH+IF5kVH68OTB
 UUw698wxzcMfSNU1rD3FGHttC4TRVuvnu/04IvfjpMy/gLUYYE5fhFmDH6u+jAzCFSEF
 Vpr1HR0UwCN2wAqAwrgkNDSPdQGEAb0zjL0Cp+ezeS8eOSpcjQzJiyFphDnV4QKHm8tg wQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps75je7ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:24 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3353w1W2013437;
        Wed, 5 Apr 2023 14:20:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3ppbvftk14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 14:20:21 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335EKIdw60031304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 14:20:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD7C220043;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDDA320040;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 14:20:17 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 804A0E0873; Wed,  5 Apr 2023 16:20:17 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/7] s390/dasd: add autoquiesce feature
Date:   Wed,  5 Apr 2023 16:20:12 +0200
Message-Id: <20230405142017.2446986-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230405142017.2446986-1-sth@linux.ibm.com>
References: <20230405142017.2446986-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tXTaMPPbqlFLzXR7VVcJ9Bhl1b1J2xXk
X-Proofpoint-ORIG-GUID: tXTaMPPbqlFLzXR7VVcJ9Bhl1b1J2xXk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_09,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050127
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add the internal logic to check for autoquiesce triggers and handle
them.

Quiesce and resume are functions that tell Linux to stop/resume
issuing I/Os to a specific DASD.
The DASD driver allows a manual quiesce/resume via ioctl.

Autoquiesce will define an amount of triggers that will lead to
an automatic quiesce if a certain event occurs.
There is no automatic resume.

All events will be reported via DASD Extended Error Reporting (EER)
if configured.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 arch/s390/include/uapi/asm/dasd.h |  2 ++
 drivers/s390/block/dasd.c         | 60 ++++++++++++++++++++++---------
 drivers/s390/block/dasd_eer.c     |  1 +
 drivers/s390/block/dasd_int.h     |  2 ++
 4 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/uapi/asm/dasd.h b/arch/s390/include/uapi/asm/dasd.h
index 93d1ccd3304c..9c49c3d67cd5 100644
--- a/arch/s390/include/uapi/asm/dasd.h
+++ b/arch/s390/include/uapi/asm/dasd.h
@@ -78,6 +78,7 @@ typedef struct dasd_information2_t {
  * 0x040: give access to raw eckd data
  * 0x080: enable discard support
  * 0x100: enable autodisable for IFCC errors (default)
+ * 0x200: enable requeue of all requests on autoquiesce
  */
 #define DASD_FEATURE_READONLY	      0x001
 #define DASD_FEATURE_USEDIAG	      0x002
@@ -88,6 +89,7 @@ typedef struct dasd_information2_t {
 #define DASD_FEATURE_USERAW	      0x040
 #define DASD_FEATURE_DISCARD	      0x080
 #define DASD_FEATURE_PATH_AUTODISABLE 0x100
+#define DASD_FEATURE_REQUEUEQUIESCE   0x200
 #define DASD_FEATURE_DEFAULT	      DASD_FEATURE_PATH_AUTODISABLE
 
 #define DASD_PARTN_BITS 2
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index a9c2a8d76c45..8186473b9aa7 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -73,7 +73,8 @@ static void dasd_profile_init(struct dasd_profile *, struct dentry *);
 static void dasd_profile_exit(struct dasd_profile *);
 static void dasd_hosts_init(struct dentry *, struct dasd_device *);
 static void dasd_hosts_exit(struct dasd_device *);
-
+static int dasd_handle_autoquiesce(struct dasd_device *, struct dasd_ccw_req *,
+				   unsigned int);
 /*
  * SECTION: Operations on the device structure.
  */
@@ -2325,7 +2326,7 @@ static int _dasd_sleep_on(struct dasd_ccw_req *maincqr, int interruptible)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (device->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(device))) {
+		    !dasd_eer_enabled(device) && device->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			continue;
@@ -2801,20 +2802,18 @@ static void __dasd_process_block_ccw_queue(struct dasd_block *block,
 			dasd_log_sense(cqr, &cqr->irb);
 		}
 
-		/* First of all call extended error reporting. */
-		if (dasd_eer_enabled(base) &&
-		    cqr->status == DASD_CQR_FAILED) {
-			dasd_eer_write(base, cqr, DASD_EER_FATALERROR);
-
-			/* restart request  */
+		/*
+		 * First call extended error reporting and check for autoquiesce
+		 */
+		spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
+		if (cqr->status == DASD_CQR_FAILED &&
+		    dasd_handle_autoquiesce(base, cqr, DASD_EER_FATALERROR)) {
 			cqr->status = DASD_CQR_FILLED;
 			cqr->retries = 255;
-			spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
-			dasd_device_set_stop_bits(base, DASD_STOPPED_QUIESCE);
-			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev),
-					       flags);
+			spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 			goto restart;
 		}
+		spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 		/* Process finished ERP request. */
 		if (cqr->refers) {
@@ -2856,7 +2855,7 @@ static void __dasd_block_start_head(struct dasd_block *block)
 		/* Non-temporary stop condition will trigger fail fast */
 		if (block->base->stopped & ~DASD_STOPPED_PENDING &&
 		    test_bit(DASD_CQR_FLAGS_FAILFAST, &cqr->flags) &&
-		    (!dasd_eer_enabled(block->base))) {
+		    !dasd_eer_enabled(block->base) && block->base->aq_mask == 0) {
 			cqr->status = DASD_CQR_FAILED;
 			cqr->intrc = -ENOLINK;
 			dasd_schedule_block_bh(block);
@@ -3670,8 +3669,8 @@ int dasd_generic_last_path_gone(struct dasd_device *device)
 	dev_warn(&device->cdev->dev, "No operational channel path is left "
 		 "for the device\n");
 	DBF_DEV_EVENT(DBF_WARNING, device, "%s", "last path gone");
-	/* First of all call extended error reporting. */
-	dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 
 	if (device->state < DASD_STATE_BASIC)
 		return 0;
@@ -3803,7 +3802,8 @@ void dasd_generic_path_event(struct ccw_device *cdev, int *path_event)
 			 "No verified channel paths remain for the device\n");
 		DBF_DEV_EVENT(DBF_WARNING, device,
 			      "%s", "last verified path gone");
-		dasd_eer_write(device, NULL, DASD_EER_NOPATH);
+		/* First call extended error reporting and check for autoquiesce. */
+		dasd_handle_autoquiesce(device, NULL, DASD_EER_NOPATH);
 		dasd_device_set_stop_bits(device,
 					  DASD_STOPPED_DC_WAIT);
 	}
@@ -3825,7 +3825,8 @@ EXPORT_SYMBOL_GPL(dasd_generic_verify_path);
 void dasd_generic_space_exhaust(struct dasd_device *device,
 				struct dasd_ccw_req *cqr)
 {
-	dasd_eer_write(device, NULL, DASD_EER_NOSPC);
+	/* First call extended error reporting and check for autoquiesce. */
+	dasd_handle_autoquiesce(device, NULL, DASD_EER_NOSPC);
 
 	if (device->state < DASD_STATE_BASIC)
 		return;
@@ -3958,6 +3959,31 @@ void dasd_schedule_requeue(struct dasd_device *device)
 }
 EXPORT_SYMBOL(dasd_schedule_requeue);
 
+static int dasd_handle_autoquiesce(struct dasd_device *device,
+				   struct dasd_ccw_req *cqr,
+				   unsigned int reason)
+{
+	/* in any case write eer message with reason */
+	if (dasd_eer_enabled(device))
+		dasd_eer_write(device, cqr, reason);
+
+	if (!test_bit(reason, &device->aq_mask))
+		return 0;
+
+	/* notify eer about autoquiesce */
+	if (dasd_eer_enabled(device))
+		dasd_eer_write(device, NULL, DASD_EER_AUTOQUIESCE);
+
+	pr_info("%s: The DASD has been put in the quiesce state\n",
+		dev_name(&device->cdev->dev));
+	dasd_device_set_stop_bits(device, DASD_STOPPED_QUIESCE);
+
+	if (device->features & DASD_FEATURE_REQUEUEQUIESCE)
+		dasd_schedule_requeue(device);
+
+	return 1;
+}
+
 static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 						   int rdc_buffer_size,
 						   int magic)
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index a4cc772208a6..c956de711cf7 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -387,6 +387,7 @@ void dasd_eer_write(struct dasd_device *device, struct dasd_ccw_req *cqr,
 		break;
 	case DASD_EER_NOPATH:
 	case DASD_EER_NOSPC:
+	case DASD_EER_AUTOQUIESCE:
 		dasd_eer_write_standard_trigger(device, NULL, id);
 		break;
 	case DASD_EER_STATECHANGE:
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 47cad999fc2a..d0ff4528d489 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -450,6 +450,7 @@ extern struct dasd_discipline *dasd_diag_discipline_pointer;
 #define DASD_EER_STATECHANGE 3
 #define DASD_EER_PPRCSUSPEND 4
 #define DASD_EER_NOSPC	     5
+#define DASD_EER_AUTOQUIESCE 31
 
 /* DASD path handling */
 
@@ -627,6 +628,7 @@ struct dasd_device {
 	struct dasd_format_entry format_entry;
 	struct kset *paths_info;
 	struct dasd_copy_relation *copy;
+	unsigned long aq_mask;
 };
 
 struct dasd_block {
-- 
2.37.2

