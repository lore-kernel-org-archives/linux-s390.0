Return-Path: <linux-kernel-owner+w=401wt.eu-S1756132AbYE2NCl@vger.kernel.org>
Message-Id: <20080529125729.105899442@de.ibm.com>
References: <20080529125501.196123527@de.ibm.com>
Date: Thu, 29 May 2008 14:55:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/11] Fix section mismatch warnings.
Content-Disposition: inline; filename=004-section.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This fixes the last remaining section mismatch warnings in s390
architecture code. It reveals also a real bug introduced by... me
with git commit 2069e978d5a6e7b45d58027e3de7f879b8c5e488
("[S390] sparsemem vmemmap: initialize memmap.")

Calling the generic vmemmap_alloc_block() function to get initialized
memory is a nice idea, however that function is __meminit annotated
and therefore the function might be gone if we try to call it later.
This can happen if a DCSS segment gets added.

So basically revert the patch and clear the memmap explicitly to fix
the original bug.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c          |    2 +-
 arch/s390/mm/vmem.c             |   18 +++++++++++++-----
 drivers/s390/char/sclp_config.c |    2 +-
 3 files changed, 15 insertions(+), 7 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -1089,7 +1089,7 @@ out:
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-int smp_rescan_cpus(void)
+int __ref smp_rescan_cpus(void)
 {
 	cpumask_t newcpus;
 	int cpu;
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -27,12 +27,19 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-static pud_t *vmem_pud_alloc(void)
+static void __ref *vmem_alloc_pages(unsigned int order)
+{
+	if (slab_is_available())
+		return (void *)__get_free_pages(GFP_KERNEL, order);
+	return alloc_bootmem_pages((1 << order) * PAGE_SIZE);
+}
+
+static inline pud_t *vmem_pud_alloc(void)
 {
 	pud_t *pud = NULL;
 
 #ifdef CONFIG_64BIT
-	pud = vmemmap_alloc_block(PAGE_SIZE * 4, 0);
+	pud = vmem_alloc_pages(2);
 	if (!pud)
 		return NULL;
 	clear_table((unsigned long *) pud, _REGION3_ENTRY_EMPTY, PAGE_SIZE * 4);
@@ -40,12 +47,12 @@ static pud_t *vmem_pud_alloc(void)
 	return pud;
 }
 
-static pmd_t *vmem_pmd_alloc(void)
+static inline pmd_t *vmem_pmd_alloc(void)
 {
 	pmd_t *pmd = NULL;
 
 #ifdef CONFIG_64BIT
-	pmd = vmemmap_alloc_block(PAGE_SIZE * 4, 0);
+	pmd = vmem_alloc_pages(2);
 	if (!pmd)
 		return NULL;
 	clear_table((unsigned long *) pmd, _SEGMENT_ENTRY_EMPTY, PAGE_SIZE * 4);
@@ -207,13 +214,14 @@ int __meminit vmemmap_populate(struct pa
 		if (pte_none(*pt_dir)) {
 			unsigned long new_page;
 
-			new_page =__pa(vmemmap_alloc_block(PAGE_SIZE, 0));
+			new_page =__pa(vmem_alloc_pages(0));
 			if (!new_page)
 				goto out;
 			pte = pfn_pte(new_page >> PAGE_SHIFT, PAGE_KERNEL);
 			*pt_dir = pte;
 		}
 	}
+	memset(start, 0, nr * sizeof(struct page));
 	ret = 0;
 out:
 	flush_tlb_kernel_range(start_addr, end_addr);
Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_config.c
+++ quilt-2.6/drivers/s390/char/sclp_config.c
@@ -40,7 +40,7 @@ static void sclp_cpu_capability_notify(s
 	put_online_cpus();
 }
 
-static void sclp_cpu_change_notify(struct work_struct *work)
+static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
 	smp_rescan_cpus();
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
