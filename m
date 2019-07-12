Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40414 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727708AbfGLXgR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 19:36:17 -0400
References: <20190712053631.9814-1-bauerman@linux.ibm.com> <20190712053631.9814-2-bauerman@linux.ibm.com> <alpine.DEB.2.21.1907121804230.1788@nanos.tec.linutronix.de>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 1/3] x86/Kconfig: Move ARCH_HAS_MEM_ENCRYPT to arch/Kconfig
In-reply-to: <alpine.DEB.2.21.1907121804230.1788@nanos.tec.linutronix.de>
Date: Fri, 12 Jul 2019 20:35:37 -0300
Message-ID: <87sgrag71y.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>


Hello Thomas,

Thanks for quickly reviewing the patches.

Thomas Gleixner <tglx@linutronix.de> writes:

> On Fri, 12 Jul 2019, Thiago Jung Bauermann wrote:
>
>> powerpc and s390 are going to use this feature as well, so put it in a
>> generic location.
>> 
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
