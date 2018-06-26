Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 26 Jun 2018 11:00:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180626090003.GA2458@hirez.programming.kicks-ass.net>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 03:23:20PM -0400, Pavel Tatashin wrote:
> Unfortunatly the above suggestion won't work. And here is why.
> 
> We have a call sequence like this:
> 
> start_kernel
>     sched_init()
>         sched_clock_init()
> 	     In this call sched_clock_running is set to 1. Which means
> 	     that sched_clock_cpu() starts doing the following sequence:
> 	     scd = cpu_sdc(cpu);
> 	     clock = sched_clock_local(scd);
> 	     Where we try to filter the output of sched_clock() based
> 	     on the value of scd. But, that won't work, because to get
> 	     this functionality, we need to have: timer initialized
> 	     that wakes up and updates scd, and we need timekeeping
> 	     initialized, so we can call ktime_get_ns(). Both of which
> 	     are called later.
>     ...
>     timekeeping_init() After this we can call ktime_get_ns()
>     time_init()  Here we configure x86_late_time_init pointer.
>     ...
>     late_time_init()
>         x86_late_time_init()
>             x86_init.timers.timer_init()
> 	        hpet_time_init() Only after this call we finally start
> 		getting clock interrupts, and can get precise output from
> 		sched_clock_local().
> 
> The way I solved the above, is I changed sched_clock() to keep outputing
> time based on early boot sched_clock() until sched_clock_init_late(), at
> whic point everything is configured and we can switch to the permanent
> clock, eventhough this happens after smp init.
> 
> If you have a better solution, please let me know.

How's something like this? That moves sched_clock_init() to right before
we enable IRQs for the first time (which is after we've started the
whole timekeeping business).

The thing is, sched_clock_init_late() reall is far too late, we need to
switch to unstable before we bring up SMP.

---
 include/linux/sched_clock.h |  5 -----
 init/main.c                 |  4 ++--
 kernel/sched/clock.c        | 49 +++++++++++++++++++++++++++++++++++----------
 kernel/sched/core.c         |  1 -
 kernel/time/sched_clock.c   |  2 +-
 5 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 411b52e424e1..2d223677740f 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -9,17 +9,12 @@
 #define LINUX_SCHED_CLOCK
 
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
-extern void sched_clock_postinit(void);
-
 extern void sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate);
 #else
-static inline void sched_clock_postinit(void) { }
-
 static inline void sched_clock_register(u64 (*read)(void), int bits,
 					unsigned long rate)
 {
-	;
 }
 #endif
 
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..162d931c9511 100644
--- a/init/main.c
+++ b/init/main.c
@@ -79,7 +79,7 @@
 #include <linux/pti.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
-#include <linux/sched_clock.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/context_tracking.h>
@@ -642,7 +642,7 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	time_init();
-	sched_clock_postinit();
+	sched_clock_init();
 	printk_safe_init();
 	perf_event_init();
 	profile_init();
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 10c83e73837a..c8286b9fc593 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -68,11 +68,6 @@ EXPORT_SYMBOL_GPL(sched_clock);
 
 __read_mostly int sched_clock_running;
 
-void sched_clock_init(void)
-{
-	sched_clock_running = 1;
-}
-
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 /*
  * We must start with !__sched_clock_stable because the unstable -> stable
@@ -199,6 +194,23 @@ void clear_sched_clock_stable(void)
 		__clear_sched_clock_stable();
 }
 
+static void __sched_clock_gtod_offset(void)
+{
+	__gtod_offset = (sched_clock() + __sched_clock_offset) - ktime_get_ns();
+}
+
+void __init sched_clock_init(void)
+{
+	/*
+	 * Set __gtod_offset such that once we mark sched_clock_running,
+	 * sched_clock_tick() continues where sched_clock() left off.
+	 *
+	 * Even if TSC is buggered, we're still UP at this point so it
+	 * can't really be out of sync.
+	 */
+	__sched_clock_gtod_offset();
+	sched_clock_running = 1;
+}
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,
  * notably: acpi_processor and intel_idle, which can mark the TSC as unstable.
@@ -351,7 +363,7 @@ u64 sched_clock_cpu(int cpu)
 		return sched_clock() + __sched_clock_offset;
 
 	if (unlikely(!sched_clock_running))
-		return 0ull;
+		return sched_clock(); /* __sched_clock_offset == 0 */
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
@@ -385,8 +397,6 @@ void sched_clock_tick(void)
 
 void sched_clock_tick_stable(void)
 {
-	u64 gtod, clock;
-
 	if (!sched_clock_stable())
 		return;
 
@@ -398,9 +408,7 @@ void sched_clock_tick_stable(void)
 	 * TSC to be unstable, any computation will be computing crap.
 	 */
 	local_irq_disable();
-	gtod = ktime_get_ns();
-	clock = sched_clock();
-	__gtod_offset = (clock + __sched_clock_offset) - gtod;
+	__sched_clock_gtod_offset();
 	local_irq_enable();
 }
 
@@ -434,6 +442,24 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
 #else /* CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
 
+#ifdef CONFIG_GENERIC_SCHED_CLOCK
+
+/*
+ * kernel/time/sched_clock.c:sched_clock_init()
+ */
+
+u64 sched_clock_cpu(int cpu)
+{
+	return sched_clock();
+}
+
+#else /* CONFIG_GENERIC_SCHED_CLOCK */
+
+void __init sched_clock_init(void)
+{
+	sched_clock_running = 1;
+}
+
 u64 sched_clock_cpu(int cpu)
 {
 	if (unlikely(!sched_clock_running))
@@ -442,6 +468,7 @@ u64 sched_clock_cpu(int cpu)
 	return sched_clock();
 }
 
+#endif /* CONFIG_GENERIC_SCHED_CLOCK */
 #endif /* CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a98d54cd5535..b27d034ef4a7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5953,7 +5953,6 @@ void __init sched_init(void)
 	int i, j;
 	unsigned long alloc_size = 0, ptr;
 
-	sched_clock_init();
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 2d8f05aad442..b4fedf312979 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -237,7 +237,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	pr_debug("Registered %pF as sched_clock source\n", read);
 }
 
-void __init sched_clock_postinit(void)
+void __init sched_clock_init(void)
 {
 	/*
 	 * If no sched_clock() function has been provided at that point,
