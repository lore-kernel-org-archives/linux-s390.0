Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52968 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgBUOdw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 09:33:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LEUgLw076870
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 09:33:51 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ya6e6mbny-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 09:33:51 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 14:33:49 -0000
Date: Fri, 21 Feb 2020 15:33:40 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200220161309.GB12709@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220161309.GB12709@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200221153340.4cdcde81.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Thu, 20 Feb 2020 17:13:09 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 867c7ebd3f10..fafc8f924955 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  	if (!virtio_has_iommu_quirk(vdev))
> >  		return true;
> >  
> > +	if (force_dma_unencrypted(&vdev->dev))
> > +		return true;
> 
> Hell no.  This is a detail of the platform DMA direct implementation.

I beg to differ. If it was a detail of the DMA direct implementation, it
should have/would have been private to kernel/dma/direct.c. 

A look at 

$ git grep -e force_dma_unencrypted
arch/powerpc/include/asm/mem_encrypt.h:static inline bool force_dma_unencrypted(struct device *dev)
arch/s390/mm/init.c:bool force_dma_unencrypted(struct device *dev)
arch/x86/mm/mem_encrypt.c:bool force_dma_unencrypted(struct device *dev)
include/linux/dma-direct.h:bool force_dma_unencrypted(struct device *dev);
include/linux/dma-direct.h:static inline bool force_dma_unencrypted(struct device *dev)
kernel/dma/direct.c:    if (force_dma_unencrypted(dev))
kernel/dma/direct.c:    if (force_dma_unencrypted(dev))
kernel/dma/direct.c:        !force_dma_unencrypted(dev)) {
kernel/dma/direct.c:    if (force_dma_unencrypted(dev))
kernel/dma/direct.c:    if (force_dma_unencrypted(dev))
kernel/dma/direct.c:        !force_dma_unencrypted(dev)) {
kernel/dma/direct.c:    if (force_dma_unencrypted(dev))

tells you, that force_dma_unencrypted() is *consumed* by dma direct, but
*provided* by the memory encryption or memory management code.
I.e. platform code tells the dma (direct) code what decisions to make
under certain circumstances.

Consider what would we have to do to make PCI devices do I/O trough
pages that were shared when the guest is running in a protected VM. The
s390_pci_dma_ops would also need to know whether to 'force dma uencrypted'
or not, and it's the exact same logic. I doubt simply using DMA direct
for zPCI would do, because we still have to do all the Z specific IOMMU
management.

> Drivers have no business looking at this flag, and virtio finally needs
> to be fixed to use the DMA API properly for everything but legacy devices.

See the follow on discussion with David Gibson. In short: I'm in favor
of always using DMA API iff we keep conformance with the VIRTIO spec and
if it does not imply any degradations for s390 (virtio-ccw), or any
other regressions.

> 
> No amount of desparate hacks is going to fix that fundamental problem,
> and I'm starting to get really sick and tired of all the crap patches
> published in this area.

I don't think I deserve the offensive language.

AFAIU you have a positive attitude towards the idea, that 
!F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio' 
should be scrapped. 

I would like to accomplish that without adverse effects to virtio-ccw
(because caring for virtio-ccw is a part of job description).

Regards,
Halil
