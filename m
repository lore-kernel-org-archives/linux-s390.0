Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:40042 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCSST3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Mar 2020 14:19:29 -0400
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <c3071359-c5d3-4247-7f16-6f61b2fa0756@c-s.fr>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c60fe230-462c-aa8c-be50-61c92840d7b7@oracle.com>
Date: Thu, 19 Mar 2020 11:17:47 -0700
MIME-Version: 1.0
In-Reply-To: <c3071359-c5d3-4247-7f16-6f61b2fa0756@c-s.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Albert Ou <aou@eecs.berkeley.edu>, Andrew Morton <akpm@linux-foundation.org>, Vasily Gorbik <gor@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>, Longpeng <longpeng2@huawei.com>, Will Deacon <will@kernel.org>, "David S.Miller" <davem@davemloft.net>

On 3/19/20 12:00 AM, Christophe Leroy wrote:
> 
> Le 18/03/2020 à 23:06, Mike Kravetz a écrit :
>> The architecture independent routine hugetlb_default_setup sets up
>> the default huge pages size.  It has no way to verify if the passed
>> value is valid, so it accepts it and attempts to validate at a later
>> time.  This requires undocumented cooperation between the arch specific
>> and arch independent code.
>>
>> For architectures that support more than one huge page size, provide
>> a routine arch_hugetlb_valid_size to validate a huge page size.
>> hugetlb_default_setup can use this to validate passed values.
>>
>> arch_hugetlb_valid_size will also be used in a subsequent patch to
>> move processing of the "hugepagesz=" in arch specific code to a common
>> routine in arch independent code.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>   arch/arm64/include/asm/hugetlb.h   |  2 ++
>>   arch/arm64/mm/hugetlbpage.c        | 19 ++++++++++++++-----
>>   arch/powerpc/include/asm/hugetlb.h |  3 +++
>>   arch/powerpc/mm/hugetlbpage.c      | 20 +++++++++++++-------
>>   arch/riscv/include/asm/hugetlb.h   |  3 +++
>>   arch/riscv/mm/hugetlbpage.c        | 28 ++++++++++++++++++----------
>>   arch/s390/include/asm/hugetlb.h    |  3 +++
>>   arch/s390/mm/hugetlbpage.c         | 18 +++++++++++++-----
>>   arch/sparc/include/asm/hugetlb.h   |  3 +++
>>   arch/sparc/mm/init_64.c            | 23 ++++++++++++++++-------
>>   arch/x86/include/asm/hugetlb.h     |  3 +++
>>   arch/x86/mm/hugetlbpage.c          | 21 +++++++++++++++------
>>   include/linux/hugetlb.h            |  7 +++++++
>>   mm/hugetlb.c                       | 16 +++++++++++++---
>>   14 files changed, 126 insertions(+), 43 deletions(-)
>>
> 
> [snip]
> 
>> diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
>> index bd6504c28c2f..3b5939016955 100644
>> --- a/arch/powerpc/include/asm/hugetlb.h
>> +++ b/arch/powerpc/include/asm/hugetlb.h
>> @@ -64,6 +64,9 @@ static inline void arch_clear_hugepage_flags(struct page *page)
>>   {
>>   }
>>   +#define arch_hugetlb_valid_size arch_hugetlb_valid_size
>> +extern bool __init arch_hugetlb_valid_size(unsigned long long size);
> 
> Don't add 'extern' keyword, it is irrelevant for a function declaration.
> 

Will do.  One of the other arch's did this and I got into a bad habit.

> checkpatch --strict doesn't like it either (https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/12318//artifact/linux/checkpatch.log)
> 
>> +
>>   #include <asm-generic/hugetlb.h>
>>     #else /* ! CONFIG_HUGETLB_PAGE */
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 33b3461d91e8..b78f660252f3 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -558,7 +558,7 @@ unsigned long vma_mmu_pagesize(struct vm_area_struct *vma)
>>       return vma_kernel_pagesize(vma);
>>   }
>>   -static int __init add_huge_page_size(unsigned long long size)
>> +bool __init arch_hugetlb_valid_size(unsigned long long size)
>>   {
>>       int shift = __ffs(size);
>>       int mmu_psize;
>> @@ -566,20 +566,26 @@ static int __init add_huge_page_size(unsigned long long size)
>>       /* Check that it is a page size supported by the hardware and
>>        * that it fits within pagetable and slice limits. */
>>       if (size <= PAGE_SIZE || !is_power_of_2(size))
>> -        return -EINVAL;
>> +        return false;
>>         mmu_psize = check_and_get_huge_psize(shift);
>>       if (mmu_psize < 0)
>> -        return -EINVAL;
>> +        return false;
>>         BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
>>   -    /* Return if huge page size has already been setup */
>> -    if (size_to_hstate(size))
>> -        return 0;
>> +    return true;
>> +}
>>   -    hugetlb_add_hstate(shift - PAGE_SHIFT);
>> +static int __init add_huge_page_size(unsigned long long size)
>> +{
>> +    int shift = __ffs(size);
>> +
>> +    if (!arch_hugetlb_valid_size(size))
>> +        return -EINVAL;
>>   +    if (!size_to_hstate(size))
>> +        hugetlb_add_hstate(shift - PAGE_SHIFT);
>>       return 0;
>>   }
>>   
> 
> [snip]
> 
>> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
>> index 5bfd5aef5378..51e6208fdeec 100644
>> --- a/arch/x86/mm/hugetlbpage.c
>> +++ b/arch/x86/mm/hugetlbpage.c
>> @@ -181,16 +181,25 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>   #endif /* CONFIG_HUGETLB_PAGE */
>>     #ifdef CONFIG_X86_64
>> +bool __init arch_hugetlb_valid_size(unsigned long long size)
>> +{
>> +    if (size == PMD_SIZE)
>> +        return true;
>> +    else if (size == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
>> +        return true;
>> +    else
>> +        return false;
>> +}
>> +
>>   static __init int setup_hugepagesz(char *opt)
>>   {
>> -    unsigned long ps = memparse(opt, &opt);
>> -    if (ps == PMD_SIZE) {
>> -        hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
>> -    } else if (ps == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES)) {
>> -        hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>> +    unsigned long long ps = memparse(opt, &opt);
>> +
>> +    if (arch_hugetlb_valid_size(ps)) {
>> +        hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
>>       } else {
>>           hugetlb_bad_size();
>> -        printk(KERN_ERR "hugepagesz: Unsupported page size %lu M\n",
>> +        printk(KERN_ERR "hugepagesz: Unsupported page size %llu M\n",
>>               ps >> 20);
> 
> Nowadays we use pr_err() instead of printk.
> 
> It would also likely allow you to have everything fit on a single line.

I may just leave this 'as is' as it will be removed in a later patch.

>>           return 0;
>>       }
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index b831e9fa1a26..33343eb980d0 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -678,6 +678,13 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>>       return &mm->page_table_lock;
>>   }
>>   +#ifndef arch_hugetlb_valid_size
>> +static inline bool arch_hugetlb_valid_size(unsigned long long size)
>> +{
>> +    return (size == HPAGE_SIZE);
> 
> Not sure the ( ) are necessary.

Likely not.  I will look at removing.

> 
>> +}
>> +#endif
>> +
>>   #ifndef hugepages_supported
>>   /*
>>    * Some platform decide whether they support huge pages at boot
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index d8ebd876871d..2f99359b93af 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3224,12 +3224,22 @@ static int __init hugetlb_nrpages_setup(char *s)
>>   }
>>   __setup("hugepages=", hugetlb_nrpages_setup);
>>   -static int __init hugetlb_default_setup(char *s)
>> +static int __init default_hugepagesz_setup(char *s)
>>   {
>> -    default_hstate_size = memparse(s, &s);
>> +    unsigned long long size;
> 
> Why unsigned long long ?
> 
> default_hstate_size is long.

Only because memparse is defined as unsigned long long.  I actually took
this from the existing powerpc hugetlb setup code.  There are no compiler
warnings/issues assigning unsigned long long to long on 64 bit builds.
Thought there would be on 32 bit platformes.

That was also the reason for making the argument to arch_hugetlb_valid_size
be unsigned long long.  So that it would match the type from memparse.
I suppose making these unsigned long and casting would be OK based on the
expected sizes.

> 
> I can't imagine 32 bits platforms having a hugepage with a 64 bits size.
> 
>> +    char *saved_s = s;
>> +
>> +    size = memparse(s, &s);
> 
> The updated s is not reused after that so you can pass NULL instead of &s and then you don't need the saved_s.
> 

Thanks for this and all the comments.  I will incorporate in v2.
-- 
Mike Kravetz
