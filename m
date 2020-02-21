Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728177AbgBUPsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 10:48:31 -0500
Received: by mail-qv1-f69.google.com with SMTP id dc2so1632443qvb.7
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 07:48:27 -0800 (PST)
Date: Fri, 21 Feb 2020 10:48:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/2] mm: move force_dma_unencrypted() to mem_encrypt.h
Message-ID: <20200221104724-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-2-pasic@linux.ibm.com>
 <20200220161146.GA12709@lst.de>
 <4369f099-e4e4-4a58-b38b-642cf53ccca6@de.ibm.com>
 <20200220163135.GA13192@lst.de>
 <20200221032727.GC2298@umbus.fritz.box>
 <20200221140639.54928efe.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221140639.54928efe.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Christoph Hellwig <hch@lst.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, Feb 21, 2020 at 02:06:39PM +0100, Halil Pasic wrote:
> On Fri, 21 Feb 2020 14:27:27 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> 
> > On Thu, Feb 20, 2020 at 05:31:35PM +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 20, 2020 at 05:23:20PM +0100, Christian Borntraeger wrote:
> > > > >From a users perspective it makes absolutely perfect sense to use the
> > > > bounce buffers when they are NEEDED. 
> > > > Forcing the user to specify iommu_platform just because you need bounce buffers
> > > > really feels wrong. And obviously we have a severe performance issue
> > > > because of the indirections.
> > > 
> > > The point is that the user should not have to specify iommu_platform.
> > > We need to make sure any new hypervisor (especially one that might require
> > > bounce buffering) always sets it,
> > 
> > So, I have draft qemu patches which enable iommu_platform by default.
> > But that's really because of other problems with !iommu_platform, not
> > anything to do with bounce buffering or secure VMs.
> > 
> > The thing is that the hypervisor *doesn't* require bounce buffering.
> > In the POWER (and maybe s390 as well) models for Secure VMs, it's the
> > *guest*'s choice to enter secure mode, so the hypervisor has no reason
> > to know whether the guest needs bounce buffering.  As far as the
> > hypervisor and qemu are concerned that's a guest internal detail, it
> > just expects to get addresses it can access whether those are GPAs
> > (iommu_platform=off) or IOVAs (iommu_platform=on).
> 
> I very much agree!
> 
> > 
> > > as was a rather bogus legacy hack
> > 
> > It was certainly a bad idea, but it was a bad idea that went into a
> > public spec and has been widely deployed for many years.  We can't
> > just pretend it didn't happen and move on.
> > 
> > Turning iommu_platform=on by default breaks old guests, some of which
> > we still care about.  We can't (automatically) do it only for guests
> > that need bounce buffering, because the hypervisor doesn't know that
> > ahead of time.
> 
> Turning iommu_platform=on for virtio-ccw makes no sense whatsover,
> because for CCW I/O there is no such thing as IOMMU and the addresses
> are always physical addresses.

Fix the name then. The spec calls is ACCESS_PLATFORM now, which
makes much more sense.

> > 
> > > that isn't extensibe for cases that for example require bounce buffering.
> > 
> > In fact bounce buffering isn't really the issue from the hypervisor
> > (or spec's) point of view.  It's the fact that not all of guest memory
> > is accessible to the hypervisor.  Bounce buffering is just one way the
> > guest might deal with that.
> > 
> 
> Agreed.
> 
> Regards,
> Halil
> 
> 
> 
