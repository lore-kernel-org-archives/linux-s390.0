Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH v2] s390/cpum_sf: Remove superfluous SMP function call
Date: Mon,  2 May 2016 11:00:12 +0200
Message-Id: <1462179612-55035-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since commit 3b9d6da67e11 ("cpu/hotplug: Fix rollback during error-out
in __cpu_disable()") it is ensured that callbacks of CPU_ONLINE and
CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
function calls are no longer required.

Replace smp_call_function_single() with a direct call of
setup_pmc_cpu(). To keep the calling convention, interrupts are
explicitly disabled around the call.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
Changes in v2:
	- Adapt referenced commit in commit message

 arch/s390/kernel/perf_cpum_sf.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1510,7 +1510,6 @@ static void cpumf_measurement_alert(stru
 static int cpumf_pmu_notifier(struct notifier_block *self,
 			      unsigned long action, void *hcpu)
 {
-	unsigned int cpu = (long) hcpu;
 	int flags;
 
 	/* Ignore the notification if no events are scheduled on the PMU.
@@ -1523,11 +1522,15 @@ static int cpumf_pmu_notifier(struct not
 	case CPU_ONLINE:
 	case CPU_DOWN_FAILED:
 		flags = PMC_INIT;
-		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
+		local_irq_disable();
+		setup_pmc_cpu(&flags);
+		local_irq_enable();
 		break;
 	case CPU_DOWN_PREPARE:
 		flags = PMC_RELEASE;
-		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
+		local_irq_disable();
+		setup_pmc_cpu(&flags);
+		local_irq_enable();
 		break;
 	default:
 		break;
