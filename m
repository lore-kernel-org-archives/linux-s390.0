Return-Path: <SRS0=JTmC=S4=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 02/10] virtio/s390: DMA support for virtio-ccw
Date: Fri, 26 Apr 2019 20:32:37 +0200
In-Reply-To: <20190426183245.37939-1-pasic@linux.ibm.com>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
Message-Id: <20190426183245.37939-3-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Christoph Hellwig <hch@infradead.org>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Currently virtio-ccw devices do not work if the device has
VIRTIO_F_IOMMU_PLATFORM. In future we do want to support DMA API with
virtio-ccw.

Let us do the plumbing, so the feature VIRTIO_F_IOMMU_PLATFORM works
with virtio-ccw.

Let us also switch from legacy avail/used accessors to the DMA aware
ones (even if it isn't strictly necessary), and remove the legacy
accessors (we were the last users).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 22 +++++++++++++++-------
 include/linux/virtio.h           | 17 -----------------
 2 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 2c66941ef3d0..42832a164546 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -66,6 +66,7 @@ struct virtio_ccw_device {
 	bool device_lost;
 	unsigned int config_ready;
 	void *airq_info;
+	u64 dma_mask;
 };
 
 struct vq_info_block_legacy {
@@ -539,8 +540,8 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		info->info_block->s.desc = queue;
 		info->info_block->s.index = i;
 		info->info_block->s.num = info->num;
-		info->info_block->s.avail = (__u64)virtqueue_get_avail(vq);
-		info->info_block->s.used = (__u64)virtqueue_get_used(vq);
+		info->info_block->s.avail = (__u64)virtqueue_get_avail_addr(vq);
+		info->info_block->s.used = (__u64)virtqueue_get_used_addr(vq);
 		ccw->count = sizeof(info->info_block->s);
 	}
 	ccw->cmd_code = CCW_CMD_SET_VQ;
@@ -772,10 +773,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 static void ccw_transport_features(struct virtio_device *vdev)
 {
 	/*
-	 * Packed ring isn't enabled on virtio_ccw for now,
-	 * because virtio_ccw uses some legacy accessors,
-	 * e.g. virtqueue_get_avail() and virtqueue_get_used()
-	 * which aren't available in packed ring currently.
+	 * There shouldn't be anything that precludes supporting packed.
+	 * TODO: Remove the limitation after having another look into this.
 	 */
 	__virtio_clear_bit(vdev, VIRTIO_F_RING_PACKED);
 }
@@ -1258,6 +1257,16 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 		ret = -ENOMEM;
 		goto out_free;
 	}
+
+	vcdev->vdev.dev.parent = &cdev->dev;
+	cdev->dev.dma_mask = &vcdev->dma_mask;
+	/* we are fine with common virtio infrastructure using 64 bit DMA */
+	ret = dma_set_mask_and_coherent(&cdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_warn(&cdev->dev, "Failed to enable 64-bit DMA.\n");
+		goto out_free;
+	}
+
 	vcdev->config_block = kzalloc(sizeof(*vcdev->config_block),
 				   GFP_DMA | GFP_KERNEL);
 	if (!vcdev->config_block) {
@@ -1272,7 +1281,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 
 	vcdev->is_thinint = virtio_ccw_use_airq; /* at least try */
 
-	vcdev->vdev.dev.parent = &cdev->dev;
 	vcdev->vdev.dev.release = virtio_ccw_release_dev;
 	vcdev->vdev.config = &virtio_ccw_config_ops;
 	vcdev->cdev = cdev;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 673fe3ef3607..15f906e4a748 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -90,23 +90,6 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 
-/*
- * Legacy accessors -- in almost all cases, these are the wrong functions
- * to use.
- */
-static inline void *virtqueue_get_desc(struct virtqueue *vq)
-{
-	return virtqueue_get_vring(vq)->desc;
-}
-static inline void *virtqueue_get_avail(struct virtqueue *vq)
-{
-	return virtqueue_get_vring(vq)->avail;
-}
-static inline void *virtqueue_get_used(struct virtqueue *vq)
-{
-	return virtqueue_get_vring(vq)->used;
-}
-
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
2.16.4
