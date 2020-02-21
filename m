Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728824AbgBUO4O (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 09:56:14 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LEtfxc002138
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 09:56:12 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8uc0wmyg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 09:56:12 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 14:56:10 -0000
Date: Fri, 21 Feb 2020 15:56:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
In-Reply-To: <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20200221155602.4de41fa7.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, 21 Feb 2020 14:22:26 +0800
Jason Wang <jasowang@redhat.com> wrote:

> 
> On 2020/2/21 上午12:06, Halil Pasic wrote:
> > Currently if one intends to run a memory protection enabled VM with
> > virtio devices and linux as the guest OS, one needs to specify the
> > VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the guest
> > linux use the DMA API, which in turn handles the memory
> > encryption/protection stuff if the guest decides to turn itself into
> > a protected one. This however makes no sense due to multiple reasons:
> > * The device is not changed by the fact that the guest RAM is
> > protected. The so called IOMMU bypass quirk is not affected.
> > * This usage is not congruent with  standardised semantics of
> > VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> > for using DMA API in virtio (orthogonal with respect to what is
> > expressed by VIRTIO_F_IOMMU_PLATFORM).
> >
> > This series aims to decouple 'have to use DMA API because my (guest) RAM
> > is protected' and 'have to use DMA API because the device told me
> > VIRTIO_F_IOMMU_PLATFORM'.
> >
> > Please find more detailed explanations about the conceptual aspects in
> > the individual patches. There is however also a very practical problem
> > that is addressed by this series.
> >
> > For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following side
> > effect The vhost code assumes it the addresses on the virtio descriptor
> > ring are not guest physical addresses but iova's, and insists on doing a
> > translation of these regardless of what transport is used (e.g. whether
> > we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7855b
> > "vhost: new device IOTLB API".) On s390 this results in severe
> > performance degradation (c.a. factor 10).
> 
> 
> Do you see a consistent degradation on the performance, or it only 
> happen when for during the beginning of the test?
> 

AFAIK the degradation is consistent.

> 
> > BTW with ccw I/O there is
> > (architecturally) no IOMMU, so the whole address translation makes no
> > sense in the context of virtio-ccw.
> 
> 
> I suspect we can do optimization in qemu side.
> 
> E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
> 
> If this makes sense, I can draft patch to see if there's any difference.

Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
then necessary translation) for virtio-ccw altogether. But Michael
voiced his opinion that we should mandate F_IOMMU_PLATFORM for devices
that could be used with guests running in protected mode. I don't share
his opinion, but that's an ongoing discussion.

Should we end up having to do translation from IOVA in vhost, we are
very interested in that translation being fast and efficient.

In that sense we would be very happy to test any optimization that aim
into that direction.

Thank you very much for your input!

Regards,
Halil

> 
> Thanks
> 
> 
> >
> > Halil Pasic (2):
> >    mm: move force_dma_unencrypted() to mem_encrypt.h
> >    virtio: let virtio use DMA API when guest RAM is protected
> >
> >   drivers/virtio/virtio_ring.c |  3 +++
> >   include/linux/dma-direct.h   |  9 ---------
> >   include/linux/mem_encrypt.h  | 10 ++++++++++
> >   3 files changed, 13 insertions(+), 9 deletions(-)
> >
> >
> > base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
> 
