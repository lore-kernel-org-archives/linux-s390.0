Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41102 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfJGQHj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Oct 2019 12:07:39 -0400
Date: Mon, 7 Oct 2019 18:07:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] s390/cio: fix virtio-ccw DMA without PV
Message-ID: <20191007180732.7a38ff0b.cohuck@redhat.com>
In-Reply-To: <20190930153803.7958-1-pasic@linux.ibm.com>
References: <20190930153803.7958-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Mon, 30 Sep 2019 17:38:02 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Commit 37db8985b211 ("s390/cio: add basic protected virtualization
> support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
> Protected Virtualization (PV) guests. The problem is that the dma_mask

Hm, I should probably add that to my test configs.

> of the ccw device, which is used by virtio core, gets changed from 64 to
> 31 bit, because some of the DMA allocations do require 31 bit
> addressable memory. For PV the only drawback is that some of the virtio
> structures must end up in ZONE_DMA because we have the bounce the
> buffers mapped via DMA API anyway.
> 
> But for non PV guests we have a problem: because of the 31 bit mask
> guests bigger than 2G are likely to try bouncing buffers. The swiotlb
> however is only initialized for PV guests, because we don't want to
> bounce anything for non PV guests. The first such map kills the guest.
> 
> Since the DMA API won't allow us to specify for each allocation whether
> we need memory from ZONE_DMA (31 bit addressable) or any DMA capable
> memory will do, let us use coherent_dma_mask (which is used for
> allocations) to force allocating form ZONE_DMA while changing dma_mask
> to DMA_BIT_MASK(64) so that at least the streaming API will regard
> the whole memory DMA capable.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
> ---
> 
> v1 --> v2:
> * Fixed comment: dropped the sentence with workaround.
> 
> The idea of enabling the client code to specify on s390 whether a chunk
> of allocated DMA memory is to be allocated form ZONE_DMA for each
> allocation was not well received [1]. 
> 
> Making the streaming API threat all addresses as DMA capable, while
> restricting the DMA API allocations to  ZONE_DMA (regardless of needed
> or not) is the next best thing we can do (from s390 perspective).
> 
> [1] https://lkml.org/lkml/2019/9/23/531 
> ---
> ---
>  drivers/s390/cio/cio.h    | 1 +
>  drivers/s390/cio/css.c    | 7 ++++++-
>  drivers/s390/cio/device.c | 2 +-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
