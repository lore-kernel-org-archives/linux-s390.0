Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v13 04/18] x86/tsc: redefine notsc to behave as tsc=unstable
Date: Wed, 11 Jul 2018 20:04:05 -0400
Message-Id: <20180712000419.5165-5-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

Currently, notsc kernel parameter disables the use of tsc register by
sched_clock(). However, this parameter does not prevent linux from
accessing tsc in other places in kernel.

The only rational to boot with notsc is to avoid timing discrepancies on
multi-socket systems where different tsc frequencies may present, and thus
fallback to jiffies for clock source.

However, there is another method to solve the above problem, it is to boot
with tsc=unstable parameter. This parameter allows sched_clock() to use tsc
but in case tsc is outside of expected interval it is corrected back to a
sane value.

This is why there is no reason to keep notsc, and it can be removed. But,
for compatibility reasons we will keep this parameter but change its
definition to be the same as tsc=unstable.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 .../admin-guide/kernel-parameters.txt          |  2 --
 Documentation/x86/x86_64/boot-options.txt      |  4 +---
 arch/x86/kernel/tsc.c                          | 18 +++---------------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..f7123d28f318 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2835,8 +2835,6 @@
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
-	notsc		[BUGS=X86-32] Disable Time Stamp Counter
-
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index 8d109ef67ab6..66114ab4f9fe 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -92,9 +92,7 @@ APICs
 Timing
 
   notsc
-  Don't use the CPU time stamp counter to read the wall time.
-  This can be used to work around timing problems on multiprocessor systems
-  with not properly synchronized CPUs.
+  Deprecated, use tsc=unstable instead.
 
   nohpet
   Don't use the HPET timer.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9d51e0..186395041725 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -38,11 +38,6 @@ EXPORT_SYMBOL(tsc_khz);
  */
 static int __read_mostly tsc_unstable;
 
-/* native_sched_clock() is called before tsc_init(), so
-   we must start with the TSC soft disabled to prevent
-   erroneous rdtsc usage on !boot_cpu_has(X86_FEATURE_TSC) processors */
-static int __read_mostly tsc_disabled = -1;
-
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
@@ -248,8 +243,7 @@ EXPORT_SYMBOL_GPL(check_tsc_unstable);
 #ifdef CONFIG_X86_TSC
 int __init notsc_setup(char *str)
 {
-	pr_warn("Kernel compiled with CONFIG_X86_TSC, cannot disable TSC completely\n");
-	tsc_disabled = 1;
+	mark_tsc_unstable("boot parameter notsc");
 	return 1;
 }
 #else
@@ -1307,7 +1301,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 static int __init init_tsc_clocksource(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
+	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
 		return 0;
 
 	if (tsc_unstable)
@@ -1414,12 +1408,6 @@ void __init tsc_init(void)
 		set_cyc2ns_scale(tsc_khz, cpu, cyc);
 	}
 
-	if (tsc_disabled > 0)
-		return;
-
-	/* now allow native_sched_clock() to use rdtsc */
-
-	tsc_disabled = 0;
 	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
@@ -1455,7 +1443,7 @@ unsigned long calibrate_delay_is_known(void)
 	int constant_tsc = cpu_has(&cpu_data(cpu), X86_FEATURE_CONSTANT_TSC);
 	const struct cpumask *mask = topology_core_cpumask(cpu);
 
-	if (tsc_disabled || !constant_tsc || !mask)
+	if (!constant_tsc || !mask)
 		return 0;
 
 	sibling = cpumask_any_but(mask, cpu);
-- 
2.18.0
