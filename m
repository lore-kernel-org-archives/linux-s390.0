Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20160711122532.121846277@linutronix.de>
Date: Mon, 11 Jul 2016 12:28:36 -0000
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch 18/66] s390: perf: Convert the hotplug notifier to state
 machine callbacks (Counter)
References: <20160711122450.923603742@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=0018-s390-perf-Convert-the-hotplug-notifier-to-state-mach.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/s390/kernel/perf_cpum_cf.c |   44 ++++++++++++++++------------------------
 include/linux/cpuhotplug.h      |    1 
 2 files changed, 19 insertions(+), 26 deletions(-)

--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -664,30 +664,22 @@ static struct pmu cpumf_pmu = {
 	.cancel_txn   = cpumf_pmu_cancel_txn,
 };
 
-static int cpumf_pmu_notifier(struct notifier_block *self, unsigned long action,
-			      void *hcpu)
+static int cpumf_pmf_setup(unsigned int cpu, int flags)
 {
-	int flags;
+	local_irq_disable();
+	setup_pmc_cpu(&flags);
+	local_irq_enable();
+	return 0;
+}
 
-	switch (action & ~CPU_TASKS_FROZEN) {
-	case CPU_ONLINE:
-	case CPU_DOWN_FAILED:
-		flags = PMC_INIT;
-		local_irq_disable();
-		setup_pmc_cpu(&flags);
-		local_irq_enable();
-		break;
-	case CPU_DOWN_PREPARE:
-		flags = PMC_RELEASE;
-		local_irq_disable();
-		setup_pmc_cpu(&flags);
-		local_irq_enable();
-		break;
-	default:
-		break;
-	}
+static int s390_pmu_online_cpu(unsigned int cpu)
+{
+	return cpumf_pmf_setup(cpu, PMC_INIT);
+}
 
-	return NOTIFY_OK;
+static int s390_pmu_offline_cpu(unsigned int cpu)
+{
+	return cpumf_pmf_setup(cpu, PMC_RELEASE);
 }
 
 static int __init cpumf_pmu_init(void)
@@ -707,7 +699,7 @@ static int __init cpumf_pmu_init(void)
 	if (rc) {
 		pr_err("Registering for CPU-measurement alerts "
 		       "failed with rc=%i\n", rc);
-		goto out;
+		return rc;
 	}
 
 	cpumf_pmu.attr_groups = cpumf_cf_event_group();
@@ -716,10 +708,10 @@ static int __init cpumf_pmu_init(void)
 		pr_err("Registering the cpum_cf PMU failed with rc=%i\n", rc);
 		unregister_external_irq(EXT_IRQ_MEASURE_ALERT,
 					cpumf_measurement_alert);
-		goto out;
+		return rc;
 	}
-	perf_cpu_notifier(cpumf_pmu_notifier);
-out:
-	return rc;
+	return cpuhp_setup_state(CPUHP_AP_PERF_S390_CF_ONLINE,
+				 "AP_PERF_S390_CF_ONLINE",
+				 s390_pmu_online_cpu, s390_pmu_offline_cpu);
 }
 early_initcall(cpumf_pmu_init);
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -42,6 +42,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_RAPL_ONLINE,
 	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
+	CPUHP_AP_PERF_S390_CF_ONLINE,
 	CPUHP_AP_NOTIFY_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
