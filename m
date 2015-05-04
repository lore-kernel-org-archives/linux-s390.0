Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [RFC kgr on klp 4/9] livepatch: add kgr infrastructure
Date: Mon,  4 May 2015 13:40:20 +0200
Message-Id: <1430739625-4658-4-git-send-email-jslaby@suse.cz>
In-Reply-To: <1430739625-4658-1-git-send-email-jslaby@suse.cz>
References: <1430739625-4658-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: live-patching@vger.kernel.org
Cc: jpoimboe@redhat.com, sjenning@redhat.com, jkosina@suse.cz, vojtech@suse.cz, mingo@redhat.com, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Miroslav Benes <mbenes@suse.cz>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

This means:
* add a per-thread flag to indicate whether a task is in the old or in
  the new universe,
* reset it in _slow_ paths of syscall's entry/exit,
* add helpers around the flag to sched.h,
* export the status in /proc/<pid>/kgr_in_progress,

This was cherry-picked from the kGraft implementation and will serve
as a base for kGraft-like patching in Live Patching.

Miroslav helped to clean the assembly up and move to C.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/s390/include/asm/thread_info.h |  2 ++
 arch/s390/kernel/Makefile           |  1 +
 arch/s390/kernel/entry.S            | 11 +++++++++++
 arch/s390/kernel/livepatch.c        | 14 ++++++++++++++
 arch/x86/include/asm/thread_info.h  | 11 +++++++----
 arch/x86/kernel/ptrace.c            |  7 +++++++
 arch/x86/kernel/signal.c            |  5 +++++
 fs/proc/base.c                      | 14 ++++++++++++++
 include/linux/sched.h               | 23 +++++++++++++++++++++++
 9 files changed, 84 insertions(+), 4 deletions(-)
 create mode 100644 arch/s390/kernel/livepatch.c

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 4c27ec764c36..88a559531a7b 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -82,6 +82,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define TIF_SINGLE_STEP		19	/* This task is single stepped */
 #define TIF_BLOCK_STEP		20	/* This task is block stepped */
 #define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
+#define TIF_KGR_IN_PROGRESS	22	/* This task has not finished patching */
 
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
@@ -93,6 +94,7 @@ void arch_release_task_struct(struct task_struct *tsk);
 #define _TIF_UPROBE		(1<<TIF_UPROBE)
 #define _TIF_31BIT		(1<<TIF_31BIT)
 #define _TIF_SINGLE_STEP	(1<<TIF_SINGLE_STEP)
+#define _TIF_KGR_IN_PROGRESS	(1<<TIF_KGR_IN_PROGRESS)
 
 #define is_32bit_task()		(test_thread_flag(TIF_31BIT))
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index ffb87617a36c..ff3ecac94ebe 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_AUDIT)		+= audit.o
 compat-obj-$(CONFIG_AUDIT)	+= compat_audit.o
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_wrapper.o $(compat-obj-y)
+obj-$(CONFIG_LIVEPATCH)		+= livepatch.o
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 99b44acbfcc7..f4be8e142a50 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -73,6 +73,15 @@ _PIF_WORK	= (_PIF_PER_TRAP)
 #endif
 	.endm
 
+	.macro	HANDLE_KGRAFT TI_reg
+#if IS_ENABLED(CONFIG_LIVEPATCH)
+	tm	__TI_flags+5(\TI_reg),(_TIF_KGR_IN_PROGRESS >> 16)
+	jz	0f
+	brasl	%r14,s390_handle_kgraft
+0:
+#endif
+	.endm
+
 	.macro LPP newpp
 #if IS_ENABLED(CONFIG_KVM)
 	tm	__LC_MACHINE_FLAGS+6,0x20	# MACHINE_FLAG_LPP
@@ -217,6 +226,7 @@ ENTRY(system_call)
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
 .Lsysc_do_svc:
+	HANDLE_KGRAFT %r12
 	lg	%r10,__TI_sysc_table(%r12)	# address of system call table
 	llgh	%r8,__PT_INT_CODE+2(%r11)
 	slag	%r8,%r8,2			# shift and test for svc 0
@@ -248,6 +258,7 @@ ENTRY(system_call)
 	jnz	.Lsysc_work			# check for work
 	tm	__LC_CPU_FLAGS+7,_CIF_WORK
 	jnz	.Lsysc_work
+	HANDLE_KGRAFT %r12
 .Lsysc_restore:
 	lg	%r14,__LC_VDSO_PER_CPU
 	lmg	%r0,%r10,__PT_R0(%r11)
diff --git a/arch/s390/kernel/livepatch.c b/arch/s390/kernel/livepatch.c
new file mode 100644
index 000000000000..99ace9df5576
--- /dev/null
+++ b/arch/s390/kernel/livepatch.c
@@ -0,0 +1,14 @@
+/*
+ * livepatch.c - s390-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2014-2015 SUSE
+ *
+ * This file is licensed under the GPLv2.
+ */
+
+#include <linux/sched.h>
+
+asmlinkage void s390_handle_kgraft(void)
+{
+	klp_kgraft_mark_task_safe(current);
+}
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index b4bdec3e9523..3dad428caa6b 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -106,6 +106,7 @@ struct thread_info {
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_KGR_IN_PROGRESS	26	/* kGraft patching running */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
 #define TIF_SYSCALL_TRACEPOINT	28	/* syscall tracepoint instrumentation */
 #define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
@@ -129,6 +130,7 @@ struct thread_info {
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
+#define _TIF_KGR_IN_PROGRESS	(1 << TIF_KGR_IN_PROGRESS)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_ADDR32		(1 << TIF_ADDR32)
@@ -138,7 +140,7 @@ struct thread_info {
 #define _TIF_WORK_SYSCALL_ENTRY	\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_EMU | _TIF_SYSCALL_AUDIT |	\
 	 _TIF_SECCOMP | _TIF_SINGLESTEP | _TIF_SYSCALL_TRACEPOINT |	\
-	 _TIF_NOHZ)
+	 _TIF_NOHZ | _TIF_KGR_IN_PROGRESS)
 
 /* work to do in syscall_trace_leave() */
 #define _TIF_WORK_SYSCALL_EXIT	\
@@ -149,17 +151,18 @@ struct thread_info {
 #define _TIF_WORK_MASK							\
 	(0x0000FFFF &							\
 	 ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|			\
-	   _TIF_SINGLESTEP|_TIF_SECCOMP|_TIF_SYSCALL_EMU))
+	   _TIF_SINGLESTEP|_TIF_SECCOMP|_TIF_SYSCALL_EMU) |		\
+	   _TIF_KGR_IN_PROGRESS)
 
 /* work to do on any return to user space */
 #define _TIF_ALLWORK_MASK						\
 	((0x0000FFFF & ~_TIF_SECCOMP) | _TIF_SYSCALL_TRACEPOINT |	\
-	_TIF_NOHZ)
+	_TIF_NOHZ | _TIF_KGR_IN_PROGRESS)
 
 /* Only used for 64 bit */
 #define _TIF_DO_NOTIFY_MASK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME |				\
-	 _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE)
+	 _TIF_USER_RETURN_NOTIFY | _TIF_UPROBE | _TIF_KGR_IN_PROGRESS)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index a7bc79480719..454f4734b840 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1527,6 +1527,13 @@ unsigned long syscall_trace_enter_phase1(struct pt_regs *regs, u32 arch)
 	}
 #endif
 
+#if IS_ENABLED(CONFIG_LIVEPATCH)
+	if (work & _TIF_KGR_IN_PROGRESS) {
+		klp_kgraft_mark_task_safe(current);
+		work &= ~_TIF_KGR_IN_PROGRESS;
+	}
+#endif
+
 	/* Do our best to finish without phase 2. */
 	if (work == 0)
 		return ret;  /* seccomp and/or nohz only (ret == 0 here) */
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1ea14fd53933..d5e38e2161ac 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -730,6 +730,11 @@ do_notify_resume(struct pt_regs *regs, void *unused, __u32 thread_info_flags)
 	if (thread_info_flags & _TIF_UPROBE)
 		uprobe_notify_resume(regs);
 
+#if IS_ENABLED(CONFIG_LIVEPATCH)
+	if (thread_info_flags & _TIF_KGR_IN_PROGRESS)
+		klp_kgraft_mark_task_safe(current);
+#endif
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 093ca14f5701..4973ae795abd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2052,6 +2052,17 @@ static const struct file_operations proc_timers_operations = {
 };
 #endif /* CONFIG_CHECKPOINT_RESTORE */
 
+#if IS_ENABLED(CONFIG_LIVEPATCH)
+static int proc_pid_kgr_in_progress(struct seq_file *m,
+		struct pid_namespace *ns, struct pid *pid,
+		struct task_struct *task)
+{
+	seq_printf(m, "%d\n", klp_kgraft_task_in_progress(task));
+
+	return 0;
+}
+#endif /* IS_ENABLED(CONFIG_LIVEPATCH) */
+
 static int proc_pident_instantiate(struct inode *dir,
 	struct dentry *dentry, struct task_struct *task, const void *ptr)
 {
@@ -2640,6 +2651,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	REG("timers",	  S_IRUGO, proc_timers_operations),
 #endif
+#if IS_ENABLED(CONFIG_LIVEPATCH)
+	ONE("kgr_in_progress",	S_IRUSR, proc_pid_kgr_in_progress),
+#endif
 };
 
 static int proc_tgid_base_readdir(struct file *file, struct dir_context *ctx)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8222ae40ecb0..4c0555261cb1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -3085,6 +3085,29 @@ static inline void mm_update_next_owner(struct mm_struct *mm)
 }
 #endif /* CONFIG_MEMCG */
 
+#if IS_ENABLED(CONFIG_LIVEPATCH)
+static inline void klp_kgraft_mark_task_safe(struct task_struct *p)
+{
+	clear_tsk_thread_flag(p, TIF_KGR_IN_PROGRESS);
+}
+static inline void klp_kgraft_mark_task_in_progress(struct task_struct *p)
+{
+	set_tsk_thread_flag(p, TIF_KGR_IN_PROGRESS);
+}
+
+static inline bool klp_kgraft_task_in_progress(struct task_struct *p)
+{
+	return test_tsk_thread_flag(p, TIF_KGR_IN_PROGRESS);
+}
+#else
+static inline void klp_kgraft_mark_task_safe(struct task_struct *p) { }
+static inline void klp_kgraft_mark_task_in_progress(struct task_struct *p) { }
+static inline bool klp_kgraft_task_in_progress(struct task_struct *p)
+{
+	return false;
+}
+#endif /* IS_ENABLED(CONFIG_LIVEPATCH) */
+
 static inline unsigned long task_rlimit(const struct task_struct *tsk,
 		unsigned int limit)
 {
-- 
2.3.5
