Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727258AbgBDOnI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Feb 2020 09:43:08 -0500
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200204142516.GD26758@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e0006cc4-d448-89c6-38c0-51da7fc08715@redhat.com>
Date: Tue, 4 Feb 2020 15:42:56 +0100
MIME-Version: 1.0
In-Reply-To: <20200204142516.GD26758@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

On 04.02.20 15:25, Baoquan He wrote:
> On 10/06/19 at 10:56am, David Hildenbrand wrote:
>> If we have holes, the holes will automatically get detected and removed
>> once we remove the next bigger/smaller section. The extra checks can
>> go.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/memory_hotplug.c | 34 +++++++---------------------------
>>  1 file changed, 7 insertions(+), 27 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index f294918f7211..8dafa1ba8d9f 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>  		if (pfn) {
>>  			zone->zone_start_pfn = pfn;
>>  			zone->spanned_pages = zone_end_pfn - pfn;
>> +		} else {
>> +			zone->zone_start_pfn = 0;
>> +			zone->spanned_pages = 0;
>>  		}
>>  	} else if (zone_end_pfn == end_pfn) {
>>  		/*
>> @@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>>  					       start_pfn);
>>  		if (pfn)
>>  			zone->spanned_pages = pfn - zone_start_pfn + 1;
>> +		else {
>> +			zone->zone_start_pfn = 0;
>> +			zone->spanned_pages = 0;
> 
> Thinking in which case (zone_start_pfn != start_pfn) and it comes here.

Could only happen in case the zone_start_pfn would have been "out of the
zone already". If you ask me: unlikely :)

This change at least maintains the same result as before (where the
all-holes check would have caught it).

-- 
Thanks,

David / dhildenb
