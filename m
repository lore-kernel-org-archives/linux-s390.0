Return-Path: <SRS0=rjTT=SG=vger.kernel.org=kvm-owner@kernel.org>
From: Halil Pasic <pasic@linux.ibm.com>
Subject: [RFC PATCH 07/12] virtio/s390: use DMA memory for ccw I/O
Date: Fri,  5 Apr 2019 01:16:17 +0200
In-Reply-To: <20190404231622.52531-1-pasic@linux.ibm.com>
References: <20190404231622.52531-1-pasic@linux.ibm.com>
Message-Id: <20190404231622.52531-8-pasic@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Before virtio-ccw could get away with not using DMA API for the pieces of
memory it does ccw I/O with. With protected virtualization this has to
change, since the hypervisor needs to read and sometimes also write these
pieces of memory.

Let us make sure all ccw I/O is done through shared memory.

Note: The control blocks of I/O instructions do not need to be shared.
These are marshalled by the ultravisor.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 177 +++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 70 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 5956c9e820bb..9c412a581a50 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -49,6 +49,7 @@ struct vq_config_block {
 struct virtio_ccw_device {
 	struct virtio_device vdev;
 	__u8 *status;
+	dma_addr_t status_dma_addr;
 	__u8 config[VIRTIO_CCW_CONFIG_SIZE];
 	struct ccw_device *cdev;
 	__u32 curr_io;
@@ -61,6 +62,7 @@ struct virtio_ccw_device {
 	unsigned long indicators;
 	unsigned long indicators2;
 	struct vq_config_block *config_block;
+	dma_addr_t config_block_dma_addr;
 	bool is_thinint;
 	bool going_away;
 	bool device_lost;
@@ -113,6 +115,7 @@ struct virtio_ccw_vq_info {
 		struct vq_info_block s;
 		struct vq_info_block_legacy l;
 	} *info_block;
+	dma_addr_t info_block_dma_addr;
 	int bit_nr;
 	struct list_head node;
 	long cookie;
@@ -167,6 +170,28 @@ static struct virtio_ccw_device *to_vc_device(struct virtio_device *vdev)
 	return container_of(vdev, struct virtio_ccw_device, vdev);
 }
 
+#define vc_dma_decl_struct(type, field) \
+	dma_addr_t field ## _dma_addr;  \
+	struct type *field
+
+static inline void *__vc_dma_alloc(struct virtio_device *vdev, size_t size,
+				   dma_addr_t *dma_handle)
+{
+	return dma_alloc_coherent(vdev->dev.parent, size, dma_handle,
+				  GFP_DMA | GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline void __vc_dma_free(struct virtio_device *vdev, size_t size,
+				 void *cpu_addr, dma_addr_t dma_handle)
+{
+	dma_free_coherent(vdev->dev.parent, size, cpu_addr, dma_handle);
+}
+
+#define vc_dma_alloc_struct(vdev, ptr) \
+	({ ptr = __vc_dma_alloc(vdev, (sizeof(*(ptr))), &(ptr ## _dma_addr)); })
+#define vc_dma_free_struct(vdev, ptr) \
+	__vc_dma_free(vdev, sizeof(*(ptr)), (ptr), (ptr ## _dma_addr))
+
 static void drop_airq_indicator(struct virtqueue *vq, struct airq_info *info)
 {
 	unsigned long i, flags;
@@ -322,12 +347,12 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 {
 	int ret;
 	unsigned long *indicatorp = NULL;
-	struct virtio_thinint_area *thinint_area = NULL;
+	vc_dma_decl_struct(virtio_thinint_area, thinint_area) = NULL;
+	dma_addr_t indicatorp_dma_addr;
 	struct airq_info *airq_info = vcdev->airq_info;
 
 	if (vcdev->is_thinint) {
-		thinint_area = kzalloc(sizeof(*thinint_area),
-				       GFP_DMA | GFP_KERNEL);
+		vc_dma_alloc_struct(&vcdev->vdev, thinint_area);
 		if (!thinint_area)
 			return;
 		thinint_area->summary_indicator =
@@ -338,8 +363,9 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		ccw->cda = (__u32)(unsigned long) thinint_area;
 	} else {
 		/* payload is the address of the indicators */
-		indicatorp = kmalloc(sizeof(&vcdev->indicators),
-				     GFP_DMA | GFP_KERNEL);
+		indicatorp = __vc_dma_alloc(&vcdev->vdev,
+					    sizeof(&vcdev->indicators),
+					    &indicatorp_dma_addr);
 		if (!indicatorp)
 			return;
 		*indicatorp = 0;
@@ -359,8 +385,10 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 			 "Failed to deregister indicators (%d)\n", ret);
 	else if (vcdev->is_thinint)
 		virtio_ccw_drop_indicators(vcdev);
-	kfree(indicatorp);
-	kfree(thinint_area);
+	if (indicatorp)
+		__vc_dma_free(&vcdev->vdev, sizeof(&vcdev->indicators),
+			       indicatorp, indicatorp_dma_addr);
+	vc_dma_free_struct(&vcdev->vdev, thinint_area);
 }
 
 static inline long __do_kvm_notify(struct subchannel_id schid,
@@ -460,17 +488,17 @@ static void virtio_ccw_del_vq(struct virtqueue *vq, struct ccw1 *ccw)
 			 ret, index);
 
 	vring_del_virtqueue(vq);
-	kfree(info->info_block);
+	vc_dma_free_struct(vq->vdev, info->info_block);
 	kfree(info);
 }
 
 static void virtio_ccw_del_vqs(struct virtio_device *vdev)
 {
 	struct virtqueue *vq, *n;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
@@ -479,7 +507,7 @@ static void virtio_ccw_del_vqs(struct virtio_device *vdev)
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		virtio_ccw_del_vq(vq, ccw);
 
-	kfree(ccw);
+	vc_dma_free_struct(vdev, ccw);
 }
 
 static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
@@ -501,8 +529,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		err = -ENOMEM;
 		goto out_err;
 	}
-	info->info_block = kzalloc(sizeof(*info->info_block),
-				   GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, info->info_block);
 	if (!info->info_block) {
 		dev_warn(&vcdev->cdev->dev, "no info block\n");
 		err = -ENOMEM;
@@ -564,7 +591,7 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	if (vq)
 		vring_del_virtqueue(vq);
 	if (info) {
-		kfree(info->info_block);
+		vc_dma_free_struct(vdev, info->info_block);
 	}
 	kfree(info);
 	return ERR_PTR(err);
@@ -575,10 +602,10 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 					   struct ccw1 *ccw)
 {
 	int ret;
-	struct virtio_thinint_area *thinint_area = NULL;
+	vc_dma_decl_struct(virtio_thinint_area, thinint_area) = NULL;
 	struct airq_info *info;
 
-	thinint_area = kzalloc(sizeof(*thinint_area), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(&vcdev->vdev, thinint_area);
 	if (!thinint_area) {
 		ret = -ENOMEM;
 		goto out;
@@ -614,7 +641,7 @@ static int virtio_ccw_register_adapter_ind(struct virtio_ccw_device *vcdev,
 		virtio_ccw_drop_indicators(vcdev);
 	}
 out:
-	kfree(thinint_area);
+	vc_dma_free_struct(&vcdev->vdev, thinint_area);
 	return ret;
 }
 
@@ -627,10 +654,11 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	unsigned long *indicatorp = NULL;
+	dma_addr_t indicatorp_dma_addr;
 	int ret, i, queue_idx = 0;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return -ENOMEM;
 
@@ -654,7 +682,8 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * We need a data area under 2G to communicate. Our payload is
 	 * the address of the indicators.
 	*/
-	indicatorp = kmalloc(sizeof(&vcdev->indicators), GFP_DMA | GFP_KERNEL);
+	indicatorp = __vc_dma_alloc(&vcdev->vdev, sizeof(&vcdev->indicators),
+				    &indicatorp_dma_addr);
 	if (!indicatorp)
 		goto out;
 	*indicatorp = (unsigned long) &vcdev->indicators;
@@ -686,12 +715,16 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	if (ret)
 		goto out;
 
-	kfree(indicatorp);
-	kfree(ccw);
+	if (indicatorp)
+		__vc_dma_free(&vcdev->vdev, sizeof(&vcdev->indicators),
+			       indicatorp, indicatorp_dma_addr);
+	vc_dma_free_struct(vdev, ccw);
 	return 0;
 out:
-	kfree(indicatorp);
-	kfree(ccw);
+	if (indicatorp)
+		__vc_dma_free(&vcdev->vdev, sizeof(&vcdev->indicators),
+			       indicatorp, indicatorp_dma_addr);
+	vc_dma_free_struct(vdev, ccw);
 	virtio_ccw_del_vqs(vdev);
 	return ret;
 }
@@ -699,9 +732,9 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 static void virtio_ccw_reset(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
@@ -714,22 +747,22 @@ static void virtio_ccw_reset(struct virtio_device *vdev)
 	ccw->count = 0;
 	ccw->cda = 0;
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_RESET);
-	kfree(ccw);
+	vc_dma_free_struct(vdev, ccw);
 }
 
 static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	struct virtio_feature_desc *features;
+	vc_dma_decl_struct(virtio_feature_desc, features);
+	vc_dma_decl_struct(ccw1, ccw);
 	int ret;
 	u64 rc;
-	struct ccw1 *ccw;
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return 0;
 
-	features = kzalloc(sizeof(*features), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, features);
 	if (!features) {
 		rc = 0;
 		goto out_free;
@@ -762,8 +795,8 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
 		rc |= (u64)le32_to_cpu(features->features) << 32;
 
 out_free:
-	kfree(features);
-	kfree(ccw);
+	vc_dma_free_struct(vdev, features);
+	vc_dma_free_struct(vdev, ccw);
 	return rc;
 }
 
@@ -779,8 +812,8 @@ static void ccw_transport_features(struct virtio_device *vdev)
 static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	struct virtio_feature_desc *features;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(virtio_feature_desc, features);
+	vc_dma_decl_struct(ccw1, ccw);
 	int ret;
 
 	if (vcdev->revision >= 1 &&
@@ -790,11 +823,11 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return -ENOMEM;
 
-	features = kzalloc(sizeof(*features), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, features);
 	if (!features) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -829,8 +862,8 @@ static int virtio_ccw_finalize_features(struct virtio_device *vdev)
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
 
 out_free:
-	kfree(features);
-	kfree(ccw);
+	vc_dma_free_struct(vdev, features);
+	vc_dma_free_struct(vdev, ccw);
 
 	return ret;
 }
@@ -840,15 +873,17 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	int ret;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 	void *config_area;
 	unsigned long flags;
+	dma_addr_t config_area_dma_addr;
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
-	config_area = kzalloc(VIRTIO_CCW_CONFIG_SIZE, GFP_DMA | GFP_KERNEL);
+	config_area = __vc_dma_alloc(vdev, VIRTIO_CCW_CONFIG_SIZE,
+				     &config_area_dma_addr);
 	if (!config_area)
 		goto out_free;
 
@@ -870,8 +905,9 @@ static void virtio_ccw_get_config(struct virtio_device *vdev,
 		memcpy(buf, config_area + offset, len);
 
 out_free:
-	kfree(config_area);
-	kfree(ccw);
+	__vc_dma_free(vdev, VIRTIO_CCW_CONFIG_SIZE, config_area,
+				     config_area_dma_addr);
+	vc_dma_free_struct(vdev, ccw);
 }
 
 static void virtio_ccw_set_config(struct virtio_device *vdev,
@@ -879,15 +915,17 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 				  unsigned len)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 	void *config_area;
 	unsigned long flags;
+	dma_addr_t config_area_dma_addr;
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
-	config_area = kzalloc(VIRTIO_CCW_CONFIG_SIZE, GFP_DMA | GFP_KERNEL);
+	config_area = __vc_dma_alloc(vdev, VIRTIO_CCW_CONFIG_SIZE,
+				     &config_area_dma_addr);
 	if (!config_area)
 		goto out_free;
 
@@ -906,20 +944,21 @@ static void virtio_ccw_set_config(struct virtio_device *vdev,
 	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_CONFIG);
 
 out_free:
-	kfree(config_area);
-	kfree(ccw);
+	__vc_dma_free(vdev, VIRTIO_CCW_CONFIG_SIZE, config_area,
+				     config_area_dma_addr);
+	vc_dma_free_struct(vdev, ccw);
 }
 
 static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	u8 old_status = *vcdev->status;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 
 	if (vcdev->revision < 1)
 		return *vcdev->status;
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return old_status;
 
@@ -934,7 +973,7 @@ static u8 virtio_ccw_get_status(struct virtio_device *vdev)
  * handler anyway), vcdev->status was not overwritten and we just
  * return the old status, which is fine.
 */
-	kfree(ccw);
+	vc_dma_free_struct(vdev, ccw);
 
 	return *vcdev->status;
 }
@@ -943,10 +982,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	u8 old_status = *vcdev->status;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(ccw1, ccw);
 	int ret;
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(vdev, ccw);
 	if (!ccw)
 		return;
 
@@ -960,7 +999,7 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 	/* Write failed? We assume status is unchanged. */
 	if (ret)
 		*vcdev->status = old_status;
-	kfree(ccw);
+	vc_dma_free_struct(vdev, ccw);
 }
 
 static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
@@ -993,8 +1032,8 @@ static void virtio_ccw_release_dev(struct device *_d)
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_ccw_device *vcdev = to_vc_device(dev);
 
-	kfree(vcdev->status);
-	kfree(vcdev->config_block);
+	vc_dma_free_struct(dev, vcdev->status);
+	vc_dma_free_struct(dev, vcdev->config_block);
 	kfree(vcdev);
 }
 
@@ -1198,16 +1237,16 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
 
 static int virtio_ccw_set_transport_rev(struct virtio_ccw_device *vcdev)
 {
-	struct virtio_rev_info *rev;
-	struct ccw1 *ccw;
+	vc_dma_decl_struct(virtio_rev_info, rev);
+	vc_dma_decl_struct(ccw1, ccw);
 	int ret;
 
-	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(&vcdev->vdev, ccw);
 	if (!ccw)
 		return -ENOMEM;
-	rev = kzalloc(sizeof(*rev), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(&vcdev->vdev, rev);
 	if (!rev) {
-		kfree(ccw);
+		vc_dma_free_struct(&vcdev->vdev, ccw);
 		return -ENOMEM;
 	}
 
@@ -1237,8 +1276,8 @@ static int virtio_ccw_set_transport_rev(struct virtio_ccw_device *vcdev)
 		}
 	} while (ret == -EOPNOTSUPP);
 
-	kfree(ccw);
-	kfree(rev);
+	vc_dma_free_struct(&vcdev->vdev, ccw);
+	vc_dma_free_struct(&vcdev->vdev, rev);
 	return ret;
 }
 
@@ -1266,13 +1305,12 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 		goto out_free;
 	}
 
-	vcdev->config_block = kzalloc(sizeof(*vcdev->config_block),
-				   GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(&vcdev->vdev, vcdev->config_block);
 	if (!vcdev->config_block) {
 		ret = -ENOMEM;
 		goto out_free;
 	}
-	vcdev->status = kzalloc(sizeof(*vcdev->status), GFP_DMA | GFP_KERNEL);
+	vc_dma_alloc_struct(&vcdev->vdev, vcdev->status);
 	if (!vcdev->status) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -1280,7 +1318,6 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 
 	vcdev->is_thinint = virtio_ccw_use_airq; /* at least try */
 
-	vcdev->vdev.dev.parent = &cdev->dev;
 	vcdev->vdev.dev.release = virtio_ccw_release_dev;
 	vcdev->vdev.config = &virtio_ccw_config_ops;
 	vcdev->cdev = cdev;
@@ -1314,8 +1351,8 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	return ret;
 out_free:
 	if (vcdev) {
-		kfree(vcdev->status);
-		kfree(vcdev->config_block);
+		vc_dma_free_struct(&vcdev->vdev, vcdev->status);
+		vc_dma_free_struct(&vcdev->vdev, vcdev->config_block);
 	}
 	kfree(vcdev);
 	return ret;
-- 
2.16.4
