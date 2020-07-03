Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51813 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgGCNjo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:39:44 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 8/9] s390/vmemmap: remember unused sub-pmd ranges
Date: Fri,  3 Jul 2020 15:39:16 +0200
Message-Id: <20200703133917.39045-9-david@redhat.com>
In-Reply-To: <20200703133917.39045-1-david@redhat.com>
References: <20200703133917.39045-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

With a memmap size of 56 bytes or 72 bytes per page, the memmap for a
256 MB section won't span full PMDs. As we populate single sections and
depopulate single sections, the depopulation step would not be able to
free all vmemmap pmds anymore.

Do it similarly to x86, marking the unused memmap ranges in a special way
(pad it with 0xFD).

This allows us to add/remove sections, cleaning up all allocated
vmemmap pages even if the memmap size is not multiple of 16 bytes per page.

A 56 byte memmap can, for example, be created with !CONFIG_MEMCG and
!CONFIG_SLUB.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 66 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b7fdb9536707f..a981ff5d47223 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -72,6 +72,42 @@ static void vmem_pte_free(unsigned long *table)
 	page_table_free(&init_mm, table);
 }
 
+#define PAGE_UNUSED 0xFD
+
+static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
+{
+	/*
+	 * As we expect to add in the same granularity as we remove, it's
+	 * sufficient to mark only some piece used to block the memmap page from
+	 * getting removed (just in case the memmap never gets initialized,
+	 * e.g., because the memory block never gets onlined).
+	 */
+	memset(__va(start), 0, sizeof(struct page));
+}
+
+static void vmemmap_use_new_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	/* Could be our memmap page is filled with PAGE_UNUSED already ... */
+	vmemmap_use_sub_pmd(start, end);
+
+	/* Mark the unused parts of the new memmap page PAGE_UNUSED. */
+	if (!IS_ALIGNED(start, PMD_SIZE))
+		memset(page, PAGE_UNUSED, start - __pa(page));
+	if (!IS_ALIGNED(end, PMD_SIZE))
+		memset(__va(end), PAGE_UNUSED, __pa(page) + PMD_SIZE - end);
+}
+
+/* Returns true if the PMD is completely unused and can be freed. */
+static bool vmemmap_unuse_sub_pmd(unsigned long start, unsigned long end)
+{
+	void *page = __va(ALIGN_DOWN(start, PMD_SIZE));
+
+	memset(__va(start), PAGE_UNUSED, end - start);
+	return !memchr_inv(page, PAGE_UNUSED, PMD_SIZE);
+}
+
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
@@ -213,6 +249,11 @@ static void remove_pmd_table(pud_t *pud, unsigned long addr,
 							get_order(PMD_SIZE));
 				pmd_clear(pmd);
 				pages++;
+			} else if (!direct &&
+				   vmemmap_unuse_sub_pmd(addr, next)) {
+				vmem_free_pages(pmd_deref(*pmd),
+						get_order(PMD_SIZE));
+				pmd_clear(pmd);
 			}
 			continue;
 		}
@@ -381,7 +422,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
 	unsigned long pgt_prot, sgt_prot;
-	unsigned long address = start;
+	unsigned long next, address = start;
 	pgd_t *pg_dir;
 	p4d_t *p4_dir;
 	pud_t *pu_dir;
@@ -425,16 +466,27 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		if (pmd_none(*pm_dir) && MACHINE_HAS_EDAT1) {
 			void *new_page;
 
-			/* Use 1MB frames for vmemmap if available. We always
+			/*
+			 * Use 1MB frames for vmemmap if available. We always
 			 * use large frames even if they are only partially
-			 * used.
+			 * used, and mark the unused parts using PAGE_UNUSED.
+			 *
+			 * This is only an issue in some setups. E.g.,
+			 * a full sections with 64 byte memmap per page need
+			 * 4 MB in total. However, with 56 byte, it's 3.5 MB.
+			 *
 			 * Otherwise we would have also page tables since
 			 * vmemmap_populate gets called for each section
-			 * separately. */
+			 * separately.
+			 */
 			new_page = vmemmap_alloc_block(PMD_SIZE, node);
 			if (new_page) {
 				pmd_val(*pm_dir) = __pa(new_page) | sgt_prot;
-				address = (address + PMD_SIZE) & PMD_MASK;
+				next = pmd_addr_end(address, end);
+				if (!IS_ALIGNED(next, PMD_SIZE) ||
+				    !IS_ALIGNED(address, PMD_SIZE))
+					vmemmap_use_new_sub_pmd(address, next);
+				address = next;
 				continue;
 			}
 		}
@@ -444,7 +496,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 				goto out;
 			pmd_populate(&init_mm, pm_dir, pt_dir);
 		} else if (pmd_large(*pm_dir)) {
-			address = (address + PMD_SIZE) & PMD_MASK;
+			next = pmd_addr_end(address, end);
+			vmemmap_use_sub_pmd(address, next);
+			address = next;
 			continue;
 		}
 
-- 
2.26.2
