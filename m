From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v7 5/9] virtio_ring: Support DMA APIs
Date: Tue,  2 Feb 2016 21:46:36 -0800
Message-ID: <a6c1a2d0b3ea60bfb27c810896179bd553e7e240.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
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

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/Kconfig           |   2 +-
 drivers/virtio/virtio_ring.c     | 200 ++++++++++++++++++++++++++++++++-------
 tools/virtio/linux/dma-mapping.h |  17 ++++
 3 files changed, 183 insertions(+), 36 deletions(-)
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
index ab0be6c084f6..9abc008ff7ea 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/hrtimer.h>
 #include <linux/kmemleak.h>
+#include <linux/dma-mapping.h>
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
@@ -54,6 +55,11 @@
 #define END_USE(vq)
 #endif
 
+struct vring_desc_state {
+	void *data;			/* Data for callback. */
+	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -98,8 +104,8 @@ struct vring_virtqueue {
 	ktime_t last_add_time;
 #endif
 
-	/* Tokens for callbacks. */
-	void *data[];
+	/* Per-descriptor state. */
+	struct vring_desc_state desc_state[];
 };
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
@@ -128,6 +134,79 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	return false;
 }
 
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
+	if (!vring_use_dma_api(vq->vq.vdev))
+		return (dma_addr_t)sg_phys(sg);
+
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
+	if (!vring_use_dma_api(vq->vq.vdev))
+		return (dma_addr_t)virt_to_phys(cpu_addr);
+
+	return dma_map_single(vring_dma_dev(vq),
+			      cpu_addr, size, direction);
+}
+
+static void vring_unmap_one(const struct vring_virtqueue *vq,
+			    struct vring_desc *desc)
+{
+	u16 flags;
+
+	if (!vring_use_dma_api(vq->vq.vdev))
+		return;
+
+	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
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
+	if (!vring_use_dma_api(vq->vq.vdev))
+		return 0;
+
+	return dma_mapping_error(vring_dma_dev(vq), addr);
+}
+
 static struct vring_desc *alloc_indirect(struct virtqueue *_vq,
 					 unsigned int total_sg, gfp_t gfp)
 {
@@ -161,7 +240,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, uninitialized_var(prev);
+	unsigned int i, n, avail, descs_used, uninitialized_var(prev), err_idx;
 	int head;
 	bool indirect;
 
@@ -201,21 +280,15 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
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
@@ -230,13 +303,14 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 		return -ENOSPC;
 	}
 
-	/* We're about to use some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
-
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
+			if (vring_mapping_error(vq, addr))
+				goto unmap_release;
+
 			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
+			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
@@ -244,8 +318,12 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
+			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+			if (vring_mapping_error(vq, addr))
+				goto unmap_release;
+
 			desc[i].flags = cpu_to_virtio16(_vq->vdev, VRING_DESC_F_NEXT | VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_virtio64(_vq->vdev, sg_phys(sg));
+			desc[i].addr = cpu_to_virtio64(_vq->vdev, addr);
 			desc[i].len = cpu_to_virtio32(_vq->vdev, sg->length);
 			prev = i;
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
@@ -254,14 +332,33 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
 
+	if (indirect) {
+		/* Now that the indirect table is filled in, map it. */
+		dma_addr_t addr = vring_map_single(
+			vq, desc, total_sg * sizeof(struct vring_desc),
+			DMA_TO_DEVICE);
+		if (vring_mapping_error(vq, addr))
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
@@ -284,6 +381,24 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
@@ -454,27 +569,43 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
 
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
+		u32 len = virtio32_to_cpu(vq->vq.vdev, vq->vring.desc[head].len);
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
@@ -529,13 +660,13 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
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
@@ -709,10 +840,10 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
 	START_USE(vq);
 
 	for (i = 0; i < vq->vring.num; i++) {
-		if (!vq->data[i])
+		if (!vq->desc_state[i].data)
 			continue;
 		/* detach_buf clears data, so grab it now. */
-		buf = vq->data[i];
+		buf = vq->desc_state[i].data;
 		detach_buf(vq, i);
 		vq->avail_idx_shadow--;
 		vq->vring.avail->idx = cpu_to_virtio16(_vq->vdev, vq->avail_idx_shadow);
@@ -766,7 +897,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
+	vq = kmalloc(sizeof(*vq) + num * sizeof(struct vring_desc_state),
+		     GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
@@ -800,11 +932,9 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
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
2.5.0
