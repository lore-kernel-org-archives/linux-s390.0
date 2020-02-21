Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 21 Feb 2020 14:31:21 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <8194d502-07d8-b798-a2b5-606a8c05b895@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220161309.GB12709@lst.de>
        <20200221025915.GB2298@umbus.fritz.box>
        <8194d502-07d8-b798-a2b5-606a8c05b895@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200221143121.618134e8.pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, 21 Feb 2020 11:41:57 +0800
Jason Wang <jasowang@redhat.com> wrote:

> > I *think* what you are suggesting here is that virtio devices that
> > have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> > DMA API treats IOVA==PA, which will satisfy what the device expects.  
> 
> 
> Can this work for swiotlb?

It works on s390. I guess it would be the responsibility of however
provides the dma ops for the virtio device to ensure that if 
!F_IOMMU_PLATFORM the addresses are GPA like *mandated* by the VIRTIO
specification.

Regards,
Halil
