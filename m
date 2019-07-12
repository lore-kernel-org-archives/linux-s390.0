Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726976AbfGLOwI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 10:52:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CEpExb127763
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 10:52:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpsksqs2a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 12 Jul 2019 10:52:06 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 12 Jul 2019 15:52:03 +0100
Date: Fri, 12 Jul 2019 16:51:53 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
In-Reply-To: <20190712140812.GA29628@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
        <20190712053631.9814-4-bauerman@linux.ibm.com>
        <20190712150912.3097215e.pasic@linux.ibm.com>
        <20190712140812.GA29628@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20190712165153.78d49095.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>

On Fri, 12 Jul 2019 16:08:12 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jul 12, 2019 at 03:09:12PM +0200, Halil Pasic wrote:
> > This is the implementation for the guys that don't
> > have ARCH_HAS_MEM_ENCRYPT.
> > 
> > Means sev_active() may not be used in such code after this
> > patch. What about 
> > 
> > static inline bool force_dma_unencrypted(void)
> > {
> >         return sev_active();
> > }
> > 
> > in kernel/dma/direct.c?
> 
> FYI, I have this pending in the dma-mapping tree:
> 
> http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/e67a5ed1f86f4370991c601f2fcad9ebf9e1eebb

Thank you very much! I will have another look, but it seems to me,
without further measures taken, this would break protected virtualization
support on s390. The effect of the che for s390 is that
force_dma_unencrypted() will always return false instead calling into
the platform code like it did before the patch, right?

Should I send a  Fixes: e67a5ed1f86f "dma-direct: Force unencrypted DMA
under SME for certain DMA masks" (Tom Lendacky, 2019-07-10) patch that
rectifies things for s390 or how do we want handle this?

Regards,
Halil
