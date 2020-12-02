Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:37766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729843AbgLBMQn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Dec 2020 07:16:43 -0500
Subject: Re: [RFC V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-2-git-send-email-anshuman.khandual@arm.com>
 <864c701a-4391-f768-1b95-1992e21835a2@redhat.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <349f7b33-cd5b-4240-e7c0-d8ad39c8ba71@arm.com>
Date: Wed, 2 Dec 2020 17:45:39 +0530
MIME-Version: 1.0
In-Reply-To: <864c701a-4391-f768-1b95-1992e21835a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, akpm@linux-foundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org


On 12/2/20 2:50 PM, David Hildenbrand wrote:
> On 30.11.20 04:29, Anshuman Khandual wrote:
>> This introduces memhp_range_allowed() which can be called in various memory
>> hotplug paths to prevalidate the address range which is being added, with
>> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
>> which provides applicable address range depending on whether linear mapping
>> is required or not. For ranges that require linear mapping, it calls a new
>> arch callback arch_get_mappable_range() which the platform can override. So
>> the new callback, in turn provides the platform an opportunity to configure
>> acceptable memory hotplug address ranges in case there are constraints.
>>
>> This mechanism will help prevent platform specific errors deep down during
>> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
>> check in __add_pages().
>>
> 
> 
> [...]
> 
>>  /*
>>   * Reasonably generic function for adding memory.  It is
>>   * expected that archs that support memory hotplug will
>> @@ -317,10 +304,6 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>  	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>>  		return -EINVAL;
>>  
>> -	err = check_hotplug_memory_addressable(pfn, nr_pages);
>> -	if (err)
>> -		return err;
>> -
> 
> I was wondering if we should add a VM_BUG_ON(!memhp_range_allowed())
> here to make it clearer that callers are expected to check that first.
> Maybe an other places as well (e.g., arch code where we remove the
> original checks)

Makes sense, will add them.

> 
> [...]
> 
> 
>>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>> diff --git a/mm/memremap.c b/mm/memremap.c
>> index 16b2fb482da1..26c1825756cc 100644
>> --- a/mm/memremap.c
>> +++ b/mm/memremap.c
>> @@ -185,6 +185,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
>>  static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>  		int range_id, int nid)
>>  {
>> +	const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;
>>  	struct range *range = &pgmap->ranges[range_id];
>>  	struct dev_pagemap *conflict_pgmap;
>>  	int error, is_ram;
>> @@ -230,6 +231,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>  	if (error)
>>  		goto err_pfn_remap;
>>  
>> +	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
>> +		goto err_pfn_remap;
>> +
>>  	mem_hotplug_begin();
>>  
>>  	/*
>> @@ -243,7 +247,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>>  	 * the CPU, we do want the linear mapping and thus use
>>  	 * arch_add_memory().
>>  	 */
>> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
>> +	if (is_private) {
>>  		error = add_pages(nid, PHYS_PFN(range->start),
>>  				PHYS_PFN(range_len(range)), params);
>>  	} else {
>>
> 
> In general, LGTM.
> 

Okay
