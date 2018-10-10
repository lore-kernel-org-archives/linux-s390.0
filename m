Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
Date: Wed, 10 Oct 2018 15:41:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 2/3] PCI: remove pci_set_dma_seg_boundary
Message-ID: <20181010204152.GH5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181009140824.18667-1-hch@lst.de>
 <20181009140824.18667-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009140824.18667-3-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-pci/>
List-Post: <mailto:linux-pci@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Julian Wiedmann <jwi@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

[+cc s390 network maintainers]

On Tue, Oct 09, 2018 at 04:08:23PM +0200, Christoph Hellwig wrote:
> The two callers can just use dma_set_seg_boundary directly.

I intend to apply this trivial patch, so just FYI.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/probe.c            | 2 +-
>  drivers/s390/net/ism_drv.c     | 2 +-
>  include/linux/pci-dma-compat.h | 9 ---------
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 201f9e5ff55c..fc6340d76814 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2398,7 +2398,7 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
>  	dev->dev.coherent_dma_mask = 0xffffffffull;
>  
>  	pci_set_dma_max_seg_size(dev, 65536);
> -	pci_set_dma_seg_boundary(dev, 0xffffffff);
> +	dma_set_seg_boundary(&dev->dev, 0xffffffff);
>  
>  	/* Fix up broken headers */
>  	pci_fixup_device(pci_fixup_header, dev);
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index c0631895154e..8688c0fff761 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -515,7 +515,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (ret)
>  		goto err_unmap;
>  
> -	pci_set_dma_seg_boundary(pdev, SZ_1M - 1);
> +	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
>  	pci_set_dma_max_seg_size(pdev, SZ_1M);
>  	pci_set_master(pdev);
>  
> diff --git a/include/linux/pci-dma-compat.h b/include/linux/pci-dma-compat.h
> index c3f1b44ade29..558a109ab497 100644
> --- a/include/linux/pci-dma-compat.h
> +++ b/include/linux/pci-dma-compat.h
> @@ -125,12 +125,6 @@ static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
>  {
>  	return dma_set_max_seg_size(&dev->dev, size);
>  }
> -
> -static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
> -					   unsigned long mask)
> -{
> -	return dma_set_seg_boundary(&dev->dev, mask);
> -}
>  #else
>  static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask)
>  { return -EIO; }
> @@ -139,9 +133,6 @@ static inline int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask)
>  static inline int pci_set_dma_max_seg_size(struct pci_dev *dev,
>  					   unsigned int size)
>  { return -EIO; }
> -static inline int pci_set_dma_seg_boundary(struct pci_dev *dev,
> -					   unsigned long mask)
> -{ return -EIO; }
>  #endif
>  
>  #endif
> -- 
> 2.19.0
> 
