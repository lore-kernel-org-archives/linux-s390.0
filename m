Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 23/26] sched: early boot clock
Date: Thu, 19 Jul 2018 16:55:42 -0400
Message-Id: <20180719205545.16512-24-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Allow sched_clock() to be used before schec_clock_init() is called.
This provides with a way to get early boot timestamps on machines with
unstable clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 init/main.c          |  2 +-
 kernel/sched/clock.c | 20 +++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 162d931c9511..ff0a24170b95 100644
--- a/init/main.c
+++ b/init/main.c
@@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	time_init();
-	sched_clock_init();
 	printk_safe_init();
 	perf_event_init();
 	profile_init();
@@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
+	sched_clock_init();
 	calibrate_delay();
 	pid_idr_init();
 	anon_vma_init();
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 0e9dbb2d9aea..422cd63f8f17 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -202,7 +202,25 @@ static void __sched_clock_gtod_offset(void)
 
 void __init sched_clock_init(void)
 {
+	unsigned long flags;
+
+	/*
+	 * Set __gtod_offset such that once we mark sched_clock_running,
+	 * sched_clock_tick() continues where sched_clock() left off.
+	 *
+	 * Even if TSC is buggered, we're still UP at this point so it
+	 * can't really be out of sync.
+	 */
+	local_irq_save(flags);
+	__sched_clock_gtod_offset();
+	local_irq_restore(flags);
+
 	sched_clock_running = 1;
+
+	/* Now that sched_clock_running is set adjust scd */
+	local_irq_save(flags);
+	sched_clock_tick();
+	local_irq_restore(flags);
 }
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,
@@ -356,7 +374,7 @@ u64 sched_clock_cpu(int cpu)
 		return sched_clock() + __sched_clock_offset;
 
 	if (unlikely(!sched_clock_running))
-		return 0ull;
+		return sched_clock();
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
-- 
2.18.0
