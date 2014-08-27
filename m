From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v2 2/4] virtio_ring: Support DMA APIs if requested
Date: Wed, 27 Aug 2014 14:50:55 -0700
Message-ID: <bfffff8d7076931f8a17a63fb7b4093dbc1802a1.1409176034.git.luto@amacapital.net>
References: <cover.1409176034.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409176034.git.luto@amacapital.net>
In-Reply-To: <cover.1409176034.git.luto@amacapital.net>
References: <cover.1409176034.git.luto@amacapital.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/virtualization/>
List-Post: <mailto:virtualization@lists.linuxfoundation.org>
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>, virtio-dev@lists.oasis-open.org
List-ID: <linux-s390.vger.kernel.org>

virtio_ring currently sends the device (usually a hypervisor)
physical addresses of its I/O buffers.  This is okay when DMA
addresses and physical addresses are the same thing, but this isn't
always the case.  For example, this never works on Xen guests, and
it is likely to fail if a physical "virtio" device ever ends up
behind an IOMMU or swiotlb.

The immediate use case for me is to enable virtio on Xen guests.
For that to work, we need vring to support DMA address translation
as well as a corresponding change to virtio_pci or to another
driver.

With this patch, if enabled, virtfs survives kmemleak and
CONFIG_DMA_API_DEBUG.  virtio-net warns (correctly) about DMA from
the stack in virtnet_set_rx_mode.

This explicitly supports !CONFIG_HAS_DMA.  If vring is asked to use
the DMA API and CONFIG_HAS_DMA is not set, then vring will refuse to
create the virtqueue.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/lguest/lguest_device.c         |   3 +-
 drivers/misc/mic/card/mic_virtio.c     |   2 +-
 drivers/remoteproc/remoteproc_virtio.c |   4 +-
 drivers/s390/kvm/kvm_virtio.c          |   2 +-
 drivers/s390/kvm/virtio_ccw.c          |   4 +-
 drivers/virtio/virtio_mmio.c           |   5 +-
 drivers/virtio/virtio_pci.c            |   3 +-
 drivers/virtio/virtio_ring.c           | 187 +++++++++++++++++++++++++++++----
 include/linux/virtio_ring.h            |   1 +
 tools/virtio/linux/virtio.h            |   1 +
 tools/virtio/virtio_test.c             |   2 +-
 tools/virtio/vringh_test.c             |   3 +-
 12 files changed, 182 insertions(+), 35 deletions(-)

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index d0a1d8a45c81..f0eafbe82ed4 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -301,7 +301,8 @@ static struct virtqueue *lg_find_vq(struct virtio_device *vdev,
 	 * barriers.
 	 */
 	vq = vring_new_virtqueue(index, lvq->config.num, LGUEST_VRING_ALIGN, vdev,
-				 true, lvq->pages, lg_notify, callback, name);
+				 true, false, lvq->pages,
+				 lg_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto unmap;
diff --git a/drivers/misc/mic/card/mic_virtio.c b/drivers/misc/mic/card/mic_virtio.c
index f14b60080c21..d633964417b1 100644
--- a/drivers/misc/mic/card/mic_virtio.c
+++ b/drivers/misc/mic/card/mic_virtio.c
@@ -256,7 +256,7 @@ static struct virtqueue *mic_find_vq(struct virtio_device *vdev,
 	mvdev->vr[index] = va;
 	memset_io(va, 0x0, _vr_size);
 	vq = vring_new_virtqueue(index, le16_to_cpu(config.num),
-				 MIC_VIRTIO_RING_ALIGN, vdev, false,
+				 MIC_VIRTIO_RING_ALIGN, vdev, false, false,
 				 (void __force *)va, mic_notify, callback,
 				 name);
 	if (!vq) {
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index a34b50690b4e..e31f2fefa76e 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -107,8 +107,8 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	 * Create the new vq, and tell virtio we're not interested in
 	 * the 'weak' smp barriers, since we're talking with a real device.
 	 */
-	vq = vring_new_virtqueue(id, len, rvring->align, vdev, false, addr,
-					rproc_virtio_notify, callback, name);
+	vq = vring_new_virtqueue(id, len, rvring->align, vdev, false, false,
+				 addr, rproc_virtio_notify, callback, name);
 	if (!vq) {
 		dev_err(dev, "vring_new_virtqueue %s failed\n", name);
 		rproc_free_vring(rvring);
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index a1349653c6d9..91abcdc196d0 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -206,7 +206,7 @@ static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
 		goto out;
 
 	vq = vring_new_virtqueue(index, config->num, KVM_S390_VIRTIO_RING_ALIGN,
-				 vdev, true, (void *) config->address,
+				 vdev, true, false, (void *) config->address,
 				 kvm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index d2c0b442bce5..2462a443358a 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -478,8 +478,8 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 	}
 
 	vq = vring_new_virtqueue(i, info->num, KVM_VIRTIO_CCW_RING_ALIGN, vdev,
-				 true, info->queue, virtio_ccw_kvm_notify,
-				 callback, name);
+				 true, false, info->queue,
+				 virtio_ccw_kvm_notify, callback, name);
 	if (!vq) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index c600ccfd6922..693254e52a5d 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -366,8 +366,9 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 			vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 
 	/* Create the vring */
-	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN, vdev,
-				 true, info->queue, vm_notify, callback, name);
+	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN,
+				 vdev, true, false, info->queue,
+				 vm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 3d1463c6b120..a1f299fa4626 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -430,7 +430,8 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 
 	/* create the vring */
 	vq = vring_new_virtqueue(index, info->num, VIRTIO_PCI_VRING_ALIGN, vdev,
-				 true, info->queue, vp_notify, callback, name);
+				 true, false, info->queue,
+				 vp_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto out_activate_queue;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d356a701c9c2..8f200aee0fd8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/kmemleak.h>
+#include <linux/dma-mapping.h>
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -54,6 +55,12 @@
 #define END_USE(vq)
 #endif
 
+struct vring_desc_state
+{
+	void *data;			/* Data for callback. */
+	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+};
+
 struct vring_virtqueue
 {
 	struct virtqueue vq;
@@ -64,6 +71,9 @@ struct vring_virtqueue
 	/* Can we use weak barriers? */
 	bool weak_barriers;
 
+	/* Should we use the DMA API? */
+	bool use_dma_api;
+
 	/* Other side has made a mess, don't try any more. */
 	bool broken;
 
@@ -93,12 +103,89 @@ struct vring_virtqueue
 	ktime_t last_add_time;
 #endif
 
-	/* Tokens for callbacks. */
-	void *data[];
+	/* Per-descriptor state. */
+	struct vring_desc_state desc_state[];
 };
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+/* Map one sg entry. */
+static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
+				   struct scatterlist *sg,
+				   enum dma_data_direction direction)
+{
+#ifdef CONFIG_HAS_DMA
+	/*
+	 * We can't use dma_map_sg, because we don't use scatterlists in
+	 * the way it expects (we sometimes use unterminated
+	 * scatterlists, and we don't guarantee that the scatterlist
+	 * will exist for the lifetime of the mapping.
+	 */
+	if (vq->use_dma_api)
+		return dma_map_page(vq->vq.vdev->dev.parent,
+				    sg_page(sg), sg->offset, sg->length,
+				    direction);
+#endif
+
+	return sg_phys(sg);
+}
+
+static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
+				   void *cpu_addr, size_t size,
+				   enum dma_data_direction direction)
+{
+#ifdef CONFIG_HAS_DMA
+	if (vq->use_dma_api)
+		return dma_map_single(vq->vq.vdev->dev.parent,
+				      cpu_addr, size,
+				      direction);
+#endif
+
+	return virt_to_phys(cpu_addr);
+}
+
+static void vring_unmap_one(const struct vring_virtqueue *vq,
+			    struct vring_desc *desc)
+{
+#ifdef CONFIG_HAS_DMA
+	if (!vq->use_dma_api)
+		return;		/* Nothing to do. */
+
+	if (desc->flags & VRING_DESC_F_INDIRECT) {
+		dma_unmap_single(vq->vq.vdev->dev.parent,
+				 desc->addr, desc->len,
+				 (desc->flags & VRING_DESC_F_WRITE) ?
+				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	} else {
+		dma_unmap_page(vq->vq.vdev->dev.parent,
+			       desc->addr, desc->len,
+			       (desc->flags & VRING_DESC_F_WRITE) ?
+			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	}
+#endif
+}
+
+static void vring_unmap_indirect(const struct vring_virtqueue *vq,
+				 struct vring_desc *desc, int total)
+{
+	int i;
+
+	if (vq->use_dma_api)
+		for (i = 0; i < total; i++)
+			vring_unmap_one(vq, &desc[i]);
+}
+
+static int vring_mapping_error(const struct vring_virtqueue *vq,
+			       dma_addr_t addr)
+{
+#ifdef CONFIG_HAS_DMA
+	return vq->use_dma_api &&
+		dma_mapping_error(vq->vq.vdev->dev.parent, addr);
+#else
+	return 0;
+#endif
+}
+
 /* Set up an indirect table of descriptors and add it to the queue. */
 static inline int vring_add_indirect(struct vring_virtqueue *vq,
 				     struct scatterlist *sgs[],
@@ -132,7 +219,10 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 			if (!sg)
 				break;
 			desc[i].flags = VRING_DESC_F_NEXT;
-			desc[i].addr = sg_phys(sg);
+			desc[i].addr =
+				vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
+			if (vring_mapping_error(vq, desc[i].addr))
+				goto unmap_free;
 			desc[i].len = sg->length;
 			desc[i].next = i+1;
 			i++;
@@ -143,7 +233,10 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 			if (!sg)
 				break;
 			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			desc[i].addr = sg_phys(sg);
+			desc[i].addr =
+				vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+			if (vring_mapping_error(vq, desc[i].addr))
+				goto unmap_free;
 			desc[i].len = sg->length;
 			desc[i].next = i+1;
 			i++;
@@ -161,15 +254,26 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 	/* Use a single buffer which doesn't continue */
 	head = vq->free_head;
 	vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
-	vq->vring.desc[head].addr = virt_to_phys(desc);
-	/* kmemleak gives a false positive, as it's hidden by virt_to_phys */
-	kmemleak_ignore(desc);
+	vq->vring.desc[head].addr =
+		vring_map_single(vq,
+				 desc, i * sizeof(struct vring_desc),
+				 DMA_TO_DEVICE);
+	if (vring_mapping_error(vq, vq->vring.desc[head].addr))
+		goto unmap_free;
 	vq->vring.desc[head].len = i * sizeof(struct vring_desc);
 
 	/* Update free pointer */
 	vq->free_head = vq->vring.desc[head].next;
 
+	/* Save the indirect block */
+	vq->desc_state[head].indir_desc = desc;
+
 	return head;
+
+unmap_free:
+	vring_unmap_indirect(vq, desc, i);
+	kfree(desc);
+	return -ENOMEM;
 }
 
 static inline int virtqueue_add(struct virtqueue *_vq,
@@ -183,7 +287,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
-	unsigned int i, j, n, avail, uninitialized_var(prev), total_sg;
+	unsigned int i, j, n, avail, uninitialized_var(prev), total_sg, err_idx;
 	int head;
 
 	START_USE(vq);
@@ -244,7 +348,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 			if (!sg)
 				break;
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
-			vq->vring.desc[i].addr = sg_phys(sg);
+			vq->vring.desc[i].addr =
+				vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
+			if (vring_mapping_error(vq, vq->vring.desc[i].addr))
+				goto unmap_release;
 			vq->vring.desc[i].len = sg->length;
 			prev = i;
 			i = vq->vring.desc[i].next;
@@ -255,7 +362,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 			if (!sg)
 				break;
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			vq->vring.desc[i].addr = sg_phys(sg);
+			vq->vring.desc[i].addr =
+				vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+			if (vring_mapping_error(vq, vq->vring.desc[i].addr))
+				goto unmap_release;
 			vq->vring.desc[i].len = sg->length;
 			prev = i;
 			i = vq->vring.desc[i].next;
@@ -269,7 +379,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 add_head:
 	/* Set token. */
-	vq->data[head] = data;
+	vq->desc_state[head].data = data;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -291,6 +401,20 @@ add_head:
 	END_USE(vq);
 
 	return 0;
+
+unmap_release:
+	err_idx = i;
+	i = head;
+
+	for (n = 0; n < total_sg; n++) {
+		if (i == err_idx)
+			break;
+		vring_unmap_one(vq, &vq->vring.desc[i]);
+		i = vq->vring.desc[i].next;
+	}
+
+	vq->vq.num_free += total_sg;
+	return -EIO;
 }
 
 /**
@@ -470,22 +594,33 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 	unsigned int i;
 
 	/* Clear data ptr. */
-	vq->data[head] = NULL;
+	vq->desc_state[head].data = NULL;
 
 	/* Put back on free list: find end */
 	i = head;
 
 	/* Free the indirect table */
-	if (vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT)
-		kfree(phys_to_virt(vq->vring.desc[i].addr));
+	if (vq->desc_state[head].indir_desc) {
+		u32 len = vq->vring.desc[i].len;
+
+		BUG_ON(!(vq->vring.desc[i].flags & VRING_DESC_F_INDIRECT));
+		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
+		vring_unmap_indirect(vq, vq->desc_state[head].indir_desc,
+				     len / sizeof(struct vring_desc));
+		kfree(vq->desc_state[head].indir_desc);
+		vq->desc_state[head].indir_desc = NULL;
+	}
 
 	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
+		vring_unmap_one(vq, &vq->vring.desc[i]);
 		i = vq->vring.desc[i].next;
 		vq->vq.num_free++;
 	}
 
+	vring_unmap_one(vq, &vq->vring.desc[i]);
 	vq->vring.desc[i].next = vq->free_head;
 	vq->free_head = head;
+
 	/* Plus final descriptor */
 	vq->vq.num_free++;
 }
@@ -542,13 +677,13 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 		BAD_RING(vq, "id %u out of range\n", i);
 		return NULL;
 	}
-	if (unlikely(!vq->data[i])) {
+	if (unlikely(!vq->desc_state[i].data)) {
 		BAD_RING(vq, "id %u is not a head!\n", i);
 		return NULL;
 	}
 
 	/* detach_buf clears data, so grab it now. */
-	ret = vq->data[i];
+	ret = vq->desc_state[i].data;
 	detach_buf(vq, i);
 	vq->last_used_idx++;
 	/* If we expect an interrupt for the next entry, tell host
@@ -709,10 +844,10 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 	START_USE(vq);
 
 	for (i = 0; i < vq->vring.num; i++) {
-		if (!vq->data[i])
+		if (!vq->desc_state[i].data)
 			continue;
 		/* detach_buf clears data, so grab it now. */
-		buf = vq->data[i];
+		buf = vq->desc_state[i].data;
 		detach_buf(vq, i);
 		vq->vring.avail->idx--;
 		END_USE(vq);
@@ -751,6 +886,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
+				      bool use_dma_api,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *),
 				      void (*callback)(struct virtqueue *),
@@ -765,7 +901,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
+#ifndef CONFIG_HAS_DMA
+	if (use_dma_api)
+		return NULL;
+#endif
+
+	vq = kmalloc(sizeof(*vq) + num * sizeof(struct vring_desc_state),
+		     GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
@@ -777,6 +919,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 	vq->vq.index = index;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
+	vq->use_dma_api = use_dma_api;
 	vq->broken = false;
 	vq->last_used_idx = 0;
 	vq->num_added = 0;
@@ -795,11 +938,9 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-	for (i = 0; i < num-1; i++) {
+	for (i = 0; i < num-1; i++)
 		vq->vring.desc[i].next = i+1;
-		vq->data[i] = NULL;
-	}
-	vq->data[i] = NULL;
+	memset(vq->desc_state, 0, num * sizeof(struct vring_desc_state));
 
 	return &vq->vq;
 }
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 67e06fe18c03..60f761a38a09 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -70,6 +70,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
+				      bool use_dma_api,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 5a2d1f0f6bc7..5d42dc6a6201 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -78,6 +78,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int vring_align,
 				      struct virtio_device *vdev,
 				      bool weak_barriers,
+				      bool use_dma_api,
 				      void *pages,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 00ea679b3826..860cc89900a7 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -99,7 +99,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
 	vring_init(&info->vring, num, info->ring, 4096);
 	info->vq = vring_new_virtqueue(info->idx,
 				       info->vring.num, 4096, &dev->vdev,
-				       true, info->ring,
+				       true, false, info->ring,
 				       vq_notify, vq_callback, "test");
 	assert(info->vq);
 	info->vq->priv = info;
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 14a4f4cab5b9..67d3c3a1ba88 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -312,7 +312,8 @@ static int parallel_test(unsigned long features,
 		if (sched_setaffinity(getpid(), sizeof(cpu_set), &cpu_set))
 			err(1, "Could not set affinity to cpu %u", first_cpu);
 
-		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &gvdev.vdev, true,
+		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &gvdev.vdev,
+					 true, false,
 					 guest_map, fast_vringh ? no_notify_host
 					 : parallel_notify_host,
 					 never_callback_guest, "guest vq");
-- 
1.9.3
