Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42643 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbfIWPVV (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 11:21:21 -0400
Date: Mon, 23 Sep 2019 17:21:17 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 1/3] dma-mapping: make overriding GFP_* flags arch
 customizable
Message-ID: <20190923152117.GA2767@lst.de>
References: <20190923123418.22695-1-pasic@linux.ibm.com> <20190923123418.22695-2-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923123418.22695-2-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

On Mon, Sep 23, 2019 at 02:34:16PM +0200, Halil Pasic wrote:
> Before commit 57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in
> common code") tweaking the client code supplied GFP_* flags used to be
> an issue handled in the architecture specific code. The commit message
> suggests, that fixing the client code would actually be a better way
> of dealing with this.
> 
> On s390 common I/O devices are generally capable of using the full 64
> bit address space for DMA I/O, but some chunks of the DMA memory need to
> be 31 bit addressable (in physical address space) because the
> instructions involved mandate it. Before switching to DMA API this used
> to be a non-issue, we used to allocate those chunks from ZONE_DMA.
> Currently our only option with the DMA API is to restrict the devices to
> (via dma_mask and dma_mask_coherent) to 31 bit, which is sub-optimal.
> 
> Thus s390 we would benefit form having control over what flags are
> dropped.

No way, sorry.  You need to express that using a dma mask instead of
overloading the GFP flags.
