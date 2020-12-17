Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728127AbgLQP7y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 10:59:54 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 2/4] s390/dasd: prevent inconsistent LCU device data
Date: Thu, 17 Dec 2020 16:59:05 +0100
Message-Id: <20201217155907.36436-3-sth@linux.ibm.com>
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Prevent _lcu_update from adding a device to a pavgroup if the LCU still
requires an update. The data is not reliable any longer and in parallel
devices might have been moved on the lists already.
This might lead to list corruptions or invalid PAV grouping.
Only add devices to a pavgroup if the LCU is up to date. Additional steps
are taken by the scheduled lcu update.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 31e8b5d48e86..f841518de6c5 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -511,6 +511,14 @@ static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
 		return rc;
 
 	spin_lock_irqsave(&lcu->lock, flags);
+	/*
+	 * there is another update needed skip the remaining handling
+	 * the data might already be outdated
+	 * but especially do not add the device to an LCU with pending
+	 * update
+	 */
+	if (lcu->flags & NEED_UAC_UPDATE)
+		goto out;
 	lcu->pav = NO_PAV;
 	for (i = 0; i < MAX_DEVICES_PER_LCU; ++i) {
 		switch (lcu->uac->unit[i].ua_type) {
@@ -529,6 +537,7 @@ static int _lcu_update(struct dasd_device *refdev, struct alias_lcu *lcu)
 				 alias_list) {
 		_add_device_to_lcu(lcu, device, refdev);
 	}
+out:
 	spin_unlock_irqrestore(&lcu->lock, flags);
 	return 0;
 }
-- 
2.17.1
