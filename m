Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 13/15] livepatch: change to a per-task consistency model
Date: Mon, 13 Feb 2017 19:42:40 -0600
Message-Id: <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1487036215.git.jpoimboe@redhat.com>
References: <cover.1487036215.git.jpoimboe@redhat.com>
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

Change livepatch to use a basic per-task consistency model.  This is the
foundation which will eventually enable us to patch those ~10% of
security patches which change function or data semantics.  This is the
biggest remaining piece needed to make livepatch more generally useful.

This code stems from the design proposal made by Vojtech [1] in November
2014.  It's a hybrid of kGraft and kpatch: it uses kGraft's per-task
consistency and syscall barrier switching combined with kpatch's stack
trace switching.  There are also a number of fallback options which make
it quite flexible.

Patches are applied on a per-task basis, when the task is deemed safe to
switch over.  When a patch is enabled, livepatch enters into a
transition state where tasks are converging to the patched state.
Usually this transition state can complete in a few seconds.  The same
sequence occurs when a patch is disabled, except the tasks converge from
the patched state to the unpatched state.

An interrupt handler inherits the patched state of the task it
interrupts.  The same is true for forked tasks: the child inherits the
patched state of the parent.

Livepatch uses several complementary approaches to determine when it's
safe to patch tasks:

1. The first and most effective approach is stack checking of sleeping
   tasks.  If no affected functions are on the stack of a given task,
   the task is patched.  In most cases this will patch most or all of
   the tasks on the first try.  Otherwise it'll keep trying
   periodically.  This option is only available if the architecture has
   reliable stacks (HAVE_RELIABLE_STACKTRACE).

2. The second approach, if needed, is kernel exit switching.  A
   task is switched when it returns to user space from a system call, a
   user space IRQ, or a signal.  It's useful in the following cases:

   a) Patching I/O-bound user tasks which are sleeping on an affected
      function.  In this case you have to send SIGSTOP and SIGCONT to
      force it to exit the kernel and be patched.
   b) Patching CPU-bound user tasks.  If the task is highly CPU-bound
      then it will get patched the next time it gets interrupted by an
      IRQ.
   c) In the future it could be useful for applying patches for
      architectures which don't yet have HAVE_RELIABLE_STACKTRACE.  In
      this case you would have to signal most of the tasks on the
      system.  However this isn't supported yet because there's
      currently no way to patch kthreads without
      HAVE_RELIABLE_STACKTRACE.

3. For idle "swapper" tasks, since they don't ever exit the kernel, they
   instead have a klp_update_patch_state() call in the idle loop which
   allows them to be patched before the CPU enters the idle state.

   (Note there's not yet such an approach for kthreads.)

All the above approaches may be skipped by setting the 'immediate' flag
in the 'klp_patch' struct, which will disable per-task consistency and
patch all tasks immediately.  This can be useful if the patch doesn't
change any function or data semantics.  Note that, even with this flag
set, it's possible that some tasks may still be running with an old
version of the function, until that function returns.

There's also an 'immediate' flag in the 'klp_func' struct which allows
you to specify that certain functions in the patch can be applied
without per-task consistency.  This might be useful if you want to patch
a common function like schedule(), and the function change doesn't need
consistency but the rest of the patch does.

For architectures which don't have HAVE_RELIABLE_STACKTRACE, the user
must set patch->immediate which causes all tasks to be patched
immediately.  This option should be used with care, only when the patch
doesn't change any function or data semantics.

In the future, architectures which don't have HAVE_RELIABLE_STACKTRACE
may be allowed to use per-task consistency if we can come up with
another way to patch kthreads.

The /sys/kernel/livepatch/<patch>/transition file shows whether a patch
is in transition.  Only a single patch (the topmost patch on the stack)
can be in transition at a given time.  A patch can remain in transition
indefinitely, if any of the tasks are stuck in the initial patch state.

A transition can be reversed and effectively canceled by writing the
opposite value to the /sys/kernel/livepatch/<patch>/enabled file while
the transition is in progress.  Then all the tasks will attempt to
converge back to the original patch state.

[1] https://lkml.kernel.org/r/20141107140458.GA21774@suse.cz

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/ABI/testing/sysfs-kernel-livepatch |   8 +
 Documentation/livepatch/livepatch.txt            | 186 +++++++-
 include/linux/init_task.h                        |   9 +
 include/linux/livepatch.h                        |  42 +-
 include/linux/sched.h                            |   3 +
 kernel/fork.c                                    |   3 +
 kernel/livepatch/Makefile                        |   2 +-
 kernel/livepatch/core.c                          | 105 ++++-
 kernel/livepatch/patch.c                         |  59 +++
 kernel/livepatch/patch.h                         |   1 +
 kernel/livepatch/transition.c                    | 543 +++++++++++++++++++++++
 kernel/livepatch/transition.h                    |  14 +
 kernel/sched/idle.c                              |   4 +
 samples/livepatch/livepatch-sample.c             |  17 +
 14 files changed, 947 insertions(+), 49 deletions(-)
 create mode 100644 kernel/livepatch/transition.c
 create mode 100644 kernel/livepatch/transition.h

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index da87f43..d5d3974 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -25,6 +25,14 @@ Description:
 		code is currently applied.  Writing 0 will disable the patch
 		while writing 1 will re-enable the patch.
 
+What:		/sys/kernel/livepatch/<patch>/transition
+Date:		Feb 2017
+KernelVersion:	4.12.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		An attribute which indicates whether the patch is currently in
+		transition.
+
 What:		/sys/kernel/livepatch/<patch>/<object>
 Date:		Nov 2014
 KernelVersion:	3.19.0
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 9d2096c..4f2aec8 100644
--- a/Documentation/livepatch/livepatch.txt
+++ b/Documentation/livepatch/livepatch.txt
@@ -72,7 +72,8 @@ example, they add a NULL pointer or a boundary check, fix a race by adding
 a missing memory barrier, or add some locking around a critical section.
 Most of these changes are self contained and the function presents itself
 the same way to the rest of the system. In this case, the functions might
-be updated independently one by one.
+be updated independently one by one.  (This can be done by setting the
+'immediate' flag in the klp_patch struct.)
 
 But there are more complex fixes. For example, a patch might change
 ordering of locking in multiple functions at the same time. Or a patch
@@ -86,20 +87,141 @@ or no data are stored in the modified structures at the moment.
 The theory about how to apply functions a safe way is rather complex.
 The aim is to define a so-called consistency model. It attempts to define
 conditions when the new implementation could be used so that the system
-stays consistent. The theory is not yet finished. See the discussion at
-https://lkml.kernel.org/r/20141107140458.GA21774@suse.cz
-
-The current consistency model is very simple. It guarantees that either
-the old or the new function is called. But various functions get redirected
-one by one without any synchronization.
-
-In other words, the current implementation _never_ modifies the behavior
-in the middle of the call. It is because it does _not_ rewrite the entire
-function in the memory. Instead, the function gets redirected at the
-very beginning. But this redirection is used immediately even when
-some other functions from the same patch have not been redirected yet.
-
-See also the section "Limitations" below.
+stays consistent.
+
+Livepatch has a consistency model which is a hybrid of kGraft and
+kpatch:  it uses kGraft's per-task consistency and syscall barrier
+switching combined with kpatch's stack trace switching.  There are also
+a number of fallback options which make it quite flexible.
+
+Patches are applied on a per-task basis, when the task is deemed safe to
+switch over.  When a patch is enabled, livepatch enters into a
+transition state where tasks are converging to the patched state.
+Usually this transition state can complete in a few seconds.  The same
+sequence occurs when a patch is disabled, except the tasks converge from
+the patched state to the unpatched state.
+
+An interrupt handler inherits the patched state of the task it
+interrupts.  The same is true for forked tasks: the child inherits the
+patched state of the parent.
+
+Livepatch uses several complementary approaches to determine when it's
+safe to patch tasks:
+
+1. The first and most effective approach is stack checking of sleeping
+   tasks.  If no affected functions are on the stack of a given task,
+   the task is patched.  In most cases this will patch most or all of
+   the tasks on the first try.  Otherwise it'll keep trying
+   periodically.  This option is only available if the architecture has
+   reliable stacks (HAVE_RELIABLE_STACKTRACE).
+
+2. The second approach, if needed, is kernel exit switching.  A
+   task is switched when it returns to user space from a system call, a
+   user space IRQ, or a signal.  It's useful in the following cases:
+
+   a) Patching I/O-bound user tasks which are sleeping on an affected
+      function.  In this case you have to send SIGSTOP and SIGCONT to
+      force it to exit the kernel and be patched.
+   b) Patching CPU-bound user tasks.  If the task is highly CPU-bound
+      then it will get patched the next time it gets interrupted by an
+      IRQ.
+   c) In the future it could be useful for applying patches for
+      architectures which don't yet have HAVE_RELIABLE_STACKTRACE.  In
+      this case you would have to signal most of the tasks on the
+      system.  However this isn't supported yet because there's
+      currently no way to patch kthreads without
+      HAVE_RELIABLE_STACKTRACE.
+
+3. For idle "swapper" tasks, since they don't ever exit the kernel, they
+   instead have a klp_update_patch_state() call in the idle loop which
+   allows them to be patched before the CPU enters the idle state.
+
+   (Note there's not yet such an approach for kthreads.)
+
+All the above approaches may be skipped by setting the 'immediate' flag
+in the 'klp_patch' struct, which will disable per-task consistency and
+patch all tasks immediately.  This can be useful if the patch doesn't
+change any function or data semantics.  Note that, even with this flag
+set, it's possible that some tasks may still be running with an old
+version of the function, until that function returns.
+
+There's also an 'immediate' flag in the 'klp_func' struct which allows
+you to specify that certain functions in the patch can be applied
+without per-task consistency.  This might be useful if you want to patch
+a common function like schedule(), and the function change doesn't need
+consistency but the rest of the patch does.
+
+For architectures which don't have HAVE_RELIABLE_STACKTRACE, the user
+must set patch->immediate which causes all tasks to be patched
+immediately.  This option should be used with care, only when the patch
+doesn't change any function or data semantics.
+
+In the future, architectures which don't have HAVE_RELIABLE_STACKTRACE
+may be allowed to use per-task consistency if we can come up with
+another way to patch kthreads.
+
+The /sys/kernel/livepatch/<patch>/transition file shows whether a patch
+is in transition.  Only a single patch (the topmost patch on the stack)
+can be in transition at a given time.  A patch can remain in transition
+indefinitely, if any of the tasks are stuck in the initial patch state.
+
+A transition can be reversed and effectively canceled by writing the
+opposite value to the /sys/kernel/livepatch/<patch>/enabled file while
+the transition is in progress.  Then all the tasks will attempt to
+converge back to the original patch state.
+
+There's also a /proc/<pid>/patch_state file which can be used to
+determine which tasks are blocking completion of a patching operation.
+If a patch is in transition, this file shows 0 to indicate the task is
+unpatched and 1 to indicate it's patched.  Otherwise, if no patch is in
+transition, it shows -1.  Any tasks which are blocking the transition
+can be signaled with SIGSTOP and SIGCONT to force them to change their
+patched state.
+
+
+3.1 Adding consistency model support to new architectures
+---------------------------------------------------------
+
+For adding consistency model support to new architectures, there are a
+few options:
+
+1) Add CONFIG_HAVE_RELIABLE_STACKTRACE.  This means porting objtool, and
+   for non-DWARF unwinders, also making sure there's a way for the stack
+   tracing code to detect interrupts on the stack.
+
+2) Alternatively, ensure that every kthread has a call to
+   klp_update_patch_state() in a safe location.  Kthreads are typically
+   in an infinite loop which does some action repeatedly.  The safe
+   location to switch the kthread's patch state would be at a designated
+   point in the loop where there are no locks taken and all data
+   structures are in a well-defined state.
+
+   The location is clear when using workqueues or the kthread worker
+   API.  These kthreads process independent actions in a generic loop.
+
+   It's much more complicated with kthreads which have a custom loop.
+   There the safe location must be carefully selected on a case-by-case
+   basis.
+
+   In that case, arches without HAVE_RELIABLE_STACKTRACE would still be
+   able to use the non-stack-checking parts of the consistency model:
+
+   a) patching user tasks when they cross the kernel/user space
+      boundary; and
+
+   b) patching kthreads and idle tasks at their designated patch points.
+
+   This option isn't as good as option 1 because it requires signaling
+   user tasks and waking kthreads to patch them.  But it could still be
+   a good backup option for those architectures which don't have
+   reliable stack traces yet.
+
+In the meantime, patches for such architectures can bypass the
+consistency model by setting klp_patch.immediate to true.  This option
+is perfectly fine for patches which don't change the semantics of the
+patched functions.  In practice, this is usable for ~90% of security
+fixes.  Use of this option also means the patch can't be unloaded after
+it has been disabled.
 
 
 4. Livepatch module
@@ -134,7 +256,7 @@ Documentation/livepatch/module-elf-format.txt for more details.
 
 
 4.2. Metadata
-------------
+-------------
 
 The patch is described by several structures that split the information
 into three levels:
@@ -156,6 +278,9 @@ into three levels:
     only for a particular object ( vmlinux or a kernel module ). Note that
     kallsyms allows for searching symbols according to the object name.
 
+    There's also an 'immediate' flag which, when set, patches the
+    function immediately, bypassing the consistency model safety checks.
+
   + struct klp_object defines an array of patched functions (struct
     klp_func) in the same object. Where the object is either vmlinux
     (NULL) or a module name.
@@ -172,10 +297,13 @@ into three levels:
     This structure handles all patched functions consistently and eventually,
     synchronously. The whole patch is applied only when all patched
     symbols are found. The only exception are symbols from objects
-    (kernel modules) that have not been loaded yet. Also if a more complex
-    consistency model is supported then a selected unit (thread,
-    kernel as a whole) will see the new code from the entire patch
-    only when it is in a safe state.
+    (kernel modules) that have not been loaded yet.
+
+    Setting the 'immediate' flag applies the patch to all tasks
+    immediately, bypassing the consistency model safety checks.
+
+    For more details on how the patch is applied on a per-task basis,
+    see the "Consistency model" section.
 
 
 4.3. Livepatch module handling
@@ -239,9 +367,15 @@ Registered patches might be enabled either by calling klp_enable_patch() or
 by writing '1' to /sys/kernel/livepatch/<name>/enabled. The system will
 start using the new implementation of the patched functions at this stage.
 
-In particular, if an original function is patched for the first time, a
-function specific struct klp_ops is created and an universal ftrace handler
-is registered.
+When a patch is enabled, livepatch enters into a transition state where
+tasks are converging to the patched state.  This is indicated by a value
+of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks have
+been patched, the 'transition' value changes to '0'.  For more
+information about this process, see the "Consistency model" section.
+
+If an original function is patched for the first time, a function
+specific struct klp_ops is created and an universal ftrace handler is
+registered.
 
 Functions might be patched multiple times. The ftrace handler is registered
 only once for the given function. Further patches just add an entry to the
@@ -261,6 +395,12 @@ by writing '0' to /sys/kernel/livepatch/<name>/enabled. At this stage
 either the code from the previously enabled patch or even the original
 code gets used.
 
+When a patch is disabled, livepatch enters into a transition state where
+tasks are converging to the unpatched state.  This is indicated by a
+value of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks
+have been unpatched, the 'transition' value changes to '0'.  For more
+information about this process, see the "Consistency model" section.
+
 Here all the functions (struct klp_func) associated with the to-be-disabled
 patch are removed from the corresponding struct klp_ops. The ftrace handler
 is unregistered and the struct klp_ops is freed when the func_stack list
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 3a85d61..e49bf379 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -14,6 +14,7 @@
 #include <linux/rbtree.h>
 #include <net/net_namespace.h>
 #include <linux/sched/rt.h>
+#include <linux/livepatch.h>
 
 #include <asm/thread_info.h>
 
@@ -202,6 +203,13 @@ extern struct task_group root_task_group;
 # define INIT_KASAN(tsk)
 #endif
 
+#ifdef CONFIG_LIVEPATCH
+# define INIT_LIVEPATCH(tsk)						\
+	.patch_state = KLP_UNDEFINED,
+#else
+# define INIT_LIVEPATCH(tsk)
+#endif
+
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 # define INIT_TASK_TI(tsk)			\
 	.thread_info = INIT_THREAD_INFO(tsk),	\
@@ -288,6 +296,7 @@ extern struct task_group root_task_group;
 	INIT_VTIME(tsk)							\
 	INIT_NUMA_BALANCING(tsk)					\
 	INIT_KASAN(tsk)							\
+	INIT_LIVEPATCH(tsk)						\
 }
 
 
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 6602b34..ed90ad1 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -28,18 +28,40 @@
 
 #include <asm/livepatch.h>
 
+/* task patch states */
+#define KLP_UNDEFINED	-1
+#define KLP_UNPATCHED	 0
+#define KLP_PATCHED	 1
+
 /**
  * struct klp_func - function structure for live patching
  * @old_name:	name of the function to be patched
  * @new_func:	pointer to the patched function code
  * @old_sympos: a hint indicating which symbol position the old function
  *		can be found (optional)
+ * @immediate:  patch the func immediately, bypassing safety mechanisms
  * @old_addr:	the address of the function being patched
  * @kobj:	kobject for sysfs resources
  * @stack_node:	list node for klp_ops func_stack list
  * @old_size:	size of the old function
  * @new_size:	size of the new function
  * @patched:	the func has been added to the klp_ops list
+ * @transition:	the func is currently being applied or reverted
+ *
+ * The patched and transition variables define the func's patching state.  When
+ * patching, a func is always in one of the following states:
+ *
+ *   patched=0 transition=0: unpatched
+ *   patched=0 transition=1: unpatched, temporary starting state
+ *   patched=1 transition=1: patched, may be visible to some tasks
+ *   patched=1 transition=0: patched, visible to all tasks
+ *
+ * And when unpatching, it goes in the reverse order:
+ *
+ *   patched=1 transition=0: patched, visible to all tasks
+ *   patched=1 transition=1: patched, may be visible to some tasks
+ *   patched=0 transition=1: unpatched, temporary ending state
+ *   patched=0 transition=0: unpatched
  */
 struct klp_func {
 	/* external */
@@ -53,6 +75,7 @@ struct klp_func {
 	 * in kallsyms for the given object is used.
 	 */
 	unsigned long old_sympos;
+	bool immediate;
 
 	/* internal */
 	unsigned long old_addr;
@@ -60,6 +83,7 @@ struct klp_func {
 	struct list_head stack_node;
 	unsigned long old_size, new_size;
 	bool patched;
+	bool transition;
 };
 
 /**
@@ -68,7 +92,7 @@ struct klp_func {
  * @funcs:	function entries for functions to be patched in the object
  * @kobj:	kobject for sysfs resources
  * @mod:	kernel module associated with the patched object
- * 		(NULL for vmlinux)
+ *		(NULL for vmlinux)
  * @patched:	the object's funcs have been added to the klp_ops list
  */
 struct klp_object {
@@ -86,6 +110,7 @@ struct klp_object {
  * struct klp_patch - patch structure for live patching
  * @mod:	reference to the live patch module
  * @objs:	object entries for kernel objects to be patched
+ * @immediate:  patch all funcs immediately, bypassing safety mechanisms
  * @list:	list node for global list of registered patches
  * @kobj:	kobject for sysfs resources
  * @enabled:	the patch is enabled (but operation may be incomplete)
@@ -94,6 +119,7 @@ struct klp_patch {
 	/* external */
 	struct module *mod;
 	struct klp_object *objs;
+	bool immediate;
 
 	/* internal */
 	struct list_head list;
@@ -121,13 +147,27 @@ void arch_klp_init_object_loaded(struct klp_patch *patch,
 int klp_module_coming(struct module *mod);
 void klp_module_going(struct module *mod);
 
+void klp_copy_process(struct task_struct *child);
 void klp_update_patch_state(struct task_struct *task);
 
+static inline bool klp_patch_pending(struct task_struct *task)
+{
+	return test_tsk_thread_flag(task, TIF_PATCH_PENDING);
+}
+
+static inline bool klp_have_reliable_stack(void)
+{
+	return IS_ENABLED(CONFIG_STACKTRACE) &&
+	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
+}
+
 #else /* !CONFIG_LIVEPATCH */
 
 static inline int klp_module_coming(struct module *mod) { return 0; }
 static inline void klp_module_going(struct module *mod) {}
+static inline bool klp_patch_pending(struct task_struct *task) { return false; }
 static inline void klp_update_patch_state(struct task_struct *task) {}
+static inline void klp_copy_process(struct task_struct *child) {}
 
 #endif /* CONFIG_LIVEPATCH */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5aec804..f653fea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1980,6 +1980,9 @@ struct task_struct {
 	/* A live task holds one reference. */
 	atomic_t stack_refcount;
 #endif
+#ifdef CONFIG_LIVEPATCH
+	int patch_state;
+#endif
 /* CPU-specific state of this task */
 	struct thread_struct thread;
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index c6eb727..a1552ab 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -77,6 +77,7 @@
 #include <linux/compiler.h>
 #include <linux/sysctl.h>
 #include <linux/kcov.h>
+#include <linux/livepatch.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1772,6 +1773,8 @@ static __latent_entropy struct task_struct *copy_process(
 		p->parent_exec_id = current->self_exec_id;
 	}
 
+	klp_copy_process(p);
+
 	spin_lock(&current->sighand->siglock);
 
 	/*
diff --git a/kernel/livepatch/Makefile b/kernel/livepatch/Makefile
index e136dad..2b8bdb1 100644
--- a/kernel/livepatch/Makefile
+++ b/kernel/livepatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 
-livepatch-objs := core.o patch.o
+livepatch-objs := core.o patch.o transition.o
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 10ba3a1..3dc3c90 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -31,22 +31,22 @@
 #include <linux/moduleloader.h>
 #include <asm/cacheflush.h>
 #include "patch.h"
+#include "transition.h"
 
 /*
- * The klp_mutex protects the global lists and state transitions of any
- * structure reachable from them.  References to any structure must be obtained
- * under mutex protection (except in klp_ftrace_handler(), which uses RCU to
- * ensure it gets consistent data).
+ * klp_mutex is a coarse lock which serializes access to klp data.  All
+ * accesses to klp-related variables and structures must have mutex protection,
+ * except within the following functions which carefully avoid the need for it:
+ *
+ * - klp_ftrace_handler()
+ * - klp_update_patch_state()
  */
-static DEFINE_MUTEX(klp_mutex);
+DEFINE_MUTEX(klp_mutex);
 
 static LIST_HEAD(klp_patches);
 
 static struct kobject *klp_root_kobj;
 
-/* TODO: temporary stub */
-void klp_update_patch_state(struct task_struct *task) {}
-
 static bool klp_is_module(struct klp_object *obj)
 {
 	return obj->name;
@@ -85,7 +85,6 @@ static void klp_find_object_module(struct klp_object *obj)
 	mutex_unlock(&module_mutex);
 }
 
-/* klp_mutex must be held by caller */
 static bool klp_is_patch_registered(struct klp_patch *patch)
 {
 	struct klp_patch *mypatch;
@@ -281,20 +280,27 @@ static int klp_write_object_relocations(struct module *pmod,
 
 static int __klp_disable_patch(struct klp_patch *patch)
 {
-	struct klp_object *obj;
+	if (klp_transition_patch)
+		return -EBUSY;
 
 	/* enforce stacking: only the last enabled patch can be disabled */
 	if (!list_is_last(&patch->list, &klp_patches) &&
 	    list_next_entry(patch, list)->enabled)
 		return -EBUSY;
 
-	pr_notice("disabling patch '%s'\n", patch->mod->name);
+	klp_init_transition(patch, KLP_UNPATCHED);
 
-	klp_for_each_object(patch, obj) {
-		if (obj->patched)
-			klp_unpatch_object(obj);
-	}
+	/*
+	 * Enforce the order of the func->transition writes in
+	 * klp_init_transition() and the TIF_PATCH_PENDING writes in
+	 * klp_start_transition().  In the rare case where klp_ftrace_handler()
+	 * is called shortly after klp_update_patch_state() switches the task,
+	 * this ensures the handler sees that func->transition is set.
+	 */
+	smp_wmb();
 
+	klp_start_transition();
+	klp_try_complete_transition();
 	patch->enabled = false;
 
 	return 0;
@@ -337,6 +343,9 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	struct klp_object *obj;
 	int ret;
 
+	if (klp_transition_patch)
+		return -EBUSY;
+
 	if (WARN_ON(patch->enabled))
 		return -EINVAL;
 
@@ -347,22 +356,36 @@ static int __klp_enable_patch(struct klp_patch *patch)
 
 	pr_notice("enabling patch '%s'\n", patch->mod->name);
 
+	klp_init_transition(patch, KLP_PATCHED);
+
+	/*
+	 * Enforce the order of the func->transition writes in
+	 * klp_init_transition() and the ops->func_stack writes in
+	 * klp_patch_object(), so that klp_ftrace_handler() will see the
+	 * func->transition updates before the handler is registered and the
+	 * new funcs become visible to the handler.
+	 */
+	smp_wmb();
+
 	klp_for_each_object(patch, obj) {
 		if (!klp_is_object_loaded(obj))
 			continue;
 
 		ret = klp_patch_object(obj);
-		if (ret)
-			goto unregister;
+		if (ret) {
+			pr_warn("failed to enable patch '%s'\n",
+				patch->mod->name);
+
+			klp_cancel_transition();
+			return ret;
+		}
 	}
 
+	klp_start_transition();
+	klp_try_complete_transition();
 	patch->enabled = true;
 
 	return 0;
-
-unregister:
-	WARN_ON(__klp_disable_patch(patch));
-	return ret;
 }
 
 /**
@@ -399,6 +422,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
  * /sys/kernel/livepatch
  * /sys/kernel/livepatch/<patch>
  * /sys/kernel/livepatch/<patch>/enabled
+ * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
  */
@@ -424,7 +448,9 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 		goto err;
 	}
 
-	if (enabled) {
+	if (patch == klp_transition_patch) {
+		klp_reverse_transition();
+	} else if (enabled) {
 		ret = __klp_enable_patch(patch);
 		if (ret)
 			goto err;
@@ -452,9 +478,21 @@ static ssize_t enabled_show(struct kobject *kobj,
 	return snprintf(buf, PAGE_SIZE-1, "%d\n", patch->enabled);
 }
 
+static ssize_t transition_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct klp_patch *patch;
+
+	patch = container_of(kobj, struct klp_patch, kobj);
+	return snprintf(buf, PAGE_SIZE-1, "%d\n",
+			patch == klp_transition_patch);
+}
+
 static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
+static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
 static struct attribute *klp_patch_attrs[] = {
 	&enabled_kobj_attr.attr,
+	&transition_kobj_attr.attr,
 	NULL
 };
 
@@ -544,6 +582,7 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 
 	INIT_LIST_HEAD(&func->stack_node);
 	func->patched = false;
+	func->transition = false;
 
 	/* The format for the sysfs directory is <function,sympos> where sympos
 	 * is the nth occurrence of this symbol in kallsyms for the patched
@@ -740,6 +779,16 @@ int klp_register_patch(struct klp_patch *patch)
 		return -ENODEV;
 
 	/*
+	 * Architectures without reliable stack traces have to set
+	 * patch->immediate because there's currently no way to patch kthreads
+	 * with the consistency model.
+	 */
+	if (!klp_have_reliable_stack() && !patch->immediate) {
+		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
+		return -ENOSYS;
+	}
+
+	/*
 	 * A reference is taken on the patch module to prevent it from being
 	 * unloaded.  Right now, we don't allow patch modules to unload since
 	 * there is currently no method to determine if a thread is still
@@ -788,7 +837,11 @@ int klp_module_coming(struct module *mod)
 				goto err;
 			}
 
-			if (!patch->enabled)
+			/*
+			 * Only patch the module if the patch is enabled or is
+			 * in transition.
+			 */
+			if (!patch->enabled && patch != klp_transition_patch)
 				break;
 
 			pr_notice("applying patch '%s' to loading module '%s'\n",
@@ -845,7 +898,11 @@ void klp_module_going(struct module *mod)
 			if (!klp_is_module(obj) || strcmp(obj->name, mod->name))
 				continue;
 
-			if (patch->enabled) {
+			/*
+			 * Only unpatch the module if the patch is enabled or
+			 * is in transition.
+			 */
+			if (patch->enabled || patch == klp_transition_patch) {
 				pr_notice("reverting patch '%s' on unloading module '%s'\n",
 					  patch->mod->name, obj->mod->name);
 				klp_unpatch_object(obj);
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 5efa262..f826903 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -29,6 +29,7 @@
 #include <linux/bug.h>
 #include <linux/printk.h>
 #include "patch.h"
+#include "transition.h"
 
 static LIST_HEAD(klp_ops);
 
@@ -54,15 +55,64 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 {
 	struct klp_ops *ops;
 	struct klp_func *func;
+	int patch_state;
 
 	ops = container_of(fops, struct klp_ops, fops);
 
 	rcu_read_lock();
+
 	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
 				      stack_node);
+
+	/*
+	 * func should never be NULL because preemption should be disabled here
+	 * and unregister_ftrace_function() does the equivalent of a
+	 * synchronize_sched() before the func_stack removal.
+	 */
 	if (WARN_ON_ONCE(!func))
 		goto unlock;
 
+	/*
+	 * In the enable path, enforce the order of the ops->func_stack and
+	 * func->transition reads.  The corresponding write barrier is in
+	 * __klp_enable_patch().
+	 *
+	 * (Note that this barrier technically isn't needed in the disable
+	 * path.  In the rare case where klp_update_patch_state() runs before
+	 * this handler, its TIF_PATCH_PENDING read and this func->transition
+	 * read need to be ordered.  But klp_update_patch_state() already
+	 * enforces that.)
+	 */
+	smp_rmb();
+
+	if (unlikely(func->transition)) {
+
+		/*
+		 * Enforce the order of the func->transition and
+		 * current->patch_state reads.  Otherwise we could read an
+		 * out-of-date task state and pick the wrong function.  The
+		 * corresponding write barrier is in klp_init_transition().
+		 */
+		smp_rmb();
+
+		patch_state = current->patch_state;
+
+		WARN_ON_ONCE(patch_state == KLP_UNDEFINED);
+
+		if (patch_state == KLP_UNPATCHED) {
+			/*
+			 * Use the previously patched version of the function.
+			 * If no previous patches exist, continue with the
+			 * original function.
+			 */
+			func = list_entry_rcu(func->stack_node.next,
+					      struct klp_func, stack_node);
+
+			if (&func->stack_node == &ops->func_stack)
+				goto unlock;
+		}
+	}
+
 	klp_arch_set_pc(regs, (unsigned long)func->new_func);
 unlock:
 	rcu_read_unlock();
@@ -211,3 +261,12 @@ int klp_patch_object(struct klp_object *obj)
 
 	return 0;
 }
+
+void klp_unpatch_objects(struct klp_patch *patch)
+{
+	struct klp_object *obj;
+
+	klp_for_each_object(patch, obj)
+		if (obj->patched)
+			klp_unpatch_object(obj);
+}
diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
index 2d0cce0..0db2271 100644
--- a/kernel/livepatch/patch.h
+++ b/kernel/livepatch/patch.h
@@ -28,5 +28,6 @@ struct klp_ops *klp_find_ops(unsigned long old_addr);
 
 int klp_patch_object(struct klp_object *obj);
 void klp_unpatch_object(struct klp_object *obj);
+void klp_unpatch_objects(struct klp_patch *patch);
 
 #endif /* _LIVEPATCH_PATCH_H */
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
new file mode 100644
index 0000000..428533e
--- /dev/null
+++ b/kernel/livepatch/transition.c
@@ -0,0 +1,543 @@
+/*
+ * transition.c - Kernel Live Patching transition functions
+ *
+ * Copyright (C) 2015-2016 Josh Poimboeuf <jpoimboe@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/stacktrace.h>
+#include "patch.h"
+#include "transition.h"
+#include "../sched/sched.h"
+
+#define MAX_STACK_ENTRIES  100
+#define STACK_ERR_BUF_SIZE 128
+
+extern struct mutex klp_mutex;
+
+struct klp_patch *klp_transition_patch;
+
+static int klp_target_state = KLP_UNDEFINED;
+
+/*
+ * This work can be performed periodically to finish patching or unpatching any
+ * "straggler" tasks which failed to transition in the first attempt.
+ */
+static void klp_transition_work_fn(struct work_struct *work)
+{
+	mutex_lock(&klp_mutex);
+
+	if (klp_transition_patch)
+		klp_try_complete_transition();
+
+	mutex_unlock(&klp_mutex);
+}
+static DECLARE_DELAYED_WORK(klp_transition_work, klp_transition_work_fn);
+
+/*
+ * The transition to the target patch state is complete.  Clean up the data
+ * structures.
+ */
+static void klp_complete_transition(void)
+{
+	struct klp_object *obj;
+	struct klp_func *func;
+	struct task_struct *g, *task;
+	unsigned int cpu;
+
+	if (klp_target_state == KLP_UNPATCHED) {
+		/*
+		 * All tasks have transitioned to KLP_UNPATCHED so we can now
+		 * remove the new functions from the func_stack.
+		 */
+		klp_unpatch_objects(klp_transition_patch);
+
+		/*
+		 * Make sure klp_ftrace_handler() can no longer see functions
+		 * from this patch on the ops->func_stack.  Otherwise, after
+		 * func->transition gets cleared, the handler may choose a
+		 * removed function.
+		 */
+		synchronize_rcu();
+	}
+
+	if (klp_transition_patch->immediate)
+		goto done;
+
+	klp_for_each_object(klp_transition_patch, obj)
+		klp_for_each_func(obj, func)
+			func->transition = false;
+
+	/* Prevent klp_ftrace_handler() from seeing KLP_UNDEFINED state */
+	if (klp_target_state == KLP_PATCHED)
+		synchronize_rcu();
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task) {
+		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
+		task->patch_state = KLP_UNDEFINED;
+	}
+	read_unlock(&tasklist_lock);
+
+	for_each_possible_cpu(cpu) {
+		task = idle_task(cpu);
+		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
+		task->patch_state = KLP_UNDEFINED;
+	}
+
+done:
+	klp_target_state = KLP_UNDEFINED;
+	klp_transition_patch = NULL;
+}
+
+/*
+ * This is called in the error path, to cancel a transition before it has
+ * started, i.e. klp_init_transition() has been called but
+ * klp_start_transition() hasn't.  If the transition *has* been started,
+ * klp_reverse_transition() should be used instead.
+ */
+void klp_cancel_transition(void)
+{
+	klp_target_state = !klp_target_state;
+	klp_complete_transition();
+}
+
+/*
+ * Switch the patched state of the task to the set of functions in the target
+ * patch state.
+ *
+ * NOTE: If task is not 'current', the caller must ensure the task is inactive.
+ * Otherwise klp_ftrace_handler() might read the wrong 'patch_state' value.
+ */
+void klp_update_patch_state(struct task_struct *task)
+{
+	rcu_read_lock();
+
+	/*
+	 * This test_and_clear_tsk_thread_flag() call also serves as a read
+	 * barrier (smp_rmb) for two cases:
+	 *
+	 * 1) Enforce the order of the TIF_PATCH_PENDING read and the
+	 *    klp_target_state read.  The corresponding write barrier is in
+	 *    klp_init_transition().
+	 *
+	 * 2) Enforce the order of the TIF_PATCH_PENDING read and a future read
+	 *    of func->transition, if klp_ftrace_handler() is called later on
+	 *    the same CPU.  See __klp_disable_patch().
+	 */
+	if (test_and_clear_tsk_thread_flag(task, TIF_PATCH_PENDING))
+		task->patch_state = READ_ONCE(klp_target_state);
+
+	rcu_read_unlock();
+}
+
+/*
+ * Determine whether the given stack trace includes any references to a
+ * to-be-patched or to-be-unpatched function.
+ */
+static int klp_check_stack_func(struct klp_func *func,
+				struct stack_trace *trace)
+{
+	unsigned long func_addr, func_size, address;
+	struct klp_ops *ops;
+	int i;
+
+	if (func->immediate)
+		return 0;
+
+	for (i = 0; i < trace->nr_entries; i++) {
+		address = trace->entries[i];
+
+		if (klp_target_state == KLP_UNPATCHED) {
+			 /*
+			  * Check for the to-be-unpatched function
+			  * (the func itself).
+			  */
+			func_addr = (unsigned long)func->new_func;
+			func_size = func->new_size;
+		} else {
+			/*
+			 * Check for the to-be-patched function
+			 * (the previous func).
+			 */
+			ops = klp_find_ops(func->old_addr);
+
+			if (list_is_singular(&ops->func_stack)) {
+				/* original function */
+				func_addr = func->old_addr;
+				func_size = func->old_size;
+			} else {
+				/* previously patched function */
+				struct klp_func *prev;
+
+				prev = list_next_entry(func, stack_node);
+				func_addr = (unsigned long)prev->new_func;
+				func_size = prev->new_size;
+			}
+		}
+
+		if (address >= func_addr && address < func_addr + func_size)
+			return -EAGAIN;
+	}
+
+	return 0;
+}
+
+/*
+ * Determine whether it's safe to transition the task to the target patch state
+ * by looking for any to-be-patched or to-be-unpatched functions on its stack.
+ */
+static int klp_check_stack(struct task_struct *task, char *err_buf)
+{
+	static unsigned long entries[MAX_STACK_ENTRIES];
+	struct stack_trace trace;
+	struct klp_object *obj;
+	struct klp_func *func;
+	int ret;
+
+	trace.skip = 0;
+	trace.nr_entries = 0;
+	trace.max_entries = MAX_STACK_ENTRIES;
+	trace.entries = entries;
+	ret = save_stack_trace_tsk_reliable(task, &trace);
+	WARN_ON_ONCE(ret == -ENOSYS);
+	if (ret) {
+		snprintf(err_buf, STACK_ERR_BUF_SIZE,
+			 "%s: %s:%d has an unreliable stack\n",
+			 __func__, task->comm, task->pid);
+		return ret;
+	}
+
+	klp_for_each_object(klp_transition_patch, obj) {
+		if (!obj->patched)
+			continue;
+		klp_for_each_func(obj, func) {
+			ret = klp_check_stack_func(func, &trace);
+			if (ret) {
+				snprintf(err_buf, STACK_ERR_BUF_SIZE,
+					 "%s: %s:%d is sleeping on function %s\n",
+					 __func__, task->comm, task->pid,
+					 func->old_name);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Try to safely switch a task to the target patch state.  If it's currently
+ * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
+ * if the stack is unreliable, return false.
+ */
+static bool klp_try_switch_task(struct task_struct *task)
+{
+	struct rq *rq;
+	struct rq_flags flags;
+	int ret;
+	bool success = false;
+	char err_buf[STACK_ERR_BUF_SIZE];
+
+	err_buf[0] = '\0';
+
+	/* check if this task has already switched over */
+	if (task->patch_state == klp_target_state)
+		return true;
+
+	/*
+	 * For arches which don't have reliable stack traces, we have to rely
+	 * on other methods (e.g., switching tasks at kernel exit).
+	 */
+	if (!klp_have_reliable_stack())
+		return false;
+
+	/*
+	 * Now try to check the stack for any to-be-patched or to-be-unpatched
+	 * functions.  If all goes well, switch the task to the target patch
+	 * state.
+	 */
+	rq = task_rq_lock(task, &flags);
+
+	if (task_running(rq, task) && task != current) {
+		snprintf(err_buf, STACK_ERR_BUF_SIZE,
+			 "%s: %s:%d is running\n", __func__, task->comm,
+			 task->pid);
+		goto done;
+	}
+
+	ret = klp_check_stack(task, err_buf);
+	if (ret)
+		goto done;
+
+	success = true;
+
+	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	task->patch_state = klp_target_state;
+
+done:
+	task_rq_unlock(rq, task, &flags);
+
+	/*
+	 * Due to console deadlock issues, pr_debug() can't be used while
+	 * holding the task rq lock.  Instead we have to use a temporary buffer
+	 * and print the debug message after releasing the lock.
+	 */
+	if (err_buf[0] != '\0')
+		pr_debug("%s", err_buf);
+
+	return success;
+
+}
+
+/*
+ * Try to switch all remaining tasks to the target patch state by walking the
+ * stacks of sleeping tasks and looking for any to-be-patched or
+ * to-be-unpatched functions.  If such functions are found, the task can't be
+ * switched yet.
+ *
+ * If any tasks are still stuck in the initial patch state, schedule a retry.
+ */
+void klp_try_complete_transition(void)
+{
+	unsigned int cpu;
+	struct task_struct *g, *task;
+	bool complete = true;
+
+	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
+
+	/*
+	 * If the patch can be applied or reverted immediately, skip the
+	 * per-task transitions.
+	 */
+	if (klp_transition_patch->immediate)
+		goto success;
+
+	/*
+	 * Try to switch the tasks to the target patch state by walking their
+	 * stacks and looking for any to-be-patched or to-be-unpatched
+	 * functions.  If such functions are found on a stack, or if the stack
+	 * is deemed unreliable, the task can't be switched yet.
+	 *
+	 * Usually this will transition most (or all) of the tasks on a system
+	 * unless the patch includes changes to a very common function.
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task)
+		if (!klp_try_switch_task(task))
+			complete = false;
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Ditto for the idle "swapper" tasks.
+	 */
+	get_online_cpus();
+	for_each_possible_cpu(cpu) {
+		task = idle_task(cpu);
+		if (cpu_online(cpu)) {
+			if (!klp_try_switch_task(task))
+				complete = false;
+		} else if (task->patch_state != klp_target_state) {
+			/* offline idle tasks can be switched immediately */
+			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+			task->patch_state = klp_target_state;
+		}
+	}
+	put_online_cpus();
+
+	if (!complete) {
+		/*
+		 * Some tasks weren't able to be switched over.  Try again
+		 * later and/or wait for other methods like kernel exit
+		 * switching.
+		 */
+		schedule_delayed_work(&klp_transition_work,
+				      round_jiffies_relative(HZ));
+		return;
+	}
+
+success:
+	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
+		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
+
+	/* we're done, now cleanup the data structures */
+	klp_complete_transition();
+}
+
+/*
+ * Start the transition to the specified target patch state so tasks can begin
+ * switching to it.
+ */
+void klp_start_transition(void)
+{
+	struct task_struct *g, *task;
+	unsigned int cpu;
+
+	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
+
+	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
+		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
+
+	/*
+	 * If the patch can be applied or reverted immediately, skip the
+	 * per-task transitions.
+	 */
+	if (klp_transition_patch->immediate)
+		return;
+
+	/*
+	 * Mark all normal tasks as needing a patch state update.  They'll
+	 * switch either in klp_try_complete_transition() or as they exit the
+	 * kernel.
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task)
+		if (task->patch_state != klp_target_state)
+			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Mark all idle tasks as needing a patch state update.  They'll switch
+	 * either in klp_try_complete_transition() or at the idle loop switch
+	 * point.
+	 */
+	for_each_possible_cpu(cpu) {
+		task = idle_task(cpu);
+		if (task->patch_state != klp_target_state)
+			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	}
+}
+
+/*
+ * Initialize the global target patch state and all tasks to the initial patch
+ * state, and initialize all function transition states to true in preparation
+ * for patching or unpatching.
+ */
+void klp_init_transition(struct klp_patch *patch, int state)
+{
+	struct task_struct *g, *task;
+	unsigned int cpu;
+	struct klp_object *obj;
+	struct klp_func *func;
+	int initial_state = !state;
+
+	WARN_ON_ONCE(klp_target_state != KLP_UNDEFINED);
+
+	klp_transition_patch = patch;
+
+	/*
+	 * Set the global target patch state which tasks will switch to.  This
+	 * has no effect until the TIF_PATCH_PENDING flags get set later.
+	 */
+	klp_target_state = state;
+
+	/*
+	 * If the patch can be applied or reverted immediately, skip the
+	 * per-task transitions.
+	 */
+	if (patch->immediate)
+		return;
+
+	/*
+	 * Initialize all tasks to the initial patch state to prepare them for
+	 * switching to the target state.
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task) {
+		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
+		task->patch_state = initial_state;
+	}
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Ditto for the idle "swapper" tasks.
+	 */
+	for_each_possible_cpu(cpu) {
+		task = idle_task(cpu);
+		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
+		task->patch_state = initial_state;
+	}
+
+	/*
+	 * Enforce the order of the task->patch_state initializations and the
+	 * func->transition updates to ensure that klp_ftrace_handler() doesn't
+	 * see a func in transition with a task->patch_state of KLP_UNDEFINED.
+	 *
+	 * Also enforce the order of the klp_target_state write and future
+	 * TIF_PATCH_PENDING writes to ensure klp_update_patch_state() doesn't
+	 * set a task->patch_state to KLP_UNDEFINED.
+	 */
+	smp_wmb();
+
+	/*
+	 * Set the func transition states so klp_ftrace_handler() will know to
+	 * switch to the transition logic.
+	 *
+	 * When patching, the funcs aren't yet in the func_stack and will be
+	 * made visible to the ftrace handler shortly by the calls to
+	 * klp_patch_object().
+	 *
+	 * When unpatching, the funcs are already in the func_stack and so are
+	 * already visible to the ftrace handler.
+	 */
+	klp_for_each_object(patch, obj)
+		klp_for_each_func(obj, func)
+			func->transition = true;
+}
+
+/*
+ * This function can be called in the middle of an existing transition to
+ * reverse the direction of the target patch state.  This can be done to
+ * effectively cancel an existing enable or disable operation if there are any
+ * tasks which are stuck in the initial patch state.
+ */
+void klp_reverse_transition(void)
+{
+	unsigned int cpu;
+	struct task_struct *g, *task;
+
+	klp_transition_patch->enabled = !klp_transition_patch->enabled;
+
+	klp_target_state = !klp_target_state;
+
+	/*
+	 * Clear all TIF_PATCH_PENDING flags to prevent races caused by
+	 * klp_update_patch_state() running in parallel with
+	 * klp_start_transition().
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task)
+		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	read_unlock(&tasklist_lock);
+
+	for_each_possible_cpu(cpu)
+		clear_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
+
+	/* Let any remaining calls to klp_update_patch_state() complete */
+	synchronize_rcu();
+
+	klp_start_transition();
+}
+
+/* Called from copy_process() during fork */
+void klp_copy_process(struct task_struct *child)
+{
+	child->patch_state = current->patch_state;
+
+	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
+}
diff --git a/kernel/livepatch/transition.h b/kernel/livepatch/transition.h
new file mode 100644
index 0000000..ce09b32
--- /dev/null
+++ b/kernel/livepatch/transition.h
@@ -0,0 +1,14 @@
+#ifndef _LIVEPATCH_TRANSITION_H
+#define _LIVEPATCH_TRANSITION_H
+
+#include <linux/livepatch.h>
+
+extern struct klp_patch *klp_transition_patch;
+
+void klp_init_transition(struct klp_patch *patch, int state);
+void klp_cancel_transition(void);
+void klp_start_transition(void);
+void klp_try_complete_transition(void);
+void klp_reverse_transition(void);
+
+#endif /* _LIVEPATCH_TRANSITION_H */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 6a4bae0..a8b3f1a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
 #include <linux/suspend.h>
+#include <linux/livepatch.h>
 
 #include <asm/tlb.h>
 
@@ -264,6 +265,9 @@ static void do_idle(void)
 
 	sched_ttwu_pending();
 	schedule_preempt_disabled();
+
+	if (unlikely(klp_patch_pending(current)))
+		klp_update_patch_state(current);
 }
 
 bool cpu_in_idle(unsigned long pc)
diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
index e34f871..629e0dc 100644
--- a/samples/livepatch/livepatch-sample.c
+++ b/samples/livepatch/livepatch-sample.c
@@ -17,6 +17,8 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/livepatch.h>
@@ -69,6 +71,21 @@ static int livepatch_init(void)
 {
 	int ret;
 
+	if (!klp_have_reliable_stack() && !patch.immediate) {
+		/*
+		 * WARNING: Be very careful when using 'patch.immediate' in
+		 * your patches.  It's ok to use it for simple patches like
+		 * this, but for more complex patches which change function
+		 * semantics, locking semantics, or data structures, it may not
+		 * be safe.  Use of this option will also prevent removal of
+		 * the patch.
+		 *
+		 * See Documentation/livepatch/livepatch.txt for more details.
+		 */
+		patch.immediate = true;
+		pr_notice("The consistency model isn't supported for your architecture.  Bypassing safety mechanisms and applying the patch immediately.\n");
+	}
+
 	ret = klp_register_patch(&patch);
 	if (ret)
 		return ret;
-- 
2.7.4
