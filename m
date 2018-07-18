Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v14 21/25] x86/tsc: initialize cyc2ns when tsc freq. is determined
Date: Tue, 17 Jul 2018 22:22:07 -0400
Message-Id: <20180718022211.6259-22-pasha.tatashin@oracle.com>
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

cyc2ns converts tsc to nanoseconds, and it is handled in a per-cpu data
structure.

Currently, the setup code for c2ns data for every possible CPU goes through
the same sequence of calculations as for the boot CPU, but is based on the
same tsc frequency as the boot CPU, and thus this is not necessary.

Initialize the boot cpu when tsc frequency is determined. Copy the
calculated data from the boot CPU to the other CPUs in tsc_init().

In addition do the following:

- Remove unnecessary zeroing of c2ns data by removing cyc2ns_data_init()
- Split set_cyc2ns_scale() into two functions, so set_cyc2ns_scale() can be
  called when system is up, and wraps around __set_cyc2ns_scale() that can
  be called directly when system is booting but avoids saving restoring
  IRQs and going and waking up from idle.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 94 ++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index bc8eb82050a3..0b1abe7fdd8e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -103,23 +103,6 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static void cyc2ns_data_init(struct cyc2ns_data *data)
-{
-	data->cyc2ns_mul = 0;
-	data->cyc2ns_shift = 0;
-	data->cyc2ns_offset = 0;
-}
-
-static void __init cyc2ns_init(int cpu)
-{
-	struct cyc2ns *c2n = &per_cpu(cyc2ns, cpu);
-
-	cyc2ns_data_init(&c2n->data[0]);
-	cyc2ns_data_init(&c2n->data[1]);
-
-	seqcount_init(&c2n->seq);
-}
-
 static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
@@ -135,18 +118,11 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
 {
 	unsigned long long ns_now;
 	struct cyc2ns_data data;
 	struct cyc2ns *c2n;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	sched_clock_idle_sleep_event();
-
-	if (!khz)
-		goto done;
 
 	ns_now = cycles_2_ns(tsc_now);
 
@@ -178,12 +154,55 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
 	c2n->data[0] = data;
 	raw_write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+}
+
+static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	if (khz)
+		__set_cyc2ns_scale(khz, cpu, tsc_now);
 
-done:
 	sched_clock_idle_wakeup_event();
 	local_irq_restore(flags);
 }
 
+/*
+ * Initialize cyc2ns for boot cpu
+ */
+static void __init cyc2ns_init_boot_cpu(void)
+{
+	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
+
+	seqcount_init(&c2n->seq);
+	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
+}
+
+/*
+ * Secondary CPUs do not run through cyc2ns_init(), so set up
+ * all the scale factors for all CPUs, assuming the same
+ * speed as the bootup CPU. (cpufreq notifiers will fix this
+ * up if their speed diverges)
+ */
+static void __init cyc2ns_init_secondary_cpus(void)
+{
+	unsigned int cpu, this_cpu = smp_processor_id();
+	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
+	struct cyc2ns_data *data = c2n->data;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu != this_cpu) {
+			seqcount_init(&c2n->seq);
+			c2n = per_cpu_ptr(&cyc2ns, cpu);
+			c2n->data[0] = data[0];
+			c2n->data[1] = data[1];
+		}
+	}
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -1385,6 +1404,10 @@ void __init tsc_early_init(void)
 	if (!determine_cpu_tsc_frequncies())
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
+
+	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+	tsc_store_and_check_tsc_adjust(true);
+	cyc2ns_init_boot_cpu();
 }
 
 void __init tsc_init(void)
@@ -1400,23 +1423,12 @@ void __init tsc_init(void)
 			mark_tsc_unstable("could not calculate TSC khz");
 			return;
 		}
+		/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+		tsc_store_and_check_tsc_adjust(true);
+		cyc2ns_init_boot_cpu();
 	}
 
-	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-	tsc_store_and_check_tsc_adjust(true);
-
-	/*
-	 * Secondary CPUs do not run through tsc_init(), so set up
-	 * all the scale factors for all CPUs, assuming the same
-	 * speed as the bootup CPU. (cpufreq notifiers will fix this
-	 * up if their speed diverges)
-	 */
-	cyc = rdtsc();
-	for_each_possible_cpu(cpu) {
-		cyc2ns_init(cpu);
-		set_cyc2ns_scale(tsc_khz, cpu, cyc);
-	}
-
+	cyc2ns_init_secondary_cpus();
 	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
-- 
2.18.0
