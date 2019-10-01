Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfJAOld (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Oct 2019 10:41:33 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 07/10] mm/memory_hotplug: We always have a zone in find_(smallest|biggest)_section_pfn
Date: Tue,  1 Oct 2019 16:40:08 +0200
Message-Id: <20191001144011.3801-8-david@redhat.com>
In-Reply-To: <20191001144011.3801-1-david@redhat.com>
References: <20191001144011.3801-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>, Wei Yang <richardw.yang@linux.intel.com>

With shrink_pgdat_span() out of the way, we now always have a valid
zone.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 640309236a58..273833612774 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -337,7 +337,7 @@ static unsigned long find_smallest_section_pfn(int nid, struct zone *zone,
 		if (unlikely(pfn_to_nid(start_pfn) != nid))
 			continue;
 
-		if (zone && zone != page_zone(pfn_to_page(start_pfn)))
+		if (zone != page_zone(pfn_to_page(start_pfn)))
 			continue;
 
 		return start_pfn;
@@ -362,7 +362,7 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 		if (unlikely(pfn_to_nid(pfn) != nid))
 			continue;
 
-		if (zone && zone != page_zone(pfn_to_page(pfn)))
+		if (zone != page_zone(pfn_to_page(pfn)))
 			continue;
 
 		return pfn;
-- 
2.21.0
