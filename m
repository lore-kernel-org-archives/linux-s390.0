Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20160713153334.436370635@linutronix.de>
Date: Wed, 13 Jul 2016 17:16:21 -0000
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch V2 19/67] s390/perf: Convert the hotplug notifier to state
 machine callbacks (Counter)
References: <20160713153219.128052238@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=0018-s390-perf-Convert-the-hotplug-notifier-to-state-mach.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Adam Buchbinder <adam.buchbinder@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Install the callbacks via the state machine and let the core invoke
the callbacks on the already online CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Adam Buchbinder <adam.buchbinder@gmail.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/s390/kernel/perf_cpum_cf.c | 46 +++++++++++++++++------------------------
 include/linux/cpuhotplug.h      |  1 +
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 7ec63b1..037c2a2 100644
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
-
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
+	local_irq_disable();
+	setup_pmc_cpu(&flags);
+	local_irq_enable();
+	return 0;
+}
+
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
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index b265e99..d4e09cb 100644
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
-- 
2.8.1
