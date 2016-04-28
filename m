Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 06/18] x86: dump_trace() error handling
Date: Thu, 28 Apr 2016 15:44:37 -0500
Message-Id: <c2891af88397538e7e3bba34172924d783f37c53.1461875890.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

In preparation for being able to determine whether a given stack trace
is reliable, allow the stacktrace_ops functions to propagate errors to
dump_trace().

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/stacktrace.h | 36 +++++++++++++++-----------
 arch/x86/kernel/dumpstack.c       | 31 +++++++++++------------
 arch/x86/kernel/dumpstack_32.c    | 22 ++++++++++------
 arch/x86/kernel/dumpstack_64.c    | 53 ++++++++++++++++++++++++++-------------
 4 files changed, 87 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 7c247e7..a64523f3 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -14,26 +14,32 @@ extern int kstack_depth_to_print;
 struct thread_info;
 struct stacktrace_ops;
 
-typedef unsigned long (*walk_stack_t)(struct thread_info *tinfo,
-				      unsigned long *stack,
-				      unsigned long bp,
-				      const struct stacktrace_ops *ops,
-				      void *data,
-				      unsigned long *end,
-				      int *graph);
-
-extern unsigned long
+typedef int (*walk_stack_t)(struct thread_info *tinfo,
+			    unsigned long *stack,
+			    unsigned long *bp,
+			    const struct stacktrace_ops *ops,
+			    void *data,
+			    unsigned long *end,
+			    int *graph);
+
+extern int
 print_context_stack(struct thread_info *tinfo,
-		    unsigned long *stack, unsigned long bp,
+		    unsigned long *stack, unsigned long *bp,
 		    const struct stacktrace_ops *ops, void *data,
 		    unsigned long *end, int *graph);
 
-extern unsigned long
+extern int
 print_context_stack_bp(struct thread_info *tinfo,
-		       unsigned long *stack, unsigned long bp,
+		       unsigned long *stack, unsigned long *bp,
 		       const struct stacktrace_ops *ops, void *data,
 		       unsigned long *end, int *graph);
 
+extern int
+print_context_stack_reliable(struct thread_info *tinfo,
+			     unsigned long *stack, unsigned long *bp,
+			     const struct stacktrace_ops *ops, void *data,
+			     unsigned long *end, int *graph);
+
 /* Generic stack tracer with callbacks */
 
 struct stacktrace_ops {
@@ -43,9 +49,9 @@ struct stacktrace_ops {
 	walk_stack_t	walk_stack;
 };
 
-void dump_trace(struct task_struct *tsk, struct pt_regs *regs,
-		unsigned long *stack, unsigned long bp,
-		const struct stacktrace_ops *ops, void *data);
+int dump_trace(struct task_struct *tsk, struct pt_regs *regs,
+	       unsigned long *stack, unsigned long bp,
+	       const struct stacktrace_ops *ops, void *data);
 
 #ifdef CONFIG_X86_32
 #define STACKSLOTS_PER_LINE 8
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 2bb25c3..13d240c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -92,23 +92,22 @@ static inline int valid_stack_ptr(struct thread_info *tinfo,
 	return p > t && p < t + THREAD_SIZE - size;
 }
 
-unsigned long
-print_context_stack(struct thread_info *tinfo,
-		unsigned long *stack, unsigned long bp,
-		const struct stacktrace_ops *ops, void *data,
-		unsigned long *end, int *graph)
+int print_context_stack(struct thread_info *tinfo,
+			unsigned long *stack, unsigned long *bp,
+			const struct stacktrace_ops *ops, void *data,
+			unsigned long *end, int *graph)
 {
-	struct stack_frame *frame = (struct stack_frame *)bp;
+	struct stack_frame *frame = (struct stack_frame *)*bp;
 
 	while (valid_stack_ptr(tinfo, stack, sizeof(*stack), end)) {
 		unsigned long addr;
 
 		addr = *stack;
 		if (__kernel_text_address(addr)) {
-			if ((unsigned long) stack == bp + sizeof(long)) {
+			if ((unsigned long) stack == *bp + sizeof(long)) {
 				ops->address(data, addr, 1);
 				frame = frame->next_frame;
-				bp = (unsigned long) frame;
+				*bp = (unsigned long) frame;
 			} else {
 				ops->address(data, addr, 0);
 			}
@@ -116,17 +115,16 @@ print_context_stack(struct thread_info *tinfo,
 		}
 		stack++;
 	}
-	return bp;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(print_context_stack);
 
-unsigned long
-print_context_stack_bp(struct thread_info *tinfo,
-		       unsigned long *stack, unsigned long bp,
-		       const struct stacktrace_ops *ops, void *data,
-		       unsigned long *end, int *graph)
+int print_context_stack_bp(struct thread_info *tinfo,
+			   unsigned long *stack, unsigned long *bp,
+			   const struct stacktrace_ops *ops, void *data,
+			   unsigned long *end, int *graph)
 {
-	struct stack_frame *frame = (struct stack_frame *)bp;
+	struct stack_frame *frame = (struct stack_frame *)*bp;
 	unsigned long *ret_addr = &frame->return_address;
 
 	while (valid_stack_ptr(tinfo, ret_addr, sizeof(*ret_addr), end)) {
@@ -142,7 +140,8 @@ print_context_stack_bp(struct thread_info *tinfo,
 		print_ftrace_graph_addr(addr, data, ops, tinfo, graph);
 	}
 
-	return (unsigned long)frame;
+	*bp = (unsigned long)frame;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(print_context_stack_bp);
 
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 464ffd6..e710bab 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -38,13 +38,14 @@ static void *is_softirq_stack(unsigned long *stack, int cpu)
 	return is_irq_stack(stack, irq);
 }
 
-void dump_trace(struct task_struct *task, struct pt_regs *regs,
-		unsigned long *stack, unsigned long bp,
-		const struct stacktrace_ops *ops, void *data)
+int dump_trace(struct task_struct *task, struct pt_regs *regs,
+	       unsigned long *stack, unsigned long bp,
+	       const struct stacktrace_ops *ops, void *data)
 {
 	const unsigned cpu = get_cpu();
 	int graph = 0;
 	u32 *prev_esp;
+	int ret;
 
 	if (!task)
 		task = current;
@@ -69,8 +70,10 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 			end_stack = is_softirq_stack(stack, cpu);
 
 		context = task_thread_info(task);
-		bp = ops->walk_stack(context, stack, bp, ops, data,
-				     end_stack, &graph);
+		ret = ops->walk_stack(context, stack, &bp, ops, data,
+				      end_stack, &graph);
+		if (ret)
+			goto out;
 
 		/* Stop if not on irq stack */
 		if (!end_stack)
@@ -82,11 +85,16 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 		if (!stack)
 			break;
 
-		if (ops->stack(data, "IRQ") < 0)
-			break;
+		ret = ops->stack(data, "IRQ");
+		if (ret)
+			goto out;
+
 		touch_nmi_watchdog();
 	}
+
+out:
 	put_cpu();
+	return ret;
 }
 EXPORT_SYMBOL(dump_trace);
 
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 5f1c626..0c810ba 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -148,9 +148,9 @@ analyze_stack(int cpu, struct task_struct *task, unsigned long *stack,
  * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
  */
 
-void dump_trace(struct task_struct *task, struct pt_regs *regs,
-		unsigned long *stack, unsigned long bp,
-		const struct stacktrace_ops *ops, void *data)
+int dump_trace(struct task_struct *task, struct pt_regs *regs,
+	       unsigned long *stack, unsigned long bp,
+	       const struct stacktrace_ops *ops, void *data)
 {
 	const unsigned cpu = get_cpu();
 	struct thread_info *tinfo;
@@ -159,6 +159,7 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	unsigned used = 0;
 	int graph = 0;
 	int done = 0;
+	int ret;
 
 	if (!task)
 		task = current;
@@ -198,13 +199,18 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 			break;
 
 		case STACK_IS_EXCEPTION:
-
-			if (ops->stack(data, id) < 0)
-				break;
-
-			bp = ops->walk_stack(tinfo, stack, bp, ops,
-					     data, stack_end, &graph);
-			ops->stack(data, "<EOE>");
+			ret = ops->stack(data, id);
+			if (ret)
+				goto out;
+
+			ret = ops->walk_stack(tinfo, stack, &bp, ops, data,
+					      stack_end, &graph);
+			if (ret)
+				goto out;
+
+			ret = ops->stack(data, "<EOE>");
+			if (ret)
+				goto out;
 			/*
 			 * We link to the next stack via the
 			 * second-to-last pointer (index -2 to end) in the
@@ -215,11 +221,15 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 			break;
 
 		case STACK_IS_IRQ:
+			ret = ops->stack(data, "IRQ");
+			if (ret)
+				goto out;
+
+			ret = ops->walk_stack(tinfo, stack, &bp, ops, data,
+					      stack_end, &graph);
+			if (ret)
+				goto out;
 
-			if (ops->stack(data, "IRQ") < 0)
-				break;
-			bp = ops->walk_stack(tinfo, stack, bp,
-				     ops, data, stack_end, &graph);
 			/*
 			 * We link to the next stack (which would be
 			 * the process stack normally) the last
@@ -227,12 +237,18 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 			 */
 			stack = (unsigned long *) (stack_end[-1]);
 			irq_stack = NULL;
-			ops->stack(data, "EOI");
+
+			ret = ops->stack(data, "EOI");
+			if (ret)
+				goto out;
+
 			done = 0;
 			break;
 
 		case STACK_IS_UNKNOWN:
-			ops->stack(data, "UNK");
+			ret = ops->stack(data, "UNK");
+			if (ret)
+				goto out;
 			break;
 		}
 	}
@@ -240,8 +256,11 @@ void dump_trace(struct task_struct *task, struct pt_regs *regs,
 	/*
 	 * This handles the process stack:
 	 */
-	bp = ops->walk_stack(tinfo, stack, bp, ops, data, NULL, &graph);
+	ret = ops->walk_stack(tinfo, stack, &bp, ops, data, NULL, &graph);
+
+out:
 	put_cpu();
+	return ret;
 }
 EXPORT_SYMBOL(dump_trace);
 
-- 
2.4.11
