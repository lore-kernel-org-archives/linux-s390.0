Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:36380 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRWzg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Mar 2020 18:55:36 -0400
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5aceea6a-8dc0-a44b-80c6-94511b5c75ca@oracle.com>
Date: Wed, 18 Mar 2020 15:52:46 -0700
MIME-Version: 1.0
In-Reply-To: <831a0773-1ba6-4d72-44b9-7472123b8528@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S.Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Longpeng <longpeng2@huawei.com>, Andrew Morton <akpm@linux-foundation.org>

On 3/18/20 3:15 PM, Dave Hansen wrote:
> Hi Mike,
> 
> The series looks like a great idea to me.  One nit on the x86 bits,
> though...
> 
>> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
>> index 5bfd5aef5378..51e6208fdeec 100644
>> --- a/arch/x86/mm/hugetlbpage.c
>> +++ b/arch/x86/mm/hugetlbpage.c
>> @@ -181,16 +181,25 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>  #endif /* CONFIG_HUGETLB_PAGE */
>>  
>>  #ifdef CONFIG_X86_64
>> +bool __init arch_hugetlb_valid_size(unsigned long long size)
>> +{
>> +	if (size == PMD_SIZE)
>> +		return true;
>> +	else if (size == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
>> +		return true;
>> +	else
>> +		return false;
>> +}
> 
> I'm pretty sure it's possible to have a system without 2M/PMD page
> support.  We even have a handy-dandy comment about it in
> arch/x86/include/asm/required-features.h:
> 
> 	#ifdef CONFIG_X86_64
> 	#ifdef CONFIG_PARAVIRT
> 	/* Paravirtualized systems may not have PSE or PGE available */
> 	#define NEED_PSE        0
> 	...
> 
> I *think* you need an X86_FEATURE_PSE check here to be totally correct.
> 
> 	if (size == PMD_SIZE && cpu_feature_enabled(X86_FEATURE_PSE))
> 		return true;
> 
> BTW, I prefer cpu_feature_enabled() to boot_cpu_has() because it
> includes disabled-features checking.  I don't think any of it matters
> for these specific features, but I generally prefer it on principle.

Sounds good.  I'll incorporate those changes into a v2, unless someone
else with has a different opinion.

BTW, this patch should not really change the way the code works today.
It is mostly a movement of code.  Unless I am missing something, the
existing code will always allow setup of PMD_SIZE hugetlb pages.
-- 
Mike Kravetz
