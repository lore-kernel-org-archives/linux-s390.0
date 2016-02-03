From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v7 6/9] virtio: Add improved queue allocation API
Date: Tue,  2 Feb 2016 21:46:37 -0800
Message-ID: <a8d08c2e6a3b2705260b88b7c5d020d1793dfc27.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
In-Reply-To: <cover.1454477782.git.luto@kernel.org>
References: <cover.1454477782.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Woodhouse <dwmw2@infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, KVM <kvm@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Vrabel <david.vrabel@citrix.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This leaves vring_new_virtqueue alone for compatbility, but it
adds two new improved APIs:

vring_create_virtqueue: Creates a virtqueue backed by automatically
allocated coherent memory.  (Some day it this could be extended to
support non-coherent memory, too, if there ends up being a platform
on which it's worthwhile.)

__vring_new_virtqueue: Creates a virtqueue with a manually-specified
layout.  This should allow mic_virtio to work much more cleanly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_ring.c | 209 ++++++++++++++++++++++++++++++++++++-------
 include/linux/virtio.h       |  23 ++++-
 include/linux/virtio_ring.h  |  35 ++++++++
 3 files changed, 235 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9abc008ff7ea..e46d08107a50 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -95,6 +95,11 @@ struct vring_virtqueue {
 	/* How to notify other side. FIXME: commonalize hcalls! */
 	bool (*notify)(struct virtqueue *vq);
 
+	/* DMA, allocation, and size information */
+	bool we_own_ring;
+	size_t queue_size_in_bytes;
+	dma_addr_t queue_dma_addr;
+
 #ifdef DEBUG
 	/* They're supposed to lock for us. */
 	unsigned int in_use;
@@ -878,36 +883,31 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 }
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
-struct virtqueue *vring_new_virtqueue(unsigned int index,
-				      unsigned int num,
-				      unsigned int vring_align,
-				      struct virtio_device *vdev,
-				      bool weak_barriers,
-				      void *pages,
-				      bool (*notify)(struct virtqueue *),
-				      void (*callback)(struct virtqueue *),
-				      const char *name)
+struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					struct vring vring,
+					struct virtio_device *vdev,
+					bool weak_barriers,
+					bool (*notify)(struct virtqueue *),
+					void (*callback)(struct virtqueue *),
+					const char *name)
 {
-	struct vring_virtqueue *vq;
 	unsigned int i;
+	struct vring_virtqueue *vq;
 
-	/* We assume num is a power of 2. */
-	if (num & (num - 1)) {
-		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
-		return NULL;
-	}
-
-	vq = kmalloc(sizeof(*vq) + num * sizeof(struct vring_desc_state),
+	vq = kmalloc(sizeof(*vq) + vring.num * sizeof(struct vring_desc_state),
 		     GFP_KERNEL);
 	if (!vq)
 		return NULL;
 
-	vring_init(&vq->vring, num, pages, vring_align);
+	vq->vring = vring;
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = num;
+	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
+	vq->we_own_ring = false;
+	vq->queue_dma_addr = 0;
+	vq->queue_size_in_bytes = 0;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
@@ -932,18 +932,145 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-	for (i = 0; i < num-1; i++)
+	for (i = 0; i < vring.num-1; i++)
 		vq->vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
-	memset(vq->desc_state, 0, num * sizeof(struct vring_desc_state));
+	memset(vq->desc_state, 0, vring.num * sizeof(struct vring_desc_state));
 
 	return &vq->vq;
 }
+EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
+
+static void *vring_alloc_queue(struct virtio_device *vdev, size_t size,
+			      dma_addr_t *dma_handle, gfp_t flag)
+{
+	if (vring_use_dma_api(vdev)) {
+		return dma_alloc_coherent(vdev->dev.parent, size,
+					  dma_handle, flag);
+	} else {
+		void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
+		if (queue) {
+			phys_addr_t phys_addr = virt_to_phys(queue);
+			*dma_handle = (dma_addr_t)phys_addr;
+
+			/*
+			 * Sanity check: make sure we dind't truncate
+			 * the address.  The only arches I can find that
+			 * have 64-bit phys_addr_t but 32-bit dma_addr_t
+			 * are certain non-highmem MIPS and x86
+			 * configurations, but these configurations
+			 * should never allocate physical pages above 32
+			 * bits, so this is fine.  Just in case, throw a
+			 * warning and abort if we end up with an
+			 * unrepresentable address.
+			 */
+			if (WARN_ON_ONCE(*dma_handle != phys_addr)) {
+				free_pages_exact(queue, PAGE_ALIGN(size));
+				return NULL;
+			}
+		}
+		return queue;
+	}
+}
+
+static void vring_free_queue(struct virtio_device *vdev, size_t size,
+			     void *queue, dma_addr_t dma_handle)
+{
+	if (vring_use_dma_api(vdev)) {
+		dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
+	} else {
+		free_pages_exact(queue, PAGE_ALIGN(size));
+	}
+}
+
+struct virtqueue *vring_create_virtqueue(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name)
+{
+	struct virtqueue *vq;
+	void *queue;
+	dma_addr_t dma_addr;
+	size_t queue_size_in_bytes;
+	struct vring vring;
+
+	/* We assume num is a power of 2. */
+	if (num & (num - 1)) {
+		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
+		return NULL;
+	}
+
+	/* TODO: allocate each queue chunk individually */
+	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
+		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+					  &dma_addr,
+					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
+		if (queue)
+			break;
+	}
+
+	if (!num)
+		return NULL;
+
+	if (!queue) {
+		/* Try to get a single page. You are my only hope! */
+		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
+					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
+	}
+	if (!queue)
+		return NULL;
+
+	queue_size_in_bytes = vring_size(num, vring_align);
+	vring_init(&vring, num, queue, vring_align);
+
+	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers,
+				   notify, callback, name);
+	if (!vq) {
+		vring_free_queue(vdev, queue_size_in_bytes, queue,
+				 dma_addr);
+		return NULL;
+	}
+
+	to_vvq(vq)->queue_dma_addr = dma_addr;
+	to_vvq(vq)->queue_size_in_bytes = queue_size_in_bytes;
+	to_vvq(vq)->we_own_ring = true;
+
+	return vq;
+}
+EXPORT_SYMBOL_GPL(vring_create_virtqueue);
+
+struct virtqueue *vring_new_virtqueue(unsigned int index,
+				      unsigned int num,
+				      unsigned int vring_align,
+				      struct virtio_device *vdev,
+				      bool weak_barriers,
+				      void *pages,
+				      bool (*notify)(struct virtqueue *vq),
+				      void (*callback)(struct virtqueue *vq),
+				      const char *name)
+{
+	struct vring vring;
+	vring_init(&vring, num, pages, vring_align);
+	return __vring_new_virtqueue(index, vring, vdev, weak_barriers,
+				     notify, callback, name);
+}
 EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
-void vring_del_virtqueue(struct virtqueue *vq)
+void vring_del_virtqueue(struct virtqueue *_vq)
 {
-	list_del(&vq->list);
-	kfree(to_vvq(vq));
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (vq->we_own_ring) {
+		vring_free_queue(vq->vq.vdev, vq->queue_size_in_bytes,
+				 vq->vring.desc, vq->queue_dma_addr);
+	}
+	list_del(&_vq->list);
+	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
 
@@ -1007,20 +1134,42 @@ void virtio_break_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
-void *virtqueue_get_avail(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->vring.avail;
+	BUG_ON(!vq->we_own_ring);
+
+	return vq->queue_dma_addr;
 }
-EXPORT_SYMBOL_GPL(virtqueue_get_avail);
+EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
 
-void *virtqueue_get_used(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->vring.used;
+	BUG_ON(!vq->we_own_ring);
+
+	return vq->queue_dma_addr +
+		((char *)vq->vring.avail - (char *)vq->vring.desc);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
+
+dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	BUG_ON(!vq->we_own_ring);
+
+	return vq->queue_dma_addr +
+		((char *)vq->vring.used - (char *)vq->vring.desc);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
+
+const struct vring *virtqueue_get_vring(struct virtqueue *vq)
+{
+	return &to_vvq(vq)->vring;
 }
-EXPORT_SYMBOL_GPL(virtqueue_get_used);
+EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 8f4d4bfa6d46..d5eb5479a425 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -75,8 +75,27 @@ unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
 bool virtqueue_is_broken(struct virtqueue *vq);
 
-void *virtqueue_get_avail(struct virtqueue *vq);
-void *virtqueue_get_used(struct virtqueue *vq);
+const struct vring *virtqueue_get_vring(struct virtqueue *vq);
+dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
+dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
+dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
+
+/*
+ * Legacy accessors -- in almost all cases, these are the wrong functions
+ * to use.
+ */
+static inline void *virtqueue_get_desc(struct virtqueue *vq)
+{
+	return virtqueue_get_vring(vq)->desc;
+}
+static inline void *virtqueue_get_avail(struct virtqueue *vq)
+{
+	return virtqueue_get_vring(vq)->avail;
+}
+static inline void *virtqueue_get_used(struct virtqueue *vq)
+{
+	return virtqueue_get_vring(vq)->used;
+}
 
 /**
  * virtio_device - representation of a device using virtio
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index a156e2b6ccfe..e8d36938f09a 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -59,6 +59,35 @@ static inline void virtio_store_mb(bool weak_barriers,
 struct virtio_device;
 struct virtqueue;
 
+/*
+ * Creates a virtqueue and allocates the descriptor ring.  If
+ * may_reduce_num is set, then this may allocate a smaller ring than
+ * expected.  The caller should query virtqueue_get_ring_size to learn
+ * the actual size of the ring.
+ */
+struct virtqueue *vring_create_virtqueue(unsigned int index,
+					 unsigned int num,
+					 unsigned int vring_align,
+					 struct virtio_device *vdev,
+					 bool weak_barriers,
+					 bool may_reduce_num,
+					 bool (*notify)(struct virtqueue *vq),
+					 void (*callback)(struct virtqueue *vq),
+					 const char *name);
+
+/* Creates a virtqueue with a custom layout. */
+struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					struct vring vring,
+					struct virtio_device *vdev,
+					bool weak_barriers,
+					bool (*notify)(struct virtqueue *),
+					void (*callback)(struct virtqueue *),
+					const char *name);
+
+/*
+ * Creates a virtqueue with a standard layout but a caller-allocated
+ * ring.
+ */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
 				      unsigned int vring_align,
@@ -68,7 +97,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      bool (*notify)(struct virtqueue *vq),
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name);
+
+/*
+ * Destroys a virtqueue.  If created with vring_create_virtqueue, this
+ * also frees the ring.
+ */
 void vring_del_virtqueue(struct virtqueue *vq);
+
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
 
-- 
2.5.0
