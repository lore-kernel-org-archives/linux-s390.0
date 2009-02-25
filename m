Return-Path: <linux-kernel-owner+w=401wt.eu-S1756656AbZBYPOK@vger.kernel.org>
Message-Id: <20090225150833.674275785@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 23/46] move EXPORT_SYMBOLs to definitions
Content-Disposition: inline; filename=122-export-symbols.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Move all EXPORT_SYMBOLs to their corresponding definitions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/bitmap.c     |    5 ++++
 arch/s390/kernel/process.c    |    2 +
 arch/s390/kernel/s390_ksyms.c |   44 ------------------------------------------
 arch/s390/kernel/setup.c      |    8 +++++++
 arch/s390/lib/delay.c         |    2 +
 arch/s390/mm/init.c           |    2 +
 6 files changed, 19 insertions(+), 44 deletions(-)

Index: quilt-2.6/arch/s390/kernel/bitmap.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/bitmap.c
+++ quilt-2.6/arch/s390/kernel/bitmap.c
@@ -7,10 +7,13 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/module.h>
 
 const char _oi_bitmap[] = { 0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80 };
+EXPORT_SYMBOL(_oi_bitmap);
 
 const char _ni_bitmap[] = { 0xfe, 0xfd, 0xfb, 0xf7, 0xef, 0xdf, 0xbf, 0x7f };
+EXPORT_SYMBOL(_ni_bitmap);
 
 const char _zb_findmap[] = {
 	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
@@ -29,6 +32,7 @@ const char _zb_findmap[] = {
 	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,5,
 	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,4,
 	0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,8 };
+EXPORT_SYMBOL(_zb_findmap);
 
 const char _sb_findmap[] = {
 	8,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
@@ -47,3 +51,4 @@ const char _sb_findmap[] = {
 	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
 	5,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0,
 	4,0,1,0,2,0,1,0,3,0,1,0,2,0,1,0 };
+EXPORT_SYMBOL(_sb_findmap);
Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -141,6 +141,7 @@ int kernel_thread(int (*fn)(void *), voi
 	return do_fork(flags | CLONE_VM | CLONE_UNTRACED,
 		       0, &regs, 0, NULL, NULL);
 }
+EXPORT_SYMBOL(kernel_thread);
 
 /*
  * Free current thread data structures etc..
@@ -318,6 +319,7 @@ int dump_fpu (struct pt_regs * regs, s39
 #endif /* CONFIG_64BIT */
 	return 1;
 }
+EXPORT_SYMBOL(dump_fpu);
 
 unsigned long get_wchan(struct task_struct *p)
 {
Index: quilt-2.6/arch/s390/kernel/s390_ksyms.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/s390_ksyms.c
+++ quilt-2.6/arch/s390/kernel/s390_ksyms.c
@@ -1,49 +1,5 @@
-/*
- *  arch/s390/kernel/s390_ksyms.c
- *
- *  S390 version
- */
-#include <linux/highuid.h>
 #include <linux/module.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/syscalls.h>
-#include <linux/interrupt.h>
-#include <asm/checksum.h>
-#include <asm/cpcmd.h>
-#include <asm/delay.h>
-#include <asm/pgalloc.h>
-#include <asm/setup.h>
 #include <asm/ftrace.h>
-#ifdef CONFIG_IP_MULTICAST
-#include <net/arp.h>
-#endif
-
-/*
- * memory management
- */
-EXPORT_SYMBOL(_oi_bitmap);
-EXPORT_SYMBOL(_ni_bitmap);
-EXPORT_SYMBOL(_zb_findmap);
-EXPORT_SYMBOL(_sb_findmap);
-
-/*
- * binfmt_elf loader 
- */
-extern int dump_fpu (struct pt_regs * regs, s390_fp_regs *fpregs);
-EXPORT_SYMBOL(dump_fpu);
-EXPORT_SYMBOL(empty_zero_page);
-
-/*
- * misc.
- */
-EXPORT_SYMBOL(machine_flags);
-EXPORT_SYMBOL(__udelay);
-EXPORT_SYMBOL(kernel_thread);
-EXPORT_SYMBOL(csum_fold);
-EXPORT_SYMBOL(console_mode);
-EXPORT_SYMBOL(console_devno);
-EXPORT_SYMBOL(console_irq);
 
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -74,9 +74,17 @@ EXPORT_SYMBOL(uaccess);
  * Machine setup..
  */
 unsigned int console_mode = 0;
+EXPORT_SYMBOL(console_mode);
+
 unsigned int console_devno = -1;
+EXPORT_SYMBOL(console_devno);
+
 unsigned int console_irq = -1;
+EXPORT_SYMBOL(console_irq);
+
 unsigned long machine_flags;
+EXPORT_SYMBOL(machine_flags);
+
 unsigned long elf_hwcap = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
Index: quilt-2.6/arch/s390/lib/delay.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/delay.c
+++ quilt-2.6/arch/s390/lib/delay.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/timex.h>
+#include <linux/module.h>
 #include <linux/irqflags.h>
 #include <linux/interrupt.h>
 
@@ -92,6 +93,7 @@ out:
 	local_irq_restore(flags);
 	preempt_enable();
 }
+EXPORT_SYMBOL(__udelay);
 
 /*
  * Simple udelay variant. To be used on startup and reboot
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -40,7 +40,9 @@
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
+
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
+EXPORT_SYMBOL(empty_zero_page);
 
 /*
  * paging_init() sets up the page tables

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
