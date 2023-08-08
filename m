Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1717C04E69
	for <linux-s390@archiver.kernel.org>; Tue,  8 Aug 2023 18:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbjHHSnP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjHHSmj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Aug 2023 14:42:39 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196F6EB3A3
        for <linux-s390@vger.kernel.org>; Tue,  8 Aug 2023 09:35:03 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKtS23njLztRnq;
        Tue,  8 Aug 2023 20:54:26 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500009.china.huawei.com (7.185.36.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:57:54 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 20:57:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-s390@vger.kernel.org>
CC:     <vneethv@linux.ibm.com>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
        <agordeev@linux.ibm.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] s390: remove unnecessary dev_set_drvdata()
Date:   Tue, 8 Aug 2023 20:55:01 +0800
Message-ID: <20230808125501.566824-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver data will be cleared in device_unbind_cleanup() in driver
core code. So the dev_set_drvdata(..., NULL) called in remove and
error path in probe can be removed.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/s390/block/scm_drv.c      | 2 --
 drivers/s390/char/con3215.c       | 1 -
 drivers/s390/char/tape_core.c     | 1 -
 drivers/s390/cio/chsc_sch.c       | 2 --
 drivers/s390/cio/vfio_ccw_drv.c   | 2 --
 drivers/s390/crypto/vfio_ap_ops.c | 1 -
 6 files changed, 9 deletions(-)

diff --git a/drivers/s390/block/scm_drv.c b/drivers/s390/block/scm_drv.c
index 69a845eb8b1f..8106190032c1 100644
--- a/drivers/s390/block/scm_drv.c
+++ b/drivers/s390/block/scm_drv.c
@@ -51,7 +51,6 @@ static int scm_probe(struct scm_device *scmdev)
 	dev_set_drvdata(&scmdev->dev, bdev);
 	ret = scm_blk_dev_setup(bdev, scmdev);
 	if (ret) {
-		dev_set_drvdata(&scmdev->dev, NULL);
 		kfree(bdev);
 		goto out;
 	}
@@ -65,7 +64,6 @@ static void scm_remove(struct scm_device *scmdev)
 	struct scm_blk_dev *bdev = dev_get_drvdata(&scmdev->dev);
 
 	scm_blk_dev_cleanup(bdev);
-	dev_set_drvdata(&scmdev->dev, NULL);
 	kfree(bdev);
 }
 
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index a1fef666c9b0..b0ecc32c8241 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -743,7 +743,6 @@ static void raw3215_remove(struct ccw_device *cdev)
 				break;
 		raw3215[line] = NULL;
 		spin_unlock(&raw3215_device_lock);
-		dev_set_drvdata(&cdev->dev, NULL);
 		raw3215_free_info(raw);
 	}
 }
diff --git a/drivers/s390/char/tape_core.c b/drivers/s390/char/tape_core.c
index a6d2a4792185..7a6e1804cf8f 100644
--- a/drivers/s390/char/tape_core.c
+++ b/drivers/s390/char/tape_core.c
@@ -662,7 +662,6 @@ tape_generic_remove(struct ccw_device *cdev)
 	device = dev_get_drvdata(&cdev->dev);
 	if (device) {
 		sysfs_remove_group(&cdev->dev.kobj, &tape_attr_group);
-		dev_set_drvdata(&cdev->dev, NULL);
 		tape_put_device(device);
 	}
 }
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 180ab899289c..15ac2b489a00 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -90,7 +90,6 @@ static int chsc_subchannel_probe(struct subchannel *sch)
 	if (ret) {
 		CHSC_MSG(0, "Failed to enable 0.%x.%04x: %d\n",
 			 sch->schid.ssid, sch->schid.sch_no, ret);
-		dev_set_drvdata(&sch->dev, NULL);
 		kfree(private);
 	}
 	return ret;
@@ -102,7 +101,6 @@ static void chsc_subchannel_remove(struct subchannel *sch)
 
 	cio_disable_subchannel(sch);
 	private = dev_get_drvdata(&sch->dev);
-	dev_set_drvdata(&sch->dev, NULL);
 	if (private->request) {
 		complete(&private->request->completion);
 		put_device(&sch->dev);
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 43601816ea4e..ee05825518c2 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -202,7 +202,6 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	device_del(&parent->dev);
 out_free:
 	put_device(&parent->dev);
-	dev_set_drvdata(&sch->dev, NULL);
 	return ret;
 }
 
@@ -213,7 +212,6 @@ static void vfio_ccw_sch_remove(struct subchannel *sch)
 	mdev_unregister_parent(&parent->parent);
 
 	device_unregister(&parent->dev);
-	dev_set_drvdata(&sch->dev, NULL);
 
 	VFIO_CCW_MSG_EVENT(4, "unbound from subchannel %x.%x.%04x\n",
 			   sch->schid.cssid, sch->schid.ssid,
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2d3c3a79b687..70129135b08d 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2088,7 +2088,6 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	}
 
 	vfio_ap_mdev_reset_queue(q);
-	dev_set_drvdata(&apdev->device, NULL);
 	kfree(q);
 	release_update_locks_for_mdev(matrix_mdev);
 }
-- 
2.25.1

