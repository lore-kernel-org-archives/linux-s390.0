Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC 1/3] mm/hotplug: Pre-validate the address range with
 platform
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
 <1606098529-7907-2-git-send-email-anshuman.khandual@arm.com>
 <13392308-45a8-f85d-b25e-4a728e1e0730@redhat.com>
 <0c13a221-570a-0d64-fce9-d28e52cbdd6c@arm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8886f78e-28cf-ded0-1629-d4206205be96@redhat.com>
Date: Fri, 27 Nov 2020 10:01:12 +0100
MIME-Version: 1.0
In-Reply-To: <0c13a221-570a-0d64-fce9-d28e52cbdd6c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org

>>
>> "arch_get_mappable_range(void)" (or similar) ?
> 
> The current name seems bit better (I guess). Because we are asking for
> max addressable range with or without the linear mapping.
> 
>>
>> AFAIKs, both implementations (arm64/s390x) simply do the exact same
>> thing as memhp_get_pluggable_range() for !need_mapping.
> 
> That is for now. Even the range without requiring linear mapping might not
> be the same (like now) for every platform as some might have constraints.
> So asking the platform ranges with or without linear mapping seems to be
> better and could accommodate special cases going forward. Anyways, there
> is an always an "all allowing" fallback option nonetheless.

Let's keep it simple as long as we don't have a real scenario where this
would apply.

[...]

> 
>>
>>> +		return true;
>>> +
>>> +	WARN(1, "Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
>>> +		start, end, memhp_range.start, memhp_range.end);
>>
>> pr_warn() (or even pr_warn_once())
>>
>> while we're at it. No reason to eventually crash a system :)
> 
> Didn't quite get it. How could this crash the system ?

With panic_on_warn, which some distributions started to enable.

[...]

>>>  		/*
>>>  		 * Validate altmap is within bounds of the total request
>>> @@ -1109,6 +1089,9 @@ int __ref __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>>>  	struct resource *res;
>>>  	int ret;
>>>  
>>> +	if (!memhp_range_allowed(start, size, 1))
>>> +		return -ERANGE;
>>
>> We used to return -E2BIG, no? Maybe better keep that.
> 
> ERANGE seems to be better as the range can overrun on either side.

Did you check all callers that they can handle it? Should mention that
in the patch description then.

> 
>>
>>> +
>>>  	res = register_memory_resource(start, size, "System RAM");
>>>  	if (IS_ERR(res))
>>>  		return PTR_ERR(res);
>>> @@ -1123,6 +1106,9 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>>>  {
>>>  	int rc;
>>>  
>>> +	if (!memhp_range_allowed(start, size, 1))
>>> +		return -ERANGE;
>>> +
>>>  	lock_device_hotplug();
>>>  	rc = __add_memory(nid, start, size, mhp_flags);
>>>  	unlock_device_hotplug();
>>> @@ -1163,6 +1149,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>>>  	    resource_name[strlen(resource_name) - 1] != ')')
>>>  		return -EINVAL;
>>>  
>>> +	if (!memhp_range_allowed(start, size, 0))
>>> +		return -ERANGE;
>>> +
>>>  	lock_device_hotplug();
>>
>> For all 3 cases, doing a single check in register_memory_resource() is
>> sufficient.
> 
> Will replace with a single check in register_memory_resource(). But does
> add_memory_driver_managed() always require linear mapping ? The proposed
> check here did not ask for linear mapping in add_memory_driver_managed().

Yes, in that regard, it behaves just like add_memory().



-- 
Thanks,

David / dhildenb
