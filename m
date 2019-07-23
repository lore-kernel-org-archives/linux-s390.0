Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfGWMdj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Jul 2019 08:33:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6NCTFmP036128
        for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2019 08:33:38 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tx03hprhq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 23 Jul 2019 08:33:18 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Tue, 23 Jul 2019 13:32:32 +0100
Date: Tue, 23 Jul 2019 14:32:26 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
In-Reply-To: <20190719130130.3ef4fa9c.pasic@linux.ibm.com>
References: <20190718172120.69947-1-pasic@linux.ibm.com>
        <20190719063249.GA4852@osiris>
        <20190719130130.3ef4fa9c.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190723143226.6d929d7a.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Fri, 19 Jul 2019 13:01:30 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> > > diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
> > > index 6f26f35d4a71..3b0329665b13 100644
> > > --- a/arch/s390/include/asm/dma.h
> > > +++ b/arch/s390/include/asm/dma.h
> > > @@ -10,6 +10,7 @@
> > >   * by the 31 bit heritage.
> > >   */
> > >  #define MAX_DMA_ADDRESS         0x80000000
> > > +#define ARCH_ZONE_DMA_BITS      31  
> > 
> > powerpc has this in arch/powerpc/include/asm/page.h. This really
> > should be consistently defined in the same header file across
> > architectures.
> > 
> > Christoph, what is the preferred header file for this definition?

ping

Christoph could you please answer Heiko's question, so I can do my
respin.

Regards,
Halil

> > 
> > I'd also rather say it would be better to move the #ifndef ARCH_ZONE_DMA_BITS
> > check to a common code header file instead of having it in a C file, and
> > make it more obvious in which header file architectures should/can override
> > the default, no?  
> 
> +1
> 
> I will wait for Christoph's answer with a respin. Thanks for having a
> look.
