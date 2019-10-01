Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfJAOla (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Oct 2019 10:41:30 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v5 06/10] mm/memory_hotplug: Poison memmap in remove_pfn_range_from_zone()
Date: Tue,  1 Oct 2019 16:40:07 +0200
Message-Id: <20191001144011.3801-7-david@redhat.com>
In-Reply-To: <20191001144011.3801-1-david@redhat.com>
References: <20191001144011.3801-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

Let's poison the pages similar to when adding new memory in
sparse_add_section(). Also call remove_pfn_range_from_zone() from
memunmap_pages(), so we can poison the memmap from there as well.

While at it, calculate the pfn in memunmap_pages() only once.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 3 +++
 mm/memremap.c       | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index cef909ebd807..640309236a58 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -464,6 +464,9 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long flags;
 
+	/* Poison struct pages because they are now uninitialized again. */
+	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
+
 	/*
 	 * Zone shrinking code cannot properly deal with ZONE_DEVICE. So
 	 * we will not try to shrink the zones - which is okay as
diff --git a/mm/memremap.c b/mm/memremap.c
index 734afeaad811..371939f92b69 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -139,6 +139,8 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	nid = page_to_nid(pfn_to_page(start_pfn));
 
 	mem_hotplug_begin();
+	remove_pfn_range_from_zone(page_zone(pfn_to_page(start_pfn)),
+				   start_pfn, nr_pages);
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		__remove_pages(start_pfn, nr_pages, NULL);
 	} else {
-- 
2.21.0
