From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v5 07/10] virtio_mmio: Use the DMA API if enabled
Date: Thu, 28 Jan 2016 18:31:20 -0800
Message-ID: <b849ab8ff08c9b8320a0a38f793aebe0aa7ca68a.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
In-Reply-To: <cover.1454034075.git.luto@kernel.org>
References: <cover.1454034075.git.luto@kernel.org>
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

This switches to vring_create_virtqueue, simplifying the driver and
adding DMA API support.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 67 ++++++++++----------------------------------
 1 file changed, 15 insertions(+), 52 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 745c6ee1bb3e..48bfea91dbca 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -99,12 +99,6 @@ struct virtio_mmio_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
 
-	/* the number of entries in the queue */
-	unsigned int num;
-
-	/* the virtual address of the ring queue */
-	void *queue;
-
 	/* the list node for the virtqueues list */
 	struct list_head node;
 };
@@ -322,15 +316,13 @@ static void vm_del_vq(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
 	struct virtio_mmio_vq_info *info = vq->priv;
-	unsigned long flags, size;
+	unsigned long flags;
 	unsigned int index = vq->index;
 
 	spin_lock_irqsave(&vm_dev->lock, flags);
 	list_del(&info->node);
 	spin_unlock_irqrestore(&vm_dev->lock, flags);
 
-	vring_del_virtqueue(vq);
-
 	/* Select and deactivate the queue */
 	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 	if (vm_dev->version == 1) {
@@ -340,8 +332,8 @@ static void vm_del_vq(struct virtqueue *vq)
 		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 
-	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_MMIO_VRING_ALIGN));
-	free_pages_exact(info->queue, size);
+	vring_del_virtqueue(vq);
+
 	kfree(info);
 }
 
@@ -356,8 +348,6 @@ static void vm_del_vqs(struct virtio_device *vdev)
 	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
 }
 
-
-
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name)
@@ -365,7 +355,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtio_mmio_vq_info *info;
 	struct virtqueue *vq;
-	unsigned long flags, size;
+	unsigned long flags;
+	unsigned int num;
 	int err;
 
 	if (!name)
@@ -388,66 +379,40 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 		goto error_kmalloc;
 	}
 
-	/* Allocate pages for the queue - start with a queue as big as
-	 * possible (limited by maximum size allowed by device), drop down
-	 * to a minimal size, just big enough to fit descriptor table
-	 * and two rings (which makes it "alignment_size * 2")
-	 */
-	info->num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
-
-	/* If the device reports a 0 entry queue, we won't be able to
-	 * use it to perform I/O, and vring_new_virtqueue() can't create
-	 * empty queues anyway, so don't bother to set up the device.
-	 */
-	if (info->num == 0) {
+	num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
+	if (num == 0) {
 		err = -ENOENT;
-		goto error_alloc_pages;
-	}
-
-	while (1) {
-		size = PAGE_ALIGN(vring_size(info->num,
-				VIRTIO_MMIO_VRING_ALIGN));
-		/* Did the last iter shrink the queue below minimum size? */
-		if (size < VIRTIO_MMIO_VRING_ALIGN * 2) {
-			err = -ENOMEM;
-			goto error_alloc_pages;
-		}
-
-		info->queue = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
-		if (info->queue)
-			break;
-
-		info->num /= 2;
+		goto error_new_virtqueue;
 	}
 
 	/* Create the vring */
-	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN, vdev,
-				 true, info->queue, vm_notify, callback, name);
+	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
+				 true, true, vm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto error_new_virtqueue;
 	}
 
 	/* Activate the queue */
-	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
+	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
 		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
+		writel(virtqueue_get_desc_addr(vq) >> PAGE_SHIFT,
 				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
 		u64 addr;
 
-		addr = virt_to_phys(info->queue);
+		addr = virtqueue_get_desc_addr(vq);
 		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
 		writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
 
-		addr = virt_to_phys(virtqueue_get_avail(vq));
+		addr = virtqueue_get_avail_addr(vq);
 		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
 		writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
 
-		addr = virt_to_phys(virtqueue_get_used(vq));
+		addr = virtqueue_get_used_addr(vq);
 		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
 		writel((u32)(addr >> 32),
 				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
@@ -471,8 +436,6 @@ error_new_virtqueue:
 		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
-	free_pages_exact(info->queue, size);
-error_alloc_pages:
 	kfree(info);
 error_kmalloc:
 error_available:
-- 
2.5.0
