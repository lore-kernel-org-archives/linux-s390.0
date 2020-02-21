Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgBUSQz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 13:16:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LIGfvJ140002
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 13:16:54 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uc2uk92-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 13:16:53 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 18:16:34 -0000
Date: Fri, 21 Feb 2020 19:16:25 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200221163938.GC10054@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220161309.GB12709@lst.de>
        <20200221153340.4cdcde81.pasic@linux.ibm.com>
        <20200221163938.GC10054@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Message-Id: <20200221191625.1d589ea7.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, 21 Feb 2020 17:39:38 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > > Hell no.  This is a detail of the platform DMA direct implementation.
> > 
> > I beg to differ. If it was a detail of the DMA direct implementation, it
> > should have/would have been private to kernel/dma/direct.c. 
> 
> It can't given that platforms have to implement it.  It is an arch hook
> for dma-direct.
> 
> > Consider what would we have to do to make PCI devices do I/O trough
> > pages that were shared when the guest is running in a protected VM. The
> > s390_pci_dma_ops would also need to know whether to 'force dma uencrypted'
> > or not, and it's the exact same logic. I doubt simply using DMA direct
> > for zPCI would do, because we still have to do all the Z specific IOMMU
> > management.
> 
> And your IOMMU can't deal with the encryption bit?

There is no encrypt bit, and our memory is not encrypted, but protected.
Means e.g. when buggy/malicious hypervisor tries to read a protected
page it wont get ciphertext, but a slap on its finger. In order do make
memory accessible to the hypervisor (or another guest, or a real device)
the guest must make a so called utlravisor call (talk to the firmware)
and share the respective page.

We tapped into the memory encryption infrastructure, because both is
protecting the guest memory form the host (just by different means), and
because it made no sense to build up something in parallel when most of
the stuff we need was already there. But most unfortunately the names
are deceiving when it comes to s390 protected virtualization and it's
guest I/O enablement.


>  In the case we
> could think of allowing IOMMU implementation to access it.  But the
> point that it is an internal detail of the DMA implementation and by
> now means for drivers.

From the perspective, that any driver that does anything remotely DMAish,
that is, some external entity (possibly a hypervisor, possibly a channel
subsystem, possibly a DMA controller) to should the memory, should do
DMA API first, to make sure, the DMAish goes well, your argument makes
perfect sense. But form that perspective !F_ACCESS_PLATFORM is also a
DMAish. And the virtio spec mandates that !F_ACCESS_PLATFORM implies
GPA's.

For virtio-ccw I want GPA's and not IOVA's on s390, for virtio-pci,
which we also support in general but not with protected virtualization,
well, it's a different story.

With protected visualization however I must make sure all I/O goes
through shared pages. We use swiotlb for that. But then the old
infrastructure won't cut it. Jet we still need GPA's on the ring (with
the extra requirement that the page must be shared). 

DMA API is a nice fit there because we can allocate DMA coherent memory
(such that what comes back from our DMA ops is a GPA), so we have shared
memory that the hypervisor and the guest is allowed to look at
concurrently, and for the buffers that are going to be put on the vring,
we can use the streaming API, which uses bounce buffers. The returned
IOVA (in DMA API speak) is a GPA of the bounce buffer, and the guest is
not allowed to peek until it unmaps, so everything is cozy. But for that
to work, we all (AMD SEV, power, and s390) must go through the DMA API,
because the old infrastructure in virtio core simply won't cut it. And
it has nothing to do with the device. David explained it very well.

My series is about controlling virtio-core's usage of DMA API. I believe,
I did it in a way that doesn't hurt any arch at the moment.

Maybe the conflict can be resolved if the transport gets a say in
whether to use the DMA API or not. In the end the VIRTIO spec does say
that "Whether accesses are actually limited or translated is described
by platform-specific means."

Regards,
Halil






 
