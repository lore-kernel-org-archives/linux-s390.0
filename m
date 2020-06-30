Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41756 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387980AbgF3Q6v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 12:58:51 -0400
Subject: Re: [PATCH v1 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
References: <20200630081730.6862-1-david@redhat.com>
 <20200630081730.6862-2-david@redhat.com>
 <20200630162929.GC2500444@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
Date: Tue, 30 Jun 2020 18:58:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200630162929.GC2500444@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

>>  extern struct memblock memblock;
>> @@ -114,6 +110,19 @@ int memblock_remove(phys_addr_t base, phys_addr_t size);
>>  int memblock_free(phys_addr_t base, phys_addr_t size);
>>  int memblock_reserve(phys_addr_t base, phys_addr_t size);
>>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> +/**
>> + * for_each_physmem_range - iterate through physmem areas not included in type.
>> + * @i: u64 used as loop variable
>> + * @type: ptr to memblock_type which excludes from the iteration, can be %NULL
>> + * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
>> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
>> + */
>> +#define for_each_physmem_range(i, type, p_start, p_end)			\
>> +	for (i = 0, __next_physmem_range(&i, type, p_start, p_end);	\
>> +	     i != (u64)ULLONG_MAX;					\
>> +	     __next_physmem_range(&i, type, p_start, p_end))
>> +void __next_physmem_range(u64 *idx, struct memblock_type *type,
>> +			  phys_addr_t *out_start, phys_addr_t *out_end);
> 
> __next_physmem_range() is not really necessary, the
> for_each_physmem_range() macro can use __next_mem_range() directly, but
> I suspect it won't look nice :)
> 
> Can you please make __next_physmem_range() static inline if we are to
> keep it?

The thing is, then I have to expose "physmem" to something outside
memblock.c. That's what I wanted to avoid here. (instead, have a minimal
interface that is sufficient enough for this special case of physmem -
add memory during boot, walk memory after boot. Performance is not an
issue).

[...]

>>   * Each region is represented by :c:type:`struct memblock_region` that
>>   * defines the region extents, its attributes and NUMA node id on NUMA
>>   * systems. Every memory type is described by the :c:type:`struct
>>   * memblock_type` which contains an array of memory regions along with
>> - * the allocator metadata. The memory types are nicely wrapped with
>> - * :c:type:`struct memblock`. This structure is statically initialzed
>> - * at build time. The region arrays for the "memory" and "reserved"
>> - * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
>> - * "physmap" type to %INIT_PHYSMEM_REGIONS.
>> + * the allocator metadata. The memory types (except "physmem") are nicely
>> + * wrapped with :c:type:`struct memblock`. This structure is statically
>> + * initialized at build time. The region arrays for the "memory" and
>> + * "reserved" types are initially sized to %INIT_MEMBLOCK_REGIONS.
> 
> I'd prefer
> 
> 	... The "memory" and "reserved" types are nicely wrapped 
> 	with :c:type:`struct memblock`. This structure is statically
>         initialized at build time. 
> 
> And while on this we can update the "reserved" size to match the code:
> 
> 	The region arrays are initilily sized to %INIT_MEMBLOCK_REGIONS
>  	for "memory" and %INIT_MEMBLOCK_RESERVED_REGIONS for "reserved".

Ack to both!

-- 
Thanks,

David / dhildenb
