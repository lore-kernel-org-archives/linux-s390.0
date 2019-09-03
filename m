Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbfICSyh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Sep 2019 14:54:37 -0400
References: <20190806044919.10622-2-bauerman@linux.ibm.com> <46MFPW6NYNz9sDQ@ozlabs.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 1/6] x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
In-reply-to: <46MFPW6NYNz9sDQ@ozlabs.org>
Date: Tue, 03 Sep 2019 15:53:54 -0300
Message-ID: <87k1apky7x.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: x86@kernel.org, linux-s390@vger.kernel.org, Lianbo Jiang <lijiang@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>


Michael Ellerman <patch-notifications@ellerman.id.au> writes:

> On Tue, 2019-08-06 at 04:49:14 UTC, Thiago Jung Bauermann wrote:
>> powerpc is also going to use this feature, so put it in a generic location.
>> 
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Series applied to powerpc topic/mem-encrypt, thanks.
>
> https://git.kernel.org/powerpc/c/0c9c1d56397518eb823d458b00b06bcccd956794

Thank you!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
