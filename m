Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v3 1/3] dasd: refactor dasd_ioctl_information
Date: Fri,  8 May 2020 15:14:53 +0200
Message-Id: <20200508131455.55407-2-sth@linux.ibm.com>
In-Reply-To: <20200508131455.55407-1-sth@linux.ibm.com>
References: <20200508131455.55407-1-sth@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: hch@lst.de
Cc: axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

From: Christoph Hellwig <hch@lst.de>

Prepare for in-kernel callers of this functionality.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_ioctl.c | 38 +++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 9a5f3add325f..dabcb4ce92da 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -457,10 +457,9 @@ static int dasd_ioctl_read_profile(struct dasd_block *block, void __user *argp)
 /*
  * Return dasd information. Used for BIODASDINFO and BIODASDINFO2.
  */
-static int dasd_ioctl_information(struct dasd_block *block,
-				  unsigned int cmd, void __user *argp)
+static int __dasd_ioctl_information(struct dasd_block *block,
+		struct dasd_information2_t *dasd_info)
 {
-	struct dasd_information2_t *dasd_info;
 	struct subchannel_id sch_id;
 	struct ccw_dev_id dev_id;
 	struct dasd_device *base;
@@ -473,10 +472,6 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	if (!base->discipline || !base->discipline->fill_info)
 		return -EINVAL;
 
-	dasd_info = kzalloc(sizeof(struct dasd_information2_t), GFP_KERNEL);
-	if (dasd_info == NULL)
-		return -ENOMEM;
-
 	rc = base->discipline->fill_info(base, dasd_info);
 	if (rc) {
 		kfree(dasd_info);
@@ -520,15 +515,24 @@ static int dasd_ioctl_information(struct dasd_block *block,
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
 	spin_unlock_irqrestore(&block->queue_lock, flags);
+	return 0;
+}
 
-	rc = 0;
-	if (copy_to_user(argp, dasd_info,
-			 ((cmd == (unsigned int) BIODASDINFO2) ?
-			  sizeof(struct dasd_information2_t) :
-			  sizeof(struct dasd_information_t))))
-		rc = -EFAULT;
+static int dasd_ioctl_information(struct dasd_block *block, void __user *argp,
+		size_t copy_size)
+{
+	struct dasd_information2_t *dasd_info;
+	int error = 0;
+
+	dasd_info = kzalloc(sizeof(*dasd_info), GFP_KERNEL);
+	if (!dasd_info)
+		return -ENOMEM;
+
+	error = __dasd_ioctl_information(block, dasd_info);
+	if (!error && copy_to_user(argp, dasd_info, copy_size))
+		error = -EFAULT;
 	kfree(dasd_info);
-	return rc;
+	return error;
 }
 
 /*
@@ -622,10 +626,12 @@ int dasd_ioctl(struct block_device *bdev, fmode_t mode,
 		rc = dasd_ioctl_check_format(bdev, argp);
 		break;
 	case BIODASDINFO:
-		rc = dasd_ioctl_information(block, cmd, argp);
+		rc = dasd_ioctl_information(block, argp,
+				sizeof(struct dasd_information_t));
 		break;
 	case BIODASDINFO2:
-		rc = dasd_ioctl_information(block, cmd, argp);
+		rc = dasd_ioctl_information(block, argp,
+				sizeof(struct dasd_information2_t));
 		break;
 	case BIODASDPRRD:
 		rc = dasd_ioctl_read_profile(block, argp);
-- 
2.17.1
