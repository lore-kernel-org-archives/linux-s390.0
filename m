Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:57458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgLJI7a (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 03:59:30 -0500
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
References: <20201210065845.GA20691@osiris>
 <E026809E-4624-4ACE-B309-0443704C637B@redhat.com>
 <0a2f6eb1-c38b-9cc2-5c45-16f6c8999ce2@arm.com>
 <2a379949-4ecb-e380-560e-78ef91168c87@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <1ff0df3a-a6bf-7c1c-6e10-02de3477e3ed@arm.com>
Date: Thu, 10 Dec 2020 14:28:31 +0530
MIME-Version: 1.0
In-Reply-To: <2a379949-4ecb-e380-560e-78ef91168c87@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>



On 12/10/20 1:32 PM, David Hildenbrand wrote:
> On 10.12.20 08:40, Anshuman Khandual wrote:
>>
>>
>> On 12/10/20 12:34 PM, David Hildenbrand wrote:
>>>
>>>> Am 10.12.2020 um 07:58 schrieb Heiko Carstens <hca@linux.ibm.com>:
>>>>
>>>> ﻿On Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote:
>>>>>>> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
>>>>>>> will create three range checks i.e two memhp_range_allowed() and the
>>>>>>> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
>>>>>>> paths, which is not optimal.
>>>>>>
>>>>>> Ah, sorry. I didn't follow this discussion too closely. I just thought
>>>>>> my point of view would be clear: let's not have two different ways to
>>>>>> check for the same thing which must be kept in sync.
>>>>>> Therefore I was wondering why this next version is still doing
>>>>>> that. Please find a way to solve this.
>>>>>
>>>>> The following change is after the current series and should work with
>>>>> and without memory hotplug enabled. There will be just a single place
>>>>> i.e vmem_get_max_addr() to update in case the maximum address changes
>>>>> from VMEM_MAX_PHYS to something else later.
>>>>
>>>> Still not. That's way too much code churn for what you want to achieve.
>>>> If the s390 specific patch would look like below you can add
>>>>
>>>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>>>>
>>>> But please make sure that the arch_get_mappable_range() prototype in
>>>> linux/memory_hotplug.h is always visible and does not depend on
>>>> CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
>>>> because of this.
>>>>
>>>> Thanks.
>>>>
>>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>>> index 77767850d0d0..e0e78234ae57 100644
>>>> --- a/arch/s390/mm/init.c
>>>> +++ b/arch/s390/mm/init.c
>>>> @@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>    if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>>>        return -EINVAL;
>>>>
>>>> +    VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>>>>    rc = vmem_add_mapping(start, size);
>>>>    if (rc)
>>>>        return rc;
>>>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>>>> index b239f2ba93b0..ccd55e2f97f9 100644
>>>> --- a/arch/s390/mm/vmem.c
>>>> +++ b/arch/s390/mm/vmem.c
>>>> @@ -4,6 +4,7 @@
>>>>  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>>>>  */
>>>>
>>>> +#include <linux/memory_hotplug.h>
>>>> #include <linux/memblock.h>
>>>> #include <linux/pfn.h>
>>>> #include <linux/mm.h>
>>>> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>>>    mutex_unlock(&vmem_mutex);
>>>> }
>>>>
>>>> +struct range arch_get_mappable_range(void)
>>>> +{
>>>> +    struct range range;
>>>> +
>>>> +    range.start = 0;
>>>> +    range.end = VMEM_MAX_PHYS;
>>>> +    return range;
>>>> +}
>>>> +
>>>> int vmem_add_mapping(unsigned long start, unsigned long size)
>>>> {
>>>> +    struct range range;
>>>>    int ret;
>>>>
>>>> -    if (start + size > VMEM_MAX_PHYS ||
>>>> +    range = arch_get_mappable_range();
>>>> +    if (start < range.start ||
>>>> +        start + size > range.end ||
>>>>        start + size < start)
>>>>        return -ERANGE;
>>>>
>>>>
>>>
>>> Right, what I had in mind as reply to v1. Not sure if we really need new checks in common code. Having a new memhp_get_pluggable_range() would be sufficient for my use case (virtio-mem).
>> Didn't quite understand "Not sure if we really need new checks in common code".
>> Could you please be more specific. New checks as in pagemap_range() ? Because
>> other places it is either replacing erstwhile check_hotplug_memory_addressable()
>> or just moving existing checks from platform arch_add_memory() to the beginning
>> of various hotplug paths.
> 
> The main concern I have with current code is that it makes it impossible
> for some driver to detect which ranges it could actually later hotplug.
> You cannot warn about a strange setup before you actually run into the
> issues while trying to add memory. Like returning "-EINVAL" from a
> function but not exposing which values are actually valid.
> 
> If we have memhp_get_pluggable_range(), we have such a mechanism and
> 
> 1. Trying to add out-of-range memory will fail (although deep down in
> arch code, but at least it fails).
> 
> 2. There is a way for drivers to find out which values are actually
> valid before triggering 1.

Right, that is an important use case from a driver perspective as it
helps validate the range being attempted for hotplug, before failing.
But then memhp_range_allowed() also uses the same mechanism i.e
memhp_get_pluggable_range() to unify

1. Generic check_hotplug_memory_addressable()
2. Platform checks in arch_add_memory()

This unified function can be called just at the beginning of memory
hotplug so that both (1) and (2) can be dropped all together. This
is just a logical extension which does improve the memory hotplug
implementation (in itself) by failing earlier and while at it, also
unifying generic and platform specific range constraints. Both the
use cases are orthogonal IMHO.

> 
> For my use case that's good enough. Do you have others in mind that
> require new checks in common code (meaning inside add_memory() and friends)?
