Return-Path: <linux-kernel-owner+w=401wt.eu-S1760905AbYEOPFH@vger.kernel.org>
Message-Id: <20080515150009.822888309@de.ibm.com>
References: <20080515145705.188435204@de.ibm.com>
Date: Thu, 15 May 2008 16:57:15 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/11] smp: __smp_call_function_map vs cpu_online_map fix.
Content-Disposition: inline; filename=010-smp-call-lock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Both smp_call_function() and __smp_call_function_map() access
cpu_online_map. Both functions run with preemption disabled which
protects for cpus going offline. However new cpus can be added and
therefore the cpu_online_map can change unexpectedly.
So use the call_lock to protect against changes to the cpu_online_map
in start_secondary() and all smp_call_* functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -139,7 +139,6 @@ static void __smp_call_function_map(void
 	if (wait)
 		data.finished = CPU_MASK_NONE;
 
-	spin_lock(&call_lock);
 	call_data = &data;
 
 	for_each_cpu_mask(cpu, map)
@@ -151,7 +150,6 @@ static void __smp_call_function_map(void
 	if (wait)
 		while (!cpus_equal(map, data.finished))
 			cpu_relax();
-	spin_unlock(&call_lock);
 out:
 	if (local) {
 		local_irq_disable();
@@ -177,11 +175,11 @@ int smp_call_function(void (*func) (void
 {
 	cpumask_t map;
 
-	preempt_disable();
+	spin_lock(&call_lock);
 	map = cpu_online_map;
 	cpu_clear(smp_processor_id(), map);
 	__smp_call_function_map(func, info, nonatomic, wait, map);
-	preempt_enable();
+	spin_unlock(&call_lock);
 	return 0;
 }
 EXPORT_SYMBOL(smp_call_function);
@@ -202,10 +200,10 @@ EXPORT_SYMBOL(smp_call_function);
 int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 			     int nonatomic, int wait)
 {
-	preempt_disable();
+	spin_lock(&call_lock);
 	__smp_call_function_map(func, info, nonatomic, wait,
 				cpumask_of_cpu(cpu));
-	preempt_enable();
+	spin_unlock(&call_lock);
 	return 0;
 }
 EXPORT_SYMBOL(smp_call_function_single);
@@ -228,10 +226,10 @@ EXPORT_SYMBOL(smp_call_function_single);
 int smp_call_function_mask(cpumask_t mask, void (*func)(void *), void *info,
 			   int wait)
 {
-	preempt_disable();
+	spin_lock(&call_lock);
 	cpu_clear(smp_processor_id(), mask);
 	__smp_call_function_map(func, info, 0, wait, mask);
-	preempt_enable();
+	spin_unlock(&call_lock);
 	return 0;
 }
 EXPORT_SYMBOL(smp_call_function_mask);
@@ -592,7 +590,9 @@ int __cpuinit start_secondary(void *cpuv
 	pfault_init();
 
 	/* Mark this cpu as online */
+	spin_lock(&call_lock);
 	cpu_set(smp_processor_id(), cpu_online_map);
+	spin_unlock(&call_lock);
 	/* Switch on interrupts */
 	local_irq_enable();
 	/* Print info about this processor */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
