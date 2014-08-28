From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v3 2/5] virtio_pci: Use the DMA API for virtqueues
Date: Thu, 28 Aug 2014 16:51:41 -0700
Message-ID: <d07f711ac2fd98db66c2afc28c4cf38d7485eda8.1409269667.git.luto@amacapital.net>
References: <cover.1409269667.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1409269667.git.luto@amacapital.net>
In-Reply-To: <cover.1409269667.git.luto@amacapital.net>
References: <cover.1409269667.git.luto@amacapital.net>
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
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, linux390@de.ibm.com, Andy Lutomirski <luto@amacapital.net>
List-ID: <linux-s390.vger.kernel.org>

A virtqueue is a coherent DMA mapping.  Use the DMA API for it.
This fixes virtio_pci on Xen.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 drivers/virtio/virtio_pci.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a1f299fa4626..d0eee85496b5 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -80,8 +80,9 @@ struct virtio_pci_vq_info
 	/* the number of entries in the queue */
 	int num;
 
-	/* the virtual address of the ring queue */
-	void *queue;
+	/* the ring queue */
+	void *queue;			/* virtual address */
+	dma_addr_t queue_dma_addr;	/* bus address */
 
 	/* the list node for the virtqueues list */
 	struct list_head node;
@@ -417,20 +418,26 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
 	info->num = num;
 	info->msix_vector = msix_vec;
 
-	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
-	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
+	size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
+	info->queue = dma_zalloc_coherent(vdev->dev.parent, size,
+					  &info->queue_dma_addr, GFP_KERNEL);
 	if (info->queue == NULL) {
 		err = -ENOMEM;
 		goto out_info;
 	}
 
 	/* activate the queue */
-	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
+	iowrite32(info->queue_dma_addr >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
 		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
-	/* create the vring */
+	/*
+	 * create the vring.  If there is an IOMMU of any sort, including
+	 * Xen paravirt's ersatz IOMMU, use it.  If the host wants physical
+	 * addresses instead of bus addresses, the host shouldn't expose
+	 * an IOMMU.
+	 */
 	vq = vring_new_virtqueue(index, info->num, VIRTIO_PCI_VRING_ALIGN, vdev,
-				 true, false, info->queue,
+				 true, true, info->queue,
 				 vp_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
@@ -463,7 +470,8 @@ out_assign:
 	vring_del_virtqueue(vq);
 out_activate_queue:
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
-	free_pages_exact(info->queue, size);
+	dma_free_coherent(vdev->dev.parent, size,
+			  info->queue, info->queue_dma_addr);
 out_info:
 	kfree(info);
 	return ERR_PTR(err);
@@ -494,7 +502,8 @@ static void vp_del_vq(struct virtqueue *vq)
 	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
 
 	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
-	free_pages_exact(info->queue, size);
+	dma_free_coherent(vq->vdev->dev.parent, size,
+			  info->queue, info->queue_dma_addr);
 	kfree(info);
 }
 
@@ -713,6 +722,13 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (err)
 		goto out;
 
+	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_set_mask_and_coherent(&pci_dev->dev,
+						DMA_BIT_MASK(32));
+	if (err)
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+
 	err = pci_request_regions(pci_dev, "virtio-pci");
 	if (err)
 		goto out_enable_device;
-- 
1.9.3
