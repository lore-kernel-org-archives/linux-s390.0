Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Date: Thu, 21 Jun 2018 17:25:16 -0400
Message-Id: <20180621212518.19914-10-pasha.tatashin@oracle.com>
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We will change sched_clock() to be called early. But, during boot
sched_clock() changes its output without notifying us about the change of
clock source.

This happens in tsc_init(), when static_branch_enable(&__use_tsc) is
called.

native_sched_clock() changes from outputing jiffies to reading tsc, but
sched is not notified in anyway. So, to preserve the continoutity in this
place we add the offset of sched_clock() to the calculation of cyc2ns.

Without this change, the output would look like this:

[    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.009000] tsc: Fast TSC calibration using PIT
[    0.010000] tsc: Detected 3192.137 MHz processor
[    0.011000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e03465ceb2,    max_idle_ns: 440795259855 ns

static_branch_enable(__use_tsc) is called, and timestamps became precise
but reduced:

[    0.002233] Calibrating delay loop (skipped), value calculated using timer frequency..     6384.27 BogoMIPS (lpj=3192137)
[    0.002516] pid_max: default: 32768 minimum: 301

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 186395041725..654a01cc0358 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -133,7 +133,9 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void set_cyc2ns_scale(unsigned long khz, int cpu,
+			     unsigned long long tsc_now,
+			     unsigned long long sched_now)
 {
 	unsigned long long ns_now;
 	struct cyc2ns_data data;
@@ -146,7 +148,7 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
 	if (!khz)
 		goto done;
 
-	ns_now = cycles_2_ns(tsc_now);
+	ns_now = cycles_2_ns(tsc_now) + sched_now;
 
 	/*
 	 * Compute a new multiplier as per the above comment and ensure our
@@ -936,7 +938,7 @@ static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 			mark_tsc_unstable("cpufreq changes");
 
-		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc());
+		set_cyc2ns_scale(tsc_khz, freq->cpu, rdtsc(), 0);
 	}
 
 	return 0;
@@ -1285,7 +1287,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 	/* Update the sched_clock() rate to match the clocksource one */
 	for_each_possible_cpu(cpu)
-		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop);
+		set_cyc2ns_scale(tsc_khz, cpu, tsc_stop, 0);
 
 out:
 	if (tsc_unstable)
@@ -1356,7 +1358,7 @@ void __init tsc_early_delay_calibrate(void)
 
 void __init tsc_init(void)
 {
-	u64 lpj, cyc;
+	u64 lpj, cyc, sch;
 	int cpu;
 
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
@@ -1403,9 +1405,10 @@ void __init tsc_init(void)
 	 * up if their speed diverges)
 	 */
 	cyc = rdtsc();
+	sch = local_clock();
 	for_each_possible_cpu(cpu) {
 		cyc2ns_init(cpu);
-		set_cyc2ns_scale(tsc_khz, cpu, cyc);
+		set_cyc2ns_scale(tsc_khz, cpu, cyc, sch);
 	}
 
 	static_branch_enable(&__use_tsc);
-- 
2.17.1
