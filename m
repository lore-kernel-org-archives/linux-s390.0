From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/3] s390/virtio-ccw: Fix setup_vq error handling.
Date: Fri, 25 Jan 2013 15:34:16 +0100
Message-ID: <1359124457-51126-3-git-send-email-borntraeger@de.ibm.com>
References: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

virtio_ccw_setup_vq() failed to unwind correctly on errors. In
particular, it failed to delete the virtqueue on errors, leading to
list corruption when virtio_ccw_del_vqs() iterated over a virtqueue
that had not been added to the vcdev's list.

Fix this with redoing the error unwinding in virtio_ccw_setup_vq(),
using a single path for all errors.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 2edd94a..3217dfe 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -244,9 +244,9 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	int err;
-	struct virtqueue *vq;
+	struct virtqueue *vq = NULL;
 	struct virtio_ccw_vq_info *info;
-	unsigned long size;
+	unsigned long size = 0; /* silence the compiler */
 	unsigned long flags;
 
 	/* Allocate queue. */
@@ -279,11 +279,8 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
 		err = -ENOMEM;
-		free_pages_exact(info->queue, size);
 		goto out_err;
 	}
-	info->vq = vq;
-	vq->priv = info;
 
 	/* Register it with the host. */
 	info->info_block->queue = (__u64)info->queue;
@@ -297,12 +294,12 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	err = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_VQ | i);
 	if (err) {
 		dev_warn(&vcdev->cdev->dev, "SET_VQ failed\n");
-		free_pages_exact(info->queue, size);
-		info->vq = NULL;
-		vq->priv = NULL;
 		goto out_err;
 	}
 
+	info->vq = vq;
+	vq->priv = info;
+
 	/* Save it to our list. */
 	spin_lock_irqsave(&vcdev->lock, flags);
 	list_add(&info->node, &vcdev->virtqueues);
@@ -311,8 +308,13 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	return vq;
 
 out_err:
-	if (info)
+	if (vq)
+		vring_del_virtqueue(vq);
+	if (info) {
+		if (info->queue)
+			free_pages_exact(info->queue, size);
 		kfree(info->info_block);
+	}
 	kfree(info);
 	return ERR_PTR(err);
 }
-- 
1.7.12.4
