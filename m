Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 01/12] virtio/s390: use vring_create_virtqueue
Date: Fri,  5 Apr 2019 01:16:11 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-2-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The commit 2a2d1382fe9d ("virtio: Add improved queue allocation API")
establishes a new way of allocating virtqueues (as a part of the effort
that taught DMA to virtio rings).

In the future we will want virtio-ccw to use the DMA API as well.

Let us switch from the legacy method of allocating virtqueues to
vring_create_virtqueue() as the first step into that direction.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 74c328321889..edf4afe2d688 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -108,7 +108,6 @@ struct virtio_rev_info {
 struct virtio_ccw_vq_info {
 	struct virtqueue *vq;
 	int num;
-	void *queue;
 	union {
 		struct vq_info_block s;
 		struct vq_info_block_legacy l;
@@ -423,7 +422,6 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
 	struct virtio_ccw_device *vcdev = to_vc_device(vq->vdev);
 	struct virtio_ccw_vq_info *info = vq->priv;
 	unsigned long flags;
-	unsigned long size;
 	int ret;
 	unsigned int index = vq->index;
 
@@ -461,8 +459,6 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
 			 ret, index);
 
 	vring_del_virtqueue(vq);
-	size = PAGE_ALIGN(vring_size(info->num, KVM_VIRTIO_CCW_RING_ALIGN));
-	free_pages_exact(info->queue, size);
 	kfree(info->info_block);
 	kfree(info);
 }
@@ -494,7 +490,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	int err;
 	struct virtqueue *vq = NULL;
 	struct virtio_ccw_vq_info *info;
-	unsigned long size = 0; /* silence the compiler */
+	u64 queue;
 	unsigned long flags;
 
 	/* Allocate queue. */
@@ -516,17 +512,10 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		err = info->num;
 		goto out_err;
 	}
-	size = PAGE_ALIGN(vring_size(info->num, KVM_VIRTIO_CCW_RING_ALIGN));
-	info->queue = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
-	if (info->queue == NULL) {
-		dev_warn(&vcdev->cdev->dev, "no queue\n");
-		err = -ENOMEM;
-		goto out_err;
-	}
+	vq = vring_create_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN,
+				    vdev, true, true, ctx,
+				    virtio_ccw_kvm_notify, callback, name);
 
-	vq = vring_new_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN, vdev,
-				 true, ctx, info->queue, virtio_ccw_kvm_notify,
-				 callback, name);
 	if (!vq) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
@@ -534,15 +523,17 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		goto out_err;
 	}
 
+
 	/* Register it with the host. */
+	queue = virtqueue_get_desc_addr(vq);
 	if (vcdev->revision == 0) {
-		info->info_block->l.queue = (__u64)info->queue;
+		info->info_block->l.queue = queue;
 		info->info_block->l.align = KVM_VIRTIO_CCW_RING_ALIGN;
 		info->info_block->l.index = i;
 		info->info_block->l.num = info->num;
 		ccw->count = sizeof(info->info_block->l);
 	} else {
-		info->info_block->s.desc = (__u64)info->queue;
+		info->info_block->s.desc = queue;
 		info->info_block->s.index = i;
 		info->info_block->s.num = info->num;
 		info->info_block->s.avail = (__u64)virtqueue_get_avail(vq);
@@ -572,8 +563,6 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	if (vq)
 		vring_del_virtqueue(vq);
 	if (info) {
-		if (info->queue)
-			free_pages_exact(info->queue, size);
 		kfree(info->info_block);
 	}
 	kfree(info);
-- 
2.16.4
