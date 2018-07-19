Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 24/26] sched: use static key for sched_clock_running
Date: Thu, 19 Jul 2018 16:55:43 -0400
Message-Id: <20180719205545.16512-25-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

sched_clock_running may be read every time sched_clock_cpu() is called.
Yet, this variable is updated only twice during boot, and never changes
again, therefore it is better to make it a static key.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/clock.c | 16 ++++++++--------
 kernel/sched/debug.c |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 422cd63f8f17..c5c47ad3f386 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -67,7 +67,7 @@ unsigned long long __weak sched_clock(void)
 }
 EXPORT_SYMBOL_GPL(sched_clock);
 
-__read_mostly int sched_clock_running;
+static DEFINE_STATIC_KEY_FALSE(sched_clock_running);
 
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 /*
@@ -191,7 +191,7 @@ void clear_sched_clock_stable(void)
 
 	smp_mb(); /* matches sched_clock_init_late() */
 
-	if (sched_clock_running == 2)
+	if (static_key_count(&sched_clock_running.key) == 2)
 		__clear_sched_clock_stable();
 }
 
@@ -215,7 +215,7 @@ void __init sched_clock_init(void)
 	__sched_clock_gtod_offset();
 	local_irq_restore(flags);
 
-	sched_clock_running = 1;
+	static_branch_inc(&sched_clock_running);
 
 	/* Now that sched_clock_running is set adjust scd */
 	local_irq_save(flags);
@@ -228,7 +228,7 @@ void __init sched_clock_init(void)
  */
 static int __init sched_clock_init_late(void)
 {
-	sched_clock_running = 2;
+	static_branch_inc(&sched_clock_running);
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
 	 *
@@ -373,7 +373,7 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return sched_clock();
 
 	preempt_disable_notrace();
@@ -396,7 +396,7 @@ void sched_clock_tick(void)
 	if (sched_clock_stable())
 		return;
 
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return;
 
 	lockdep_assert_irqs_disabled();
@@ -455,13 +455,13 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
 void __init sched_clock_init(void)
 {
-	sched_clock_running = 1;
+	static_branch_inc(&sched_clock_running);
 	generic_sched_clock_init();
 }
 
 u64 sched_clock_cpu(int cpu)
 {
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return 0;
 
 	return sched_clock();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e593b4118578..b0212f489a33 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -623,8 +623,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 #undef PU
 }
 
-extern __read_mostly int sched_clock_running;
-
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-- 
2.18.0
