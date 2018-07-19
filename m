Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 26/26] x86/tsc:  use tsc_calibrate_cpu_early and pit_hpet_ptimer_calibrate_cpu
Date: Thu, 19 Jul 2018 16:55:45 -0400
Message-Id: <20180719205545.16512-27-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Early in boot enable tsc_calibrate_cpu_early and switch to
tsc_calibrate_cpu() only later. Do this unconditionally, because it is
unknown what methods other cpus will use to calibrate once they are
onlined.

If by the time tsc_init() is called tsc frequency is still unknown do only
pit_hpet_ptimer_calibrate_cpu to calibrate, as this function contails the
only methods that had not been called earlier in boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tsc.h |  1 -
 arch/x86/kernel/tsc.c      | 25 +++++++++++++++++++------
 arch/x86/kernel/x86_init.c |  2 +-
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 88140e4f2292..eb5bbfeccb66 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -39,7 +39,6 @@ extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
-extern unsigned long native_calibrate_cpu(void);
 extern unsigned long native_calibrate_cpu_early(void);
 extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 60586779b02c..02e416b87ac1 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -854,7 +854,7 @@ unsigned long native_calibrate_cpu_early(void)
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
-unsigned long native_calibrate_cpu(void)
+static unsigned long native_calibrate_cpu(void)
 {
 	unsigned long tsc_freq = native_calibrate_cpu_early();
 
@@ -1374,13 +1374,19 @@ static int __init init_tsc_clocksource(void)
  */
 device_initcall(init_tsc_clocksource);
 
-static bool __init determine_cpu_tsc_frequencies(void)
+static bool __init determine_cpu_tsc_frequencies(bool early)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
 	WARN_ON(cpu_khz || tsc_khz);
 
-	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
+	if (early) {
+		cpu_khz = x86_platform.calibrate_cpu();
+		tsc_khz = x86_platform.calibrate_tsc();
+	} else {
+		/* We should not be here with non-native cpu calibration */
+		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
+		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
+	}
 
 	/*
 	 * Trust non-zero tsc_khz as authorative,
@@ -1419,7 +1425,7 @@ void __init tsc_early_init(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
-	if (!determine_cpu_tsc_frequencies())
+	if (!determine_cpu_tsc_frequencies(true))
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
 
@@ -1431,6 +1437,13 @@ void __init tsc_early_init(void)
 
 void __init tsc_init(void)
 {
+	/*
+	 * native_calibrate_cpu_early can only calibrate using methods that are
+	 * available early in boot.
+	 */
+	if (x86_platform.calibrate_cpu == native_calibrate_cpu_early)
+		x86_platform.calibrate_cpu = native_calibrate_cpu;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC)) {
 		setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 		return;
@@ -1438,7 +1451,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies()) {
+		if (!determine_cpu_tsc_frequencies(false)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 3ab867603e81..2792b5573818 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -109,7 +109,7 @@ struct x86_cpuinit_ops x86_cpuinit = {
 static void default_nmi_init(void) { };
 
 struct x86_platform_ops x86_platform __ro_after_init = {
-	.calibrate_cpu			= native_calibrate_cpu,
+	.calibrate_cpu			= native_calibrate_cpu_early,
 	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
 	.set_wallclock			= mach_set_rtc_mmss,
-- 
2.18.0
