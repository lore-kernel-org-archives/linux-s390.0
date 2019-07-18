Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRNLB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Jul 2019 09:11:01 -0400
Date: Thu, 18 Jul 2019 06:10:59 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
Message-ID: <20190718131059.GA18742@infradead.org>
References: <20190718091700.353b3721@ezekiel.suse.cz>
 <20190718113633.GB3581@osiris>
 <20190718135112.5c65685f@ezekiel.suse.cz>
 <20190718145044.03dc9804.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718145044.03dc9804.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Petr Tesarik <ptesarik@suse.cz>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>

On Thu, Jul 18, 2019 at 02:50:44PM +0200, Halil Pasic wrote:
> > I wondered why the kernel works OK on my system, and it is in fact not
> > so bad. If the first allocation fails, the kernel adds GFP_DMA and
> > retries, so this is not fatal, but with a proper definition of
> > ARCH_ZONE_DMA_BITS it should be possible to get success in the first
> > attempt already, let's do it.
> > 
> > Petr T
> 
> I fully agree! I will post a patch that provides correct
> ARCH_ZONE_DMA_BITS for s390.
> 
> BTW I wonder if ARCH_ZONE_DMA_BITS can be inferred from MAX_DMA_ADDRESS,
> and why do we need both.@Christoph, maybe you can help me understand if
> there is a relationship between the two or not, or?

MAX_DMA_ADDRESS is a bit of a weird beast which I honestly do not
understand fully, but most of the uses in common code look a little
bogus, and we should probably get rid of it.
