Return-Path: <linux-kernel-owner+w=401wt.eu-S1758132AbZCRMv0@vger.kernel.org>
Message-Id: <20090318124846.376656469@de.ibm.com>
References: <20090318124829.637003183@de.ibm.com>
Date: Wed, 18 Mar 2009 13:48:35 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/6] make page table upgrade work again
Content-Disposition: inline; filename=006-large-map.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

After TASK_SIZE now gives the current size of the address space the
upgrade of a 64 bit process from 3 to 4 levels of page table  needs
to use the arch_mmap_check hook to catch large mmap lengths. The
get_unmapped_area* functions need to check for -ENOMEM from the
arch_get_unmapped_area*, upgrade the page table and retry.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/mman.h |    5 ++++
 arch/s390/mm/mmap.c          |   44 +++++++++++++++++++++++++++++--------------
 2 files changed, 35 insertions(+), 14 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/mman.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/mman.h
+++ quilt-2.6/arch/s390/include/asm/mman.h
@@ -22,4 +22,9 @@
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__) && defined(CONFIG_64BIT)
+int s390_mmap_check(unsigned long addr, unsigned long len);
+#define arch_mmap_check(addr,len,flags)	s390_mmap_check(addr,len)
+#endif
+
 #endif /* __S390_MMAN_H__ */
Index: quilt-2.6/arch/s390/mm/mmap.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/mmap.c
+++ quilt-2.6/arch/s390/mm/mmap.c
@@ -89,42 +89,58 @@ EXPORT_SYMBOL_GPL(arch_pick_mmap_layout)
 
 #else
 
+int s390_mmap_check(unsigned long addr, unsigned long len)
+{
+	if (!test_thread_flag(TIF_31BIT) &&
+	    len >= TASK_SIZE && TASK_SIZE < (1UL << 53))
+		return crst_table_upgrade(current->mm, 1UL << 53);
+	return 0;
+}
+
 static unsigned long
 s390_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
+	unsigned long area;
 	int rc;
 
-	addr = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
-	if (addr & ~PAGE_MASK)
-		return addr;
-	if (unlikely(mm->context.asce_limit < addr + len)) {
-		rc = crst_table_upgrade(mm, addr + len);
+	area = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
+	if (!(area & ~PAGE_MASK))
+		return area;
+	if (area == -ENOMEM &&
+	    !test_thread_flag(TIF_31BIT) && TASK_SIZE < (1UL << 53)) {
+		/* Upgrade the page table to 4 levels and retry. */
+		rc = crst_table_upgrade(mm, 1UL << 53);
 		if (rc)
 			return (unsigned long) rc;
+		area = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
 	}
-	return addr;
+	return area;
 }
 
 static unsigned long
-s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
+s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
 			  const unsigned long len, const unsigned long pgoff,
 			  const unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long addr = addr0;
+	unsigned long area;
 	int rc;
 
-	addr = arch_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
-	if (addr & ~PAGE_MASK)
-		return addr;
-	if (unlikely(mm->context.asce_limit < addr + len)) {
-		rc = crst_table_upgrade(mm, addr + len);
+	area = arch_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
+	if (!(area & ~PAGE_MASK))
+		return area;
+	if (area == -ENOMEM &&
+	    !test_thread_flag(TIF_31BIT) && TASK_SIZE < (1UL << 53)) {
+		/* Upgrade the page table to 4 levels and retry. */
+		rc = crst_table_upgrade(mm, 1UL << 53);
 		if (rc)
 			return (unsigned long) rc;
+		area = arch_get_unmapped_area_topdown(filp, addr, len,
+						      pgoff, flags);
 	}
-	return addr;
+	return area;
 }
 /*
  * This function, called very early during the creation of a new

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
