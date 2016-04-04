Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH] s390/cpum_cf: Remove superfluous SMP function call
Date: Mon,  4 Apr 2016 12:27:45 +0200
Message-Id: <1459765665-13649-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
CPU_DOWN_PREPARE are processed on the hotplugged CPU. Due to this SMP
function calls are no longer required.

Replace smp_call_function_single() with a direct call of
setup_pmc_cpu(). To keep the calling convention, interrupts are
explicitely disabled around the call.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/s390/kernel/perf_cpum_cf.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -665,18 +665,21 @@ static struct pmu cpumf_pmu = {
 static int cpumf_pmu_notifier(struct notifier_block *self, unsigned long action,
 			      void *hcpu)
 {
-	unsigned int cpu = (long) hcpu;
 	int flags;
 
 	switch (action & ~CPU_TASKS_FROZEN) {
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
