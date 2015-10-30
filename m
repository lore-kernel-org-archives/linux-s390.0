From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 3/6] virtio_pci: Use the DMA API
Date: Thu, 29 Oct 2015 18:09:48 -0700
Message-ID: <064dc8bba95b14bf33292092087ad90e04ccc5ef.1446162273.git.luto@kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
In-Reply-To: <cover.1446162273.git.luto@kernel.org>
References: <cover.1446162273.git.luto@kernel.org>
Sender: sparclinux-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Joerg Roedel <jroedel@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org, KVM <kvm@vger.kernel.org>, dwmw2@infradead.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

This fixes virtio-pci on platforms and busses that have IOMMUs.  This
will break the experimental QEMU Q35 IOMMU support until QEMU is
fixed.  In exchange, it fixes physical virtio hardware as well as
virtio-pci running under Xen.

We should clean up the virtqueue API to do its own allocation and
teach virtqueue_get_avail and virtqueue_get_used to return DMA
addresses directly.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_pci_common.h |  3 ++-
 drivers/virtio/virtio_pci_legacy.c | 19 +++++++++++++++----
 drivers/virtio/virtio_pci_modern.c | 34 ++++++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index b976d968e793..cd6196b513ad 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -38,8 +38,9 @@ struct virtio_pci_vq_info {
 	/* the number of entries in the queue */
 	int num;
 
-	/* the virtual address of the ring queue */
+	/* the ring queue */
 	void *queue;
+	dma_addr_t queue_dma_addr;      /* bus address */
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 48bc9797e530..b5293e5f2af4 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -135,12 +135,14 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->msix_vector = msix_vec;
 
 	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
-	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
+	info->queue = dma_zalloc_coherent(&vp_dev->pci_dev->dev, size,
+					  &info->queue_dma_addr,
+					  GFP_KERNEL);
 	if (info->queue == NULL)
 		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
-	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+	iowrite32(info->queue_dma_addr >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
 		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	/* create the vring */
@@ -169,7 +171,8 @@ out_assign:
 	vring_del_virtqueue(vq);
 out_activate_queue:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
-	free_pages_exact(info->queue, size);
+	dma_free_coherent(&vp_dev->pci_dev->dev, size,
+			  info->queue, info->queue_dma_addr);
 	return ERR_PTR(err);
 }
 
@@ -194,7 +197,8 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
-	free_pages_exact(info->queue, size);
+	dma_free_coherent(&vp_dev->pci_dev->dev, size,
+			  info->queue, info->queue_dma_addr);
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
@@ -227,6 +231,13 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
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
index 8e5cf194cc0b..fbe0bd1c4881 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -293,14 +293,16 @@ static size_t vring_pci_size(u16 num)
 	return PAGE_ALIGN(vring_size(num, SMP_CACHE_BYTES));
 }
 
-static void *alloc_virtqueue_pages(int *num)
+static void *alloc_virtqueue_pages(struct virtio_pci_device *vp_dev,
+				   int *num, dma_addr_t *dma_addr)
 {
 	void *pages;
 
 	/* TODO: allocate each queue chunk individually */
 	for (; *num && vring_pci_size(*num) > PAGE_SIZE; *num /= 2) {
-		pages = alloc_pages_exact(vring_pci_size(*num),
-					  GFP_KERNEL|__GFP_ZERO|__GFP_NOWARN);
+		pages = dma_zalloc_coherent(
+			&vp_dev->pci_dev->dev, vring_pci_size(*num),
+			dma_addr, GFP_KERNEL|__GFP_NOWARN);
 		if (pages)
 			return pages;
 	}
@@ -309,7 +311,9 @@ static void *alloc_virtqueue_pages(int *num)
 		return NULL;
 
 	/* Try to get a single page. You are my only hope! */
-	return alloc_pages_exact(vring_pci_size(*num), GFP_KERNEL|__GFP_ZERO);
+	return dma_zalloc_coherent(
+		&vp_dev->pci_dev->dev, vring_pci_size(*num),
+		dma_addr, GFP_KERNEL);
 }
 
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
@@ -346,7 +350,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->num = num;
 	info->msix_vector = msix_vec;
 
-	info->queue = alloc_virtqueue_pages(&info->num);
+	info->queue = alloc_virtqueue_pages(vp_dev, &info->num,
+					    &info->queue_dma_addr);
 	if (info->queue == NULL)
 		return ERR_PTR(-ENOMEM);
 
@@ -361,11 +366,11 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	/* activate the queue */
 	vp_iowrite16(num, &cfg->queue_size);
-	vp_iowrite64_twopart(virt_to_phys(info->queue),
+	vp_iowrite64_twopart(info->queue_dma_addr,
 			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
-	vp_iowrite64_twopart(virt_to_phys(virtqueue_get_avail(vq)),
+	vp_iowrite64_twopart(info->queue_dma_addr + ((char *)virtqueue_get_avail(vq) - (char *)info->queue),
 			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
-	vp_iowrite64_twopart(virt_to_phys(virtqueue_get_used(vq)),
+	vp_iowrite64_twopart(info->queue_dma_addr + ((char *)virtqueue_get_used(vq) - (char *)info->queue),
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
 	if (vp_dev->notify_base) {
@@ -411,7 +416,8 @@ err_assign_vector:
 err_map_notify:
 	vring_del_virtqueue(vq);
 err_new_queue:
-	free_pages_exact(info->queue, vring_pci_size(info->num));
+	dma_free_coherent(&vp_dev->pci_dev->dev, vring_pci_size(info->num),
+			  info->queue, info->queue_dma_addr);
 	return ERR_PTR(err);
 }
 
@@ -457,7 +463,8 @@ static void del_vq(struct virtio_pci_vq_info *info)
 
 	vring_del_virtqueue(vq);
 
-	free_pages_exact(info->queue, vring_pci_size(info->num));
+	dma_free_coherent(&vp_dev->pci_dev->dev, vring_pci_size(info->num),
+			  info->queue, info->queue_dma_addr);
 }
 
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
@@ -641,6 +648,13 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
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
2.4.3
