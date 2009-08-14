Return-Path: <linux-kernel-owner+w=401wt.eu-S1756332AbZHNLc0@vger.kernel.org>
Message-Id: <20090814112615.613484629@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/34] introduce get_clock_monotonic
Content-Disposition: inline; filename=112-get_clock_monotonic.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Introduce get_clock_monotonic() function which can be used to get a
(fast) timestamp. Resolution is the same as for get_clock(). The
only difference is that the timestamps are monotonic and don't jump
backward or forward.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/timex.h |   16 +++++++++++++++-
 arch/s390/kernel/early.c      |    2 +-
 arch/s390/kernel/head.S       |    2 +-
 arch/s390/kernel/time.c       |    9 +++++----
 4 files changed, 22 insertions(+), 7 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/timex.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/timex.h
+++ quilt-2.6/arch/s390/include/asm/timex.h
@@ -88,6 +88,20 @@ int get_sync_clock(unsigned long long *c
 void init_cpu_timer(void);
 unsigned long long monotonic_clock(void);
 
-extern u64 sched_clock_base_cc;
+extern u64 sched_clock_base;
+
+/**
+ * get_clock_monotonic - returns current time in clock rate units
+ *
+ * The caller must ensure that preemption is disabled.
+ * The clock and sched_clock_base get changed via stop_machine.
+ * Therefore preemption must be disabled when calling this
+ * function, otherwise the returned value is not guaranteed to
+ * be monotonic.
+ */
+static inline unsigned long long get_clock_monotonic(void)
+{
+	return get_clock_xt() - sched_clock_base;
+}
 
 #endif
Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -52,7 +52,7 @@ static void __init reset_tod_clock(void)
 	if (set_clock(TOD_UNIX_EPOCH) != 0 || store_clock(&time) != 0)
 		disabled_wait(0);
 
-	sched_clock_base_cc = TOD_UNIX_EPOCH;
+	sched_clock_base = TOD_UNIX_EPOCH;
 }
 
 #ifdef CONFIG_SHARED_KERNEL
Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S
+++ quilt-2.6/arch/s390/kernel/head.S
@@ -535,7 +535,7 @@ startup:basr	%r13,0			# get base
 	b	0(%r13)
 	.align	4
 4:	.long	startup_continue
-5:	.long	sched_clock_base_cc
+5:	.long	sched_clock_base
 	.align	8
 6:	.long	0x7fffffff,0xffffffff
 
Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -59,7 +59,8 @@
 
 #define TICK_SIZE tick
 
-u64 sched_clock_base_cc = -1;	/* Force to data section. */
+u64 sched_clock_base = -1;	/* Force to data section. */
+EXPORT_SYMBOL(sched_clock_base);
 
 static DEFINE_PER_CPU(struct clock_event_device, comparators);
 
@@ -68,7 +69,7 @@ static DEFINE_PER_CPU(struct clock_event
  */
 unsigned long long notrace sched_clock(void)
 {
-	return ((get_clock_xt() - sched_clock_base_cc) * 125) >> 9;
+	return (get_clock_monotonic() * 125) >> 9;
 }
 
 /*
@@ -277,7 +278,7 @@ void __init time_init(void)
 	tod_to_timeval(now - TOD_UNIX_EPOCH, &xtime);
 	clocksource_tod.cycle_last = now;
 	clocksource_tod.raw_time = xtime;
-	tod_to_timeval(sched_clock_base_cc - TOD_UNIX_EPOCH, &ts);
+	tod_to_timeval(sched_clock_base - TOD_UNIX_EPOCH, &ts);
 	set_normalized_timespec(&wall_to_monotonic, -ts.tv_sec, -ts.tv_nsec);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 
@@ -315,7 +316,7 @@ static unsigned long long adjust_time(un
 		delta = -delta;
 		adjust.offset = -ticks * (1000000 / HZ);
 	}
-	sched_clock_base_cc += delta;
+	sched_clock_base += delta;
 	if (adjust.offset != 0) {
 		pr_notice("The ETR interface has adjusted the clock "
 			  "by %li microseconds\n", adjust.offset);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
