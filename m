Return-Path: <linux-kernel-owner+w=401wt.eu-S1765371AbXGWIyn@vger.kernel.org>
Message-Id: <20070723085640.135097226@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/9] Improve __smp_call_function_map.
Content-Disposition: inline; filename=002-smp-call.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

There is no need to disable bottom halves when holding call_lock. Also
this could imply that it is legal to call smp_call_function* from
bh context, which it is not.
Also test if func will be executed locally before disabling
and aterwards enabling interrupts again. It's not necessary to disable
and enable interrupts each time __smp_call_function_map gets called.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -120,7 +120,7 @@ static void __smp_call_function_map(void
 	if (wait)
 		data.finished = CPU_MASK_NONE;
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 
 	for_each_cpu_mask(cpu, map)
@@ -129,18 +129,16 @@ static void __smp_call_function_map(void
 	/* Wait for response */
 	while (!cpus_equal(map, data.started))
 		cpu_relax();
-
 	if (wait)
 		while (!cpus_equal(map, data.finished))
 			cpu_relax();
-
-	spin_unlock_bh(&call_lock);
-
+	spin_unlock(&call_lock);
 out:
-	local_irq_disable();
-	if (local)
+	if (local) {
+		local_irq_disable();
 		func(info);
-	local_irq_enable();
+		local_irq_enable();
+	}
 }
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
