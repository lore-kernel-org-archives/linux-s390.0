Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732464AbfGOUAe (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 16:00:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FJw8VN097096
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 16:00:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2trvcma983-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 15 Jul 2019 16:00:31 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Mon, 15 Jul 2019 21:00:30 +0100
References: <20190713044554.28719-1-bauerman@linux.ibm.com> <20190713044554.28719-2-bauerman@linux.ibm.com> <3dc137a99c73b1b6582fc854844a417e@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH 1/3] x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig
In-reply-to: <3dc137a99c73b1b6582fc854844a417e@linux.vnet.ibm.com>
Date: Mon, 15 Jul 2019 17:00:01 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877e8jnk5a.fsf@morokweng.localdomain>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: janani@linux.ibm.com
Cc: x86@kernel.org, linux-s390@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Robin Murphy <robin.murphy@arm.com>, Mike Anderson <andmike@linux.ibm.com>, Ram Pai <linuxram@us.ibm.com>, linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Lendacky <Thomas.Lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Linuxppc-dev <linuxppc-dev-bounces+janani=linux.ibm.com@lists.ozlabs.org>


Hello Janani,

Thanks for reviewing the patch.

janani <janani@linux.ibm.com> writes:

> On 2019-07-12 23:45, Thiago Jung Bauermann wrote:
>> powerpc is also going to use this feature, so put it in a generic location.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>>  arch/Kconfig      | 3 +++
>>  arch/s390/Kconfig | 3 ---
>>  arch/x86/Kconfig  | 4 +---
>>  3 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index c47b328eada0..4ef3499d4480 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -927,6 +927,9 @@ config LOCK_EVENT_COUNTS
>>  	  the chance of application behavior change because of timing
>>  	  differences. The counts are reported via debugfs.
>>
>> +config ARCH_HAS_MEM_ENCRYPT
>> +	bool
>> +
>>  source "kernel/gcov/Kconfig"
>>
>>  source "scripts/gcc-plugins/Kconfig"
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 5d8570ed6cab..f820e631bf89 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -1,7 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -config ARCH_HAS_MEM_ENCRYPT
>> -        def_bool y
>> -
>
>  Since you are removing the "def_bool y" when ARCH_HAS_MEM_ENCRYPT is moved to
> arch/Kconfig, does the s390/Kconfig need "select ARCH_HAS_MEM_ENCRYPT" added
> like you do for x86/Kconfig?

Indeed, I missed that. Thanks for spotting it!

>
>  - Janani
>
>>  config MMU
>>  	def_bool y
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c9f331bb538b..5d3295f2df94 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -68,6 +68,7 @@ config X86
>>  	select ARCH_HAS_FORTIFY_SOURCE
>>  	select ARCH_HAS_GCOV_PROFILE_ALL
>>  	select ARCH_HAS_KCOV			if X86_64
>> +	select ARCH_HAS_MEM_ENCRYPT
>>  	select ARCH_HAS_MEMBARRIER_SYNC_CORE
>>  	select ARCH_HAS_PMEM_API		if X86_64
>>  	select ARCH_HAS_PTE_SPECIAL
>> @@ -1520,9 +1521,6 @@ config X86_CPA_STATISTICS
>>  	  helps to determine the effectiveness of preserving large and huge
>>  	  page mappings when mapping protections are changed.
>>
>> -config ARCH_HAS_MEM_ENCRYPT
>> -	def_bool y
>> -
>>  config AMD_MEM_ENCRYPT
>>  	bool "AMD Secure Memory Encryption (SME) support"
>>  	depends on X86_64 && CPU_SUP_AMD


-- 
Thiago Jung Bauermann
IBM Linux Technology Center
