Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29980 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730296AbgGVJqQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:16 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/9] s390/vmem: consolidate vmem_add_range() and vmem_remove_range()
Date: Wed, 22 Jul 2020 11:45:51 +0200
Message-Id: <20200722094558.9828-3-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

We want to have only a single pagetable walker and reuse the same
functionality for vmemmap handling. Let's start by consolidating
vmem_add_range() and vmem_remove_range(), converting it into a
recursive implementation.

A recursive implementation makes it easier to expand individual cases
without harming readability. In addition, we minimize traversing the
whole hierarchy over and over again.

One change is that we don't unmap large PMDs/PUDs when not completely
covered by the request, something that should never happen with direct
mappings, unless one would be removing in other granularity than added,
which would be broken already.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 317 +++++++++++++++++++++++++++-----------------
 1 file changed, 198 insertions(+), 119 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 66c5333020ead..177daf389d391 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -54,148 +54,227 @@ pte_t __ref *vmem_pte_alloc(void)
 	return pte;
 }
 
-/*
- * Add a physical memory range to the 1:1 mapping.
- */
-static int vmem_add_range(unsigned long start, unsigned long size)
+static void modify_pte_table(pmd_t *pmd, unsigned long addr, unsigned long end,
+			    bool add)
 {
-	unsigned long pgt_prot, sgt_prot, r3_prot;
-	unsigned long pages4k, pages1m, pages2g;
-	unsigned long end = start + size;
-	unsigned long address = start;
-	pgd_t *pg_dir;
-	p4d_t *p4_dir;
-	pud_t *pu_dir;
-	pmd_t *pm_dir;
-	pte_t *pt_dir;
-	int ret = -ENOMEM;
+	unsigned long prot, pages = 0;
+	pte_t *pte;
 
-	pgt_prot = pgprot_val(PAGE_KERNEL);
-	sgt_prot = pgprot_val(SEGMENT_KERNEL);
-	r3_prot = pgprot_val(REGION3_KERNEL);
-	if (!MACHINE_HAS_NX) {
-		pgt_prot &= ~_PAGE_NOEXEC;
-		sgt_prot &= ~_SEGMENT_ENTRY_NOEXEC;
-		r3_prot &= ~_REGION_ENTRY_NOEXEC;
+	prot = pgprot_val(PAGE_KERNEL);
+	if (!MACHINE_HAS_NX)
+		prot &= ~_PAGE_NOEXEC;
+
+	pte = pte_offset_kernel(pmd, addr);
+	for (; addr < end; addr += PAGE_SIZE, pte++) {
+		if (!add) {
+			if (pte_none(*pte))
+				continue;
+			pte_clear(&init_mm, addr, pte);
+		} else if (pte_none(*pte)) {
+			pte_val(*pte) = addr | prot;
+		} else
+			continue;
+
+		pages++;
 	}
-	pages4k = pages1m = pages2g = 0;
-	while (address < end) {
-		pg_dir = pgd_offset_k(address);
-		if (pgd_none(*pg_dir)) {
-			p4_dir = vmem_crst_alloc(_REGION2_ENTRY_EMPTY);
-			if (!p4_dir)
-				goto out;
-			pgd_populate(&init_mm, pg_dir, p4_dir);
-		}
-		p4_dir = p4d_offset(pg_dir, address);
-		if (p4d_none(*p4_dir)) {
-			pu_dir = vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
-			if (!pu_dir)
+
+	update_page_count(PG_DIRECT_MAP_4K, add ? pages : -pages);
+}
+
+static int modify_pmd_table(pud_t *pud, unsigned long addr, unsigned long end,
+			    bool add)
+{
+	unsigned long next, prot, pages = 0;
+	int ret = -ENOMEM;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	prot = pgprot_val(SEGMENT_KERNEL);
+	if (!MACHINE_HAS_NX)
+		prot &= ~_SEGMENT_ENTRY_NOEXEC;
+
+	pmd = pmd_offset(pud, addr);
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+
+		if (!add) {
+			if (pmd_none(*pmd))
+				continue;
+			if (pmd_large(*pmd) && !add) {
+				if (IS_ALIGNED(addr, PMD_SIZE) &&
+				    IS_ALIGNED(next, PMD_SIZE)) {
+					pmd_clear(pmd);
+					pages++;
+				}
+				continue;
+			}
+		} else if (pmd_none(*pmd)) {
+			if (IS_ALIGNED(addr, PMD_SIZE) &&
+			    IS_ALIGNED(next, PMD_SIZE) &&
+			    MACHINE_HAS_EDAT1 && addr &&
+			    !debug_pagealloc_enabled()) {
+				pmd_val(*pmd) = addr | prot;
+				pages++;
+				continue;
+			}
+			pte = vmem_pte_alloc();
+			if (!pte)
 				goto out;
-			p4d_populate(&init_mm, p4_dir, pu_dir);
-		}
-		pu_dir = pud_offset(p4_dir, address);
-		if (MACHINE_HAS_EDAT2 && pud_none(*pu_dir) && address &&
-		    !(address & ~PUD_MASK) && (address + PUD_SIZE <= end) &&
-		     !debug_pagealloc_enabled()) {
-			pud_val(*pu_dir) = address | r3_prot;
-			address += PUD_SIZE;
-			pages2g++;
+			pmd_populate(&init_mm, pmd, pte);
+		} else if (pmd_large(*pmd))
 			continue;
-		}
-		if (pud_none(*pu_dir)) {
-			pm_dir = vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
-			if (!pm_dir)
+
+		modify_pte_table(pmd, addr, next, add);
+	}
+	ret = 0;
+out:
+	update_page_count(PG_DIRECT_MAP_1M, add ? pages : -pages);
+	return ret;
+}
+
+static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
+			    bool add)
+{
+	unsigned long next, prot, pages = 0;
+	int ret = -ENOMEM;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	prot = pgprot_val(REGION3_KERNEL);
+	if (!MACHINE_HAS_NX)
+		prot &= ~_REGION_ENTRY_NOEXEC;
+
+	pud = pud_offset(p4d, addr);
+	for (; addr < end; addr = next, pud++) {
+		next = pud_addr_end(addr, end);
+
+		if (!add) {
+			if (pud_none(*pud))
+				continue;
+			if (pud_large(*pud)) {
+				if (IS_ALIGNED(addr, PUD_SIZE) &&
+				    IS_ALIGNED(next, PUD_SIZE)) {
+					pud_clear(pud);
+					pages++;
+				}
+				continue;
+			}
+		} else if (pud_none(*pud)) {
+			if (IS_ALIGNED(addr, PUD_SIZE) &&
+			    IS_ALIGNED(next, PUD_SIZE) &&
+			    MACHINE_HAS_EDAT2 && addr &&
+			    !debug_pagealloc_enabled()) {
+				pud_val(*pud) = addr | prot;
+				pages++;
+				continue;
+			}
+			pmd = vmem_crst_alloc(_SEGMENT_ENTRY_EMPTY);
+			if (!pmd)
 				goto out;
-			pud_populate(&init_mm, pu_dir, pm_dir);
-		}
-		pm_dir = pmd_offset(pu_dir, address);
-		if (MACHINE_HAS_EDAT1 && pmd_none(*pm_dir) && address &&
-		    !(address & ~PMD_MASK) && (address + PMD_SIZE <= end) &&
-		    !debug_pagealloc_enabled()) {
-			pmd_val(*pm_dir) = address | sgt_prot;
-			address += PMD_SIZE;
-			pages1m++;
+			pud_populate(&init_mm, pud, pmd);
+		} else if (pud_large(*pud))
 			continue;
+
+		ret = modify_pmd_table(pud, addr, next, add);
+		if (ret)
+			goto out;
+	}
+	ret = 0;
+out:
+	update_page_count(PG_DIRECT_MAP_2G, add ? pages : -pages);
+	return ret;
+}
+
+static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
+			    bool add)
+{
+	unsigned long next;
+	int ret = -ENOMEM;
+	p4d_t *p4d;
+	pud_t *pud;
+
+	p4d = p4d_offset(pgd, addr);
+	for (; addr < end; addr = next, p4d++) {
+		next = p4d_addr_end(addr, end);
+
+		if (!add) {
+			if (p4d_none(*p4d))
+				continue;
+		} else if (p4d_none(*p4d)) {
+			pud = vmem_crst_alloc(_REGION3_ENTRY_EMPTY);
+			if (!pud)
+				goto out;
 		}
-		if (pmd_none(*pm_dir)) {
-			pt_dir = vmem_pte_alloc();
-			if (!pt_dir)
+
+		ret = modify_pud_table(p4d, addr, next, add);
+		if (ret)
+			goto out;
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+static int modify_pagetable(unsigned long start, unsigned long end, bool add)
+{
+	unsigned long addr, next;
+	int ret = -ENOMEM;
+	pgd_t *pgd;
+	p4d_t *p4d;
+
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(start | end)))
+		return -EINVAL;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+		pgd = pgd_offset_k(addr);
+
+		if (!add) {
+			if (pgd_none(*pgd))
+				continue;
+		} else if (pgd_none(*pgd)) {
+			p4d = vmem_crst_alloc(_REGION2_ENTRY_EMPTY);
+			if (!p4d)
 				goto out;
-			pmd_populate(&init_mm, pm_dir, pt_dir);
+			pgd_populate(&init_mm, pgd, p4d);
 		}
 
-		pt_dir = pte_offset_kernel(pm_dir, address);
-		pte_val(*pt_dir) = address | pgt_prot;
-		address += PAGE_SIZE;
-		pages4k++;
+		ret = modify_p4d_table(pgd, addr, next, add);
+		if (ret)
+			goto out;
 	}
 	ret = 0;
 out:
-	update_page_count(PG_DIRECT_MAP_4K, pages4k);
-	update_page_count(PG_DIRECT_MAP_1M, pages1m);
-	update_page_count(PG_DIRECT_MAP_2G, pages2g);
+	if (!add)
+		flush_tlb_kernel_range(start, end);
 	return ret;
 }
 
+static int add_pagetable(unsigned long start, unsigned long end)
+{
+	return modify_pagetable(start, end, true);
+}
+
+static int remove_pagetable(unsigned long start, unsigned long end)
+{
+	return modify_pagetable(start, end, false);
+}
+
+/*
+ * Add a physical memory range to the 1:1 mapping.
+ */
+static int vmem_add_range(unsigned long start, unsigned long size)
+{
+	return add_pagetable(start, start + size);
+}
+
 /*
  * Remove a physical memory range from the 1:1 mapping.
  * Currently only invalidates page table entries.
  */
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
-	unsigned long pages4k, pages1m, pages2g;
-	unsigned long end = start + size;
-	unsigned long address = start;
-	pgd_t *pg_dir;
-	p4d_t *p4_dir;
-	pud_t *pu_dir;
-	pmd_t *pm_dir;
-	pte_t *pt_dir;
-
-	pages4k = pages1m = pages2g = 0;
-	while (address < end) {
-		pg_dir = pgd_offset_k(address);
-		if (pgd_none(*pg_dir)) {
-			address += PGDIR_SIZE;
-			continue;
-		}
-		p4_dir = p4d_offset(pg_dir, address);
-		if (p4d_none(*p4_dir)) {
-			address += P4D_SIZE;
-			continue;
-		}
-		pu_dir = pud_offset(p4_dir, address);
-		if (pud_none(*pu_dir)) {
-			address += PUD_SIZE;
-			continue;
-		}
-		if (pud_large(*pu_dir)) {
-			pud_clear(pu_dir);
-			address += PUD_SIZE;
-			pages2g++;
-			continue;
-		}
-		pm_dir = pmd_offset(pu_dir, address);
-		if (pmd_none(*pm_dir)) {
-			address += PMD_SIZE;
-			continue;
-		}
-		if (pmd_large(*pm_dir)) {
-			pmd_clear(pm_dir);
-			address += PMD_SIZE;
-			pages1m++;
-			continue;
-		}
-		pt_dir = pte_offset_kernel(pm_dir, address);
-		pte_clear(&init_mm, address, pt_dir);
-		address += PAGE_SIZE;
-		pages4k++;
-	}
-	flush_tlb_kernel_range(start, end);
-	update_page_count(PG_DIRECT_MAP_4K, -pages4k);
-	update_page_count(PG_DIRECT_MAP_1M, -pages1m);
-	update_page_count(PG_DIRECT_MAP_2G, -pages2g);
+	remove_pagetable(start, start + size);
 }
 
 /*
-- 
2.26.2
