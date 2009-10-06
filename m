Return-Path: <linux-kernel-owner+w=401wt.eu-S1756651AbZJFJIi@vger.kernel.org>
Date: Tue, 6 Oct 2009 11:07:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.32-rc3
Message-ID: <20091006110752.338c9014@mschwide.boeblingen.de.ibm.com>
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

more s390 patches. There is one bigger patch which is not a bug-fix,
the 64-bit register support for 31-bit processes. I hope that is still
ok-ish for rc3.

Please pull from 'for-linus' branch of

	git://git390.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

Christian Borntraeger (3):
      [S390] module: fix memory leak in s390 module loader
      [S390] Fix memory leak in /proc/cio_ignore
      [S390] Fix enabled udelay for short delays.

Felix Beck (2):
      [S390] zcrypt: Fix sparse warning.
      [S390] zcrypt: Improve some comments

Gerald Schaefer (1):
      [S390] Add EX_TABLE for addressing exception in usercopy functions.

Heiko Carstens (6):
      [S390] Enable kmemleak on s390.
      [S390] Provide arch specific mdelay implementation.
      [S390] compat: fix truncate system call wrapper
      [S390] ftrace: drop nmi protection
      [S390] perf_counter: fix vdso detection
      [S390] 64-bit register support for 31-bit processes

Martin Schwidefsky (2):
      [S390] fix build breakage with CONFIG_AIO=n
      [S390] pm: ignore time spend in suspended state

Michael Ernst (1):
      [S390] cio: channel path memory leak

Michael Holzheu (1):
      [S390] hibernate: Use correct place for CPU address in lowcore

Peter Oberparleiter (3):
      [S390] cio: make disconnected handling consistent
      [S390] cio: make not operational handling consistent
      [S390] cio: allow setting boxed devices offline

Sebastian Ott (1):
      [S390] 3270 console build fix

Stefan Haberland (1):
      [S390] dasd: fix race condition in resume code

 arch/s390/include/asm/delay.h       |    7 ++-
 arch/s390/include/asm/elf.h         |   12 ++++++
 arch/s390/include/asm/ptrace.h      |    4 ++
 arch/s390/include/asm/ucontext.h    |   15 +++++++
 arch/s390/kernel/compat_signal.c    |   35 +++++++++++++++++-
 arch/s390/kernel/compat_wrapper.S   |    2 +-
 arch/s390/kernel/ftrace.c           |    3 -
 arch/s390/kernel/module.c           |    3 +
 arch/s390/kernel/ptrace.c           |   70 +++++++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c            |   15 ++++++-
 arch/s390/kernel/swsusp_asm64.S     |   26 +++++++++---
 arch/s390/kernel/vdso.c             |   16 ++++----
 arch/s390/kernel/vmlinux.lds.S      |    1 +
 arch/s390/lib/delay.c               |   27 ++++++++-----
 arch/s390/lib/uaccess_mvcos.c       |   12 +++---
 arch/s390/lib/uaccess_std.c         |   14 ++++---
 arch/s390/mm/pgtable.c              |   10 ++++-
 drivers/s390/block/dasd.c           |    5 +-
 drivers/s390/block/dasd_eckd.c      |    9 +++-
 drivers/s390/char/raw3270.c         |    2 +
 drivers/s390/cio/blacklist.c        |   13 ++----
 drivers/s390/cio/chp.c              |    2 +-
 drivers/s390/cio/device.c           |    4 +-
 drivers/s390/cio/device.h           |    1 +
 drivers/s390/cio/device_fsm.c       |   35 +++++++++++++----
 drivers/s390/crypto/zcrypt_pcixcc.c |   13 ++++--
 include/linux/elf.h                 |    1 +
 lib/Kconfig.debug                   |    7 ++-
 28 files changed, 282 insertions(+), 82 deletions(-)

diff --git a/arch/s390/include/asm/delay.h b/arch/s390/include/asm/delay.h
index a356c95..8a096b8 100644
--- a/arch/s390/include/asm/delay.h
+++ b/arch/s390/include/asm/delay.h
@@ -14,10 +14,11 @@
 #ifndef _S390_DELAY_H
 #define _S390_DELAY_H
 
-extern void __udelay(unsigned long usecs);
-extern void udelay_simple(unsigned long usecs);
+extern void __udelay(unsigned long long usecs);
+extern void udelay_simple(unsigned long long usecs);
 extern void __delay(unsigned long loops);
 
-#define udelay(n) __udelay(n)
+#define udelay(n) __udelay((unsigned long long) (n))
+#define mdelay(n) __udelay((unsigned long long) (n) * 1000)
 
 #endif /* defined(_S390_DELAY_H) */
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 74d0bbb..e885442 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -92,6 +92,18 @@
 /* Keep this the last entry.  */
 #define R_390_NUM	61
 
+/* Bits present in AT_HWCAP. */
+#define HWCAP_S390_ESAN3	1
+#define HWCAP_S390_ZARCH	2
+#define HWCAP_S390_STFLE	4
+#define HWCAP_S390_MSA		8
+#define HWCAP_S390_LDISP	16
+#define HWCAP_S390_EIMM		32
+#define HWCAP_S390_DFP		64
+#define HWCAP_S390_HPAGE	128
+#define HWCAP_S390_ETF3EH	256
+#define HWCAP_S390_HIGH_GPRS	512
+
 /*
  * These are used to set parameters in the core dumps.
  */
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 539263f..95dcf18 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -311,6 +311,10 @@ typedef struct
 	__u32		orig_gpr2;
 } s390_compat_regs;
 
+typedef struct
+{
+	__u32		gprs_high[NUM_GPRS];
+} s390_compat_regs_high;
 
 #ifdef __KERNEL__
 
diff --git a/arch/s390/include/asm/ucontext.h b/arch/s390/include/asm/ucontext.h
index d69bec0..cfb874e 100644
--- a/arch/s390/include/asm/ucontext.h
+++ b/arch/s390/include/asm/ucontext.h
@@ -9,6 +9,21 @@
 #ifndef _ASM_S390_UCONTEXT_H
 #define _ASM_S390_UCONTEXT_H
 
+#define UC_EXTENDED	0x00000001
+
+#ifndef __s390x__
+
+struct ucontext_extended {
+	unsigned long	  uc_flags;
+	struct ucontext  *uc_link;
+	stack_t		  uc_stack;
+	_sigregs	  uc_mcontext;
+	unsigned long	  uc_sigmask[2];
+	unsigned long	  uc_gprs_high[16];
+};
+
+#endif
+
 struct ucontext {
 	unsigned long	  uc_flags;
 	struct ucontext  *uc_link;
diff --git a/arch/s390/kernel/compat_signal.c b/arch/s390/kernel/compat_signal.c
index b537cb0..eee9998 100644
--- a/arch/s390/kernel/compat_signal.c
+++ b/arch/s390/kernel/compat_signal.c
@@ -39,6 +39,7 @@ typedef struct
 	struct sigcontext32 sc;
 	_sigregs32 sregs;
 	int signo;
+	__u32 gprs_high[NUM_GPRS];
 	__u8 retcode[S390_SYSCALL_SIZE];
 } sigframe32;
 
@@ -48,6 +49,7 @@ typedef struct
 	__u8 retcode[S390_SYSCALL_SIZE];
 	compat_siginfo_t info;
 	struct ucontext32 uc;
+	__u32 gprs_high[NUM_GPRS];
 } rt_sigframe32;
 
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
@@ -344,6 +346,30 @@ static int restore_sigregs32(struct pt_regs *regs,_sigregs32 __user *sregs)
 	return 0;
 }
 
+static int save_sigregs_gprs_high(struct pt_regs *regs, __u32 __user *uregs)
+{
+	__u32 gprs_high[NUM_GPRS];
+	int i;
+
+	for (i = 0; i < NUM_GPRS; i++)
+		gprs_high[i] = regs->gprs[i] >> 32;
+
+	return __copy_to_user(uregs, &gprs_high, sizeof(gprs_high));
+}
+
+static int restore_sigregs_gprs_high(struct pt_regs *regs, __u32 __user *uregs)
+{
+	__u32 gprs_high[NUM_GPRS];
+	int err, i;
+
+	err = __copy_from_user(&gprs_high, uregs, sizeof(gprs_high));
+	if (err)
+		return err;
+	for (i = 0; i < NUM_GPRS; i++)
+		*(__u32 *)&regs->gprs[i] = gprs_high[i];
+	return 0;
+}
+
 asmlinkage long sys32_sigreturn(void)
 {
 	struct pt_regs *regs = task_pt_regs(current);
@@ -363,6 +389,8 @@ asmlinkage long sys32_sigreturn(void)
 
 	if (restore_sigregs32(regs, &frame->sregs))
 		goto badframe;
+	if (restore_sigregs_gprs_high(regs, frame->gprs_high))
+		goto badframe;
 
 	return regs->gprs[2];
 
@@ -394,6 +422,8 @@ asmlinkage long sys32_rt_sigreturn(void)
 
 	if (restore_sigregs32(regs, &frame->uc.uc_mcontext))
 		goto badframe;
+	if (restore_sigregs_gprs_high(regs, frame->gprs_high))
+		goto badframe;
 
 	err = __get_user(ss_sp, &frame->uc.uc_stack.ss_sp);
 	st.ss_sp = compat_ptr(ss_sp);
@@ -474,6 +504,8 @@ static int setup_frame32(int sig, struct k_sigaction *ka,
 
 	if (save_sigregs32(regs, &frame->sregs))
 		goto give_sigsegv;
+	if (save_sigregs_gprs_high(regs, frame->gprs_high))
+		goto give_sigsegv;
 	if (__put_user((unsigned long) &frame->sregs, &frame->sc.sregs))
 		goto give_sigsegv;
 
@@ -529,13 +561,14 @@ static int setup_rt_frame32(int sig, struct k_sigaction *ka, siginfo_t *info,
 		goto give_sigsegv;
 
 	/* Create the ucontext.  */
-	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(UC_EXTENDED, &frame->uc.uc_flags);
 	err |= __put_user(0, &frame->uc.uc_link);
 	err |= __put_user(current->sas_ss_sp, &frame->uc.uc_stack.ss_sp);
 	err |= __put_user(sas_ss_flags(regs->gprs[15]),
 	                  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
 	err |= save_sigregs32(regs, &frame->uc.uc_mcontext);
+	err |= save_sigregs_gprs_high(regs, frame->gprs_high);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto give_sigsegv;
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 682fb69..cbd9901 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -409,7 +409,7 @@ sys32_munmap_wrapper:
 	.globl	sys32_truncate_wrapper
 sys32_truncate_wrapper:
 	llgtr	%r2,%r2			# const char *
-	llgfr	%r3,%r3			# unsigned long
+	lgfr	%r3,%r3			# long
 	jg	sys_truncate		# branch to system call
 
 	.globl	sys32_ftruncate_wrapper
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 57bdcb1..f5fe34d 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -185,9 +185,6 @@ unsigned long prepare_ftrace_return(unsigned long ip, unsigned long parent)
 {
 	struct ftrace_graph_ent trace;
 
-	/* Nmi's are currently unsupported. */
-	if (unlikely(in_nmi()))
-		goto out;
 	if (unlikely(atomic_read(&current->tracing_graph_pause)))
 		goto out;
 	if (ftrace_push_return_trace(parent, ip, &trace.depth, 0) == -EBUSY)
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index ab2e3ed..639380a 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -55,6 +55,8 @@ void *module_alloc(unsigned long size)
 /* Free memory returned from module_alloc */
 void module_free(struct module *mod, void *module_region)
 {
+	vfree(mod->arch.syminfo);
+	mod->arch.syminfo = NULL;
 	vfree(module_region);
 }
 
@@ -402,6 +404,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    struct module *me)
 {
 	vfree(me->arch.syminfo);
+	me->arch.syminfo = NULL;
 	return module_bug_finalize(hdr, sechdrs, me);
 }
 
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index a873867..653c6a1 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -57,6 +57,7 @@
 enum s390_regset {
 	REGSET_GENERAL,
 	REGSET_FP,
+	REGSET_GENERAL_EXTENDED,
 };
 
 static void
@@ -879,6 +880,67 @@ static int s390_compat_regs_set(struct task_struct *target,
 	return rc;
 }
 
+static int s390_compat_regs_high_get(struct task_struct *target,
+				     const struct user_regset *regset,
+				     unsigned int pos, unsigned int count,
+				     void *kbuf, void __user *ubuf)
+{
+	compat_ulong_t *gprs_high;
+
+	gprs_high = (compat_ulong_t *)
+		&task_pt_regs(target)->gprs[pos / sizeof(compat_ulong_t)];
+	if (kbuf) {
+		compat_ulong_t *k = kbuf;
+		while (count > 0) {
+			*k++ = *gprs_high;
+			gprs_high += 2;
+			count -= sizeof(*k);
+		}
+	} else {
+		compat_ulong_t __user *u = ubuf;
+		while (count > 0) {
+			if (__put_user(*gprs_high, u++))
+				return -EFAULT;
+			gprs_high += 2;
+			count -= sizeof(*u);
+		}
+	}
+	return 0;
+}
+
+static int s390_compat_regs_high_set(struct task_struct *target,
+				     const struct user_regset *regset,
+				     unsigned int pos, unsigned int count,
+				     const void *kbuf, const void __user *ubuf)
+{
+	compat_ulong_t *gprs_high;
+	int rc = 0;
+
+	gprs_high = (compat_ulong_t *)
+		&task_pt_regs(target)->gprs[pos / sizeof(compat_ulong_t)];
+	if (kbuf) {
+		const compat_ulong_t *k = kbuf;
+		while (count > 0) {
+			*gprs_high = *k++;
+			*gprs_high += 2;
+			count -= sizeof(*k);
+		}
+	} else {
+		const compat_ulong_t  __user *u = ubuf;
+		while (count > 0 && !rc) {
+			unsigned long word;
+			rc = __get_user(word, u++);
+			if (rc)
+				break;
+			*gprs_high = word;
+			*gprs_high += 2;
+			count -= sizeof(*u);
+		}
+	}
+
+	return rc;
+}
+
 static const struct user_regset s390_compat_regsets[] = {
 	[REGSET_GENERAL] = {
 		.core_note_type = NT_PRSTATUS,
@@ -896,6 +958,14 @@ static const struct user_regset s390_compat_regsets[] = {
 		.get = s390_fpregs_get,
 		.set = s390_fpregs_set,
 	},
+	[REGSET_GENERAL_EXTENDED] = {
+		.core_note_type = NT_PRXSTATUS,
+		.n = sizeof(s390_compat_regs_high) / sizeof(compat_long_t),
+		.size = sizeof(compat_long_t),
+		.align = sizeof(compat_long_t),
+		.get = s390_compat_regs_high_get,
+		.set = s390_compat_regs_high_set,
+	},
 };
 
 static const struct user_regset_view user_s390_compat_view = {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 9ed13a1..061479f 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -729,7 +729,7 @@ static void __init setup_hwcaps(void)
 
 	if ((facility_list & (1UL << (31 - 22)))
 	    && (facility_list & (1UL << (31 - 30))))
-		elf_hwcap |= 1UL << 8;
+		elf_hwcap |= HWCAP_S390_ETF3EH;
 
 	/*
 	 * Check for additional facilities with store-facility-list-extended.
@@ -748,11 +748,20 @@ static void __init setup_hwcaps(void)
 	    __stfle(&facility_list_extended, 1) > 0) {
 		if ((facility_list_extended & (1ULL << (63 - 42)))
 		    && (facility_list_extended & (1ULL << (63 - 44))))
-			elf_hwcap |= 1UL << 6;
+			elf_hwcap |= HWCAP_S390_DFP;
 	}
 
+	/*
+	 * Huge page support HWCAP_S390_HPAGE is bit 7.
+	 */
 	if (MACHINE_HAS_HPAGE)
-		elf_hwcap |= 1UL << 7;
+		elf_hwcap |= HWCAP_S390_HPAGE;
+
+	/*
+	 * 64-bit register support for 31-bit processes
+	 * HWCAP_S390_HIGH_GPRS is bit 9.
+	 */
+	elf_hwcap |= HWCAP_S390_HIGH_GPRS;
 
 	switch (S390_lowcore.cpu_id.machine) {
 	case 0x9672:
diff --git a/arch/s390/kernel/swsusp_asm64.S b/arch/s390/kernel/swsusp_asm64.S
index fe927d0..7c8653e 100644
--- a/arch/s390/kernel/swsusp_asm64.S
+++ b/arch/s390/kernel/swsusp_asm64.S
@@ -43,7 +43,7 @@ swsusp_arch_suspend:
 	lghi	%r1,0x1000
 
 	/* Save CPU address */
-	stap	__LC_CPU_ADDRESS(%r1)
+	stap	__LC_CPU_ADDRESS(%r0)
 
 	/* Store registers */
 	mvc	0x318(4,%r1),__SF_EMPTY(%r15)	/* move prefix to lowcore */
@@ -69,8 +69,21 @@ swsusp_arch_suspend:
 	stmg	%r0,%r15,0x280(%r1)		/* store general registers */
 
 	stpt	0x328(%r1)			/* store timer */
+	stck	__SF_EMPTY(%r15)		/* store clock */
 	stckc	0x330(%r1)			/* store clock comparator */
 
+	/* Update cputime accounting before going to sleep */
+	lg	%r0,__LC_LAST_UPDATE_TIMER
+	slg	%r0,0x328(%r1)
+	alg	%r0,__LC_SYSTEM_TIMER
+	stg	%r0,__LC_SYSTEM_TIMER
+	mvc	__LC_LAST_UPDATE_TIMER(8),0x328(%r1)
+	lg	%r0,__LC_LAST_UPDATE_CLOCK
+	slg	%r0,__SF_EMPTY(%r15)
+	alg	%r0,__LC_STEAL_TIMER
+	stg	%r0,__LC_STEAL_TIMER
+	mvc	__LC_LAST_UPDATE_CLOCK(8),__SF_EMPTY(%r15)
+
 	/* Activate DAT */
 	stosm	__SF_EMPTY(%r15),0x04
 
@@ -159,8 +172,7 @@ pgm_check_entry:
 	larl	%r1,.Lresume_cpu		/* Resume CPU address: r2 */
 	stap	0(%r1)
 	llgh	%r2,0(%r1)
-	lghi	%r3,0x1000
-	llgh	%r1,__LC_CPU_ADDRESS(%r3)	/* Suspend CPU address: r1 */
+	llgh	%r1,__LC_CPU_ADDRESS(%r0)	/* Suspend CPU address: r1 */
 	cgr	%r1,%r2
 	je	restore_registers		/* r1 = r2 -> nothing to do */
 	larl	%r4,.Lrestart_suspend_psw	/* Set new restart PSW */
@@ -200,8 +212,11 @@ restart_suspend:
 
 restore_registers:
 	/* Restore registers */
-	lghi	%r13,0x1000		/* %r1 = pointer to save arae */
+	lghi	%r13,0x1000		/* %r1 = pointer to save area */
 
+	/* Ignore time spent in suspended state. */
+	llgf	%r1,0x318(%r13)
+	stck	__LC_LAST_UPDATE_CLOCK(%r1)
 	spt	0x328(%r13)		/* reprogram timer */
 	//sckc	0x330(%r13)		/* set clock comparator */
 
@@ -229,9 +244,6 @@ restore_registers:
 	/* Load old stack */
 	lg	%r15,0x2f8(%r13)
 
-	/* Pointer to save area */
-	lghi	%r13,0x1000
-
 	/* Restore prefix register */
 	spx	0x318(%r13)
 
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 45a3e9a..adfb32a 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -247,6 +247,13 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	}
 
 	/*
+	 * Put vDSO base into mm struct. We need to do this before calling
+	 * install_special_mapping or the perf counter mmap tracking code
+	 * will fail to recognise it as a vDSO (since arch_vma_name fails).
+	 */
+	current->mm->context.vdso_base = vdso_base;
+
+	/*
 	 * our vma flags don't have VM_WRITE so by default, the process
 	 * isn't allowed to write those pages.
 	 * gdb can break that with ptrace interface, and thus trigger COW
@@ -267,14 +274,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 				     VM_ALWAYSDUMP,
 				     vdso_pagelist);
 	if (rc)
-		goto out_up;
-
-	/* Put vDSO base into mm struct */
-	current->mm->context.vdso_base = vdso_base;
-
-	up_write(&mm->mmap_sem);
-	return 0;
-
+		current->mm->context.vdso_base = 0;
 out_up:
 	up_write(&mm->mmap_sem);
 	return rc;
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index bc15ef9..a68ac10 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -51,6 +51,7 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	_eshared = .;		/* End of shareable data */
+	_sdata = .;		/* Start of data section */
 
 	EXCEPTION_TABLE(16) :data
 
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 97c1eca..752b362 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -25,13 +25,13 @@ void __delay(unsigned long loops)
 	asm volatile("0: brct %0,0b" : : "d" ((loops/2) + 1));
 }
 
-static void __udelay_disabled(unsigned long usecs)
+static void __udelay_disabled(unsigned long long usecs)
 {
 	unsigned long mask, cr0, cr0_saved;
 	u64 clock_saved;
 
 	clock_saved = local_tick_disable();
-	set_clock_comparator(get_clock() + ((u64) usecs << 12));
+	set_clock_comparator(get_clock() + (usecs << 12));
 	__ctl_store(cr0_saved, 0, 0);
 	cr0 = (cr0_saved & 0xffff00e0) | 0x00000800;
 	__ctl_load(cr0 , 0, 0);
@@ -46,20 +46,25 @@ static void __udelay_disabled(unsigned long usecs)
 	set_clock_comparator(S390_lowcore.clock_comparator);
 }
 
-static void __udelay_enabled(unsigned long usecs)
+static void __udelay_enabled(unsigned long long usecs)
 {
 	unsigned long mask;
-	u64 end, time;
+	u64 clock_saved;
+	u64 end;
 
 	mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT | PSW_MASK_IO;
-	end = get_clock() + ((u64) usecs << 12);
+	end = get_clock() + (usecs << 12);
 	do {
-		time = end < S390_lowcore.clock_comparator ?
-			end : S390_lowcore.clock_comparator;
-		set_clock_comparator(time);
+		clock_saved = 0;
+		if (end < S390_lowcore.clock_comparator) {
+			clock_saved = local_tick_disable();
+			set_clock_comparator(end);
+		}
 		trace_hardirqs_on();
 		__load_psw_mask(mask);
 		local_irq_disable();
+		if (clock_saved)
+			local_tick_enable(clock_saved);
 	} while (get_clock() < end);
 	set_clock_comparator(S390_lowcore.clock_comparator);
 }
@@ -67,7 +72,7 @@ static void __udelay_enabled(unsigned long usecs)
 /*
  * Waits for 'usecs' microseconds using the TOD clock comparator.
  */
-void __udelay(unsigned long usecs)
+void __udelay(unsigned long long usecs)
 {
 	unsigned long flags;
 
@@ -101,11 +106,11 @@ EXPORT_SYMBOL(__udelay);
  * Simple udelay variant. To be used on startup and reboot
  * when the interrupt handler isn't working.
  */
-void udelay_simple(unsigned long usecs)
+void udelay_simple(unsigned long long usecs)
 {
 	u64 end;
 
-	end = get_clock() + ((u64) usecs << 12);
+	end = get_clock() + (usecs << 12);
 	while (get_clock() < end)
 		cpu_relax();
 }
diff --git a/arch/s390/lib/uaccess_mvcos.c b/arch/s390/lib/uaccess_mvcos.c
index 3f15aaf..58da3f4 100644
--- a/arch/s390/lib/uaccess_mvcos.c
+++ b/arch/s390/lib/uaccess_mvcos.c
@@ -36,7 +36,7 @@ static size_t copy_from_user_mvcos(size_t size, const void __user *ptr, void *x)
 	tmp1 = -4096UL;
 	asm volatile(
 		"0: .insn ss,0xc80000000000,0(%0,%2),0(%1),0\n"
-		"   jz    7f\n"
+		"9: jz    7f\n"
 		"1:"ALR"  %0,%3\n"
 		"  "SLR"  %1,%3\n"
 		"  "SLR"  %2,%3\n"
@@ -47,7 +47,7 @@ static size_t copy_from_user_mvcos(size_t size, const void __user *ptr, void *x)
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   4f\n"
 		"3: .insn ss,0xc80000000000,0(%4,%2),0(%1),0\n"
-		"  "SLR"  %0,%4\n"
+		"10:"SLR"  %0,%4\n"
 		"  "ALR"  %2,%4\n"
 		"4:"LHI"  %4,-1\n"
 		"  "ALR"  %4,%0\n"	/* copy remaining size, subtract 1 */
@@ -61,7 +61,7 @@ static size_t copy_from_user_mvcos(size_t size, const void __user *ptr, void *x)
 		"   j     8f\n"
 		"7:"SLR"  %0,%0\n"
 		"8: \n"
-		EX_TABLE(0b,2b) EX_TABLE(3b,4b)
+		EX_TABLE(0b,2b) EX_TABLE(3b,4b) EX_TABLE(9b,2b) EX_TABLE(10b,4b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: "d" (reg0) : "cc", "memory");
 	return size;
@@ -82,7 +82,7 @@ static size_t copy_to_user_mvcos(size_t size, void __user *ptr, const void *x)
 	tmp1 = -4096UL;
 	asm volatile(
 		"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
-		"   jz    4f\n"
+		"6: jz    4f\n"
 		"1:"ALR"  %0,%3\n"
 		"  "SLR"  %1,%3\n"
 		"  "SLR"  %2,%3\n"
@@ -93,11 +93,11 @@ static size_t copy_to_user_mvcos(size_t size, void __user *ptr, const void *x)
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   5f\n"
 		"3: .insn ss,0xc80000000000,0(%4,%1),0(%2),0\n"
-		"  "SLR"  %0,%4\n"
+		"7:"SLR"  %0,%4\n"
 		"   j     5f\n"
 		"4:"SLR"  %0,%0\n"
 		"5: \n"
-		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
+		EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: "d" (reg0) : "cc", "memory");
 	return size;
diff --git a/arch/s390/lib/uaccess_std.c b/arch/s390/lib/uaccess_std.c
index d2ffbad..07deaee 100644
--- a/arch/s390/lib/uaccess_std.c
+++ b/arch/s390/lib/uaccess_std.c
@@ -36,12 +36,12 @@ size_t copy_from_user_std(size_t size, const void __user *ptr, void *x)
 	tmp1 = -256UL;
 	asm volatile(
 		"0: mvcp  0(%0,%2),0(%1),%3\n"
-		"   jz    8f\n"
+		"10:jz    8f\n"
 		"1:"ALR"  %0,%3\n"
 		"   la    %1,256(%1)\n"
 		"   la    %2,256(%2)\n"
 		"2: mvcp  0(%0,%2),0(%1),%3\n"
-		"   jnz   1b\n"
+		"11:jnz   1b\n"
 		"   j     8f\n"
 		"3: la    %4,255(%1)\n"	/* %4 = ptr + 255 */
 		"  "LHI"  %3,-4096\n"
@@ -50,7 +50,7 @@ size_t copy_from_user_std(size_t size, const void __user *ptr, void *x)
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   5f\n"
 		"4: mvcp  0(%4,%2),0(%1),%3\n"
-		"  "SLR"  %0,%4\n"
+		"12:"SLR"  %0,%4\n"
 		"  "ALR"  %2,%4\n"
 		"5:"LHI"  %4,-1\n"
 		"  "ALR"  %4,%0\n"	/* copy remaining size, subtract 1 */
@@ -65,6 +65,7 @@ size_t copy_from_user_std(size_t size, const void __user *ptr, void *x)
 		"8:"SLR"  %0,%0\n"
 		"9: \n"
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,5b)
+		EX_TABLE(10b,3b) EX_TABLE(11b,3b) EX_TABLE(12b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
 	return size;
@@ -85,12 +86,12 @@ size_t copy_to_user_std(size_t size, void __user *ptr, const void *x)
 	tmp1 = -256UL;
 	asm volatile(
 		"0: mvcs  0(%0,%1),0(%2),%3\n"
-		"   jz    5f\n"
+		"7: jz    5f\n"
 		"1:"ALR"  %0,%3\n"
 		"   la    %1,256(%1)\n"
 		"   la    %2,256(%2)\n"
 		"2: mvcs  0(%0,%1),0(%2),%3\n"
-		"   jnz   1b\n"
+		"8: jnz   1b\n"
 		"   j     5f\n"
 		"3: la    %4,255(%1)\n" /* %4 = ptr + 255 */
 		"  "LHI"  %3,-4096\n"
@@ -99,11 +100,12 @@ size_t copy_to_user_std(size_t size, void __user *ptr, const void *x)
 		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
 		"   jnh   6f\n"
 		"4: mvcs  0(%4,%1),0(%2),%3\n"
-		"  "SLR"  %0,%4\n"
+		"9:"SLR"  %0,%4\n"
 		"   j     6f\n"
 		"5:"SLR"  %0,%0\n"
 		"6: \n"
 		EX_TABLE(0b,3b) EX_TABLE(2b,3b) EX_TABLE(4b,6b)
+		EX_TABLE(7b,3b) EX_TABLE(8b,3b) EX_TABLE(9b,6b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
 		: : "cc", "memory");
 	return size;
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index c60bfb3..2757c56 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -279,7 +279,10 @@ int s390_enable_sie(void)
 	/* lets check if we are allowed to replace the mm */
 	task_lock(tsk);
 	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
-	    tsk->mm != tsk->active_mm || !hlist_empty(&tsk->mm->ioctx_list)) {
+#ifdef CONFIG_AIO
+	    !hlist_empty(&tsk->mm->ioctx_list) ||
+#endif
+	    tsk->mm != tsk->active_mm) {
 		task_unlock(tsk);
 		return -EINVAL;
 	}
@@ -295,7 +298,10 @@ int s390_enable_sie(void)
 	/* Now lets check again if something happened */
 	task_lock(tsk);
 	if (!tsk->mm || atomic_read(&tsk->mm->mm_users) > 1 ||
-	    tsk->mm != tsk->active_mm || !hlist_empty(&tsk->mm->ioctx_list)) {
+#ifdef CONFIG_AIO
+	    !hlist_empty(&tsk->mm->ioctx_list) ||
+#endif
+	    tsk->mm != tsk->active_mm) {
 		mmput(mm);
 		task_unlock(tsk);
 		return -EINVAL;
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index dad0449..53b8c25 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2508,8 +2508,6 @@ int dasd_generic_restore_device(struct ccw_device *cdev)
 	device->stopped &= ~DASD_UNRESUMED_PM;
 
 	dasd_schedule_device_bh(device);
-	if (device->block)
-		dasd_schedule_block_bh(device->block);
 
 	if (device->discipline->restore)
 		rc = device->discipline->restore(device);
@@ -2520,6 +2518,9 @@ int dasd_generic_restore_device(struct ccw_device *cdev)
 		 */
 		device->stopped |= DASD_UNRESUMED_PM;
 
+	if (device->block)
+		dasd_schedule_block_bh(device->block);
+
 	dasd_put_device(device);
 	return 0;
 }
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ab35217..0be7c15 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2338,6 +2338,8 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 	/* Calculate number of blocks/records per track. */
 	blksize = block->bp_block;
 	blk_per_trk = recs_per_track(&private->rdc_data, 0, blksize);
+	if (blk_per_trk == 0)
+		return ERR_PTR(-EINVAL);
 	/* Calculate record id of first and last block. */
 	first_rec = first_trk = blk_rq_pos(req) >> block->s2b_shift;
 	first_offs = sector_div(first_trk, blk_per_trk);
@@ -3211,6 +3213,7 @@ int dasd_eckd_pm_freeze(struct dasd_device *device)
 int dasd_eckd_restore_device(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private;
+	struct dasd_eckd_characteristics temp_rdc_data;
 	int is_known, rc;
 	struct dasd_uid temp_uid;
 
@@ -3245,15 +3248,17 @@ int dasd_eckd_restore_device(struct dasd_device *device)
 	dasd_eckd_read_features(device);
 
 	/* Read Device Characteristics */
-	memset(&private->rdc_data, 0, sizeof(private->rdc_data));
 	rc = dasd_generic_read_dev_chars(device, DASD_ECKD_MAGIC,
-					 &private->rdc_data, 64);
+					 &temp_rdc_data, 64);
 	if (rc) {
 		DBF_EVENT(DBF_WARNING,
 			  "Read device characteristics failed, rc=%d for "
 			  "device: %s", rc, dev_name(&device->cdev->dev));
 		goto out_err;
 	}
+	spin_lock(get_ccwdev_lock(device->cdev));
+	memcpy(&private->rdc_data, &temp_rdc_data, sizeof(temp_rdc_data));
+	spin_unlock(get_ccwdev_lock(device->cdev));
 
 	/* add device to alias management */
 	dasd_alias_add_device(device);
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index d6a022f..62ddf52 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -1361,11 +1361,13 @@ static int raw3270_pm_start(struct ccw_device *cdev)
 
 void raw3270_pm_unfreeze(struct raw3270_view *view)
 {
+#ifdef CONFIG_TN3270_CONSOLE
 	struct raw3270 *rp;
 
 	rp = view->dev;
 	if (rp && test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
 		ccw_device_force_console();
+#endif
 }
 
 static struct ccw_device_id raw3270_id[] = {
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index 6565f02..7eab9ab 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -265,13 +265,11 @@ struct ccwdev_iter {
 static void *
 cio_ignore_proc_seq_start(struct seq_file *s, loff_t *offset)
 {
-	struct ccwdev_iter *iter;
+	struct ccwdev_iter *iter = s->private;
 
 	if (*offset >= (__MAX_SUBCHANNEL + 1) * (__MAX_SSID + 1))
 		return NULL;
-	iter = kzalloc(sizeof(struct ccwdev_iter), GFP_KERNEL);
-	if (!iter)
-		return ERR_PTR(-ENOMEM);
+	memset(iter, 0, sizeof(*iter));
 	iter->ssid = *offset / (__MAX_SUBCHANNEL + 1);
 	iter->devno = *offset % (__MAX_SUBCHANNEL + 1);
 	return iter;
@@ -280,8 +278,6 @@ cio_ignore_proc_seq_start(struct seq_file *s, loff_t *offset)
 static void
 cio_ignore_proc_seq_stop(struct seq_file *s, void *it)
 {
-	if (!IS_ERR(it))
-		kfree(it);
 }
 
 static void *
@@ -378,14 +374,15 @@ static const struct seq_operations cio_ignore_proc_seq_ops = {
 static int
 cio_ignore_proc_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &cio_ignore_proc_seq_ops);
+	return seq_open_private(file, &cio_ignore_proc_seq_ops,
+				sizeof(struct ccwdev_iter));
 }
 
 static const struct file_operations cio_ignore_proc_fops = {
 	.open    = cio_ignore_proc_open,
 	.read    = seq_read,
 	.llseek  = seq_lseek,
-	.release = seq_release,
+	.release = seq_release_private,
 	.write   = cio_ignore_write,
 };
 
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 4000283..8ab5160 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -393,7 +393,6 @@ int chp_new(struct chp_id chpid)
 	chp->state = 1;
 	chp->dev.parent = &channel_subsystems[chpid.cssid]->device;
 	chp->dev.release = chp_release;
-	dev_set_name(&chp->dev, "chp%x.%02x", chpid.cssid, chpid.id);
 
 	/* Obtain channel path description and fill it in. */
 	ret = chsc_determine_base_channel_path_desc(chpid, &chp->desc);
@@ -411,6 +410,7 @@ int chp_new(struct chp_id chpid)
 	} else {
 		chp->cmg = -1;
 	}
+	dev_set_name(&chp->dev, "chp%x.%02x", chpid.cssid, chpid.id);
 
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index f780bdd..2ee093e 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1609,7 +1609,7 @@ int ccw_purge_blacklisted(void)
 	return 0;
 }
 
-static void device_set_disconnected(struct ccw_device *cdev)
+void ccw_device_set_disconnected(struct ccw_device *cdev)
 {
 	if (!cdev)
 		return;
@@ -1705,7 +1705,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int slow)
 		ccw_device_trigger_reprobe(cdev);
 		break;
 	case DISC:
-		device_set_disconnected(cdev);
+		ccw_device_set_disconnected(cdev);
 		break;
 	default:
 		break;
diff --git a/drivers/s390/cio/device.h b/drivers/s390/cio/device.h
index ed39a2c..246c648 100644
--- a/drivers/s390/cio/device.h
+++ b/drivers/s390/cio/device.h
@@ -125,6 +125,7 @@ int ccw_device_stlck(struct ccw_device *);
 void ccw_device_trigger_reprobe(struct ccw_device *);
 void ccw_device_kill_io(struct ccw_device *);
 int ccw_device_notify(struct ccw_device *, int);
+void ccw_device_set_disconnected(struct ccw_device *cdev);
 void ccw_device_set_notoper(struct ccw_device *cdev);
 
 /* qdio needs this. */
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index e728ce4..b9613d7 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -387,19 +387,35 @@ ccw_device_done(struct ccw_device *cdev, int state)
 
 	cdev->private->state = state;
 
-	if (state == DEV_STATE_BOXED) {
+	switch (state) {
+	case DEV_STATE_BOXED:
 		CIO_MSG_EVENT(0, "Boxed device %04x on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
 		if (cdev->online && !ccw_device_notify(cdev, CIO_BOXED))
 			ccw_device_schedule_sch_unregister(cdev);
 		cdev->private->flags.donotify = 0;
-	}
-	if (state == DEV_STATE_NOT_OPER) {
+		break;
+	case DEV_STATE_NOT_OPER:
 		CIO_MSG_EVENT(0, "Device %04x gone on subchannel %04x\n",
 			      cdev->private->dev_id.devno, sch->schid.sch_no);
 		if (!ccw_device_notify(cdev, CIO_GONE))
 			ccw_device_schedule_sch_unregister(cdev);
+		else
+			ccw_device_set_disconnected(cdev);
 		cdev->private->flags.donotify = 0;
+		break;
+	case DEV_STATE_DISCONNECTED:
+		CIO_MSG_EVENT(0, "Disconnected device %04x on subchannel "
+			      "%04x\n", cdev->private->dev_id.devno,
+			      sch->schid.sch_no);
+		if (!ccw_device_notify(cdev, CIO_NO_PATH))
+			ccw_device_schedule_sch_unregister(cdev);
+		else
+			ccw_device_set_disconnected(cdev);
+		cdev->private->flags.donotify = 0;
+		break;
+	default:
+		break;
 	}
 
 	if (cdev->private->flags.donotify) {
@@ -671,6 +687,10 @@ ccw_device_offline(struct ccw_device *cdev)
 		ccw_device_done(cdev, DEV_STATE_NOT_OPER);
 		return 0;
 	}
+	if (cdev->private->state == DEV_STATE_BOXED) {
+		ccw_device_done(cdev, DEV_STATE_BOXED);
+		return 0;
+	}
 	if (ccw_device_is_orphan(cdev)) {
 		ccw_device_done(cdev, DEV_STATE_OFFLINE);
 		return 0;
@@ -730,11 +750,10 @@ ccw_device_recog_notoper(struct ccw_device *cdev, enum dev_event dev_event)
 static void ccw_device_generic_notoper(struct ccw_device *cdev,
 				       enum dev_event dev_event)
 {
-	struct subchannel *sch;
-
-	ccw_device_set_notoper(cdev);
-	sch = to_subchannel(cdev->dev.parent);
-	css_schedule_eval(sch->schid);
+	if (!ccw_device_notify(cdev, CIO_GONE))
+		ccw_device_schedule_sch_unregister(cdev);
+	else
+		ccw_device_set_disconnected(cdev);
 }
 
 /*
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.c b/drivers/s390/crypto/zcrypt_pcixcc.c
index c20d479..5677b40 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.c
+++ b/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -361,7 +361,7 @@ static void rng_type6CPRB_msgX(struct ap_device *ap_dev,
 		.ToCardLen1	= sizeof *msg - sizeof(msg->hdr),
 		.FromCardLen1	= sizeof *msg - sizeof(msg->hdr),
 	};
-	static struct CPRBX static_cprbx = {
+	static struct CPRBX local_cprbx = {
 		.cprb_len	= 0x00dc,
 		.cprb_ver_id	= 0x02,
 		.func_id	= {0x54, 0x32},
@@ -372,7 +372,7 @@ static void rng_type6CPRB_msgX(struct ap_device *ap_dev,
 
 	msg->hdr = static_type6_hdrX;
 	msg->hdr.FromCardLen2 = random_number_length,
-	msg->cprbx = static_cprbx;
+	msg->cprbx = local_cprbx;
 	msg->cprbx.rpl_datal = random_number_length,
 	msg->cprbx.domain = AP_QID_QUEUE(ap_dev->qid);
 	memcpy(msg->function_code, msg->hdr.function_code, 0x02);
@@ -561,7 +561,8 @@ static int convert_response_ica(struct zcrypt_device *zdev,
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_ica(zdev, reply,
 						  outputdata, outputdatalength);
-		/* no break, incorrect cprb version is an unknown response */
+		/* Fall through, no break, incorrect cprb version is an unknown
+		 * response */
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
@@ -587,7 +588,8 @@ static int convert_response_xcrb(struct zcrypt_device *zdev,
 		}
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_xcrb(zdev, reply, xcRB);
-		/* no break, incorrect cprb version is an unknown response */
+		/* Fall through, no break, incorrect cprb version is an unknown
+		 * response */
 	default: /* Unknown response type, this should NEVER EVER happen */
 		xcRB->status = 0x0008044DL; /* HDD_InvalidParm */
 		zdev->online = 0;
@@ -610,7 +612,8 @@ static int convert_response_rng(struct zcrypt_device *zdev,
 			return -EINVAL;
 		if (msg->cprbx.cprb_ver_id == 0x02)
 			return convert_type86_rng(zdev, reply, data);
-		/* no break, incorrect cprb version is an unknown response */
+		/* Fall through, no break, incorrect cprb version is an unknown
+		 * response */
 	default: /* Unknown response type, this should NEVER EVER happen */
 		zdev->online = 0;
 		return -EAGAIN;	/* repeat the request on a different device. */
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 45a937b..90a4ed0 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -361,6 +361,7 @@ typedef struct elf64_shdr {
 #define NT_PPC_VSX	0x102		/* PowerPC VSX registers */
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
+#define NT_PRXSTATUS	0x300		/* s390 upper register halves */
 
 
 /* Note header in a PT_NOTE section */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8911558..30df586 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -346,8 +346,9 @@ config SLUB_STATS
 
 config DEBUG_KMEMLEAK
 	bool "Kernel memory leak detector"
-	depends on DEBUG_KERNEL && EXPERIMENTAL && (X86 || ARM || PPC) && \
-		!MEMORY_HOTPLUG
+	depends on DEBUG_KERNEL && EXPERIMENTAL && !MEMORY_HOTPLUG && \
+		(X86 || ARM || PPC || S390)
+
 	select DEBUG_FS if SYSFS
 	select STACKTRACE if STACKTRACE_SUPPORT
 	select KALLSYMS
@@ -370,7 +371,7 @@ config DEBUG_KMEMLEAK
 config DEBUG_KMEMLEAK_EARLY_LOG_SIZE
 	int "Maximum kmemleak early log entries"
 	depends on DEBUG_KMEMLEAK
-	range 200 2000
+	range 200 40000
 	default 400
 	help
 	  Kmemleak must track all the memory allocations to avoid
