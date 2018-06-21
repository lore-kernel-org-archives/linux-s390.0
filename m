Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v12 11/11] x86/tsc: use tsc early
Date: Thu, 21 Jun 2018 17:25:18 -0400
Message-Id: <20180621212518.19914-12-pasha.tatashin@oracle.com>
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We want to get timestamps and high resultion clock available to us as early
as possible in boot. But, native_sched_clock() outputs time based either on
tsc after tsc_init() is called later in boot, or using jiffies when clock
interrupts are enabled, which is also happens later in boot.

On the other hand, we know tsc frequency from as early as when
tsc_early_delay_calibrate() is called. So, we use the early tsc calibration
to output timestamps early. Later in boot when tsc_init() is called we
calibrate tsc again using more precise methods, and start using that.

Since sched_clock() is in a hot path, we want to make sure that no
regressions are introduced to this function, with the current approach
sched_clock() path is not modified at all.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 654a01cc0358..b8a893d8f84a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -133,22 +133,13 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu,
-			     unsigned long long tsc_now,
-			     unsigned long long sched_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu,
+			       unsigned long long tsc_now,
+			       unsigned long long sched_now)
 {
-	unsigned long long ns_now;
+	unsigned long long ns_now = cycles_2_ns(tsc_now) + sched_now;
 	struct cyc2ns_data data;
 	struct cyc2ns *c2n;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	sched_clock_idle_sleep_event();
-
-	if (!khz)
-		goto done;
-
-	ns_now = cycles_2_ns(tsc_now) + sched_now;
 
 	/*
 	 * Compute a new multiplier as per the above comment and ensure our
@@ -178,12 +169,31 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu,
 	c2n->data[0] = data;
 	raw_write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+}
+
+static void set_cyc2ns_scale(unsigned long khz, int cpu,
+			     unsigned long long tsc_now,
+			     unsigned long long sched_now)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	if (khz)
+		__set_cyc2ns_scale(khz, cpu, tsc_now, sched_now);
 
-done:
 	sched_clock_idle_wakeup_event();
 	local_irq_restore(flags);
 }
 
+static void __init sched_clock_early_init(unsigned int khz)
+{
+	cyc2ns_init(smp_processor_id());
+	__set_cyc2ns_scale(khz, smp_processor_id(), rdtsc(), 0);
+	static_branch_enable(&__use_tsc);
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -1354,6 +1364,7 @@ void __init tsc_early_delay_calibrate(void)
 	lpj = tsc_khz * 1000;
 	do_div(lpj, HZ);
 	loops_per_jiffy = lpj;
+	sched_clock_early_init(tsc_khz);
 }
 
 void __init tsc_init(void)
@@ -1382,6 +1393,7 @@ void __init tsc_init(void)
 	if (!tsc_khz) {
 		mark_tsc_unstable("could not calculate TSC khz");
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
+		static_branch_disable(&__use_tsc);
 		return;
 	}
 
-- 
2.17.1
