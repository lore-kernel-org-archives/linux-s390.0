Return-Path: <linux-kernel-owner+w=401wt.eu-S1758543AbYBEPmr@vger.kernel.org>
Message-Id: <20080205153914.533265710@de.ibm.com>
References: <20080205153835.337897404@de.ibm.com>
Date: Tue, 05 Feb 2008 16:38:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/18] latencytop s390 support.
Content-Disposition: inline; filename=013-latency-s390.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Holger Wolf <wolf@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Cc: Holger Wolf <wolf@linux.vnet.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig             |    3 +++
 arch/s390/kernel/stacktrace.c |   31 +++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 8 deletions(-)

Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -16,6 +16,9 @@ config LOCKDEP_SUPPORT
 config STACKTRACE_SUPPORT
 	def_bool y
 
+config HAVE_LATENCYTOP_SUPPORT
+	def_bool y
+
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: quilt-2.6/arch/s390/kernel/stacktrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/stacktrace.c
+++ quilt-2.6/arch/s390/kernel/stacktrace.c
@@ -14,7 +14,8 @@
 static unsigned long save_context_stack(struct stack_trace *trace,
 					unsigned long sp,
 					unsigned long low,
-					unsigned long high)
+					unsigned long high,
+					int savesched)
 {
 	struct stack_frame *sf;
 	struct pt_regs *regs;
@@ -47,10 +48,12 @@ static unsigned long save_context_stack(
 			return sp;
 		regs = (struct pt_regs *)sp;
 		addr = regs->psw.addr & PSW_ADDR_INSN;
-		if (!trace->skip)
-			trace->entries[trace->nr_entries++] = addr;
-		else
-			trace->skip--;
+		if (savesched || !in_sched_functions(addr)) {
+			if (!trace->skip)
+				trace->entries[trace->nr_entries++] = addr;
+			else
+				trace->skip--;
+		}
 		if (trace->nr_entries >= trace->max_entries)
 			return sp;
 		low = sp;
@@ -66,15 +69,27 @@ void save_stack_trace(struct stack_trace
 	orig_sp = sp & PSW_ADDR_INSN;
 	new_sp = save_context_stack(trace, orig_sp,
 				    S390_lowcore.panic_stack - PAGE_SIZE,
-				    S390_lowcore.panic_stack);
+				    S390_lowcore.panic_stack, 1);
 	if (new_sp != orig_sp)
 		return;
 	new_sp = save_context_stack(trace, new_sp,
 				    S390_lowcore.async_stack - ASYNC_SIZE,
-				    S390_lowcore.async_stack);
+				    S390_lowcore.async_stack, 1);
 	if (new_sp != orig_sp)
 		return;
 	save_context_stack(trace, new_sp,
 			   S390_lowcore.thread_info,
-			   S390_lowcore.thread_info + THREAD_SIZE);
+			   S390_lowcore.thread_info + THREAD_SIZE, 1);
+}
+
+void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
+{
+	unsigned long sp, low, high;
+
+	sp = tsk->thread.ksp & PSW_ADDR_INSN;
+	low = (unsigned long) task_stack_page(tsk);
+	high = (unsigned long) task_pt_regs(tsk);
+	save_context_stack(trace, sp, low, high, 0);
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
