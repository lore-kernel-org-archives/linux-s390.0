Return-Path: <linux-kernel-owner+w=401wt.eu-S933307AbZFLJNh@vger.kernel.org>
Date: Fri, 12 Jun 2009 11:12:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.31
Message-ID: <20090612111259.465c6584@skybase>
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
      [S390] dcssblk: revert devt conversion

Heiko Carstens (15):
      [S390] implement interrupt-enabling rwlocks
      [S390] add mini sclp driver
      [S390] implement is_compat_task
      [S390] secure computing arch backend
      [S390] uaccess: use might_fault() instead of might_sleep()
      [S390] vmalloc: add vmalloc kernel parameter support
      [S390] maccess: add weak attribute to probe_kernel_write
      [S390] maccess: arch specific probe_kernel_write() implementation
      [S390] kprobes: use probe_kernel_write
      [S390] ftrace: add dynamic ftrace support
      [S390] ftrace: add function trace mcount test support
      [S390] ftrace: add function graph tracer support
      [S390] ftrace: add system call tracer support
      [S390] wire up sys_rt_tgsigqueueinfo
      [S390] wire up sys_perf_counter_open

Jan Glauber (2):
      [S390] qdio: simplify error handling in irq handler
      [S390] qdio: inline qdio_perf_stat_inc

Martin Schwidefsky (6):
      [S390] vdso: kernel parameter syntax
      [S390] merge cpu.h into cputime.h
      [S390] use facility list for cpu type safety check
      [S390] 3270: do not register with tty_register_device
      [S390] 3270: lock dependency fixes
      [S390] profile_tick called twice

Roel Kluin (1):
      [S390] qdio: fix access beyond ARRAY_SIZE of irq_ptr->{in,out}put_qs

Sebastian Ott (3):
      [S390] cio: fix sanity checks in device_ops.
      [S390] dasd: check_characteristics cleanup
      [S390] dasd: sync after async probe

Stefan Weinhuber (2):
      [S390] dasd: no High Performance FICON in 31-bit mode
      [S390] dasd: forward internal errors to dasd_sleep_on caller

 arch/s390/Kconfig                   |   23 +++
 arch/s390/include/asm/compat.h      |   19 ++-
 arch/s390/include/asm/cpu.h         |   32 ----
 arch/s390/include/asm/cputime.h     |   19 ++
 arch/s390/include/asm/ftrace.h      |   21 +++
 arch/s390/include/asm/lowcore.h     |    9 +-
 arch/s390/include/asm/pgtable.h     |    7 +-
 arch/s390/include/asm/seccomp.h     |   16 ++
 arch/s390/include/asm/spinlock.h    |   19 ++-
 arch/s390/include/asm/syscall.h     |    1 +
 arch/s390/include/asm/thread_info.h |   12 +-
 arch/s390/include/asm/uaccess.h     |   16 +-
 arch/s390/include/asm/unistd.h      |    4 +-
 arch/s390/kernel/Makefile           |    7 +-
 arch/s390/kernel/compat_wrapper.S   |   17 ++
 arch/s390/kernel/early.c            |    4 +
 arch/s390/kernel/entry.S            |    7 +-
 arch/s390/kernel/entry64.S          |    7 +-
 arch/s390/kernel/ftrace.c           |  260 ++++++++++++++++++++++++++++
 arch/s390/kernel/head.S             |   65 +++++--
 arch/s390/kernel/kprobes.c          |   33 +----
 arch/s390/kernel/mcount.S           |  212 ++++++++++++++++++++---
 arch/s390/kernel/nmi.c              |    2 +-
 arch/s390/kernel/process.c          |    3 +-
 arch/s390/kernel/ptrace.c           |   23 ++-
 arch/s390/kernel/s390_ext.c         |    5 +-
 arch/s390/kernel/sclp.S             |  327 +++++++++++++++++++++++++++++++++++
 arch/s390/kernel/setup.c            |    2 +
 arch/s390/kernel/signal.c           |    3 +-
 arch/s390/kernel/smp.c              |    3 +-
 arch/s390/kernel/syscalls.S         |    2 +
 arch/s390/kernel/time.c             |    9 +-
 arch/s390/kernel/vdso.c             |   19 ++-
 arch/s390/kernel/vmlinux.lds.S      |    1 +
 arch/s390/kernel/vtime.c            |    2 +-
 arch/s390/kvm/kvm-s390.c            |    2 +-
 arch/s390/lib/spinlock.c            |   40 +++++
 arch/s390/mm/Makefile               |    2 +-
 arch/s390/mm/fault.c                |    3 +-
 arch/s390/mm/maccess.c              |   61 +++++++
 arch/s390/mm/mmap.c                 |   11 +-
 arch/s390/mm/pgtable.c              |   16 ++-
 drivers/s390/block/dasd.c           |   34 +++-
 drivers/s390/block/dasd_diag.c      |    1 +
 drivers/s390/block/dasd_eckd.c      |   44 +++--
 drivers/s390/block/dasd_fba.c       |   22 ++-
 drivers/s390/block/dasd_int.h       |    3 +-
 drivers/s390/block/dcssblk.c        |    4 +-
 drivers/s390/char/con3270.c         |   38 ++---
 drivers/s390/char/tty3270.c         |   57 ++----
 drivers/s390/cio/cio.c              |    6 +-
 drivers/s390/cio/device_ops.c       |   24 +--
 drivers/s390/cio/qdio_main.c        |   46 ++----
 drivers/s390/cio/qdio_perf.c        |   12 --
 drivers/s390/cio/qdio_perf.h        |   10 +-
 mm/maccess.c                        |    2 +-
 scripts/recordmcount.pl             |   13 ++
 57 files changed, 1323 insertions(+), 339 deletions(-)
 delete mode 100644 arch/s390/include/asm/cpu.h
 create mode 100644 arch/s390/include/asm/seccomp.h
 create mode 100644 arch/s390/kernel/ftrace.c
 create mode 100644 arch/s390/kernel/sclp.S
 create mode 100644 arch/s390/mm/maccess.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2eca5fe..99dc3de 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -82,6 +82,11 @@ config S390
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_SYSCALL_WRAPPERS
 	select HAVE_FUNCTION_TRACER
+	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
+	select HAVE_FTRACE_MCOUNT_RECORD
+	select HAVE_FTRACE_SYSCALLS
+	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_DEFAULT_NO_SPIN_MUTEXES
 	select HAVE_OPROFILE
 	select HAVE_KPROBES
@@ -567,6 +572,24 @@ bool "s390 guest support for KVM (EXPERIMENTAL)"
 	  the KVM hypervisor. This will add detection for KVM as well  as a
 	  virtio transport. If KVM is detected, the virtio console will be
 	  the default console.
+
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	depends on PROC_FS
+	default y
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via /proc/<pid>/seccomp, it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y.
+
 endmenu
 
 source "net/Kconfig"
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index de065b3..01a0802 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -5,6 +5,7 @@
  */
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/thread_info.h>
 
 #define PSW32_MASK_PER		0x40000000UL
 #define PSW32_MASK_DAT		0x04000000UL
@@ -163,12 +164,28 @@ static inline compat_uptr_t ptr_to_compat(void __user *uptr)
 	return (u32)(unsigned long)uptr;
 }
 
+#ifdef CONFIG_COMPAT
+
+static inline int is_compat_task(void)
+{
+	return test_thread_flag(TIF_31BIT);
+}
+
+#else
+
+static inline int is_compat_task(void)
+{
+	return 0;
+}
+
+#endif
+
 static inline void __user *compat_alloc_user_space(long len)
 {
 	unsigned long stack;
 
 	stack = KSTK_ESP(current);
-	if (test_thread_flag(TIF_31BIT))
+	if (is_compat_task())
 		stack &= 0x7fffffffUL;
 	return (void __user *) (stack - len);
 }
diff --git a/arch/s390/include/asm/cpu.h b/arch/s390/include/asm/cpu.h
deleted file mode 100644
index d60a2ee..0000000
--- a/arch/s390/include/asm/cpu.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  include/asm-s390/cpu.h
- *
- *    Copyright IBM Corp. 2007
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
- */
-
-#ifndef _ASM_S390_CPU_H_
-#define _ASM_S390_CPU_H_
-
-#include <linux/types.h>
-#include <linux/percpu.h>
-#include <linux/spinlock.h>
-
-struct s390_idle_data {
-	spinlock_t lock;
-	unsigned long long idle_count;
-	unsigned long long idle_enter;
-	unsigned long long idle_time;
-};
-
-DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
-
-void vtime_start_cpu(void);
-
-static inline void s390_idle_check(void)
-{
-	if ((&__get_cpu_var(s390_idle))->idle_enter != 0ULL)
-		vtime_start_cpu();
-}
-
-#endif /* _ASM_S390_CPU_H_ */
diff --git a/arch/s390/include/asm/cputime.h b/arch/s390/include/asm/cputime.h
index 941384f..ec917d4 100644
--- a/arch/s390/include/asm/cputime.h
+++ b/arch/s390/include/asm/cputime.h
@@ -9,6 +9,9 @@
 #ifndef _S390_CPUTIME_H
 #define _S390_CPUTIME_H
 
+#include <linux/types.h>
+#include <linux/percpu.h>
+#include <linux/spinlock.h>
 #include <asm/div64.h>
 
 /* We want to use full resolution of the CPU timer: 2**-12 micro-seconds. */
@@ -174,8 +177,24 @@ cputime64_to_clock_t(cputime64_t cputime)
        return __div(cputime, 4096000000ULL / USER_HZ);
 }
 
+struct s390_idle_data {
+	spinlock_t lock;
+	unsigned long long idle_count;
+	unsigned long long idle_enter;
+	unsigned long long idle_time;
+};
+
+DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
+
+void vtime_start_cpu(void);
 cputime64_t s390_get_idle_time(int cpu);
 
 #define arch_idle_time(cpu) s390_get_idle_time(cpu)
 
+static inline void s390_idle_check(void)
+{
+	if ((&__get_cpu_var(s390_idle))->idle_enter != 0ULL)
+		vtime_start_cpu();
+}
+
 #endif /* _S390_CPUTIME_H */
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 5a5bc75..96c14a9 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -2,7 +2,28 @@
 #define _ASM_S390_FTRACE_H
 
 #ifndef __ASSEMBLY__
+
 extern void _mcount(void);
+extern unsigned long ftrace_dyn_func;
+
+struct dyn_arch_ftrace { };
+
+#define MCOUNT_ADDR ((long)_mcount)
+
+#ifdef CONFIG_64BIT
+#define MCOUNT_OFFSET_RET 18
+#define MCOUNT_INSN_SIZE  24
+#define MCOUNT_OFFSET	  14
+#else
+#define MCOUNT_OFFSET_RET 26
+#define MCOUNT_INSN_SIZE  30
+#define MCOUNT_OFFSET	   8
 #endif
 
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr - MCOUNT_OFFSET;
+}
+
+#endif /* __ASSEMBLY__ */
 #endif /* _ASM_S390_FTRACE_H */
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 3aeca49..5046ad6 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -30,6 +30,7 @@
 #define __LC_SUBCHANNEL_NR		0x00ba
 #define __LC_IO_INT_PARM		0x00bc
 #define __LC_IO_INT_WORD		0x00c0
+#define __LC_STFL_FAC_LIST		0x00c8
 #define __LC_MCCK_CODE			0x00e8
 
 #define __LC_DUMP_REIPL			0x0e00
@@ -67,6 +68,7 @@
 #define __LC_CPUID			0x02b0
 #define __LC_INT_CLOCK			0x02c8
 #define __LC_MACHINE_FLAGS		0x02d8
+#define __LC_FTRACE_FUNC		0x02dc
 #define __LC_IRB			0x0300
 #define __LC_PFAULT_INTPARM		0x0080
 #define __LC_CPU_TIMER_SAVE_AREA	0x00d8
@@ -112,6 +114,7 @@
 #define __LC_INT_CLOCK			0x0340
 #define __LC_VDSO_PER_CPU		0x0350
 #define __LC_MACHINE_FLAGS		0x0358
+#define __LC_FTRACE_FUNC		0x0360
 #define __LC_IRB			0x0380
 #define __LC_PASTE			0x03c0
 #define __LC_PFAULT_INTPARM		0x11b8
@@ -280,7 +283,8 @@ struct _lowcore
 	__u64	int_clock;			/* 0x02c8 */
 	__u64	clock_comparator;		/* 0x02d0 */
 	__u32	machine_flags;			/* 0x02d8 */
-	__u8	pad_0x02dc[0x0300-0x02dc];	/* 0x02dc */
+	__u32	ftrace_func;			/* 0x02dc */
+	__u8	pad_0x02f0[0x0300-0x02f0];	/* 0x02f0 */
 
 	/* Interrupt response block */
 	__u8	irb[64];			/* 0x0300 */
@@ -385,7 +389,8 @@ struct _lowcore
 	__u64	clock_comparator;		/* 0x0348 */
 	__u64	vdso_per_cpu_data;		/* 0x0350 */
 	__u64	machine_flags;			/* 0x0358 */
-	__u8	pad_0x0360[0x0380-0x0360];	/* 0x0360 */
+	__u64	ftrace_func;			/* 0x0360 */
+	__u8	pad_0x0368[0x0380-0x0368];	/* 0x0368 */
 
 	/* Interrupt response block. */
 	__u8	irb[64];			/* 0x0380 */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 5caddd4..60a7b1a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -112,12 +112,15 @@ extern char empty_zero_page[PAGE_SIZE];
  * effect, this also makes sure that 64 bit module code cannot be used
  * as system call address.
  */
+
+extern unsigned long VMALLOC_START;
+
 #ifndef __s390x__
-#define VMALLOC_START	0x78000000UL
+#define VMALLOC_SIZE	(96UL << 20)
 #define VMALLOC_END	0x7e000000UL
 #define VMEM_MAP_END	0x80000000UL
 #else /* __s390x__ */
-#define VMALLOC_START	0x3e000000000UL
+#define VMALLOC_SIZE	(1UL << 30)
 #define VMALLOC_END	0x3e040000000UL
 #define VMEM_MAP_END	0x40000000000UL
 #endif /* __s390x__ */
diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
new file mode 100644
index 0000000..781a9cf
--- /dev/null
+++ b/arch/s390/include/asm/seccomp.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_S390_SECCOMP_H
+#define _ASM_S390_SECCOMP_H
+
+#include <linux/unistd.h>
+
+#define __NR_seccomp_read	__NR_read
+#define __NR_seccomp_write	__NR_write
+#define __NR_seccomp_exit	__NR_exit
+#define __NR_seccomp_sigreturn	__NR_sigreturn
+
+#define __NR_seccomp_read_32	__NR_read
+#define __NR_seccomp_write_32	__NR_write
+#define __NR_seccomp_exit_32	__NR_exit
+#define __NR_seccomp_sigreturn_32 __NR_sigreturn
+
+#endif	/* _ASM_S390_SECCOMP_H */
diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index f3861b0..c9af0d1 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -122,8 +122,10 @@ static inline void __raw_spin_unlock(raw_spinlock_t *lp)
 #define __raw_write_can_lock(x) ((x)->lock == 0)
 
 extern void _raw_read_lock_wait(raw_rwlock_t *lp);
+extern void _raw_read_lock_wait_flags(raw_rwlock_t *lp, unsigned long flags);
 extern int _raw_read_trylock_retry(raw_rwlock_t *lp);
 extern void _raw_write_lock_wait(raw_rwlock_t *lp);
+extern void _raw_write_lock_wait_flags(raw_rwlock_t *lp, unsigned long flags);
 extern int _raw_write_trylock_retry(raw_rwlock_t *lp);
 
 static inline void __raw_read_lock(raw_rwlock_t *rw)
@@ -134,6 +136,14 @@ static inline void __raw_read_lock(raw_rwlock_t *rw)
 		_raw_read_lock_wait(rw);
 }
 
+static inline void __raw_read_lock_flags(raw_rwlock_t *rw, unsigned long flags)
+{
+	unsigned int old;
+	old = rw->lock & 0x7fffffffU;
+	if (_raw_compare_and_swap(&rw->lock, old, old + 1) != old)
+		_raw_read_lock_wait_flags(rw, flags);
+}
+
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
 	unsigned int old, cmp;
@@ -151,6 +161,12 @@ static inline void __raw_write_lock(raw_rwlock_t *rw)
 		_raw_write_lock_wait(rw);
 }
 
+static inline void __raw_write_lock_flags(raw_rwlock_t *rw, unsigned long flags)
+{
+	if (unlikely(_raw_compare_and_swap(&rw->lock, 0, 0x80000000) != 0))
+		_raw_write_lock_wait_flags(rw, flags);
+}
+
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
 	_raw_compare_and_swap(&rw->lock, 0x80000000, 0);
@@ -172,9 +188,6 @@ static inline int __raw_write_trylock(raw_rwlock_t *rw)
 	return _raw_write_trylock_retry(rw);
 }
 
-#define __raw_read_lock_flags(lock, flags) __raw_read_lock(lock)
-#define __raw_write_lock_flags(lock, flags) __raw_write_lock(lock)
-
 #define _raw_read_relax(lock)	cpu_relax()
 #define _raw_write_relax(lock)	cpu_relax()
 
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 2429b87..e0a73d3 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -12,6 +12,7 @@
 #ifndef _ASM_SYSCALL_H
 #define _ASM_SYSCALL_H	1
 
+#include <linux/sched.h>
 #include <asm/ptrace.h>
 
 static inline long syscall_get_nr(struct task_struct *task,
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 461f2ab..925bcc6 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -83,14 +83,16 @@ static inline struct thread_info *current_thread_info(void)
 /*
  * thread information flags bit numbers
  */
-#define TIF_SYSCALL_TRACE	0	/* syscall trace active */
 #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTART_SVC		4	/* restart svc with new svc number */
-#define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
 #define TIF_SINGLE_STEP		6	/* deliver sigtrap on return to user */
 #define TIF_MCCK_PENDING	7	/* machine check handling is pending */
+#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
+#define TIF_SYSCALL_AUDIT	9	/* syscall auditing active */
+#define TIF_SECCOMP		10	/* secure computing */
+#define TIF_SYSCALL_FTRACE	11	/* ftrace syscall instrumentation */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
@@ -99,15 +101,17 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
 #define TIF_FREEZE		21	/* thread is freezing for suspend */
 
-#define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_RESTART_SVC	(1<<TIF_RESTART_SVC)
-#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLE_STEP	(1<<TIF_SINGLE_STEP)
 #define _TIF_MCCK_PENDING	(1<<TIF_MCCK_PENDING)
+#define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_SYSCALL_FTRACE	(1<<TIF_SYSCALL_FTRACE)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_31BIT		(1<<TIF_31BIT)
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 0235970..8377e91 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -131,7 +131,7 @@ static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
 
 #define put_user(x, ptr)					\
 ({								\
-	might_sleep();						\
+	might_fault();						\
 	__put_user(x, ptr);					\
 })
 
@@ -180,7 +180,7 @@ extern int __put_user_bad(void) __attribute__((noreturn));
 
 #define get_user(x, ptr)					\
 ({								\
-	might_sleep();						\
+	might_fault();						\
 	__get_user(x, ptr);					\
 })
 
@@ -231,7 +231,7 @@ __copy_to_user(void __user *to, const void *from, unsigned long n)
 static inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __copy_to_user(to, from, n);
 	return n;
@@ -282,7 +282,7 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static inline unsigned long __must_check
 copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (access_ok(VERIFY_READ, from, n))
 		n = __copy_from_user(to, from, n);
 	else
@@ -299,7 +299,7 @@ __copy_in_user(void __user *to, const void __user *from, unsigned long n)
 static inline unsigned long __must_check
 copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (__access_ok(from,n) && __access_ok(to,n))
 		n = __copy_in_user(to, from, n);
 	return n;
@@ -312,7 +312,7 @@ static inline long __must_check
 strncpy_from_user(char *dst, const char __user *src, long count)
 {
         long res = -EFAULT;
-        might_sleep();
+	might_fault();
         if (access_ok(VERIFY_READ, src, 1))
 		res = uaccess.strncpy_from_user(count, src, dst);
         return res;
@@ -321,7 +321,7 @@ strncpy_from_user(char *dst, const char __user *src, long count)
 static inline unsigned long
 strnlen_user(const char __user * src, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	return uaccess.strnlen_user(n, src);
 }
 
@@ -354,7 +354,7 @@ __clear_user(void __user *to, unsigned long n)
 static inline unsigned long __must_check
 clear_user(void __user *to, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = uaccess.clear_user(n, to);
 	return n;
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index f0f19e6..c80602d 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -267,7 +267,9 @@
 #define __NR_epoll_create1	327
 #define	__NR_preadv		328
 #define	__NR_pwritev		329
-#define NR_syscalls 330
+#define __NR_rt_tgsigqueueinfo	330
+#define __NR_perf_counter_open	331
+#define NR_syscalls 332
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 228e310..c75ed43 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -3,8 +3,9 @@
 #
 
 ifdef CONFIG_FUNCTION_TRACER
-# Do not trace early boot code
+# Don't trace early setup code and tracing code
 CFLAGS_REMOVE_early.o = -pg
+CFLAGS_REMOVE_ftrace.o = -pg
 endif
 
 #
@@ -22,7 +23,7 @@ CFLAGS_sysinfo.o += -Iinclude/math-emu -Iarch/s390/math-emu -w
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o setup.o \
 	    processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o mem_detect.o \
-	    vdso.o vtime.o sysinfo.o nmi.o
+	    vdso.o vtime.o sysinfo.o nmi.o sclp.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
@@ -41,6 +42,8 @@ obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
+obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
+obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 
 # Kexec part
 S390_KEXEC_OBJS := machine_kexec.o crash.o
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index fb38af6..88a8336 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1823,3 +1823,20 @@ compat_sys_pwritev_wrapper:
 	llgfr	%r5,%r5			# u32
 	llgfr	%r6,%r6			# u32
 	jg	compat_sys_pwritev	# branch to system call
+
+	.globl	compat_sys_rt_tgsigqueueinfo_wrapper
+compat_sys_rt_tgsigqueueinfo_wrapper:
+	lgfr	%r2,%r2			# compat_pid_t
+	lgfr	%r3,%r3			# compat_pid_t
+	lgfr	%r4,%r4			# int
+	llgtr	%r5,%r5			# struct compat_siginfo *
+	jg	compat_sys_rt_tgsigqueueinfo_wrapper # branch to system call
+
+	.globl	sys_perf_counter_open_wrapper
+sys_perf_counter_open_wrapper:
+	llgtr	%r2,%r2			# const struct perf_counter_attr *
+	lgfr	%r3,%r3			# pid_t
+	lgfr	%r4,%r4			# int
+	lgfr	%r5,%r5			# int
+	llgfr	%r6,%r6			# unsigned long
+	jg	sys_perf_counter_open	# branch to system call
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index cf09948..fb26373 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -11,6 +11,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/ctype.h>
+#include <linux/ftrace.h>
 #include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/pfn.h>
@@ -410,5 +411,8 @@ void __init startup_init(void)
 	sclp_facilities_detect();
 	detect_memory_layout(memory_chunk);
 	S390_lowcore.machine_flags = machine_flags;
+#ifdef CONFIG_DYNAMIC_FTRACE
+	S390_lowcore.ftrace_func = (unsigned long)ftrace_caller;
+#endif
 	lockdep_on();
 }
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index f3e2759..c4c80a2 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -53,6 +53,8 @@ _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 		 _TIF_MCCK_PENDING | _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 		 _TIF_MCCK_PENDING)
+_TIF_SYSCALL = (_TIF_SYSCALL_TRACE>>8 | _TIF_SYSCALL_AUDIT>>8 | \
+		_TIF_SECCOMP>>8 | _TIF_SYSCALL_FTRACE>>8)
 
 STACK_SHIFT = PAGE_SHIFT + THREAD_ORDER
 STACK_SIZE  = 1 << STACK_SHIFT
@@ -265,7 +267,7 @@ sysc_do_restart:
 	sth	%r7,SP_SVCNR(%r15)
 	sll	%r7,2		  # svc number *4
 	l	%r8,BASED(.Lsysc_table)
-	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
+	tm	__TI_flags+2(%r9),_TIF_SYSCALL
 	l	%r8,0(%r7,%r8)	  # get system call addr.
 	bnz	BASED(sysc_tracesys)
 	basr	%r14,%r8	  # call sys_xxxx
@@ -405,7 +407,7 @@ sysc_tracego:
 	basr	%r14,%r8		# call sys_xxx
 	st	%r2,SP_R2(%r15)		# store return value
 sysc_tracenogo:
-	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
+	tm	__TI_flags+2(%r9),_TIF_SYSCALL
 	bz	BASED(sysc_return)
 	l	%r1,BASED(.Ltrace_exit)
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
@@ -1107,6 +1109,7 @@ cleanup_io_leave_insn:
 
 		.section .rodata, "a"
 #define SYSCALL(esa,esame,emu)	.long esa
+	.globl	sys_call_table
 sys_call_table:
 #include "syscalls.S"
 #undef SYSCALL
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 84a1058..f6618e9 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -56,6 +56,8 @@ _TIF_WORK_SVC = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 		 _TIF_MCCK_PENDING | _TIF_RESTART_SVC | _TIF_SINGLE_STEP )
 _TIF_WORK_INT = (_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_NEED_RESCHED | \
 		 _TIF_MCCK_PENDING)
+_TIF_SYSCALL = (_TIF_SYSCALL_TRACE>>8 | _TIF_SYSCALL_AUDIT>>8 | \
+		_TIF_SECCOMP>>8 | _TIF_SYSCALL_FTRACE>>8)
 
 #define BASED(name) name-system_call(%r13)
 
@@ -260,7 +262,7 @@ sysc_do_restart:
 	larl	%r10,sys_call_table_emu  # use 31 bit emulation system calls
 sysc_noemu:
 #endif
-	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
+	tm	__TI_flags+6(%r9),_TIF_SYSCALL
 	lgf	%r8,0(%r7,%r10) # load address of system call routine
 	jnz	sysc_tracesys
 	basr	%r14,%r8	# call sys_xxxx
@@ -391,7 +393,7 @@ sysc_tracego:
 	basr	%r14,%r8		# call sys_xxx
 	stg	%r2,SP_R2(%r15)		# store return value
 sysc_tracenogo:
-	tm	__TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
+	tm	__TI_flags+6(%r9),_TIF_SYSCALL
 	jz	sysc_return
 	la	%r2,SP_PTREGS(%r15)	# load pt_regs
 	larl	%r14,sysc_return	# return point is sysc_return
@@ -1058,6 +1060,7 @@ cleanup_io_leave_insn:
 
 		.section .rodata, "a"
 #define SYSCALL(esa,esame,emu)	.long esame
+	.globl	sys_call_table
 sys_call_table:
 #include "syscalls.S"
 #undef SYSCALL
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
new file mode 100644
index 0000000..82ddfd3
--- /dev/null
+++ b/arch/s390/kernel/ftrace.c
@@ -0,0 +1,260 @@
+/*
+ * Dynamic function tracer architecture backend.
+ *
+ * Copyright IBM Corp. 2009
+ *
+ *   Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *
+ */
+
+#include <linux/hardirq.h>
+#include <linux/uaccess.h>
+#include <linux/ftrace.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <trace/syscall.h>
+#include <asm/lowcore.h>
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+void ftrace_disable_code(void);
+void ftrace_disable_return(void);
+void ftrace_call_code(void);
+void ftrace_nop_code(void);
+
+#define FTRACE_INSN_SIZE 4
+
+#ifdef CONFIG_64BIT
+
+asm(
+	"	.align	4\n"
+	"ftrace_disable_code:\n"
+	"	j	0f\n"
+	"	.word	0x0024\n"
+	"	lg	%r1,"__stringify(__LC_FTRACE_FUNC)"\n"
+	"	basr	%r14,%r1\n"
+	"ftrace_disable_return:\n"
+	"	lg	%r14,8(15)\n"
+	"	lgr	%r0,%r0\n"
+	"0:\n");
+
+asm(
+	"	.align	4\n"
+	"ftrace_nop_code:\n"
+	"	j	.+"__stringify(MCOUNT_INSN_SIZE)"\n");
+
+asm(
+	"	.align	4\n"
+	"ftrace_call_code:\n"
+	"	stg	%r14,8(%r15)\n");
+
+#else /* CONFIG_64BIT */
+
+asm(
+	"	.align	4\n"
+	"ftrace_disable_code:\n"
+	"	j	0f\n"
+	"	l	%r1,"__stringify(__LC_FTRACE_FUNC)"\n"
+	"	basr	%r14,%r1\n"
+	"ftrace_disable_return:\n"
+	"	l	%r14,4(%r15)\n"
+	"	j	0f\n"
+	"	bcr	0,%r7\n"
+	"	bcr	0,%r7\n"
+	"	bcr	0,%r7\n"
+	"	bcr	0,%r7\n"
+	"	bcr	0,%r7\n"
+	"	bcr	0,%r7\n"
+	"0:\n");
+
+asm(
+	"	.align	4\n"
+	"ftrace_nop_code:\n"
+	"	j	.+"__stringify(MCOUNT_INSN_SIZE)"\n");
+
+asm(
+	"	.align	4\n"
+	"ftrace_call_code:\n"
+	"	st	%r14,4(%r15)\n");
+
+#endif /* CONFIG_64BIT */
+
+static int ftrace_modify_code(unsigned long ip,
+			      void *old_code, int old_size,
+			      void *new_code, int new_size)
+{
+	unsigned char replaced[MCOUNT_INSN_SIZE];
+
+	/*
+	 * Note: Due to modules code can disappear and change.
+	 *  We need to protect against faulting as well as code
+	 *  changing. We do this by using the probe_kernel_*
+	 *  functions.
+	 *  This however is just a simple sanity check.
+	 */
+	if (probe_kernel_read(replaced, (void *)ip, old_size))
+		return -EFAULT;
+	if (memcmp(replaced, old_code, old_size) != 0)
+		return -EINVAL;
+	if (probe_kernel_write((void *)ip, new_code, new_size))
+		return -EPERM;
+	return 0;
+}
+
+static int ftrace_make_initial_nop(struct module *mod, struct dyn_ftrace *rec,
+				   unsigned long addr)
+{
+	return ftrace_modify_code(rec->ip,
+				  ftrace_call_code, FTRACE_INSN_SIZE,
+				  ftrace_disable_code, MCOUNT_INSN_SIZE);
+}
+
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	if (addr == MCOUNT_ADDR)
+		return ftrace_make_initial_nop(mod, rec, addr);
+	return ftrace_modify_code(rec->ip,
+				  ftrace_call_code, FTRACE_INSN_SIZE,
+				  ftrace_nop_code, FTRACE_INSN_SIZE);
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	return ftrace_modify_code(rec->ip,
+				  ftrace_nop_code, FTRACE_INSN_SIZE,
+				  ftrace_call_code, FTRACE_INSN_SIZE);
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	ftrace_dyn_func = (unsigned long)func;
+	return 0;
+}
+
+int __init ftrace_dyn_arch_init(void *data)
+{
+	*(unsigned long *)data = 0;
+	return 0;
+}
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifdef CONFIG_DYNAMIC_FTRACE
+/*
+ * Patch the kernel code at ftrace_graph_caller location:
+ * The instruction there is branch relative on condition. The condition mask
+ * is either all ones (always branch aka disable ftrace_graph_caller) or all
+ * zeroes (nop aka enable ftrace_graph_caller).
+ * Instruction format for brc is a7m4xxxx where m is the condition mask.
+ */
+int ftrace_enable_ftrace_graph_caller(void)
+{
+	unsigned short opcode = 0xa704;
+
+	return probe_kernel_write(ftrace_graph_caller, &opcode, sizeof(opcode));
+}
+
+int ftrace_disable_ftrace_graph_caller(void)
+{
+	unsigned short opcode = 0xa7f4;
+
+	return probe_kernel_write(ftrace_graph_caller, &opcode, sizeof(opcode));
+}
+
+static inline unsigned long ftrace_mcount_call_adjust(unsigned long addr)
+{
+	return addr - (ftrace_disable_return - ftrace_disable_code);
+}
+
+#else /* CONFIG_DYNAMIC_FTRACE */
+
+static inline unsigned long ftrace_mcount_call_adjust(unsigned long addr)
+{
+	return addr - MCOUNT_OFFSET_RET;
+}
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+/*
+ * Hook the return address and push it in the stack of return addresses
+ * in current thread info.
+ */
+unsigned long prepare_ftrace_return(unsigned long ip, unsigned long parent)
+{
+	struct ftrace_graph_ent trace;
+
+	/* Nmi's are currently unsupported. */
+	if (unlikely(in_nmi()))
+		goto out;
+	if (unlikely(atomic_read(&current->tracing_graph_pause)))
+		goto out;
+	if (ftrace_push_return_trace(parent, ip, &trace.depth) == -EBUSY)
+		goto out;
+	trace.func = ftrace_mcount_call_adjust(ip) & PSW_ADDR_INSN;
+	/* Only trace if the calling function expects to. */
+	if (!ftrace_graph_entry(&trace)) {
+		current->curr_ret_stack--;
+		goto out;
+	}
+	parent = (unsigned long)return_to_handler;
+out:
+	return parent;
+}
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#ifdef CONFIG_FTRACE_SYSCALLS
+
+extern unsigned long __start_syscalls_metadata[];
+extern unsigned long __stop_syscalls_metadata[];
+extern unsigned int sys_call_table[];
+
+static struct syscall_metadata **syscalls_metadata;
+
+struct syscall_metadata *syscall_nr_to_meta(int nr)
+{
+	if (!syscalls_metadata || nr >= NR_syscalls || nr < 0)
+		return NULL;
+
+	return syscalls_metadata[nr];
+}
+
+static struct syscall_metadata *find_syscall_meta(unsigned long syscall)
+{
+	struct syscall_metadata *start;
+	struct syscall_metadata *stop;
+	char str[KSYM_SYMBOL_LEN];
+
+	start = (struct syscall_metadata *)__start_syscalls_metadata;
+	stop = (struct syscall_metadata *)__stop_syscalls_metadata;
+	kallsyms_lookup(syscall, NULL, NULL, NULL, str);
+
+	for ( ; start < stop; start++) {
+		if (start->name && !strcmp(start->name + 3, str + 3))
+			return start;
+	}
+	return NULL;
+}
+
+void arch_init_ftrace_syscalls(void)
+{
+	struct syscall_metadata *meta;
+	int i;
+	static atomic_t refs;
+
+	if (atomic_inc_return(&refs) != 1)
+		goto out;
+	syscalls_metadata = kzalloc(sizeof(*syscalls_metadata) * NR_syscalls,
+				    GFP_KERNEL);
+	if (!syscalls_metadata)
+		goto out;
+	for (i = 0; i < NR_syscalls; i++) {
+		meta = find_syscall_meta((unsigned long)sys_call_table[i]);
+		syscalls_metadata[i] = meta;
+	}
+	return;
+out:
+	atomic_dec(&refs);
+}
+#endif
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
index 22596d7..6d22741 100644
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -1,7 +1,5 @@
 /*
- *  arch/s390/kernel/head.S
- *
- * Copyright (C) IBM Corp. 1999,2006
+ * Copyright IBM Corp. 1999,2009
  *
  *    Author(s): Hartmut Penner <hp@de.ibm.com>
  *		 Martin Schwidefsky <schwidefsky@de.ibm.com>
@@ -479,27 +477,58 @@ startup:basr	%r13,0			# get base
 	mvc	__LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
 	mvc	__LC_EXIT_TIMER(8),5f-.LPG0(%r13)
 #ifndef CONFIG_MARCH_G5
-	# check processor version against MARCH_{G5,Z900,Z990,Z9_109,Z10}
-	stidp	__LC_CPUID		# store cpuid
-	lhi	%r0,(3f-2f) / 2
-	la	%r1,2f-.LPG0(%r13)
-0:	clc	__LC_CPUID+4(2),0(%r1)
-	jne	3f
-	lpsw	1f-.LPG0(13)		# machine type not good enough, crash
+	# check capabilities against MARCH_{G5,Z900,Z990,Z9_109,Z10}
+	xc	__LC_STFL_FAC_LIST(8),__LC_STFL_FAC_LIST
+	stfl	__LC_STFL_FAC_LIST	# store facility list
+	tm	__LC_STFL_FAC_LIST,0x01	# stfle available ?
+	jz	0f
+	la	%r0,0
+	.insn	s,0xb2b00000,__LC_STFL_FAC_LIST	# store facility list extended
+0:	l	%r0,__LC_STFL_FAC_LIST
+	n	%r0,2f+8-.LPG0(%r13)
+	cl	%r0,2f+8-.LPG0(%r13)
+	jne	1f
+	l	%r0,__LC_STFL_FAC_LIST+4
+	n	%r0,2f+12-.LPG0(%r13)
+	cl	%r0,2f+12-.LPG0(%r13)
+	je	3f
+1:	l	%r15,.Lstack-.LPG0(%r13)
+	ahi	%r15,1<<(PAGE_SHIFT+THREAD_ORDER) # init_task_union+THREAD_SIZE
+	ahi	%r15,-96
+	la	%r2,.Lals_string-.LPG0(%r13)
+	l	%r3,.Lsclp_print-.LPG0(%r13)
+	basr	%r14,%r3
+	lpsw	2f-.LPG0(%r13)		# machine type not good enough, crash
+.Lals_string:
+	.asciz	"The Linux kernel requires more recent processor hardware"
+.Lsclp_print:
+	.long	_sclp_print_early
+.Lstack:
+	.long	init_thread_union
 	.align 16
-1:	.long	0x000a0000,0x00000000
-2:
+2:	.long	0x000a0000,0x8badcccc
+#if defined(CONFIG_64BIT)
 #if defined(CONFIG_MARCH_Z10)
-	.short 0x9672, 0x2064, 0x2066, 0x2084, 0x2086, 0x2094, 0x2096
+	.long 0xc100efe3, 0xf0680000
 #elif defined(CONFIG_MARCH_Z9_109)
-	.short 0x9672, 0x2064, 0x2066, 0x2084, 0x2086
+	.long 0xc100efc3, 0x00000000
 #elif defined(CONFIG_MARCH_Z990)
-	.short 0x9672, 0x2064, 0x2066
+	.long 0xc0002000, 0x00000000
 #elif defined(CONFIG_MARCH_Z900)
-	.short 0x9672
+	.long 0xc0000000, 0x00000000
+#endif
+#else
+#if defined(CONFIG_MARCH_Z10)
+	.long 0x8100c880, 0x00000000
+#elif defined(CONFIG_MARCH_Z9_109)
+	.long 0x8100c880, 0x00000000
+#elif defined(CONFIG_MARCH_Z990)
+	.long 0x80002000, 0x00000000
+#elif defined(CONFIG_MARCH_Z900)
+	.long 0x80000000, 0x00000000
+#endif
 #endif
-3:	la	%r1,2(%r1)
-	brct	%r0,0b
+3:
 #endif
 
 	l	%r13,4f-.LPG0(%r13)
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index a01cf02..9bb2f62 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -25,9 +25,9 @@
 #include <linux/preempt.h>
 #include <linux/stop_machine.h>
 #include <linux/kdebug.h>
+#include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 #include <asm/sections.h>
-#include <asm/uaccess.h>
 #include <linux/module.h>
 
 DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
@@ -155,35 +155,8 @@ void __kprobes get_instruction_type(struct arch_specific_insn *ainsn)
 static int __kprobes swap_instruction(void *aref)
 {
 	struct ins_replace_args *args = aref;
-	u32 *addr;
-	u32 instr;
-	int err = -EFAULT;
 
-	/*
-	 * Text segment is read-only, hence we use stura to bypass dynamic
-	 * address translation to exchange the instruction. Since stura
-	 * always operates on four bytes, but we only want to exchange two
-	 * bytes do some calculations to get things right. In addition we
-	 * shall not cross any page boundaries (vmalloc area!) when writing
-	 * the new instruction.
-	 */
-	addr = (u32 *)((unsigned long)args->ptr & -4UL);
-	if ((unsigned long)args->ptr & 2)
-		instr = ((*addr) & 0xffff0000) | args->new;
-	else
-		instr = ((*addr) & 0x0000ffff) | args->new << 16;
-
-	asm volatile(
-		"	lra	%1,0(%1)\n"
-		"0:	stura	%2,%1\n"
-		"1:	la	%0,0\n"
-		"2:\n"
-		EX_TABLE(0b,2b)
-		: "+d" (err)
-		: "a" (addr), "d" (instr)
-		: "memory", "cc");
-
-	return err;
+	return probe_kernel_write(args->ptr, &args->new, sizeof(args->new));
 }
 
 void __kprobes arch_arm_kprobe(struct kprobe *p)
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 8064122..2a0a5e9 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -1,5 +1,5 @@
 /*
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008,2009
  *
  *   Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
  *
@@ -7,36 +7,64 @@
 
 #include <asm/asm-offsets.h>
 
-#ifndef CONFIG_64BIT
-.globl _mcount
+	.globl ftrace_stub
+ftrace_stub:
+	br	%r14
+
+#ifdef CONFIG_64BIT
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+	.globl _mcount
 _mcount:
-	stm	%r0,%r5,8(%r15)
-	st	%r14,56(%r15)
-	lr	%r1,%r15
-	ahi	%r15,-96
-	l	%r3,100(%r15)
-	la	%r2,0(%r14)
-	st	%r1,__SF_BACKCHAIN(%r15)
-	la	%r3,0(%r3)
-	bras	%r14,0f
-	.long	ftrace_trace_function
-0:	l	%r14,0(%r14)
-	l	%r14,0(%r14)
-	basr	%r14,%r14
-	ahi	%r15,96
-	lm	%r0,%r5,8(%r15)
-	l	%r14,56(%r15)
 	br	%r14
 
-.globl ftrace_stub
-ftrace_stub:
+	.globl ftrace_caller
+ftrace_caller:
+	larl	%r1,function_trace_stop
+	icm	%r1,0xf,0(%r1)
+	bnzr	%r14
+	stmg	%r2,%r5,32(%r15)
+	stg	%r14,112(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-160
+	stg	%r1,__SF_BACKCHAIN(%r15)
+	lgr	%r2,%r14
+	lg	%r3,168(%r15)
+	larl	%r14,ftrace_dyn_func
+	lg	%r14,0(%r14)
+	basr	%r14,%r14
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl	ftrace_graph_caller
+ftrace_graph_caller:
+	# This unconditional branch gets runtime patched. Change only if
+	# you know what you are doing. See ftrace_enable_graph_caller().
+	j	0f
+	lg	%r2,272(%r15)
+	lg	%r3,168(%r15)
+	brasl	%r14,prepare_ftrace_return
+	stg	%r2,168(%r15)
+0:
+#endif
+	aghi	%r15,160
+	lmg	%r2,%r5,32(%r15)
+	lg	%r14,112(%r15)
 	br	%r14
 
-#else /* CONFIG_64BIT */
+	.data
+	.globl	ftrace_dyn_func
+ftrace_dyn_func:
+	.quad	ftrace_stub
+	.previous
+
+#else /* CONFIG_DYNAMIC_FTRACE */
 
-.globl _mcount
+	.globl _mcount
 _mcount:
-	stmg	%r0,%r5,16(%r15)
+	larl	%r1,function_trace_stop
+	icm	%r1,0xf,0(%r1)
+	bnzr	%r14
+	stmg	%r2,%r5,32(%r15)
 	stg	%r14,112(%r15)
 	lgr	%r1,%r15
 	aghi	%r15,-160
@@ -46,13 +74,143 @@ _mcount:
 	larl	%r14,ftrace_trace_function
 	lg	%r14,0(%r14)
 	basr	%r14,%r14
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	lg	%r2,272(%r15)
+	lg	%r3,168(%r15)
+	brasl	%r14,prepare_ftrace_return
+	stg	%r2,168(%r15)
+#endif
 	aghi	%r15,160
-	lmg	%r0,%r5,16(%r15)
+	lmg	%r2,%r5,32(%r15)
 	lg	%r14,112(%r15)
 	br	%r14
 
-.globl ftrace_stub
-ftrace_stub:
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+	.globl	return_to_handler
+return_to_handler:
+	stmg	%r2,%r5,32(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-160
+	stg	%r1,__SF_BACKCHAIN(%r15)
+	brasl	%r14,ftrace_return_to_handler
+	aghi	%r15,160
+	lgr	%r14,%r2
+	lmg	%r2,%r5,32(%r15)
+	br	%r14
+
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
+#else /* CONFIG_64BIT */
+
+#ifdef CONFIG_DYNAMIC_FTRACE
+
+	.globl _mcount
+_mcount:
+	br	%r14
+
+	.globl ftrace_caller
+ftrace_caller:
+	stm	%r2,%r5,16(%r15)
+	bras	%r1,2f
+0:	.long	ftrace_trace_function
+1:	.long	function_trace_stop
+2:	l	%r2,1b-0b(%r1)
+	icm	%r2,0xf,0(%r2)
+	jnz	3f
+	st	%r14,56(%r15)
+	lr	%r0,%r15
+	ahi	%r15,-96
+	l	%r3,100(%r15)
+	la	%r2,0(%r14)
+	st	%r0,__SF_BACKCHAIN(%r15)
+	la	%r3,0(%r3)
+	l	%r14,0b-0b(%r1)
+	l	%r14,0(%r14)
+	basr	%r14,%r14
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.globl	ftrace_graph_caller
+ftrace_graph_caller:
+	# This unconditional branch gets runtime patched. Change only if
+	# you know what you are doing. See ftrace_enable_graph_caller().
+	j	1f
+	bras	%r1,0f
+	.long	prepare_ftrace_return
+0:	l	%r2,152(%r15)
+	l	%r4,0(%r1)
+	l	%r3,100(%r15)
+	basr	%r14,%r4
+	st	%r2,100(%r15)
+1:
+#endif
+	ahi	%r15,96
+	l	%r14,56(%r15)
+3:	lm	%r2,%r5,16(%r15)
 	br	%r14
 
+	.data
+	.globl	ftrace_dyn_func
+ftrace_dyn_func:
+	.long	ftrace_stub
+	.previous
+
+#else /* CONFIG_DYNAMIC_FTRACE */
+
+	.globl _mcount
+_mcount:
+	stm	%r2,%r5,16(%r15)
+	bras	%r1,2f
+0:	.long	ftrace_trace_function
+1:	.long	function_trace_stop
+2:	l	%r2,1b-0b(%r1)
+	icm	%r2,0xf,0(%r2)
+	jnz	3f
+	st	%r14,56(%r15)
+	lr	%r0,%r15
+	ahi	%r15,-96
+	l	%r3,100(%r15)
+	la	%r2,0(%r14)
+	st	%r0,__SF_BACKCHAIN(%r15)
+	la	%r3,0(%r3)
+	l	%r14,0b-0b(%r1)
+	l	%r14,0(%r14)
+	basr	%r14,%r14
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	bras	%r1,0f
+	.long	prepare_ftrace_return
+0:	l	%r2,152(%r15)
+	l	%r4,0(%r1)
+	l	%r3,100(%r15)
+	basr	%r14,%r4
+	st	%r2,100(%r15)
+#endif
+	ahi	%r15,96
+	l	%r14,56(%r15)
+3:	lm	%r2,%r5,16(%r15)
+	br	%r14
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+	.globl	return_to_handler
+return_to_handler:
+	stm	%r2,%r5,16(%r15)
+	st	%r14,56(%r15)
+	lr	%r0,%r15
+	ahi	%r15,-96
+	st	%r0,__SF_BACKCHAIN(%r15)
+	bras	%r1,0f
+	.long	ftrace_return_to_handler
+0:	l	%r2,0b-0b(%r1)
+	basr	%r14,%r2
+	lr	%r14,%r2
+	ahi	%r15,96
+	lm	%r2,%r5,16(%r15)
+	br	%r14
+
+#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
+
 #endif /* CONFIG_64BIT */
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 28cf196..015e27d 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -16,7 +16,7 @@
 #include <asm/lowcore.h>
 #include <asm/smp.h>
 #include <asm/etr.h>
-#include <asm/cpu.h>
+#include <asm/cputime.h>
 #include <asm/nmi.h>
 #include <asm/crw.h>
 
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index a3acd8e..355f7a3 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -32,6 +32,7 @@
 #include <linux/elfcore.h>
 #include <linux/kernel_stat.h>
 #include <linux/syscalls.h>
+#include <asm/compat.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -204,7 +205,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	save_fp_regs(&p->thread.fp_regs);
 	/* Set a new TLS ?  */
 	if (clone_flags & CLONE_SETTLS) {
-		if (test_thread_flag(TIF_31BIT)) {
+		if (is_compat_task()) {
 			p->thread.acrs[0] = (unsigned int) regs->gprs[6];
 		} else {
 			p->thread.acrs[0] = (unsigned int)(regs->gprs[6] >> 32);
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 75c496f..490b399 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -36,7 +36,9 @@
 #include <linux/elf.h>
 #include <linux/regset.h>
 #include <linux/tracehook.h>
-
+#include <linux/seccomp.h>
+#include <trace/syscall.h>
+#include <asm/compat.h>
 #include <asm/segment.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -69,7 +71,7 @@ FixPerRegisters(struct task_struct *task)
 	if (per_info->single_step) {
 		per_info->control_regs.bits.starting_addr = 0;
 #ifdef CONFIG_COMPAT
-		if (test_thread_flag(TIF_31BIT))
+		if (is_compat_task())
 			per_info->control_regs.bits.ending_addr = 0x7fffffffUL;
 		else
 #endif
@@ -482,8 +484,7 @@ static int peek_user_compat(struct task_struct *child,
 {
 	__u32 tmp;
 
-	if (!test_thread_flag(TIF_31BIT) ||
-	    (addr & 3) || addr > sizeof(struct user) - 3)
+	if (!is_compat_task() || (addr & 3) || addr > sizeof(struct user) - 3)
 		return -EIO;
 
 	tmp = __peek_user_compat(child, addr);
@@ -584,8 +585,7 @@ static int __poke_user_compat(struct task_struct *child,
 static int poke_user_compat(struct task_struct *child,
 			    addr_t addr, addr_t data)
 {
-	if (!test_thread_flag(TIF_31BIT) ||
-	    (addr & 3) || addr > sizeof(struct user32) - 3)
+	if (!is_compat_task() || (addr & 3) || addr > sizeof(struct user32) - 3)
 		return -EIO;
 
 	return __poke_user_compat(child, addr, data);
@@ -642,6 +642,9 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret;
 
+	/* Do the secure computing check first. */
+	secure_computing(regs->gprs[2]);
+
 	/*
 	 * The sysc_tracesys code in entry.S stored the system
 	 * call number to gprs[2].
@@ -659,8 +662,11 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		ret = -1;
 	}
 
+	if (unlikely(test_thread_flag(TIF_SYSCALL_FTRACE)))
+		ftrace_syscall_enter(regs);
+
 	if (unlikely(current->audit_context))
-		audit_syscall_entry(test_thread_flag(TIF_31BIT) ?
+		audit_syscall_entry(is_compat_task() ?
 					AUDIT_ARCH_S390 : AUDIT_ARCH_S390X,
 				    regs->gprs[2], regs->orig_gpr2,
 				    regs->gprs[3], regs->gprs[4],
@@ -674,6 +680,9 @@ asmlinkage void do_syscall_trace_exit(struct pt_regs *regs)
 		audit_syscall_exit(AUDITSC_RESULT(regs->gprs[2]),
 				   regs->gprs[2]);
 
+	if (unlikely(test_thread_flag(TIF_SYSCALL_FTRACE)))
+		ftrace_syscall_exit(regs);
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall_exit(regs, 0);
 }
diff --git a/arch/s390/kernel/s390_ext.c b/arch/s390/kernel/s390_ext.c
index a0d2d55..0de305b 100644
--- a/arch/s390/kernel/s390_ext.c
+++ b/arch/s390/kernel/s390_ext.c
@@ -10,10 +10,11 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/ftrace.h>
 #include <linux/errno.h>
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
-#include <asm/cpu.h>
+#include <asm/cputime.h>
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
 #include <asm/irq_regs.h>
@@ -112,7 +113,7 @@ int unregister_early_external_interrupt(__u16 code, ext_int_handler_t handler,
 	return 0;
 }
 
-void do_extint(struct pt_regs *regs, unsigned short code)
+void __irq_entry do_extint(struct pt_regs *regs, unsigned short code)
 {
         ext_int_info_t *p;
         int index;
diff --git a/arch/s390/kernel/sclp.S b/arch/s390/kernel/sclp.S
new file mode 100644
index 0000000..20639df
--- /dev/null
+++ b/arch/s390/kernel/sclp.S
@@ -0,0 +1,327 @@
+/*
+ * Mini SCLP driver.
+ *
+ * Copyright IBM Corp. 2004,2009
+ *
+ *   Author(s):	Peter Oberparleiter <Peter.Oberparleiter@de.ibm.com>,
+ *		Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *
+ */
+
+LC_EXT_NEW_PSW		= 0x58			# addr of ext int handler
+LC_EXT_INT_PARAM	= 0x80			# addr of ext int parameter
+LC_EXT_INT_CODE		= 0x86			# addr of ext int code
+
+#
+# Subroutine which waits synchronously until either an external interruption
+# or a timeout occurs.
+#
+# Parameters:
+#   R2	= 0 for no timeout, non-zero for timeout in (approximated) seconds
+#
+# Returns:
+#   R2	= 0 on interrupt, 2 on timeout
+#   R3	= external interruption parameter if R2=0
+#
+
+.section ".init.text","ax"
+
+_sclp_wait_int:
+	stm	%r6,%r15,24(%r15)		# save registers
+	basr	%r13,0				# get base register
+.LbaseS1:
+	ahi	%r15,-96			# create stack frame
+	la	%r8,LC_EXT_NEW_PSW		# register int handler
+	mvc	.LoldpswS1-.LbaseS1(8,%r13),0(%r8)
+	mvc	0(8,%r8),.LextpswS1-.LbaseS1(%r13)
+	lhi	%r6,0x0200			# cr mask for ext int (cr0.54)
+	ltr	%r2,%r2
+	jz	.LsetctS1
+	ahi	%r6,0x0800			# cr mask for clock int (cr0.52)
+	stck	.LtimeS1-.LbaseS1(%r13)		# initiate timeout
+	al	%r2,.LtimeS1-.LbaseS1(%r13)
+	st	%r2,.LtimeS1-.LbaseS1(%r13)
+	sckc	.LtimeS1-.LbaseS1(%r13)
+
+.LsetctS1:
+	stctl	%c0,%c0,.LctlS1-.LbaseS1(%r13)	# enable required interrupts
+	l	%r0,.LctlS1-.LbaseS1(%r13)
+	lhi	%r1,~(0x200 | 0x800)		# clear old values
+	nr	%r1,%r0
+	or	%r1,%r6				# set new value
+	st	%r1,.LctlS1-.LbaseS1(%r13)
+	lctl	%c0,%c0,.LctlS1-.LbaseS1(%r13)
+	st	%r0,.LctlS1-.LbaseS1(%r13)
+	lhi	%r2,2				# return code for timeout
+.LloopS1:
+	lpsw	.LwaitpswS1-.LbaseS1(%r13)	# wait until interrupt
+.LwaitS1:
+	lh	%r7,LC_EXT_INT_CODE
+	chi	%r7,0x1004			# timeout?
+	je	.LtimeoutS1
+	chi	%r7,0x2401			# service int?
+	jne	.LloopS1
+	sr	%r2,%r2
+	l	%r3,LC_EXT_INT_PARAM
+.LtimeoutS1:
+	lctl	%c0,%c0,.LctlS1-.LbaseS1(%r13)	# restore interrupt setting
+	# restore old handler
+	mvc	0(8,%r8),.LoldpswS1-.LbaseS1(%r13)
+	lm	%r6,%r15,120(%r15)		# restore registers
+	br	%r14				# return to caller
+
+	.align	8
+.LoldpswS1:
+	.long	0, 0				# old ext int PSW
+.LextpswS1:
+	.long	0x00080000, 0x80000000+.LwaitS1	# PSW to handle ext int
+.LwaitpswS1:
+	.long	0x010a0000, 0x00000000+.LloopS1	# PSW to wait for ext int
+.LtimeS1:
+	.quad	0				# current time
+.LctlS1:
+	.long	0				# CT0 contents
+
+#
+# Subroutine to synchronously issue a service call.
+#
+# Parameters:
+#   R2	= command word
+#   R3	= sccb address
+#
+# Returns:
+#   R2	= 0 on success, 1 on failure
+#   R3	= sccb response code if R2 = 0
+#
+
+_sclp_servc:
+	stm	%r6,%r15,24(%r15)		# save registers
+	ahi	%r15,-96			# create stack frame
+	lr	%r6,%r2				# save command word
+	lr	%r7,%r3				# save sccb address
+.LretryS2:
+	lhi	%r2,1				# error return code
+	.insn	rre,0xb2200000,%r6,%r7		# servc
+	brc	1,.LendS2			# exit if not operational
+	brc	8,.LnotbusyS2			# go on if not busy
+	sr	%r2,%r2				# wait until no longer busy
+	bras	%r14,_sclp_wait_int
+	j	.LretryS2			# retry
+.LnotbusyS2:
+	sr	%r2,%r2				# wait until result
+	bras	%r14,_sclp_wait_int
+	sr	%r2,%r2
+	lh	%r3,6(%r7)
+.LendS2:
+	lm	%r6,%r15,120(%r15)		# restore registers
+	br	%r14
+
+#
+# Subroutine to set up the SCLP interface.
+#
+# Parameters:
+#   R2	= 0 to activate, non-zero to deactivate
+#
+# Returns:
+#   R2	= 0 on success, non-zero on failure
+#
+
+_sclp_setup:
+	stm	%r6,%r15,24(%r15)		# save registers
+	ahi	%r15,-96			# create stack frame
+	basr	%r13,0				# get base register
+.LbaseS3:
+	l	%r6,.LsccbS0-.LbaseS3(%r13)	# prepare init mask sccb
+	mvc	0(.LinitendS3-.LinitsccbS3,%r6),.LinitsccbS3-.LbaseS3(%r13)
+	ltr	%r2,%r2				# initialization?
+	jz	.LdoinitS3			# go ahead
+	# clear masks
+	xc	.LinitmaskS3-.LinitsccbS3(8,%r6),.LinitmaskS3-.LinitsccbS3(%r6)
+.LdoinitS3:
+	l	%r2,.LwritemaskS3-.LbaseS3(%r13)# get command word
+	lr	%r3,%r6				# get sccb address
+	bras	%r14,_sclp_servc		# issue service call
+	ltr	%r2,%r2				# servc successful?
+	jnz	.LerrorS3
+	chi	%r3,0x20			# write mask successful?
+	jne	.LerrorS3
+	# check masks
+	la	%r2,.LinitmaskS3-.LinitsccbS3(%r6)
+	l	%r1,0(%r2)			# receive mask ok?
+	n	%r1,12(%r2)
+	cl	%r1,0(%r2)
+	jne	.LerrorS3
+	l	%r1,4(%r2)			# send mask ok?
+	n	%r1,8(%r2)
+	cl	%r1,4(%r2)
+	sr	%r2,%r2
+	je	.LendS3
+.LerrorS3:
+	lhi	%r2,1				# error return code
+.LendS3:
+	lm	%r6,%r15,120(%r15)		# restore registers
+	br	%r14
+.LwritemaskS3:
+	.long	0x00780005			# SCLP command for write mask
+.LinitsccbS3:
+	.word	.LinitendS3-.LinitsccbS3
+	.byte	0,0,0,0
+	.word	0
+	.word	0
+	.word	4
+.LinitmaskS3:
+	.long	0x80000000
+	.long	0x40000000
+	.long	0
+	.long	0
+.LinitendS3:
+
+#
+# Subroutine which prints a given text to the SCLP console.
+#
+# Parameters:
+#   R2	= address of nil-terminated ASCII text
+#
+# Returns:
+#   R2	= 0 on success, 1 on failure
+#
+
+_sclp_print:
+	stm	%r6,%r15,24(%r15)		# save registers
+	ahi	%r15,-96			# create stack frame
+	basr	%r13,0				# get base register
+.LbaseS4:
+	l	%r8,.LsccbS0-.LbaseS4(%r13)	# prepare write data sccb
+	mvc	0(.LmtoS4-.LwritesccbS4,%r8),.LwritesccbS4-.LbaseS4(%r13)
+	la	%r7,.LmtoS4-.LwritesccbS4(%r8)	# current mto addr
+	sr	%r0,%r0
+	l	%r10,.Lascebc-.LbaseS4(%r13)	# address of translation table
+.LinitmtoS4:
+	# initialize mto
+	mvc	0(.LmtoendS4-.LmtoS4,%r7),.LmtoS4-.LbaseS4(%r13)
+	lhi	%r6,.LmtoendS4-.LmtoS4		# current mto length
+.LloopS4:
+	ic	%r0,0(%r2)			# get character
+	ahi	%r2,1
+	ltr	%r0,%r0				# end of string?
+	jz	.LfinalizemtoS4
+	chi	%r0,0x15			# end of line (NL)?
+	jz	.LfinalizemtoS4
+	stc	%r0,0(%r6,%r7)			# copy to mto
+	la	%r11,0(%r6,%r7)
+	tr	0(1,%r11),0(%r10)		# translate to EBCDIC
+	ahi	%r6,1
+	j	.LloopS4
+.LfinalizemtoS4:
+	sth	%r6,0(%r7)			# update mto length
+	lh	%r9,.LmdbS4-.LwritesccbS4(%r8)	# update mdb length
+	ar	%r9,%r6
+	sth	%r9,.LmdbS4-.LwritesccbS4(%r8)
+	lh	%r9,.LevbufS4-.LwritesccbS4(%r8)# update evbuf length
+	ar	%r9,%r6
+	sth	%r9,.LevbufS4-.LwritesccbS4(%r8)
+	lh	%r9,0(%r8)			# update sccb length
+	ar	%r9,%r6
+	sth	%r9,0(%r8)
+	ar	%r7,%r6				# update current mto adress
+	ltr	%r0,%r0				# more characters?
+	jnz	.LinitmtoS4
+	l	%r2,.LwritedataS4-.LbaseS4(%r13)# write data
+	lr	%r3,%r8
+	bras	%r14,_sclp_servc
+	ltr	%r2,%r2				# servc successful?
+	jnz	.LendS4
+	chi	%r3,0x20			# write data successful?
+	je	.LendS4
+	lhi	%r2,1				# error return code
+.LendS4:
+	lm	%r6,%r15,120(%r15)		# restore registers
+	br	%r14
+
+#
+# Function which prints a given text to the SCLP console.
+#
+# Parameters:
+#   R2	= address of nil-terminated ASCII text
+#
+# Returns:
+#   R2	= 0 on success, 1 on failure
+#
+
+	.globl _sclp_print_early
+_sclp_print_early:
+	stm	%r6,%r15,24(%r15)		# save registers
+	ahi	%r15,-96			# create stack frame
+	lr	%r10,%r2			# save string pointer
+	lhi	%r2,0
+	bras	%r14,_sclp_setup		# enable console
+	ltr	%r2,%r2
+	jnz	.LendS5
+	lr	%r2,%r10
+	bras	%r14,_sclp_print		# print string
+	ltr	%r2,%r2
+	jnz	.LendS5
+	lhi	%r2,1
+	bras	%r14,_sclp_setup		# disable console
+.LendS5:
+	lm	%r6,%r15,120(%r15)		# restore registers
+	br	%r14
+
+.LwritedataS4:
+	.long	0x00760005			# SCLP command for write data
+.LwritesccbS4:
+	# sccb
+	.word	.LmtoS4-.LwritesccbS4
+	.byte	0
+	.byte	0,0,0
+	.word	0
+
+	# evbuf
+.LevbufS4:
+	.word	.LmtoS4-.LevbufS4
+	.byte	0x02
+	.byte	0
+	.word	0
+
+.LmdbS4:
+	# mdb
+	.word	.LmtoS4-.LmdbS4
+	.word	1
+	.long	0xd4c4c240
+	.long	1
+
+	# go
+.LgoS4:
+	.word	.LmtoS4-.LgoS4
+	.word	1
+	.long	0
+	.byte	0,0,0,0,0,0,0,0
+	.byte	0,0,0
+	.byte	0
+	.byte	0,0,0,0,0,0,0
+	.byte	0
+	.word	0
+	.byte	0,0,0,0,0,0,0,0,0,0
+	.byte	0,0,0,0,0,0,0,0
+	.byte	0,0,0,0,0,0,0,0
+
+.LmtoS4:
+	.word	.LmtoendS4-.LmtoS4
+	.word	4
+	.word	0x1000
+	.byte	0
+	.byte	0,0,0
+.LmtoendS4:
+
+	# Global constants
+.LsccbS0:
+	.long	_sclp_work_area
+.Lascebc:
+	.long	_ascebc
+.previous
+
+.section ".init.data","a"
+	.balign 4096
+_sclp_work_area:
+	.fill	4096
+.previous
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 7402b6a..9717717 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -42,6 +42,7 @@
 #include <linux/ctype.h>
 #include <linux/reboot.h>
 #include <linux/topology.h>
+#include <linux/ftrace.h>
 
 #include <asm/ipl.h>
 #include <asm/uaccess.h>
@@ -442,6 +443,7 @@ setup_lowcore(void)
 	lc->steal_timer = S390_lowcore.steal_timer;
 	lc->last_update_timer = S390_lowcore.last_update_timer;
 	lc->last_update_clock = S390_lowcore.last_update_clock;
+	lc->ftrace_func = S390_lowcore.ftrace_func;
 	set_prefix((u32)(unsigned long) lc);
 	lowcore_ptr[0] = lc;
 }
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 3cf74c3..062bd64 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -26,6 +26,7 @@
 #include <linux/binfmts.h>
 #include <linux/tracehook.h>
 #include <linux/syscalls.h>
+#include <linux/compat.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/lowcore.h>
@@ -482,7 +483,7 @@ void do_signal(struct pt_regs *regs)
 		/* Whee!  Actually deliver the signal.  */
 		int ret;
 #ifdef CONFIG_COMPAT
-		if (test_thread_flag(TIF_31BIT)) {
+		if (is_compat_task()) {
 			ret = handle_signal32(signr, &ka, &info, oldset, regs);
 	        }
 		else
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index a985a3b..cc8c484 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -47,7 +47,7 @@
 #include <asm/timer.h>
 #include <asm/lowcore.h>
 #include <asm/sclp.h>
-#include <asm/cpu.h>
+#include <asm/cputime.h>
 #include <asm/vdso.h>
 #include "entry.h"
 
@@ -572,6 +572,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	cpu_lowcore->cpu_nr = cpu;
 	cpu_lowcore->kernel_asce = S390_lowcore.kernel_asce;
 	cpu_lowcore->machine_flags = S390_lowcore.machine_flags;
+	cpu_lowcore->ftrace_func = S390_lowcore.ftrace_func;
 	eieio();
 
 	while (signal_processor(cpu, sigp_restart) == sigp_busy)
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 2c7739f..ad1acd2 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -338,3 +338,5 @@ SYSCALL(sys_dup3,sys_dup3,sys_dup3_wrapper)
 SYSCALL(sys_epoll_create1,sys_epoll_create1,sys_epoll_create1_wrapper)
 SYSCALL(sys_preadv,sys_preadv,compat_sys_preadv_wrapper)
 SYSCALL(sys_pwritev,sys_pwritev,compat_sys_pwritev_wrapper)
+SYSCALL(sys_rt_tgsigqueueinfo,sys_rt_tgsigqueueinfo,compat_sys_rt_tgsigqueueinfo_wrapper) /* 330 */
+SYSCALL(sys_perf_counter_open,sys_perf_counter_open,sys_perf_counter_open_wrapper)
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index ef596d0..215330a 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -70,7 +70,7 @@ static DEFINE_PER_CPU(struct clock_event_device, comparators);
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
-unsigned long long sched_clock(void)
+unsigned long long notrace sched_clock(void)
 {
 	return ((get_clock_xt() - sched_clock_base_cc) * 125) >> 9;
 }
@@ -95,12 +95,6 @@ void tod_to_timeval(__u64 todval, struct timespec *xtime)
 	xtime->tv_nsec = ((todval * 1000) >> 12);
 }
 
-#ifdef CONFIG_PROFILING
-#define s390_do_profile()	profile_tick(CPU_PROFILING)
-#else
-#define s390_do_profile()	do { ; } while(0)
-#endif /* CONFIG_PROFILING */
-
 void clock_comparator_work(void)
 {
 	struct clock_event_device *cd;
@@ -109,7 +103,6 @@ void clock_comparator_work(void)
 	set_clock_comparator(S390_lowcore.clock_comparator);
 	cd = &__get_cpu_var(comparators);
 	cd->event_handler(cd);
-	s390_do_profile();
 }
 
 /*
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 89b2e7f..45e1708 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -22,7 +22,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/bootmem.h>
-
+#include <linux/compat.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -53,8 +53,19 @@ unsigned int __read_mostly vdso_enabled = 1;
 
 static int __init vdso_setup(char *s)
 {
-	vdso_enabled = simple_strtoul(s, NULL, 0);
-	return 1;
+	unsigned long val;
+	int rc;
+
+	rc = 0;
+	if (strncmp(s, "on", 3) == 0)
+		vdso_enabled = 1;
+	else if (strncmp(s, "off", 4) == 0)
+		vdso_enabled = 0;
+	else {
+		rc = strict_strtoul(s, 0, &val);
+		vdso_enabled = rc ? 0 : !!val;
+	}
+	return !rc;
 }
 __setup("vdso=", vdso_setup);
 
@@ -203,7 +214,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	vdso_pagelist = vdso64_pagelist;
 	vdso_pages = vdso64_pages;
 #ifdef CONFIG_COMPAT
-	if (test_thread_flag(TIF_31BIT)) {
+	if (is_compat_task()) {
 		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
 	}
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 89399b8..a53db23 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -34,6 +34,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		IRQENTRY_TEXT
 		*(.fixup)
 		*(.gnu.warning)
 	} :text = 0x0700
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index c87f59b..c8eb725 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -23,7 +23,7 @@
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
 #include <asm/irq_regs.h>
-#include <asm/cpu.h>
+#include <asm/cputime.h>
 
 static ext_int_info_t ext_int_info_timer;
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 10bccd1..c18b21d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -512,7 +512,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		BUG();
 	}
 
-	might_sleep();
+	might_fault();
 
 	do {
 		__vcpu_run(vcpu);
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index e41f400..f7e0d30 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -124,6 +124,27 @@ void _raw_read_lock_wait(raw_rwlock_t *rw)
 }
 EXPORT_SYMBOL(_raw_read_lock_wait);
 
+void _raw_read_lock_wait_flags(raw_rwlock_t *rw, unsigned long flags)
+{
+	unsigned int old;
+	int count = spin_retry;
+
+	local_irq_restore(flags);
+	while (1) {
+		if (count-- <= 0) {
+			_raw_yield();
+			count = spin_retry;
+		}
+		if (!__raw_read_can_lock(rw))
+			continue;
+		old = rw->lock & 0x7fffffffU;
+		local_irq_disable();
+		if (_raw_compare_and_swap(&rw->lock, old, old + 1) == old)
+			return;
+	}
+}
+EXPORT_SYMBOL(_raw_read_lock_wait_flags);
+
 int _raw_read_trylock_retry(raw_rwlock_t *rw)
 {
 	unsigned int old;
@@ -157,6 +178,25 @@ void _raw_write_lock_wait(raw_rwlock_t *rw)
 }
 EXPORT_SYMBOL(_raw_write_lock_wait);
 
+void _raw_write_lock_wait_flags(raw_rwlock_t *rw, unsigned long flags)
+{
+	int count = spin_retry;
+
+	local_irq_restore(flags);
+	while (1) {
+		if (count-- <= 0) {
+			_raw_yield();
+			count = spin_retry;
+		}
+		if (!__raw_write_can_lock(rw))
+			continue;
+		local_irq_disable();
+		if (_raw_compare_and_swap(&rw->lock, 0, 0x80000000) == 0)
+			return;
+	}
+}
+EXPORT_SYMBOL(_raw_write_lock_wait_flags);
+
 int _raw_write_trylock_retry(raw_rwlock_t *rw)
 {
 	int count = spin_retry;
diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
index 2a74581..db05661 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux s390-specific parts of the memory manager.
 #
 
-obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o
+obj-y	 := init.o fault.o extmem.o mmap.o vmem.o pgtable.o maccess.o
 obj-$(CONFIG_CMM) += cmm.o
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
 obj-$(CONFIG_PAGE_STATES) += page-states.o
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 833e836..220a152 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/ptrace.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
+#include <linux/compat.h>
 #include <linux/smp.h>
 #include <linux/kdebug.h>
 #include <linux/smp_lock.h>
@@ -239,7 +240,7 @@ static int signal_return(struct mm_struct *mm, struct pt_regs *regs,
 	up_read(&mm->mmap_sem);
 	clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
 #ifdef CONFIG_COMPAT
-	compat = test_tsk_thread_flag(current, TIF_31BIT);
+	compat = is_compat_task();
 	if (compat && instruction == 0x0a77)
 		sys32_sigreturn();
 	else if (compat && instruction == 0x0aad)
diff --git a/arch/s390/mm/maccess.c b/arch/s390/mm/maccess.c
new file mode 100644
index 0000000..8175627
--- /dev/null
+++ b/arch/s390/mm/maccess.c
@@ -0,0 +1,61 @@
+/*
+ * Access kernel memory without faulting -- s390 specific implementation.
+ *
+ * Copyright IBM Corp. 2009
+ *
+ *   Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *
+ */
+
+#include <linux/uaccess.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <asm/system.h>
+
+/*
+ * This function writes to kernel memory bypassing DAT and possible
+ * write protection. It copies one to four bytes from src to dst
+ * using the stura instruction.
+ * Returns the number of bytes copied or -EFAULT.
+ */
+static long probe_kernel_write_odd(void *dst, void *src, size_t size)
+{
+	unsigned long count, aligned;
+	int offset, mask;
+	int rc = -EFAULT;
+
+	aligned = (unsigned long) dst & ~3UL;
+	offset = (unsigned long) dst & 3;
+	count = min_t(unsigned long, 4 - offset, size);
+	mask = (0xf << (4 - count)) & 0xf;
+	mask >>= offset;
+	asm volatile(
+		"	bras	1,0f\n"
+		"	icm	0,0,0(%3)\n"
+		"0:	l	0,0(%1)\n"
+		"	lra	%1,0(%1)\n"
+		"1:	ex	%2,0(1)\n"
+		"2:	stura	0,%1\n"
+		"	la	%0,0\n"
+		"3:\n"
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b) EX_TABLE(2b,3b)
+		: "+d" (rc), "+a" (aligned)
+		: "a" (mask), "a" (src) : "cc", "memory", "0", "1");
+	return rc ? rc : count;
+}
+
+long probe_kernel_write(void *dst, void *src, size_t size)
+{
+	long copied = 0;
+
+	while (size) {
+		copied = probe_kernel_write_odd(dst, src, size);
+		if (copied < 0)
+			break;
+		dst += copied;
+		src += copied;
+		size -= copied;
+	}
+	return copied < 0 ? -EFAULT : 0;
+}
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index e008d23..f4558cc 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <asm/pgalloc.h>
+#include <asm/compat.h>
 
 /*
  * Top of mmap area (just below the process stack).
@@ -55,7 +56,7 @@ static inline int mmap_is_legacy(void)
 	/*
 	 * Force standard allocation for 64 bit programs.
 	 */
-	if (!test_thread_flag(TIF_31BIT))
+	if (!is_compat_task())
 		return 1;
 #endif
 	return sysctl_legacy_va_layout ||
@@ -91,7 +92,7 @@ EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
 
 int s390_mmap_check(unsigned long addr, unsigned long len)
 {
-	if (!test_thread_flag(TIF_31BIT) &&
+	if (!is_compat_task() &&
 	    len >= TASK_SIZE && TASK_SIZE < (1UL << 53))
 		return crst_table_upgrade(current->mm, 1UL << 53);
 	return 0;
@@ -108,8 +109,7 @@ s390_get_unmapped_area(struct file *filp, unsigned long addr,
 	area = arch_get_unmapped_area(filp, addr, len, pgoff, flags);
 	if (!(area & ~PAGE_MASK))
 		return area;
-	if (area == -ENOMEM &&
-	    !test_thread_flag(TIF_31BIT) && TASK_SIZE < (1UL << 53)) {
+	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < (1UL << 53)) {
 		/* Upgrade the page table to 4 levels and retry. */
 		rc = crst_table_upgrade(mm, 1UL << 53);
 		if (rc)
@@ -131,8 +131,7 @@ s390_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
 	area = arch_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
 	if (!(area & ~PAGE_MASK))
 		return area;
-	if (area == -ENOMEM &&
-	    !test_thread_flag(TIF_31BIT) && TASK_SIZE < (1UL << 53)) {
+	if (area == -ENOMEM && !is_compat_task() && TASK_SIZE < (1UL << 53)) {
 		/* Upgrade the page table to 4 levels and retry. */
 		rc = crst_table_upgrade(mm, 1UL << 53);
 		if (rc)
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index be6c1cf..4ca8e82 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -1,7 +1,5 @@
 /*
- *  arch/s390/mm/pgtable.c
- *
- *    Copyright IBM Corp. 2007
+ *    Copyright IBM Corp. 2007,2009
  *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  */
 
@@ -53,6 +51,18 @@ void clear_table_pgstes(unsigned long *table)
 
 #endif
 
+unsigned long VMALLOC_START = VMALLOC_END - VMALLOC_SIZE;
+EXPORT_SYMBOL(VMALLOC_START);
+
+static int __init parse_vmalloc(char *arg)
+{
+	if (!arg)
+		return -EINVAL;
+	VMALLOC_START = (VMALLOC_END - memparse(arg, &arg)) & PAGE_MASK;
+	return 0;
+}
+early_param("vmalloc", parse_vmalloc);
+
 unsigned long *crst_table_alloc(struct mm_struct *mm, int noexec)
 {
 	struct page *page = alloc_pages(GFP_KERNEL, ALLOC_ORDER);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 27a1be0..442bb98 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -851,8 +851,10 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 
 	/* Check the cqr */
 	rc = dasd_check_cqr(cqr);
-	if (rc)
+	if (rc) {
+		cqr->intrc = rc;
 		return rc;
+	}
 	device = (struct dasd_device *) cqr->startdev;
 	if (cqr->retries < 0) {
 		/* internal error 14 - start_IO run out of retries */
@@ -915,6 +917,7 @@ int dasd_start_IO(struct dasd_ccw_req *cqr)
 		BUG();
 		break;
 	}
+	cqr->intrc = rc;
 	return rc;
 }
 
@@ -1454,8 +1457,12 @@ int dasd_sleep_on(struct dasd_ccw_req *cqr)
 	dasd_add_request_tail(cqr);
 	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
-	/* Request status is either done or failed. */
-	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+	if (cqr->status == DASD_CQR_DONE)
+		rc = 0;
+	else if (cqr->intrc)
+		rc = cqr->intrc;
+	else
+		rc = -EIO;
 	return rc;
 }
 
@@ -1477,8 +1484,15 @@ int dasd_sleep_on_interruptible(struct dasd_ccw_req *cqr)
 		dasd_cancel_req(cqr);
 		/* wait (non-interruptible) for final status */
 		wait_event(generic_waitq, _wait_for_wakeup(cqr));
+		cqr->intrc = rc;
 	}
-	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+
+	if (cqr->status == DASD_CQR_DONE)
+		rc = 0;
+	else if (cqr->intrc)
+		rc = cqr->intrc;
+	else
+		rc = -EIO;
 	return rc;
 }
 
@@ -1523,8 +1537,12 @@ int dasd_sleep_on_immediatly(struct dasd_ccw_req *cqr)
 
 	wait_event(generic_waitq, _wait_for_wakeup(cqr));
 
-	/* Request status is either done or failed. */
-	rc = (cqr->status == DASD_CQR_DONE) ? 0 : -EIO;
+	if (cqr->status == DASD_CQR_DONE)
+		rc = 0;
+	else if (cqr->intrc)
+		rc = cqr->intrc;
+	else
+		rc = -EIO;
 	return rc;
 }
 
@@ -2427,12 +2445,12 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 
 
 int dasd_generic_read_dev_chars(struct dasd_device *device, char *magic,
-				void **rdc_buffer, int rdc_buffer_size)
+				void *rdc_buffer, int rdc_buffer_size)
 {
 	int ret;
 	struct dasd_ccw_req *cqr;
 
-	cqr = dasd_generic_build_rdc(device, *rdc_buffer, rdc_buffer_size,
+	cqr = dasd_generic_build_rdc(device, rdc_buffer, rdc_buffer_size,
 				     magic);
 	if (IS_ERR(cqr))
 		return PTR_ERR(cqr);
diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 2efaddf..644086b 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -202,6 +202,7 @@ dasd_start_diag(struct dasd_ccw_req * cqr)
 		rc = -EIO;
 		break;
 	}
+	cqr->intrc = rc;
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index a41c940..cf0cfdb 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1097,20 +1097,20 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private;
 	struct dasd_block *block;
-	void *rdc_data;
 	int is_known, rc;
 
 	private = (struct dasd_eckd_private *) device->private;
-	if (private == NULL) {
-		private = kzalloc(sizeof(struct dasd_eckd_private),
-				  GFP_KERNEL | GFP_DMA);
-		if (private == NULL) {
+	if (!private) {
+		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
+		if (!private) {
 			dev_warn(&device->cdev->dev,
 				 "Allocating memory for private DASD data "
 				 "failed\n");
 			return -ENOMEM;
 		}
 		device->private = (void *) private;
+	} else {
+		memset(private, 0, sizeof(*private));
 	}
 	/* Invalidate status of initial analysis. */
 	private->init_cqr_status = -1;
@@ -1161,9 +1161,8 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 		goto out_err3;
 
 	/* Read Device Characteristics */
-	rdc_data = (void *) &(private->rdc_data);
-	memset(rdc_data, 0, sizeof(rdc_data));
-	rc = dasd_generic_read_dev_chars(device, "ECKD", &rdc_data, 64);
+	rc = dasd_generic_read_dev_chars(device, "ECKD", &private->rdc_data,
+					 64);
 	if (rc) {
 		DBF_EVENT(DBF_WARNING,
 			  "Read device characteristics failed, rc=%d for "
@@ -1183,7 +1182,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 		 private->rdc_data.dev_model,
 		 private->rdc_data.cu_type,
 		 private->rdc_data.cu_model.model,
-		    private->real_cyl,
+		 private->real_cyl,
 		 private->rdc_data.trk_per_cyl,
 		 private->rdc_data.sec_per_trk);
 	return 0;
@@ -2336,9 +2335,10 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 {
 	int tpm, cmdrtd, cmdwtd;
 	int use_prefix;
-
-	struct dasd_eckd_private *private;
+#if defined(CONFIG_64BIT)
 	int fcx_in_css, fcx_in_gneq, fcx_in_features;
+#endif
+	struct dasd_eckd_private *private;
 	struct dasd_device *basedev;
 	sector_t first_rec, last_rec;
 	sector_t first_trk, last_trk;
@@ -2361,11 +2361,15 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 	last_offs = sector_div(last_trk, blk_per_trk);
 	cdlspecial = (private->uses_cdl && first_rec < 2*blk_per_trk);
 
-	/* is transport mode supported ? */
+	/* is transport mode supported? */
+#if defined(CONFIG_64BIT)
 	fcx_in_css = css_general_characteristics.fcx;
 	fcx_in_gneq = private->gneq->reserved2[7] & 0x04;
 	fcx_in_features = private->features.feature[40] & 0x80;
 	tpm = fcx_in_css && fcx_in_gneq && fcx_in_features;
+#else
+	tpm = 0;
+#endif
 
 	/* is read track data and write track data in command mode supported? */
 	cmdrtd = private->features.feature[9] & 0x20;
@@ -3013,8 +3017,9 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		      " I/O status report for device %s:\n",
 		      dev_name(&device->cdev->dev));
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-		       " in req: %p CS: 0x%02X DS: 0x%02X\n", req,
-		       scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw));
+		       " in req: %p CS: 0x%02X DS: 0x%02X CC: 0x%02X RC: %d\n",
+		       req, scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw),
+		       scsw_cc(&irb->scsw), req->intrc);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
@@ -3115,9 +3120,10 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 		      " I/O status report for device %s:\n",
 		      dev_name(&device->cdev->dev));
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
-		       " in req: %p CS: 0x%02X DS: 0x%02X "
+		       " in req: %p CS: 0x%02X DS: 0x%02X CC: 0x%02X RC: %d "
 		       "fcxs: 0x%02X schxs: 0x%02X\n", req,
 		       scsw_cstat(&irb->scsw), scsw_dstat(&irb->scsw),
+		       scsw_cc(&irb->scsw), req->intrc,
 		       irb->scsw.tm.fcxs, irb->scsw.tm.schxs);
 	len += sprintf(page + len, KERN_ERR PRINTK_HEADER
 		       " device %s: Failing TCW: %p\n",
@@ -3273,8 +3279,14 @@ static struct dasd_discipline dasd_eckd_discipline = {
 static int __init
 dasd_eckd_init(void)
 {
+	int ret;
+
 	ASCEBC(dasd_eckd_discipline.ebcname, 4);
-	return ccw_driver_register(&dasd_eckd_driver);
+	ret = ccw_driver_register(&dasd_eckd_driver);
+	if (!ret)
+		wait_for_device_probe();
+
+	return ret;
 }
 
 static void __exit
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 8912358..597c6ff 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -122,20 +122,20 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 	struct dasd_block *block;
 	struct dasd_fba_private *private;
 	struct ccw_device *cdev = device->cdev;
-	void *rdc_data;
 	int rc;
 
 	private = (struct dasd_fba_private *) device->private;
-	if (private == NULL) {
-		private = kzalloc(sizeof(struct dasd_fba_private),
-				  GFP_KERNEL | GFP_DMA);
-		if (private == NULL) {
+	if (!private) {
+		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
+		if (!private) {
 			dev_warn(&device->cdev->dev,
 				 "Allocating memory for private DASD "
 				 "data failed\n");
 			return -ENOMEM;
 		}
 		device->private = (void *) private;
+	} else {
+		memset(private, 0, sizeof(*private));
 	}
 	block = dasd_alloc_block();
 	if (IS_ERR(block)) {
@@ -150,8 +150,8 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 	block->base = device;
 
 	/* Read Device Characteristics */
-	rdc_data = (void *) &(private->rdc_data);
-	rc = dasd_generic_read_dev_chars(device, "FBA ", &rdc_data, 32);
+	rc = dasd_generic_read_dev_chars(device, "FBA ", &private->rdc_data,
+					 32);
 	if (rc) {
 		DBF_EVENT(DBF_WARNING, "Read device characteristics returned "
 			  "error %d for device: %s",
@@ -604,8 +604,14 @@ static struct dasd_discipline dasd_fba_discipline = {
 static int __init
 dasd_fba_init(void)
 {
+	int ret;
+
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
-	return ccw_driver_register(&dasd_fba_driver);
+	ret = ccw_driver_register(&dasd_fba_driver);
+	if (!ret)
+		wait_for_device_probe();
+
+	return ret;
 }
 
 static void __exit
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index c1e487f..f97ceb7 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -173,6 +173,7 @@ struct dasd_ccw_req {
 	void *data;			/* pointer to data area */
 
 	/* these are important for recovering erroneous requests          */
+	int intrc;			/* internal error, e.g. from start_IO */
 	struct irb irb;			/* device status in case of an error */
 	struct dasd_ccw_req *refers;	/* ERP-chain queueing. */
 	void *function; 		/* originating ERP action */
@@ -578,7 +579,7 @@ int dasd_generic_set_offline (struct ccw_device *cdev);
 int dasd_generic_notify(struct ccw_device *, int);
 void dasd_generic_handle_state_change(struct dasd_device *);
 
-int dasd_generic_read_dev_chars(struct dasd_device *, char *, void **, int);
+int dasd_generic_read_dev_chars(struct dasd_device *, char *, void *, int);
 char *dasd_get_sense(struct irb *);
 
 /* externals in dasd_devmap.c */
diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index a4c7ffc..b21caf1 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -127,7 +127,7 @@ dcssblk_assign_free_minor(struct dcssblk_dev_info *dev_info)
 		found = 0;
 		// test if minor available
 		list_for_each_entry(entry, &dcssblk_devices, lh)
-			if (minor == MINOR(disk_devt(entry->gd)))
+			if (minor == entry->gd->first_minor)
 				found++;
 		if (!found) break; // got unused minor
 	}
@@ -625,7 +625,7 @@ dcssblk_add_store(struct device *dev, struct device_attribute *attr, const char
 	if (rc)
 		goto release_gd;
 	sprintf(dev_info->gd->disk_name, "dcssblk%d",
-		MINOR(disk_devt(dev_info->gd)));
+		dev_info->gd->first_minor);
 	list_add_tail(&dev_info->lh, &dcssblk_devices);
 
 	if (!try_module_get(THIS_MODULE)) {
diff --git a/drivers/s390/char/con3270.c b/drivers/s390/char/con3270.c
index d028d2e..ed5396d 100644
--- a/drivers/s390/char/con3270.c
+++ b/drivers/s390/char/con3270.c
@@ -64,7 +64,7 @@ static struct con3270 *condev;
 #define CON_UPDATE_ERASE	1	/* Use EWRITEA instead of WRITE. */
 #define CON_UPDATE_LIST		2	/* Update lines in tty3270->update. */
 #define CON_UPDATE_STATUS	4	/* Update status line. */
-#define CON_UPDATE_ALL		7
+#define CON_UPDATE_ALL		8	/* Recreate screen. */
 
 static void con3270_update(struct con3270 *);
 
@@ -73,18 +73,10 @@ static void con3270_update(struct con3270 *);
  */
 static void con3270_set_timer(struct con3270 *cp, int expires)
 {
-	if (expires == 0) {
-		if (timer_pending(&cp->timer))
-			del_timer(&cp->timer);
-		return;
-	}
-	if (timer_pending(&cp->timer) &&
-	    mod_timer(&cp->timer, jiffies + expires))
-		return;
-	cp->timer.function = (void (*)(unsigned long)) con3270_update;
-	cp->timer.data = (unsigned long) cp;
-	cp->timer.expires = jiffies + expires;
-	add_timer(&cp->timer);
+	if (expires == 0)
+		del_timer(&cp->timer);
+	else
+		mod_timer(&cp->timer, jiffies + expires);
 }
 
 /*
@@ -225,6 +217,12 @@ con3270_update(struct con3270 *cp)
 
 	spin_lock_irqsave(&cp->view.lock, flags);
 	updated = 0;
+	if (cp->update_flags & CON_UPDATE_ALL) {
+		con3270_rebuild_update(cp);
+		con3270_update_status(cp);
+		cp->update_flags = CON_UPDATE_ERASE | CON_UPDATE_LIST |
+			CON_UPDATE_STATUS;
+	}
 	if (cp->update_flags & CON_UPDATE_ERASE) {
 		/* Use erase write alternate to initialize display. */
 		raw3270_request_set_cmd(wrq, TC_EWRITEA);
@@ -302,7 +300,6 @@ con3270_read_tasklet(struct raw3270_request *rrq)
 		deactivate = 1;
 		break;
 	case 0x6d:	/* clear: start from scratch. */
-		con3270_rebuild_update(cp);
 		cp->update_flags = CON_UPDATE_ALL;
 		con3270_set_timer(cp, 1);
 		break;
@@ -382,30 +379,21 @@ con3270_issue_read(struct con3270 *cp)
 static int
 con3270_activate(struct raw3270_view *view)
 {
-	unsigned long flags;
 	struct con3270 *cp;
 
 	cp = (struct con3270 *) view;
-	spin_lock_irqsave(&cp->view.lock, flags);
-	cp->nr_up = 0;
-	con3270_rebuild_update(cp);
-	con3270_update_status(cp);
 	cp->update_flags = CON_UPDATE_ALL;
 	con3270_set_timer(cp, 1);
-	spin_unlock_irqrestore(&cp->view.lock, flags);
 	return 0;
 }
 
 static void
 con3270_deactivate(struct raw3270_view *view)
 {
-	unsigned long flags;
 	struct con3270 *cp;
 
 	cp = (struct con3270 *) view;
-	spin_lock_irqsave(&cp->view.lock, flags);
 	del_timer(&cp->timer);
-	spin_unlock_irqrestore(&cp->view.lock, flags);
 }
 
 static int
@@ -504,6 +492,7 @@ con3270_write(struct console *co, const char *str, unsigned int count)
 			con3270_cline_end(cp);
 	}
 	/* Setup timer to output current console buffer after 1/10 second */
+	cp->nr_up = 0;
 	if (cp->view.dev && !timer_pending(&cp->timer))
 		con3270_set_timer(cp, HZ/10);
 	spin_unlock_irqrestore(&cp->view.lock,flags);
@@ -624,7 +613,8 @@ con3270_init(void)
 
 	INIT_LIST_HEAD(&condev->lines);
 	INIT_LIST_HEAD(&condev->update);
-	init_timer(&condev->timer);
+	setup_timer(&condev->timer, (void (*)(unsigned long)) con3270_update,
+		    (unsigned long) condev);
 	tasklet_init(&condev->readlet, 
 		     (void (*)(unsigned long)) con3270_read_tasklet,
 		     (unsigned long) condev->read);
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index a7fe630..3838567 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -112,7 +112,7 @@ struct tty3270 {
 #define TTY_UPDATE_LIST		2	/* Update lines in tty3270->update. */
 #define TTY_UPDATE_INPUT	4	/* Update input line. */
 #define TTY_UPDATE_STATUS	8	/* Update status line. */
-#define TTY_UPDATE_ALL		15
+#define TTY_UPDATE_ALL		16	/* Recreate screen. */
 
 static void tty3270_update(struct tty3270 *);
 
@@ -121,19 +121,10 @@ static void tty3270_update(struct tty3270 *);
  */
 static void tty3270_set_timer(struct tty3270 *tp, int expires)
 {
-	if (expires == 0) {
-		if (timer_pending(&tp->timer) && del_timer(&tp->timer))
-			raw3270_put_view(&tp->view);
-		return;
-	}
-	if (timer_pending(&tp->timer) &&
-	    mod_timer(&tp->timer, jiffies + expires))
-		return;
-	raw3270_get_view(&tp->view);
-	tp->timer.function = (void (*)(unsigned long)) tty3270_update;
-	tp->timer.data = (unsigned long) tp;
-	tp->timer.expires = jiffies + expires;
-	add_timer(&tp->timer);
+	if (expires == 0)
+		del_timer(&tp->timer);
+	else
+		mod_timer(&tp->timer, jiffies + expires);
 }
 
 /*
@@ -337,7 +328,6 @@ tty3270_write_callback(struct raw3270_request *rq, void *data)
 	tp = (struct tty3270 *) rq->view;
 	if (rq->rc != 0) {
 		/* Write wasn't successfull. Refresh all. */
-		tty3270_rebuild_update(tp);
 		tp->update_flags = TTY_UPDATE_ALL;
 		tty3270_set_timer(tp, 1);
 	}
@@ -366,6 +356,12 @@ tty3270_update(struct tty3270 *tp)
 
 	spin_lock(&tp->view.lock);
 	updated = 0;
+	if (tp->update_flags & TTY_UPDATE_ALL) {
+		tty3270_rebuild_update(tp);
+		tty3270_update_status(tp);
+		tp->update_flags = TTY_UPDATE_ERASE | TTY_UPDATE_LIST |
+			TTY_UPDATE_INPUT | TTY_UPDATE_STATUS;
+	}
 	if (tp->update_flags & TTY_UPDATE_ERASE) {
 		/* Use erase write alternate to erase display. */
 		raw3270_request_set_cmd(wrq, TC_EWRITEA);
@@ -425,7 +421,6 @@ tty3270_update(struct tty3270 *tp)
 		xchg(&tp->write, wrq);
 	}
 	spin_unlock(&tp->view.lock);
-	raw3270_put_view(&tp->view);
 }
 
 /*
@@ -570,7 +565,6 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 		tty3270_set_timer(tp, 1);
 	} else if (tp->input->string[0] == 0x6d) {
 		/* Display has been cleared. Redraw. */
-		tty3270_rebuild_update(tp);
 		tp->update_flags = TTY_UPDATE_ALL;
 		tty3270_set_timer(tp, 1);
 	}
@@ -641,22 +635,20 @@ static int
 tty3270_activate(struct raw3270_view *view)
 {
 	struct tty3270 *tp;
-	unsigned long flags;
 
 	tp = (struct tty3270 *) view;
-	spin_lock_irqsave(&tp->view.lock, flags);
-	tp->nr_up = 0;
-	tty3270_rebuild_update(tp);
-	tty3270_update_status(tp);
 	tp->update_flags = TTY_UPDATE_ALL;
 	tty3270_set_timer(tp, 1);
-	spin_unlock_irqrestore(&tp->view.lock, flags);
 	return 0;
 }
 
 static void
 tty3270_deactivate(struct raw3270_view *view)
 {
+	struct tty3270 *tp;
+
+	tp = (struct tty3270 *) view;
+	del_timer(&tp->timer);
 }
 
 static int
@@ -743,6 +735,7 @@ tty3270_free_view(struct tty3270 *tp)
 {
 	int pages;
 
+	del_timer_sync(&tp->timer);
 	kbd_free(tp->kbd);
 	raw3270_request_free(tp->kreset);
 	raw3270_request_free(tp->read);
@@ -889,7 +882,8 @@ tty3270_open(struct tty_struct *tty, struct file * filp)
 	INIT_LIST_HEAD(&tp->update);
 	INIT_LIST_HEAD(&tp->rcl_lines);
 	tp->rcl_max = 20;
-	init_timer(&tp->timer);
+	setup_timer(&tp->timer, (void (*)(unsigned long)) tty3270_update,
+		    (unsigned long) tp);
 	tasklet_init(&tp->readlet, 
 		     (void (*)(unsigned long)) tty3270_read_tasklet,
 		     (unsigned long) tp->read);
@@ -1754,14 +1748,6 @@ static const struct tty_operations tty3270_ops = {
 	.set_termios = tty3270_set_termios
 };
 
-static void tty3270_notifier(int index, int active)
-{
-	if (active)
-		tty_register_device(tty3270_driver, index, NULL);
-	else
-		tty_unregister_device(tty3270_driver, index);
-}
-
 /*
  * 3270 tty registration code called from tty_init().
  * Most kernel services (incl. kmalloc) are available at this poimt.
@@ -1796,12 +1782,6 @@ static int __init tty3270_init(void)
 		return ret;
 	}
 	tty3270_driver = driver;
-	ret = raw3270_register_notifier(tty3270_notifier);
-	if (ret) {
-		put_tty_driver(driver);
-		return ret;
-
-	}
 	return 0;
 }
 
@@ -1810,7 +1790,6 @@ tty3270_exit(void)
 {
 	struct tty_driver *driver;
 
-	raw3270_unregister_notifier(tty3270_notifier);
 	driver = tty3270_driver;
 	tty3270_driver = NULL;
 	tty_unregister_driver(driver);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 2aebb98..5ec7789 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -12,6 +12,7 @@
 #define KMSG_COMPONENT "cio"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <linux/ftrace.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -28,7 +29,7 @@
 #include <asm/chpid.h>
 #include <asm/airq.h>
 #include <asm/isc.h>
-#include <asm/cpu.h>
+#include <asm/cputime.h>
 #include <asm/fcx.h>
 #include <asm/nmi.h>
 #include <asm/crw.h>
@@ -626,8 +627,7 @@ out:
  *	    handlers).
  *
  */
-void
-do_IRQ (struct pt_regs *regs)
+void __irq_entry do_IRQ(struct pt_regs *regs)
 {
 	struct tpi_info *tpi_info;
 	struct subchannel *sch;
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 151754d..bf0a24a 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -114,7 +114,7 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
 	struct subchannel *sch;
 	int ret;
 
-	if (!cdev)
+	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
@@ -122,8 +122,6 @@ int ccw_device_clear(struct ccw_device *cdev, unsigned long intparm)
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
-	if (!sch)
-		return -ENODEV;
 	ret = cio_clear(sch);
 	if (ret == 0)
 		cdev->private->intparm = intparm;
@@ -161,11 +159,9 @@ int ccw_device_start_key(struct ccw_device *cdev, struct ccw1 *cpa,
 	struct subchannel *sch;
 	int ret;
 
-	if (!cdev)
+	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
-	if (!sch)
-		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_VERIFY ||
@@ -339,7 +335,7 @@ int ccw_device_halt(struct ccw_device *cdev, unsigned long intparm)
 	struct subchannel *sch;
 	int ret;
 
-	if (!cdev)
+	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
@@ -347,8 +343,6 @@ int ccw_device_halt(struct ccw_device *cdev, unsigned long intparm)
 	    cdev->private->state != DEV_STATE_W4SENSE)
 		return -EINVAL;
 	sch = to_subchannel(cdev->dev.parent);
-	if (!sch)
-		return -ENODEV;
 	ret = cio_halt(sch);
 	if (ret == 0)
 		cdev->private->intparm = intparm;
@@ -372,11 +366,9 @@ int ccw_device_resume(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
 
-	if (!cdev)
+	if (!cdev || !cdev->dev.parent)
 		return -ENODEV;
 	sch = to_subchannel(cdev->dev.parent);
-	if (!sch)
-		return -ENODEV;
 	if (cdev->private->state == DEV_STATE_NOT_OPER)
 		return -ENODEV;
 	if (cdev->private->state != DEV_STATE_ONLINE ||
@@ -471,11 +463,11 @@ __u8 ccw_device_get_path_mask(struct ccw_device *cdev)
 {
 	struct subchannel *sch;
 
-	sch = to_subchannel(cdev->dev.parent);
-	if (!sch)
+	if (!cdev->dev.parent)
 		return 0;
-	else
-		return sch->lpm;
+
+	sch = to_subchannel(cdev->dev.parent);
+	return sch->lpm;
 }
 
 /*
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index accd957..d79cf5b 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -881,42 +881,26 @@ no_handler:
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
 }
 
-static int qdio_establish_check_errors(struct ccw_device *cdev, int cstat,
-				       int dstat)
+static void qdio_establish_handle_irq(struct ccw_device *cdev, int cstat,
+				      int dstat)
 {
 	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
 
-	if (cstat || (dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END))) {
-		DBF_ERROR("EQ:ck con");
-		goto error;
-	}
+	DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qest irq");
 
-	if (!(dstat & DEV_STAT_DEV_END)) {
-		DBF_ERROR("EQ:no dev");
+	if (cstat)
 		goto error;
-	}
-
-	if (dstat & ~(DEV_STAT_CHN_END | DEV_STAT_DEV_END)) {
-		DBF_ERROR("EQ: bad io");
+	if (dstat & ~(DEV_STAT_DEV_END | DEV_STAT_CHN_END))
 		goto error;
-	}
-	return 0;
+	if (!(dstat & DEV_STAT_DEV_END))
+		goto error;
+	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ESTABLISHED);
+	return;
+
 error:
 	DBF_ERROR("%4x EQ:error", irq_ptr->schid.sch_no);
 	DBF_ERROR("ds: %2x cs:%2x", dstat, cstat);
-
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
-	return 1;
-}
-
-static void qdio_establish_handle_irq(struct ccw_device *cdev, int cstat,
-				      int dstat)
-{
-	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
-
-	DBF_DEV_EVENT(DBF_INFO, irq_ptr, "qest irq");
-	if (!qdio_establish_check_errors(cdev, cstat, dstat))
-		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ESTABLISHED);
 }
 
 /* qdio interrupt handler */
@@ -946,7 +930,6 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		}
 	}
 	qdio_irq_check_sense(irq_ptr, irb);
-
 	cstat = irb->scsw.cmd.cstat;
 	dstat = irb->scsw.cmd.dstat;
 
@@ -954,22 +937,19 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	case QDIO_IRQ_STATE_INACTIVE:
 		qdio_establish_handle_irq(cdev, cstat, dstat);
 		break;
-
 	case QDIO_IRQ_STATE_CLEANUP:
 		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_INACTIVE);
 		break;
-
 	case QDIO_IRQ_STATE_ESTABLISHED:
 	case QDIO_IRQ_STATE_ACTIVE:
 		if (cstat & SCHN_STAT_PCI) {
 			qdio_int_handler_pci(irq_ptr);
 			return;
 		}
-		if ((cstat & ~SCHN_STAT_PCI) || dstat) {
+		if (cstat || dstat)
 			qdio_handle_activate_check(cdev, intparm, cstat,
 						   dstat);
-			break;
-		}
+		break;
 	default:
 		WARN_ON(1);
 	}
@@ -1514,7 +1494,7 @@ int do_QDIO(struct ccw_device *cdev, unsigned int callflags,
 
 	if ((bufnr > QDIO_MAX_BUFFERS_PER_Q) ||
 	    (count > QDIO_MAX_BUFFERS_PER_Q) ||
-	    (q_nr > QDIO_MAX_QUEUES_PER_IRQ))
+	    (q_nr >= QDIO_MAX_QUEUES_PER_IRQ))
 		return -EINVAL;
 
 	if (!count)
diff --git a/drivers/s390/cio/qdio_perf.c b/drivers/s390/cio/qdio_perf.c
index 136d0f0..eff9439 100644
--- a/drivers/s390/cio/qdio_perf.c
+++ b/drivers/s390/cio/qdio_perf.c
@@ -25,18 +25,6 @@ struct qdio_perf_stats perf_stats;
 static struct proc_dir_entry *qdio_perf_pde;
 #endif
 
-inline void qdio_perf_stat_inc(atomic_long_t *count)
-{
-	if (qdio_performance_stats)
-		atomic_long_inc(count);
-}
-
-inline void qdio_perf_stat_dec(atomic_long_t *count)
-{
-	if (qdio_performance_stats)
-		atomic_long_dec(count);
-}
-
 /*
  * procfs functions
  */
diff --git a/drivers/s390/cio/qdio_perf.h b/drivers/s390/cio/qdio_perf.h
index 7821ac4..ff4504c 100644
--- a/drivers/s390/cio/qdio_perf.h
+++ b/drivers/s390/cio/qdio_perf.h
@@ -9,7 +9,6 @@
 #define QDIO_PERF_H
 
 #include <linux/types.h>
-#include <linux/device.h>
 #include <asm/atomic.h>
 
 struct qdio_perf_stats {
@@ -50,10 +49,13 @@ struct qdio_perf_stats {
 extern struct qdio_perf_stats perf_stats;
 extern int qdio_performance_stats;
 
+static inline void qdio_perf_stat_inc(atomic_long_t *count)
+{
+	if (qdio_performance_stats)
+		atomic_long_inc(count);
+}
+
 int qdio_setup_perf_stats(void);
 void qdio_remove_perf_stats(void);
 
-extern void qdio_perf_stat_inc(atomic_long_t *count);
-extern void qdio_perf_stat_dec(atomic_long_t *count);
-
 #endif
diff --git a/mm/maccess.c b/mm/maccess.c
index ac40796..9073695 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL_GPL(probe_kernel_read);
  * Safely write to address @dst from the buffer at @src.  If a kernel fault
  * happens, handle that and return -EFAULT.
  */
-long probe_kernel_write(void *dst, void *src, size_t size)
+long notrace __weak probe_kernel_write(void *dst, void *src, size_t size)
 {
 	long ret;
 	mm_segment_t old_fs = get_fs();
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 0fae7da..91033e6 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -185,6 +185,19 @@ if ($arch eq "x86_64") {
     $objcopy .= " -O elf32-i386";
     $cc .= " -m32";
 
+} elsif ($arch eq "s390" && $bits == 32) {
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_390_32\\s+_mcount\$";
+    $alignment = 4;
+    $ld .= " -m elf_s390";
+    $cc .= " -m31";
+
+} elsif ($arch eq "s390" && $bits == 64) {
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):\\s*R_390_(PC|PLT)32DBL\\s+_mcount\\+0x2\$";
+    $alignment = 8;
+    $type = ".quad";
+    $ld .= " -m elf64_s390";
+    $cc .= " -m64";
+
 } elsif ($arch eq "sh") {
     $alignment = 2;
 
