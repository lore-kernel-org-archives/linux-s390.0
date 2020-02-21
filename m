Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgBUSHN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 13:07:13 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LI5Axd001974
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 13:07:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8ubybx4y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 13:07:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 18:07:09 -0000
Date: Fri, 21 Feb 2020 19:07:02 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
In-Reply-To: <20200221104724-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-2-pasic@linux.ibm.com>
        <20200220161146.GA12709@lst.de>
        <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
        <20200220163135.GA13192@lst.de>
        <20200221032727.GC2298@umbus.fritz.box>
        <20200221140639.54928efe.pasic@linux.ibm.com>
        <20200221104724-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200221190702.68fd57fc.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, 21 Feb 2020 10:48:15 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> > On Fri, 21 Feb 2020 14:27:27 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> > 
> > > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > > > > >From a users perspective it makes absolutely perfect sense to use the
> > > > > bounce buffers when they are NEEDED. 
> > > > > Forcing the user to specify iommu_platform just because you need bounce buffers
> > > > > really feels wrong. And obviously we have a severe performance issue
> > > > > because of the indirections.
> > > > 
> > > > The point is that the user should not have to specify iommu_platform.
> > > > We need to make sure any new hypervisor (especially one that might require
> > > > bounce buffering) always sets it,
> > > 
> > > So, I have draft qemu patches which enable iommu_platform by default.
> > > But that's really because of other problems with !iommu_platform, not
> > > anything to do with bounce buffering or secure VMs.
> > > 
> > > The thing is that the hypervisor *doesn't* require bounce buffering.
> > > In the POWER (and maybe s390 as well) models for Secure VMs, it's the
> > > *guest*'s choice to enter secure mode, so the hypervisor has no reason
> > > to know whether the guest needs bounce buffering.  As far as the
> > > hypervisor and qemu are concerned that's a guest internal detail, it
> > > just expects to get addresses it can access whether those are GPAs
> > > (iommu_platform=off) or IOVAs (iommu_platform=on).
> > 
> > I very much agree!
> > 
> > > 
> > > > as was a rather bogus legacy hack
> > > 
> > > It was certainly a bad idea, but it was a bad idea that went into a
> > > public spec and has been widely deployed for many years.  We can't
> > > just pretend it didn't happen and move on.
> > > 
> > > Turning iommu_platform=on by default breaks old guests, some of which
> > > we still care about.  We can't (automatically) do it only for guests
> > > that need bounce buffering, because the hypervisor doesn't know that
> > > ahead of time.
> > 
> > Turning iommu_platform=on for virtio-ccw makes no sense whatsover,
> > because for CCW I/O there is no such thing as IOMMU and the addresses
> > are always physical addresses.
> 
> Fix the name then. The spec calls is ACCESS_PLATFORM now, which
> makes much more sense.

I don't quite get it. Sorry. Maybe I will revisit this later.

Regards,
Halil

> 
> > > 
> > > > that isn't extensibe for cases that for example require bounce buffering.
> > > 
> > > In fact bounce buffering isn't really the issue from the hypervisor
> > > (or spec's) point of view.  It's the fact that not all of guest memory
> > > is accessible to the hypervisor.  Bounce buffering is just one way the
> > > guest might deal with that.
> > > 
> > 
> > Agreed.
> > 
> > Regards,
> > Halil
> > 
> > 
> > 
> 
> 
