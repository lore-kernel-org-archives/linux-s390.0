Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbfGSLBj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 07:01:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JAwODT010423
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 07:01:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tubeebasc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 07:01:37 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 19 Jul 2019 12:01:36 +0100
Date: Fri, 19 Jul 2019 13:01:30 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
In-Reply-To: <20190719063249.GA4852@osiris>
References: <20190718172120.69947-1-pasic@linux.ibm.com>
        <20190719063249.GA4852@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190719130130.3ef4fa9c.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Fri, 19 Jul 2019 08:32:49 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> On Thu, Jul 18, 2019 at 07:21:20PM +0200, Halil Pasic wrote:
> > On s390 ZONE_DMA is up to 2G, i.e. ARCH_ZONE_DMA_BITS should be 31 bits.
> > The current value is 24 and makes __dma_direct_alloc_pages() take a
> > wrong turn first (but __dma_direct_alloc_pages() recovers then).
> > 
> > Let's correct ARCH_ZONE_DMA_BITS value and avoid wrong turns.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Reported-by: Petr Tesarik <ptesarik@suse.cz>
> > Fixes: c61e9637340e ("dma-direct: add support for allocation from
> > ZONE_DMA and ZONE_DMA32")
> 
> Please don't add linebreaks to "Fixes:" tags.
> 

Will remember that, thanks! I was not aware of the rule and checkpatch
did not complain. 

> > ---
> >  arch/s390/include/asm/dma.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
> > index 6f26f35d4a71..3b0329665b13 100644
> > --- a/arch/s390/include/asm/dma.h
> > +++ b/arch/s390/include/asm/dma.h
> > @@ -10,6 +10,7 @@
> >   * by the 31 bit heritage.
> >   */
> >  #define MAX_DMA_ADDRESS         0x80000000
> > +#define ARCH_ZONE_DMA_BITS      31
> 
> powerpc has this in arch/powerpc/include/asm/page.h. This really
> should be consistently defined in the same header file across
> architectures.
> 
> Christoph, what is the preferred header file for this definition?
> 
> I'd also rather say it would be better to move the #ifndef ARCH_ZONE_DMA_BITS
> check to a common code header file instead of having it in a C file, and
> make it more obvious in which header file architectures should/can override
> the default, no?

+1

I will wait for Christoph's answer with a respin. Thanks for having a
look.

Regards,
Halil
