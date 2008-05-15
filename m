Return-Path: <linux-kernel-owner+w=401wt.eu-S932642AbYEOPFd@vger.kernel.org>
Message-Id: <20080515150008.059041429@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/11] sparsemem vmemmap: initialize memmap.
Content-Disposition: inline; filename=003-sparsemem-fix.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Let's just use the generic vmmemmap_alloc_block() function which
always returns initialized memory.

Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/vmem.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -27,19 +27,12 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-static void __ref *vmem_alloc_pages(unsigned int order)
-{
-	if (slab_is_available())
-		return (void *)__get_free_pages(GFP_KERNEL, order);
-	return alloc_bootmem_pages((1 << order) * PAGE_SIZE);
-}
-
-static inline pud_t *vmem_pud_alloc(void)
+static pud_t *vmem_pud_alloc(void)
 {
 	pud_t *pud = NULL;
 
 #ifdef CONFIG_64BIT
-	pud = vmem_alloc_pages(2);
+	pud = vmemmap_alloc_block(PAGE_SIZE * 4, 0);
 	if (!pud)
 		return NULL;
 	clear_table((unsigned long *) pud, _REGION3_ENTRY_EMPTY, PAGE_SIZE * 4);
@@ -47,12 +40,12 @@ static inline pud_t *vmem_pud_alloc(void
 	return pud;
 }
 
-static inline pmd_t *vmem_pmd_alloc(void)
+static pmd_t *vmem_pmd_alloc(void)
 {
 	pmd_t *pmd = NULL;
 
 #ifdef CONFIG_64BIT
-	pmd = vmem_alloc_pages(2);
+	pmd = vmemmap_alloc_block(PAGE_SIZE * 4, 0);
 	if (!pmd)
 		return NULL;
 	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE * 4);
@@ -60,7 +53,7 @@ static inline pmd_t *vmem_pmd_alloc(void
 	return pmd;
 }
 
-static pte_t __init_refok *vmem_pte_alloc(void)
+static pte_t __ref *vmem_pte_alloc(void)
 {
 	pte_t *pte;
 
@@ -214,7 +207,7 @@ int __meminit vmemmap_populate(struct pa
 		if (pte_none(*pt_dir)) {
 			unsigned long new_page;
 
-			new_page =__pa(vmem_alloc_pages(0));
+			new_page =__pa(vmemmap_alloc_block(PAGE_SIZE, 0));
 			if (!new_page)
 				goto out;
 			pte = pfn_pte(new_page >> PAGE_SHIFT, PAGE_KERNEL);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
