Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52268 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbgGCNjc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:39:32 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/9] s390/vmem: recursive implementation of vmem_remove_range()
Date: Fri,  3 Jul 2020 15:39:10 +0200
Message-Id: <20200703133917.39045-3-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

We want to reuse the same functionality in vmemmap_free(). Let's start by
introducing recursive remove_pagetable(), inspired by x86. We'll extend
it to cover the vmemmap similarly next.

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
 arch/s390/mm/vmem.c | 153 +++++++++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 46 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 66c5333020ead..6fe156c3f035c 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -138,64 +138,125 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 	return ret;
 }
 
-/*
- * Remove a physical memory range from the 1:1 mapping.
- * Currently only invalidates page table entries.
- */
-static void vmem_remove_range(unsigned long start, unsigned long size)
+static void remove_pte_table(pmd_t *pmd, unsigned long addr,
+			     unsigned long end)
 {
-	unsigned long pages4k, pages1m, pages2g;
-	unsigned long end = start + size;
-	unsigned long address = start;
-	pgd_t *pg_dir;
-	p4d_t *p4_dir;
-	pud_t *pu_dir;
-	pmd_t *pm_dir;
-	pte_t *pt_dir;
+	unsigned long pages = 0;
+	pte_t *pte;
 
-	pages4k = pages1m = pages2g = 0;
-	while (address < end) {
-		pg_dir = pgd_offset_k(address);
-		if (pgd_none(*pg_dir)) {
-			address += PGDIR_SIZE;
+	pte = pte_offset_kernel(pmd, addr);
+	for (; addr < end; addr += PAGE_SIZE, pte++) {
+		if (pte_none(*pte))
 			continue;
-		}
-		p4_dir = p4d_offset(pg_dir, address);
-		if (p4d_none(*p4_dir)) {
-			address += P4D_SIZE;
+
+		pte_clear(&init_mm, addr, pte);
+		pages++;
+	}
+
+	update_page_count(PG_DIRECT_MAP_4K, -pages);
+}
+
+static void remove_pmd_table(pud_t *pud, unsigned long addr,
+			     unsigned long end)
+{
+	unsigned long next, pages = 0;
+	pmd_t *pmd;
+
+	pmd = pmd_offset(pud, addr);
+	for (; addr < end; addr = next, pmd++) {
+		next = pmd_addr_end(addr, end);
+
+		if (pmd_none(*pmd))
 			continue;
-		}
-		pu_dir = pud_offset(p4_dir, address);
-		if (pud_none(*pu_dir)) {
-			address += PUD_SIZE;
+
+		if (pmd_large(*pmd)) {
+			if (IS_ALIGNED(addr, PMD_SIZE) &&
+			    IS_ALIGNED(next, PMD_SIZE)) {
+				pmd_clear(pmd);
+				pages++;
+			}
 			continue;
 		}
-		if (pud_large(*pu_dir)) {
-			pud_clear(pu_dir);
-			address += PUD_SIZE;
-			pages2g++;
+
+		remove_pte_table(pmd, addr, next);
+	}
+
+	update_page_count(PG_DIRECT_MAP_1M, -pages);
+}
+
+static void remove_pud_table(p4d_t *p4d, unsigned long addr,
+			     unsigned long end)
+{
+	unsigned long next, pages = 0;
+	pud_t *pud;
+
+	pud = pud_offset(p4d, addr);
+	for (; addr < end; addr = next, pud++) {
+		next = pud_addr_end(addr, end);
+
+		if (pud_none(*pud))
 			continue;
-		}
-		pm_dir = pmd_offset(pu_dir, address);
-		if (pmd_none(*pm_dir)) {
-			address += PMD_SIZE;
+
+		if (pud_large(*pud)) {
+			if (IS_ALIGNED(addr, PUD_SIZE) &&
+			    IS_ALIGNED(next, PUD_SIZE)) {
+				pud_clear(pud);
+				pages++;
+			}
 			continue;
 		}
-		if (pmd_large(*pm_dir)) {
-			pmd_clear(pm_dir);
-			address += PMD_SIZE;
-			pages1m++;
+
+		remove_pmd_table(pud, addr, next);
+	}
+
+	update_page_count(PG_DIRECT_MAP_2G, -pages);
+}
+
+static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
+			     unsigned long end)
+{
+	unsigned long next;
+	p4d_t *p4d;
+
+	p4d = p4d_offset(pgd, addr);
+	for (; addr < end; addr = next, p4d++) {
+		next = p4d_addr_end(addr, end);
+
+		if (p4d_none(*p4d))
 			continue;
-		}
-		pt_dir = pte_offset_kernel(pm_dir, address);
-		pte_clear(&init_mm, address, pt_dir);
-		address += PAGE_SIZE;
-		pages4k++;
+
+		remove_pud_table(p4d, addr, next);
 	}
+}
+
+static void remove_pagetable(unsigned long start, unsigned long end)
+{
+	unsigned long addr, next;
+	pgd_t *pgd;
+
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(start | end)))
+		return;
+
+	for (addr = start; addr < end; addr = next) {
+		next = pgd_addr_end(addr, end);
+		pgd = pgd_offset_k(addr);
+
+		if (pgd_none(*pgd))
+			continue;
+
+		remove_p4d_table(pgd, addr, next);
+	}
+
 	flush_tlb_kernel_range(start, end);
-	update_page_count(PG_DIRECT_MAP_4K, -pages4k);
-	update_page_count(PG_DIRECT_MAP_1M, -pages1m);
-	update_page_count(PG_DIRECT_MAP_2G, -pages2g);
+}
+
+/*
+ * Remove a physical memory range from the 1:1 mapping.
+ * Currently only invalidates page table entries.
+ */
+static void vmem_remove_range(unsigned long start, unsigned long size)
+{
+	remove_pagetable(start, start + size);
 }
 
 /*
-- 
2.26.2
