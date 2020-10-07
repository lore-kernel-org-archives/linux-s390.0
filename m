Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgJGM4e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 08:56:34 -0400
Date: Wed, 7 Oct 2020 14:56:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20201007125625.GK2651@hirez.programming.kicks-ass.net>
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
 <yt9dimbm79qi.fsf@linux.ibm.com>
 <20201007100551.GC2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007100551.GC2628@hirez.programming.kicks-ass.net>
List-ID: <linux-s390.vger.kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com

On Wed, Oct 07, 2020 at 12:05:51PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 09:53:25AM +0200, Sven Schnelle wrote:
> > Hi Peter,
> > 
> > peterz@infradead.org writes:
> > 
> > > After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> > > lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> > > bunch more RCU violations that were previously hidden.
> > >
> > > Switch the idle->seqcount over to using raw_write_*() to avoid the
> > > lockdep annotation and thus the lock tracepoints.
> > >
> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > [..]
> > 
> > I'm still seeing the splat below on s390 when irq tracing is enabled:
> 
> Damn... :/
> 
> This one is tricky, trouble seems to be that arch_cpu_idle() is defined
> to enable interrupts (no doubt because ot x86 :/), but we call it before
> rcu_exit_idle().
> 
> What a mess... let me rummage around the various archs to see what makes
> most sense here.

Maybe something like so, I've not yet tested it. I need to figure out
how to force x86 into this path.

---
 arch/alpha/kernel/process.c      |  2 +-
 arch/arm/kernel/process.c        |  2 +-
 arch/arm64/kernel/process.c      |  2 +-
 arch/csky/kernel/process.c       |  2 +-
 arch/h8300/kernel/process.c      |  2 +-
 arch/hexagon/kernel/process.c    |  2 +-
 arch/ia64/kernel/process.c       |  2 +-
 arch/microblaze/kernel/process.c |  2 +-
 arch/mips/kernel/idle.c          | 12 ++++++------
 arch/nios2/kernel/process.c      |  2 +-
 arch/openrisc/kernel/process.c   |  2 +-
 arch/parisc/kernel/process.c     |  2 +-
 arch/powerpc/kernel/idle.c       |  4 ++--
 arch/riscv/kernel/process.c      |  2 +-
 arch/s390/kernel/idle.c          |  2 +-
 arch/sh/kernel/idle.c            |  2 +-
 arch/sparc/kernel/process_32.c   |  2 +-
 arch/sparc/kernel/process_64.c   |  4 ++--
 arch/um/kernel/process.c         |  2 +-
 arch/x86/include/asm/mwait.h     |  2 --
 arch/x86/kernel/process.c        |  8 +++++---
 kernel/sched/idle.c              | 28 +++++++++++++++++++++++++++-
 22 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 7462a7911002..4c7b0414a3ff 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -57,7 +57,7 @@ EXPORT_SYMBOL(pm_power_off);
 void arch_cpu_idle(void)
 {
 	wtint(0);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_dead(void)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 8e6ace03e960..9f199b1e8383 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -71,7 +71,7 @@ void arch_cpu_idle(void)
 		arm_pm_idle();
 	else
 		cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_prepare(void)
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f1804496b935..e8f44cf9d7bf 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -124,7 +124,7 @@ void arch_cpu_idle(void)
 	 * tricks
 	 */
 	cpu_do_idle();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f730869e21ee..69af6bc87e64 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -102,6 +102,6 @@ void arch_cpu_idle(void)
 #ifdef CONFIG_CPU_PM_STOP
 	asm volatile("stop\n");
 #endif
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 #endif
diff --git a/arch/h8300/kernel/process.c b/arch/h8300/kernel/process.c
index 83ce3caf7313..a2961c7b2332 100644
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -57,7 +57,7 @@ asmlinkage void ret_from_kernel_thread(void);
  */
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	__asm__("sleep");
 }
 
diff --git a/arch/hexagon/kernel/process.c b/arch/hexagon/kernel/process.c
index dfd322c5ce83..20962601a1b4 100644
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -44,7 +44,7 @@ void arch_cpu_idle(void)
 {
 	__vmwait();
 	/*  interrupts wake us up, but irqs are still disabled */
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index f19cb97c0098..1b2769260688 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -252,7 +252,7 @@ void arch_cpu_idle(void)
 	if (mark_idle)
 		(*mark_idle)(1);
 
-	safe_halt();
+	raw_safe_halt();
 
 	if (mark_idle)
 		(*mark_idle)(0);
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/process.c
index a9e46e525cd0..f99860771ff4 100644
--- a/arch/microblaze/kernel/process.c
+++ b/arch/microblaze/kernel/process.c
@@ -149,5 +149,5 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fpregs)
 
 void arch_cpu_idle(void)
 {
-       local_irq_enable();
+       raw_local_irq_enable();
 }
diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 5bc3b04693c7..18e69ebf5691 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -33,19 +33,19 @@ static void __cpuidle r3081_wait(void)
 {
 	unsigned long cfg = read_c0_conf();
 	write_c0_conf(cfg | R30XX_CONF_HALT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 static void __cpuidle r39xx_wait(void)
 {
 	if (!need_resched())
 		write_c0_conf(read_c0_conf() | TX39_CONF_HALT);
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void __cpuidle r4k_wait(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	__r4k_wait();
 }
 
@@ -64,7 +64,7 @@ void __cpuidle r4k_wait_irqoff(void)
 		"	.set	arch=r4000	\n"
 		"	wait			\n"
 		"	.set	pop		\n");
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -84,7 +84,7 @@ static void __cpuidle rm7k_wait_irqoff(void)
 		"	wait						\n"
 		"	mtc0	$1, $12		# stalls until W stage	\n"
 		"	.set	pop					\n");
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
@@ -257,7 +257,7 @@ void arch_cpu_idle(void)
 	if (cpu_wait)
 		cpu_wait();
 	else
-		local_irq_enable();
+		raw_local_irq_enable();
 }
 
 #ifdef CONFIG_CPU_IDLE
diff --git a/arch/nios2/kernel/process.c b/arch/nios2/kernel/process.c
index 88a4ec03edab..f5cc55a88d31 100644
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -33,7 +33,7 @@ EXPORT_SYMBOL(pm_power_off);
 
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index 0ff391f00334..3c98728cce24 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -79,7 +79,7 @@ void machine_power_off(void)
  */
 void arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 	if (mfspr(SPR_UPR) & SPR_UPR_PMP)
 		mtspr(SPR_PMR, mfspr(SPR_PMR) | SPR_PMR_DME);
 }
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index f196d96e2f9f..a92a23d6acd9 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -169,7 +169,7 @@ void __cpuidle arch_cpu_idle_dead(void)
 
 void __cpuidle arch_cpu_idle(void)
 {
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	/* nop on real hardware, qemu will idle sleep. */
 	asm volatile("or %%r10,%%r10,%%r10\n":::);
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index 422e31d2f5a2..8df35f1329a4 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -60,9 +60,9 @@ void arch_cpu_idle(void)
 		 * interrupts enabled, some don't.
 		 */
 		if (irqs_disabled())
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		local_irq_enable();
+		raw_local_irq_enable();
 		/*
 		 * Go into low thread priority and possibly
 		 * low power mode.
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 2b97c493427c..308e1d95ecbf 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -36,7 +36,7 @@ extern asmlinkage void ret_from_kernel_thread(void);
 void arch_cpu_idle(void)
 {
 	wait_for_interrupt();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void show_regs(struct pt_regs *regs)
diff --git a/arch/s390/kernel/idle.c b/arch/s390/kernel/idle.c
index f7f1e64e0d98..060eac5b2ac4 100644
--- a/arch/s390/kernel/idle.c
+++ b/arch/s390/kernel/idle.c
@@ -123,7 +123,7 @@ void arch_cpu_idle_enter(void)
 void arch_cpu_idle(void)
 {
 	enabled_wait();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void arch_cpu_idle_exit(void)
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 0dc0f52f9bb8..f59814983bd5 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -22,7 +22,7 @@ static void (*sh_idle)(void);
 void default_idle(void)
 {
 	set_bl_bit();
-	local_irq_enable();
+	raw_local_irq_enable();
 	/* Isn't this racy ? */
 	cpu_sleep();
 	clear_bl_bit();
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index adfcaeab3ddc..a02363735915 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -74,7 +74,7 @@ void arch_cpu_idle(void)
 {
 	if (sparc_idle)
 		(*sparc_idle)();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /* XXX cli/sti -> local_irq_xxx here, check this works once SMP is fixed. */
diff --git a/arch/sparc/kernel/process_64.c b/arch/sparc/kernel/process_64.c
index a75093b993f9..6f8c7822fc06 100644
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -62,11 +62,11 @@ void arch_cpu_idle(void)
 {
 	if (tlb_type != hypervisor) {
 		touch_nmi_watchdog();
-		local_irq_enable();
+		raw_local_irq_enable();
 	} else {
 		unsigned long pstate;
 
-		local_irq_enable();
+		raw_local_irq_enable();
 
                 /* The sun4v sleeping code requires that we have PSTATE.IE cleared over
                  * the cpu sleep hypervisor call.
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 26b5e243d3fc..495f101792b3 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -217,7 +217,7 @@ void arch_cpu_idle(void)
 {
 	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
 	um_idle_sleep();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 int __cant_sleep(void) {
diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
index e039a933aca3..29dd27b5a339 100644
--- a/arch/x86/include/asm/mwait.h
+++ b/arch/x86/include/asm/mwait.h
@@ -88,8 +88,6 @@ static inline void __mwaitx(unsigned long eax, unsigned long ebx,
 
 static inline void __sti_mwait(unsigned long eax, unsigned long ecx)
 {
-	trace_hardirqs_on();
-
 	mds_idle_clear_cpu_buffers();
 	/* "mwait %eax, %ecx;" */
 	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ba4593a913fa..4d756c570eff 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -685,7 +685,7 @@ void arch_cpu_idle(void)
  */
 void __cpuidle default_idle(void)
 {
-	safe_halt();
+	raw_safe_halt();
 }
 #if defined(CONFIG_APM_MODULE) || defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
 EXPORT_SYMBOL(default_idle);
@@ -736,6 +736,8 @@ void stop_this_cpu(void *dummy)
 /*
  * AMD Erratum 400 aware idle routine. We handle it the same way as C3 power
  * states (local apic timer and TSC stop).
+ *
+ * XXX this function is completely buggered vs RCU and tracing.
  */
 static void amd_e400_idle(void)
 {
@@ -801,9 +803,9 @@ static __cpuidle void mwait_idle(void)
 		if (!need_resched())
 			__sti_mwait(0, 0);
 		else
-			local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		local_irq_enable();
+		raw_local_irq_enable();
 	}
 	__current_clr_polling();
 }
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f324dc36fc43..dee807ffad11 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -78,7 +78,7 @@ void __weak arch_cpu_idle_dead(void) { }
 void __weak arch_cpu_idle(void)
 {
 	cpu_idle_force_poll = 1;
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /**
@@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
 
 		trace_cpu_idle(1, smp_processor_id());
 		stop_critical_timings();
+
+		/*
+		 * arch_cpu_idle() is supposed to enable IRQs, however
+		 * we can't do that because of RCU and tracing.
+		 *
+		 * Trace IRQs enable here, then switch off RCU, and have
+		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
+		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
+		 * last -- this is very similar to the entry code.
+		 */
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(_THIS_IP_);
 		rcu_idle_enter();
+		lockdep_hardirqs_on(_THIS_IP_);
+
 		arch_cpu_idle();
+
+		/*
+		 * OK, so IRQs are enabled here, but RCU needs them disabled to
+		 * turn itself back on.. funny thing is that disabling IRQs
+		 * will cause tracing, which needs RCU. Jump through hoops to
+		 * make it 'work'.
+		 */
+		raw_local_irq_disable();
+		lockdep_hardirqs_off(_THIS_IP_);
 		rcu_idle_exit();
+		lockdep_hardirqs_on(_THIS_IP_);
+		raw_local_irq_enable();
+
 		start_critical_timings();
 		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 	}
