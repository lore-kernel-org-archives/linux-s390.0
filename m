From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 1/1] virtio_ccw: fix hang in set offline processing
Date: Thu,  6 Mar 2014 10:35:51 +0100
Message-ID: <1394098551-20023-2-git-send-email-cornelia.huck@de.ibm.com>
References: <1394098551-20023-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1394098551-20023-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

During set offline processing virtio_grab_drvdata() incorrectly
calls dev_set_drvdata() to remove the virtio_ccw_device from the
parent ccw_device's driver data. This is wrong and ends up in a
hang during virtio_ccw_reset(), as the interrupt handler still
has need of the virtio_ccw_device.

A new field 'going_away' is introduced in struct virtio_ccw_device
to control the usage of the ccw_device's driver data pointer in
virtio_grab_drvdata().

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 6a2b5fd..1e1fc67 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -61,6 +61,7 @@ struct virtio_ccw_device {
 	unsigned long indicators2;
 	struct vq_config_block *config_block;
 	bool is_thinint;
+	bool going_away;
 	void *airq_info;
 };
 
@@ -995,30 +996,39 @@ static struct virtio_ccw_device *virtio_grab_drvdata(struct ccw_device *cdev)
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	vcdev = dev_get_drvdata(&cdev->dev);
-	if (!vcdev) {
+	if (!vcdev || vcdev->going_away) {
 		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 		return NULL;
 	}
-	dev_set_drvdata(&cdev->dev, NULL);
+	vcdev->going_away = true;
 	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	return vcdev;
 }
 
 static void virtio_ccw_remove(struct ccw_device *cdev)
 {
+	unsigned long flags;
 	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
 	if (vcdev && cdev->online)
 		unregister_virtio_device(&vcdev->vdev);
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	dev_set_drvdata(&cdev->dev, NULL);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	cdev->handler = NULL;
 }
 
 static int virtio_ccw_offline(struct ccw_device *cdev)
 {
+	unsigned long flags;
 	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	if (vcdev)
+	if (vcdev) {
 		unregister_virtio_device(&vcdev->vdev);
+		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+		dev_set_drvdata(&cdev->dev, NULL);
+		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	}
 	return 0;
 }
 
-- 
1.7.9.5
