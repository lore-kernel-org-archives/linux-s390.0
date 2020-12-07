Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52627 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbgLGJEl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 04:04:41 -0500
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
 <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com> <20201203115133.GB9994@osiris>
 <4d6c9ec4-f1be-46b9-5d67-5c53f5afedc5@redhat.com>
 <62c60c9e-20d6-25bd-94d0-78bfed0f2476@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <02dfe6f5-efb6-c04d-c34a-a1e7393625cf@redhat.com>
Date: Mon, 7 Dec 2020 10:03:11 +0100
MIME-Version: 1.0
In-Reply-To: <62c60c9e-20d6-25bd-94d0-78bfed0f2476@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>

On 07.12.20 05:38, Anshuman Khandual wrote:
> 
> 
> On 12/3/20 5:31 PM, David Hildenbrand wrote:
>> On 03.12.20 12:51, Heiko Carstens wrote:
>>> On Thu, Dec 03, 2020 at 06:03:00AM +0530, Anshuman Khandual wrote:
>>>>>> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
>>>>>> index 5060956b8e7d..cc055a78f7b6 100644
>>>>>> --- a/arch/s390/mm/extmem.c
>>>>>> +++ b/arch/s390/mm/extmem.c
>>>>>> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
>>>>>>  		goto out_free_resource;
>>>>>>  	}
>>>>>>  
>>>>>> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
>>>>>> +		rc = -ERANGE;
>>>>>> +		goto out_resource;
>>>>>> +	}
>>>>>> +
>>>>>>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
>>>>>>  	if (rc)
>>>>>>  		goto out_resource;
>>>>>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>>>>>> index b239f2ba93b0..06dddcc0ce06 100644
>>>>>> --- a/arch/s390/mm/vmem.c
>>>>>> +++ b/arch/s390/mm/vmem.c
>>>>>> @@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>>>>>  	mutex_unlock(&vmem_mutex);
>>>>>>  }
>>>>>>  
>>>>>> +struct range arch_get_mappable_range(void)
>>>>>> +{
>>>>>> +	struct range memhp_range;
>>>>>> +
>>>>>> +	memhp_range.start = 0;
>>>>>> +	memhp_range.end =  VMEM_MAX_PHYS;
>>>>>> +	return memhp_range;
>>>>>> +}
>>>>>> +
>>>>>>  int vmem_add_mapping(unsigned long start, unsigned long size)
>>>>>>  {
>>>>>>  	int ret;
>>>>>>  
>>>>>> -	if (start + size > VMEM_MAX_PHYS ||
>>>>>> -	    start + size < start)
>>>>>> -		return -ERANGE;
>>>>>> -
>>>>>
>>>>> I really fail to see how this could be considered an improvement for
>>>>> s390. Especially I do not like that the (central) range check is now
>>>>> moved to the caller (__segment_load). Which would mean potential
>>>>> additional future callers would have to duplicate that code as well.
>>>>
>>>> The physical range check is being moved to the generic hotplug code
>>>> via arch_get_mappable_range() instead, making the existing check in
>>>> vmem_add_mapping() redundant. Dropping the check there necessitates
>>>> adding back a similar check in __segment_load(). Otherwise there
>>>> will be a loss of functionality in terms of range check.
>>>>
>>>> May be we could just keep this existing check in vmem_add_mapping()
>>>> as well in order avoid this movement but then it would be redundant
>>>> check in every hotplug path.
>>>>
>>>> So I guess the choice is to either have redundant range checks in
>>>> all hotplug paths or future internal callers of vmem_add_mapping()
>>>> take care of the range check.
>>>
>>> The problem I have with this current approach from an architecture
>>> perspective: we end up having two completely different methods which
>>> are doing the same and must be kept in sync. This might be obvious
>>> looking at this patch, but I'm sure this will go out-of-sync (aka
>>> broken) sooner or later.
>>
>> Exactly, there should be one function only that was the whole idea of
>> arch_get_mappable_range().
>>
>>>
>>> Therefore I would really like to see a single method to do the range
>>> checking. Maybe you could add a callback into architecture code, so
>>> that such an architecture specific function could also be used
>>> elsewhere. Dunno.
>>>
>>
>> I think we can just switch to using "memhp_range_allowed()" here then
>> after implementing arch_get_mappable_range().
>>
>> Doesn't hurt to double check in vmem_add_mapping() - especially to keep
>> extmem working without changes. At least for callers of memory hotplug
>> it's then clear which values actually won't fail deep down in arch code.
> 
> But there is a small problem here. memhp_range_allowed() is now defined
> and available with CONFIG_MEMORY_HOTPLUG where as vmem_add_mapping() and
> __segment_load() are generally available without any config dependency.
> So if CONFIG_MEMORY_HOTPLUG is not enabled there will be a build failure
> in vmem_add_mapping() for memhp_range_allowed() symbol.
> 
> We could just move VM_BUG_ON(!memhp_range_allowed(start, size, 1)) check
> from vmem_add_mapping() to arch_add_memory() like on arm64 platform. But
> then __segment_load() would need that additional new check to compensate
> as proposed earlier.
> 
> Also leaving vmem_add_mapping() and __segment_load() unchanged will cause
> the address range check to be called three times on the hotplug path i.e
> 
> 1. register_memory_resource()
> 2. arch_add_memory()
> 3. vmem_add_mapping()
> 
> Moving memhp_range_allowed() check inside arch_add_memory() seems better
> and consistent with arm64. Also in the future, any platform which choose
> to override arch_get_mappable() will have this additional VM_BUG_ON() in
> their arch_add_memory().

Yeah, it might not make sense to add these checks all over the place.
The important part is that

1. There is a check somewhere (and if it's deep down in arch code)
2. There is an obvious way for callers to find out what valid values are.


I guess it would be good enough to

a) Factor out getting arch ranges into arch_get_mappable_range()
b) Provide memhp_get_pluggable_range()

Both changes only make sense with an in-tree user. I'm planning on using
this functionality in virtio-mem code. I can pickup your patches, drop
the superfluous checks, and use it from virtio-mem code. Makese sense
(BTW, looks like we'll see aarch64 support for virtio-mem soon)?

-- 
Thanks,

David / dhildenb
