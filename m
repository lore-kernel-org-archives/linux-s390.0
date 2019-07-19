Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728669AbfGSPqE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jul 2019 11:46:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6JFhN25121039
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 11:46:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tug36t2qc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 19 Jul 2019 11:46:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Fri, 19 Jul 2019 16:46:01 +0100
References: <20190718032858.28744-1-bauerman@linux.ibm.com> <680bb92e-66eb-8959-88a5-3447a6a282c8@amd.com> <87a7db3z68.fsf@morokweng.localdomain> <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 0/6] Remove x86-specific code from generic headers
In-reply-to: <879a196a-1d92-931d-88f4-6ce17a09cf20@amd.com>
Date: Fri, 19 Jul 2019 12:45:47 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87imrygh90.fsf@morokweng.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: "x86@kernel.org" <x86@kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>


Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:

> On 7/18/19 2:44 PM, Thiago Jung Bauermann wrote:
>> 
>> Lendacky, Thomas <Thomas.Lendacky@amd.com> writes:
>> 
>>> On 7/17/19 10:28 PM, Thiago Jung Bauermann wrote:
>>>> Hello,
>>>>
>>>> This version is mostly about splitting up patch 2/3 into three separate
>>>> patches, as suggested by Christoph Hellwig. Two other changes are a fix in
>>>> patch 1 which wasn't selecting ARCH_HAS_MEM_ENCRYPT for s390 spotted by
>>>> Janani and removal of sme_active and sev_active symbol exports as suggested
>>>> by Christoph Hellwig.
>>>>
>>>> These patches are applied on top of today's dma-mapping/for-next.
>>>>
>>>> I don't have a way to test SME, SEV, nor s390's PEF so the patches have only
>>>> been build tested.
>>>
>>> I'll try and get this tested quickly to be sure everything works for SME
>>> and SEV.
>
> Built and tested both SME and SEV and everything appears to be working
> well (not extensive testing, but should be good enough).

Great news. Thanks for testing!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
