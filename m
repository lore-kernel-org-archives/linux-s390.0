Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-eopbgr680063.outbound.protection.outlook.com ([40.107.68.63]:65442
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726984AbfK1Amk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Nov 2019 19:42:40 -0500
Date: Thu, 28 Nov 2019 00:42:25 +0000
From: Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
Message-ID: <20191128004225.GA11539@ashkalra_ubuntu_server>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
 <20191119121022.03aed69a.pasic@linux.ibm.com>
 <20191119080420-mutt-send-email-mst@kernel.org>
 <20191122140827.0ead345c.pasic@linux.ibm.com>
 <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
 <20191126184527.GA10481@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126184527.GA10481@lst.de>
MIME-Version: 1.0
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>

Why can't we leverage CMA instead of SWIOTLB for DMA when SEV is
enabled, CMA is well integerated with the DMA subsystem and handles
encrypted pages when force_dma_unencrypted() returns TRUE. 

Though, CMA might face the same issues as SWIOTLB bounce buffers, it's
size is similarly setup statically as SWIOTLB does or can be set as a 
percentage of the available system memory.

Thanks,
Ashish

Tue, Nov 26, 2019 at 07:45:27PM +0100, Christoph Hellwig wrote:
> On Sat, Nov 23, 2019 at 09:39:08AM -0600, Tom Lendacky wrote:
> > Ideally, having a pool of shared pages for DMA, outside of standard
> > SWIOTLB, might be a good thing.  On x86, SWIOTLB really seems geared
> > towards devices that don't support 64-bit DMA. If a device supports 64-bit
> > DMA then it can use shared pages that reside anywhere to perform the DMA
> > and bounce buffering. I wonder if the SWIOTLB support can be enhanced to
> > support something like this, using today's low SWIOTLB buffers if the DMA
> > mask necessitates it, otherwise using a dynamically sized pool of shared
> > pages that can live anywhere.
> 
> I think that can be done relatively easily.  I've actually been thinking
> of multiple pool support for a whіle to replace the bounce buffering
> in the block layer for ISA devices (24-bit addressing).
> 
> I've also been looking into a dma_alloc_pages interface to help people
> just allocate pages that are always dma addressable, but don't need
> a coherent allocation.  My last version I shared is here:
> 
> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fgit.infradead.org%2Fusers%2Fhch%2Fmisc.git%2Fshortlog%2Frefs%2Fheads%2Fdma_alloc_pages&amp;data=02%7C01%7CAshish.Kalra%40amd.com%7Cc977f3861fdd40b8f06508d772a0cf1b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637103907325617335&amp;sdata=4FzBxGNqNn36CxpU%2FgQ4socs7InNDgAZlTspBMfUsIw%3D&amp;reserved=0
> 
> But it turns out this still doesn't work with SEV as we'll always
> bounce.  And I've been kinda lost on figuring out a way how to
> allocate unencrypted pages that we we can feed into the normal
> dma_map_page & co interfaces due to the magic encryption bit in
> the address.  I guess we could have a fallback path in the mapping
> path and just unconditionally clear that bit in the dma_to_phys
> path.
