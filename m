Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52276 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731720AbgGVJqX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:23 -0400
From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 6/9] s390/vmem: cleanup empty page tables
Date: Wed, 22 Jul 2020 11:45:55 +0200
Message-Id: <20200722094558.9828-7-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

Let's cleanup empty page tables. Consider only page tables that fully
fall into the idendity mapping and the vmemmap range.

As there are no valid accesses to vmem/vmemmap within non-populated ranges,
the single tlb flush at the end should be sufficient.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 102 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index a2b79681df69d..b831f9f9130aa 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -63,6 +63,15 @@ pte_t __ref *vmem_pte_alloc(void)
 	return pte;
 }
 
+static void vmem_pte_free(unsigned long *table)
+{
+	/* We don't expect boot memory to be removed ever. */
+	if (!slab_is_available() ||
+	    WARN_ON_ONCE(PageReserved(virt_to_page(table))))
+		return;
+	page_table_free(&init_mm, table);
+}
+
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 				  unsigned long end, bool add, bool direct)
@@ -105,6 +114,21 @@ static int __ref modify_pte_table(pmd_t *pmd, unsigned long addr,
 	return ret;
 }
 
+static void try_free_pte_table(pmd_t *pmd, unsigned long start)
+{
+	pte_t *pte;
+	int i;
+
+	/* We can safely assume this is fully in 1:1 mapping & vmemmap area */
+	pte = pte_offset_kernel(pmd, start);
+	for (i = 0; i < PTRS_PER_PTE; i++, pte++)
+		if (!pte_none(*pte))
+			return;
+
+	vmem_pte_free(__va(pmd_deref(*pmd)));
+	pmd_clear(pmd);
+}
+
 /* __ref: we'll only call vmemmap_alloc_block() via vmemmap_populate() */
 static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 				  unsigned long end, bool add, bool direct)
@@ -171,6 +195,8 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 		ret = modify_pte_table(pmd, addr, next, add, direct);
 		if (ret)
 			goto out;
+		if (!add)
+			try_free_pte_table(pmd, addr & PMD_MASK);
 	}
 	ret = 0;
 out:
@@ -179,6 +205,29 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
 	return ret;
 }
 
+static void try_free_pmd_table(pud_t *pud, unsigned long start)
+{
+	const unsigned long end = start + PUD_SIZE;
+	pmd_t *pmd;
+	int i;
+
+	/* Don't mess with any tables not fully in 1:1 mapping & vmemmap area */
+	if (end > VMALLOC_START)
+		return;
+#ifdef CONFIG_KASAN
+	if (start < KASAN_SHADOW_END && KASAN_SHADOW_START > end)
+		return;
+#endif
+
+	pmd = pmd_offset(pud, start);
+	for (i = 0; i < PTRS_PER_PMD; i++, pmd++)
+		if (!pmd_none(*pmd))
+			return;
+
+	vmem_free_pages(pud_deref(*pud), CRST_ALLOC_ORDER);
+	pud_clear(pud);
+}
+
 static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 			    bool add, bool direct)
 {
@@ -225,6 +274,8 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 		ret = modify_pmd_table(pud, addr, next, add, direct);
 		if (ret)
 			goto out;
+		if (!add)
+			try_free_pmd_table(pud, addr & PUD_MASK);
 	}
 	ret = 0;
 out:
@@ -233,6 +284,29 @@ static int modify_pud_table(p4d_t *p4d, unsigned long addr, unsigned long end,
 	return ret;
 }
 
+static void try_free_pud_table(p4d_t *p4d, unsigned long start)
+{
+	const unsigned long end = start + P4D_SIZE;
+	pud_t *pud;
+	int i;
+
+	/* Don't mess with any tables not fully in 1:1 mapping & vmemmap area */
+	if (end > VMALLOC_START)
+		return;
+#ifdef CONFIG_KASAN
+	if (start < KASAN_SHADOW_END && KASAN_SHADOW_START > end)
+		return;
+#endif
+
+	pud = pud_offset(p4d, start);
+	for (i = 0; i < PTRS_PER_PUD; i++, pud++)
+		if (!pud_none(*pud))
+			return;
+
+	vmem_free_pages(p4d_deref(*p4d), CRST_ALLOC_ORDER);
+	p4d_clear(p4d);
+}
+
 static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 			    bool add, bool direct)
 {
@@ -257,12 +331,37 @@ static int modify_p4d_table(pgd_t *pgd, unsigned long addr, unsigned long end,
 		ret = modify_pud_table(p4d, addr, next, add, direct);
 		if (ret)
 			goto out;
+		if (!add)
+			try_free_pud_table(p4d, addr & P4D_MASK);
 	}
 	ret = 0;
 out:
 	return ret;
 }
 
+static void try_free_p4d_table(pgd_t *pgd, unsigned long start)
+{
+	const unsigned long end = start + PGDIR_SIZE;
+	p4d_t *p4d;
+	int i;
+
+	/* Don't mess with any tables not fully in 1:1 mapping & vmemmap area */
+	if (end > VMALLOC_START)
+		return;
+#ifdef CONFIG_KASAN
+	if (start < KASAN_SHADOW_END && KASAN_SHADOW_START > end)
+		return;
+#endif
+
+	p4d = p4d_offset(pgd, start);
+	for (i = 0; i < PTRS_PER_P4D; i++, p4d++)
+		if (!p4d_none(*p4d))
+			return;
+
+	vmem_free_pages(pgd_deref(*pgd), CRST_ALLOC_ORDER);
+	pgd_clear(pgd);
+}
+
 static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 			    bool direct)
 {
@@ -291,6 +390,8 @@ static int modify_pagetable(unsigned long start, unsigned long end, bool add,
 		ret = modify_p4d_table(pgd, addr, next, add, direct);
 		if (ret)
 			goto out;
+		if (!add)
+			try_free_p4d_table(pgd, addr & PGDIR_MASK);
 	}
 	ret = 0;
 out:
@@ -319,7 +420,6 @@ static int vmem_add_range(unsigned long start, unsigned long size)
 
 /*
  * Remove a physical memory range from the 1:1 mapping.
- * Currently only invalidates page table entries.
  */
 static void vmem_remove_range(unsigned long start, unsigned long size)
 {
-- 
2.26.2
