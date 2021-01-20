Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:50122 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730937AbhATIeQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 03:34:16 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
 <691872bb-b251-83e0-126e-afd54683c83e@redhat.com>
Message-ID: <3d4f3b14-0715-b2b3-b015-04b8a77abfb8@arm.com>
Date: Wed, 20 Jan 2021 14:03:45 +0530
MIME-Version: 1.0
In-Reply-To: <691872bb-b251-83e0-126e-afd54683c83e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/19/21 5:51 PM, David Hildenbrand wrote:
> On 18.01.21 14:12, Anshuman Khandual wrote:
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
>> check in __add_pages() but instead adds a VM_BUG_ON() check which would
> 
> In this patch, you keep the __add_pages() checks. But as discussed, we
> could perform it in mm/memremap.c:pagemap_range() insted and convert it
> to a VM_BUG_ON().

Just to be sure, will the following change achieve what you are
suggesting here. pagemap_range() after this change, will again
be the same like the V1 series.

---
 mm/memory_hotplug.c |  3 +--
 mm/memremap.c       | 12 +++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 46faa914aa25..10d4ec8f349c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -304,8 +304,7 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
 
-	if(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false))
-		return -E2BIG;
+	VM_BUG_ON(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false));
 
 	if (altmap) {
 		/*
diff --git a/mm/memremap.c b/mm/memremap.c
index e15b13736f6a..26c1825756cc 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -185,6 +185,7 @@ static void dev_pagemap_percpu_release(struct percpu_ref *ref)
 static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 		int range_id, int nid)
 {
+	const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;
 	struct range *range = &pgmap->ranges[range_id];
 	struct dev_pagemap *conflict_pgmap;
 	int error, is_ram;
@@ -230,6 +231,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	if (error)
 		goto err_pfn_remap;
 
+	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
+		goto err_pfn_remap;
+
 	mem_hotplug_begin();
 
 	/*
@@ -243,7 +247,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	 * the CPU, we do want the linear mapping and thus use
 	 * arch_add_memory().
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+	if (is_private) {
 		error = add_pages(nid, PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), params);
 	} else {
@@ -253,12 +257,6 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 			goto err_kasan;
 		}
 
-		if (!memhp_range_allowed(range->start, range_len(range), true)) {
-			error = -ERANGE;
-			mem_hotplug_done();
-			goto err_add_memory;
-		}
-
 		error = arch_add_memory(nid, range->start, range_len(range),
 					params);
 	}
-- 
2.20.1
