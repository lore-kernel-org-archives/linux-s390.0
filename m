Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30565 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728750AbgEZJgh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 05:36:37 -0400
From: Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH] s390/virtio: remove unused pm callbacks
Date: Tue, 26 May 2020 11:36:29 +0200
Message-Id: <20200526093629.257649-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>

Support for hibernation on s390 has been recently been removed with
commit 394216275c7d ("s390: remove broken hibernate / power management
support"), no need to keep unused code around.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 957889a42d2e..5730572b52cd 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1372,27 +1372,6 @@ static struct ccw_device_id virtio_ids[] = {
 	{},
 };
 
-#ifdef CONFIG_PM_SLEEP
-static int virtio_ccw_freeze(struct ccw_device *cdev)
-{
-	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
-
-	return virtio_device_freeze(&vcdev->vdev);
-}
-
-static int virtio_ccw_restore(struct ccw_device *cdev)
-{
-	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
-	int ret;
-
-	ret = virtio_ccw_set_transport_rev(vcdev);
-	if (ret)
-		return ret;
-
-	return virtio_device_restore(&vcdev->vdev);
-}
-#endif
-
 static struct ccw_driver virtio_ccw_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
@@ -1405,11 +1384,6 @@ static struct ccw_driver virtio_ccw_driver = {
 	.set_online = virtio_ccw_online,
 	.notify = virtio_ccw_cio_notify,
 	.int_class = IRQIO_VIR,
-#ifdef CONFIG_PM_SLEEP
-	.freeze = virtio_ccw_freeze,
-	.thaw = virtio_ccw_restore,
-	.restore = virtio_ccw_restore,
-#endif
 };
 
 static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
-- 
2.25.4
