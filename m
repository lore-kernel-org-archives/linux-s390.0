Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH 1/2] s390/cpum_cf: Fix missing cpu hotplug notifier transition
Date: Fri, 11 Mar 2016 11:52:37 +0100
Message-Id: <1457693558-45970-2-git-send-email-anna-maria@linutronix.de>
In-Reply-To: <1457693558-45970-1-git-send-email-anna-maria@linutronix.de>
References: <1457693558-45970-1-git-send-email-anna-maria@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

The cpumf_pmu_notfier() hotplug callback lacks handling of the
CPU_DOWN_FAILED case. That means, if CPU_DOWN_PREPARE failes, the PMC
of the CPU is not setup again.

Add handling for CPU_DOWN_FAILED transition to setup the PMC of the
CPU.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
---
 arch/s390/kernel/perf_cpum_cf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -670,6 +670,7 @@ static int cpumf_pmu_notifier(struct not
 
 	switch (action & ~CPU_TASKS_FROZEN) {
 	case CPU_ONLINE:
+	case CPU_DOWN_FAILED:
 		flags = PMC_INIT;
 		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
 		break;
