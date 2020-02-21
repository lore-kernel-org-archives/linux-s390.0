Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgBUSDp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 13:03:45 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LI15CS106235
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 13:03:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8ubrak2n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 13:03:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 18:03:42 -0000
Date: Fri, 21 Feb 2020 19:03:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200221104901-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220154904-mutt-send-email-mst@kernel.org>
        <20200221141230.13eebc35.pasic@linux.ibm.com>
        <20200221104901-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200221190334.3b03d296.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, 21 Feb 2020 10:56:45 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 21, 2020 at 02:12:30PM +0100, Halil Pasic wrote:
> > On Thu, 20 Feb 2020 15:55:14 -0500
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
[..]
> > > To summarize, the necessary conditions for a hack along these lines
> > > (using DMA API without VIRTIO_F_ACCESS_PLATFORM) are that we detect that:
> > > 
> > >   - secure guest mode is enabled - so we know that since we don't share
> > >     most memory regular virtio code won't
> > >     work, even though the buggy hypervisor didn't set VIRTIO_F_ACCESS_PLATFORM
> > 
> > force_dma_unencrypted(&vdev->dev) is IMHO exactly about this.
> > 
> > >   - DMA API is giving us addresses that are actually also physical
> > >     addresses
> > 
> > In case of s390 this is given.
> > I talked with the power people before
> > posting this, and they ensured me they can are willing to deal with
> > this. I was hoping to talk abut this with the AMD SEV people here (hence
> > the cc).
> 
> We'd need a part of DMA API that promises this though. Platform
> maintainers aren't going to go out of their way to do the
> right thing just for virtio, and I can't track all arches
> to make sure they don't violate virtio requirements.
> 

One would have to track only the arches that have
force_dma_unecrypted(), and generally speaking the arches shall make
sure the DMA ops are suitable, whatever that means in the given context.

> > 
> > >   - Hypervisor is buggy and didn't enable VIRTIO_F_ACCESS_PLATFORM
> > > 
> > 
> > I don't get this point. The argument where the hypervisor is buggy is a
> > bit hard to follow for me. If hypervisor is buggy we have already lost
> > anyway most of the time, or?
> 
> If VIRTIO_F_ACCESS_PLATFORM is set then things just work.  If
> VIRTIO_F_ACCESS_PLATFORM is clear device is supposed to have access to
> all of memory.  You can argue in various ways but it's easier to just
> declare a behaviour that violates this a bug. Which might still be worth
> working around, for various reasons.
> 


I don't agree. The spec explicitly states "If this feature bit is set
to 0, then the device has same access to memory addresses supplied to it
as the driver has." That ain't any guest memory, but the addresses
supplied to it. BTW this is how channel I/O works as well: the channel
program authorizes the device to use the memory locations specified by
the channel program, for as long as the channel program is executed.
That's how channel I/O does isolation without an architected IOMMU.

Can you please show me the words in the specification that say, the
device has to have access to the entire guest memory all the time?

Maybe I have to understand all the intentions behind
VIRTIO_F_ACCESS_PLATFORM better. I've read the spec several times, but I
still have the feeling, when we discuss, that I didn't get it right.
IOMMUs and PCI style DMA are unfortunately not my bread and butter.

I only know that the devices do not need any new device capability (I
assume VIRTIO_F_ACCESS_PLATFORM does express a device capability), to
work with protected virtualization. Unless one defines
VIRTIO_F_ACCESS_PLATFORM is the capability that the device won't poke
*arbitrary* guest memory.  From that perspective mandating the flag
feels wrong. (CCW devices are never allowed to poke arbitrary
memory.)

Yet, if VIRTIO_F_ACCESS_PLATFORM is a flag that every nice and modern
virtio device should have (i.e. a lack of it means kida broken), then I
have the feeling virtio-ccw should probably evolve in the direction, that
having VIRTIO_F_ACCESS_PLATFORM set does not hurt.

I have to think some more.

> 
> > > I don't see how this patch does this.
> > 
> > I do get your point. I don't know of a good way to check that DMA API
> > is giving us addresses that are actually physical addresses, and the
> > situation you describe definitely has some risk to it.
> 
> One way would be to extend the DMA API with such an API.

Seems Christoph does not like that idea.

> 
> Another would be to make virtio always use DMA API
> and hide the logic in there.

I thought Christoph wants that, but I was wrong.

> This second approach is not easy, in particular since DMA API adds
> a bunch of overhead which we need to find ways to
> measure and mitigate.
> 

Agreed. From s390 perspective, I think it ain't to bad if we get GFP_DMA.

Many thanks for your patience!
Halil

[..]
