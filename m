Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:56814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgLICiB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 8 Dec 2020 21:38:01 -0500
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
References: <1607400978-31595-1-git-send-email-anshuman.khandual@arm.com>
 <1607400978-31595-4-git-send-email-anshuman.khandual@arm.com>
 <20201208152709.GA26979@osiris>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <7484e153-6c77-8325-6195-621fe144011e@arm.com>
Date: Wed, 9 Dec 2020 08:07:04 +0530
MIME-Version: 1.0
In-Reply-To: <20201208152709.GA26979@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>



On 12/8/20 8:57 PM, Heiko Carstens wrote:
> On Tue, Dec 08, 2020 at 09:46:18AM +0530, Anshuman Khandual wrote:
>> This overrides arch_get_mappabble_range() on s390 platform which will be
>> used with recently added generic framework. It drops a redundant similar
>> check in vmem_add_mapping() while compensating __segment_load() with a new
>> address range check to preserve the existing functionality. It also adds a
>> VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
>> been called on the hotplug path.
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/s390/mm/extmem.c |  5 +++++
>>  arch/s390/mm/init.c   | 10 ++++++++++
>>  arch/s390/mm/vmem.c   |  4 ----
>>  3 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
>> index 5060956b8e7d..cc055a78f7b6 100644
>> --- a/arch/s390/mm/extmem.c
>> +++ b/arch/s390/mm/extmem.c
>> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
>>  		goto out_free_resource;
>>  	}
>>  
>> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
>> +		rc = -ERANGE;
>> +		goto out_resource;
>> +	}
>> +
>>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
>>  	if (rc)
>>  		goto out_resource;
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 77767850d0d0..64937baabf93 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -278,6 +278,15 @@ device_initcall(s390_cma_mem_init);
>>  
>>  #endif /* CONFIG_CMA */
>>  
>> +struct range arch_get_mappable_range(void)
>> +{
>> +	struct range memhp_range;
>> +
>> +	memhp_range.start = 0;
>> +	memhp_range.end =  VMEM_MAX_PHYS;
>> +	return memhp_range;
>> +}
>> +
>>  int arch_add_memory(int nid, u64 start, u64 size,
>>  		    struct mhp_params *params)
>>  {
>> @@ -291,6 +300,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>  		return -EINVAL;
>>  
>> +	VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>>  	rc = vmem_add_mapping(start, size);
>>  	if (rc)
>>  		return rc;
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index b239f2ba93b0..749eab43aa93 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -536,10 +536,6 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
>>  {
>>  	int ret;
>>  
>> -	if (start + size > VMEM_MAX_PHYS ||
>> -	    start + size < start)
>> -		return -ERANGE;
>> -
> 
> Is there a reason why you added the memhp_range_allowed() check call
> to arch_add_memory() instead of vmem_add_mapping()? If you would do

As I had mentioned previously, memhp_range_allowed() is available with
CONFIG_MEMORY_HOTPLUG but vmem_add_mapping() is always available. Hence
there will be a build failure in vmem_add_mapping() for the range check
memhp_range_allowed() without memory hotplug enabled.

> that, then the extra code in __segment_load() wouldn't be
> required.
> Even though the error message from memhp_range_allowed() might be
> highly confusing.
Alternatively leaving __segment_load() and vmem_add_memory() unchanged
will create three range checks i.e two memhp_range_allowed() and the
existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
paths, which is not optimal.
