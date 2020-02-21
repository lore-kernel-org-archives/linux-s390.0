Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56415 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgBUQjm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 11:39:42 -0500
Date: Fri, 21 Feb 2020 17:39:38 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221163938.GC10054@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220160606.53156-3-pasic@linux.ibm.com> <20200220161309.GB12709@lst.de> <20200221153340.4cdcde81.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221153340.4cdcde81.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > Hell no.  This is a detail of the platform DMA direct implementation.
> 
> I beg to differ. If it was a detail of the DMA direct implementation, it
> should have/would have been private to kernel/dma/direct.c. 

It can't given that platforms have to implement it.  It is an arch hook
for dma-direct.

> Consider what would we have to do to make PCI devices do I/O trough
> pages that were shared when the guest is running in a protected VM. The
> s390_pci_dma_ops would also need to know whether to 'force dma uencrypted'
> or not, and it's the exact same logic. I doubt simply using DMA direct
> for zPCI would do, because we still have to do all the Z specific IOMMU
> management.

And your IOMMU can't deal with the encryption bit?  In the case we
could think of allowing IOMMU implementation to access it.  But the
point that it is an internal detail of the DMA implementation and by
now means for drivers.
