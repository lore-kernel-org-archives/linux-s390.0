Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56364 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgBUQf1 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 11:35:27 -0500
Date: Fri, 21 Feb 2020 17:35:23 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200221163523.GA10054@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220160606.53156-3-pasic@linux.ibm.com> <20200220154904-mutt-send-email-mst@kernel.org> <20200221141230.13eebc35.pasic@linux.ibm.com> <20200221104901-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104901-mutt-send-email-mst@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Fri, Feb 21, 2020 at 10:56:45AM -0500, Michael S. Tsirkin wrote:
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

There is no way the DMA API is going to promise that you.  All kinds
of platforms have offsets to DMA, and they are communicated through
interfaces like the device tree or ACPI.  But the good thing is that
your hypervisors is in control of that, neither the DMA API nor
virtio have any business to interfer with that.  In fact for harware
virtio device we might need such an offset for them to work on
lots of SOCs.
