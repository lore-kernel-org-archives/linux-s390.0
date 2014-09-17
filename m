From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: [PATCH v5 2/3] virtio_pci: Use the DMA API for virtqueues when
	possible
Date: Wed, 17 Sep 2014 09:09:45 -0700
Message-ID: <20140917160944.GA11600@ovro.caltech.edu>
References: <cover.1410931077.git.luto@amacapital.net>
	<6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <6c31406005160303a7ee291a933c267f8e55fa85.1410931077.git.luto@amacapital.net>
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
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux390@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 16, 2014 at 10:22:27PM -0700, Andy Lutomirski wrote:
> On non-PPC systems, virtio_pci should use the DMA API.  This fixes
> virtio_pci on Xen.  On PPC, using the DMA API would break things, so
> we need to preserve the old behavior.
> 
> The big comment in this patch explains the considerations in more
> detail.
> 
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> ---
>  drivers/virtio/virtio_pci.c | 90 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 81 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index a1f299fa4626..8ddb0a641878 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -80,8 +80,10 @@ struct virtio_pci_vq_info
>  	/* the number of entries in the queue */
>  	int num;
>  
> -	/* the virtual address of the ring queue */
> -	void *queue;
> +	/* the ring queue */
> +	void *queue;			/* virtual address */
> +	dma_addr_t queue_dma_addr;	/* bus address */
> +	bool use_dma_api;		/* are we using the DMA API? */
>  
>  	/* the list node for the virtqueues list */
>  	struct list_head node;
> @@ -388,6 +390,50 @@ static int vp_request_intx(struct virtio_device *vdev)
>  	return err;
>  }
>  
> +static bool vp_use_dma_api(void)
> +{
> +	/*
> +	 * Due to limitations of the DMA API, we only have two choices:
> +	 * use the DMA API (e.g. set up IOMMU mappings or apply Xen's
> +	 * physical-to-machine translation) or use direct physical
> +	 * addressing.  Furthermore, there's no sensible way yet for the
> +	 * PCI bus code to tell us whether we're supposed to act like a
> +	 * normal PCI device (and use the DMA API) or to do something
> +	 * else.  So we're stuck with heuristics here.
> +	 *
> +	 * In general, we would prefer to use the DMA API, since we
> +	 * might be driving a physical device, and such devices *must*
> +	 * use the DMA API if there is an IOMMU involved.
> +	 *
> +	 * On x86, there are no physically-mapped emulated virtio PCI
> +	 * devices that live behind an IOMMU.  On ARM, there don't seem
> +	 * to be any hypervisors that use virtio_pci (as opposed to
> +	 * virtio_mmio) that also emulate an IOMMU.  So using the DMI

Hi,

I noticed a typo here. It should say "DMA" not "DMI". Just thought I'd
point it out.

Ira

> +	 * API is safe.
> +	 *
> +	 * On PowerPC, it's the other way around.  There usually is an
> +	 * IOMMU between us and the virtio PCI device, but the device is
> +	 * probably emulated and ignores the IOMMU.  Unfortunately, we
> +	 * can't tell whether we're talking to an emulated device or to
> +	 * a physical device that really lives behind the IOMMU.  That
> +	 * means that we're stuck with ignoring the DMA API.
> +	 */
> +
> +#ifdef CONFIG_PPC
> +	return false;
> +#else
> +	/*
> +	 * Minor optimization: if the platform promises to have physical
> +	 * PCI DMA, we turn off DMA mapping in virtio_ring.  If the
> +	 * platform's DMA API implementation is well optimized, this
> +	 * should have almost no effect, but we already have a branch in
> +	 * the vring code, and we can avoid any further indirection with
> +	 * very little effort.
> +	 */
> +	return !PCI_DMA_BUS_IS_PHYS;
> +#endif
> +}
> +
>  static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>  				  void (*callback)(struct virtqueue *vq),
>  				  const char *name,
> @@ -416,21 +462,30 @@ static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
>  
>  	info->num = num;
>  	info->msix_vector = msix_vec;
> +	info->use_dma_api = vp_use_dma_api();
>  
> -	size = PAGE_ALIGN(vring_size(num, VIRTIO_PCI_VRING_ALIGN));
> -	info->queue = alloc_pages_exact(size, GFP_KERNEL|__GFP_ZERO);
> +	size = vring_size(num, VIRTIO_PCI_VRING_ALIGN);
> +	if (info->use_dma_api) {
> +		info->queue = dma_zalloc_coherent(vdev->dev.parent, size,
> +						  &info->queue_dma_addr,
> +						  GFP_KERNEL);
> +	} else {
> +		info->queue = alloc_pages_exact(PAGE_ALIGN(size),
> +						GFP_KERNEL|__GFP_ZERO);
> +		info->queue_dma_addr = virt_to_phys(info->queue);
> +	}
>  	if (info->queue == NULL) {
>  		err = -ENOMEM;
>  		goto out_info;
>  	}
>  
>  	/* activate the queue */
> -	iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
> +	iowrite32(info->queue_dma_addr >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
>  		  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>  
>  	/* create the vring */
>  	vq = vring_new_virtqueue(index, info->num, VIRTIO_PCI_VRING_ALIGN, vdev,
> -				 true, false, info->queue,
> +				 true, info->use_dma_api, info->queue,
>  				 vp_notify, callback, name);
>  	if (!vq) {
>  		err = -ENOMEM;
> @@ -463,7 +518,12 @@ out_assign:
>  	vring_del_virtqueue(vq);
>  out_activate_queue:
>  	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> -	free_pages_exact(info->queue, size);
> +	if (info->use_dma_api) {
> +		dma_free_coherent(vdev->dev.parent, size,
> +				  info->queue, info->queue_dma_addr);
> +	} else {
> +		free_pages_exact(info->queue, PAGE_ALIGN(size));
> +	}
>  out_info:
>  	kfree(info);
>  	return ERR_PTR(err);
> @@ -493,8 +553,13 @@ static void vp_del_vq(struct virtqueue *vq)
>  	/* Select and deactivate the queue */
>  	iowrite32(0, vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
>  
> -	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_PCI_VRING_ALIGN));
> -	free_pages_exact(info->queue, size);
> +	size = vring_size(info->num, VIRTIO_PCI_VRING_ALIGN);
> +	if (info->use_dma_api) {
> +		dma_free_coherent(vq->vdev->dev.parent, size,
> +				  info->queue, info->queue_dma_addr);
> +	} else {
> +		free_pages_exact(info->queue, PAGE_ALIGN(size));
> +	}
>  	kfree(info);
>  }
>  
> @@ -713,6 +778,13 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	if (err)
>  		goto out;
>  
> +	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> +	if (err)
> +		err = dma_set_mask_and_coherent(&pci_dev->dev,
> +						DMA_BIT_MASK(32));
> +	if (err)
> +		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +
>  	err = pci_request_regions(pci_dev, "virtio-pci");
>  	if (err)
>  		goto out_enable_device;
> -- 
> 1.9.3
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
