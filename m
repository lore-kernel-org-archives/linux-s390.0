Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgLBMRz (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Dec 2020 07:17:55 -0500
Subject: Re: [RFC V2 2/3] arm64/mm: Define arch_get_mappable_range()
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-3-git-send-email-anshuman.khandual@arm.com>
 <1861413c-fd23-f3e2-14f3-00feec6ff2fb@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <85975346-d5ae-d971-e50f-9c0b77649910@arm.com>
Date: Wed, 2 Dec 2020 17:47:01 +0530
MIME-Version: 1.0
In-Reply-To: <1861413c-fd23-f3e2-14f3-00feec6ff2fb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>



On 12/2/20 2:56 PM, David Hildenbrand wrote:
> On 30.11.20 04:29, Anshuman Khandual wrote:
>> This overrides arch_get_mappable_range() on arm64 platform which will be
>> used with recently added generic framework. It drops inside_linear_region()
>> and subsequent check in arch_add_memory() which are no longer required.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/mm/mmu.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index ca692a815731..49ec8f2838f2 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1444,16 +1444,19 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
>>  	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
>>  }
>>  
>> -static bool inside_linear_region(u64 start, u64 size)
>> +struct range arch_get_mappable_range(void)
>>  {
>> +	struct range memhp_range;
>> +
>>  	/*
>>  	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
>>  	 * accommodating both its ends but excluding PAGE_END. Max physical
>>  	 * range which can be mapped inside this linear mapping range, must
>>  	 * also be derived from its end points.
>>  	 */
>> -	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
>> -	       (start + size - 1) <= __pa(PAGE_END - 1);
>> +	memhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
>> +	memhp_range.end =  __pa(PAGE_END - 1);
>> +	return memhp_range;
>>  }
>>  
>>  int arch_add_memory(int nid, u64 start, u64 size,
>> @@ -1461,11 +1464,6 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  {
>>  	int ret, flags = 0;
>>  
>> -	if (!inside_linear_region(start, size)) {
>> -		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
>> -		return -EINVAL;
>> -	}
> As discussed, I think something like a VM_BUG_ON() here might makes
> sense, indicating that we require the caller to validate upfront. Same
> applies to the s390x variant.

Sure, will do.

> 
> Thanks!
> 
