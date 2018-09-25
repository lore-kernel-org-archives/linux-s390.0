From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH v2 2/2] virtio/s390: fix race in ccw_io_helper()
Date: Tue, 25 Sep 2018 14:13:09 +0200
Message-ID: <20180925121309.58524-3-pasic@linux.ibm.com>
References: <20180925121309.58524-1-pasic@linux.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180925121309.58524-1-pasic@linux.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

While ccw_io_helper() seems like intended to be exclusive in a sense that
it is supposed to facilitate I/O for at most one thread at any given
time, there is actually nothing ensuring that threads won't pile up at
vcdev->wait_q. If they do, all threads get woken up and see the status
that belongs to some other request than their own. This can lead to bugs.
For an example see:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432

This race normally does not cause any problems. The operations provided
by struct virtio_config_ops are usually invoked in a well defined
sequence, normally don't fail, and are normally used quite infrequent
too.

Yet, if some of the these operations are directly triggered via sysfs
attributes, like in the case described by the referenced bug, userspace
is given an opportunity to force races by increasing the frequency of the
given operations.

Let us fix the problem by ensuring, that for each device, we finish
processing the previous request before starting with a new one.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Cc: stable@vger.kernel.org
---
 drivers/s390/virtio/virtio_ccw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index a5e8530a3391..b67dc4974f23 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -56,6 +56,7 @@ struct virtio_ccw_device {
 	unsigned int revision; /* Transport revision */
 	wait_queue_head_t wait_q;
 	spinlock_t lock;
+	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
 	unsigned long indicators;
 	unsigned long indicators2;
@@ -296,6 +297,7 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
 	unsigned long flags;
 	int flag = intparm & VIRTIO_CCW_INTPARM_MASK;
 
+	mutex_lock(&vcdev->io_lock);
 	do {
 		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
 		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
@@ -308,7 +310,9 @@ static int ccw_io_helper(struct virtio_ccw_device *vcdev,
 		cpu_relax();
 	} while (ret == -EBUSY);
 	wait_event(vcdev->wait_q, doing_io(vcdev, flag) == 0);
-	return ret ? ret : vcdev->err;
+	ret = ret ? ret : vcdev->err;
+	mutex_unlock(&vcdev->io_lock);
+	return ret;
 }
 
 static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
@@ -1253,6 +1257,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	init_waitqueue_head(&vcdev->wait_q);
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
+	mutex_init(&vcdev->io_lock);
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, vcdev);
-- 
2.16.4
