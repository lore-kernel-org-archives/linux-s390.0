Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:53224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfGWPwt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jul 2019 11:52:49 -0400
Date: Tue, 23 Jul 2019 08:52:49 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
Message-ID: <20190723155249.GA30643@infradead.org>
References: <20190718172120.69947-1-pasic@linux.ibm.com>
 <20190719063249.GA4852@osiris>
 <20190719130130.3ef4fa9c.pasic@linux.ibm.com>
 <20190723143226.6d929d7a.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723143226.6d929d7a.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Tue, Jul 23, 2019 at 02:32:26PM +0200, Halil Pasic wrote:
> On Fri, 19 Jul 2019 13:01:30 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > > > diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
> > > > index 6f26f35d4a71..3b0329665b13 100644
> > > > --- a/arch/s390/include/asm/dma.h
> > > > +++ b/arch/s390/include/asm/dma.h
> > > > @@ -10,6 +10,7 @@
> > > >   * by the 31 bit heritage.
> > > >   */
> > > >  #define MAX_DMA_ADDRESS         0x80000000
> > > > +#define ARCH_ZONE_DMA_BITS      31  
> > > 
> > > powerpc has this in arch/powerpc/include/asm/page.h. This really
> > > should be consistently defined in the same header file across
> > > architectures.
> > > 
> > > Christoph, what is the preferred header file for this definition?
> 
> ping
> 
> Christoph could you please answer Heiko's question, so I can do my
> respin.

page.h is fine for now.  dma.h is odd for sure as it is for legacy
ISA DMA only.
