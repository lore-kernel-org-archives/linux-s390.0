From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH 2/3] virtio_ring: Use DMA APIs
Date: Tue, 26 Aug 2014 14:17:01 -0700
Message-ID: <24470d6ef6f915f9235a49b986ae181be7661681.1409087794.git.luto@amacapital.net>
References: <cover.1409087794.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409087794.git.luto@amacapital.net>
In-Reply-To: <cover.1409087794.git.luto@amacapital.net>
References: <cover.1409087794.git.luto@amacapital.net>
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
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, virtualization@lists.linux-foundation.org, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

virtio_ring currently sends the device (usually a hypervisor)
physical addresses of its I/O buffers.  This is okay when DMA
addresses and physical addresses are the same thing, but this isn't
always the case.  For example, this never works on Xen guests, and
it is likely to fail if a physical "virtio" device ever ends up
behind an IOMMU or swiotlb.

The immediate use case for me is to enable virtio on Xen guests.
For that to work, we need this fix as well as a corresponding
fix to virtio_pci or to another driver.

With this patch, virtfs survives kmemleak and CONFIG_DMA_API_DEBUG.
virtio-net warns (correctly) about DMA from the stack in
virtnet_set_rx_mode.

This breaks s390's defconfig.  The default configuration for s390
does virtio through a KVM-specific interface, but that configuration
does not support DMA.  I could modify this patch to stub out the DMA
API calls if !CONFIG_HAS_DMA, but it seems to me that it would be
much nicer to make s390 support DMA unconditionally.

It's actually unclear to me whether this can be fixed without either
s390 arch support or a special case for s390 in virtio_ring: on
brief inspection of s390's DMA code, it seems to assume that
everything goes through a PCI IOMMU, which is presumably not the
case for virtio.

Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/virtio/Kconfig       |   1 +
 drivers/virtio/virtio_ring.c | 116 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 95 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index c6683f2e396c..b6f3acc61153 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -1,5 +1,6 @@
 config VIRTIO
 	tristate
+	depends on HAS_DMA
 	---help---
 	  This option is selected by any driver which implements the virtio
 	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_LGUEST,
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d356a701c9c2..6a78e2fd8e63 100644
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
@@ -93,12 +100,45 @@ struct vring_virtqueue
 	ktime_t last_add_time;
 #endif
 
-	/* Tokens for callbacks. */
-	void *data[];
+	/* Per-descriptor state. */
+	struct vring_desc_state desc_state[];
 };
 
 #define to_vvq(_vq) container_of(_vq, struct vring_virtqueue, vq)
 
+/* Helper to map one sg entry, since we can't use dma_map_sg. */
+static dma_addr_t dma_map_one_sg(struct vring_virtqueue *vq,
+				 struct scatterlist *sg,
+				 enum dma_data_direction direction)
+{
+	return dma_map_page(vq->vq.vdev->dev.parent,
+			    sg_page(sg), sg->offset, sg->length, direction);
+}
+
+static void unmap_one(struct vring_virtqueue *vq, struct vring_desc *desc)
+{
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
+}
+
+static void unmap_indirect(struct vring_virtqueue *vq, struct vring_desc *desc,
+			   int total)
+{
+	int i;
+
+	for (i = 0; i < total; i++)
+		unmap_one(vq, &desc[i]);
+}
+
 /* Set up an indirect table of descriptors and add it to the queue. */
 static inline int vring_add_indirect(struct vring_virtqueue *vq,
 				     struct scatterlist *sgs[],
@@ -132,7 +172,11 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 			if (!sg)
 				break;
 			desc[i].flags = VRING_DESC_F_NEXT;
-			desc[i].addr = sg_phys(sg);
+			desc[i].addr =
+				dma_map_one_sg(vq, sg, DMA_TO_DEVICE);
+			if (dma_mapping_error(vq->vq.vdev->dev.parent,
+					      desc[i].addr))
+				goto unmap_free;
 			desc[i].len = sg->length;
 			desc[i].next = i+1;
 			i++;
@@ -143,7 +187,11 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 			if (!sg)
 				break;
 			desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			desc[i].addr = sg_phys(sg);
+			desc[i].addr =
+				dma_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+			if (dma_mapping_error(vq->vq.vdev->dev.parent,
+					      desc[i].addr))
+				goto unmap_free;
 			desc[i].len = sg->length;
 			desc[i].next = i+1;
 			i++;
@@ -161,15 +209,27 @@ static inline int vring_add_indirect(struct vring_virtqueue *vq,
 	/* Use a single buffer which doesn't continue */
 	head = vq->free_head;
 	vq->vring.desc[head].flags = VRING_DESC_F_INDIRECT;
-	vq->vring.desc[head].addr = virt_to_phys(desc);
-	/* kmemleak gives a false positive, as it's hidden by virt_to_phys */
-	kmemleak_ignore(desc);
+	vq->vring.desc[head].addr =
+		dma_map_single(vq->vq.vdev->dev.parent,
+			       desc, i * sizeof(struct vring_desc),
+			       DMA_TO_DEVICE);
+	if (dma_mapping_error(vq->vq.vdev->dev.parent,
+			      vq->vring.desc[head].addr))
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
+	unmap_indirect(vq, desc, i);
+	kfree(desc);
+	return -ENOMEM;
 }
 
 static inline int virtqueue_add(struct virtqueue *_vq,
@@ -244,7 +304,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 			if (!sg)
 				break;
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
-			vq->vring.desc[i].addr = sg_phys(sg);
+			vq->vring.desc[i].addr =
+				dma_map_one_sg(vq, sg, DMA_TO_DEVICE);
 			vq->vring.desc[i].len = sg->length;
 			prev = i;
 			i = vq->vring.desc[i].next;
@@ -255,7 +316,8 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 			if (!sg)
 				break;
 			vq->vring.desc[i].flags = VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
-			vq->vring.desc[i].addr = sg_phys(sg);
+			vq->vring.desc[i].addr =
+				dma_map_one_sg(vq, sg, DMA_FROM_DEVICE);
 			vq->vring.desc[i].len = sg->length;
 			prev = i;
 			i = vq->vring.desc[i].next;
@@ -269,7 +331,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 add_head:
 	/* Set token. */
-	vq->data[head] = data;
+	vq->desc_state[head].data = data;
 
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
@@ -470,22 +532,33 @@ static void detach_buf(struct vring_virtqueue *vq, unsigned int head)
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
+		unmap_indirect(vq, vq->desc_state[head].indir_desc,
+			       len / sizeof(struct vring_desc));
+		kfree(vq->desc_state[head].indir_desc);
+		vq->desc_state[head].indir_desc = NULL;
+	}
 
 	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
+		unmap_one(vq, &vq->vring.desc[i]);
 		i = vq->vring.desc[i].next;
 		vq->vq.num_free++;
 	}
 
+	unmap_one(vq, &vq->vring.desc[i]);
 	vq->vring.desc[i].next = vq->free_head;
 	vq->free_head = head;
+
 	/* Plus final descriptor */
 	vq->vq.num_free++;
 }
@@ -542,13 +615,13 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
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
@@ -709,10 +782,10 @@ void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
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
@@ -765,7 +838,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
+	vq = kmalloc(sizeof(*vq) + num * sizeof(struct vring_desc_state),
+		     GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
@@ -795,11 +869,9 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
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
-- 
1.9.3
