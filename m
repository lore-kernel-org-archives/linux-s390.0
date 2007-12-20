Return-Path: <linux-kernel-owner+w=401wt.eu-S966316AbXLTPk6@vger.kernel.org>
Message-Id: <20071220152107.926027882@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 22/47] Print kernel version in dump_stack() and show_regs().
Content-Disposition: inline; filename=121-version-printk.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Also print PREEMPT and/or SMP if the kernel was configured that way.
Makes s390 look a bit more like other architectures.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |   18 ++++++++++--------
 arch/s390/kernel/traps.c   |   20 +++++++++++++++++---
 2 files changed, 27 insertions(+), 11 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -36,7 +36,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
-
+#include <linux/utsname.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -182,13 +182,15 @@ void cpu_idle(void)
 
 void show_regs(struct pt_regs *regs)
 {
-	struct task_struct *tsk = current;
-
-        printk("CPU:    %d    %s\n", task_thread_info(tsk)->cpu, print_tainted());
-        printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
-	       current->comm, task_pid_nr(current), (void *) tsk,
-	       (void *) tsk->thread.ksp);
-
+	print_modules();
+	printk("CPU: %d %s %s %.*s\n",
+	       task_thread_info(current)->cpu, print_tainted(),
+	       init_utsname()->release,
+	       (int)strcspn(init_utsname()->version, " "),
+	       init_utsname()->version);
+	printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
+	       current->comm, current->pid, current,
+	       (void *) current->thread.ksp);
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/reboot.h>
 #include <linux/kprobes.h>
 #include <linux/bug.h>
+#include <linux/utsname.h>
 #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -168,9 +169,16 @@ void show_stack(struct task_struct *task
  */
 void dump_stack(void)
 {
+	printk("CPU: %d %s %s %.*s\n",
+	       task_thread_info(current)->cpu, print_tainted(),
+	       init_utsname()->release,
+	       (int)strcspn(init_utsname()->version, " "),
+	       init_utsname()->version);
+	printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
+	       current->comm, current->pid, current,
+	       (void *) current->thread.ksp);
 	show_stack(NULL, NULL);
 }
-
 EXPORT_SYMBOL(dump_stack);
 
 static inline int mask_bits(struct pt_regs *regs, unsigned long bits)
@@ -258,8 +266,14 @@ void die(const char * str, struct pt_reg
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
-	print_modules();
+	printk("%s: %04lx [#%d] ", str, err & 0xffff, ++die_counter);
+#ifdef CONFIG_PREEMPT
+	printk("PREEMPT ");
+#endif
+#ifdef CONFIG_SMP
+	printk("SMP");
+#endif
+	printk("\n");
 	notify_die(DIE_OOPS, str, regs, err, current->thread.trap_no, SIGSEGV);
 	show_regs(regs);
 	bust_spinlocks(0);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
