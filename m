Return-Path: <linux-kernel-owner+w=401wt.eu-S1757912AbYFCRJ5@vger.kernel.org>
Message-Id: <20080603170521.232745379@de.ibm.com>
References: <20080603165859.107949986@de.ibm.com>
Date: Tue, 03 Jun 2008 18:59:11 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 12/14] Introduce user_regset accessors for s390
Content-Disposition: inline; filename=111-user-regset.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add the user_regset definitions for normal and compat processes, replace
the dump_regs core dump cruft with the generic CORE_DUMP_USER_REGSET and
replace binfmt_elf32.c with the generic compat_binfmt_elf.c implementation.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig                |    1 
 arch/s390/kernel/Makefile        |    7 
 arch/s390/kernel/binfmt_elf32.c  |  214 ----------------------
 arch/s390/kernel/compat_ptrace.h |    4 
 arch/s390/kernel/ptrace.c        |  363 ++++++++++++++++++++++++++++++++++-----
 include/asm-s390/elf.h           |   51 +----
 include/asm-s390/processor.h     |   14 +
 include/asm-s390/ptrace.h        |   15 +
 8 files changed, 365 insertions(+), 304 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -146,6 +146,7 @@ config MATHEMU
 config COMPAT
 	bool "Kernel support for 31 bit emulation"
 	depends on 64BIT
+	select COMPAT_BINFMT_ELF
 	help
 	  Select this option if you want to enable your system kernel to
 	  handle system-calls from ELF binaries for 31 bit ESA.  This option
Index: quilt-2.6/arch/s390/kernel/binfmt_elf32.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/binfmt_elf32.c
+++ /dev/null
@@ -1,214 +0,0 @@
-/*
- * Support for 32-bit Linux for S390 ELF binaries.
- *
- * Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- * Author(s): Gerhard Tonn (ton@de.ibm.com)
- *
- * Heavily inspired by the 32-bit Sparc compat code which is
- * Copyright (C) 1995, 1996, 1997, 1998 David S. Miller (davem@redhat.com)
- * Copyright (C) 1995, 1996, 1997, 1998 Jakub Jelinek   (jj@ultra.linux.cz)
- */
-
-#define __ASMS390_ELF_H
-
-#include <linux/time.h>
-
-/*
- * These are used to set parameters in the core dumps.
- */
-#define ELF_CLASS	ELFCLASS32
-#define ELF_DATA	ELFDATA2MSB
-#define ELF_ARCH	EM_S390
-
-/*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) \
-	(((x)->e_machine == EM_S390 || (x)->e_machine == EM_S390_OLD) \
-         && (x)->e_ident[EI_CLASS] == ELF_CLASS)
-
-/* ELF register definitions */
-#define NUM_GPRS      16
-#define NUM_FPRS      16
-#define NUM_ACRS      16    
-
-/* For SVR4/S390 the function pointer to be registered with `atexit` is
-   passed in R14. */
-#define ELF_PLAT_INIT(_r, load_addr) \
-	do { \
-		_r->gprs[14] = 0; \
-	} while(0)
-
-#define USE_ELF_CORE_DUMP
-#define ELF_EXEC_PAGESIZE       4096
-
-/* This is the location that an ET_DYN program is loaded if exec'ed.  Typical
-   use of this is to invoke "./ld.so someprog" to test out a new version of
-   the loader.  We need to make sure that it is out of the way of the program
-   that it will "exec", and that there is sufficient room for the brk.  */
-
-#define ELF_ET_DYN_BASE         (TASK_SIZE / 3 * 2)
-
-/* Wow, the "main" arch needs arch dependent functions too.. :) */
-
-/* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
-   now struct_user_regs, they are different) */
-
-#define ELF_CORE_COPY_REGS(pr_reg, regs) dump_regs32(regs, &pr_reg);
-
-#define ELF_CORE_COPY_TASK_REGS(tsk, regs) dump_task_regs32(tsk, regs)
-
-#define ELF_CORE_COPY_FPREGS(tsk, fpregs) dump_task_fpu(tsk, fpregs)
-
-/* This yields a mask that user programs can use to figure out what
-   instruction set this CPU supports. */
-
-#define ELF_HWCAP (0)
-
-/* This yields a string that ld.so will use to load implementation
-   specific libraries for optimization.  This is more specific in
-   intent than poking at uname or /proc/cpuinfo.
-
-   For the moment, we have only optimizations for the Intel generations,
-   but that could change... */
-
-#define ELF_PLATFORM (NULL)
-
-#define SET_PERSONALITY(ex, ibcs2)			\
-do {							\
-	if (ibcs2)                                      \
-		set_personality(PER_SVR4);              \
-	else if (current->personality != PER_LINUX32)   \
-		set_personality(PER_LINUX);             \
-	set_thread_flag(TIF_31BIT);			\
-} while (0)
-
-#include "compat_linux.h"
-
-typedef _s390_fp_regs32 elf_fpregset_t;
-
-typedef struct
-{
-	
-	_psw_t32	psw;
-	__u32		gprs[__NUM_GPRS]; 
-	__u32		acrs[__NUM_ACRS]; 
-	__u32		orig_gpr2;
-} s390_regs32;
-typedef s390_regs32 elf_gregset_t;
-
-static inline int dump_regs32(struct pt_regs *ptregs, elf_gregset_t *regs)
-{
-	int i;
-
-	memcpy(&regs->psw.mask, &ptregs->psw.mask, 4);
-	memcpy(&regs->psw.addr, (char *)&ptregs->psw.addr + 4, 4);
-	for (i = 0; i < NUM_GPRS; i++)
-		regs->gprs[i] = ptregs->gprs[i];
-	save_access_regs(regs->acrs);
-	regs->orig_gpr2 = ptregs->orig_gpr2;
-	return 1;
-}
-
-static inline int dump_task_regs32(struct task_struct *tsk, elf_gregset_t *regs)
-{
-	struct pt_regs *ptregs = task_pt_regs(tsk);
-	int i;
-
-	memcpy(&regs->psw.mask, &ptregs->psw.mask, 4);
-	memcpy(&regs->psw.addr, (char *)&ptregs->psw.addr + 4, 4);
-	for (i = 0; i < NUM_GPRS; i++)
-		regs->gprs[i] = ptregs->gprs[i];
-	memcpy(regs->acrs, tsk->thread.acrs, sizeof(regs->acrs));
-	regs->orig_gpr2 = ptregs->orig_gpr2;
-	return 1;
-}
-
-static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
-{
-	if (tsk == current)
-		save_fp_regs((s390_fp_regs *) fpregs);
-	else
-		memcpy(fpregs, &tsk->thread.fp_regs, sizeof(elf_fpregset_t));
-	return 1;
-}
-
-#include <asm/processor.h>
-#include <asm/pgalloc.h>
-#include <linux/module.h>
-#include <linux/elfcore.h>
-#include <linux/binfmts.h>
-#include <linux/compat.h>
-
-#define elf_prstatus elf_prstatus32
-struct elf_prstatus32
-{
-	struct elf_siginfo pr_info;	/* Info associated with signal */
-	short	pr_cursig;		/* Current signal */
-	u32	pr_sigpend;	/* Set of pending signals */
-	u32	pr_sighold;	/* Set of held signals */
-	pid_t	pr_pid;
-	pid_t	pr_ppid;
-	pid_t	pr_pgrp;
-	pid_t	pr_sid;
-	struct compat_timeval pr_utime;	/* User time */
-	struct compat_timeval pr_stime;	/* System time */
-	struct compat_timeval pr_cutime;	/* Cumulative user time */
-	struct compat_timeval pr_cstime;	/* Cumulative system time */
-	elf_gregset_t pr_reg;	/* GP registers */
-	int pr_fpvalid;		/* True if math co-processor being used.  */
-};
-
-#define elf_prpsinfo elf_prpsinfo32
-struct elf_prpsinfo32
-{
-	char	pr_state;	/* numeric process state */
-	char	pr_sname;	/* char for pr_state */
-	char	pr_zomb;	/* zombie */
-	char	pr_nice;	/* nice val */
-	u32	pr_flag;	/* flags */
-	u16	pr_uid;
-	u16	pr_gid;
-	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
-	/* Lots missing */
-	char	pr_fname[16];	/* filename of executable */
-	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
-};
-
-#include <linux/highuid.h>
-
-/*
-#define init_elf_binfmt init_elf32_binfmt
-*/
-
-#undef start_thread
-#define start_thread                    start_thread31 
-
-static inline void start_thread31(struct pt_regs *regs, unsigned long new_psw,
-				  unsigned long new_stackp)
-{
-	set_fs(USER_DS);
-	regs->psw.mask	= psw_user32_bits;
-	regs->psw.addr	= new_psw;
-	regs->gprs[15]	= new_stackp;
-	crst_table_downgrade(current->mm, 1UL << 31);
-}
-
-MODULE_DESCRIPTION("Binary format loader for compatibility with 32bit Linux for S390 binaries,"
-                   " Copyright 2000 IBM Corporation"); 
-MODULE_AUTHOR("Gerhard Tonn <ton@de.ibm.com>");
-
-#undef MODULE_DESCRIPTION
-#undef MODULE_AUTHOR
-
-#undef cputime_to_timeval
-#define cputime_to_timeval cputime_to_compat_timeval
-static inline void
-cputime_to_compat_timeval(const cputime_t cputime, struct compat_timeval *value)
-{
-	value->tv_usec = cputime % 1000000;
-	value->tv_sec = cputime / 1000000;
-}
-
-#include "../../../fs/binfmt_elf.c"
-
Index: quilt-2.6/arch/s390/kernel/compat_ptrace.h
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_ptrace.h
+++ quilt-2.6/arch/s390/kernel/compat_ptrace.h
@@ -1,7 +1,7 @@
 #ifndef _PTRACE32_H
 #define _PTRACE32_H
 
-#include "compat_linux.h"  /* needed for _psw_t32 */
+#include "compat_linux.h"  /* needed for psw_compat_t */
 
 typedef struct {
 	__u32 cr[3];
@@ -38,7 +38,7 @@ typedef struct {
 
 struct user_regs_struct32
 {
-	_psw_t32 psw;
+	psw_compat_t psw;
 	u32 gprs[NUM_GPRS];
 	u32 acrs[NUM_ACRS];
 	u32 orig_gpr2;
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -7,6 +7,11 @@
 #
 CFLAGS_smp.o	:= -Wno-nonnull
 
+#
+# Pass UTS_MACHINE for user_regset definition
+#
+CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
+
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o
@@ -23,7 +28,7 @@ obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
 					compat_wrapper.o compat_exec_domain.o \
-					binfmt_elf32.o $(compat-obj-y)
+					$(compat-obj-y)
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
Index: quilt-2.6/arch/s390/kernel/ptrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ptrace.c
+++ quilt-2.6/arch/s390/kernel/ptrace.c
@@ -33,6 +33,8 @@
 #include <linux/security.h>
 #include <linux/audit.h>
 #include <linux/signal.h>
+#include <linux/elf.h>
+#include <linux/regset.h>
 
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -47,6 +49,11 @@
 #include "compat_ptrace.h"
 #endif
 
+enum s390_regset {
+	REGSET_GENERAL,
+	REGSET_FP,
+};
+
 static void
 FixPerRegisters(struct task_struct *task)
 {
@@ -126,24 +133,10 @@ ptrace_disable(struct task_struct *child
  * struct user contain pad bytes that should be read as zeroes.
  * Lovely...
  */
-static int
-peek_user(struct task_struct *child, addr_t addr, addr_t data)
+static unsigned long __peek_user(struct task_struct *child, addr_t addr)
 {
 	struct user *dummy = NULL;
-	addr_t offset, tmp, mask;
-
-	/*
-	 * Stupid gdb peeks/pokes the access registers in 64 bit with
-	 * an alignment of 4. Programmers from hell...
-	 */
-	mask = __ADDR_MASK;
-#ifdef CONFIG_64BIT
-	if (addr >= (addr_t) &dummy->regs.acrs &&
-	    addr < (addr_t) &dummy->regs.orig_gpr2)
-		mask = 3;
-#endif
-	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)
-		return -EIO;
+	addr_t offset, tmp;
 
 	if (addr < (addr_t) &dummy->regs.acrs) {
 		/*
@@ -197,24 +190,18 @@ peek_user(struct task_struct *child, add
 	} else
 		tmp = 0;
 
-	return put_user(tmp, (addr_t __user *) data);
+	return tmp;
 }
 
-/*
- * Write a word to the user area of a process at location addr. This
- * operation does have an additional problem compared to peek_user.
- * Stores to the program status word and on the floating point
- * control register needs to get checked for validity.
- */
 static int
-poke_user(struct task_struct *child, addr_t addr, addr_t data)
+peek_user(struct task_struct *child, addr_t addr, addr_t data)
 {
 	struct user *dummy = NULL;
-	addr_t offset, mask;
+	addr_t tmp, mask;
 
 	/*
 	 * Stupid gdb peeks/pokes the access registers in 64 bit with
-	 * an alignment of 4. Programmers from hell indeed...
+	 * an alignment of 4. Programmers from hell...
 	 */
 	mask = __ADDR_MASK;
 #ifdef CONFIG_64BIT
@@ -225,6 +212,21 @@ poke_user(struct task_struct *child, add
 	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)
 		return -EIO;
 
+	tmp = __peek_user(child, addr);
+	return put_user(tmp, (addr_t __user *) data);
+}
+
+/*
+ * Write a word to the user area of a process at location addr. This
+ * operation does have an additional problem compared to peek_user.
+ * Stores to the program status word and on the floating point
+ * control register needs to get checked for validity.
+ */
+static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
+{
+	struct user *dummy = NULL;
+	addr_t offset;
+
 	if (addr < (addr_t) &dummy->regs.acrs) {
 		/*
 		 * psw and gprs are stored on the stack
@@ -292,6 +294,28 @@ poke_user(struct task_struct *child, add
 	return 0;
 }
 
+static int
+poke_user(struct task_struct *child, addr_t addr, addr_t data)
+{
+	struct user *dummy = NULL;
+	addr_t mask;
+
+	/*
+	 * Stupid gdb peeks/pokes the access registers in 64 bit with
+	 * an alignment of 4. Programmers from hell indeed...
+	 */
+	mask = __ADDR_MASK;
+#ifdef CONFIG_64BIT
+	if (addr >= (addr_t) &dummy->regs.acrs &&
+	    addr < (addr_t) &dummy->regs.orig_gpr2)
+		mask = 3;
+#endif
+	if ((addr & mask) || addr > sizeof(struct user) - __ADDR_MASK)
+		return -EIO;
+
+	return __poke_user(child, addr, data);
+}
+
 long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
 	ptrace_area parea; 
@@ -367,18 +391,13 @@ long arch_ptrace(struct task_struct *chi
 /*
  * Same as peek_user but for a 31 bit program.
  */
-static int
-peek_user_emu31(struct task_struct *child, addr_t addr, addr_t data)
+static u32 __peek_user_compat(struct task_struct *child, addr_t addr)
 {
 	struct user32 *dummy32 = NULL;
 	per_struct32 *dummy_per32 = NULL;
 	addr_t offset;
 	__u32 tmp;
 
-	if (!test_thread_flag(TIF_31BIT) ||
-	    (addr & 3) || addr > sizeof(struct user) - 3)
-		return -EIO;
-
 	if (addr < (addr_t) &dummy32->regs.acrs) {
 		/*
 		 * psw and gprs are stored on the stack
@@ -435,25 +454,32 @@ peek_user_emu31(struct task_struct *chil
 	} else
 		tmp = 0;
 
+	return tmp;
+}
+
+static int peek_user_compat(struct task_struct *child,
+			    addr_t addr, addr_t data)
+{
+	__u32 tmp;
+
+	if (!test_thread_flag(TIF_31BIT) ||
+	    (addr & 3) || addr > sizeof(struct user) - 3)
+		return -EIO;
+
+	tmp = __peek_user_compat(child, addr);
 	return put_user(tmp, (__u32 __user *) data);
 }
 
 /*
  * Same as poke_user but for a 31 bit program.
  */
-static int
-poke_user_emu31(struct task_struct *child, addr_t addr, addr_t data)
+static int __poke_user_compat(struct task_struct *child,
+			      addr_t addr, addr_t data)
 {
 	struct user32 *dummy32 = NULL;
 	per_struct32 *dummy_per32 = NULL;
+	__u32 tmp = (__u32) data;
 	addr_t offset;
-	__u32 tmp;
-
-	if (!test_thread_flag(TIF_31BIT) ||
-	    (addr & 3) || addr > sizeof(struct user32) - 3)
-		return -EIO;
-
-	tmp = (__u32) data;
 
 	if (addr < (addr_t) &dummy32->regs.acrs) {
 		/*
@@ -528,6 +554,16 @@ poke_user_emu31(struct task_struct *chil
 	return 0;
 }
 
+static int poke_user_compat(struct task_struct *child,
+			    addr_t addr, addr_t data)
+{
+	if (!test_thread_flag(TIF_31BIT) ||
+	    (addr & 3) || addr > sizeof(struct user32) - 3)
+		return -EIO;
+
+	return __poke_user_compat(child, addr, data);
+}
+
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
@@ -539,11 +575,11 @@ long compat_arch_ptrace(struct task_stru
 	switch (request) {
 	case PTRACE_PEEKUSR:
 		/* read the word at location addr in the USER area. */
-		return peek_user_emu31(child, addr, data);
+		return peek_user_compat(child, addr, data);
 
 	case PTRACE_POKEUSR:
 		/* write the word at location addr in the USER area */
-		return poke_user_emu31(child, addr, data);
+		return poke_user_compat(child, addr, data);
 
 	case PTRACE_PEEKUSR_AREA:
 	case PTRACE_POKEUSR_AREA:
@@ -555,13 +591,13 @@ long compat_arch_ptrace(struct task_stru
 		copied = 0;
 		while (copied < parea.len) {
 			if (request == PTRACE_PEEKUSR_AREA)
-				ret = peek_user_emu31(child, addr, data);
+				ret = peek_user_compat(child, addr, data);
 			else {
 				__u32 utmp;
 				if (get_user(utmp,
 					     (__u32 __force __user *) data))
 					return -EFAULT;
-				ret = poke_user_emu31(child, addr, utmp);
+				ret = poke_user_compat(child, addr, utmp);
 			}
 			if (ret)
 				return ret;
@@ -610,3 +646,240 @@ syscall_trace(struct pt_regs *regs, int 
 				    regs->gprs[2], regs->orig_gpr2, regs->gprs[3],
 				    regs->gprs[4], regs->gprs[5]);
 }
+
+/*
+ * user_regset definitions.
+ */
+
+static int s390_regs_get(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 void *kbuf, void __user *ubuf)
+{
+	if (target == current)
+		save_access_regs(target->thread.acrs);
+
+	if (kbuf) {
+		unsigned long *k = kbuf;
+		while (count > 0) {
+			*k++ = __peek_user(target, pos);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		unsigned long __user *u = ubuf;
+		while (count > 0) {
+			if (__put_user(__peek_user(target, pos), u++))
+				return -EFAULT;
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+	return 0;
+}
+
+static int s390_regs_set(struct task_struct *target,
+			 const struct user_regset *regset,
+			 unsigned int pos, unsigned int count,
+			 const void *kbuf, const void __user *ubuf)
+{
+	int rc = 0;
+
+	if (target == current)
+		save_access_regs(target->thread.acrs);
+
+	if (kbuf) {
+		const unsigned long *k = kbuf;
+		while (count > 0 && !rc) {
+			rc = __poke_user(target, pos, *k++);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		const unsigned long  __user *u = ubuf;
+		while (count > 0 && !rc) {
+			unsigned long word;
+			rc = __get_user(word, u++);
+			if (rc)
+				break;
+			rc = __poke_user(target, pos, word);
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+
+	if (rc == 0 && target == current)
+		restore_access_regs(target->thread.acrs);
+
+	return rc;
+}
+
+static int s390_fpregs_get(struct task_struct *target,
+			   const struct user_regset *regset, unsigned int pos,
+			   unsigned int count, void *kbuf, void __user *ubuf)
+{
+	if (target == current)
+		save_fp_regs(&target->thread.fp_regs);
+
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				   &target->thread.fp_regs, 0, -1);
+}
+
+static int s390_fpregs_set(struct task_struct *target,
+			   const struct user_regset *regset, unsigned int pos,
+			   unsigned int count, const void *kbuf,
+			   const void __user *ubuf)
+{
+	int rc = 0;
+
+	if (target == current)
+		save_fp_regs(&target->thread.fp_regs);
+
+	/* If setting FPC, must validate it first. */
+	if (count > 0 && pos < offsetof(s390_fp_regs, fprs)) {
+		u32 fpc[2] = { target->thread.fp_regs.fpc, 0 };
+		rc = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &fpc,
+					0, offsetof(s390_fp_regs, fprs));
+		if (rc)
+			return rc;
+		if ((fpc[0] & ~FPC_VALID_MASK) != 0 || fpc[1] != 0)
+			return -EINVAL;
+		target->thread.fp_regs.fpc = fpc[0];
+	}
+
+	if (rc == 0 && count > 0)
+		rc = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					target->thread.fp_regs.fprs,
+					offsetof(s390_fp_regs, fprs), -1);
+
+	if (rc == 0 && target == current)
+		restore_fp_regs(&target->thread.fp_regs);
+
+	return rc;
+}
+
+static const struct user_regset s390_regsets[] = {
+	[REGSET_GENERAL] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = sizeof(s390_regs) / sizeof(long),
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.get = s390_regs_get,
+		.set = s390_regs_set,
+	},
+	[REGSET_FP] = {
+		.core_note_type = NT_PRFPREG,
+		.n = sizeof(s390_fp_regs) / sizeof(long),
+		.size = sizeof(long),
+		.align = sizeof(long),
+		.get = s390_fpregs_get,
+		.set = s390_fpregs_set,
+	},
+};
+
+static const struct user_regset_view user_s390_view = {
+	.name = UTS_MACHINE,
+	.e_machine = EM_S390,
+	.regsets = s390_regsets,
+	.n = ARRAY_SIZE(s390_regsets)
+};
+
+#ifdef CONFIG_COMPAT
+static int s390_compat_regs_get(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				void *kbuf, void __user *ubuf)
+{
+	if (target == current)
+		save_access_regs(target->thread.acrs);
+
+	if (kbuf) {
+		compat_ulong_t *k = kbuf;
+		while (count > 0) {
+			*k++ = __peek_user_compat(target, pos);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		compat_ulong_t __user *u = ubuf;
+		while (count > 0) {
+			if (__put_user(__peek_user_compat(target, pos), u++))
+				return -EFAULT;
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+	return 0;
+}
+
+static int s390_compat_regs_set(struct task_struct *target,
+				const struct user_regset *regset,
+				unsigned int pos, unsigned int count,
+				const void *kbuf, const void __user *ubuf)
+{
+	int rc = 0;
+
+	if (target == current)
+		save_access_regs(target->thread.acrs);
+
+	if (kbuf) {
+		const compat_ulong_t *k = kbuf;
+		while (count > 0 && !rc) {
+			rc = __poke_user_compat(target, pos, *k++);
+			count -= sizeof(*k);
+			pos += sizeof(*k);
+		}
+	} else {
+		const compat_ulong_t  __user *u = ubuf;
+		while (count > 0 && !rc) {
+			compat_ulong_t word;
+			rc = __get_user(word, u++);
+			if (rc)
+				break;
+			rc = __poke_user_compat(target, pos, word);
+			count -= sizeof(*u);
+			pos += sizeof(*u);
+		}
+	}
+
+	if (rc == 0 && target == current)
+		restore_access_regs(target->thread.acrs);
+
+	return rc;
+}
+
+static const struct user_regset s390_compat_regsets[] = {
+	[REGSET_GENERAL] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = sizeof(s390_compat_regs) / sizeof(compat_long_t),
+		.size = sizeof(compat_long_t),
+		.align = sizeof(compat_long_t),
+		.get = s390_compat_regs_get,
+		.set = s390_compat_regs_set,
+	},
+	[REGSET_FP] = {
+		.core_note_type = NT_PRFPREG,
+		.n = sizeof(s390_fp_regs) / sizeof(compat_long_t),
+		.size = sizeof(compat_long_t),
+		.align = sizeof(compat_long_t),
+		.get = s390_fpregs_get,
+		.set = s390_fpregs_set,
+	},
+};
+
+static const struct user_regset_view user_s390_compat_view = {
+	.name = "s390",
+	.e_machine = EM_S390,
+	.regsets = s390_compat_regsets,
+	.n = ARRAY_SIZE(s390_compat_regsets)
+};
+#endif
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+#ifdef CONFIG_COMPAT
+	if (test_tsk_thread_flag(task, TIF_31BIT))
+		return &user_s390_compat_view;
+#endif
+	return &user_s390_view;
+}
Index: quilt-2.6/include/asm-s390/elf.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/elf.h
+++ quilt-2.6/include/asm-s390/elf.h
@@ -113,6 +113,9 @@
 typedef s390_fp_regs elf_fpregset_t;
 typedef s390_regs elf_gregset_t;
 
+typedef s390_fp_regs compat_elf_fpregset_t;
+typedef s390_compat_regs compat_elf_gregset_t;
+
 #include <linux/sched.h>	/* for task_struct */
 #include <asm/system.h>		/* for save_access_regs */
 #include <asm/mmu_context.h>
@@ -123,6 +126,10 @@ typedef s390_regs elf_gregset_t;
 #define elf_check_arch(x) \
 	(((x)->e_machine == EM_S390 || (x)->e_machine == EM_S390_OLD) \
          && (x)->e_ident[EI_CLASS] == ELF_CLASS) 
+#define compat_elf_check_arch(x) \
+	(((x)->e_machine == EM_S390 || (x)->e_machine == EM_S390_OLD) \
+	 && (x)->e_ident[EI_CLASS] == ELF_CLASS)
+#define compat_start_thread	start_thread31
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
@@ -131,6 +138,7 @@ typedef s390_regs elf_gregset_t;
 		_r->gprs[14] = 0; \
 	} while (0)
 
+#define CORE_DUMP_USE_REGSET
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
 
@@ -140,44 +148,6 @@ typedef s390_regs elf_gregset_t;
    that it will "exec", and that there is sufficient room for the brk.  */
 #define ELF_ET_DYN_BASE		(STACK_TOP / 3 * 2)
 
-/* Wow, the "main" arch needs arch dependent functions too.. :) */
-
-/* regs is struct pt_regs, pr_reg is elf_gregset_t (which is
-   now struct_user_regs, they are different) */
-
-static inline int dump_regs(struct pt_regs *ptregs, elf_gregset_t *regs)
-{
-	memcpy(&regs->psw, &ptregs->psw, sizeof(regs->psw)+sizeof(regs->gprs));
-	save_access_regs(regs->acrs);
-	regs->orig_gpr2 = ptregs->orig_gpr2;
-	return 1;
-}
-
-#define ELF_CORE_COPY_REGS(pr_reg, regs) dump_regs(regs, &pr_reg);
-
-static inline int dump_task_regs(struct task_struct *tsk, elf_gregset_t *regs)
-{
-	struct pt_regs *ptregs = task_pt_regs(tsk);
-	memcpy(&regs->psw, &ptregs->psw, sizeof(regs->psw)+sizeof(regs->gprs));
-	memcpy(regs->acrs, tsk->thread.acrs, sizeof(regs->acrs));
-	regs->orig_gpr2 = ptregs->orig_gpr2;
-	return 1;
-}
-
-#define ELF_CORE_COPY_TASK_REGS(tsk, regs) dump_task_regs(tsk, regs)
-
-static inline int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
-{
-	if (tsk == current)
-		save_fp_regs(fpregs);
-	else
-		memcpy(fpregs, &tsk->thread.fp_regs, sizeof(elf_fpregset_t));
-	return 1;
-}
-
-#define ELF_CORE_COPY_FPREGS(tsk, fpregs) dump_task_fpu(tsk, fpregs)
-
-
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
 
@@ -204,7 +174,10 @@ do {							\
 		set_personality(PER_SVR4);		\
 	else if (current->personality != PER_LINUX32)	\
 		set_personality(PER_LINUX);		\
-	clear_thread_flag(TIF_31BIT);			\
+	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
+		set_thread_flag(TIF_31BIT);		\
+	else						\
+		clear_thread_flag(TIF_31BIT);		\
 } while (0)
 #endif /* __s390x__ */
 
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -143,11 +143,19 @@ struct stack_frame {
 /*
  * Do necessary setup to start up a new thread.
  */
-#define start_thread(regs, new_psw, new_stackp) do {            \
+#define start_thread(regs, new_psw, new_stackp) do {		\
 	set_fs(USER_DS);					\
 	regs->psw.mask	= psw_user_bits;			\
-        regs->psw.addr  = new_psw | PSW_ADDR_AMODE;             \
-        regs->gprs[15]  = new_stackp ;                          \
+	regs->psw.addr	= new_psw | PSW_ADDR_AMODE;		\
+	regs->gprs[15]	= new_stackp;				\
+} while (0)
+
+#define start_thread31(regs, new_psw, new_stackp) do {		\
+	set_fs(USER_DS);					\
+	regs->psw.mask	= psw_user32_bits;			\
+	regs->psw.addr	= new_psw | PSW_ADDR_AMODE;		\
+	regs->gprs[15]	= new_stackp;				\
+	crst_table_downgrade(current->mm, 1UL << 31);		\
 } while (0)
 
 /* Forward declaration, a strange C thing */
Index: quilt-2.6/include/asm-s390/ptrace.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ptrace.h
+++ quilt-2.6/include/asm-s390/ptrace.h
@@ -215,6 +215,12 @@ typedef struct 
         unsigned long addr;
 } __attribute__ ((aligned(8))) psw_t;
 
+typedef struct
+{
+	__u32	mask;
+	__u32	addr;
+} __attribute__ ((aligned(8))) psw_compat_t;
+
 #ifndef __s390x__
 
 #define PSW_MASK_PER		0x40000000UL
@@ -292,6 +298,15 @@ typedef struct
 	unsigned long orig_gpr2;
 } s390_regs;
 
+typedef struct
+{
+	psw_compat_t	psw;
+	__u32		gprs[NUM_GPRS];
+	__u32		acrs[NUM_ACRS];
+	__u32		orig_gpr2;
+} s390_compat_regs;
+
+
 #ifdef __KERNEL__
 #include <asm/setup.h>
 #include <asm/page.h>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
