Return-Path: <linux-kernel-owner@vger.kernel.org>
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/9] s390/vmemmap: implement vmemmap_free()
Date: Fri,  3 Jul 2020 15:39:11 +0200
Message-Id: <20200703133917.39045-4-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

Reuse the shiny new remove_pagetable(), tweaking it to handle freeing of
vmemmap pages, similar to the x86-64 variant (passing "bool direct" to
distinguish).

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 46 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 6fe156c3f035c..16e109c292bf5 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -29,6 +29,15 @@ static void __ref *vmem_alloc_pages(unsigned int order)
 	return (void *) memblock_phys_alloc(size, size);
 }
 
+static void vmem_free_pages(unsigned long addr, int order)
+{
+	/* We don't expect boot memory to be removed ever. */
+	if (!slab_is_available() ||
+	    WARN_ON_ONCE(PageReserved(phys_to_page(addr))))
+		return;
+	free_pages(addr, order);
+}
+
 void *vmem_crst_alloc(unsigned long val)
 {
 	unsigned long *table;
@@ -139,7 +148,7 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 }
 
 static void remove_pte_table(pmd_t *pmd, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long pages = 0;
 	pte_t *pte;
@@ -149,15 +158,18 @@ static void remove_pte_table(pmd_t *pmd, unsigned long addr,
 		if (pte_none(*pte))
 			continue;
 
+		if (!direct)
+			vmem_free_pages(pfn_to_phys(pte_pfn(*pte)), 0);
 		pte_clear(&init_mm, addr, pte);
 		pages++;
 	}
 
-	update_page_count(PG_DIRECT_MAP_4K, -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_4K, -pages);
 }
 
 static void remove_pmd_table(pud_t *pud, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long next, pages = 0;
 	pmd_t *pmd;
@@ -172,20 +184,24 @@ static void remove_pmd_table(pud_t *pud, unsigned long addr,
 		if (pmd_large(*pmd)) {
 			if (IS_ALIGNED(addr, PMD_SIZE) &&
 			    IS_ALIGNED(next, PMD_SIZE)) {
+				if (!direct)
+					vmem_free_pages(pmd_deref(*pmd),
+							get_order(PMD_SIZE));
 				pmd_clear(pmd);
 				pages++;
 			}
 			continue;
 		}
 
-		remove_pte_table(pmd, addr, next);
+		remove_pte_table(pmd, addr, next, direct);
 	}
 
-	update_page_count(PG_DIRECT_MAP_1M, -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_1M, -pages);
 }
 
 static void remove_pud_table(p4d_t *p4d, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long next, pages = 0;
 	pud_t *pud;
@@ -200,20 +216,22 @@ static void remove_pud_table(p4d_t *p4d, unsigned long addr,
 		if (pud_large(*pud)) {
 			if (IS_ALIGNED(addr, PUD_SIZE) &&
 			    IS_ALIGNED(next, PUD_SIZE)) {
+				WARN_ON_ONCE(!direct);
 				pud_clear(pud);
 				pages++;
 			}
 			continue;
 		}
 
-		remove_pmd_table(pud, addr, next);
+		remove_pmd_table(pud, addr, next, direct);
 	}
 
-	update_page_count(PG_DIRECT_MAP_2G, -pages);
+	if (direct)
+		update_page_count(PG_DIRECT_MAP_2G, -pages);
 }
 
 static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
-			     unsigned long end)
+			     unsigned long end, bool direct)
 {
 	unsigned long next;
 	p4d_t *p4d;
@@ -225,11 +243,12 @@ static void remove_p4d_table(pgd_t *pgd, unsigned long addr,
 		if (p4d_none(*p4d))
 			continue;
 
-		remove_pud_table(p4d, addr, next);
+		remove_pud_table(p4d, addr, next, direct);
 	}
 }
 
-static void remove_pagetable(unsigned long start, unsigned long end)
+static void remove_pagetable(unsigned long start, unsigned long end,
+			     bool direct)
 {
 	unsigned long addr, next;
 	pgd_t *pgd;
@@ -244,7 +263,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
 		if (pgd_none(*pgd))
 			continue;
 
-		remove_p4d_table(pgd, addr, next);
+		remove_p4d_table(pgd, addr, next, direct);
 	}
 
 	flush_tlb_kernel_range(start, end);
@@ -256,7 +275,7 @@ static void remove_pagetable(unsigned long start, unsigned long end)
  */
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
-	remove_pagetable(start, start + size);
+	remove_pagetable(start, start + size, true);
 }
 
 /*
@@ -351,6 +370,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap)
 {
+	remove_pagetable(start, end, false);
 }
 
 void vmem_remove_mapping(unsigned long start, unsigned long size)
-- 
2.26.2
