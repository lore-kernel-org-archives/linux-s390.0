Return-Path: <linux-kernel-owner+w=401wt.eu-S1753016AbZDOQhd@vger.kernel.org>
Date: Wed, 15 Apr 2009 18:36:39 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 2.6.30-rc2
Message-ID: <20090415183639.3558763c@skybase>
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

Christian Ehrhardt (1):
      [S390] s390: move machine flags to lowcore

Cornelia Huck (1):
      [S390] dasd: Use the new async framework for autoonlining.

Gerald Schaefer (1):
      [S390] appldata: Use new mod_virt_timer_periodic() function.

Heiko Carstens (3):
      [S390] wire up preadv/pwritev system calls
      [S390] call nmi_enter/nmi_exit on machine checks
      [S390] smp: fix cpu_possible_map initialization

Jan Glauber (2):
      [S390] extend virtual timer interface by mod_virt_timer_periodic
      [S390] qdio: remove dead timeout handler

Martin Schwidefsky (5):
      [S390] stp synchronization retry timer
      [S390] fix idle time accounting
      [S390] cpu hotplug and accounting values
      [S390] add read_persistent_clock
      [S390] boot cputime accounting

Stefan Weinhuber (1):
      [S390] dasd: fix idaw boundary checking for track based ccw

 arch/s390/appldata/appldata_base.c  |    2 +-
 arch/s390/include/asm/cpuid.h       |   25 +++++++++++
 arch/s390/include/asm/kvm_host.h    |    1 +
 arch/s390/include/asm/lowcore.h     |   12 ++++--
 arch/s390/include/asm/processor.h   |   17 +------
 arch/s390/include/asm/ptrace.h      |    2 -
 arch/s390/include/asm/setup.h       |   24 +++++-----
 arch/s390/include/asm/thread_info.h |    3 +-
 arch/s390/include/asm/timer.h       |    1 +
 arch/s390/include/asm/timex.h       |    5 ++
 arch/s390/include/asm/unistd.h      |    4 +-
 arch/s390/kernel/asm-offsets.c      |    2 +
 arch/s390/kernel/compat_wrapper.S   |   18 ++++++++
 arch/s390/kernel/early.c            |   19 +++++++++
 arch/s390/kernel/entry.S            |   13 ++++++
 arch/s390/kernel/entry64.S          |   13 ++++++
 arch/s390/kernel/head.S             |   15 +++++-
 arch/s390/kernel/nmi.c              |    5 +-
 arch/s390/kernel/setup.c            |   12 ++++-
 arch/s390/kernel/smp.c              |    4 +-
 arch/s390/kernel/syscalls.S         |    2 +
 arch/s390/kernel/time.c             |   77 +++++++++++++++++++++++------------
 arch/s390/kernel/vtime.c            |   67 ++++++++++++++++--------------
 drivers/s390/block/dasd.c           |   37 +++++++++++-----
 drivers/s390/block/dasd_eckd.c      |   16 +++++--
 drivers/s390/cio/qdio_main.c        |   43 +------------------
 26 files changed, 280 insertions(+), 159 deletions(-)
 create mode 100644 arch/s390/include/asm/cpuid.h

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 27b70d8..aeb3cff 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -176,7 +176,7 @@ static void __appldata_mod_vtimer_wrap(void *p) {
 		struct vtimer_list *timer;
 		u64    expires;
 	} *args = p;
-	mod_virt_timer(args->timer, args->expires);
+	mod_virt_timer_periodic(args->timer, args->expires);
 }
 
 #define APPLDATA_ADD_TIMER	0
diff --git a/arch/s390/include/asm/cpuid.h b/arch/s390/include/asm/cpuid.h
new file mode 100644
index 0000000..07836a2
--- /dev/null
+++ b/arch/s390/include/asm/cpuid.h
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
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c6e674f..54ea39f 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -15,6 +15,7 @@
 #define ASM_KVM_HOST_H
 #include <linux/kvm_host.h>
 #include <asm/debug.h>
+#include <asm/cpuid.h>
 
 #define KVM_MAX_VCPUS 64
 #define KVM_MEMORY_SLOTS 32
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index b349f1c..3aeca49 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
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
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 61862b3..c139fa7 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
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
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index f1b0516..539263f 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -313,8 +313,6 @@ typedef struct
 
 
 #ifdef __KERNEL__
-#include <asm/setup.h>
-#include <asm/page.h>
 
 /*
  * The pt_regs struct defines the way the registers are stored on
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index e8bd6ac..38b0fc2 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
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
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index c544aa5..461f2ab 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -31,8 +31,9 @@
 #define ASYNC_SIZE  (PAGE_SIZE << ASYNC_ORDER)
 
 #ifndef __ASSEMBLY__
-#include <asm/processor.h>
 #include <asm/lowcore.h>
+#include <asm/page.h>
+#include <asm/processor.h>
 
 /*
  * low level task data that entry.S needs immediate access to
diff --git a/arch/s390/include/asm/timer.h b/arch/s390/include/asm/timer.h
index e4bcab7..814243c 100644
--- a/arch/s390/include/asm/timer.h
+++ b/arch/s390/include/asm/timer.h
@@ -41,6 +41,7 @@ extern void init_virt_timer(struct vtimer_list *timer);
 extern void add_virt_timer(void *new);
 extern void add_virt_timer_periodic(void *new);
 extern int mod_virt_timer(struct vtimer_list *timer, __u64 expires);
+extern int mod_virt_timer_periodic(struct vtimer_list *timer, __u64 expires);
 extern int del_virt_timer(struct vtimer_list *timer);
 
 extern void init_cpu_vtimer(void);
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index d744c3d..cc21e3e 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -11,6 +11,9 @@
 #ifndef _ASM_S390_TIMEX_H
 #define _ASM_S390_TIMEX_H
 
+/* The value of the TOD clock for 1.1.1970. */
+#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
+
 /* Inline functions for clock register access. */
 static inline int set_clock(__u64 time)
 {
@@ -85,4 +88,6 @@ int get_sync_clock(unsigned long long *clock);
 void init_cpu_timer(void);
 unsigned long long monotonic_clock(void);
 
+extern u64 sched_clock_base_cc;
+
 #endif
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index c8ad350..f0f19e6 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -265,7 +265,9 @@
 #define __NR_pipe2		325
 #define __NR_dup3		326
 #define __NR_epoll_create1	327
-#define NR_syscalls 328
+#define	__NR_preadv		328
+#define	__NR_pwritev		329
+#define NR_syscalls 330
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 67a6001..fa9905c 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -27,6 +27,8 @@ int main(void)
 	DEFINE(__TI_flags, offsetof(struct thread_info, flags));
 	DEFINE(__TI_cpu, offsetof(struct thread_info, cpu));
 	DEFINE(__TI_precount, offsetof(struct thread_info, preempt_count));
+	DEFINE(__TI_user_timer, offsetof(struct thread_info, user_timer));
+	DEFINE(__TI_system_timer, offsetof(struct thread_info, system_timer));
 	BLANK();
 	DEFINE(__PT_ARGS, offsetof(struct pt_regs, args));
 	DEFINE(__PT_PSW, offsetof(struct pt_regs, psw));
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index 87cf5a7..fb38af6 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1805,3 +1805,21 @@ compat_sys_keyctl_wrapper:
 	llgfr	%r5,%r5			# u32
 	llgfr	%r6,%r6			# u32
 	jg	compat_sys_keyctl	# branch to system call
+
+	.globl	compat_sys_preadv_wrapper
+compat_sys_preadv_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgtr	%r3,%r3			# compat_iovec *
+	llgfr	%r4,%r4			# unsigned long
+	llgfr	%r5,%r5			# u32
+	llgfr	%r6,%r6			# u32
+	jg	compat_sys_preadv	# branch to system call
+
+	.globl	compat_sys_pwritev_wrapper
+compat_sys_pwritev_wrapper:
+	llgfr	%r2,%r2			# unsigned long
+	llgtr	%r3,%r3			# compat_iovec *
+	llgfr	%r4,%r4			# unsigned long
+	llgfr	%r5,%r5			# u32
+	llgfr	%r6,%r6			# u32
+	jg	compat_sys_pwritev	# branch to system call
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 4d221c8..cf09948 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -34,8 +34,25 @@
 
 char kernel_nss_name[NSS_NAME_SIZE + 1];
 
+static unsigned long machine_flags;
+
 static void __init setup_boot_command_line(void);
 
+/*
+ * Get the TOD clock running.
+ */
+static void __init reset_tod_clock(void)
+{
+	u64 time;
+
+	if (store_clock(&time) == 0)
+		return;
+	/* TOD clock not running. Set the clock to Unix Epoch. */
+	if (set_clock(TOD_UNIX_EPOCH) != 0 || store_clock(&time) != 0)
+		disabled_wait(0);
+
+	sched_clock_base_cc = TOD_UNIX_EPOCH;
+}
 
 #ifdef CONFIG_SHARED_KERNEL
 int __init savesys_ipl_nss(char *cmd, const int cmdlen);
@@ -370,6 +387,7 @@ static void __init setup_boot_command_line(void)
  */
 void __init startup_init(void)
 {
+	reset_tod_clock();
 	ipl_save_parameters();
 	rescue_initrd();
 	clear_bss_section();
@@ -391,5 +409,6 @@ void __init startup_init(void)
 	setup_hpage();
 	sclp_facilities_detect();
 	detect_memory_layout(memory_chunk);
+	S390_lowcore.machine_flags = machine_flags;
 	lockdep_on();
 }
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 1268aa2..f3e2759 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -837,16 +837,29 @@ mcck_return:
 	__CPUINIT
 	.globl restart_int_handler
 restart_int_handler:
+	basr	%r1,0
+restart_base:
+	spt	restart_vtime-restart_base(%r1)
+	stck	__LC_LAST_UPDATE_CLOCK
+	mvc	__LC_LAST_UPDATE_TIMER(8),restart_vtime-restart_base(%r1)
+	mvc	__LC_EXIT_TIMER(8),restart_vtime-restart_base(%r1)
 	l	%r15,__LC_SAVE_AREA+60	# load ksp
 	lctl	%c0,%c15,__LC_CREGS_SAVE_AREA # get new ctl regs
 	lam	%a0,%a15,__LC_AREGS_SAVE_AREA
 	lm	%r6,%r15,__SF_GPRS(%r15) # load registers from clone
+	l	%r1,__LC_THREAD_INFO
+	mvc	__LC_USER_TIMER(8),__TI_user_timer(%r1)
+	mvc	__LC_SYSTEM_TIMER(8),__TI_system_timer(%r1)
+	xc	__LC_STEAL_TIMER(8),__LC_STEAL_TIMER
 	stosm	__SF_EMPTY(%r15),0x04	# now we can turn dat on
 	basr	%r14,0
 	l	%r14,restart_addr-.(%r14)
 	br	%r14			# branch to start_secondary
 restart_addr:
 	.long	start_secondary
+	.align	8
+restart_vtime:
+	.long	0x7fffffff,0xffffffff
 	.previous
 #else
 /*
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index c6fbde1..84a1058 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -831,14 +831,27 @@ mcck_return:
 	__CPUINIT
 	.globl restart_int_handler
 restart_int_handler:
+	basr	%r1,0
+restart_base:
+	spt	restart_vtime-restart_base(%r1)
+	stck	__LC_LAST_UPDATE_CLOCK
+	mvc	__LC_LAST_UPDATE_TIMER(8),restart_vtime-restart_base(%r1)
+	mvc	__LC_EXIT_TIMER(8),restart_vtime-restart_base(%r1)
 	lg	%r15,__LC_SAVE_AREA+120 # load ksp
 	lghi	%r10,__LC_CREGS_SAVE_AREA
 	lctlg	%c0,%c15,0(%r10) # get new ctl regs
 	lghi	%r10,__LC_AREGS_SAVE_AREA
 	lam	%a0,%a15,0(%r10)
 	lmg	%r6,%r15,__SF_GPRS(%r15) # load registers from clone
+	lg	%r1,__LC_THREAD_INFO
+	mvc	__LC_USER_TIMER(8),__TI_user_timer(%r1)
+	mvc	__LC_SYSTEM_TIMER(8),__TI_system_timer(%r1)
+	xc	__LC_STEAL_TIMER(8),__LC_STEAL_TIMER
 	stosm	__SF_EMPTY(%r15),0x04	# now we can turn dat on
 	jg	start_secondary
+	.align	8
+restart_vtime:
+	.long	0x7fffffff,0xffffffff
 	.previous
 #else
 /*
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
index 1046c2c..bba1449 100644
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -471,7 +471,12 @@ startup:basr	%r13,0			# get base
 .LPG0:
 	xc	0x200(256),0x200	# partially clear lowcore
 	xc	0x300(256),0x300
-
+	l	%r1,5f-.LPG0(%r13)
+	stck	0(%r1)
+	spt	6f-.LPG0(%r13)
+	mvc	__LC_LAST_UPDATE_CLOCK(8),0(%r1)
+	mvc	__LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
+	mvc	__LC_EXIT_TIMER(8),5f-.LPG0(%r13)
 #ifndef CONFIG_MARCH_G5
 	# check processor version against MARCH_{G5,Z900,Z990,Z9_109,Z10}
 	stidp	__LC_CPUID		# store cpuid
@@ -496,9 +501,13 @@ startup:basr	%r13,0			# get base
 	brct	%r0,0b
 #endif
 
-	l	%r13,0f-.LPG0(%r13)
+	l	%r13,4f-.LPG0(%r13)
 	b	0(%r13)
-0:	.long	startup_continue
+	.align	4
+4:	.long	startup_continue
+5:	.long	sched_clock_base_cc
+	.align	8
+6:	.long	0x7fffffff,0xffffffff
 
 #
 # params at 10400 (setup.h)
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 4bfdc42..28cf196 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -10,6 +10,7 @@
 
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/hardirq.h>
 #include <linux/time.h>
 #include <linux/module.h>
 #include <asm/lowcore.h>
@@ -253,7 +254,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 	struct mci *mci;
 	int umode;
 
-	lockdep_off();
+	nmi_enter();
 	s390_idle_check();
 
 	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
@@ -363,7 +364,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 		mcck->warning = 1;
 		set_thread_flag(TIF_MCCK_PENDING);
 	}
-	lockdep_on();
+	nmi_exit();
 }
 
 static int __init machine_check_init(void)
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 06201b9..7402b6a 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
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
@@ -436,6 +434,14 @@ setup_lowcore(void)
 #else
 	lc->vdso_per_cpu_data = (unsigned long) &lc->paste[0];
 #endif
+	lc->sync_enter_timer = S390_lowcore.sync_enter_timer;
+	lc->async_enter_timer = S390_lowcore.async_enter_timer;
+	lc->exit_timer = S390_lowcore.exit_timer;
+	lc->user_timer = S390_lowcore.user_timer;
+	lc->system_timer = S390_lowcore.system_timer;
+	lc->steal_timer = S390_lowcore.steal_timer;
+	lc->last_update_timer = S390_lowcore.last_update_timer;
+	lc->last_update_clock = S390_lowcore.last_update_clock;
 	set_prefix((u32)(unsigned long) lc);
 	lowcore_ptr[0] = lc;
 }
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 006ed50..a985a3b 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -571,6 +571,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	cpu_lowcore->current_task = (unsigned long) idle;
 	cpu_lowcore->cpu_nr = cpu;
 	cpu_lowcore->kernel_asce = S390_lowcore.kernel_asce;
+	cpu_lowcore->machine_flags = S390_lowcore.machine_flags;
 	eieio();
 
 	while (signal_processor(cpu, sigp_restart) == sigp_busy)
@@ -590,7 +591,8 @@ static int __init setup_possible_cpus(char *s)
 	int pcpus, cpu;
 
 	pcpus = simple_strtoul(s, NULL, 0);
-	for (cpu = 0; cpu < pcpus && cpu < nr_cpu_ids; cpu++)
+	init_cpu_possible(cpumask_of(0));
+	for (cpu = 1; cpu < pcpus && cpu < nr_cpu_ids; cpu++)
 		set_cpu_possible(cpu, true);
 	return 0;
 }
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index fe5b25a..2c7739f 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -336,3 +336,5 @@ SYSCALL(sys_inotify_init1,sys_inotify_init1,sys_inotify_init1_wrapper)
 SYSCALL(sys_pipe2,sys_pipe2,sys_pipe2_wrapper) /* 325 */
 SYSCALL(sys_dup3,sys_dup3,sys_dup3_wrapper)
 SYSCALL(sys_epoll_create1,sys_epoll_create1,sys_epoll_create1_wrapper)
+SYSCALL(sys_preadv,sys_preadv,compat_sys_preadv_wrapper)
+SYSCALL(sys_pwritev,sys_pwritev,compat_sys_pwritev_wrapper)
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index f72d410..6ded50d 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -52,9 +52,6 @@
 #define USECS_PER_JIFFY     ((unsigned long) 1000000/HZ)
 #define CLK_TICKS_PER_JIFFY ((unsigned long) USECS_PER_JIFFY << 12)
 
-/* The value of the TOD clock for 1.1.1970. */
-#define TOD_UNIX_EPOCH 0x7d91048bca000000ULL
-
 /*
  * Create a small time difference between the timer interrupts
  * on the different cpus to avoid lock contention.
@@ -63,9 +60,10 @@
 
 #define TICK_SIZE tick
 
+u64 sched_clock_base_cc = -1;	/* Force to data section. */
+
 static ext_int_info_t ext_int_info_cc;
 static ext_int_info_t ext_int_etr_cc;
-static u64 sched_clock_base_cc;
 
 static DEFINE_PER_CPU(struct clock_event_device, comparators);
 
@@ -195,22 +193,12 @@ static void timing_alert_interrupt(__u16 code)
 static void etr_reset(void);
 static void stp_reset(void);
 
-/*
- * Get the TOD clock running.
- */
-static u64 __init reset_tod_clock(void)
+unsigned long read_persistent_clock(void)
 {
-	u64 time;
-
-	etr_reset();
-	stp_reset();
-	if (store_clock(&time) == 0)
-		return time;
-	/* TOD clock not running. Set the clock to Unix Epoch. */
-	if (set_clock(TOD_UNIX_EPOCH) != 0 || store_clock(&time) != 0)
-		panic("TOD clock not operational.");
+	struct timespec ts;
 
-	return TOD_UNIX_EPOCH;
+	tod_to_timeval(get_clock() - TOD_UNIX_EPOCH, &ts);
+	return ts.tv_sec;
 }
 
 static cycle_t read_tod_clock(void)
@@ -265,12 +253,13 @@ void update_vsyscall_tz(void)
  */
 void __init time_init(void)
 {
-	sched_clock_base_cc = reset_tod_clock();
+	struct timespec ts;
+	unsigned long flags;
+	cycle_t now;
 
-	/* set xtime */
-	tod_to_timeval(sched_clock_base_cc - TOD_UNIX_EPOCH, &xtime);
-        set_normalized_timespec(&wall_to_monotonic,
-                                -xtime.tv_sec, -xtime.tv_nsec);
+	/* Reset time synchronization interfaces. */
+	etr_reset();
+	stp_reset();
 
 	/* request the clock comparator external interrupt */
 	if (register_early_external_interrupt(0x1004,
@@ -278,17 +267,38 @@ void __init time_init(void)
 					      &ext_int_info_cc) != 0)
                 panic("Couldn't request external interrupt 0x1004");
 
-	if (clocksource_register(&clocksource_tod) != 0)
-		panic("Could not register TOD clock source");
-
 	/* request the timing alert external interrupt */
 	if (register_early_external_interrupt(0x1406,
 					      timing_alert_interrupt,
 					      &ext_int_etr_cc) != 0)
 		panic("Couldn't request external interrupt 0x1406");
 
+	if (clocksource_register(&clocksource_tod) != 0)
+		panic("Could not register TOD clock source");
+
+	/*
+	 * The TOD clock is an accurate clock. The xtime should be
+	 * initialized in a way that the difference between TOD and
+	 * xtime is reasonably small. Too bad that timekeeping_init
+	 * sets xtime.tv_nsec to zero. In addition the clock source
+	 * change from the jiffies clock source to the TOD clock
+	 * source add another error of up to 1/HZ second. The same
+	 * function sets wall_to_monotonic to a value that is too
+	 * small for /proc/uptime to be accurate.
+	 * Reset xtime and wall_to_monotonic to sane values.
+	 */
+	write_seqlock_irqsave(&xtime_lock, flags);
+	now = get_clock();
+	tod_to_timeval(now - TOD_UNIX_EPOCH, &xtime);
+	clocksource_tod.cycle_last = now;
+	clocksource_tod.raw_time = xtime;
+	tod_to_timeval(sched_clock_base_cc - TOD_UNIX_EPOCH, &ts);
+	set_normalized_timespec(&wall_to_monotonic, -ts.tv_sec, -ts.tv_nsec);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
 	/* Enable TOD clock interrupts on the boot cpu. */
 	init_cpu_timer();
+
 	/* Enable cpu timer interrupts on the boot cpu. */
 	vtime_init();
 }
@@ -1423,6 +1433,7 @@ static void *stp_page;
 static void stp_work_fn(struct work_struct *work);
 static DEFINE_MUTEX(stp_work_mutex);
 static DECLARE_WORK(stp_work, stp_work_fn);
+static struct timer_list stp_timer;
 
 static int __init early_parse_stp(char *p)
 {
@@ -1454,10 +1465,16 @@ static void __init stp_reset(void)
 	}
 }
 
+static void stp_timeout(unsigned long dummy)
+{
+	queue_work(time_sync_wq, &stp_work);
+}
+
 static int __init stp_init(void)
 {
 	if (!test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags))
 		return 0;
+	setup_timer(&stp_timer, stp_timeout, 0UL);
 	time_init_wq();
 	if (!stp_online)
 		return 0;
@@ -1565,6 +1582,7 @@ static void stp_work_fn(struct work_struct *work)
 
 	if (!stp_online) {
 		chsc_sstpc(stp_page, STP_OP_CTRL, 0x0000);
+		del_timer_sync(&stp_timer);
 		goto out_unlock;
 	}
 
@@ -1586,6 +1604,13 @@ static void stp_work_fn(struct work_struct *work)
 	stop_machine(stp_sync_clock, &stp_sync, &cpu_online_map);
 	put_online_cpus();
 
+	if (!check_sync_clock())
+		/*
+		 * There is a usable clock but the synchonization failed.
+		 * Retry after a second.
+		 */
+		mod_timer(&stp_timer, jiffies + HZ);
+
 out_unlock:
 	mutex_unlock(&stp_work_mutex);
 }
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index ecf0304..38ea92f 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -134,6 +134,8 @@ void vtime_start_cpu(void)
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	idle_time = S390_lowcore.int_clock - idle->idle_enter;
 	account_idle_time(idle_time);
+	S390_lowcore.steal_timer +=
+		idle->idle_enter - S390_lowcore.last_update_clock;
 	S390_lowcore.last_update_clock = S390_lowcore.int_clock;
 
 	/* Account system time spent going idle. */
@@ -425,17 +427,7 @@ void add_virt_timer_periodic(void *new)
 }
 EXPORT_SYMBOL(add_virt_timer_periodic);
 
-/*
- * If we change a pending timer the function must be called on the CPU
- * where the timer is running on, e.g. by smp_call_function_single()
- *
- * The original mod_timer adds the timer if it is not pending. For
- * compatibility we do the same. The timer will be added on the current
- * CPU as a oneshot timer.
- *
- * returns whether it has modified a pending timer (1) or not (0)
- */
-int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
+int __mod_vtimer(struct vtimer_list *timer, __u64 expires, int periodic)
 {
 	struct vtimer_queue *vq;
 	unsigned long flags;
@@ -444,39 +436,35 @@ int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
 	BUG_ON(!timer->function);
 	BUG_ON(!expires || expires > VTIMER_MAX_SLICE);
 
-	/*
-	 * This is a common optimization triggered by the
-	 * networking code - if the timer is re-modified
-	 * to be the same thing then just return:
-	 */
 	if (timer->expires == expires && vtimer_pending(timer))
 		return 1;
 
 	cpu = get_cpu();
 	vq = &per_cpu(virt_cpu_timer, cpu);
 
-	/* check if we run on the right CPU */
-	BUG_ON(timer->cpu != cpu);
-
 	/* disable interrupts before test if timer is pending */
 	spin_lock_irqsave(&vq->lock, flags);
 
 	/* if timer isn't pending add it on the current CPU */
 	if (!vtimer_pending(timer)) {
 		spin_unlock_irqrestore(&vq->lock, flags);
-		/* we do not activate an interval timer with mod_virt_timer */
-		timer->interval = 0;
+
+		if (periodic)
+			timer->interval = expires;
+		else
+			timer->interval = 0;
 		timer->expires = expires;
 		timer->cpu = cpu;
 		internal_add_vtimer(timer);
 		return 0;
 	}
 
+	/* check if we run on the right CPU */
+	BUG_ON(timer->cpu != cpu);
+
 	list_del_init(&timer->entry);
 	timer->expires = expires;
-
-	/* also change the interval if we have an interval timer */
-	if (timer->interval)
+	if (periodic)
 		timer->interval = expires;
 
 	/* the timer can't expire anymore so we can release the lock */
@@ -484,9 +472,32 @@ int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
 	internal_add_vtimer(timer);
 	return 1;
 }
+
+/*
+ * If we change a pending timer the function must be called on the CPU
+ * where the timer is running on.
+ *
+ * returns whether it has modified a pending timer (1) or not (0)
+ */
+int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
+{
+	return __mod_vtimer(timer, expires, 0);
+}
 EXPORT_SYMBOL(mod_virt_timer);
 
 /*
+ * If we change a pending timer the function must be called on the CPU
+ * where the timer is running on.
+ *
+ * returns whether it has modified a pending timer (1) or not (0)
+ */
+int mod_virt_timer_periodic(struct vtimer_list *timer, __u64 expires)
+{
+	return __mod_vtimer(timer, expires, 1);
+}
+EXPORT_SYMBOL(mod_virt_timer_periodic);
+
+/*
  * delete a virtual timer
  *
  * returns whether the deleted timer was pending (1) or not (0)
@@ -516,16 +527,8 @@ EXPORT_SYMBOL(del_virt_timer);
  */
 void init_cpu_vtimer(void)
 {
-	struct thread_info *ti = current_thread_info();
 	struct vtimer_queue *vq;
 
-	S390_lowcore.user_timer = ti->user_timer;
-	S390_lowcore.system_timer = ti->system_timer;
-
-	/* kick the virtual timer */
-	asm volatile ("STCK %0" : "=m" (S390_lowcore.last_update_clock));
-	asm volatile ("STPT %0" : "=m" (S390_lowcore.last_update_timer));
-
 	/* initialize per cpu vtimer structure */
 	vq = &__get_cpu_var(virt_cpu_timer);
 	INIT_LIST_HEAD(&vq->list);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0570794..d181527 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -20,6 +20,7 @@
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
 #include <linux/hdreg.h>
+#include <linux/async.h>
 
 #include <asm/ccwdev.h>
 #include <asm/ebcdic.h>
@@ -480,8 +481,10 @@ static void dasd_change_state(struct dasd_device *device)
         if (rc && rc != -EAGAIN)
                 device->target = device->state;
 
-	if (device->state == device->target)
+	if (device->state == device->target) {
 		wake_up(&dasd_init_waitq);
+		dasd_put_device(device);
+	}
 
 	/* let user-space know that the device status changed */
 	kobject_uevent(&device->cdev->dev.kobj, KOBJ_CHANGE);
@@ -513,12 +516,15 @@ void dasd_kick_device(struct dasd_device *device)
  */
 void dasd_set_target_state(struct dasd_device *device, int target)
 {
+	dasd_get_device(device);
 	/* If we are in probeonly mode stop at DASD_STATE_READY. */
 	if (dasd_probeonly && target > DASD_STATE_READY)
 		target = DASD_STATE_READY;
 	if (device->target != target) {
-                if (device->state == target)
+		if (device->state == target) {
 			wake_up(&dasd_init_waitq);
+			dasd_put_device(device);
+		}
 		device->target = target;
 	}
 	if (device->state != device->target)
@@ -2148,6 +2154,22 @@ dasd_exit(void)
  * SECTION: common functions for ccw_driver use
  */
 
+static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
+{
+	struct ccw_device *cdev = data;
+	int ret;
+
+	ret = ccw_device_set_online(cdev);
+	if (ret)
+		pr_warning("%s: Setting the DASD online failed with rc=%d\n",
+			   dev_name(&cdev->dev), ret);
+	else {
+		struct dasd_device *device = dasd_device_from_cdev(cdev);
+		wait_event(dasd_init_waitq, _wait_for_device(device));
+		dasd_put_device(device);
+	}
+}
+
 /*
  * Initial attempt at a probe function. this can be simplified once
  * the other detection code is gone.
@@ -2180,10 +2202,7 @@ int dasd_generic_probe(struct ccw_device *cdev,
 	 */
 	if ((dasd_get_feature(cdev, DASD_FEATURE_INITIAL_ONLINE) > 0 ) ||
 	    (dasd_autodetect && dasd_busid_known(dev_name(&cdev->dev)) != 0))
-		ret = ccw_device_set_online(cdev);
-	if (ret)
-		pr_warning("%s: Setting the DASD online failed with rc=%d\n",
-		       dev_name(&cdev->dev), ret);
+		async_schedule(dasd_generic_auto_online, cdev);
 	return 0;
 }
 
@@ -2290,13 +2309,7 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	} else
 		pr_debug("dasd_generic device %s found\n",
 				dev_name(&cdev->dev));
-
-	/* FIXME: we have to wait for the root device but we don't want
-	 * to wait for each single device but for all at once. */
-	wait_event(dasd_init_waitq, _wait_for_device(device));
-
 	dasd_put_device(device);
-
 	return rc;
 }
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 2125479..cb52da0 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2019,15 +2019,23 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 				ccw++;
 				recid += count;
 				new_track = 0;
+				/* first idaw for a ccw may start anywhere */
+				if (!idaw_dst)
+					idaw_dst = dst;
 			}
-			/* If we start a new idaw, everything is fine and the
-			 * start of the new idaw is the start of this segment.
+			/* If we start a new idaw, we must make sure that it
+			 * starts on an IDA_BLOCK_SIZE boundary.
 			 * If we continue an idaw, we must make sure that the
 			 * current segment begins where the so far accumulated
 			 * idaw ends
 			 */
-			if (!idaw_dst)
-				idaw_dst = dst;
+			if (!idaw_dst) {
+				if (__pa(dst) & (IDA_BLOCK_SIZE-1)) {
+					dasd_sfree_request(cqr, startdev);
+					return ERR_PTR(-ERANGE);
+				} else
+					idaw_dst = dst;
+			}
 			if ((idaw_dst + idaw_len) != dst) {
 				dasd_sfree_request(cqr, startdev);
 				return ERR_PTR(-ERANGE);
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index 9e8a291..accd957 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -881,42 +881,6 @@ no_handler:
 	qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
 }
 
-static void qdio_call_shutdown(struct work_struct *work)
-{
-	struct ccw_device_private *priv;
-	struct ccw_device *cdev;
-
-	priv = container_of(work, struct ccw_device_private, kick_work);
-	cdev = priv->cdev;
-	qdio_shutdown(cdev, QDIO_FLAG_CLEANUP_USING_CLEAR);
-	put_device(&cdev->dev);
-}
-
-static void qdio_int_error(struct ccw_device *cdev)
-{
-	struct qdio_irq *irq_ptr = cdev->private->qdio_data;
-
-	switch (irq_ptr->state) {
-	case QDIO_IRQ_STATE_INACTIVE:
-	case QDIO_IRQ_STATE_CLEANUP:
-		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
-		break;
-	case QDIO_IRQ_STATE_ESTABLISHED:
-	case QDIO_IRQ_STATE_ACTIVE:
-		qdio_set_state(irq_ptr, QDIO_IRQ_STATE_STOPPED);
-		if (get_device(&cdev->dev)) {
-			/* Can't call shutdown from interrupt context. */
-			PREPARE_WORK(&cdev->private->kick_work,
-				     qdio_call_shutdown);
-			queue_work(ccw_device_work, &cdev->private->kick_work);
-		}
-		break;
-	default:
-		WARN_ON(1);
-	}
-	wake_up(&cdev->private->wait_q);
-}
-
 static int qdio_establish_check_errors(struct ccw_device *cdev, int cstat,
 				       int dstat)
 {
@@ -973,10 +937,8 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 		switch (PTR_ERR(irb)) {
 		case -EIO:
 			DBF_ERROR("%4x IO error", irq_ptr->schid.sch_no);
-			return;
-		case -ETIMEDOUT:
-			DBF_ERROR("%4x IO timeout", irq_ptr->schid.sch_no);
-			qdio_int_error(cdev);
+			qdio_set_state(irq_ptr, QDIO_IRQ_STATE_ERR);
+			wake_up(&cdev->private->wait_q);
 			return;
 		default:
 			WARN_ON(1);
@@ -1001,7 +963,6 @@ void qdio_int_handler(struct ccw_device *cdev, unsigned long intparm,
 	case QDIO_IRQ_STATE_ACTIVE:
 		if (cstat & SCHN_STAT_PCI) {
 			qdio_int_handler_pci(irq_ptr);
-			/* no state change so no need to wake up wait_q */
 			return;
 		}
 		if ((cstat & ~SCHN_STAT_PCI) || dstat) {
