Return-Path: <linux-kernel-owner+w=401wt.eu-S1754049Ab0ANOao@vger.kernel.org>
Date: Thu, 14 Jan 2010 15:30:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.33-rc4
Message-ID: <20100114153034.542cdc80@mschwide.boeblingen.de.ibm.com>
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

Heiko Carstens (15):
      [S390] dasd: add missing compat ptr conversion
      [S390] cio: add missing compat ptr conversion
      [S390] vmcp: add missing compat ptr conversion
      [S390] fs3270: add missing compat ptr conversion
      [S390] smp: setup smp_processor_id early
      [S390] smp: remove volatile type quilifier from __cpu_logical_map
      [S390] tape_block: remove ioctl function
      [S390] Move __cpu_logical_map to smp.c
      [S390] bug: implement arch specific __WARN macro
      [S390] mmap: add missing compat_ptr conversion to both mmap compat syscalls
      [S390] dasd: add proper compat pointer conversion for symmetrix ioctl
      [S390] con3215: remove empty ioctl function
      [S390] unwire sys_recvmmsg again
      [S390] zcrypt: add sanity check before copy_from_user()
      [S390] tape_char: add missing compat_ptr conversion

Jiri Slaby (1):
      [S390] use helpers for rlimits

Martin Schwidefsky (4):
      [S390] fix loading of PER control registers for utrace.
      [S390] clear TIF_SINGLE_STEP for new process.
      [S390] duplicate SIGTRAP on signal delivery.
      [S390] remove superfluous TIF_USEDFPU bit

 arch/s390/include/asm/bug.h         |    4 +++
 arch/s390/include/asm/sigp.h        |   20 ++++++++++++-----
 arch/s390/include/asm/thread_info.h |   12 ++++------
 arch/s390/include/asm/unistd.h      |    6 +++-
 arch/s390/kernel/compat_linux.c     |   41 +++++++++++++---------------------
 arch/s390/kernel/compat_wrapper.S   |    9 -------
 arch/s390/kernel/process.c          |    3 +-
 arch/s390/kernel/ptrace.c           |    8 ++++++
 arch/s390/kernel/setup.c            |    8 ------
 arch/s390/kernel/signal.c           |   10 +-------
 arch/s390/kernel/smp.c              |    9 +++++++
 arch/s390/kernel/syscalls.S         |    1 -
 arch/s390/kernel/topology.c         |    2 +-
 arch/s390/lib/spinlock.c            |    2 +-
 arch/s390/mm/mmap.c                 |    4 +-
 drivers/s390/block/dasd_eckd.c      |   14 +++++++----
 drivers/s390/block/dasd_ioctl.c     |   14 +++++++----
 drivers/s390/char/con3215.c         |   17 --------------
 drivers/s390/char/fs3270.c          |   17 +++++++++-----
 drivers/s390/char/tape_block.c      |   39 ---------------------------------
 drivers/s390/char/tape_char.c       |   18 ++++++++++++--
 drivers/s390/char/vmcp.c            |   12 +++++++--
 drivers/s390/cio/chsc_sch.c         |   23 ++++++++++++------
 drivers/s390/crypto/zcrypt_api.c    |    4 ++-
 24 files changed, 137 insertions(+), 160 deletions(-)

diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index efb74fd..b1066b9 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -52,6 +52,10 @@
 	unreachable();					\
 } while (0)
 
+#define __WARN() do {					\
+	__EMIT_BUG(BUGFLAG_WARNING);			\
+} while (0)
+
 #define WARN_ON(x) ({					\
 	int __ret_warn_on = !!(x);			\
 	if (__builtin_constant_p(__ret_warn_on)) {	\
diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
index ec403d4..f72d611 100644
--- a/arch/s390/include/asm/sigp.h
+++ b/arch/s390/include/asm/sigp.h
@@ -15,11 +15,19 @@
 #ifndef __SIGP__
 #define __SIGP__
 
-#include <asm/ptrace.h>
-#include <asm/atomic.h>
+#include <asm/system.h>
 
 /* get real cpu address from logical cpu number */
-extern volatile int __cpu_logical_map[];
+extern int __cpu_logical_map[];
+
+static inline int cpu_logical_map(int cpu)
+{
+#ifdef CONFIG_SMP
+	return __cpu_logical_map[cpu];
+#else
+	return stap();
+#endif
+}
 
 typedef enum
 {
@@ -79,7 +87,7 @@ signal_processor(__u16 cpu_addr, sigp_order_code order_code)
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		:	"=d"	(ccode)
-		: "d" (reg1), "d" (__cpu_logical_map[cpu_addr]),
+		: "d" (reg1), "d" (cpu_logical_map(cpu_addr)),
 		  "a" (order_code) : "cc" , "memory");
 	return ccode;
 }
@@ -98,7 +106,7 @@ signal_processor_p(__u32 parameter, __u16 cpu_addr, sigp_order_code order_code)
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		: "=d" (ccode)
-		: "d" (reg1), "d" (__cpu_logical_map[cpu_addr]),
+		: "d" (reg1), "d" (cpu_logical_map(cpu_addr)),
 		  "a" (order_code) : "cc" , "memory");
 	return ccode;
 }
@@ -118,7 +126,7 @@ signal_processor_ps(__u32 *statusptr, __u32 parameter, __u16 cpu_addr,
 		"	ipm	%0\n"
 		"	srl	%0,28\n"
 		: "=d" (ccode), "+d" (reg1)
-		: "d" (__cpu_logical_map[cpu_addr]), "a" (order_code)
+		: "d" (cpu_logical_map(cpu_addr)), "a" (order_code)
 		: "cc" , "memory");
 	*statusptr = reg1;
 	return ccode;
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 07eb61b..66069e7 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -93,13 +93,12 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_AUDIT	9	/* syscall auditing active */
 #define TIF_SECCOMP		10	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	11	/* syscall tracepoint instrumentation */
-#define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
-#define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
+#define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
-#define TIF_31BIT		18	/* 32bit process */ 
-#define TIF_MEMDIE		19
-#define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
-#define TIF_FREEZE		21	/* thread is freezing for suspend */
+#define TIF_31BIT		17	/* 32bit process */
+#define TIF_MEMDIE		18
+#define TIF_RESTORE_SIGMASK	19	/* restore signal mask in do_signal() */
+#define TIF_FREEZE		20	/* thread is freezing for suspend */
 
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
@@ -112,7 +111,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
-#define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_31BIT		(1<<TIF_31BIT)
 #define _TIF_FREEZE		(1<<TIF_FREEZE)
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 192a720..6e9f049 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -269,8 +269,7 @@
 #define	__NR_pwritev		329
 #define __NR_rt_tgsigqueueinfo	330
 #define __NR_perf_event_open	331
-#define __NR_recvmmsg		332
-#define NR_syscalls 333
+#define NR_syscalls 332
 
 /* 
  * There are some system calls that are not present on 64 bit, some
@@ -377,6 +376,9 @@
 #define __IGNORE_migrate_pages
 #define __IGNORE_move_pages
 
+/* Ignore system calls that are also reachable via sys_socket */
+#define __IGNORE_recvmmsg
+
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linux.c
index 22c9e55..11c3aba 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -616,44 +616,35 @@ asmlinkage long sys32_fstatat64(unsigned int dfd, char __user *filename,
  */
 
 struct mmap_arg_struct_emu31 {
-	u32	addr;
-	u32	len;
-	u32	prot;
-	u32	flags;
-	u32	fd;
-	u32	offset;
+	compat_ulong_t addr;
+	compat_ulong_t len;
+	compat_ulong_t prot;
+	compat_ulong_t flags;
+	compat_ulong_t fd;
+	compat_ulong_t offset;
 };
 
-asmlinkage unsigned long
-old32_mmap(struct mmap_arg_struct_emu31 __user *arg)
+asmlinkage unsigned long old32_mmap(struct mmap_arg_struct_emu31 __user *arg)
 {
 	struct mmap_arg_struct_emu31 a;
-	int error = -EFAULT;
 
 	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;
-
-	error = -EINVAL;
+		return -EFAULT;
 	if (a.offset & ~PAGE_MASK)
-		goto out;
-
-	error = sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd,
-			       a.offset >> PAGE_SHIFT);
-out:
-	return error;
+		return -EINVAL;
+	a.addr = (unsigned long) compat_ptr(a.addr);
+	return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd,
+			      a.offset >> PAGE_SHIFT);
 }
 
-asmlinkage long 
-sys32_mmap2(struct mmap_arg_struct_emu31 __user *arg)
+asmlinkage long sys32_mmap2(struct mmap_arg_struct_emu31 __user *arg)
 {
 	struct mmap_arg_struct_emu31 a;
-	int error = -EFAULT;
 
 	if (copy_from_user(&a, arg, sizeof(a)))
-		goto out;
-	error = sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
-out:
-	return error;
+		return -EFAULT;
+	a.addr = (unsigned long) compat_ptr(a.addr);
+	return sys_mmap_pgoff(a.addr, a.len, a.prot, a.flags, a.fd, a.offset);
 }
 
 asmlinkage long sys32_read(unsigned int fd, char __user * buf, size_t count)
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index faeaccc..30de2d0 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1853,12 +1853,3 @@ sys32_execve_wrapper:
 	llgtr	%r3,%r3			# compat_uptr_t *
 	llgtr	%r4,%r4			# compat_uptr_t *
 	jg	sys32_execve		# branch to system call
-
-	.globl	compat_sys_recvmmsg_wrapper
-compat_sys_recvmmsg_wrapper:
-	lgfr	%r2,%r2			# int
-	llgtr	%r3,%r3			# struct compat_mmsghdr *
-	llgfr	%r4,%r4			# unsigned int
-	llgfr	%r5,%r5			# unsigned int
-	llgtr	%r6,%r6			# struct compat_timespec *
-	jg	compat_sys_recvmmsg
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 5417eb5..00b6d1d 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -153,8 +153,6 @@ void exit_thread(void)
 
 void flush_thread(void)
 {
-	clear_used_math();
-	clear_tsk_thread_flag(current, TIF_USEDFPU);
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -217,6 +215,7 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 	p->thread.mm_segment = get_fs();
 	/* Don't copy debug registers */
 	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
+	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
 	/* Initialize per thread user and system timer values */
 	ti = task_thread_info(p);
 	ti->user_timer = 0;
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 13815d3..7cf4642 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -65,6 +65,7 @@ FixPerRegisters(struct task_struct *task)
 {
 	struct pt_regs *regs;
 	per_struct *per_info;
+	per_cr_words cr_words;
 
 	regs = task_pt_regs(task);
 	per_info = (per_struct *) &task->thread.per_info;
@@ -98,6 +99,13 @@ FixPerRegisters(struct task_struct *task)
 		per_info->control_regs.bits.storage_alt_space_ctl = 1;
 	else
 		per_info->control_regs.bits.storage_alt_space_ctl = 0;
+
+	if (task == current) {
+		__ctl_store(cr_words, 9, 11);
+		if (memcmp(&cr_words, &per_info->control_regs.words,
+			   sizeof(cr_words)) != 0)
+			__ctl_load(per_info->control_regs.words, 9, 11);
+	}
 }
 
 void user_enable_single_step(struct task_struct *task)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 0663287..8d8957b 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -87,7 +87,6 @@ unsigned long elf_hwcap = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
 struct mem_chunk __initdata memory_chunk[MEMORY_CHUNKS];
-volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
 
 int __initdata memory_end_set;
 unsigned long __initdata memory_end;
@@ -124,12 +123,6 @@ void __cpuinit cpu_init(void)
          */
 	get_cpu_id(&S390_lowcore.cpu_id);
 
-        /*
-         * Force FPU initialization:
-         */
-        clear_thread_flag(TIF_USEDFPU);
-        clear_used_math();
-
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 	BUG_ON(current->mm);
@@ -855,7 +848,6 @@ setup_arch(char **cmdline_p)
 	setup_lowcore();
 
         cpu_init();
-	__cpu_logical_map[0] = stap();
 	s390_init_cpu_topology();
 
 	/*
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 6b4fef8..1675c48 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -500,18 +500,10 @@ void do_signal(struct pt_regs *regs)
 				clear_thread_flag(TIF_RESTORE_SIGMASK);
 
 			/*
-			 * If we would have taken a single-step trap
-			 * for a normal instruction, act like we took
-			 * one for the handler setup.
-			 */
-			if (current->thread.per_info.single_step)
-				set_thread_flag(TIF_SINGLE_STEP);
-
-			/*
 			 * Let tracing know that we've done the handler setup.
 			 */
 			tracehook_signal_handler(signr, &info, &ka, regs,
-					 test_thread_flag(TIF_SINGLE_STEP));
+					current->thread.per_info.single_step);
 		}
 		return;
 	}
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 93e5203..76a6fdd 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -52,6 +52,9 @@
 #include <asm/cpu.h>
 #include "entry.h"
 
+/* logical cpu to cpu address */
+int __cpu_logical_map[NR_CPUS];
+
 static struct task_struct *current_set[NR_CPUS];
 
 static u8 smp_cpu_type;
@@ -717,6 +720,12 @@ void __init smp_cpus_done(unsigned int max_cpus)
 {
 }
 
+void __init smp_setup_processor_id(void)
+{
+	S390_lowcore.cpu_nr = 0;
+	__cpu_logical_map[0] = stap();
+}
+
 /*
  * the frequency of the profiling timer can be changed
  * by writing a multiplier value into /proc/profile.
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 4f292c9..30eca07 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -340,4 +340,3 @@ SYSCALL(sys_preadv,sys_preadv,compat_sys_preadv_wrapper)
 SYSCALL(sys_pwritev,sys_pwritev,compat_sys_pwritev_wrapper)
 SYSCALL(sys_rt_tgsigqueueinfo,sys_rt_tgsigqueueinfo,compat_sys_rt_tgsigqueueinfo_wrapper) /* 330 */
 SYSCALL(sys_perf_event_open,sys_perf_event_open,sys_perf_event_open_wrapper)
-SYSCALL(sys_recvmmsg,sys_recvmmsg,compat_sys_recvmmsg_wrapper)
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 3c72c9c..14ef6f0 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -114,7 +114,7 @@ static void add_cpus_to_core(struct tl_cpu *tl_cpu, struct core_info *core)
 
 		rcpu = CPU_BITS - 1 - cpu + tl_cpu->origin;
 		for_each_present_cpu(lcpu) {
-			if (__cpu_logical_map[lcpu] == rcpu) {
+			if (cpu_logical_map(lcpu) == rcpu) {
 				cpu_set(lcpu, core->mask);
 				smp_cpu_polarization[lcpu] = tl_cpu->pp;
 			}
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index 10754a3..cff327f 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -34,7 +34,7 @@ static inline void _raw_yield_cpu(int cpu)
 {
 	if (MACHINE_HAS_DIAG9C)
 		asm volatile("diag %0,0,0x9c"
-			     : : "d" (__cpu_logical_map[cpu]));
+			     : : "d" (cpu_logical_map(cpu)));
 	else
 		_raw_yield();
 }
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index f4558cc..869efba 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -40,7 +40,7 @@
 
 static inline unsigned long mmap_base(void)
 {
-	unsigned long gap = current->signal->rlim[RLIMIT_STACK].rlim_cur;
+	unsigned long gap = rlimit(RLIMIT_STACK);
 
 	if (gap < MIN_GAP)
 		gap = MIN_GAP;
@@ -61,7 +61,7 @@ static inline int mmap_is_legacy(void)
 #endif
 	return sysctl_legacy_va_layout ||
 	    (current->personality & ADDR_COMPAT_LAYOUT) ||
-	    current->signal->rlim[RLIMIT_STACK].rlim_cur == RLIM_INFINITY;
+	    rlimit(RLIMIT_STACK) == RLIM_INFINITY;
 }
 
 #ifndef CONFIG_64BIT
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 5819dc0..1c500c4 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -23,6 +23,7 @@
 #include <asm/debug.h>
 #include <asm/idals.h>
 #include <asm/ebcdic.h>
+#include <asm/compat.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/cio.h>
@@ -2844,13 +2845,16 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	rc = -EFAULT;
 	if (copy_from_user(&usrparm, argp, sizeof(usrparm)))
 		goto out;
-#ifndef CONFIG_64BIT
-	/* Make sure pointers are sane even on 31 bit. */
-	if ((usrparm.psf_data >> 32) != 0 || (usrparm.rssd_result >> 32) != 0) {
+	if (is_compat_task() || sizeof(long) == 4) {
+		/* Make sure pointers are sane even on 31 bit. */
 		rc = -EINVAL;
-		goto out;
+		if ((usrparm.psf_data >> 32) != 0)
+			goto out;
+		if ((usrparm.rssd_result >> 32) != 0)
+			goto out;
+		usrparm.psf_data &= 0x7fffffffULL;
+		usrparm.rssd_result &= 0x7fffffffULL;
 	}
-#endif
 	/* alloc I/O data area */
 	psf_data = kzalloc(usrparm.psf_data_len, GFP_KERNEL | GFP_DMA);
 	rssd_result = kzalloc(usrparm.rssd_result_len, GFP_KERNEL | GFP_DMA);
diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
index 478bcdb..fc7b30b 100644
--- a/drivers/s390/block/dasd_ioctl.c
+++ b/drivers/s390/block/dasd_ioctl.c
@@ -17,7 +17,7 @@
 #include <linux/fs.h>
 #include <linux/blkpg.h>
 #include <linux/smp_lock.h>
-
+#include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/cmb.h>
 #include <asm/uaccess.h>
@@ -358,9 +358,8 @@ dasd_ioctl_set_ro(struct block_device *bdev, void __user *argp)
 }
 
 static int dasd_ioctl_readall_cmb(struct dasd_block *block, unsigned int cmd,
-		unsigned long arg)
+				  struct cmbdata __user *argp)
 {
-	struct cmbdata __user *argp = (void __user *) arg;
 	size_t size = _IOC_SIZE(cmd);
 	struct cmbdata data;
 	int ret;
@@ -376,7 +375,12 @@ dasd_do_ioctl(struct block_device *bdev, fmode_t mode,
 	      unsigned int cmd, unsigned long arg)
 {
 	struct dasd_block *block = bdev->bd_disk->private_data;
-	void __user *argp = (void __user *)arg;
+	void __user *argp;
+
+	if (is_compat_task())
+		argp = compat_ptr(arg);
+	else
+		argp = (void __user *)arg;
 
 	if (!block)
                 return -ENODEV;
@@ -414,7 +418,7 @@ dasd_do_ioctl(struct block_device *bdev, fmode_t mode,
 	case BIODASDCMFDISABLE:
 		return disable_cmf(block->base->cdev);
 	case BIODASDREADALLCMB:
-		return dasd_ioctl_readall_cmb(block, cmd, arg);
+		return dasd_ioctl_readall_cmb(block, cmd, argp);
 	default:
 		/* if the discipline has an ioctl method try it. */
 		if (block->base->discipline->ioctl) {
diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 9d61683..59ec073 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -1037,22 +1037,6 @@ static void tty3215_flush_buffer(struct tty_struct *tty)
 }
 
 /*
- * Currently we don't have any io controls for 3215 ttys
- */
-static int tty3215_ioctl(struct tty_struct *tty, struct file * file,
-			 unsigned int cmd, unsigned long arg)
-{
-	if (tty->flags & (1 << TTY_IO_ERROR))
-		return -EIO;
-
-	switch (cmd) {
-	default:
-		return -ENOIOCTLCMD;
-	}
-	return 0;
-}
-
-/*
  * Disable reading from a 3215 tty
  */
 static void tty3215_throttle(struct tty_struct * tty)
@@ -1117,7 +1101,6 @@ static const struct tty_operations tty3215_ops = {
 	.write_room = tty3215_write_room,
 	.chars_in_buffer = tty3215_chars_in_buffer,
 	.flush_buffer = tty3215_flush_buffer,
-	.ioctl = tty3215_ioctl,
 	.throttle = tty3215_throttle,
 	.unthrottle = tty3215_unthrottle,
 	.stop = tty3215_stop,
diff --git a/drivers/s390/char/fs3270.c b/drivers/s390/char/fs3270.c
index 247b2b9..31c59b0 100644
--- a/drivers/s390/char/fs3270.c
+++ b/drivers/s390/char/fs3270.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/smp_lock.h>
 
+#include <asm/compat.h>
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/ebcdic.h>
@@ -322,6 +323,7 @@ fs3270_write(struct file *filp, const char __user *data, size_t count, loff_t *o
 static long
 fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
+	char __user *argp;
 	struct fs3270 *fp;
 	struct raw3270_iocb iocb;
 	int rc;
@@ -329,6 +331,10 @@ fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	fp = filp->private_data;
 	if (!fp)
 		return -ENODEV;
+	if (is_compat_task())
+		argp = compat_ptr(arg);
+	else
+		argp = (char __user *)arg;
 	rc = 0;
 	mutex_lock(&fs3270_mutex);
 	switch (cmd) {
@@ -339,10 +345,10 @@ fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		fp->write_command = arg;
 		break;
 	case TUBGETI:
-		rc = put_user(fp->read_command, (char __user *) arg);
+		rc = put_user(fp->read_command, argp);
 		break;
 	case TUBGETO:
-		rc = put_user(fp->write_command,(char __user *) arg);
+		rc = put_user(fp->write_command, argp);
 		break;
 	case TUBGETMOD:
 		iocb.model = fp->view.model;
@@ -351,8 +357,7 @@ fs3270_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		iocb.pf_cnt = 24;
 		iocb.re_cnt = 20;
 		iocb.map = 0;
-		if (copy_to_user((char __user *) arg, &iocb,
-				 sizeof(struct raw3270_iocb)))
+		if (copy_to_user(argp, &iocb, sizeof(struct raw3270_iocb)))
 			rc = -EFAULT;
 		break;
 	}
@@ -511,8 +516,8 @@ static const struct file_operations fs3270_fops = {
 	.write		 = fs3270_write,	/* write */
 	.unlocked_ioctl	 = fs3270_ioctl,	/* ioctl */
 	.compat_ioctl	 = fs3270_ioctl,	/* ioctl */
-	.open	 	= fs3270_open,		/* open */
-	.release 	= fs3270_close,		/* release */
+	.open		 = fs3270_open,		/* open */
+	.release	 = fs3270_close,	/* release */
 };
 
 /*
diff --git a/drivers/s390/char/tape_block.c b/drivers/s390/char/tape_block.c
index 9681614..8d3d720 100644
--- a/drivers/s390/char/tape_block.c
+++ b/drivers/s390/char/tape_block.c
@@ -46,8 +46,6 @@
  */
 static int tapeblock_open(struct block_device *, fmode_t);
 static int tapeblock_release(struct gendisk *, fmode_t);
-static int tapeblock_ioctl(struct block_device *, fmode_t, unsigned int,
-				unsigned long);
 static int tapeblock_medium_changed(struct gendisk *);
 static int tapeblock_revalidate_disk(struct gendisk *);
 
@@ -55,7 +53,6 @@ static const struct block_device_operations tapeblock_fops = {
 	.owner		 = THIS_MODULE,
 	.open		 = tapeblock_open,
 	.release	 = tapeblock_release,
-	.ioctl		 = tapeblock_ioctl,
 	.media_changed   = tapeblock_medium_changed,
 	.revalidate_disk = tapeblock_revalidate_disk,
 };
@@ -416,42 +413,6 @@ tapeblock_release(struct gendisk *disk, fmode_t mode)
 }
 
 /*
- * Support of some generic block device IOCTLs.
- */
-static int
-tapeblock_ioctl(
-	struct block_device *	bdev,
-	fmode_t			mode,
-	unsigned int		command,
-	unsigned long		arg
-) {
-	int rc;
-	int minor;
-	struct gendisk *disk = bdev->bd_disk;
-	struct tape_device *device;
-
-	rc     = 0;
-	BUG_ON(!disk);
-	device = disk->private_data;
-	BUG_ON(!device);
-	minor  = MINOR(bdev->bd_dev);
-
-	DBF_LH(6, "tapeblock_ioctl(0x%0x)\n", command);
-	DBF_LH(6, "device = %d:%d\n", tapeblock_major, minor);
-
-	switch (command) {
-		/* Refuse some IOCTL calls without complaining (mount). */
-		case 0x5310:		/* CDROMMULTISESSION */
-			rc = -EINVAL;
-			break;
-		default:
-			rc = -EINVAL;
-	}
-
-	return rc;
-}
-
-/*
  * Initialize block device frontend.
  */
 int
diff --git a/drivers/s390/char/tape_char.c b/drivers/s390/char/tape_char.c
index 2125ec7..539045a 100644
--- a/drivers/s390/char/tape_char.c
+++ b/drivers/s390/char/tape_char.c
@@ -18,6 +18,7 @@
 #include <linux/proc_fs.h>
 #include <linux/mtio.h>
 #include <linux/smp_lock.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 
@@ -37,8 +38,9 @@ static ssize_t tapechar_write(struct file *, const char __user *, size_t, loff_t
 static int tapechar_open(struct inode *,struct file *);
 static int tapechar_release(struct inode *,struct file *);
 static long tapechar_ioctl(struct file *, unsigned int, unsigned long);
-static long tapechar_compat_ioctl(struct file *, unsigned int,
-			  unsigned long);
+#ifdef CONFIG_COMPAT
+static long tapechar_compat_ioctl(struct file *, unsigned int, unsigned long);
+#endif
 
 static const struct file_operations tape_fops =
 {
@@ -46,7 +48,9 @@ static const struct file_operations tape_fops =
 	.read = tapechar_read,
 	.write = tapechar_write,
 	.unlocked_ioctl = tapechar_ioctl,
+#ifdef CONFIG_COMPAT
 	.compat_ioctl = tapechar_compat_ioctl,
+#endif
 	.open = tapechar_open,
 	.release = tapechar_release,
 };
@@ -457,15 +461,22 @@ tapechar_ioctl(struct file *filp, unsigned int no, unsigned long data)
 	return rc;
 }
 
+#ifdef CONFIG_COMPAT
 static long
 tapechar_compat_ioctl(struct file *filp, unsigned int no, unsigned long data)
 {
 	struct tape_device *device = filp->private_data;
 	int rval = -ENOIOCTLCMD;
+	unsigned long argp;
 
+	/* The 'arg' argument of any ioctl function may only be used for
+	 * pointers because of the compat pointer conversion.
+	 * Consider this when adding new ioctls.
+	 */
+	argp = (unsigned long) compat_ptr(data);
 	if (device->discipline->ioctl_fn) {
 		mutex_lock(&device->mutex);
-		rval = device->discipline->ioctl_fn(device, no, data);
+		rval = device->discipline->ioctl_fn(device, no, argp);
 		mutex_unlock(&device->mutex);
 		if (rval == -EINVAL)
 			rval = -ENOIOCTLCMD;
@@ -473,6 +484,7 @@ tapechar_compat_ioctl(struct file *filp, unsigned int no, unsigned long data)
 
 	return rval;
 }
+#endif /* CONFIG_COMPAT */
 
 /*
  * Initialize character device frontend.
diff --git a/drivers/s390/char/vmcp.c b/drivers/s390/char/vmcp.c
index a6087ce..921dcda 100644
--- a/drivers/s390/char/vmcp.c
+++ b/drivers/s390/char/vmcp.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <asm/compat.h>
 #include <asm/cpcmd.h>
 #include <asm/debug.h>
 #include <asm/uaccess.h>
@@ -139,21 +140,26 @@ vmcp_write(struct file *file, const char __user *buff, size_t count,
 static long vmcp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct vmcp_session *session;
+	int __user *argp;
 	int temp;
 
 	session = (struct vmcp_session *)file->private_data;
+	if (is_compat_task())
+		argp = compat_ptr(arg);
+	else
+		argp = (int __user *)arg;
 	if (mutex_lock_interruptible(&session->mutex))
 		return -ERESTARTSYS;
 	switch (cmd) {
 	case VMCP_GETCODE:
 		temp = session->resp_code;
 		mutex_unlock(&session->mutex);
-		return put_user(temp, (int __user *)arg);
+		return put_user(temp, argp);
 	case VMCP_SETBUF:
 		free_pages((unsigned long)session->response,
 				get_order(session->bufsize));
 		session->response=NULL;
-		temp = get_user(session->bufsize, (int __user *)arg);
+		temp = get_user(session->bufsize, argp);
 		if (get_order(session->bufsize) > 8) {
 			session->bufsize = PAGE_SIZE;
 			temp = -EINVAL;
@@ -163,7 +169,7 @@ static long vmcp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case VMCP_GETSIZE:
 		temp = session->resp_size;
 		mutex_unlock(&session->mutex);
-		return put_user(temp, (int __user *)arg);
+		return put_user(temp, argp);
 	default:
 		mutex_unlock(&session->mutex);
 		return -ENOIOCTLCMD;
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index cc5144b..c84ac94 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -12,6 +12,7 @@
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 
+#include <asm/compat.h>
 #include <asm/cio.h>
 #include <asm/chsc.h>
 #include <asm/isc.h>
@@ -770,24 +771,30 @@ out_free:
 static long chsc_ioctl(struct file *filp, unsigned int cmd,
 		       unsigned long arg)
 {
+	void __user *argp;
+
 	CHSC_MSG(2, "chsc_ioctl called, cmd=%x\n", cmd);
+	if (is_compat_task())
+		argp = compat_ptr(arg);
+	else
+		argp = (void __user *)arg;
 	switch (cmd) {
 	case CHSC_START:
-		return chsc_ioctl_start((void __user *)arg);
+		return chsc_ioctl_start(argp);
 	case CHSC_INFO_CHANNEL_PATH:
-		return chsc_ioctl_info_channel_path((void __user *)arg);
+		return chsc_ioctl_info_channel_path(argp);
 	case CHSC_INFO_CU:
-		return chsc_ioctl_info_cu((void __user *)arg);
+		return chsc_ioctl_info_cu(argp);
 	case CHSC_INFO_SCH_CU:
-		return chsc_ioctl_info_sch_cu((void __user *)arg);
+		return chsc_ioctl_info_sch_cu(argp);
 	case CHSC_INFO_CI:
-		return chsc_ioctl_conf_info((void __user *)arg);
+		return chsc_ioctl_conf_info(argp);
 	case CHSC_INFO_CCL:
-		return chsc_ioctl_conf_comp_list((void __user *)arg);
+		return chsc_ioctl_conf_comp_list(argp);
 	case CHSC_INFO_CPD:
-		return chsc_ioctl_chpd((void __user *)arg);
+		return chsc_ioctl_chpd(argp);
 	case CHSC_INFO_DCAL:
-		return chsc_ioctl_dcal((void __user *)arg);
+		return chsc_ioctl_dcal(argp);
 	default: /* unknown ioctl number */
 		return -ENOIOCTLCMD;
 	}
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 0d4d18b..c68be24 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -393,10 +393,12 @@ static long zcrypt_rsa_crt(struct ica_rsa_modexpo_crt *crt)
 			 * u_mult_inv > 128 bytes.
 			 */
 			if (copied == 0) {
-				int len;
+				unsigned int len;
 				spin_unlock_bh(&zcrypt_device_lock);
 				/* len is max 256 / 2 - 120 = 8 */
 				len = crt->inputdatalength / 2 - 120;
+				if (len > sizeof(z1))
+					return -EFAULT;
 				z1 = z2 = z3 = 0;
 				if (copy_from_user(&z1, crt->np_prime, len) ||
 				    copy_from_user(&z2, crt->bp_key, len) ||
