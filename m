Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 10/12] virtio/s390: consolidate DMA allocations
Date: Fri,  5 Apr 2019 01:16:20 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-11-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

We can reduce the number of DMA allocations by pulling the bits
of memory that belongs to virtio_ccw_device and needs to be DMA
memory into a single area.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 48 ++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index aa45a6a027ae..7268149f2ee8 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -49,12 +49,12 @@ struct vq_config_block {
 struct vcdev_dma_area {
 	unsigned long indicators;
 	unsigned long indicators2;
+	struct vq_config_block config_block;
+	__u8 status; /* TODO check __aligned(8); */
 };
 
 struct virtio_ccw_device {
 	struct virtio_device vdev;
-	__u8 *status;
-	dma_addr_t status_dma_addr;
 	__u8 config[VIRTIO_CCW_CONFIG_SIZE];
 	struct ccw_device *cdev;
 	__u32 curr_io;
@@ -64,8 +64,6 @@ struct virtio_ccw_device {
 	spinlock_t lock;
 	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
-	struct vq_config_block *config_block;
-	dma_addr_t config_block_dma_addr;
 	bool is_thinint;
 	bool going_away;
 	bool device_lost;
@@ -450,15 +448,15 @@ static int virtio_ccw_read_vq_conf(struct virtio_ccw_device *vcdev,
 {
 	int ret;
 
-	vcdev->config_block->index = index;
+	vcdev->dma_area->config_block.index = index;
 	ccw->cmd_code = CCW_CMD_READ_VQ_CONF;
 	ccw->flags = 0;
 	ccw->count = sizeof(struct vq_config_block);
-	ccw->cda = (__u32)(unsigned long)(vcdev->config_block);
+	ccw->cda = (__u32)(unsigned long)(&vcdev->dma_area->config_block);
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_VQ_CONF);
 	if (ret)
 		return ret;
-	return vcdev->config_block->num ?: -ENOENT;
+	return vcdev->dma_area->config_block.num ?: -ENOENT;
 }
 
 static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
@@ -754,7 +752,7 @@ static void virtio_ccw_reset(struct virtio_device *vdev)
 		return;
 
 	/* Zero status bits. */
-	*vcdev->status = 0;
+	vcdev->dma_area->status = 0;
 
 	/* Send a reset ccw on device. */
 	ccw->cmd_code = CCW_CMD_VDEV_RESET;
@@ -967,11 +965,11 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	u8 old_status = *vcdev->status;
+	u8 old_status = vcdev->dma_area->status;
 	vc_dma_decl_struct(ccw1, ccw);
 
 	if (vcdev->revision < 1)
-		return *vcdev->status;
+		return vcdev->dma_area->status;
 
 	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
@@ -979,24 +977,24 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 
 	ccw->cmd_code = CCW_CMD_READ_STATUS;
 	ccw->flags = 0;
-	ccw->count = sizeof(*vcdev->status);
-	ccw->cda = (__u32)(unsigned long)vcdev->status;
+	ccw->count = sizeof(vcdev->dma_area->status);
+	ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_READ_STATUS);
 /*
  * If the channel program failed (should only happen if the device
  * was hotunplugged, and then we clean up via the machine check
- * handler anyway), vcdev->status was not overwritten and we just
+ * handler anyway), vcdev->dma_area->status was not overwritten and we just
  * return the old status, which is fine.
 */
 	vc_dma_free_struct(vdev, ccw);
 
-	return *vcdev->status;
+	return vcdev->dma_area->status;
 }
 
 static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	u8 old_status = *vcdev->status;
+	u8 old_status = vcdev->dma_area->status;
 	vc_dma_decl_struct(ccw1, ccw);
 	int ret;
 
@@ -1005,15 +1003,15 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 		return;
 
 	/* Write the status to the host. */
-	*vcdev->status = status;
+	vcdev->dma_area->status = status;
 	ccw->cmd_code = CCW_CMD_WRITE_STATUS;
 	ccw->flags = 0;
 	ccw->count = sizeof(status);
-	ccw->cda = (__u32)(unsigned long)vcdev->status;
+	ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
 	/* Write failed? We assume status is unchanged. */
 	if (ret)
-		*vcdev->status = old_status;
+		vcdev->dma_area->status = old_status;
 	vc_dma_free_struct(vdev, ccw);
 }
 
@@ -1047,8 +1045,6 @@ static void virtio_ccw_release_dev(struct device *_d)
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_ccw_device *vcdev = to_vc_device(dev);
 
-	vc_dma_free_struct(dev, vcdev->status);
-	vc_dma_free_struct(dev, vcdev->config_block);
 	__vc_dma_free(&vcdev->vdev, PAGE_SIZE, vcdev->dma_area,
 		      vcdev->dma_area_dma_addr);
 	kfree(vcdev);
@@ -1322,16 +1318,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 		goto out_free;
 	}
 
-	vc_dma_alloc_struct(&vcdev->vdev, vcdev->config_block);
-	if (!vcdev->config_block) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
-	vc_dma_alloc_struct(&vcdev->vdev, vcdev->status);
-	if (!vcdev->status) {
-		ret = -ENOMEM;
-		goto out_free;
-	}
 	vcdev->dma_area = __vc_dma_alloc(&vcdev->vdev, PAGE_SIZE,
 					 &vcdev->dma_area_dma_addr);
 	if (!vcdev->dma_area) {
@@ -1374,8 +1360,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	return ret;
 out_free:
 	if (vcdev) {
-		vc_dma_free_struct(&vcdev->vdev, vcdev->status);
-		vc_dma_free_struct(&vcdev->vdev, vcdev->config_block);
 		__vc_dma_free(&vcdev->vdev, PAGE_SIZE, vcdev->dma_area,
 			      vcdev->dma_area_dma_addr);
 	}
-- 
2.16.4
