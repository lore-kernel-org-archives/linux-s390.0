Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 18 Dec 2020 19:53:12 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: [GIT PULL] more s390 updates for 5.11 merge window
Message-ID: <20201218185312.GA5261@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-s390.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

please pull some more small updates for s390. This is mainly to
decouple udelay() and arch_cpu_idle() and simplify both of them,
like I brought it up after the lockdep breakage in 5.10-rc6.

Thanks,
Heiko

The following changes since commit 586592478b1fa8bb8cd6875a9191468e9b1a8b13:

  Merge tag 's390-5.11-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2020-12-14 16:22:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.11-2

for you to fetch changes up to dfdc6e73cdcf011a04568231132916c6d06b861f:

  s390/zcrypt: convert comma to semicolon (2020-12-16 14:55:50 +0100)

----------------------------------------------------------------
- Always initialize kernel stack backchain when entering the kernel, so
  that unwinding works properly.

- Fix stack  unwinder test case to avoid rare interrupt stack corruption.

- Simplify udelay() and just let it busy loop instead of implementing a
  complex logic.

- arch_cpu_idle() cleanup.

- Some other minor improvements.

----------------------------------------------------------------
Heiko Carstens (10):
      s390: always clear kernel stack backchain before calling functions
      s390: make calls to TRACE_IRQS_OFF/TRACE_IRQS_ON balanced
      s390/test_unwind: fix CALL_ON_STACK tests
      s390/test_unwind: use timer instead of udelay
      s390/delay: simplify udelay
      s390/irq: select HAVE_IRQ_EXIT_ON_IRQ_STACK
      s390/delay: remove udelay_simple()
      s390/idle: merge enabled_wait() and arch_cpu_idle()
      s390/idle: remove raw_local_irq_save()/restore() from arch_cpu_idle()
      s390/idle: allow arch_cpu_idle() to be kprobed

Zheng Yongjun (1):
      s390/zcrypt: convert comma to semicolon

 arch/s390/Kconfig                  |   1 +
 arch/s390/include/asm/delay.h      |  12 ++---
 arch/s390/include/asm/processor.h  |   7 ---
 arch/s390/kernel/entry.S           |  16 +++---
 arch/s390/kernel/idle.c            |  18 ++-----
 arch/s390/kernel/ipl.c             |   2 +-
 arch/s390/kernel/setup.c           |   1 -
 arch/s390/lib/delay.c              | 105 ++++---------------------------------
 arch/s390/lib/test_unwind.c        |  31 ++++++-----
 drivers/s390/cio/device.c          |   2 +-
 drivers/s390/crypto/zcrypt_cex2a.c |   2 +-
 drivers/s390/crypto/zcrypt_cex4.c  |   2 +-
 12 files changed, 44 insertions(+), 155 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index a60cc523d810..9e8895cb9ee7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -153,6 +153,7 @@ config S390
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO
+	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_KERNEL_BZIP2
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZ4
diff --git a/arch/s390/include/asm/delay.h b/arch/s390/include/asm/delay.h
index 4a08379cd1eb..21a8fe18fe66 100644
--- a/arch/s390/include/asm/delay.h
+++ b/arch/s390/include/asm/delay.h
@@ -13,14 +13,12 @@
 #ifndef _S390_DELAY_H
 #define _S390_DELAY_H
 
-void udelay_enable(void);
-void __ndelay(unsigned long long nsecs);
-void __udelay(unsigned long long usecs);
-void udelay_simple(unsigned long long usecs);
+void __ndelay(unsigned long nsecs);
+void __udelay(unsigned long usecs);
 void __delay(unsigned long loops);
 
-#define ndelay(n) __ndelay((unsigned long long) (n))
-#define udelay(n) __udelay((unsigned long long) (n))
-#define mdelay(n) __udelay((unsigned long long) (n) * 1000)
+#define ndelay(n) __ndelay((unsigned long)(n))
+#define udelay(n) __udelay((unsigned long)(n))
+#define mdelay(n) __udelay((unsigned long)(n) * 1000)
 
 #endif /* defined(_S390_DELAY_H) */
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 6b7269f51f83..2058a435add4 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -16,14 +16,12 @@
 
 #define CIF_NOHZ_DELAY		2	/* delay HZ disable for a tick */
 #define CIF_FPU			3	/* restore FPU registers */
-#define CIF_IGNORE_IRQ		4	/* ignore interrupt (for udelay) */
 #define CIF_ENABLED_WAIT	5	/* in enabled wait state */
 #define CIF_MCCK_GUEST		6	/* machine check happening in guest */
 #define CIF_DEDICATED_CPU	7	/* this CPU is dedicated */
 
 #define _CIF_NOHZ_DELAY		BIT(CIF_NOHZ_DELAY)
 #define _CIF_FPU		BIT(CIF_FPU)
-#define _CIF_IGNORE_IRQ		BIT(CIF_IGNORE_IRQ)
 #define _CIF_ENABLED_WAIT	BIT(CIF_ENABLED_WAIT)
 #define _CIF_MCCK_GUEST		BIT(CIF_MCCK_GUEST)
 #define _CIF_DEDICATED_CPU	BIT(CIF_DEDICATED_CPU)
@@ -292,11 +290,6 @@ static inline unsigned long __rewind_psw(psw_t psw, unsigned long ilc)
 	return (psw.addr - ilc) & mask;
 }
 
-/*
- * Function to stop a processor until the next interrupt occurs
- */
-void enabled_wait(void);
-
 /*
  * Function to drop a processor into disabled wait state
  */
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 8bb9ebb71c4b..87e83164c330 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -413,6 +413,7 @@ ENTRY(system_call)
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
 	stg	%r14,__PT_FLAGS(%r11)
+	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	ENABLE_INTS
 .Lsysc_do_svc:
 	# clear user controlled register to prevent speculative use
@@ -429,7 +430,6 @@ ENTRY(system_call)
 	jnl	.Lsysc_nr_ok
 	slag	%r8,%r1,3
 .Lsysc_nr_ok:
-	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	stg	%r2,__PT_ORIG_GPR2(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
 	lg	%r9,0(%r8,%r10)			# get system call add.
@@ -698,8 +698,8 @@ ENTRY(pgm_check_handler)
 	mvc	__THREAD_per_address(8,%r14),__LC_PER_ADDRESS
 	mvc	__THREAD_per_cause(2,%r14),__LC_PER_CODE
 	mvc	__THREAD_per_paid(1,%r14),__LC_PER_ACCESS_ID
-6:	RESTORE_SM_CLEAR_PER
-	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+6:	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+	RESTORE_SM_CLEAR_PER
 	larl	%r1,pgm_check_table
 	llgh	%r10,__PT_INT_CODE+2(%r11)
 	nill	%r10,0x007f
@@ -730,8 +730,8 @@ ENTRY(pgm_check_handler)
 # PER event in supervisor state, must be kprobes
 #
 .Lpgm_kprobe:
-	RESTORE_SM_CLEAR_PER
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+	RESTORE_SM_CLEAR_PER
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	brasl	%r14,do_per_trap
 	j	.Lpgm_return
@@ -777,10 +777,8 @@ ENTRY(io_int_handler)
 .Lio_skip_asce:
 	mvc	__PT_INT_CODE(12,%r11),__LC_SUBCHANNEL_ID
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
-	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
-	jo	.Lio_restore
-	TRACE_IRQS_OFF
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+	TRACE_IRQS_OFF
 .Lio_loop:
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,IO_INTERRUPT
@@ -965,10 +963,8 @@ ENTRY(ext_int_handler)
 	mvc	__PT_INT_PARM(4,%r11),__LC_EXT_PARAMS
 	mvc	__PT_INT_PARM_LONG(8,%r11),0(%r1)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
-	TSTMSK	__LC_CPU_FLAGS,_CIF_IGNORE_IRQ
-	jo	.Lio_restore
-	TRACE_IRQS_OFF
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
+	TRACE_IRQS_OFF
 	lgr	%r2,%r11		# pass pointer to pt_regs
 	lghi	%r3,EXT_INTERRUPT
 	brasl	%r14,do_IRQ
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index 2b85096964f8..a5d4d80d6ede 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -9,7 +9,6 @@
 
 #include <linux/kernel.h>
 #include <linux/kernel_stat.h>
-#include <linux/kprobes.h>
 #include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
@@ -21,22 +20,19 @@
 
 static DEFINE_PER_CPU(struct s390_idle_data, s390_idle);
 
-void enabled_wait(void)
+void arch_cpu_idle(void)
 {
 	struct s390_idle_data *idle = this_cpu_ptr(&s390_idle);
 	unsigned long long idle_time;
-	unsigned long psw_mask, flags;
-
+	unsigned long psw_mask;
 
 	/* Wait for external, I/O or machine check interrupt. */
 	psw_mask = PSW_KERNEL_BITS | PSW_MASK_WAIT | PSW_MASK_DAT |
 		PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK;
 	clear_cpu_flag(CIF_NOHZ_DELAY);
 
-	raw_local_irq_save(flags);
-	/* Call the assembler magic in entry.S */
+	/* psw_idle() returns with interrupts disabled. */
 	psw_idle(idle, psw_mask);
-	raw_local_irq_restore(flags);
 
 	/* Account time spent with enabled wait psw loaded as idle time. */
 	raw_write_seqcount_begin(&idle->seqcount);
@@ -46,8 +42,8 @@ void enabled_wait(void)
 	idle->idle_count++;
 	account_idle_time(cputime_to_nsecs(idle_time));
 	raw_write_seqcount_end(&idle->seqcount);
+	raw_local_irq_enable();
 }
-NOKPROBE_SYMBOL(enabled_wait);
 
 static ssize_t show_idle_count(struct device *dev,
 				struct device_attribute *attr, char *buf)
@@ -120,12 +116,6 @@ void arch_cpu_idle_enter(void)
 {
 }
 
-void arch_cpu_idle(void)
-{
-	enabled_wait();
-	raw_local_irq_enable();
-}
-
 void arch_cpu_idle_exit(void)
 {
 }
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 98b3aca1de8e..7a21eca498aa 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1512,7 +1512,7 @@ static void diag308_dump(void *dump_block)
 	while (1) {
 		if (diag308(DIAG308_LOAD_NORMAL_DUMP, NULL) != 0x302)
 			break;
-		udelay_simple(USEC_PER_SEC);
+		udelay(USEC_PER_SEC);
 	}
 }
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 1f16a03be995..1fbed91c73bc 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -335,7 +335,6 @@ int __init arch_early_irq_init(void)
 	if (!stack)
 		panic("Couldn't allocate async stack");
 	S390_lowcore.async_stack = stack + STACK_INIT_OFFSET;
-	udelay_enable();
 	return 0;
 }
 
diff --git a/arch/s390/lib/delay.c b/arch/s390/lib/delay.c
index 68d61f2835df..f289afeb3f31 100644
--- a/arch/s390/lib/delay.c
+++ b/arch/s390/lib/delay.c
@@ -19,13 +19,6 @@
 #include <asm/div64.h>
 #include <asm/idle.h>
 
-static DEFINE_STATIC_KEY_FALSE(udelay_ready);
-
-void __init udelay_enable(void)
-{
-	static_branch_enable(&udelay_ready);
-}
-
 void __delay(unsigned long loops)
 {
         /*
@@ -39,105 +32,25 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-static void __udelay_disabled(unsigned long long usecs)
+static void delay_loop(unsigned long delta)
 {
-	unsigned long cr0, cr0_new, psw_mask;
-	struct s390_idle_data idle;
-	u64 end;
+	unsigned long end;
 
-	end = get_tod_clock() + (usecs << 12);
-	__ctl_store(cr0, 0, 0);
-	cr0_new = cr0 & ~CR0_IRQ_SUBCLASS_MASK;
-	cr0_new |= (1UL << (63 - 52)); /* enable clock comparator irq */
-	__ctl_load(cr0_new, 0, 0);
-	psw_mask = __extract_psw() | PSW_MASK_EXT | PSW_MASK_WAIT;
-	set_clock_comparator(end);
-	set_cpu_flag(CIF_IGNORE_IRQ);
-	psw_idle(&idle, psw_mask);
-	trace_hardirqs_off();
-	clear_cpu_flag(CIF_IGNORE_IRQ);
-	set_clock_comparator(S390_lowcore.clock_comparator);
-	__ctl_load(cr0, 0, 0);
+	end = get_tod_clock_monotonic() + delta;
+	while (!tod_after(get_tod_clock_monotonic(), end))
+		cpu_relax();
 }
 
-static void __udelay_enabled(unsigned long long usecs)
+void __udelay(unsigned long usecs)
 {
-	u64 clock_saved, end;
-
-	end = get_tod_clock_fast() + (usecs << 12);
-	do {
-		clock_saved = 0;
-		if (tod_after(S390_lowcore.clock_comparator, end)) {
-			clock_saved = local_tick_disable();
-			set_clock_comparator(end);
-		}
-		enabled_wait();
-		if (clock_saved)
-			local_tick_enable(clock_saved);
-	} while (get_tod_clock_fast() < end);
-}
-
-/*
- * Waits for 'usecs' microseconds using the TOD clock comparator.
- */
-void __udelay(unsigned long long usecs)
-{
-	unsigned long flags;
-
-	if (!static_branch_likely(&udelay_ready)) {
-		udelay_simple(usecs);
-		return;
-	}
-
-	preempt_disable();
-	local_irq_save(flags);
-	if (in_irq()) {
-		__udelay_disabled(usecs);
-		goto out;
-	}
-	if (in_softirq()) {
-		if (raw_irqs_disabled_flags(flags))
-			__udelay_disabled(usecs);
-		else
-			__udelay_enabled(usecs);
-		goto out;
-	}
-	if (raw_irqs_disabled_flags(flags)) {
-		local_bh_disable();
-		__udelay_disabled(usecs);
-		_local_bh_enable();
-		goto out;
-	}
-	__udelay_enabled(usecs);
-out:
-	local_irq_restore(flags);
-	preempt_enable();
+	delay_loop(usecs << 12);
 }
 EXPORT_SYMBOL(__udelay);
 
-/*
- * Simple udelay variant. To be used on startup and reboot
- * when the interrupt handler isn't working.
- */
-void udelay_simple(unsigned long long usecs)
-{
-	u64 end;
-
-	end = get_tod_clock_fast() + (usecs << 12);
-	while (get_tod_clock_fast() < end)
-		cpu_relax();
-}
-
-void __ndelay(unsigned long long nsecs)
+void __ndelay(unsigned long nsecs)
 {
-	u64 end;
-
 	nsecs <<= 9;
 	do_div(nsecs, 125);
-	end = get_tod_clock_fast() + nsecs;
-	if (nsecs & ~0xfffUL)
-		__udelay(nsecs >> 12);
-	while (get_tod_clock_fast() < end)
-		barrier();
+	delay_loop(nsecs);
 }
 EXPORT_SYMBOL(__ndelay);
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 7c988994931f..dcd8946255be 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -9,12 +9,12 @@
 #include <linux/kallsyms.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/timer.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/kprobes.h>
 #include <linux/wait.h>
 #include <asm/irq.h>
-#include <asm/delay.h>
 
 #define BT_BUF_SIZE (PAGE_SIZE * 4)
 
@@ -205,12 +205,15 @@ static noinline int unwindme_func3(struct unwindme *u)
 /* This function must appear in the backtrace. */
 static noinline int unwindme_func2(struct unwindme *u)
 {
+	unsigned long flags;
 	int rc;
 
 	if (u->flags & UWM_SWITCH_STACK) {
-		preempt_disable();
+		local_irq_save(flags);
+		local_mcck_disable();
 		rc = CALL_ON_STACK(unwindme_func3, S390_lowcore.nodat_stack, 1, u);
-		preempt_enable();
+		local_mcck_enable();
+		local_irq_restore(flags);
 		return rc;
 	} else {
 		return unwindme_func3(u);
@@ -223,31 +226,27 @@ static noinline int unwindme_func1(void *u)
 	return unwindme_func2((struct unwindme *)u);
 }
 
-static void unwindme_irq_handler(struct ext_code ext_code,
-				       unsigned int param32,
-				       unsigned long param64)
+static void unwindme_timer_fn(struct timer_list *unused)
 {
 	struct unwindme *u = READ_ONCE(unwindme);
 
-	if (u && u->task == current) {
+	if (u) {
 		unwindme = NULL;
 		u->task = NULL;
 		u->ret = unwindme_func1(u);
+		complete(&u->task_ready);
 	}
 }
 
+static struct timer_list unwind_timer;
+
 static int test_unwind_irq(struct unwindme *u)
 {
-	preempt_disable();
-	if (register_external_irq(EXT_IRQ_CLK_COMP, unwindme_irq_handler)) {
-		pr_info("Couldn't register external interrupt handler");
-		return -1;
-	}
-	u->task = current;
 	unwindme = u;
-	udelay(1);
-	unregister_external_irq(EXT_IRQ_CLK_COMP, unwindme_irq_handler);
-	preempt_enable();
+	init_completion(&u->task_ready);
+	timer_setup(&unwind_timer, unwindme_timer_fn, 0);
+	mod_timer(&unwind_timer, jiffies + 1);
+	wait_for_completion(&u->task_ready);
 	return u->ret;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index e0005a4fc978..9e3c8b4e7fa8 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1668,7 +1668,7 @@ void ccw_device_wait_idle(struct ccw_device *cdev)
 		cio_tsch(sch);
 		if (sch->schib.scsw.cmd.actl == 0)
 			break;
-		udelay_simple(100);
+		udelay(100);
 	}
 }
 #endif
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index 226a5612e855..62ceeb7fc125 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -175,7 +175,7 @@ static int zcrypt_cex2a_queue_probe(struct ap_device *ap_dev)
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX2A_CLEANUP_TIME,
+	aq->request_timeout = CEX2A_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index f5195bca1d85..f4a6d3744241 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -631,7 +631,7 @@ static int zcrypt_cex4_queue_probe(struct ap_device *ap_dev)
 	atomic_set(&zq->load, 0);
 	ap_queue_init_state(aq);
 	ap_queue_init_reply(aq, &zq->reply);
-	aq->request_timeout = CEX4_CLEANUP_TIME,
+	aq->request_timeout = CEX4_CLEANUP_TIME;
 	aq->private = zq;
 	rc = zcrypt_queue_register(zq);
 	if (rc) {
