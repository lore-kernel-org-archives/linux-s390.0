Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 11/12] virtio/s390: use the cio DMA pool
Date: Fri,  5 Apr 2019 01:16:21 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-12-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Lets use the cio DMA pool for DMA allocations to avoid problems with
granularity, and make things simpler and cheaper.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 54 ++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 7268149f2ee8..ba1dafe04968 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -71,7 +71,6 @@ struct virtio_ccw_device {
 	void *airq_info;
 	__u64 dma_mask;
 	struct vcdev_dma_area *dma_area;
-	dma_addr_t dma_area_dma_addr;
 };
 
 static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
@@ -128,7 +127,6 @@ struct virtio_ccw_vq_info {
 		struct vq_info_block s;
 		struct vq_info_block_legacy l;
 	} *info_block;
-	dma_addr_t info_block_dma_addr;
 	int bit_nr;
 	struct list_head node;
 	long cookie;
@@ -184,26 +182,23 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
 }
 
 #define vc_dma_decl_struct(type, field) \
-	dma_addr_t field ## _dma_addr;  \
 	struct type *field
 
-static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size,
-				   dma_addr_t *dma_handle)
+static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size)
 {
-	return dma_alloc_coherent(vdev->dev.parent, size, dma_handle,
-				  GFP_DMA | GFP_KERNEL | __GFP_ZERO);
+	return (void *) cio_dma_zalloc(size);
 }
 
 static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
-				 void *cpu_addr, dma_addr_t dma_handle)
+				 void *cpu_addr)
 {
-	dma_free_coherent(vdev->dev.parent, size, cpu_addr, dma_handle);
+	cio_dma_free(cpu_addr, size);
 }
 
 #define vc_dma_alloc_struct(vdev, ptr) \
-	({ ptr = __vc_dma_alloc(vdev, (sizeof(*(ptr))), &(ptr ## _dma_addr)); })
+	({ptr = __vc_dma_alloc(vdev, sizeof(*(ptr))); })
 #define vc_dma_free_struct(vdev, ptr) \
-	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr), (ptr ## _dma_addr))
+	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr))
 
 static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
 {
@@ -361,7 +356,6 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 	int ret;
 	unsigned long *indicatorp = NULL;
 	vc_dma_decl_struct(virtio_thinint_area, thinint_area) = NULL;
-	dma_addr_t indicatorp_dma_addr;
 	struct airq_info *airq_info = vcdev->airq_info;
 
 	if (vcdev->is_thinint) {
@@ -377,8 +371,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 	} else {
 		/* payload is the address of the indicators */
 		indicatorp = __vc_dma_alloc(&vcdev->vdev,
-					    sizeof(indicators(vcdev)),
-					    &indicatorp_dma_addr);
+					    sizeof(indicators(vcdev)));
 		if (!indicatorp)
 			return;
 		*indicatorp = 0;
@@ -400,7 +393,7 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		virtio_ccw_drop_indicators(vcdev);
 	if (indicatorp)
 		__vc_dma_free(&vcdev->vdev, sizeof(indicators(vcdev)),
-			       indicatorp, indicatorp_dma_addr);
+			       indicatorp);
 	vc_dma_free_struct(&vcdev->vdev, thinint_area);
 }
 
@@ -667,7 +660,6 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	unsigned long *indicatorp = NULL;
-	dma_addr_t indicatorp_dma_addr;
 	int ret, i, queue_idx = 0;
 	vc_dma_decl_struct(ccw1, ccw);
 
@@ -695,8 +687,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * We need a data area under 2G to communicate. Our payload is
 	 * the address of the indicators.
 	*/
-	indicatorp = __vc_dma_alloc(&vcdev->vdev, sizeof(indicators(vcdev)),
-				    &indicatorp_dma_addr);
+	indicatorp = __vc_dma_alloc(&vcdev->vdev, sizeof(indicators(vcdev)));
 	if (!indicatorp)
 		goto out;
 	*indicatorp = (unsigned long) indicators(vcdev);
@@ -730,13 +721,13 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 
 	if (indicatorp)
 		__vc_dma_free(&vcdev->vdev, sizeof(indicators(vcdev)),
-			       indicatorp, indicatorp_dma_addr);
+			       indicatorp);
 	vc_dma_free_struct(vdev, ccw);
 	return 0;
 out:
 	if (indicatorp)
 		__vc_dma_free(&vcdev->vdev, sizeof(indicators(vcdev)),
-			       indicatorp, indicatorp_dma_addr);
+			       indicatorp);
 	vc_dma_free_struct(vdev, ccw);
 	virtio_ccw_del_vqs(vdev);
 	return ret;
@@ -889,14 +880,12 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
 	vc_dma_decl_struct(ccw1, ccw);
 	void *config_area;
 	unsigned long flags;
-	dma_addr_t config_area_dma_addr;
 
 	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
-	config_area = __vc_dma_alloc(vdev, VIRTIO_CCW_CONFIG_SIZE,
-				     &config_area_dma_addr);
+	config_area = __vc_dma_alloc(vdev, VIRTIO_CCW_CONFIG_SIZE);
 	if (!config_area)
 		goto out_free;
 
@@ -918,8 +907,7 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
 		memcpy(buf, config_area + offset, len);
 
 out_free:
-	__vc_dma_free(vdev, VIRTIO_CCW_CONFIG_SIZE, config_area,
-				     config_area_dma_addr);
+	__vc_dma_free(vdev, VIRTIO_CCW_CONFIG_SIZE, config_area);
 	vc_dma_free_struct(vdev, ccw);
 }
 
@@ -931,14 +919,12 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 	vc_dma_decl_struct(ccw1, ccw);
 	void *config_area;
 	unsigned long flags;
-	dma_addr_t config_area_dma_addr;
 
 	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
-	config_area = __vc_dma_alloc(vdev, VIRTIO_CCW_CONFIG_SIZE,
-				     &config_area_dma_addr);
+	config_area = __vc_dma_alloc(vdev, VIRTIO_CCW_CONFIG_SIZE);
 	if (!config_area)
 		goto out_free;
 
@@ -957,8 +943,7 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_CONFIG);
 
 out_free:
-	__vc_dma_free(vdev, VIRTIO_CCW_CONFIG_SIZE, config_area,
-				     config_area_dma_addr);
+	__vc_dma_free(vdev, VIRTIO_CCW_CONFIG_SIZE, config_area);
 	vc_dma_free_struct(vdev, ccw);
 }
 
@@ -1045,8 +1030,7 @@ static void virtio_ccw_release_dev(struct device *_d)
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_ccw_device *vcdev = to_vc_device(dev);
 
-	__vc_dma_free(&vcdev->vdev, PAGE_SIZE, vcdev->dma_area,
-		      vcdev->dma_area_dma_addr);
+	vc_dma_free_struct(&vcdev->vdev, vcdev->dma_area);
 	kfree(vcdev);
 }
 
@@ -1318,8 +1302,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 		goto out_free;
 	}
 
-	vcdev->dma_area = __vc_dma_alloc(&vcdev->vdev, PAGE_SIZE,
-					 &vcdev->dma_area_dma_addr);
+	vc_dma_alloc_struct(&vcdev->vdev, vcdev->dma_area);
 	if (!vcdev->dma_area) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -1360,8 +1343,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	return ret;
 out_free:
 	if (vcdev) {
-		__vc_dma_free(&vcdev->vdev, PAGE_SIZE, vcdev->dma_area,
-			      vcdev->dma_area_dma_addr);
+		vc_dma_free_struct(&vcdev->vdev, vcdev->dma_area);
 	}
 	kfree(vcdev);
 	return ret;
-- 
2.16.4
