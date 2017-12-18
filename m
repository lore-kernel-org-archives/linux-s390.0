From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] virtio/s390: fixup for implement PM operations for virtio_ccw
Date: Mon, 18 Dec 2017 09:37:06 +0100
Message-ID: <20171218083706.223836-1-borntraeger@de.ibm.com>
References: <201712171200.w6OAf5Jm%fengguang.wu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <201712171200.w6OAf5Jm%fengguang.wu@intel.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>, kbuild-all@01.org, kbuild test robot <fengguang.wu@intel.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We need to disable the pm callbacks if CONFIG_PM is not set.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
Cornelia, you might want to squash this into the original commit.

 drivers/s390/virtio/virtio_ccw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 330b3fa3430a..985184ebda45 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1315,6 +1315,7 @@ static struct ccw_device_id virtio_ids[] = {
 	{},
 };
 
+#ifdef CONFIG_PM_SLEEP
 static int virtio_ccw_freeze(struct ccw_device *cdev)
 {
 	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
@@ -1333,6 +1334,7 @@ static int virtio_ccw_restore(struct ccw_device *cdev)
 
 	return virtio_device_restore(&vcdev->vdev);
 }
+#endif
 
 static struct ccw_driver virtio_ccw_driver = {
 	.driver = {
@@ -1346,9 +1348,11 @@ static struct ccw_driver virtio_ccw_driver = {
 	.set_online = virtio_ccw_online,
 	.notify = virtio_ccw_cio_notify,
 	.int_class = IRQIO_VIR,
+#ifdef CONFIG_PM_SLEEP
 	.freeze = virtio_ccw_freeze,
 	.thaw = virtio_ccw_restore,
 	.restore = virtio_ccw_restore,
+#endif
 };
 
 static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
-- 
2.13.4
