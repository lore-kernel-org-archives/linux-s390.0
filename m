Return-Path: <linux-kernel-owner+w=401wt.eu-S1761223AbYD2OQw@vger.kernel.org>
Message-Id: <20080429140248.892514700@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/15] Move show_regs to traps.c.
Content-Disposition: inline; filename=002-showregs.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

This is where it should be and we can get rid of some externs
and a static inline function.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c   |   18 ------------------
 arch/s390/kernel/traps.c     |   26 ++++++++++++++++++++++----
 include/asm-s390/processor.h |    9 ---------
 3 files changed, 22 insertions(+), 31 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -180,24 +180,6 @@ void cpu_idle(void)
 	}
 }
 
-void show_regs(struct pt_regs *regs)
-{
-	print_modules();
-	printk("CPU: %d %s %s %.*s\n",
-	       task_thread_info(current)->cpu, print_tainted(),
-	       init_utsname()->release,
-	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
-	printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
-	       current->comm, current->pid, current,
-	       (void *) current->thread.ksp);
-	show_registers(regs);
-	/* Show stack backtrace if pt_regs is from kernel mode */
-	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		show_trace(NULL, (unsigned long *) regs->gprs[15]);
-	show_last_breaking_event(regs);
-}
-
 extern void kernel_thread_starter(void);
 
 asm(
Index: quilt-2.6/arch/s390/kernel/traps.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/traps.c
+++ quilt-2.6/arch/s390/kernel/traps.c
@@ -113,7 +113,7 @@ __show_trace(unsigned long sp, unsigned 
 	}
 }
 
-void show_trace(struct task_struct *task, unsigned long *stack)
+static void show_trace(struct task_struct *task, unsigned long *stack)
 {
 	register unsigned long __r15 asm ("15");
 	unsigned long sp;
@@ -161,14 +161,14 @@ void show_stack(struct task_struct *task
 	show_trace(task, sp);
 }
 
-#ifdef CONFIG_64BIT
-void show_last_breaking_event(struct pt_regs *regs)
+static void show_last_breaking_event(struct pt_regs *regs)
 {
+#ifdef CONFIG_64BIT
 	printk("Last Breaking-Event-Address:\n");
 	printk(" [<%016lx>] ", regs->args[0] & PSW_ADDR_INSN);
 	print_symbol("%s\n", regs->args[0] & PSW_ADDR_INSN);
-}
 #endif
+}
 
 /*
  * The architecture-independent dump_stack generator
@@ -223,6 +223,24 @@ void show_registers(struct pt_regs *regs
 	show_code(regs);
 }	
 
+void show_regs(struct pt_regs *regs)
+{
+	print_modules();
+	printk("CPU: %d %s %s %.*s\n",
+	       task_thread_info(current)->cpu, print_tainted(),
+	       init_utsname()->release,
+	       (int)strcspn(init_utsname()->version, " "),
+	       init_utsname()->version);
+	printk("Process %s (pid: %d, task: %p, ksp: %p)\n",
+	       current->comm, current->pid, current,
+	       (void *) current->thread.ksp);
+	show_registers(regs);
+	/* Show stack backtrace if pt_regs is from kernel mode */
+	if (!(regs->psw.mask & PSW_MASK_PSTATE))
+		show_trace(NULL, (unsigned long *) regs->gprs[15]);
+	show_last_breaking_event(regs);
+}
+
 /* This is called from fs/proc/array.c */
 void task_show_regs(struct seq_file *m, struct task_struct *task)
 {
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -172,16 +172,7 @@ extern unsigned long thread_saved_pc(str
  */
 extern void task_show_regs(struct seq_file *m, struct task_struct *task);
 
-extern void show_registers(struct pt_regs *regs);
 extern void show_code(struct pt_regs *regs);
-extern void show_trace(struct task_struct *task, unsigned long *sp);
-#ifdef CONFIG_64BIT
-extern void show_last_breaking_event(struct pt_regs *regs);
-#else
-static inline void show_last_breaking_event(struct pt_regs *regs)
-{
-}
-#endif
 
 unsigned long get_wchan(struct task_struct *p);
 #define task_pt_regs(tsk) ((struct pt_regs *) \

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
