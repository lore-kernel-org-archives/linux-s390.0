Return-Path: <linux-kernel-owner+w=401wt.eu-S1757656AbZCRNug@vger.kernel.org>
Date: Wed, 18 Mar 2009 14:48:40 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 updates for 2.6.29-rc8
Message-ID: <20090318144840.59f1723e@skybase>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Gerald Schaefer (1):
      [S390] Dont check for pfn_valid() in uaccess_pt.c

Heiko Carstens (2):
      [S390] topology: define SD_MC_INIT to fix performance regression
      [S390] ftrace/mcount: fix kernel stack backchain

Martin Schwidefsky (3):
      [S390] __div64_31 broken for CONFIG_MARCH_G5
      [S390] make page table walking more robust
      [S390] make page table upgrade work again

 arch/s390/include/asm/mman.h      |    5 ++++
 arch/s390/include/asm/processor.h |    5 +--
 arch/s390/include/asm/topology.h  |    2 +
 arch/s390/kernel/mcount.S         |    6 +++-
 arch/s390/lib/div64.c             |    2 +-
 arch/s390/lib/uaccess_pt.c        |   18 --------------
 arch/s390/mm/mmap.c               |   48 ++++++++++++++++++++++++------------
 arch/s390/mm/pgtable.c            |    2 +
 8 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/s390/include/asm/mman.h b/arch/s390/include/asm/mman.h
index 7839767..da01432 100644
--- a/arch/s390/include/asm/mman.h
+++ b/arch/s390/include/asm/mman.h
@@ -22,4 +22,9 @@
 #define MCL_CURRENT	1		/* lock all current mappings */
 #define MCL_FUTURE	2		/* lock all future mappings */
 
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__) && defined(CONFIG_64BIT)
+int s390_mmap_check(unsigned long addr, unsigned long len);
+#define arch_mmap_check(addr,len,flags)	s390_mmap_check(addr,len)
+#endif
+
 #endif /* __S390_MMAN_H__ */
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 066b995..db4523f 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -61,7 +61,7 @@ extern void print_cpu_info(struct cpuinfo_S390 *);
 extern int get_cpu_capability(unsigned int *);
 
 /*
- * User space process size: 2GB for 31 bit, 4TB for 64 bit.
+ * User space process size: 2GB for 31 bit, 4TB or 8PT for 64 bit.
  */
 #ifndef __s390x__
 
@@ -70,8 +70,7 @@ extern int get_cpu_capability(unsigned int *);
 
 #else /* __s390x__ */
 
-#define TASK_SIZE_OF(tsk)	(test_tsk_thread_flag(tsk,TIF_31BIT) ? \
-					(1UL << 31) : (1UL << 53))
+#define TASK_SIZE_OF(tsk)	((tsk)->mm->context.asce_limit)
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
 					(1UL << 30) : (1UL << 41))
 #define TASK_SIZE		TASK_SIZE_OF(current)
diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index c93eb50..c979c3b 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -30,6 +30,8 @@ static inline void s390_init_cpu_topology(void)
 };
 #endif
 
+#define SD_MC_INIT SD_CPU_INIT
+
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_S390_TOPOLOGY_H */
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 397d131..8064122 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -5,6 +5,8 @@
  *
  */
 
+#include <asm/asm-offsets.h>
+
 #ifndef CONFIG_64BIT
 .globl _mcount
 _mcount:
@@ -14,7 +16,7 @@ _mcount:
 	ahi	%r15,-96
 	l	%r3,100(%r15)
 	la	%r2,0(%r14)
-	st	%r1,0(%r15)
+	st	%r1,__SF_BACKCHAIN(%r15)
 	la	%r3,0(%r3)
 	bras	%r14,0f
 	.long	ftrace_trace_function
@@ -38,7 +40,7 @@ _mcount:
 	stg	%r14,112(%r15)
 	lgr	%r1,%r15
 	aghi	%r15,-160
-	stg	%r1,0(%r15)
+	stg	%r1,__SF_BACKCHAIN(%r15)
 	lgr	%r2,%r14
 	lg	%r3,168(%r15)
 	larl	%r14,ftrace_trace_function
diff --git a/arch/s390/lib/div64.c b/arch/s390/lib/div64.c
index a5f8300..d9e62c0 100644
--- a/arch/s390/lib/div64.c
+++ b/arch/s390/lib/div64.c
@@ -61,7 +61,7 @@ static uint32_t __div64_31(uint64_t *n, uint32_t base)
 		"	clr	%0,%3\n"
 		"	jl	0f\n"
 		"	slr	%0,%3\n"
-		"	alr	%1,%2\n"
+		"	ahi	%1,1\n"
 		"0:\n"
 		: "+d" (reg2), "+d" (reg3), "=d" (tmp)
 		: "d" (base), "2" (1UL) : "cc" );
diff --git a/arch/s390/lib/uaccess_pt.c b/arch/s390/lib/uaccess_pt.c
index d66215b..b0b84c3 100644
--- a/arch/s390/lib/uaccess_pt.c
+++ b/arch/s390/lib/uaccess_pt.c
@@ -119,8 +119,6 @@ retry:
 			goto fault;
 
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn))
-			goto out;
 
 		offset = uaddr & (PAGE_SIZE - 1);
 		size = min(n - done, PAGE_SIZE - offset);
@@ -135,7 +133,6 @@ retry:
 		done += size;
 		uaddr += size;
 	} while (done < n);
-out:
 	spin_unlock(&mm->page_table_lock);
 	return n - done;
 fault:
@@ -163,9 +160,6 @@ retry:
 		goto fault;
 
 	pfn = pte_pfn(*pte);
-	if (!pfn_valid(pfn))
-		goto out;
-
 	ret = (pfn << PAGE_SHIFT) + (uaddr & (PAGE_SIZE - 1));
 out:
 	return ret;
@@ -244,11 +238,6 @@ retry:
 			goto fault;
 
 		pfn = pte_pfn(*pte);
-		if (!pfn_valid(pfn)) {
-			done = -1;
-			goto out;
-		}
-
 		offset = uaddr & (PAGE_SIZE-1);
 		addr = (char *)(pfn << PAGE_SHIFT) + offset;
 		len = min(count - done, PAGE_SIZE - offset);
@@ -256,7 +245,6 @@ retry:
 		done += len_str;
 		uaddr += len_str;
 	} while ((len_str == len) && (done < count));
-out:
 	spin_unlock(&mm->page_table_lock);
 	return done + 1;
 fault:
@@ -325,12 +313,7 @@ retry:
 		}
 
 		pfn_from = pte_pfn(*pte_from);
-		if (!pfn_valid(pfn_from))
-			goto out;
 		pfn_to = pte_pfn(*pte_to);
-		if (!pfn_valid(pfn_to))
-			goto out;
-
 		offset_from = uaddr_from & (PAGE_SIZE-1);
 		offset_to = uaddr_from & (PAGE_SIZE-1);
 		offset_max = max(offset_from, offset_to);
@@ -342,7 +325,6 @@ retry:
 		uaddr_from += size;
 		uaddr_to += size;
 	} while (done < n);
-out:
 	spin_unlock(&mm->page_table_lock);
 	return n - done;
 fault:
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 5932a82..e008d23 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -35,7 +35,7 @@
  * Leave an at least ~128 MB hole.
  */
 #define MIN_GAP (128*1024*1024)
-#define MAX_GAP (TASK_SIZE/6*5)
+#define MAX_GAP (STACK_TOP/6*5)
 
 static inline unsigned long mmap_base(void)
 {
@@ -46,7 +46,7 @@ static inline unsigned long mmap_base(void)
 	else if (gap > MAX_GAP)
 		gap = MAX_GAP;
 
-	return TASK_SIZE - (gap & PAGE_MASK);
+	return STACK_TOP - (gap & PAGE_MASK);
 }
 
 static inline int mmap_is_legacy(void)
@@ -89,42 +89,58 @@ EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
 
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
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0767827..6b6ddc4 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -117,6 +117,7 @@ repeat:
 		crst_table_init(table, entry);
 		pgd_populate(mm, (pgd_t *) table, (pud_t *) pgd);
 		mm->pgd = (pgd_t *) table;
+		mm->task_size = mm->context.asce_limit;
 		table = NULL;
 	}
 	spin_unlock(&mm->page_table_lock);
@@ -154,6 +155,7 @@ void crst_table_downgrade(struct mm_struct *mm, unsigned long limit)
 			BUG();
 		}
 		mm->pgd = (pgd_t *) (pgd_val(*pgd) & _REGION_ENTRY_ORIGIN);
+		mm->task_size = mm->context.asce_limit;
 		crst_table_free(mm, (unsigned long *) pgd);
 	}
 	update_mm(mm, current);
