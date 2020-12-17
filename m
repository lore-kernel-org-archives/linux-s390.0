Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbgLQQBJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 17 Dec 2020 11:01:09 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 4/4] s390/dasd: fix list corruption of lcu list
Date: Thu, 17 Dec 2020 16:59:07 +0100
Message-Id: <20201217155907.36436-5-sth@linux.ibm.com>
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

In dasd_alias_disconnect_device_from_lcu the device is removed from any
list on the LCU. Afterwards the LCU is removed from the lcu list if it
does not contain devices any longer.

The lcu->lock protects the lcu from parallel updates. But to cancel all
workers and wait for completion the lcu->lock has to be unlocked.

If two devices are removed in parallel and both are removed from the LCU
the first device that takes the lcu->lock again will delete the LCU because
it is already empty but the second device also tries to free the LCU which
leads to a list corruption of the lcu list.

Fix by removing the device right before the lcu is checked without
unlocking the lcu->lock in between.

Fixes: 8e09f21574ea ("[S390] dasd: add hyper PAV support to DASD device driver, part 1")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_alias.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index 60344e13e87b..dc78a523a69f 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -256,7 +256,6 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
 		return;
 	device->discipline->get_uid(device, &uid);
 	spin_lock_irqsave(&lcu->lock, flags);
-	list_del_init(&device->alias_list);
 	/* make sure that the workers don't use this device */
 	if (device == lcu->suc_data.device) {
 		spin_unlock_irqrestore(&lcu->lock, flags);
@@ -283,6 +282,7 @@ void dasd_alias_disconnect_device_from_lcu(struct dasd_device *device)
 
 	spin_lock_irqsave(&aliastree.lock, flags);
 	spin_lock(&lcu->lock);
+	list_del_init(&device->alias_list);
 	if (list_empty(&lcu->grouplist) &&
 	    list_empty(&lcu->active_devices) &&
 	    list_empty(&lcu->inactive_devices)) {
-- 
2.17.1
