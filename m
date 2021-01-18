Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:35604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404276AbhARNNo (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 08:13:44 -0500
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range being added with platform
Date: Mon, 18 Jan 2021 18:42:59 +0530
Message-Id: <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This introduces memhp_range_allowed() which can be called in various memory
hotplug paths to prevalidate the address range which is being added, with
the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
which provides applicable address range depending on whether linear mapping
is required or not. For ranges that require linear mapping, it calls a new
arch callback arch_get_mappable_range() which the platform can override. So
the new callback, in turn provides the platform an opportunity to configure
acceptable memory hotplug address ranges in case there are constraints.

This mechanism will help prevent platform specific errors deep down during
hotplug calls. This drops now redundant check_hotplug_memory_addressable()
check in __add_pages() but instead adds a VM_BUG_ON() check which would
ensure that the range has been validated with memhp_range_allowed() earlier
in the call chain. Besides memhp_get_pluggable_range() also can be used by
potential memory hotplug callers to avail the allowed physical range which
would go through on a given platform.

This does not really add any new range check in generic memory hotplug but
instead compensates for lost checks in arch_add_memory() where applicable
and check_hotplug_memory_addressable(), with unified memhp_range_allowed().

Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memory_hotplug.h | 10 +++++
 mm/memory_hotplug.c            | 79 ++++++++++++++++++++++++++--------
 mm/memremap.c                  |  6 +++
 3 files changed, 76 insertions(+), 19 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 15acce5ab106..439b013f818a 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -70,6 +70,9 @@ typedef int __bitwise mhp_t;
  */
 #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+bool memhp_range_allowed(u64 start, u64 size, bool need_mapping);
+struct range memhp_get_pluggable_range(bool need_mapping);
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
@@ -281,6 +284,13 @@ static inline bool movable_node_is_enabled(void)
 }
 #endif /* ! CONFIG_MEMORY_HOTPLUG */
 
+/*
+ * Keep this declaration outside CONFIG_MEMORY_HOTPLUG as some
+ * platforms might override and use arch_get_mappable_range()
+ * for internal non memory hotplug purposes.
+ */
+struct range arch_get_mappable_range(void);
+
 #if defined(CONFIG_MEMORY_HOTPLUG) || defined(CONFIG_DEFERRED_STRUCT_PAGE_INIT)
 /*
  * pgdat resizing functions
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..f62664e77ff9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -107,6 +107,9 @@ static struct resource *register_memory_resource(u64 start, u64 size,
 	if (strcmp(resource_name, "System RAM"))
 		flags |= IORESOURCE_SYSRAM_DRIVER_MANAGED;
 
+	if (!memhp_range_allowed(start, size, true))
+		return ERR_PTR(-E2BIG);
+
 	/*
 	 * Make sure value parsed from 'mem=' only restricts memory adding
 	 * while booting, so that memory hotplug won't be impacted. Please
@@ -284,22 +287,6 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
-static int check_hotplug_memory_addressable(unsigned long pfn,
-					    unsigned long nr_pages)
-{
-	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
-
-	if (max_addr >> MAX_PHYSMEM_BITS) {
-		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
-		WARN(1,
-		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
-		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
-		return -E2BIG;
-	}
-
-	return 0;
-}
-
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -317,9 +304,8 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
 
-	err = check_hotplug_memory_addressable(pfn, nr_pages);
-	if (err)
-		return err;
+	if(!memhp_range_allowed(PFN_PHYS(pfn), nr_pages * PAGE_SIZE, false))
+		return -E2BIG;
 
 	if (altmap) {
 		/*
@@ -1180,6 +1166,61 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 }
 EXPORT_SYMBOL_GPL(add_memory_driver_managed);
 
+/*
+ * Platforms should define arch_get_mappable_range() that provides
+ * maximum possible addressable physical memory range for which the
+ * linear mapping could be created. The platform returned address
+ * range must adhere to these following semantics.
+ *
+ * - range.start <= range.end
+ * - Range includes both end points [range.start..range.end]
+ *
+ * There is also a fallback definition provided here, allowing the
+ * entire possible physical address range in case any platform does
+ * not define arch_get_mappable_range().
+ */
+struct range __weak arch_get_mappable_range(void)
+{
+	struct range memhp_range = {
+		.start = 0UL,
+		.end = -1ULL,
+	};
+	return memhp_range;
+}
+
+struct range memhp_get_pluggable_range(bool need_mapping)
+{
+	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
+	struct range memhp_range;
+
+	if (need_mapping) {
+		memhp_range = arch_get_mappable_range();
+		if (memhp_range.start > max_phys) {
+			memhp_range.start = 0;
+			memhp_range.end = 0;
+		}
+		memhp_range.end = min_t(u64, memhp_range.end, max_phys);
+	} else {
+		memhp_range.start = 0;
+		memhp_range.end = max_phys;
+	}
+	return memhp_range;
+}
+EXPORT_SYMBOL_GPL(memhp_get_pluggable_range);
+
+bool memhp_range_allowed(u64 start, u64 size, bool need_mapping)
+{
+	struct range memhp_range = memhp_get_pluggable_range(need_mapping);
+	u64 end = start + size;
+
+	if (start < end && start >= memhp_range.start && (end - 1) <= memhp_range.end)
+		return true;
+
+	pr_warn("Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
+		start, end, memhp_range.start, memhp_range.end);
+	return false;
+}
+
 #ifdef CONFIG_MEMORY_HOTREMOVE
 /*
  * Confirm all pages in a range [start, end) belong to the same zone (skipping
diff --git a/mm/memremap.c b/mm/memremap.c
index 16b2fb482da1..e15b13736f6a 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -253,6 +253,12 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 			goto err_kasan;
 		}
 
+		if (!memhp_range_allowed(range->start, range_len(range), true)) {
+			error = -ERANGE;
+			mem_hotplug_done();
+			goto err_add_memory;
+		}
+
 		error = arch_add_memory(nid, range->start, range_len(range),
 					params);
 	}
-- 
2.20.1
