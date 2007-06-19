Return-Path: <linux-kernel-owner+w=401wt.eu-S1756881AbXFSIqX@vger.kernel.org>
Message-Id: <20070619084641.914438035@de.ibm.com>
References: <20070619084516.457715754@de.ibm.com>
Date: Tue, 19 Jun 2007 10:45:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] Fix yet another two section mismatches.
Content-Disposition: inline; filename=003-sections.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

WARNING: arch/s390/kernel/built-in.o(.text+0xb92a):
	 Section mismatch: reference to .init.text:start_secondary
	 (between 'restart_addr' and 'stack_overflow')
WARNING: arch/s390/appldata/built-in.o(.data+0xdc):
	 Section mismatch: reference to .init.text:
	 (between 'appldata_nb' and 'appldata_timer_lock')

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    5 ++---
 arch/s390/kernel/entry.S           |    8 +++++++-
 arch/s390/kernel/entry64.S         |    8 +++++++-
 3 files changed, 16 insertions(+), 5 deletions(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -535,8 +535,7 @@ void appldata_unregister_ops(struct appl
 
 /******************************* init / exit *********************************/
 
-static void
-appldata_online_cpu(int cpu)
+static void __cpuinit appldata_online_cpu(int cpu)
 {
 	init_virt_timer(&per_cpu(appldata_timer, cpu));
 	per_cpu(appldata_timer, cpu).function = appldata_timer_function;
@@ -580,7 +579,7 @@ appldata_cpu_notify(struct notifier_bloc
 	return NOTIFY_OK;
 }
 
-static struct notifier_block appldata_nb = {
+static struct notifier_block __cpuinitdata appldata_nb = {
 	.notifier_call = appldata_cpu_notify,
 };
 
Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S
+++ quilt-2.6/arch/s390/kernel/entry64.S
@@ -745,10 +745,13 @@ mcck_return:
 #endif
 	lpswe	__LC_RETURN_MCCK_PSW	# back to caller
 
-#ifdef CONFIG_SMP
 /*
  * Restart interruption handler, kick starter for additional CPUs
  */
+#ifdef CONFIG_SMP
+#ifndef CONFIG_HOTPLUG_CPU
+	.section .init.text,"ax"
+#endif
 	.globl restart_int_handler
 restart_int_handler:
 	lg	%r15,__LC_SAVE_AREA+120 # load ksp
@@ -759,6 +762,9 @@ restart_int_handler:
 	lmg	%r6,%r15,__SF_GPRS(%r15) # load registers from clone
 	stosm	__SF_EMPTY(%r15),0x04	# now we can turn dat on
 	jg	start_secondary
+#ifndef CONFIG_HOTPLUG_CPU
+	.previous
+#endif
 #else
 /*
  * If we do not run with SMP enabled, let the new CPU crash ...
Index: quilt-2.6/arch/s390/kernel/entry.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry.S
+++ quilt-2.6/arch/s390/kernel/entry.S
@@ -769,10 +769,13 @@ mcck_return:
 
 	RESTORE_ALL __LC_RETURN_MCCK_PSW,0
 
-#ifdef CONFIG_SMP
 /*
  * Restart interruption handler, kick starter for additional CPUs
  */
+#ifdef CONFIG_SMP
+#ifndef CONFIG_HOTPLUG_CPU
+	.section .init.text,"ax"
+#endif
 	.globl restart_int_handler
 restart_int_handler:
 	l	%r15,__LC_SAVE_AREA+60	# load ksp
@@ -785,6 +788,9 @@ restart_int_handler:
 	br	%r14			# branch to start_secondary
 restart_addr:
 	.long	start_secondary
+#ifndef CONFIG_HOTPLUG_CPU
+	.previous
+#endif
 #else
 /*
  * If we do not run with SMP enabled, let the new CPU crash ...

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
