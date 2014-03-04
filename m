From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 6/8] virtio_ccw: fix vcdev pointer handling issues
Date: Tue,  4 Mar 2014 12:27:16 +0100
Message-ID: <1393932438-58848-7-git-send-email-borntraeger@de.ibm.com>
References: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1393932438-58848-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heinz Graalfs <graalfs@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>

The interrupt handler virtio_ccw_int_handler() using the vcdev pointer
is protected by the ccw_device lock. Resetting the pointer within the
ccw_device structure should be done when holding this lock.

Also resetting the vcdev pointer (under the ccw_device lock) prior to
freeing the vcdev pointer memory removes a critical path.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 0fc5848..413c630 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -636,6 +636,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 	struct virtqueue *vq;
 	struct virtio_driver *drv;
 
+	if (!vcdev)
+		return;
 	/* Check if it's a notification from the host. */
 	if ((intparm == 0) &&
 	    (scsw_stctl(&irb->scsw) ==
@@ -734,23 +736,37 @@ static int virtio_ccw_probe(struct ccw_device *cdev)
 	return 0;
 }
 
+static struct virtio_ccw_device *virtio_grab_drvdata(struct ccw_device *cdev)
+{
+	unsigned long flags;
+	struct virtio_ccw_device *vcdev;
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	vcdev = dev_get_drvdata(&cdev->dev);
+	if (!vcdev) {
+		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+		return NULL;
+	}
+	dev_set_drvdata(&cdev->dev, NULL);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	return vcdev;
+}
+
 static void virtio_ccw_remove(struct ccw_device *cdev)
 {
-	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	if (cdev->online) {
+	if (vcdev && cdev->online)
 		unregister_virtio_device(&vcdev->vdev);
-		dev_set_drvdata(&cdev->dev, NULL);
-	}
 	cdev->handler = NULL;
 }
 
 static int virtio_ccw_offline(struct ccw_device *cdev)
 {
-	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	unregister_virtio_device(&vcdev->vdev);
-	dev_set_drvdata(&cdev->dev, NULL);
+	if (vcdev)
+		unregister_virtio_device(&vcdev->vdev);
 	return 0;
 }
 
@@ -759,6 +775,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 {
 	int ret;
 	struct virtio_ccw_device *vcdev;
+	unsigned long flags;
 
 	vcdev = kzalloc(sizeof(*vcdev), GFP_KERNEL);
 	if (!vcdev) {
@@ -786,7 +803,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
 
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, vcdev);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	vcdev->vdev.id.vendor = cdev->id.cu_type;
 	vcdev->vdev.id.device = cdev->id.cu_model;
 	ret = register_virtio_device(&vcdev->vdev);
@@ -797,7 +816,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	}
 	return 0;
 out_put:
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, NULL);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	put_device(&vcdev->vdev.dev);
 	return ret;
 out_free:
-- 
1.8.4.2
