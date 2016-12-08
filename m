Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 01/15] stacktrace/x86: add function for detecting reliable
 stack traces
Date: Thu,  8 Dec 2016 12:08:26 -0600
Message-Id: <0315b36c08c104d56a4b43537fb300d200418996.1481220077.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1481220077.git.jpoimboe@redhat.com>
References: <cover.1481220077.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

For live patching and possibly other use cases, a stack trace is only
useful if it can be assured that it's completely reliable.  Add a new
save_stack_trace_tsk_reliable() function to achieve that.

Scenarios which indicate that a stack trace may be unreliable:

- running task
- interrupt stack
- preemption
- corrupted stack data
- stack grows the wrong way
- stack walk doesn't reach the bottom
- user didn't provide a large enough entries array

Also add CONFIG_HAVE_RELIABLE_STACKTRACE so arch-independent code can
determine at build time whether the function is implemented.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/Kconfig                   |  6 +++++
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/unwind.h  |  6 +++++
 arch/x86/kernel/stacktrace.c   | 59 +++++++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/unwind_frame.c |  1 +
 include/linux/stacktrace.h     |  8 +++---
 kernel/stacktrace.c            | 12 +++++++--
 7 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 13f27c1..d61a133 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -678,6 +678,12 @@ config HAVE_STACK_VALIDATION
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
index 215612c..b4a6663 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -155,6 +155,7 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
+	select HAVE_RELIABLE_STACKTRACE		if X86_64 && FRAME_POINTER && STACK_VALIDATION
 	select HAVE_STACK_VALIDATION		if X86_64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index c5a7f3a..44f86dc 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -11,6 +11,7 @@ struct unwind_state {
 	unsigned long stack_mask;
 	struct task_struct *task;
 	int graph_idx;
+	bool error;
 #ifdef CONFIG_FRAME_POINTER
 	unsigned long *bp;
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
index 0653788..3e0cf5e 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -74,6 +74,64 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
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
+			 * Preemption and page faults on the stack can make
+			 * frame pointers unreliable.
+			 */
+			if (!user_mode(regs))
+				return -1;
+
+			/*
+			 * This frame contains the (user mode) pt_regs at the
+			 * end of the stack.  Finish the unwind.
+			 */
+			unwind_next_frame(&state);
+			break;
+		}
+
+		addr = unwind_get_return_address(&state);
+		if (!addr || save_stack_address(trace, addr, false))
+			return -1;
+	}
+
+	if (!unwind_done(&state) || unwind_error(&state))
+		return -1;
+
+	if (trace->nr_entries < trace->max_entries)
+		trace->entries[trace->nr_entries++] = ULONG_MAX;
+
+	return 0;
+}
+
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
@@ -136,4 +194,3 @@ void save_stack_trace_user(struct stack_trace *trace)
 	if (trace->nr_entries < trace->max_entries)
 		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
-
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index ea7b7f9..f82525a 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -184,6 +184,7 @@ bool unwind_next_frame(struct unwind_state *state)
 			state->bp, state->task->comm,
 			state->task->pid, next_frame);
 	}
+	state->error = true;
 the_end:
 	state->stack_info.type = STACK_TYPE_UNKNOWN;
 	return false;
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
