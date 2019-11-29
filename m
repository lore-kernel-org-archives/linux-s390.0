Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbfK2OJw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 09:09:52 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xATE2aZF051082
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:09:51 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjuwh9t0v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 09:09:51 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 29 Nov 2019 14:09:48 -0000
Date: Fri, 29 Nov 2019 15:09:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio_ring: fix return code on DMA mapping fails
In-Reply-To: <20191126184527.GA10481@lst.de>
References: <20191114124646.74790-1-pasic@linux.ibm.com>
        <20191119121022.03aed69a.pasic@linux.ibm.com>
        <20191119080420-mutt-send-email-mst@kernel.org>
        <20191122140827.0ead345c.pasic@linux.ibm.com>
        <1ec7c229-6c4f-9351-efda-ed2df20f95f6@amd.com>
        <20191126184527.GA10481@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20191129150941.34cab07a.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, Michael Mueller <mimu@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Andy Lutomirski <luto@kernel.org>, Brijesh Singh <brijesh.singh@amd.com>, "Kalra, Ashish" <Ashish.Kalra@amd.com>

On Tue, 26 Nov 2019 19:45:27 +0100
Christoph Hellwig <hch@lst.de> wrote:

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
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages
> 
> But it turns out this still doesn't work with SEV as we'll always
> bounce.  And I've been kinda lost on figuring out a way how to
> allocate unencrypted pages that we we can feed into the normal
> dma_map_page & co interfaces due to the magic encryption bit in
> the address.  I guess we could have a fallback path in the mapping
> path and just unconditionally clear that bit in the dma_to_phys
> path.

Thanks Christoph! Thanks Tom! I will do some looking and thinking and
report back.

Regards,
Halil
