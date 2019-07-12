Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727708AbfGLXnV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 19:43:21 -0400
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-3-bauerman@linux.ibm.com> <20190712071328.GA22889@lst.de>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 2/3] DMA mapping: Move SME handling to x86-specific files
In-reply-to: <20190712071328.GA22889@lst.de>
Date: Fri, 12 Jul 2019 20:42:31 -0300
Message-ID: <87r26ug6qg.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, "Lendacky, Thomas" <thomas.lendacky@amd.com>


[ Cc'ing Tom Lendacky which I forgot to do earlier. Sorry about that. ]

Hello Christoph,

Christoph Hellwig <hch@lst.de> writes:

> Honestly I think this code should go away without any replacement.
> There is no reason why we should have a special debug printk just
> for one specific reason why there is a requirement for a large DMA
> mask.

Makes sense. I'll submit a v2 which just removes this code.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
