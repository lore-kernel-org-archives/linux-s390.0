Return-Path: <linux-kernel-owner+w=401wt.eu-S1756907AbZDNN6T@vger.kernel.org>
Message-Id: <20090414135349.911958793@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 14/14] boot cputime accounting
Content-Disposition: inline; filename=014-boot-cputime.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Start the cpu time accounting very early to catch the cpu time spent
for the initial kernel setup. To make the output of /proc/uptime
match the sum of all cpu accounting values of the boot cpu reset
xtime and wall_to_monotonic to sane values based on the TOD clock.
The values set by timekeeping_init are off by up to a second.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S  |    8 +++++++-
 arch/s390/kernel/setup.c |    8 ++++++++
 arch/s390/kernel/time.c  |   36 ++++++++++++++++++++++++++++--------
 arch/s390/kernel/vtime.c |    8 --------
 4 files changed, 43 insertions(+), 17 deletions(-)

Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S
+++ quilt-2.6/arch/s390/kernel/head.S
@@ -473,7 +473,10 @@ startup:basr	%r13,0			# get base
 	xc	0x300(256),0x300
 	l	%r1,5f-.LPG0(%r13)
 	stck	0(%r1)
-
+	spt	6f-.LPG0(%r13)
+	mvc	__LC_LAST_UPDATE_CLOCK(8),0(%r1)
+	mvc	__LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
+	mvc	__LC_EXIT_TIMER(8),5f-.LPG0(%r13)
 #ifndef CONFIG_MARCH_G5
 	# check processor version against MARCH_{G5,Z900,Z990,Z9_109,Z10}
 	stidp	__LC_CPUID		# store cpuid
@@ -500,8 +503,11 @@ startup:basr	%r13,0			# get base
 
 	l	%r13,4f-.LPG0(%r13)
 	b	0(%r13)
+	.align	4
 4:	.long	startup_continue
 5:	.long	sched_clock_base_cc
+	.align	8
+6:	.long	0x7fffffff,0xffffffff
 
 #
 # params at 10400 (setup.h)
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -434,6 +434,14 @@ setup_lowcore(void)
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
Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -253,32 +253,52 @@ void update_vsyscall_tz(void)
  */
 void __init time_init(void)
 {
+	struct timespec ts;
+	unsigned long flags;
+	cycle_t now;
+
 	/* Reset time synchronization interfaces. */
 	etr_reset();
 	stp_reset();
 
-	/* set xtime */
-	tod_to_timeval(sched_clock_base_cc - TOD_UNIX_EPOCH, &xtime);
-        set_normalized_timespec(&wall_to_monotonic,
-                                -xtime.tv_sec, -xtime.tv_nsec);
-
 	/* request the clock comparator external interrupt */
 	if (register_early_external_interrupt(0x1004,
 					      clock_comparator_interrupt,
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
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -527,16 +527,8 @@ EXPORT_SYMBOL(del_virt_timer);
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

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
