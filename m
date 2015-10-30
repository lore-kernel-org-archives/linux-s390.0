From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 6/6] virtio_pci: Use the DMA API
Date: Thu, 29 Oct 2015 18:09:51 -0700
Message-ID: <82367a4ca126b658aaa18ee0a704ac5f0d3a3d3f.1446162273.git.luto@kernel.org>
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

This switches to vring_create_virtqueue, simplifying the driver and
adding DMA API support.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 drivers/virtio/virtio_pci_common.h |  7 -----
 drivers/virtio/virtio_pci_legacy.c | 39 +++++++-----------------
 drivers/virtio/virtio_pci_modern.c | 61 ++++++--------------------------------
 3 files changed, 19 insertions(+), 88 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index cd6196b513ad..1a3c689d1b9e 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -35,13 +35,6 @@ struct virtio_pci_vq_info {
 	/* the actual virtqueue */
 	struct virtqueue *vq;
 
-	/* the number of entries in the queue */
-	int num;
-
-	/* the ring queue */
-	void *queue;
-	dma_addr_t queue_dma_addr;      /* bus address */
-
 	/* the list node for the virtqueues list */
 	struct list_head node;
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index b5293e5f2af4..8c4e61783441 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -119,7 +119,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  u16 msix_vec)
 {
 	struct virtqueue *vq;
-	unsigned long size;
 	u16 num;
 	int err;
 
@@ -131,29 +130,19 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || ioread32(vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN))
 		return ERR_PTR(-ENOENT);
 
-	info->num = num;
 	info->msix_vector = msix_vec;
 
-	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
-	info->queue = dma_zalloc_coherent(&vp_dev->pci_dev->dev, size,
-					  &info->queue_dma_addr,
-					  GFP_KERNEL);
-	if (info->queue == NULL)
+	/* create the vring */
+	vq = vring_create_virtqueue(index, num,
+				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
+				    true, false, vp_notify, callback, name);
+	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
-	iowrite32(info->queue_dma_addr >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
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
@@ -161,18 +150,15 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
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
-	dma_free_coherent(&vp_dev->pci_dev->dev, size,
-			  info->queue, info->queue_dma_addr);
+	vring_del_virtqueue(vq);
 	return ERR_PTR(err);
 }
 
@@ -180,7 +166,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 {
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	unsigned long size;
 
 	iowrite16(vq->index, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
 
@@ -191,14 +176,10 @@ static void del_vq(struct virtio_pci_vq_info *info)
 		ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
 	}
 
-	vring_del_virtqueue(vq);
-
 	/* Select and deactivate the queue */
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
-	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
-	dma_free_coherent(&vp_dev->pci_dev->dev, size,
-			  info->queue, info->queue_dma_addr);
+	vring_del_virtqueue(vq);
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index fbe0bd1c4881..50b0cd5a501e 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -287,35 +287,6 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 	return vp_ioread16(&vp_dev->common->msix_config);
 }
 
-static size_t vring_pci_size(u16 num)
-{
-	/* We only need a cacheline separation. */
-	return PAGE_ALIGN(vring_size(num, SMP_CACHE_BYTES));
-}
-
-static void *alloc_virtqueue_pages(struct virtio_pci_device *vp_dev,
-				   int *num, dma_addr_t *dma_addr)
-{
-	void *pages;
-
-	/* TODO: allocate each queue chunk individually */
-	for (; *num && vring_pci_size(*num) > PAGE_SIZE; *num /= 2) {
-		pages = dma_zalloc_coherent(
-			&vp_dev->pci_dev->dev, vring_pci_size(*num),
-			dma_addr, GFP_KERNEL|__GFP_NOWARN);
-		if (pages)
-			return pages;
-	}
-
-	if (!*num)
-		return NULL;
-
-	/* Try to get a single page. You are my only hope! */
-	return dma_zalloc_coherent(
-		&vp_dev->pci_dev->dev, vring_pci_size(*num),
-		dma_addr, GFP_KERNEL);
-}
-
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_pci_vq_info *info,
 				  unsigned index,
@@ -347,30 +318,22 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	/* get offset of notification word for this vq */
 	off = vp_ioread16(&cfg->queue_notify_off);
 
-	info->num = num;
 	info->msix_vector = msix_vec;
 
-	info->queue = alloc_virtqueue_pages(vp_dev, &info->num,
-					    &info->queue_dma_addr);
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
-	vp_iowrite64_twopart(info->queue_dma_addr,
+	vp_iowrite16(virtqueue_get_vring_size(vq), &cfg->queue_size);
+	vp_iowrite64_twopart(virtqueue_get_desc_addr(vq),
 			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
-	vp_iowrite64_twopart(info->queue_dma_addr + ((char *)virtqueue_get_avail(vq) - (char *)info->queue),
+	vp_iowrite64_twopart(virtqueue_get_avail_addr(vq),
 			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
-	vp_iowrite64_twopart(info->queue_dma_addr + ((char *)virtqueue_get_used(vq) - (char *)info->queue),
+	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
 	if (vp_dev->notify_base) {
@@ -415,9 +378,6 @@ err_assign_vector:
 		pci_iounmap(vp_dev->pci_dev, (void __iomem __force *)vq->priv);
 err_map_notify:
 	vring_del_virtqueue(vq);
-err_new_queue:
-	dma_free_coherent(&vp_dev->pci_dev->dev, vring_pci_size(info->num),
-			  info->queue, info->queue_dma_addr);
 	return ERR_PTR(err);
 }
 
@@ -462,9 +422,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
 		pci_iounmap(vp_dev->pci_dev, (void __force __iomem *)vq->priv);
 
 	vring_del_virtqueue(vq);
-
-	dma_free_coherent(&vp_dev->pci_dev->dev, vring_pci_size(info->num),
-			  info->queue, info->queue_dma_addr);
 }
 
 static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
-- 
2.4.3
