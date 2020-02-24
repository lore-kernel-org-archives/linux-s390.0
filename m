Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:39240 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBXRRA (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 12:17:00 -0500
Date: Mon, 24 Feb 2020 18:16:57 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20200224171657.GB7278@lst.de>
References: <20200220160606.53156-1-pasic@linux.ibm.com> <20200220160606.53156-3-pasic@linux.ibm.com> <20200220161309.GB12709@lst.de> <20200221153340.4cdcde81.pasic@linux.ibm.com> <20200222140408-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222140408-mutt-send-email-mst@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, Michael Mueller <mimu@linux.ibm.com>

On Sat, Feb 22, 2020 at 02:07:58PM -0500, Michael S. Tsirkin wrote:
> On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > AFAIU you have a positive attitude towards the idea, that 
> > !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio' 
> > should be scrapped. 
> > 
> > I would like to accomplish that without adverse effects to virtio-ccw
> > (because caring for virtio-ccw is a part of job description).
> > 
> > Regards,
> > Halil
> 
> It is possible, in theory. IIRC the main challenge is that DMA API
> has overhead of indirect function calls even when all it
> does it return back the PA without changes.

That overhead is gone now, the DMA direct calls are direct calls these
days.
