Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728217AbfHALGh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Aug 2019 07:06:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71B31Li068776
        for <linux-s390@vger.kernel.org>; Thu, 1 Aug 2019 07:06:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3vnmpae3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 01 Aug 2019 07:06:36 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 1 Aug 2019 12:06:34 +0100
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/1] s390/dasd: fix endless loop after read unit address configuration
Date: Thu,  1 Aug 2019 13:06:30 +0200
In-Reply-To: <20190801110630.82432-1-sth@linux.ibm.com>
References: <20190801110630.82432-1-sth@linux.ibm.com>
Message-Id: <20190801110630.82432-2-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org, hoeppner@linux.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, gor@linux.ibm.com

After getting a storage server event that causes the DASD device driver
to update its unit address configuration during a device shutdown there is
the possibility of an endless loop in the device driver.

In the system log there will be ongoing DASD error messages with RC: -19.

The reason is that the loop starting the ruac request only terminates when
the retry counter is decreased to 0. But in the sleep_on function there are
early exit paths that do not decrease the retry counter.

Prevent an endless loop by handling those cases separately.

Remove the unnecessary do..while loop since the sleep_on function takes
care of retries by itself.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org # 2.6.25+
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>

---
 drivers/s390/block/dasd_alias.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index b9ce93e9df89..99f86612f775 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -383,6 +383,20 @@ suborder_not_supported(struct dasd_ccw_req *cqr)
 	char msg_format;
 	char msg_no;
 
+	/*
+	 * intrc values ENODEV, ENOLINK and EPERM
+	 * will be optained from sleep_on to indicate that no
+	 * IO operation can be started
+	 */
+	if (cqr->intrc == -ENODEV)
+		return 1;
+
+	if (cqr->intrc == -ENOLINK)
+		return 1;
+
+	if (cqr->intrc == -EPERM)
+		return 1;
+
 	sense = dasd_get_sense(&cqr->irb);
 	if (!sense)
 		return 0;
@@ -447,12 +461,8 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	lcu->flags &= ~NEED_UAC_UPDATE;
 	spin_unlock_irqrestore(&lcu->lock, flags);
 
-	do {
-		rc = dasd_sleep_on(cqr);
-		if (rc && suborder_not_supported(cqr))
-			return -EOPNOTSUPP;
-	} while (rc && (cqr->retries > 0));
-	if (rc) {
+	rc = dasd_sleep_on(cqr);
+	if (rc && !suborder_not_supported(cqr)) {
 		spin_lock_irqsave(&lcu->lock, flags);
 		lcu->flags |= NEED_UAC_UPDATE;
 		spin_unlock_irqrestore(&lcu->lock, flags);
-- 
2.17.1
