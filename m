Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56386 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgBUQgs (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 11:36:48 -0500
Date: Fri, 21 Feb 2020 17:36:45 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221163645.GB10054@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220160606.53156-3-pasic@linux.ibm.com> <20200220161309.GB12709@lst.de> <20200221025915.GB2298@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221025915.GB2298@umbus.fritz.box>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, Feb 21, 2020 at 01:59:15PM +1100, David Gibson wrote:
> > Hell no.  This is a detail of the platform DMA direct implementation.
> > Drivers have no business looking at this flag, and virtio finally needs
> > to be fixed to use the DMA API properly for everything but legacy devices.
> 
> So, this patch definitely isn't right as it stands, but I'm struggling
> to understand what it is you're saying is the right way.
> 
> By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> see how being a legacy device or not relates to use of the DMA API.

No.   "legacy" is anything that does not set F_ACCESS_PLATFORM.

> I *think* what you are suggesting here is that virtio devices that
> have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> DMA API treats IOVA==PA, which will satisfy what the device expects.
> Then the virtio driver can use the DMA API the same way for both
> F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.

No.  Those should just keep using the existing legacy non-dma ops
case and be done with it.  No changes to that and most certainly
no new features.
