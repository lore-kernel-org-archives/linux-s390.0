Return-Path: <linux-kernel-owner+w=401wt.eu-S1756992AbYBEPkn@vger.kernel.org>
Message-Id: <20080205153912.500327574@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/18] Fix smp_call_function_mask semantics.
Content-Disposition: inline; filename=007-smp-call.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Make sure func isn't called on the local cpu just like on all other
architectures that implement this function.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -225,12 +225,11 @@ EXPORT_SYMBOL(smp_call_function_single);
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler.
  */
-int
-smp_call_function_mask(cpumask_t mask,
-			void (*func)(void *), void *info,
-			int wait)
+int smp_call_function_mask(cpumask_t mask, void (*func)(void *), void *info,
+			   int wait)
 {
 	preempt_disable();
+	cpu_clear(smp_processor_id(), mask);
 	__smp_call_function_map(func, info, 0, wait, mask);
 	preempt_enable();
 	return 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
