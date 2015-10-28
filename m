From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 2/3] virtio_ring: Support DMA APIs
Date: Tue, 27 Oct 2015 22:30:20 -0700
Message-ID: <ef92832ae3e58afb161a92858dc8428e6a0f63b5.1446009834.git.luto@kernel.org>
References: <cover.1446009834.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446009834.git.luto@kernel.org>
In-Reply-To: <cover.1446009834.git.luto@kernel.org>
References: <cover.1446009834.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>
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
CONFIG_DMA_API_DEBUG.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/Kconfig           |   2 +-
 drivers/virtio/virtio_ring.c     | 187 +++++++++++++++++++++++++++++++--------
 tools/virtio/linux/dma-mapping.h |  17 ++++
 3 files changed, 169 insertions(+), 37 deletions(-)
 create mode 100644 tools/virtio/linux/dma-mapping.h

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index cab9f3f63a38..77590320d44c 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -60,7 +60,7 @@ config VIRTIO_INPUT
 
  config VIRTIO_MMIO
 	tristate "Platform bus driver for memory mapped virtio devices"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM && HAS_DMA
  	select VIRTIO
  	---help---
  	 This drivers provides support for memory mapped virtio
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 096b857e7b75..e71bf0ca59a2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/kmemleak.h>
+#include <linux/dma-mapping.h>
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -54,7 +55,14 @@
 #define END_USE(vq)
 #endif
 
-struct vring_virtqueue {
+struct vring_desc_state
+{
+	void *data;			/* Data for callback. */
+	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+};
+
+struct vring_virtqueue
+{
 	struct virtqueue vq;
 
 	/* Actual memory layout for this queue */
@@ -92,12 +100,71 @@ struct vring_virtqueue {
 	ktime_t last_add_time;
 #endif
 
-	/* Tokens for callbacks. */
-	void *data[];
+	/* Per-descriptor state. */
+	struct vring_desc_state desc_state[];
 };
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+/*
+ * The DMA ops on various arches are rather gnarly right now, and
+ * making all of the arch DMA ops work on the vring device itself
+ * is a mess.  For now, we use the parent device for DMA ops.
+ */
+struct device *vring_dma_dev(const struct vring_virtqueue *vq)
+{
+	return vq->vq.vdev->dev.parent;
+}
+
+/* Map one sg entry. */
+static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
+				   struct scatterlist *sg,
+				   enum dma_data_direction direction)
+{
+	/*
+	 * We can't use dma_map_sg, because we don't use scatterlists in
+	 * the way it expects (we don't guarantee that the scatterlist
+	 * will exist for the lifetime of the mapping).
+	 */
+	return dma_map_page(vring_dma_dev(vq),
+			    sg_page(sg), sg->offset, sg->length,
+			    direction);
+}
+
+static dma_addr_t vring_map_single(const struct vring_virtqueue *vq,
+				   void *cpu_addr, size_t size,
+				   enum dma_data_direction direction)
+{
+	return dma_map_single(vring_dma_dev(vq),
+			      cpu_addr, size, direction);
+}
+
+static void vring_unmap_one(const struct vring_virtqueue *vq,
+			    struct vring_desc *desc)
+{
+	u16 flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
+
+	if (flags & VRING_DESC_F_INDIRECT) {
+		dma_unmap_single(vring_dma_dev(vq),
+				 virtio64_to_cpu(vq->vq.vdev, desc->addr),
+				 virtio32_to_cpu(vq->vq.vdev, desc->len),
+				 (flags & VRING_DESC_F_WRITE) ?
+				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	} else {
+		dma_unmap_page(vring_dma_dev(vq),
+			       virtio64_to_cpu(vq->vq.vdev, desc->addr),
+			       virtio32_to_cpu(vq->vq.vdev, desc->len),
+			       (flags & VRING_DESC_F_WRITE) ?
+			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	}
+}
+
+static int vring_mapping_error(const struct vring_virtqueue *vq,
+			       dma_addr_t addr)
+{
+	return dma_mapping_error(vring_dma_dev(vq), addr);
+}
+
 static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 					 unsigned int total_sg, gfp_t gfp)
 {
@@ -131,7 +198,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, uninitialized_var(prev);
+	unsigned int i, n, avail, descs_used, uninitialized_var(prev), err_idx;
 	int head;
 	bool indirect;
 
@@ -171,21 +238,15 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 	if (desc) {
 		/* Use a single buffer which doesn't continue */
-		vq->vring.desc[head].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
-		vq->vring.desc[head].addr = cpu_to_virtio64(_vq->vdev, virt_to_phys(desc));
-		/* avoid kmemleak false positive (hidden by virt_to_phys) */
-		kmemleak_ignore(desc);
-		vq->vring.desc[head].len = cpu_to_virtio32(_vq->vdev, total_sg * sizeof(struct vring_desc));
-
+		indirect = true;
 		/* Set up rest to use this indirect table. */
 		i = 0;
 		descs_used = 1;
-		indirect = true;
 	} else {
+		indirect = false;
 		desc = vq->vring.desc;
 		i = head;
 		descs_used = total_sg;
-		indirect = false;
 	}
 
 	if (vq->vq.num_free < descs_used) {
@@ -200,14 +261,13 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		return -ENOSPC;
 	}
 
-	/* We're about to use some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
-
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
+			desc[i].addr = cpu_to_virtio64(_vq->vdev, vring_map_one_sg(vq, sg, DMA_TO_DEVICE));
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
+			if (vring_mapping_error(vq, desc[i].addr))
+				goto unmap_release;
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		}
@@ -215,8 +275,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
 			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
+			desc[i].addr = cpu_to_virtio64(_vq->vdev, vring_map_one_sg(vq, sg, DMA_FROM_DEVICE));
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
+			if (vring_mapping_error(vq, desc[i].addr))
+				goto unmap_release;
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		}
@@ -224,14 +286,34 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
 
+	if (indirect) {
+		/* Now that the indirect table is filled in, map it. */
+		dma_addr_t addr = vring_map_single(
+			vq, desc, total_sg * sizeof(struct vring_desc),
+			DMA_TO_DEVICE);
+
+		if (vring_mapping_error(vq, vq->vring.desc[head].addr))
+			goto unmap_release;
+
+		vq->vring.desc[head].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_INDIRECT);
+		vq->vring.desc[head].addr = cpu_to_virtio64(_vq->vdev, addr);
+
+		vq->vring.desc[head].len = cpu_to_virtio32(_vq->vdev, total_sg * sizeof(struct vring_desc));
+	}
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= descs_used;
+
 	/* Update free pointer */
 	if (indirect)
 		vq->free_head = virtio16_to_cpu(_vq->vdev, vq->vring.desc[head].next);
 	else
 		vq->free_head = i;
 
-	/* Set token. */
-	vq->data[head] = data;
+	/* Store token and indirect buffer state. */
+	vq->desc_state[head].data = data;
+	if (indirect)
+		vq->desc_state[head].indir_desc = desc;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -253,6 +335,24 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		virtqueue_kick(_vq);
 
 	return 0;
+
+unmap_release:
+	err_idx = i;
+	i = head;
+
+	for (n = 0; n < total_sg; n++) {
+		if (i == err_idx)
+			break;
+		vring_unmap_one(vq, &desc[i]);
+		i = vq->vring.desc[i].next;
+	}
+
+	vq->vq.num_free += total_sg;
+
+	if (indirect)
+		kfree(desc);
+
+	return -EIO;
 }
 
 /**
@@ -423,27 +523,43 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
 
 static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
 {
-	unsigned int i;
+	unsigned int i, j;
+	u16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
-	vq->data[head] = NULL;
+	vq->desc_state[head].data = NULL;
 
-	/* Put back on free list: find end */
+	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	/* Free the indirect table */
-	if (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT))
-		kfree(phys_to_virt(virtio64_to_cpu(vq->vq.vdev, vq->vring.desc[i].addr)));
-
-	while (vq->vring.desc[i].flags & cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT)) {
+	while (vq->vring.desc[i].flags & nextflag) {
+		vring_unmap_one(vq, &vq->vring.desc[i]);
 		i = virtio16_to_cpu(vq->vq.vdev, vq->vring.desc[i].next);
 		vq->vq.num_free++;
 	}
 
+	vring_unmap_one(vq, &vq->vring.desc[i]);
 	vq->vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev, vq->free_head);
 	vq->free_head = head;
+
 	/* Plus final descriptor */
 	vq->vq.num_free++;
+
+	/* Free the indirect table, if any, now that it's unmapped. */
+	if (vq->desc_state[head].indir_desc) {
+		struct vring_desc *indir_desc = vq->desc_state[head].indir_desc;
+		u32 len = vq->vring.desc[head].len;
+
+		BUG_ON(!(vq->vring.desc[head].flags &
+			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
+		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
+
+		for (j = 0; j < len / sizeof(struct vring_desc); j++)
+			vring_unmap_one(vq, &indir_desc[j]);
+
+		kfree(vq->desc_state[head].indir_desc);
+		vq->desc_state[head].indir_desc = NULL;
+	}
 }
 
 static inline bool more_used(const struct vring_virtqueue *vq)
@@ -498,13 +614,13 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
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
@@ -665,10 +781,10 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 	START_USE(vq);
 
 	for (i = 0; i < vq->vring.num; i++) {
-		if (!vq->data[i])
+		if (!vq->desc_state[i].data)
 			continue;
 		/* detach_buf clears data, so grab it now. */
-		buf = vq->data[i];
+		buf = vq->desc_state[i].data;
 		detach_buf(vq, i);
 		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, virtio16_to_cpu(_vq->vdev, vq->vring.avail->idx) - 1);
 		END_USE(vq);
@@ -721,7 +837,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
+	vq = kmalloc(sizeof(*vq) + num * sizeof(struct vring_desc_state),
+		     GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
@@ -751,11 +868,9 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-	for (i = 0; i < num-1; i++) {
+	for (i = 0; i < num-1; i++)
 		vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
-		vq->data[i] = NULL;
-	}
-	vq->data[i] = NULL;
+	memset(vq->desc_state, 0, num * sizeof(struct vring_desc_state));
 
 	return &vq->vq;
 }
diff --git a/tools/virtio/linux/dma-mapping.h b/tools/virtio/linux/dma-mapping.h
new file mode 100644
index 000000000000..4f93af89ae16
--- /dev/null
+++ b/tools/virtio/linux/dma-mapping.h
@@ -0,0 +1,17 @@
+#ifndef _LINUX_DMA_MAPPING_H
+#define _LINUX_DMA_MAPPING_H
+
+#ifdef CONFIG_HAS_DMA
+# error Virtio userspace code does not support CONFIG_HAS_DMA
+#endif
+
+#define PCI_DMA_BUS_IS_PHYS 1
+
+enum dma_data_direction {
+	DMA_BIDIRECTIONAL = 0,
+	DMA_TO_DEVICE = 1,
+	DMA_FROM_DEVICE = 2,
+	DMA_NONE = 3,
+};
+
+#endif
-- 
2.4.3
