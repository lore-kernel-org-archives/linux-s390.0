Return-Path: <linux-kernel-owner+w=401wt.eu-S1753949AbZI2MZg@vger.kernel.org>
Message-Id: <20090929122533.402715150@de.ibm.com>
Date: Tue, 29 Sep 2009 14:25:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/2] [PATCH] nohz: introduce arch_needs_cpu
References: <20090929122514.693636761@de.ibm.com>
Content-Disposition: inline; filename=201-nohz-delay.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Allow the architecture to request a normal jiffy tick when the system
goes idle and tick_nohz_stop_sched_tick is called . On s390 the hook is
used to prevent the system going fully idle if there has been an
interrupt other than a clock comparator interrupt since the last wakeup.

On s390 the HiperSockets response time for 1 connection ping-pong goes
down from 42 to 34 microseconds. The CPU cost decreases by 27%.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/cputime.h |    8 ++++++++
 arch/s390/kernel/s390_ext.c     |    2 ++
 arch/s390/kernel/vtime.c        |    2 ++
 drivers/s390/cio/cio.c          |    1 +
 include/linux/tick.h            |    3 +++
 kernel/time/tick-sched.c        |   13 ++++++++-----
 6 files changed, 24 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/cputime.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/cputime.h	2009-09-24 09:06:44.000000000 +0200
+++ quilt-2.6/arch/s390/include/asm/cputime.h	2009-09-29 14:15:49.000000000 +0200
@@ -183,6 +183,7 @@
 	unsigned long long idle_count;
 	unsigned long long idle_enter;
 	unsigned long long idle_time;
+	int nohz_delay;
 };
 
 DECLARE_PER_CPU(struct s390_idle_data, s390_idle);
@@ -198,4 +199,11 @@
 		vtime_start_cpu();
 }
 
+static inline int s390_nohz_delay(int cpu)
+{
+	return per_cpu(s390_idle, cpu).nohz_delay != 0;
+}
+
+#define arch_needs_cpu(cpu) s390_nohz_delay(cpu)
+
 #endif /* _S390_CPUTIME_H */
Index: quilt-2.6/arch/s390/kernel/s390_ext.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/s390_ext.c	2009-08-14 13:17:23.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/s390_ext.c	2009-09-29 14:15:49.000000000 +0200
@@ -126,6 +126,8 @@
 		/* Serve timer interrupts first. */
 		clock_comparator_work();
 	kstat_cpu(smp_processor_id()).irqs[EXTERNAL_INTERRUPT]++;
+	if (code != 0x1004)
+		__get_cpu_var(s390_idle).nohz_delay = 1;
         index = ext_hash(code);
 	for (p = ext_int_hash[index]; p; p = p->next) {
 		if (likely(p->code == code))
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c	2009-08-14 13:17:23.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/vtime.c	2009-09-29 14:15:49.000000000 +0200
@@ -167,6 +167,8 @@
 	/* Wait for external, I/O or machine check interrupt. */
 	psw.mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_IO | PSW_MASK_EXT;
 
+	idle->nohz_delay = 0;
+
 	/* Check if the CPU timer needs to be reprogrammed. */
 	if (vq->do_spt) {
 		__u64 vmax = VTIMER_MAX_SLICE;
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c	2009-09-12 09:47:15.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cio.c	2009-09-29 14:15:49.000000000 +0200
@@ -618,6 +618,7 @@
 	old_regs = set_irq_regs(regs);
 	s390_idle_check();
 	irq_enter();
+	__get_cpu_var(s390_idle).nohz_delay = 1;
 	if (S390_lowcore.int_clock >= S390_lowcore.clock_comparator)
 		/* Serve timer interrupts first. */
 		clock_comparator_work();
Index: quilt-2.6/include/linux/tick.h
===================================================================
--- quilt-2.6.orig/include/linux/tick.h	2009-08-07 11:09:40.000000000 +0200
+++ quilt-2.6/include/linux/tick.h	2009-09-29 14:15:49.000000000 +0200
@@ -98,6 +98,9 @@
 extern struct tick_sched *tick_get_tick_sched(int cpu);
 extern void tick_check_idle(int cpu);
 extern int tick_oneshot_mode_active(void);
+#  ifndef arch_needs_cpu
+#   define arch_needs_cpu(cpu) (0)
+#  endif
 # else
 static inline void tick_clock_notify(void) { }
 static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
Index: quilt-2.6/kernel/time/tick-sched.c
===================================================================
--- quilt-2.6.orig/kernel/time/tick-sched.c	2009-09-29 14:15:43.000000000 +0200
+++ quilt-2.6/kernel/time/tick-sched.c	2009-09-29 14:15:49.000000000 +0200
@@ -264,12 +264,15 @@
 		last_jiffies = jiffies;
 	} while (read_seqretry(&xtime_lock, seq));
 
-	/* Get the next timer wheel timer */
-	next_jiffies = get_next_timer_interrupt(last_jiffies);
-	delta_jiffies = next_jiffies - last_jiffies;
-
-	if (rcu_needs_cpu(cpu) || printk_needs_cpu(cpu))
+	if (rcu_needs_cpu(cpu) || printk_needs_cpu(cpu) ||
+	    arch_needs_cpu(cpu)) {
+		next_jiffies = last_jiffies + 1;
 		delta_jiffies = 1;
+	} else {
+		/* Get the next timer wheel timer */
+		next_jiffies = get_next_timer_interrupt(last_jiffies);
+		delta_jiffies = next_jiffies - last_jiffies;
+	}
 	/*
 	 * Do not stop the tick, if we are only one off
 	 * or if the cpu is required for rcu
