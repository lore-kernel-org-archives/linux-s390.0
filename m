Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20160713153334.518084858@linutronix.de>
Date: Wed, 13 Jul 2016 17:16:22 -0000
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [patch V2 20/67] s390/perf: Convert the hotplug notifier to state
 machine callbacks (Sampling)
References: <20160713153219.128052238@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=0019-s390-perf-Convert-the-hotplug-notifier-to-state-mach.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, rt@linutronix.de, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Install the callbacks via the state machine and let the core invoke the
callbacks on the already online CPUs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/s390/kernel/perf_cpum_sf.c | 45 +++++++++++++++++------------------------
 include/linux/cpuhotplug.h      |  1 +
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index a8e8321..f4a4c11 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1506,37 +1506,28 @@ static void cpumf_measurement_alert(struct ext_code ext_code,
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
+		return 0;
 
-	return NOTIFY_OK;
+	local_irq_disable();
+	setup_pmc_cpu(&flags);
+	local_irq_enable();
+	return 0;
+}
+
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
@@ -1636,7 +1627,9 @@ static int __init init_cpum_sampling_pmu(void)
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
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index d4e09cb..fea6666 100644
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
-- 
2.8.1
