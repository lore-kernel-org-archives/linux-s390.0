Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
From: David Hildenbrand <david@redhat.com>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
 <9916f217-ec29-33ff-a260-7a26792d23a1@redhat.com>
 <897c31ba-d3bd-b694-8c87-82e784a60c51@arm.com>
 <5e133a5e-41bb-9d6b-f76e-a96d3efe0f5e@redhat.com>
Message-ID: <417b574c-309e-6d5d-36e4-9b16d82c54a6@redhat.com>
Date: Fri, 22 Jan 2021 11:43:25 +0100
MIME-Version: 1.0
In-Reply-To: <5e133a5e-41bb-9d6b-f76e-a96d3efe0f5e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

On 22.01.21 11:42, David Hildenbrand wrote:
> On 22.01.21 11:41, Anshuman Khandual wrote:
>>
>> On 1/22/21 2:48 PM, David Hildenbrand wrote:
>>>
>>>> +/*
>>>> + * Platforms should define arch_get_mappable_range() that provides
>>>> + * maximum possible addressable physical memory range for which the
>>>> + * linear mapping could be created. The platform returned address
>>>> + * range must adhere to these following semantics.
>>>> + *
>>>> + * - range.start <= range.end
>>>> + * - Range includes both end points [range.start..range.end]
>>>> + *
>>>> + * There is also a fallback definition provided here, allowing the
>>>> + * entire possible physical address range in case any platform does
>>>> + * not define arch_get_mappable_range().
>>>> + */
>>>> +struct range __weak arch_get_mappable_range(void)
>>>> +{
>>>> +	struct range memhp_range = {
>>>> +		.start = 0UL,
>>>> +		.end = -1ULL,
>>>> +	};
>>>> +	return memhp_range;
>>>> +}
>>>> +
>>>> +struct range memhp_get_pluggable_range(bool need_mapping)
>>>> +{
>>>> +	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
>>>
>>> Sorry, thought about that line a bit more, and I think this is just
>>> wrong (took me longer to realize as it should). The old code used this
>>> calculation to print the limit only (in a wrong way), let's recap:
>>>
>>> Assume MAX_PHYSMEM_BITS=32
>>>
>>> 	max_phys = (1ULL << (32 + 1)) - 1 = 0x1ffffffffull;
>>>
>>> Ehm, these are 33 bit.
>>>
>>> OTOH, old code checked for
>>>
>>> 	if (max_addr >> MAX_PHYSMEM_BITS) {
>>>
>>> Which makes sense, because
>>>
>>> 	0x1ffffffffull >> 32 = 1
>>>
>>> results in "true", meaning it's to big, while
>>>
>>> 	0xffffffffull >> 32 = 0
>>>
>>> correctly results in "false", meaning the address is fine.
>>>
>>>
>>>
>>> So, this should just be
>>>
>>> const u64 max_phys = 1ULL << MAX_PHYSMEM_BITS;
>>>
>>> (similarly as calculated in virito-mem code, or in kernel/resource.c)
>>
>> Should this be 1ULL << MAX_PHYSMEM_BITS - 1 instead ? Currently there are
> 
> Yes, obviously, sorry, forgot the -1.
> 

const u64 max_phys = (1ULL << MAX_PHYSMEM_BITS) - 1;

to be precise.

-- 
Thanks,

David / dhildenb
