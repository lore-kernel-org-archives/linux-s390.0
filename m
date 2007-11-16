Return-Path: <linux-kernel-owner+w=401wt.eu-S934627AbXKPO3v@vger.kernel.org>
Message-Id: <20071116142527.464813313@de.ibm.com>
References: <20071116142441.484714036@de.ibm.com>
Date: Fri, 16 Nov 2007 15:24:49 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/10] Dont overwrite lowcores on smp_send_stop().
Content-Disposition: inline; filename=008-lowcores.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Don't perform a sigp store-status-at-address on smp_send_stop().
It will overwrite the lowcores of other cpus and destroys valueable
debug informations.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |   56 ++++++-------------------------------------------
 1 file changed, 7 insertions(+), 49 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2007-11-16 14:27:30.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2007-11-16 14:27:44.000000000 +0100
@@ -193,72 +193,30 @@ int smp_call_function_single(int cpu, vo
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-static void do_send_stop(void)
+void smp_send_stop(void)
 {
 	int cpu, rc;
 
-	/* stop all processors */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
-		do {
-			rc = signal_processor(cpu, sigp_stop);
-		} while (rc == sigp_busy);
-	}
-}
+	/* Disable all interrupts/machine checks */
+	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
 
-static void do_store_status(void)
-{
-	int cpu, rc;
+	/* write magic number to zero page (absolute 0) */
+	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
 
-	/* store status of all processors in their lowcores (real 0) */
+	/* stop all processors */
 	for_each_online_cpu(cpu) {
 		if (cpu == smp_processor_id())
 			continue;
 		do {
-			rc = signal_processor_p(
-				(__u32)(unsigned long) lowcore_ptr[cpu], cpu,
-				sigp_store_status_at_address);
+			rc = signal_processor(cpu, sigp_stop);
 		} while (rc == sigp_busy);
-	}
-}
 
-static void do_wait_for_stop(void)
-{
-	int cpu;
-
-	/* Wait for all other cpus to enter stopped state */
-	for_each_online_cpu(cpu) {
-		if (cpu == smp_processor_id())
-			continue;
 		while (!smp_cpu_not_running(cpu))
 			cpu_relax();
 	}
 }
 
 /*
- * this function sends a 'stop' sigp to all other CPUs in the system.
- * it goes straight through.
- */
-void smp_send_stop(void)
-{
-	/* Disable all interrupts/machine checks */
-	__load_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK);
-
-	/* write magic number to zero page (absolute 0) */
-	lowcore_ptr[smp_processor_id()]->panic_magic = __PANIC_MAGIC;
-
-	/* stop other processors. */
-	do_send_stop();
-
-	/* wait until other processors are stopped */
-	do_wait_for_stop();
-
-	/* store status of other processors. */
-	do_store_status();
-}
-
-/*
  * Reboot, halt and power_off routines for SMP.
  */
 void machine_restart_smp(char *__unused)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
