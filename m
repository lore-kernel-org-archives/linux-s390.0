Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr760088.outbound.protection.outlook.com ([40.107.76.88]:49345
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726716AbfK2B6F (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 Nov 2019 20:58:05 -0500
Date: Fri, 29 Nov 2019 01:57:55 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Message-ID: <20191129015730.GA13084@ashkalra_ubuntu_server>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
 <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
 <20191126184527.GA10481@lst.de>
 <20191128004225.GA11539@ashkalra_ubuntu_server>
 <20191128070538.GB20274@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128070538.GB20274@lst.de>
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>

On Thu, Nov 28, 2019 at 08:05:38AM +0100, Christoph Hellwig wrote:
> On Thu, Nov 28, 2019 at 12:42:25AM +0000, Ashish Kalra wrote:
> > Why can't we leverage CMA instead of SWIOTLB for DMA when SEV is
> > enabled, CMA is well integerated with the DMA subsystem and handles
> > encrypted pages when force_dma_unencrypted() returns TRUE. 
> > 
> > Though, CMA might face the same issues as SWIOTLB bounce buffers, it's
> > size is similarly setup statically as SWIOTLB does or can be set as a 
> > percentage of the available system memory.
> 
> How is CMA integrated with SEV?  CMA just gives a contiguous chunk
> of memory, which still needs to be remapped as unencrypted before
> returning it to the user.

Looking at the implementation, i see that CMA is accessible using
dma_alloc_coherent() and the buffer allocated by dma_alloc_coherent()
either using the CMA or the page allocator, will be marked/tagged as
unencrypted and returned to the user.

But for dma_map_xx() interfaces, the memory will need be remapped as
unencrypted memory (as you mentioned).

Thanks,
Ashish
