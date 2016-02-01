From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v6 6/9] virtio: Add improved queue allocation API
Date: Mon,  1 Feb 2016 10:00:56 -0800
Message-ID: <5819fe5f70a5c110ab4ea58233004aafd9259d29.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
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
 drivers/virtio/virtio_ring.c | 178 +++++++++++++++++++++++++++++++++++--------
 include/linux/virtio.h       |  23 +++++-
 include/linux/virtio_ring.h  |  35 +++++++++
 3 files changed, 204 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 2f621e96b9ff..cf2840c7e500 100644
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
@@ -932,18 +932,105 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
 
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
+		queue = dma_zalloc_coherent(
+			vdev->dev.parent, vring_size(num, vring_align),
+			&dma_addr, GFP_KERNEL|__GFP_NOWARN);
+		if (queue)
+			break;
+	}
+
+	if (!num)
+		return NULL;
+
+	if (!queue) {
+		/* Try to get a single page. You are my only hope! */
+		queue = dma_zalloc_coherent(
+			vdev->dev.parent, vring_size(num, vring_align),
+			&dma_addr, GFP_KERNEL);
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
+		dma_free_coherent(vdev->dev.parent,
+				  queue_size_in_bytes, queue,
+				  dma_addr);
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
+		dma_free_coherent(vring_dma_dev(vq), vq->queue_size_in_bytes,
+				  vq->vring.desc, vq->queue_dma_addr);
+	}
+	list_del(&_vq->list);
+	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
 
@@ -1007,20 +1094,51 @@ void virtio_break_device(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_break_device);
 
-void *virtqueue_get_avail(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	BUG_ON(!vq->we_own_ring);
+
+	if (vring_use_dma_api(vq))
+		return vq->queue_dma_addr;
+	else
+		return virt_to_phys(vq->vring.desc);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_desc_addr);
+
+dma_addr_t virtqueue_get_avail_addr(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->vring.avail;
+	BUG_ON(!vq->we_own_ring);
+
+	if (vring_use_dma_api(vq))
+		return vq->queue_dma_addr +
+			((char *)vq->vring.avail - (char *)vq->vring.desc);
+	else
+		return virt_to_phys(vq->vring.avail);
 }
-EXPORT_SYMBOL_GPL(virtqueue_get_avail);
+EXPORT_SYMBOL_GPL(virtqueue_get_avail_addr);
 
-void *virtqueue_get_used(struct virtqueue *_vq)
+dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->vring.used;
+	BUG_ON(!vq->we_own_ring);
+
+	if (vring_use_dma_api(vq))
+		return vq->queue_dma_addr +
+			((char *)vq->vring.used - (char *)vq->vring.desc);
+	else
+		return virt_to_phys(vq->vring.used);
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
