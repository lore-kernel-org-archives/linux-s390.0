Return-Path: <linux-kernel-owner+w=401wt.eu-S1755986AbYJAJDy@vger.kernel.org>
Message-Id: <20081001084129.581466549@de.ibm.com>
References: <20081001083317.782967473@de.ibm.com>
Date: Wed, 01 Oct 2008 10:33:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 17/21] nohz: Fix __udelay.
Content-Disposition: inline; filename=116-udelay-torture.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

rcutorture reveals that our __udelay implementation is still buggy,
since it might schedule tasklets, but prevents their execution:

NOHZ: local_softirq_pending 42
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 142
NOHZ: local_softirq_pending 02

To fix this we make sure that only the clock comparator interrupt
is enabled when the enabled wait psw is loaded.
Also no code gets called anymore which might schedule tasklets.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |    2 +
 arch/s390/lib/delay.c   |   88 +++++++++++++++++++++++++++++-------------------
 2 files changed, 56 insertions(+), 34 deletions(-)

Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -169,6 +169,8 @@ void init_cpu_timer(void)
 
 static void clock_comparator_interrupt(__u16 code)
 {
+	if (S390_lowcore.clock_comparator == -1ULL)
+		set_clock_comparator(S390_lowcore.clock_comparator);
 }
 
 static void etr_timing_alert(struct etr_irq_parm *);
Index: quilt-2.6/arch/s390/lib/delay.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/delay.c
+++ quilt-2.6/arch/s390/lib/delay.c
@@ -1,14 +1,9 @@
 /*
- *  arch/s390/lib/delay.c
  *    Precise Delay Loops for S390
  *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *
- *  Derived from "arch/i386/lib/delay.c"
- *    Copyright (C) 1993 Linus Torvalds
- *    Copyright (C) 1997 Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ *    Copyright IBM Corp. 1999,2008
+ *    Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
  */
 
 #include <linux/sched.h>
@@ -29,30 +24,31 @@ void __delay(unsigned long loops)
 	asm volatile("0: brct %0,0b" : : "d" ((loops/2) + 1));
 }
 
-/*
- * Waits for 'usecs' microseconds using the TOD clock comparator.
- */
-void __udelay(unsigned long usecs)
+static void __udelay_disabled(unsigned long usecs)
 {
-	u64 end, time, old_cc = 0;
-	unsigned long flags, cr0, mask, dummy;
-	int irq_context;
+	unsigned long mask, cr0, cr0_saved;
+	u64 clock_saved;
 
-	irq_context = in_interrupt();
-	if (!irq_context)
-		local_bh_disable();
-	local_irq_save(flags);
-	if (raw_irqs_disabled_flags(flags)) {
-		old_cc = local_tick_disable();
-		S390_lowcore.clock_comparator = -1ULL;
-		__ctl_store(cr0, 0, 0);
-		dummy = (cr0 & 0xffff00e0) | 0x00000800;
-		__ctl_load(dummy , 0, 0);
-		mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT;
-	} else
-		mask = psw_kernel_bits | PSW_MASK_WAIT |
-			PSW_MASK_EXT | PSW_MASK_IO;
+	clock_saved = local_tick_disable();
+	set_clock_comparator(get_clock() + ((u64) usecs << 12));
+	__ctl_store(cr0_saved, 0, 0);
+	cr0 = (cr0_saved & 0xffff00e0) | 0x00000800;
+	__ctl_load(cr0 , 0, 0);
+	mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT;
+	trace_hardirqs_on();
+	__load_psw_mask(mask);
+	local_irq_disable();
+	__ctl_load(cr0_saved, 0, 0);
+	local_tick_enable(clock_saved);
+	set_clock_comparator(S390_lowcore.clock_comparator);
+}
 
+static void __udelay_enabled(unsigned long usecs)
+{
+	unsigned long mask;
+	u64 end, time;
+
+	mask = psw_kernel_bits | PSW_MASK_WAIT | PSW_MASK_EXT | PSW_MASK_IO;
 	end = get_clock() + ((u64) usecs << 12);
 	do {
 		time = end < S390_lowcore.clock_comparator ?
@@ -62,13 +58,37 @@ void __udelay(unsigned long usecs)
 		__load_psw_mask(mask);
 		local_irq_disable();
 	} while (get_clock() < end);
+	set_clock_comparator(S390_lowcore.clock_comparator);
+}
 
-	if (raw_irqs_disabled_flags(flags)) {
-		__ctl_load(cr0, 0, 0);
-		local_tick_enable(old_cc);
+/*
+ * Waits for 'usecs' microseconds using the TOD clock comparator.
+ */
+void __udelay(unsigned long usecs)
+{
+	unsigned long flags;
+
+	preempt_disable();
+	local_irq_save(flags);
+	if (in_irq()) {
+		__udelay_disabled(usecs);
+		goto out;
+	}
+	if (in_softirq()) {
+		if (raw_irqs_disabled_flags(flags))
+			__udelay_disabled(usecs);
+		else
+			__udelay_enabled(usecs);
+		goto out;
 	}
-	if (!irq_context)
+	if (raw_irqs_disabled_flags(flags)) {
+		local_bh_disable();
+		__udelay_disabled(usecs);
 		_local_bh_enable();
-	set_clock_comparator(S390_lowcore.clock_comparator);
+		goto out;
+	}
+	__udelay_enabled(usecs);
+out:
 	local_irq_restore(flags);
+	preempt_enable();
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
