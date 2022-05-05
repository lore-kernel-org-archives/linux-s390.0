Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45136C4332F
	for <linux-s390@archiver.kernel.org>; Thu,  5 May 2022 14:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380522AbiEEOVW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 May 2022 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380512AbiEEOVU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 May 2022 10:21:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC1E5A2EF;
        Thu,  5 May 2022 07:17:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245EGt9h023354;
        Thu, 5 May 2022 14:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VWZVjO7jLV8qlLNR34/g3TwhQBy/7Dgq2uezDR+UWk8=;
 b=B/Vzz++JMCnX166Kej1xoNNFvdDQsWzhdKrv7kmEAFE7hfJnXOubqz2k2yQgDArDRXYP
 0xCl0WPI7DVXdUPm+LRznbIk2A++evU17zshH1b/9kf61rAN2A8USZkhGv6y1Bssxjpz
 aLplAeop6f16XxUTlMQd2/nh0UXDIcPtAd7eFoFQjRHEoVl9gpOgo9I18q/iNcUR6q4I
 Q/7p8jwTaJ7m4troKx6yJV5hyk70zClUSR7N9fQST47CtduYUfnCaQWF75VzZqtP9/Ly
 g+PI5R2JTqYvFSRy+gg8xw9Iz9P4EYCcikAAmtvMFOglHTUJrNLC2FVYJXlVJv5VWBQi vA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fve8cay88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:38 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 245EHCug011628;
        Thu, 5 May 2022 14:17:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3ftp7fv6g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 14:17:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 245E4BrJ36503924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 May 2022 14:04:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 641A1AE04D;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 531EBAE045;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  5 May 2022 14:17:33 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 0F241E0397; Thu,  5 May 2022 16:17:33 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/5] s390/dasd: fix data corruption for ESE devices
Date:   Thu,  5 May 2022 16:17:29 +0200
Message-Id: <20220505141733.1989450-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505141733.1989450-1-sth@linux.ibm.com>
References: <20220505141733.1989450-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YZ17bF5Zkc-L7XlqE6AchT3QP6SoIqJC
X-Proofpoint-GUID: YZ17bF5Zkc-L7XlqE6AchT3QP6SoIqJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_05,2022-05-05_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=948 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050099
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

For ESE devices we get an error when accessing an unformatted track.
The handling of this error will return zero data for read requests and
format the track on demand before writing to it. To do this the code needs
to distinguish between read and write requests. This is done with data from
the blocklayer request. A pointer to the blocklayer request is stored in
the CQR.

If there is an error on the device an ERP request is built to do error
recovery. While the ERP request is mostly a copy of the original CQR the
pointer to the blocklayer request is not copied to not accidentally pass
it back to the blocklayer without cleanup.

This leads to the error that during ESE handling after an ERP request was
built it is not possible to determine the IO direction. This leads to the
formatting of a track for read requests which might in turn lead to data
corruption.

Fixes: 5e2b17e712cf ("s390/dasd: Add dynamic formatting support for ESE volumes")
Cc: stable@vger.kernel.org # 5.3+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c      |  8 +++++++-
 drivers/s390/block/dasd_eckd.c |  2 +-
 drivers/s390/block/dasd_int.h  | 12 ++++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 8e87a31e329d..76d13c5ff205 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1639,6 +1639,7 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	unsigned long now;
 	int nrf_suppressed = 0;
 	int fp_suppressed = 0;
+	struct request *req;
 	u8 *sense = NULL;
 	int expires;
 
@@ -1739,7 +1740,12 @@ void dasd_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	}
 
 	if (dasd_ese_needs_format(cqr->block, irb)) {
-		if (rq_data_dir((struct request *)cqr->callback_data) == READ) {
+		req = dasd_get_callback_data(cqr);
+		if (!req) {
+			cqr->status = DASD_CQR_ERROR;
+			return;
+		}
+		if (rq_data_dir(req) == READ) {
 			device->discipline->ese_read(cqr, irb);
 			cqr->status = DASD_CQR_SUCCESS;
 			cqr->stopclk = now;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 8410a25a65c1..e3583502aca2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3145,7 +3145,7 @@ dasd_eckd_ese_format(struct dasd_device *startdev, struct dasd_ccw_req *cqr,
 	sector_t curr_trk;
 	int rc;
 
-	req = cqr->callback_data;
+	req = dasd_get_callback_data(cqr);
 	block = cqr->block;
 	base = block->base;
 	private = base->private;
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 3b7af00a7825..07f9670ea61e 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -756,6 +756,18 @@ dasd_check_blocksize(int bsize)
 	return 0;
 }
 
+/*
+ * return the callback data of the original request in case there are
+ * ERP requests build on top of it
+ */
+static inline void *dasd_get_callback_data(struct dasd_ccw_req *cqr)
+{
+	while (cqr->refers)
+		cqr = cqr->refers;
+
+	return cqr->callback_data;
+}
+
 /* externals in dasd.c */
 #define DASD_PROFILE_OFF	 0
 #define DASD_PROFILE_ON 	 1
-- 
2.32.0

