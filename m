Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v4 01/15] stacktrace/x86: add function for detecting reliable
 stack traces
Date: Thu, 19 Jan 2017 09:46:09 -0600
Message-Id: <dfe1419dc06f37e1f4aec5bf81d5b60e505a8d0f.1484839971.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1484839971.git.jpoimboe@redhat.com>
References: <cover.1484839971.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

For live patching and possibly other use cases, a stack trace is only
useful if it can be assured that it's completely reliable.  Add a new
save_stack_trace_tsk_reliable() function to achieve that.

Note that if the target task isn't the current task, and the target task
is allowed to run, then it could be writing the stack while the unwinder
is reading it, resulting in possible corruption.  So the caller of
save_stack_trace_tsk_reliable() must ensure that the task is either
'current' or inactive.

save_stack_trace_tsk_reliable() relies on the x86 unwinder's detection
of pt_regs on the stack.  If the pt_regs are not user-mode registers
from a syscall, then they indicate an in-kernel interrupt or exception
(e.g. preemption or a page fault), in which case the stack is considered
unreliable due to the nature of frame pointers.

It also relies on the x86 unwinder's detection of other issues, such as:

- corrupted stack data
- stack grows the wrong way
- stack walk doesn't reach the bottom
- user didn't provide a large enough entries array

Such issues are reported by checking unwind_error() and !unwind_done().

Also add CONFIG_HAVE_RELIABLE_STACKTRACE so arch-independent code can
determine at build time whether the function is implemented.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                   |  6 +++
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/unwind.h  |  6 +++
 arch/x86/kernel/stacktrace.c   | 85 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/unwind_frame.c |  2 +
 include/linux/stacktrace.h     |  8 ++--
 kernel/stacktrace.c            | 12 +++++-
 7 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index a00b24b..3fb09e3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -709,6 +709,12 @@ config HAVE_STACK_VALIDATION
 	  Architecture supports the 'objtool check' host tool command, which
 	  performs compile-time stack metadata validation.
 
+config HAVE_RELIABLE_STACKTRACE
+	bool
+	help
+	  Architecture has a save_stack_trace_tsk_reliable() function which
+	  only returns a stack trace if it can guarantee the trace is reliable.
+
 config HAVE_ARCH_HASH
 	bool
 	default n
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1d4e8f..604e4da 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -156,6 +156,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE		if X86_64 && FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 6fa75b1..137e9cce 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -11,6 +11,7 @@ struct unwind_state {
 	unsigned long stack_mask;
 	struct task_struct *task;
 	int graph_idx;
+	bool error;
 #ifdef CONFIG_FRAME_POINTER
 	unsigned long *bp, *orig_sp;
 	struct pt_regs *regs;
@@ -40,6 +41,11 @@ void unwind_start(struct unwind_state *state, struct task_struct *task,
 	__unwind_start(state, task, regs, first_frame);
 }
 
+static inline bool unwind_error(struct unwind_state *state)
+{
+	return state->error;
+}
+
 #ifdef CONFIG_FRAME_POINTER
 
 static inline
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 0653788..fc36842 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -74,6 +74,90 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
+#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
+static int __save_stack_trace_reliable(struct stack_trace *trace,
+				       struct task_struct *task)
+{
+	struct unwind_state state;
+	struct pt_regs *regs;
+	unsigned long addr;
+
+	for (unwind_start(&state, task, NULL, NULL); !unwind_done(&state);
+	     unwind_next_frame(&state)) {
+
+		regs = unwind_get_entry_regs(&state);
+		if (regs) {
+			/*
+			 * Kernel mode registers on the stack indicate an
+			 * in-kernel interrupt or exception (e.g., preemption
+			 * or a page fault), which can make frame pointers
+			 * unreliable.
+			 */
+			if (!user_mode(regs))
+				return -1;
+
+			/*
+			 * The last frame contains the user mode syscall
+			 * pt_regs.  Skip it and finish the unwind.
+			 */
+			unwind_next_frame(&state);
+			if (WARN_ON_ONCE(!unwind_done(&state))) {
+				show_stack(task, NULL);
+				return -1;
+			}
+			break;
+		}
+
+		addr = unwind_get_return_address(&state);
+
+		/*
+		 * A NULL or invalid return address probably means there's some
+		 * generated code which __kernel_text_address() doesn't know
+		 * about.
+		 */
+		if (WARN_ON_ONCE(!addr)) {
+			show_stack(task, NULL);
+			return -1;
+		}
+
+		if (save_stack_address(trace, addr, false))
+			return -1;
+	}
+
+	/* Check for stack corruption */
+	if (WARN_ON_ONCE(unwind_error(&state))) {
+		show_stack(task, NULL);
+		return -1;
+	}
+
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+
+	return 0;
+}
+
+/*
+ * This function returns an error if it detects any unreliable features of the
+ * stack.  Otherwise it guarantees that the stack trace is reliable.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is inactive.
+ */
+int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+				  struct stack_trace *trace)
+{
+	int ret;
+
+	if (!try_get_task_stack(tsk))
+		return -EINVAL;
+
+	ret = __save_stack_trace_reliable(trace, tsk);
+
+	put_task_stack(tsk);
+
+	return ret;
+}
+#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
+
 /* Userspace stacktrace - based on kernel/trace/trace_sysprof.c */
 
 struct stack_frame_user {
@@ -136,4 +220,3 @@ void save_stack_trace_user(struct stack_trace *trace)
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
-
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 23d1556..b15563d 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -223,6 +223,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	return true;
 
 bad_address:
+	state->error = true;
+
 	/*
 	 * When unwinding a non-current task, the task might actually be
 	 * running on another CPU, in which case it could be modifying its
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 0a34489..8e8b67b 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -18,6 +18,8 @@ extern void save_stack_trace_regs(struct pt_regs *regs,
 				  struct stack_trace *trace);
 extern void save_stack_trace_tsk(struct task_struct *tsk,
 				struct stack_trace *trace);
+extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
+					 struct stack_trace *trace);
 
 extern void print_stack_trace(struct stack_trace *trace, int spaces);
 extern int snprint_stack_trace(char *buf, size_t size,
@@ -29,12 +31,12 @@ extern void save_stack_trace_user(struct stack_trace *trace);
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
+#endif /* __LINUX_STACKTRACE_H */
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index b6e4c16..4ef81dc 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -58,8 +58,8 @@ int snprint_stack_trace(char *buf, size_t size,
 EXPORT_SYMBOL_GPL(snprint_stack_trace);
 
 /*
- * Architectures that do not implement save_stack_trace_tsk or
- * save_stack_trace_regs get this weak alias and a once-per-bootup warning
+ * Architectures that do not implement save_stack_trace_*()
+ * get these weak aliases and once-per-bootup warnings
  * (whenever this facility is utilized - for example by procfs):
  */
 __weak void
@@ -73,3 +73,11 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 {
 	WARN_ONCE(1, KERN_INFO "save_stack_trace_regs() not implemented yet.\n");
 }
+
+__weak int
+save_stack_trace_tsk_reliable(struct task_struct *tsk,
+			      struct stack_trace *trace)
+{
+	WARN_ONCE(1, KERN_INFO "save_stack_tsk_reliable() not implemented yet.\n");
+	return -ENOSYS;
+}
-- 
2.7.4
