Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH V3 2/3] arm64/mm: Define arch_get_mappable_range()
Date: Mon, 18 Jan 2021 18:43:00 +0530
Message-Id: <1610975582-12646-3-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com, hca@linux.ibm.com, catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Oscar Salvador <osalvador@suse.de>, Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This overrides arch_get_mappable_range() on arm64 platform which will be
used with recently added generic framework. It drops inside_linear_region()
and subsequent check in arch_add_memory() which are no longer required. It
also adds a VM_BUG_ON() check that would ensure that memhp_range_allowed()
has already been called.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index ae0c3d023824..f2e1770c9f29 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1442,16 +1442,19 @@ static void __remove_pgd_mapping(pgd_t *pgdir, unsigned long start, u64 size)
 	free_empty_tables(start, end, PAGE_OFFSET, PAGE_END);
 }
 
-static bool inside_linear_region(u64 start, u64 size)
+struct range arch_get_mappable_range(void)
 {
+	struct range memhp_range;
+
 	/*
 	 * Linear mapping region is the range [PAGE_OFFSET..(PAGE_END - 1)]
 	 * accommodating both its ends but excluding PAGE_END. Max physical
 	 * range which can be mapped inside this linear mapping range, must
 	 * also be derived from its end points.
 	 */
-	return start >= __pa(_PAGE_OFFSET(vabits_actual)) &&
-	       (start + size - 1) <= __pa(PAGE_END - 1);
+	memhp_range.start = __pa(_PAGE_OFFSET(vabits_actual));
+	memhp_range.end =  __pa(PAGE_END - 1);
+	return memhp_range;
 }
 
 int arch_add_memory(int nid, u64 start, u64 size,
@@ -1459,11 +1462,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 {
 	int ret, flags = 0;
 
-	if (!inside_linear_region(start, size)) {
-		pr_err("[%llx %llx] is outside linear mapping region\n", start, start + size);
-		return -EINVAL;
-	}
-
+	VM_BUG_ON(!memhp_range_allowed(start, size, true));
 	if (rodata_full || debug_pagealloc_enabled())
 		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 
-- 
2.20.1
