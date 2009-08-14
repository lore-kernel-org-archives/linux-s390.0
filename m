Return-Path: <linux-kernel-owner+w=401wt.eu-S932293AbZHNL05@vger.kernel.org>
Message-Id: <20090814112616.078820730@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/34] improve mcount code
Content-Disposition: inline; filename=114-mcount-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Move the 64 bit mount code from mcount.S into mcount64.S and avoid
code duplication.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/Makefile   |    2 
 arch/s390/kernel/mcount.S   |  147 ++------------------------------------------
 arch/s390/kernel/mcount64.S |   78 +++++++++++++++++++++++
 3 files changed, 89 insertions(+), 138 deletions(-)

Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -41,7 +41,7 @@ obj-$(CONFIG_COMPAT)		+= compat_linux.o 
 
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
-obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o
+obj-$(CONFIG_FUNCTION_TRACER)	+= $(if $(CONFIG_64BIT),mcount64.o,mcount.o)
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += ftrace.o
 
Index: quilt-2.6/arch/s390/kernel/mcount64.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/mcount64.S
@@ -0,0 +1,78 @@
+/*
+ * Copyright IBM Corp. 2008,2009
+ *
+ *   Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *
+ */
+
+#include <asm/asm-offsets.h>
+
+	.globl ftrace_stub
+ftrace_stub:
+	br	%r14
+
+	.globl _mcount
+_mcount:
+#ifdef CONFIG_DYNAMIC_FTRACE
+	br	%r14
+
+	.data
+	.globl	ftrace_dyn_func
+ftrace_dyn_func:
+	.quad	ftrace_stub
+	.previous
+
+	.globl ftrace_caller
+ftrace_caller:
+#endif
+	larl	%r1,function_trace_stop
+	icm	%r1,0xf,0(%r1)
+	bnzr	%r14
+	stmg	%r2,%r5,32(%r15)
+	stg	%r14,112(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-160
+	stg	%r1,__SF_BACKCHAIN(%r15)
+	lgr	%r2,%r14
+	lg	%r3,168(%r15)
+#ifdef CONFIG_DYNAMIC_FTRACE
+	larl	%r14,ftrace_dyn_func
+#else
+	larl	%r14,ftrace_trace_function
+#endif
+	lg	%r14,0(%r14)
+	basr	%r14,%r14
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifdef CONFIG_DYNAMIC_FTRACE
+	.globl	ftrace_graph_caller
+ftrace_graph_caller:
+	# This unconditional branch gets runtime patched. Change only if
+	# you know what you are doing. See ftrace_enable_graph_caller().
+	j	0f
+#endif
+	lg	%r2,272(%r15)
+	lg	%r3,168(%r15)
+	brasl	%r14,prepare_ftrace_return
+	stg	%r2,168(%r15)
+0:
+#endif
+	aghi	%r15,160
+	lmg	%r2,%r5,32(%r15)
+	lg	%r14,112(%r15)
+	br	%r14
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+
+	.globl	return_to_handler
+return_to_handler:
+	stmg	%r2,%r5,32(%r15)
+	lgr	%r1,%r15
+	aghi	%r15,-160
+	stg	%r1,__SF_BACKCHAIN(%r15)
+	brasl	%r14,ftrace_return_to_handler
+	aghi	%r15,160
+	lgr	%r14,%r2
+	lmg	%r2,%r5,32(%r15)
+	br	%r14
+
+#endif
Index: quilt-2.6/arch/s390/kernel/mcount.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/mcount.S
+++ quilt-2.6/arch/s390/kernel/mcount.S
@@ -11,111 +11,27 @@
 ftrace_stub:
 	br	%r14
 
-#ifdef CONFIG_64BIT
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-
 	.globl _mcount
 _mcount:
-	br	%r14
-
-	.globl ftrace_caller
-ftrace_caller:
-	larl	%r1,function_trace_stop
-	icm	%r1,0xf,0(%r1)
-	bnzr	%r14
-	stmg	%r2,%r5,32(%r15)
-	stg	%r14,112(%r15)
-	lgr	%r1,%r15
-	aghi	%r15,-160
-	stg	%r1,__SF_BACKCHAIN(%r15)
-	lgr	%r2,%r14
-	lg	%r3,168(%r15)
-	larl	%r14,ftrace_dyn_func
-	lg	%r14,0(%r14)
-	basr	%r14,%r14
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	.globl	ftrace_graph_caller
-ftrace_graph_caller:
-	# This unconditional branch gets runtime patched. Change only if
-	# you know what you are doing. See ftrace_enable_graph_caller().
-	j	0f
-	lg	%r2,272(%r15)
-	lg	%r3,168(%r15)
-	brasl	%r14,prepare_ftrace_return
-	stg	%r2,168(%r15)
-0:
-#endif
-	aghi	%r15,160
-	lmg	%r2,%r5,32(%r15)
-	lg	%r14,112(%r15)
+#ifdef CONFIG_DYNAMIC_FTRACE
 	br	%r14
 
 	.data
 	.globl	ftrace_dyn_func
 ftrace_dyn_func:
-	.quad	ftrace_stub
+	.long	ftrace_stub
 	.previous
 
-#else /* CONFIG_DYNAMIC_FTRACE */
-
-	.globl _mcount
-_mcount:
-	larl	%r1,function_trace_stop
-	icm	%r1,0xf,0(%r1)
-	bnzr	%r14
-	stmg	%r2,%r5,32(%r15)
-	stg	%r14,112(%r15)
-	lgr	%r1,%r15
-	aghi	%r15,-160
-	stg	%r1,__SF_BACKCHAIN(%r15)
-	lgr	%r2,%r14
-	lg	%r3,168(%r15)
-	larl	%r14,ftrace_trace_function
-	lg	%r14,0(%r14)
-	basr	%r14,%r14
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	lg	%r2,272(%r15)
-	lg	%r3,168(%r15)
-	brasl	%r14,prepare_ftrace_return
-	stg	%r2,168(%r15)
-#endif
-	aghi	%r15,160
-	lmg	%r2,%r5,32(%r15)
-	lg	%r14,112(%r15)
-	br	%r14
-
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-
-	.globl	return_to_handler
-return_to_handler:
-	stmg	%r2,%r5,32(%r15)
-	lgr	%r1,%r15
-	aghi	%r15,-160
-	stg	%r1,__SF_BACKCHAIN(%r15)
-	brasl	%r14,ftrace_return_to_handler
-	aghi	%r15,160
-	lgr	%r14,%r2
-	lmg	%r2,%r5,32(%r15)
-	br	%r14
-
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
-#else /* CONFIG_64BIT */
-
-#ifdef CONFIG_DYNAMIC_FTRACE
-
-	.globl _mcount
-_mcount:
-	br	%r14
-
 	.globl ftrace_caller
 ftrace_caller:
+#endif
 	stm	%r2,%r5,16(%r15)
 	bras	%r1,2f
+#ifdef CONFIG_DYNAMIC_FTRACE
+0:	.long	ftrace_dyn_func
+#else
 0:	.long	ftrace_trace_function
+#endif
 1:	.long	function_trace_stop
 2:	l	%r2,1b-0b(%r1)
 	icm	%r2,0xf,0(%r2)
@@ -131,53 +47,13 @@ ftrace_caller:
 	l	%r14,0(%r14)
 	basr	%r14,%r14
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#ifdef CONFIG_DYNAMIC_FTRACE
 	.globl	ftrace_graph_caller
 ftrace_graph_caller:
 	# This unconditional branch gets runtime patched. Change only if
 	# you know what you are doing. See ftrace_enable_graph_caller().
 	j	1f
-	bras	%r1,0f
-	.long	prepare_ftrace_return
-0:	l	%r2,152(%r15)
-	l	%r4,0(%r1)
-	l	%r3,100(%r15)
-	basr	%r14,%r4
-	st	%r2,100(%r15)
-1:
 #endif
-	ahi	%r15,96
-	l	%r14,56(%r15)
-3:	lm	%r2,%r5,16(%r15)
-	br	%r14
-
-	.data
-	.globl	ftrace_dyn_func
-ftrace_dyn_func:
-	.long	ftrace_stub
-	.previous
-
-#else /* CONFIG_DYNAMIC_FTRACE */
-
-	.globl _mcount
-_mcount:
-	stm	%r2,%r5,16(%r15)
-	bras	%r1,2f
-0:	.long	ftrace_trace_function
-1:	.long	function_trace_stop
-2:	l	%r2,1b-0b(%r1)
-	icm	%r2,0xf,0(%r2)
-	jnz	3f
-	st	%r14,56(%r15)
-	lr	%r0,%r15
-	ahi	%r15,-96
-	l	%r3,100(%r15)
-	la	%r2,0(%r14)
-	st	%r0,__SF_BACKCHAIN(%r15)
-	la	%r3,0(%r3)
-	l	%r14,0b-0b(%r1)
-	l	%r14,0(%r14)
-	basr	%r14,%r14
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	bras	%r1,0f
 	.long	prepare_ftrace_return
 0:	l	%r2,152(%r15)
@@ -185,14 +61,13 @@ _mcount:
 	l	%r3,100(%r15)
 	basr	%r14,%r4
 	st	%r2,100(%r15)
+1:
 #endif
 	ahi	%r15,96
 	l	%r14,56(%r15)
 3:	lm	%r2,%r5,16(%r15)
 	br	%r14
 
-#endif /* CONFIG_DYNAMIC_FTRACE */
-
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
 	.globl	return_to_handler
@@ -211,6 +86,4 @@ return_to_handler:
 	lm	%r2,%r5,16(%r15)
 	br	%r14
 
-#endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
-#endif /* CONFIG_64BIT */
+#endif

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
