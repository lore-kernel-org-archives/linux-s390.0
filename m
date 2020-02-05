Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:61277 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgBEW4U (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Feb 2020 17:56:20 -0500
Date: Thu, 6 Feb 2020 06:56:33 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200205225633.GA28446@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200205095924.GC24162@richard>
 <20200205144811.GF26758@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205144811.GF26758@MiWiFi-R3L-srv>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Baoquan He <bhe@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

On Wed, Feb 05, 2020 at 10:48:11PM +0800, Baoquan He wrote:
>Hi Wei Yang,
>
>On 02/05/20 at 05:59pm, Wei Yang wrote:
>> >diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> >index f294918f7211..8dafa1ba8d9f 100644
>> >--- a/mm/memory_hotplug.c
>> >+++ b/mm/memory_hotplug.c
>> >@@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>> > 		if (pfn) {
>> > 			zone->zone_start_pfn = pfn;
>> > 			zone->spanned_pages = zone_end_pfn - pfn;
>> >+		} else {
>> >+			zone->zone_start_pfn = 0;
>> >+			zone->spanned_pages = 0;
>> > 		}
>> > 	} else if (zone_end_pfn == end_pfn) {
>> > 		/*
>> >@@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
>> > 					       start_pfn);
>> > 		if (pfn)
>> > 			zone->spanned_pages = pfn - zone_start_pfn + 1;
>> >+		else {
>> >+			zone->zone_start_pfn = 0;
>> >+			zone->spanned_pages = 0;
>> >+		}
>> > 	}
>> 
>> If it is me, I would like to take out these two similar logic out.
>
>I also like this style. 
>> 
>> For example:
>> 
>> 	if () {
>> 	} else if () {
>> 	} else {
>> 		goto out;
>Here the last else is unnecessary, right?
>

I am afraid not.

If the range is not the first or last, we would leave pfn not initialized.


-- 
Wei Yang
Help you, Help me
