Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 09/12] virtio/s390: use DMA memory for notifiers
Date: Fri,  5 Apr 2019 01:16:19 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-10-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

The hypervisor is supposed to poke the classic notifiers, if these are
used, out of band with regards to ccw I/O. So these need to be allocated
as DMA memory (which is shared memory for protected virtualization
guests).

Let us factor out notifiers in a satellite that is allocated as DMA
memory to accommodate that.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 156166ae4df4..aa45a6a027ae 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -46,6 +46,11 @@ struct vq_config_block {
 #define VIRTIO_CCW_CONFIG_SIZE 0x100
 /* same as PCI config space size, should be enough for all drivers */
 
+struct vcdev_dma_area {
+	unsigned long indicators;
+	unsigned long indicators2;
+};
+
 struct virtio_ccw_device {
 	struct virtio_device vdev;
 	__u8 *status;
@@ -59,8 +64,6 @@ struct virtio_ccw_device {
 	spinlock_t lock;
 	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
-	unsigned long indicators;
-	unsigned long indicators2;
 	struct vq_config_block *config_block;
 	dma_addr_t config_block_dma_addr;
 	bool is_thinint;
@@ -69,16 +72,18 @@ struct virtio_ccw_device {
 	unsigned int config_ready;
 	void *airq_info;
 	__u64 dma_mask;
+	struct vcdev_dma_area *dma_area;
+	dma_addr_t dma_area_dma_addr;
 };
 
 static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
 {
-	return &vcdev->indicators;
+	return &vcdev->dma_area->indicators;
 }
 
 static inline unsigned long *indicators2(struct virtio_ccw_device *vcdev)
 {
-	return &vcdev->indicators2;
+	return &vcdev->dma_area->indicators2;
 }
 
 struct vq_info_block_legacy {
@@ -1044,6 +1049,8 @@ static void virtio_ccw_release_dev(struct device *_d)
 
 	vc_dma_free_struct(dev, vcdev->status);
 	vc_dma_free_struct(dev, vcdev->config_block);
+	__vc_dma_free(&vcdev->vdev, PAGE_SIZE, vcdev->dma_area,
+		      vcdev->dma_area_dma_addr);
 	kfree(vcdev);
 }
 
@@ -1325,6 +1332,12 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 		ret = -ENOMEM;
 		goto out_free;
 	}
+	vcdev->dma_area = __vc_dma_alloc(&vcdev->vdev, PAGE_SIZE,
+					 &vcdev->dma_area_dma_addr);
+	if (!vcdev->dma_area) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
 
 	vcdev->is_thinint = virtio_ccw_use_airq; /* at least try */
 
@@ -1363,6 +1376,8 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	if (vcdev) {
 		vc_dma_free_struct(&vcdev->vdev, vcdev->status);
 		vc_dma_free_struct(&vcdev->vdev, vcdev->config_block);
+		__vc_dma_free(&vcdev->vdev, PAGE_SIZE, vcdev->dma_area,
+			      vcdev->dma_area_dma_addr);
 	}
 	kfree(vcdev);
 	return ret;
-- 
2.16.4
