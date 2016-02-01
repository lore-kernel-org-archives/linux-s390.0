From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v6 8/9] virtio_pci: Use the DMA API if enabled
Date: Mon,  1 Feb 2016 10:00:58 -0800
Message-ID: <80cb032454b8f55773ffe4bdde23f00993f8f8cb.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
In-Reply-To: <cover.1454349471.git.luto@kernel.org>
References: <cover.1454349471.git.luto@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, sparclinux@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Linux Virtualization <virtualization@lists.linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This switches to vring_create_virtqueue, simplifying the driver and
adding DMA API support.

This fixes virtio-pci on platforms and busses that have IOMMUs.  This
will break the experimental QEMU Q35 IOMMU support until QEMU is
fixed.  In exchange, it fixes physical virtio hardware as well as
virtio-pci running under Xen.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_pci_common.h |  6 ----
 drivers/virtio/virtio_pci_legacy.c | 42 +++++++++++---------------
 drivers/virtio/virtio_pci_modern.c | 61 ++++++++++----------------------------
 3 files changed, 33 insertions(+), 76 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 2cc252270b2d..28263200ed42 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -35,12 +35,6 @@ struct virtio_pci_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
 
-	/* the number of entries in the queue */
-	int num;
-
-	/* the virtual address of the ring queue */
-	void *queue;
-
 	/* the list node for the virtqueues list */
 	struct list_head node;
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 48bc9797e530..8c4e61783441 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -119,7 +119,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  u16 msix_vec)
 {
 	struct virtqueue *vq;
-	unsigned long size;
 	u16 num;
 	int err;
 
@@ -131,27 +130,19 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
 		return ERR_PTR(-ENOENT);
 
-	info->num = num;
 	info->msix_vector = msix_vec;
 
-	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
-	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
-	if (info->queue == NULL)
+	/* create the vring */
+	vq = vring_create_virtqueue(index, num,
+				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
+				    true, false, vp_notify, callback, name);
+	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
-	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+	iowrite32(virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
 		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
-	/* create the vring */
-	vq = vring_new_virtqueue(index, info->num,
-				 VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
-				 true, info->queue, vp_notify, callback, name);
-	if (!vq) {
-		err = -ENOMEM;
-		goto out_activate_queue;
-	}
-
 	vq->priv = (void __force *)vp_dev->ioaddr + VIRTIO_PCI_QUEUE_NOTIFY;
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
@@ -159,17 +150,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		msix_vec = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
-			goto out_assign;
+			goto out_deactivate;
 		}
 	}
 
 	return vq;
 
-out_assign:
-	vring_del_virtqueue(vq);
-out_activate_queue:
+out_deactivate:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
-	free_pages_exact(info->queue, size);
+	vring_del_virtqueue(vq);
 	return ERR_PTR(err);
 }
 
@@ -177,7 +166,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 {
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	unsigned long size;
 
 	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
@@ -188,13 +176,10 @@ static void del_vq(struct virtio_pci_vq_info *info)
 		ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
 	}
 
-	vring_del_virtqueue(vq);
-
 	/* Select and deactivate the queue */
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
-	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
-	free_pages_exact(info->queue, size);
+	vring_del_virtqueue(vq);
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -227,6 +212,13 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 		return -ENODEV;
 	}
 
+	rc = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (rc)
+		rc = dma_set_mask_and_coherent(&pci_dev->dev,
+						DMA_BIT_MASK(32));
+	if (rc)
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+
 	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
 	if (rc)
 		return rc;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index c0c11fad4611..0b4a4f440b85 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -287,31 +287,6 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 	return vp_ioread16(&vp_dev->common->msix_config);
 }
 
-static size_t vring_pci_size(u16 num)
-{
-	/* We only need a cacheline separation. */
-	return PAGE_ALIGN(vring_size(num, SMP_CACHE_BYTES));
-}
-
-static void *alloc_virtqueue_pages(int *num)
-{
-	void *pages;
-
-	/* TODO: allocate each queue chunk individually */
-	for (; *num && vring_pci_size(*num) > PAGE_SIZE; *num /= 2) {
-		pages = alloc_pages_exact(vring_pci_size(*num),
-					  GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN);
-		if (pages)
-			return pages;
-	}
-
-	if (!*num)
-		return NULL;
-
-	/* Try to get a single page. You are my only hope! */
-	return alloc_pages_exact(vring_pci_size(*num), GFP_KERNEL|__GFP_ZERO);
-}
-
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_pci_vq_info *info,
 				  unsigned index,
@@ -343,29 +318,22 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	/* get offset of notification word for this vq */
 	off = vp_ioread16(&cfg->queue_notify_off);
 
-	info->num = num;
 	info->msix_vector = msix_vec;
 
-	info->queue = alloc_virtqueue_pages(&info->num);
-	if (info->queue == NULL)
-		return ERR_PTR(-ENOMEM);
-
 	/* create the vring */
-	vq = vring_new_virtqueue(index, info->num,
-				 SMP_CACHE_BYTES, &vp_dev->vdev,
-				 true, info->queue, vp_notify, callback, name);
-	if (!vq) {
-		err = -ENOMEM;
-		goto err_new_queue;
-	}
+	vq = vring_create_virtqueue(index, num,
+				    SMP_CACHE_BYTES, &vp_dev->vdev,
+				    true, true, vp_notify, callback, name);
+	if (!vq)
+		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
-	vp_iowrite16(num, &cfg->queue_size);
-	vp_iowrite64_twopart(virt_to_phys(info->queue),
+	vp_iowrite16(virtqueue_get_vring_size(vq), &cfg->queue_size);
+	vp_iowrite64_twopart(virtqueue_get_desc_addr(vq),
 			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
-	vp_iowrite64_twopart(virt_to_phys(virtqueue_get_avail(vq)),
+	vp_iowrite64_twopart(virtqueue_get_avail_addr(vq),
 			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
-	vp_iowrite64_twopart(virt_to_phys(virtqueue_get_used(vq)),
+	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
 	if (vp_dev->notify_base) {
@@ -410,8 +378,6 @@ err_assign_vector:
 		pci_iounmap(vp_dev->pci_dev, (void __iomem __force *)vq->priv);
 err_map_notify:
 	vring_del_virtqueue(vq);
-err_new_queue:
-	free_pages_exact(info->queue, vring_pci_size(info->num));
 	return ERR_PTR(err);
 }
 
@@ -456,8 +422,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 		pci_iounmap(vp_dev->pci_dev, (void __force __iomem *)vq->priv);
 
 	vring_del_virtqueue(vq);
-
-	free_pages_exact(info->queue, vring_pci_size(info->num));
 }
 
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
@@ -641,6 +605,13 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 		return -EINVAL;
 	}
 
+	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_set_mask_and_coherent(&pci_dev->dev,
+						DMA_BIT_MASK(32));
+	if (err)
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+
 	/* Device capability is only mandatory for devices that have
 	 * device-specific configuration.
 	 */
-- 
2.5.0
