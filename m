Return-Path: <linux-kernel-owner+w=401wt.eu-S1756491AbZDNNyp@vger.kernel.org>
Message-Id: <20090414135346.480013162@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 01/14] s390: move machine flags to lowcore
Content-Disposition: inline; filename=001-machine-flags.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>

Currently the storage of the machine flags is a globally exported unsigned
long long variable. By moving the storage location into the lowcore struct we
allow assembler code to check machine_flags directly even without needing a
register. Addtionally the lowcore and therefore the machine flags too will be
in cache most of the time.

Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/cpuid.h       |   25 +++++++++++++++++++++++++
 arch/s390/include/asm/kvm_host.h    |    1 +
 arch/s390/include/asm/lowcore.h     |   12 ++++++++----
 arch/s390/include/asm/processor.h   |   17 +++--------------
 arch/s390/include/asm/ptrace.h      |    2 --
 arch/s390/include/asm/setup.h       |   24 ++++++++++++------------
 arch/s390/include/asm/thread_info.h |    3 ++-
 arch/s390/kernel/early.c            |    3 +++
 arch/s390/kernel/setup.c            |    4 +---
 arch/s390/kernel/smp.c              |    1 +
 10 files changed, 56 insertions(+), 36 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/cpuid.h
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/include/asm/cpuid.h
@@ -0,0 +1,25 @@
+/*
+ *    Copyright IBM Corp. 2000,2009
+ *    Author(s): Hartmut Penner <hp@de.ibm.com>,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *		 Christian Ehrhardt <ehrhardt@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_CPUID_H_
+#define _ASM_S390_CPUID_H_
+
+/*
+ *  CPU type and hardware bug flags. Kept separately for each CPU.
+ *  Members of this structure are referenced in head.S, so think twice
+ *  before touching them. [mj]
+ */
+
+typedef struct
+{
+	unsigned int version :	8;
+	unsigned int ident   : 24;
+	unsigned int machine : 16;
+	unsigned int unused  : 16;
+} __attribute__ ((packed)) cpuid_t;
+
+#endif /* _ASM_S390_CPUID_H_ */
Index: quilt-2.6/arch/s390/include/asm/kvm_host.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/kvm_host.h
+++ quilt-2.6/arch/s390/include/asm/kvm_host.h
@@ -15,6 +15,7 @@
 #define ASM_KVM_HOST_H
 #include <linux/kvm_host.h>
 #include <asm/debug.h>
+#include <asm/cpuid.h>
 
 #define KVM_MAX_VCPUS 64
 #define KVM_MEMORY_SLOTS 32
Index: quilt-2.6/arch/s390/include/asm/lowcore.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/lowcore.h
+++ quilt-2.6/arch/s390/include/asm/lowcore.h
@@ -66,6 +66,7 @@
 #define __LC_USER_EXEC_ASCE		0x02ac
 #define __LC_CPUID			0x02b0
 #define __LC_INT_CLOCK			0x02c8
+#define __LC_MACHINE_FLAGS		0x02d8
 #define __LC_IRB			0x0300
 #define __LC_PFAULT_INTPARM		0x0080
 #define __LC_CPU_TIMER_SAVE_AREA	0x00d8
@@ -110,6 +111,7 @@
 #define __LC_CPUID			0x0320
 #define __LC_INT_CLOCK			0x0340
 #define __LC_VDSO_PER_CPU		0x0350
+#define __LC_MACHINE_FLAGS		0x0358
 #define __LC_IRB			0x0380
 #define __LC_PASTE			0x03c0
 #define __LC_PFAULT_INTPARM		0x11b8
@@ -127,9 +129,9 @@
 
 #ifndef __ASSEMBLY__
 
-#include <asm/processor.h>
+#include <asm/cpuid.h>
+#include <asm/ptrace.h>
 #include <linux/types.h>
-#include <asm/sigp.h>
 
 void restart_int_handler(void);
 void ext_int_handler(void);
@@ -277,7 +279,8 @@ struct _lowcore
 	__u32	ext_call_fast;			/* 0x02c4 */
 	__u64	int_clock;			/* 0x02c8 */
 	__u64	clock_comparator;		/* 0x02d0 */
-	__u8	pad_0x02d8[0x0300-0x02d8];	/* 0x02d8 */
+	__u32	machine_flags;			/* 0x02d8 */
+	__u8	pad_0x02dc[0x0300-0x02dc];	/* 0x02dc */
 
 	/* Interrupt response block */
 	__u8	irb[64];			/* 0x0300 */
@@ -381,7 +384,8 @@ struct _lowcore
 	__u64	int_clock;			/* 0x0340 */
 	__u64	clock_comparator;		/* 0x0348 */
 	__u64	vdso_per_cpu_data;		/* 0x0350 */
-	__u8	pad_0x0358[0x0380-0x0358];	/* 0x0358 */
+	__u64	machine_flags;			/* 0x0358 */
+	__u8	pad_0x0360[0x0380-0x0360];	/* 0x0360 */
 
 	/* Interrupt response block. */
 	__u8	irb[64];			/* 0x0380 */
Index: quilt-2.6/arch/s390/include/asm/processor.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/processor.h
+++ quilt-2.6/arch/s390/include/asm/processor.h
@@ -14,7 +14,10 @@
 #define __ASM_S390_PROCESSOR_H
 
 #include <linux/linkage.h>
+#include <asm/cpuid.h>
+#include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/setup.h>
 
 #ifdef __KERNEL__
 /*
@@ -23,20 +26,6 @@
  */
 #define current_text_addr() ({ void *pc; asm("basr %0,0" : "=a" (pc)); pc; })
 
-/*
- *  CPU type and hardware bug flags. Kept separately for each CPU.
- *  Members of this structure are referenced in head.S, so think twice
- *  before touching them. [mj]
- */
-
-typedef struct
-{
-        unsigned int version :  8;
-        unsigned int ident   : 24;
-        unsigned int machine : 16;
-        unsigned int unused  : 16;
-} __attribute__ ((packed)) cpuid_t;
-
 static inline void get_cpu_id(cpuid_t *ptr)
 {
 	asm volatile("stidp 0(%1)" : "=m" (*ptr) : "a" (ptr));
Index: quilt-2.6/arch/s390/include/asm/ptrace.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/ptrace.h
+++ quilt-2.6/arch/s390/include/asm/ptrace.h
@@ -313,8 +313,6 @@ typedef struct
 
 
 #ifdef __KERNEL__
-#include <asm/setup.h>
-#include <asm/page.h>
 
 /*
  * The pt_regs struct defines the way the registers are stored on
Index: quilt-2.6/arch/s390/include/asm/setup.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/setup.h
+++ quilt-2.6/arch/s390/include/asm/setup.h
@@ -14,6 +14,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/lowcore.h>
 #include <asm/types.h>
 
 #define PARMAREA		0x10400
@@ -63,7 +64,6 @@ extern unsigned int s390_noexec;
 /*
  * Machine features detected in head.S
  */
-extern unsigned long machine_flags;
 
 #define MACHINE_FLAG_VM		(1UL << 0)
 #define MACHINE_FLAG_IEEE	(1UL << 1)
@@ -77,28 +77,28 @@ extern unsigned long machine_flags;
 #define MACHINE_FLAG_HPAGE	(1UL << 10)
 #define MACHINE_FLAG_PFMF	(1UL << 11)
 
-#define MACHINE_IS_VM		(machine_flags & MACHINE_FLAG_VM)
-#define MACHINE_IS_KVM		(machine_flags & MACHINE_FLAG_KVM)
-#define MACHINE_HAS_DIAG9C	(machine_flags & MACHINE_FLAG_DIAG9C)
+#define MACHINE_IS_VM		(S390_lowcore.machine_flags & MACHINE_FLAG_VM)
+#define MACHINE_IS_KVM		(S390_lowcore.machine_flags & MACHINE_FLAG_KVM)
+#define MACHINE_HAS_DIAG9C	(S390_lowcore.machine_flags & MACHINE_FLAG_DIAG9C)
 
 #ifndef __s390x__
-#define MACHINE_HAS_IEEE	(machine_flags & MACHINE_FLAG_IEEE)
-#define MACHINE_HAS_CSP		(machine_flags & MACHINE_FLAG_CSP)
+#define MACHINE_HAS_IEEE	(S390_lowcore.machine_flags & MACHINE_FLAG_IEEE)
+#define MACHINE_HAS_CSP		(S390_lowcore.machine_flags & MACHINE_FLAG_CSP)
 #define MACHINE_HAS_IDTE	(0)
 #define MACHINE_HAS_DIAG44	(1)
-#define MACHINE_HAS_MVPG	(machine_flags & MACHINE_FLAG_MVPG)
+#define MACHINE_HAS_MVPG	(S390_lowcore.machine_flags & MACHINE_FLAG_MVPG)
 #define MACHINE_HAS_MVCOS	(0)
 #define MACHINE_HAS_HPAGE	(0)
 #define MACHINE_HAS_PFMF	(0)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
-#define MACHINE_HAS_IDTE	(machine_flags & MACHINE_FLAG_IDTE)
-#define MACHINE_HAS_DIAG44	(machine_flags & MACHINE_FLAG_DIAG44)
+#define MACHINE_HAS_IDTE	(S390_lowcore.machine_flags & MACHINE_FLAG_IDTE)
+#define MACHINE_HAS_DIAG44	(S390_lowcore.machine_flags & MACHINE_FLAG_DIAG44)
 #define MACHINE_HAS_MVPG	(1)
-#define MACHINE_HAS_MVCOS	(machine_flags & MACHINE_FLAG_MVCOS)
-#define MACHINE_HAS_HPAGE	(machine_flags & MACHINE_FLAG_HPAGE)
-#define MACHINE_HAS_PFMF	(machine_flags & MACHINE_FLAG_PFMF)
+#define MACHINE_HAS_MVCOS	(S390_lowcore.machine_flags & MACHINE_FLAG_MVCOS)
+#define MACHINE_HAS_HPAGE	(S390_lowcore.machine_flags & MACHINE_FLAG_HPAGE)
+#define MACHINE_HAS_PFMF	(S390_lowcore.machine_flags & MACHINE_FLAG_PFMF)
 #endif /* __s390x__ */
 
 #define ZFCPDUMP_HSA_SIZE	(32UL<<20)
Index: quilt-2.6/arch/s390/include/asm/thread_info.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/thread_info.h
+++ quilt-2.6/arch/s390/include/asm/thread_info.h
@@ -31,8 +31,9 @@
 #define ASYNC_SIZE  (PAGE_SIZE << ASYNC_ORDER)
 
 #ifndef __ASSEMBLY__
-#include <asm/processor.h>
 #include <asm/lowcore.h>
+#include <asm/page.h>
+#include <asm/processor.h>
 
 /*
  * low level task data that entry.S needs immediate access to
Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -34,6 +34,8 @@
 
 char kernel_nss_name[NSS_NAME_SIZE + 1];
 
+static unsigned long machine_flags;
+
 static void __init setup_boot_command_line(void);
 
 
@@ -391,5 +393,6 @@ void __init startup_init(void)
 	setup_hpage();
 	sclp_facilities_detect();
 	detect_memory_layout(memory_chunk);
+	S390_lowcore.machine_flags = machine_flags;
 	lockdep_on();
 }
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -82,9 +82,6 @@ EXPORT_SYMBOL(console_devno);
 unsigned int console_irq = -1;
 EXPORT_SYMBOL(console_irq);
 
-unsigned long machine_flags;
-EXPORT_SYMBOL(machine_flags);
-
 unsigned long elf_hwcap = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
@@ -426,6 +423,7 @@ setup_lowcore(void)
 		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0) + PAGE_SIZE;
 	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
 	lc->thread_info = (unsigned long) &init_thread_union;
+	lc->machine_flags = S390_lowcore.machine_flags;
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE) {
 		lc->extended_save_area_addr = (__u32)
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -571,6 +571,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	cpu_lowcore->current_task = (unsigned long) idle;
 	cpu_lowcore->cpu_nr = cpu;
 	cpu_lowcore->kernel_asce = S390_lowcore.kernel_asce;
+	cpu_lowcore->machine_flags = S390_lowcore.machine_flags;
 	eieio();
 
 	while (signal_processor(cpu, sigp_restart) == sigp_busy)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
