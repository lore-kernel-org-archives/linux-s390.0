Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24551 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgBDJ3b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Feb 2020 04:29:31 -0500
Subject: Re: [PATCH v6 09/10] mm/memory_hotplug: Drop local variables in
 shrink_zone_span()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-10-david@redhat.com> <20200204092623.GD6494@linux>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6e68be60-3a18-6956-74d6-4e3ba438cb05@redhat.com>
Date: Tue, 4 Feb 2020 10:29:18 +0100
MIME-Version: 1.0
In-Reply-To: <20200204092623.GD6494@linux>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

On 04.02.20 10:26, Oscar Salvador wrote:
> On Sun, Oct 06, 2019 at 10:56:45AM +0200, David Hildenbrand wrote:
>> Get rid of the unnecessary local variables.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/memory_hotplug.c | 15 ++++++---------
>>  1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 8dafa1ba8d9f..843481bd507d 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -374,14 +374,11 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
>>  static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>  			     unsigned long end_pfn)
>>  {
>> -	unsigned long zone_start_pfn = zone->zone_start_pfn;
>> -	unsigned long z = zone_end_pfn(zone); /* zone_end_pfn namespace clash */
>> -	unsigned long zone_end_pfn = z;
>>  	unsigned long pfn;
>>  	int nid = zone_to_nid(zone);
> 
> We could also remove the nid, right?
> AFAICS, the nid is only used in find_{smallest/biggest}_section_pfn so we could
> place there as well.


I remember sending a patch on this (which was acked, but not picked up
yet)...


oh, there it is :)

https://lore.kernel.org/linux-mm/20191127174158.28226-1-david@redhat.com/

Thanks!

-- 
Thanks,

David / dhildenb
