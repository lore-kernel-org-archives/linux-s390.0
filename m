Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfGSGc6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 02:32:58 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6J6RVvW058287
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 02:32:57 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tu4yb7vq2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 02:32:57 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 19 Jul 2019 07:32:55 +0100
Date: Fri, 19 Jul 2019 08:32:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/1] s390/dma: provide proper ARCH_ZONE_DMA_BITS value
References: <20190718172120.69947-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718172120.69947-1-pasic@linux.ibm.com>
Message-Id: <20190719063249.GA4852@osiris>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

On Thu, Jul 18, 2019 at 07:21:20PM +0200, Halil Pasic wrote:
> On s390 ZONE_DMA is up to 2G, i.e. ARCH_ZONE_DMA_BITS should be 31 bits.
> The current value is 24 and makes __dma_direct_alloc_pages() take a
> wrong turn first (but __dma_direct_alloc_pages() recovers then).
> 
> Let's correct ARCH_ZONE_DMA_BITS value and avoid wrong turns.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Reported-by: Petr Tesarik <ptesarik@suse.cz>
> Fixes: c61e9637340e ("dma-direct: add support for allocation from
> ZONE_DMA and ZONE_DMA32")

Please don't add linebreaks to "Fixes:" tags.

> ---
>  arch/s390/include/asm/dma.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/include/asm/dma.h b/arch/s390/include/asm/dma.h
> index 6f26f35d4a71..3b0329665b13 100644
> --- a/arch/s390/include/asm/dma.h
> +++ b/arch/s390/include/asm/dma.h
> @@ -10,6 +10,7 @@
>   * by the 31 bit heritage.
>   */
>  #define MAX_DMA_ADDRESS         0x80000000
> +#define ARCH_ZONE_DMA_BITS      31

powerpc has this in arch/powerpc/include/asm/page.h. This really
should be consistently defined in the same header file across
architectures.

Christoph, what is the preferred header file for this definition?

I'd also rather say it would be better to move the #ifndef ARCH_ZONE_DMA_BITS
check to a common code header file instead of having it in a C file, and
make it more obvious in which header file architectures should/can override
the default, no?
