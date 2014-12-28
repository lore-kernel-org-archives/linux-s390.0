Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Aniroop Mathur <aniroop.mathur@gmail.com>
Subject: [PATCH] s390: Initialize nr_devices count variable to -1
Date: Sun, 28 Dec 2014 21:42:53 +0530
Message-Id: <1419783173-3066-1-git-send-email-aniroop.mathur@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: aniroop.mathur@gmail.com, a.mathur@samsung.com
List-ID: <linux-s390.vger.kernel.org>

From: Aniroop Mathur <a.mathur@samsung.com>

This patch initializes nr_device count variable to -1 to avoid extra
subtraction operation performed everytime scm block device is set up.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/s390/block/scm_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 76bed17..ee2bd6f 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -23,7 +23,7 @@ static int scm_major;
 static DEFINE_SPINLOCK(list_lock);
 static LIST_HEAD(inactive_requests);
 static unsigned int nr_requests = 64;
-static atomic_t nr_devices = ATOMIC_INIT(0);
+static atomic_t nr_devices = ATOMIC_INIT(-1);
 module_param(nr_requests, uint, S_IRUGO);
 MODULE_PARM_DESC(nr_requests, "Number of parallel requests.");
 
@@ -357,7 +357,7 @@ int scm_blk_dev_setup(struct scm_blk_dev *bdev, struct scm_device *scmdev)
 	int len, ret = -ENOMEM;
 	unsigned int devindex, nr_max_blk;
 
-	devindex = atomic_inc_return(&nr_devices) - 1;
+	devindex = atomic_inc_return(&nr_devices);
 	/* scma..scmz + scmaa..scmzz */
 	if (devindex > 701) {
 		ret = -ENODEV;
-- 
1.9.1
