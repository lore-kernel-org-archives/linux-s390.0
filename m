Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27496 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbgBEOsg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Feb 2020 09:48:36 -0500
Date: Wed, 5 Feb 2020 22:48:11 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v6 08/10] mm/memory_hotplug: Don't check for "all holes"
 in shrink_zone_span()
Message-ID: <20200205144811.GF26758@MiWiFi-R3L-srv>
References: <20191006085646.5768-1-david@redhat.com>
 <20191006085646.5768-9-david@redhat.com>
 <20200205095924.GC24162@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205095924.GC24162@richard>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

Hi Wei Yang,

On 02/05/20 at 05:59pm, Wei Yang wrote:
> >diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> >index f294918f7211..8dafa1ba8d9f 100644
> >--- a/mm/memory_hotplug.c
> >+++ b/mm/memory_hotplug.c
> >@@ -393,6 +393,9 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> > 		if (pfn) {
> > 			zone->zone_start_pfn = pfn;
> > 			zone->spanned_pages = zone_end_pfn - pfn;
> >+		} else {
> >+			zone->zone_start_pfn = 0;
> >+			zone->spanned_pages = 0;
> > 		}
> > 	} else if (zone_end_pfn == end_pfn) {
> > 		/*
> >@@ -405,34 +408,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
> > 					       start_pfn);
> > 		if (pfn)
> > 			zone->spanned_pages = pfn - zone_start_pfn + 1;
> >+		else {
> >+			zone->zone_start_pfn = 0;
> >+			zone->spanned_pages = 0;
> >+		}
> > 	}
> 
> If it is me, I would like to take out these two similar logic out.

I also like this style. 
> 
> For example:
> 
> 	if () {
> 	} else if () {
> 	} else {
> 		goto out;
Here the last else is unnecessary, right?

> 	}
> 
> 

Like this, I believe both David and I will be satisfactory. Even though
I still think his 2nd resetting is not needed :-)

> 	/* The zone has no valid section */
> 	if (!pfn) {
> 			zone->zone_start_pfn = 0;
> 			zone->spanned_pages = 0;
> 	}
> 
> out:
> 	zone_span_writeunlock(zone);
> 
> Well, this is just my personal taste :-)
> 
> >-
> >-	/*
> >-	 * The section is not biggest or smallest mem_section in the zone, it
> >-	 * only creates a hole in the zone. So in this case, we need not
> >-	 * change the zone. But perhaps, the zone has only hole data. Thus
> >-	 * it check the zone has only hole or not.
> >-	 */
> >-	pfn = zone_start_pfn;
> >-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SUBSECTION) {
> >-		if (unlikely(!pfn_to_online_page(pfn)))
> >-			continue;
> >-
> >-		if (page_zone(pfn_to_page(pfn)) != zone)
> >-			continue;
> >-
> >-		/* Skip range to be removed */
> >-		if (pfn >= start_pfn && pfn < end_pfn)
> >-			continue;
> >-
> >-		/* If we find valid section, we have nothing to do */
> >-		zone_span_writeunlock(zone);
> >-		return;
> >-	}
> >-
> >-	/* The zone has no valid section */
> >-	zone->zone_start_pfn = 0;
> >-	zone->spanned_pages = 0;
> > 	zone_span_writeunlock(zone);
> > }
> > 
> >-- 
> >2.21.0
> 
> -- 
> Wei Yang
> Help you, Help me
> 
