Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436968AbfHIQDj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Aug 2019 12:03:39 -0400
References: <20190806044919.10622-1-bauerman@linux.ibm.com> <87sgqasdr6.fsf@concordia.ellerman.id.au>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v4 0/6] Remove x86-specific code from generic headers
In-reply-to: <87sgqasdr6.fsf@concordia.ellerman.id.au>
Date: Fri, 09 Aug 2019 13:02:48 -0300
Message-ID: <874l2qfhsn.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mpe@ellerman.id.au
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Halil Pasic <pasic@linux.ibm.com>, Lianbo Jiang <lijiang@redhat.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>


mpe@ellerman.id.au writes:

> Thiago Jung Bauermann <bauerman@linux.ibm.com> writes:
>> Hello,
>>
>> This version has only a small change in the last patch as requested by
>> Christoph and Halil, and collects Reviewed-by's.
>>
>> These patches are applied on top of v5.3-rc2.
>>
>> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
>> been build tested.
>
> I need to take this series via the powerpc tree because there is another
> fairly large powerpc specific series dependent on it.
>
> I think this series already has pretty much all the acks it needs, which
> almost never happens, amazing work!

Yes, thank you very much to everyone who reviewed the patches!

> I'll put the series in a topic branch, just in case there's any bad
> conflicts and other folks want to merge it later on. I'll then merge the
> topic branch into my next, and so this series will be tested in
> linux-next that way.

That's awesome. Thank you very much!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
