Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFI5d (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 6 Oct 2019 04:57:33 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v6 06/10] mm/memory_hotplug: Poison memmap in remove_pfn_range_from_zone()
Date: Sun,  6 Oct 2019 10:56:42 +0200
Message-Id: <20191006085646.5768-7-david@redhat.com>
In-Reply-To: <20191006085646.5768-1-david@redhat.com>
References: <20191006085646.5768-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Dan Williams <dan.j.williams@intel.com>

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
index 5b003ffa5dc9..bf5173e7913d 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -464,6 +464,9 @@ void __ref remove_pfn_range_from_zone(struct zone *zone,
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long flags;
 
+	/* Poison struct pages because they are now uninitialized again. */
+	page_init_poison(pfn_to_page(start_pfn), sizeof(struct page) * nr_pages);
+
 #ifdef CONFIG_ZONE_DEVICE
 	/*
 	 * Zone shrinking code cannot properly deal with ZONE_DEVICE. So
diff --git a/mm/memremap.c b/mm/memremap.c
index 70263e6f093e..7fed8bd32a18 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -139,6 +139,8 @@ void memunmap_pages(struct dev_pagemap *pgmap)
 	nid = page_to_nid(first_page);
 
 	mem_hotplug_begin();
+	remove_pfn_range_from_zone(page_zone(first_page), PHYS_PFN(res->start),
+				   PHYS_PFN(resource_size(res)));
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		__remove_pages(PHYS_PFN(res->start),
 			       PHYS_PFN(resource_size(res)), NULL);
-- 
2.21.0
