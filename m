Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 07/18] stacktrace/x86: function for detecting reliable
 stack traces
Date: Thu, 28 Apr 2016 15:44:38 -0500
Message-Id: <4d34d452bf8f85c7d6d5f93db1d3eeb4cba335c7.1461875890.git.jpoimboe@redhat.com>
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

For live patching and possibly other use cases, a stack trace is only
useful if it can be assured that it's completely reliable.  Add a new
save_stack_trace_tsk_reliable() function to achieve that.

Scenarios which indicate that a stack trace may be unreliable:

- running tasks
- interrupt stacks
- preemption
- corrupted stack data
- the stack grows the wrong way
- the stack walk doesn't reach the bottom
- the user didn't provide a large enough entries array

Also add a config option so arch-independent code can determine at build
time whether the function is implemented.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                 |  6 ++++
 arch/x86/Kconfig             |  1 +
 arch/x86/kernel/dumpstack.c  | 77 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/stacktrace.c | 24 ++++++++++++++
 include/linux/kernel.h       |  1 +
 include/linux/stacktrace.h   | 20 +++++++++---
 kernel/extable.c             |  2 +-
 kernel/stacktrace.c          |  4 +--
 lib/Kconfig.debug            |  6 ++++
 9 files changed, 134 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8f84fd2..ec4d480 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -598,6 +598,12 @@ config HAVE_STACK_VALIDATION
 	  Architecture supports the 'objtool check' host tool command, which
 	  performs compile-time stack metadata validation.
 
+config HAVE_RELIABLE_STACKTRACE
+	bool
+	help
+	  Architecture has a save_stack_trace_tsk_reliable() function which
+	  only returns a stack trace if it can guarantee the trace is reliable.
+
 #
 # ABI hall of shame
 #
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0b128b4..78c4e00 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -140,6 +140,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE		if X86_64 && FRAME_POINTER
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16			if X86_32 || IA32_EMULATION
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 13d240c..70d0013 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -145,6 +145,83 @@ int print_context_stack_bp(struct thread_info *tinfo,
 }
 EXPORT_SYMBOL_GPL(print_context_stack_bp);
 
+#ifdef CONFIG_RELIABLE_STACKTRACE
+/*
+ * Only succeeds if the stack trace is deemed reliable.  This relies on the
+ * fact that frame pointers are reliable thanks to CONFIG_STACK_VALIDATION.
+ *
+ * The caller must ensure that the task is either sleeping or is the current
+ * task.
+ */
+int print_context_stack_reliable(struct thread_info *tinfo,
+				 unsigned long *stack, unsigned long *bp,
+				 const struct stacktrace_ops *ops,
+				 void *data, unsigned long *end, int *graph)
+{
+	struct stack_frame *frame = (struct stack_frame *)*bp;
+	struct stack_frame *last_frame = NULL;
+	unsigned long *ret_addr = &frame->return_address;
+
+	/*
+	 * If the kernel was preempted by an IRQ, we can't trust the stack
+	 * because the preempted function might not have gotten the chance to
+	 * save the frame pointer on the stack before it was interrupted.
+	 */
+	if (tinfo->task->flags & PF_PREEMPT_IRQ)
+		return -EINVAL;
+
+	/*
+	 * A freshly forked task has an empty stack trace.  We can consider
+	 * that to be reliable.
+	 */
+	if (test_ti_thread_flag(tinfo, TIF_FORK))
+		return 0;
+
+	while (valid_stack_ptr(tinfo, ret_addr, sizeof(*ret_addr), end)) {
+		unsigned long addr = *ret_addr;
+
+		/*
+		 * Make sure the stack only grows down.
+		 */
+		if (frame <= last_frame)
+			return -EINVAL;
+
+		/*
+		 * Make sure the frame refers to a valid kernel function.
+		 */
+		if (!core_kernel_text(addr) && !init_kernel_text(addr) &&
+		    !is_module_text_address(addr))
+			return -EINVAL;
+
+		/*
+		 * Save the kernel text address and make sure the entries array
+		 * isn't full.
+		 */
+		if (ops->address(data, addr, 1))
+			return -EINVAL;
+
+		/*
+		 * If the function graph tracer is in effect, save the real
+		 * function address.
+		 */
+		print_ftrace_graph_addr(addr, data, ops, tinfo, graph);
+
+		last_frame = frame;
+		frame = frame->next_frame;
+		ret_addr = &frame->return_address;
+	}
+
+	/*
+	 * Make sure we reached the bottom of the stack.
+	 */
+	if (last_frame + 1 != (void *)task_pt_regs(tinfo->task))
+		return -EINVAL;
+
+	*bp = (unsigned long)frame;
+	return 0;
+}
+#endif /* CONFIG_RELIABLE_STACKTRACE */
+
 static int print_trace_stack(void *data, char *name)
 {
 	printk("%s <%s> ", (char *)data, name);
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 9ee98ee..10882e4 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -148,3 +148,27 @@ void save_stack_trace_user(struct stack_trace *trace)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
+#ifdef CONFIG_RELIABLE_STACKTRACE
+
+static int save_stack_stack_reliable(void *data, char *name)
+{
+	return -EINVAL;
+}
+
+static const struct stacktrace_ops save_stack_ops_reliable = {
+	.stack		= save_stack_stack_reliable,
+	.address	= save_stack_address,
+	.walk_stack	= print_context_stack_reliable,
+};
+
+/*
+ * Returns 0 if the stack trace is deemed reliable.  The caller must ensure
+ * that the task is either sleeping or is the current task.
+ */
+int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				  struct stack_trace *trace)
+{
+	return dump_trace(tsk, NULL, NULL, 0, &save_stack_ops_reliable, trace);
+}
+
+#endif /* CONFIG_RELIABLE_STACKTRACE */
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cc73982..6be1e82 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -429,6 +429,7 @@ extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(const char *ptr, char **retptr);
 extern bool parse_option_str(const char *str, const char *option);
 
+extern int init_kernel_text(unsigned long addr);
 extern int core_kernel_text(unsigned long addr);
 extern int core_kernel_data(unsigned long addr);
 extern int __kernel_text_address(unsigned long addr);
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 0a34489..527e4cc 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -2,17 +2,18 @@
 #define __LINUX_STACKTRACE_H
 
 #include <linux/types.h>
+#include <linux/errno.h>
 
 struct task_struct;
 struct pt_regs;
 
-#ifdef CONFIG_STACKTRACE
 struct stack_trace {
 	unsigned int nr_entries, max_entries;
 	unsigned long *entries;
 	int skip;	/* input argument: How many entries to skip */
 };
 
+#ifdef CONFIG_STACKTRACE
 extern void save_stack_trace(struct stack_trace *trace);
 extern void save_stack_trace_regs(struct pt_regs *regs,
 				  struct stack_trace *trace);
@@ -29,12 +30,23 @@ extern void save_stack_trace_user(struct stack_trace *trace);
 # define save_stack_trace_user(trace)              do { } while (0)
 #endif
 
-#else
+#else /* !CONFIG_STACKTRACE */
 # define save_stack_trace(trace)			do { } while (0)
 # define save_stack_trace_tsk(tsk, trace)		do { } while (0)
 # define save_stack_trace_user(trace)			do { } while (0)
 # define print_stack_trace(trace, spaces)		do { } while (0)
 # define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
-#endif
+#endif /* CONFIG_STACKTRACE */
 
-#endif
+#ifdef CONFIG_RELIABLE_STACKTRACE
+extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+					 struct stack_trace *trace);
+#else
+static inline int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+						struct stack_trace *trace)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_RELIABLE_STACKTRACE */
+
+#endif /* __LINUX_STACKTRACE_H */
diff --git a/kernel/extable.c b/kernel/extable.c
index e820cce..c085844 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -58,7 +58,7 @@ const struct exception_table_entry *search_exception_tables(unsigned long addr)
 	return e;
 }
 
-static inline int init_kernel_text(unsigned long addr)
+int init_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_sinittext &&
 	    addr < (unsigned long)_einittext)
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index b6e4c16..f35bc5d 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -58,8 +58,8 @@ int snprint_stack_trace(char *buf, size_t size,
 EXPORT_SYMBOL_GPL(snprint_stack_trace);
 
 /*
- * Architectures that do not implement save_stack_trace_tsk or
- * save_stack_trace_regs get this weak alias and a once-per-bootup warning
+ * Architectures that do not implement save_stack_trace_*()
+ * get this weak alias and a once-per-bootup warning
  * (whenever this facility is utilized - for example by procfs):
  */
 __weak void
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5d57177..189a2d7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1164,6 +1164,12 @@ config STACKTRACE
 	  It is also used by various kernel debugging features that require
 	  stack trace generation.
 
+config RELIABLE_STACKTRACE
+	def_bool y
+	depends on HAVE_RELIABLE_STACKTRACE
+	depends on STACKTRACE
+	depends on STACK_VALIDATION
+
 config DEBUG_KOBJECT
 	bool "kobject debugging"
 	depends on DEBUG_KERNEL
-- 
2.4.11
