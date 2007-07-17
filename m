Return-Path: <linux-kernel-owner+w=401wt.eu-S1761641AbXGQMWS@vger.kernel.org>
Message-Id: <20070717122306.183443247@de.ibm.com>
References: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/8] Simplify stack trace.
Content-Disposition: inline; filename=005-stack-trace.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

sparse gives us a few of these:
stacktrace.c:69:38: warning: incorrect type in argument 2
                    (different signedness)
stacktrace.c:69:38:    expected unsigned int *skip

Just get rid of the 'skip' argument since it is contained in the
struct stack_trace that gets passed anyway.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/stacktrace.c |   26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

Index: quilt-2.6/arch/s390/kernel/stacktrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/stacktrace.c
+++ quilt-2.6/arch/s390/kernel/stacktrace.c
@@ -12,7 +12,6 @@
 #include <linux/kallsyms.h>
 
 static unsigned long save_context_stack(struct stack_trace *trace,
-					unsigned int *skip,
 					unsigned long sp,
 					unsigned long low,
 					unsigned long high)
@@ -28,10 +27,10 @@ static unsigned long save_context_stack(
 		sf = (struct stack_frame *)sp;
 		while(1) {
 			addr = sf->gprs[8] & PSW_ADDR_INSN;
-			if (!(*skip))
+			if (!trace->skip)
 				trace->entries[trace->nr_entries++] = addr;
 			else
-				(*skip)--;
+				trace->skip--;
 			if (trace->nr_entries >= trace->max_entries)
 				return sp;
 			low = sp;
@@ -48,10 +47,10 @@ static unsigned long save_context_stack(
 			return sp;
 		regs = (struct pt_regs *)sp;
 		addr = regs->psw.addr & PSW_ADDR_INSN;
-		if (!(*skip))
+		if (!trace->skip)
 			trace->entries[trace->nr_entries++] = addr;
 		else
-			(*skip)--;
+			trace->skip--;
 		if (trace->nr_entries >= trace->max_entries)
 			return sp;
 		low = sp;
@@ -65,20 +64,17 @@ void save_stack_trace(struct stack_trace
 	unsigned long orig_sp, new_sp;
 
 	orig_sp = sp & PSW_ADDR_INSN;
-
-	new_sp = save_context_stack(trace, &trace->skip, orig_sp,
-				S390_lowcore.panic_stack - PAGE_SIZE,
-				S390_lowcore.panic_stack);
+	new_sp = save_context_stack(trace, orig_sp,
+				    S390_lowcore.panic_stack - PAGE_SIZE,
+				    S390_lowcore.panic_stack);
 	if (new_sp != orig_sp)
 		return;
-	new_sp = save_context_stack(trace, &trace->skip, new_sp,
-				S390_lowcore.async_stack - ASYNC_SIZE,
-				S390_lowcore.async_stack);
+	new_sp = save_context_stack(trace, new_sp,
+				    S390_lowcore.async_stack - ASYNC_SIZE,
+				    S390_lowcore.async_stack);
 	if (new_sp != orig_sp)
 		return;
-
-	save_context_stack(trace, &trace->skip, new_sp,
+	save_context_stack(trace, new_sp,
 			   S390_lowcore.thread_info,
 			   S390_lowcore.thread_info + THREAD_SIZE);
-	return;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
