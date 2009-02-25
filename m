Return-Path: <linux-kernel-owner+w=401wt.eu-S1762054AbZBYPNA@vger.kernel.org>
Message-Id: <20090225150833.020735391@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:43 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 21/46] Remove CONFIG_MACHCHK_WARNING.
Content-Disposition: inline; filename=120-machchk-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Everybody enables it so there is no point for an extra config option.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig      |    7 -------
 arch/s390/kernel/nmi.c |   29 +++++++++++------------------
 2 files changed, 11 insertions(+), 25 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -343,13 +343,6 @@ source "mm/Kconfig"
 
 comment "I/O subsystem configuration"
 
-config MACHCHK_WARNING
-	bool "Process warning machine checks"
-	help
-	  Select this option if you want the machine check handler on IBM S/390 or
-	  zSeries to process warning machine checks (e.g. on power failures).
-	  If unsure, say "Y".
-
 config QDIO
 	tristate "QDIO support"
 	---help---
Index: quilt-2.6/arch/s390/kernel/nmi.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/nmi.c
+++ quilt-2.6/arch/s390/kernel/nmi.c
@@ -59,28 +59,23 @@ void s390_handle_mcck(void)
 
 	if (mcck.channel_report)
 		crw_handle_channel_report();
-
-#ifdef CONFIG_MACHCHK_WARNING
-/*
- * The warning may remain for a prolonged period on the bare iron.
- * (actually till the machine is powered off, or until the problem is gone)
- * So we just stop listening for the WARNING MCH and prevent continuously
- * being interrupted.  One caveat is however, that we must do this per
- * processor and cannot use the smp version of ctl_clear_bit().
- * On VM we only get one interrupt per virtally presented machinecheck.
- * Though one suffices, we may get one interrupt per (virtual) processor.
- */
+	/*
+	 * A warning may remain for a prolonged period on the bare iron.
+	 * (actually until the machine is powered off, or the problem is gone)
+	 * So we just stop listening for the WARNING MCH and avoid continuously
+	 * being interrupted.  One caveat is however, that we must do this per
+	 * processor and cannot use the smp version of ctl_clear_bit().
+	 * On VM we only get one interrupt per virtally presented machinecheck.
+	 * Though one suffices, we may get one interrupt per (virtual) cpu.
+	 */
 	if (mcck.warning) {	/* WARNING pending ? */
 		static int mchchk_wng_posted = 0;
-		/*
-		 * Use single machine clear, as we cannot handle smp right now
-		 */
+
+		/* Use single cpu clear, as we cannot handle smp here. */
 		__ctl_clear_bit(14, 24);	/* Disable WARNING MCH */
 		if (xchg(&mchchk_wng_posted, 1) == 0)
 			kill_cad_pid(SIGPWR, 1);
 	}
-#endif
-
 	if (mcck.kill_task) {
 		local_irq_enable();
 		printk(KERN_EMERG "mcck: Terminating task because of machine "
@@ -375,9 +370,7 @@ static int __init machine_check_init(voi
 {
 	ctl_set_bit(14, 25);	/* enable external damage MCH */
 	ctl_set_bit(14, 27);	/* enable system recovery MCH */
-#ifdef CONFIG_MACHCHK_WARNING
 	ctl_set_bit(14, 24);	/* enable warning MCH */
-#endif
 	return 0;
 }
 arch_initcall(machine_check_init);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
