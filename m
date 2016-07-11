Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20160711122532.208739332@linutronix.de>
Date: Mon, 11 Jul 2016 12:28:37 -0000
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch 19/66] s390: perf: Convert the hotplug notifier to state
 machine callbacks (Sampling)
References: <20160711122450.923603742@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=0019-s390-perf-Convert-the-hotplug-notifier-to-state-mach.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine and let the core invoke the
callbacks on the already online CPUs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

---
 arch/s390/kernel/perf_cpum_sf.c |   43 ++++++++++++++++------------------------
 include/linux/cpuhotplug.h      |    1 
 2 files changed, 19 insertions(+), 25 deletions(-)

--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1506,37 +1506,28 @@ static void cpumf_measurement_alert(stru
 		sf_disable();
 	}
 }
-
-static int cpumf_pmu_notifier(struct notifier_block *self,
-			      unsigned long action, void *hcpu)
+static int cpusf_pmu_setup(unsigned int cpu, int flags)
 {
-	int flags;
-
 	/* Ignore the notification if no events are scheduled on the PMU.
 	 * This might be racy...
 	 */
 	if (!atomic_read(&num_events))
-		return NOTIFY_OK;
+		return 0;
 
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
 
-	return NOTIFY_OK;
+static int s390_pmu_sf_online_cpu(unsigned int cpu)
+{
+	return cpusf_pmu_setup(cpu, PMC_INIT);
+}
+
+static int s390_pmu_sf_offline_cpu(unsigned int cpu)
+{
+	return cpusf_pmu_setup(cpu, PMC_RELEASE);
 }
 
 static int param_get_sfb_size(char *buffer, const struct kernel_param *kp)
@@ -1636,7 +1627,9 @@ static int __init init_cpum_sampling_pmu
 					cpumf_measurement_alert);
 		goto out;
 	}
-	perf_cpu_notifier(cpumf_pmu_notifier);
+
+	cpuhp_setup_state(CPUHP_AP_PERF_S390_SF_ONLINE, "AP_PERF_S390_SF_ONLINE",
+			  s390_pmu_sf_online_cpu, s390_pmu_sf_offline_cpu);
 out:
 	return err;
 }
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -43,6 +43,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CQM_ONLINE,
 	CPUHP_AP_PERF_X86_CSTATE_ONLINE,
 	CPUHP_AP_PERF_S390_CF_ONLINE,
+	CPUHP_AP_PERF_S390_SF_ONLINE,
 	CPUHP_AP_NOTIFY_ONLINE,
 	CPUHP_AP_ONLINE_DYN,
 	CPUHP_AP_ONLINE_DYN_END		= CPUHP_AP_ONLINE_DYN + 30,
