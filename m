Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729788AbfGOKp5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jul 2019 06:45:57 -0400
Subject: Re: [PATCH v3 03/11] s390x/mm: Implement arch_remove_memory()
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-4-david@redhat.com>
 <20190701074503.GD6376@dhcp22.suse.cz> <20190701124717.GU6376@dhcp22.suse.cz>
From: David Hildenbrand <david@redhat.com>
Message-ID: <556f2941-4c76-37f2-cac1-91eca48cc0e9@redhat.com>
Date: Mon, 15 Jul 2019 12:45:52 +0200
MIME-Version: 1.0
In-Reply-To: <20190701124717.GU6376@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Oscar Salvador <osalvador@suse.com>

On 01.07.19 14:47, Michal Hocko wrote:
> On Mon 01-07-19 09:45:03, Michal Hocko wrote:
>> On Mon 27-05-19 13:11:44, David Hildenbrand wrote:
>>> Will come in handy when wanting to handle errors after
>>> arch_add_memory().
>>
>> I do not understand this. Why do you add a code for something that is
>> not possible on this HW (based on the comment - is it still valid btw?)
> 
> Same as the previous patch (drop it).

No. As the description says, this will be needed to handle errors in
patch 6 cleanly.

And BTW, with paravirtualied devices like virtio-pmem and virtio-mem,
this will also see some other users in the future.

Thanks.

> 
>>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Oscar Salvador <osalvador@suse.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  arch/s390/mm/init.c | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index d552e330fbcc..14955e0a9fcf 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -243,12 +243,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>  void arch_remove_memory(int nid, u64 start, u64 size,
>>>  			struct vmem_altmap *altmap)
>>>  {
>>> -	/*
>>> -	 * There is no hardware or firmware interface which could trigger a
>>> -	 * hot memory remove on s390. So there is nothing that needs to be
>>> -	 * implemented.
>>> -	 */
>>> -	BUG();
>>> +	unsigned long start_pfn = start >> PAGE_SHIFT;
>>> +	unsigned long nr_pages = size >> PAGE_SHIFT;
>>> +	struct zone *zone;
>>> +
>>> +	zone = page_zone(pfn_to_page(start_pfn));
>>> +	__remove_pages(zone, start_pfn, nr_pages, altmap);
>>> +	vmem_remove_mapping(start, size);
>>>  }
>>>  #endif
>>>  #endif /* CONFIG_MEMORY_HOTPLUG */
>>> -- 
>>> 2.20.1
>>>
>>
>> -- 
>> Michal Hocko
>> SUSE Labs
> 


-- 

Thanks,

David / dhildenb
