Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency model
Date: Thu, 28 Apr 2016 15:44:48 -0500
Message-Id: <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
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
   reliable stacks (CONFIG_RELIABLE_STACKTRACE and
   CONFIG_STACK_VALIDATION).

2. The second approach, if needed, is kernel exit switching.  A
   task is switched when it returns to user space from a system call, a
   user space IRQ, or a signal.  It's useful in the following cases:

   a) Patching I/O-bound user tasks which are sleeping on an affected
      function.  In this case you have to send SIGSTOP and SIGCONT to
      force it to exit the kernel and be patched.
   b) Patching CPU-bound user tasks.  If the task is highly CPU-bound
      then it will get patched the next time it gets interrupted by an
      IRQ.
   c) Applying patches for architectures which don't yet have
      CONFIG_RELIABLE_STACKTRACE.  In this case you'll have to signal
      most of the tasks on the system.  However this isn't a complete
      solution, because there's currently no way to patch kthreads
      without CONFIG_RELIABLE_STACKTRACE.

   Note: since idle "swapper" tasks don't ever exit the kernel, they
   instead have a kpatch_patch_task() call in the idle loop which allows
   them to patched before the CPU enters the idle state.

3. A third approach (not yet implemented) is planned for the case where
   a kthread is sleeping on an affected function.  In that case we could
   kick the kthread with a signal and then try to patch the task from
   the to-be-patched function's livepatch ftrace handler when it
   re-enters the function.  This will require
   CONFIG_RELIABLE_STACKTRACE.

All the above approaches may be skipped by setting the 'immediate' flag
in the 'klp_patch' struct, which will patch all tasks immediately.  This
can be useful if the patch doesn't change any function or data
semantics.  Note that, even with this flag set, it's possible that some
tasks may still be running with an old version of the function, until
that function returns.

There's also an 'immediate' flag in the 'klp_func' struct which allows
you to specify that certain functions in the patch can be applied
without per-task consistency.  This might be useful if you want to patch
a common function like schedule(), and the function change doesn't need
consistency but the rest of the patch does.

For architectures which don't have CONFIG_RELIABLE_STACKTRACE, there
are two options:

a) the user can set the patch->immediate flag which causes all tasks to
   be patched immediately.  This option should be used with care, only
   when the patch doesn't change any function or data semantics; or

b) use the kernel exit switching approach (this is the default).
   Note the patching will never complete because there's no currently no
   way to patch kthreads without CONFIG_RELIABLE_STACKTRACE.

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
 Documentation/livepatch/livepatch.txt            | 132 ++++++-
 include/linux/init_task.h                        |   9 +
 include/linux/livepatch.h                        |  34 +-
 include/linux/sched.h                            |   3 +
 kernel/fork.c                                    |   3 +
 kernel/livepatch/Makefile                        |   2 +-
 kernel/livepatch/core.c                          |  98 +++--
 kernel/livepatch/patch.c                         |  43 +-
 kernel/livepatch/patch.h                         |   1 +
 kernel/livepatch/transition.c                    | 474 +++++++++++++++++++++++
 kernel/livepatch/transition.h                    |  14 +
 kernel/sched/idle.c                              |   4 +
 13 files changed, 781 insertions(+), 44 deletions(-)
 create mode 100644 kernel/livepatch/transition.c
 create mode 100644 kernel/livepatch/transition.h

diff --git a/Documentation/ABI/testing/sysfs-kernel-livepatch b/Documentation/ABI/testing/sysfs-kernel-livepatch
index da87f43..24ca6df 100644
--- a/Documentation/ABI/testing/sysfs-kernel-livepatch
+++ b/Documentation/ABI/testing/sysfs-kernel-livepatch
@@ -25,6 +25,14 @@ Description:
 		code is currently applied.  Writing 0 will disable the patch
 		while writing 1 will re-enable the patch.
 
+What:		/sys/kernel/livepatch/<patch>/transition
+Date:		May 2016
+KernelVersion:	4.7.0
+Contact:	live-patching@vger.kernel.org
+Description:
+		An attribute which indicates whether the patch is currently in
+		transition.
+
 What:		/sys/kernel/livepatch/<patch>/<object>
 Date:		Nov 2014
 KernelVersion:	3.19.0
diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
index 6c43f6e..bee86d0 100644
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
@@ -86,20 +87,103 @@ or no data are stored in the modified structures at the moment.
 The theory about how to apply functions a safe way is rather complex.
 The aim is to define a so-called consistency model. It attempts to define
 conditions when the new implementation could be used so that the system
-stays consistent. The theory is not yet finished. See the discussion at
-http://thread.gmane.org/gmane.linux.kernel/1823033/focus=1828189
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
+   reliable stacks (CONFIG_RELIABLE_STACKTRACE and
+   CONFIG_STACK_VALIDATION).
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
+   c) Applying patches for architectures which don't yet have
+      CONFIG_RELIABLE_STACKTRACE.  In this case you'll have to signal
+      most of the tasks on the system.  However this isn't a complete
+      solution, because there's currently no way to patch kthreads
+      without CONFIG_RELIABLE_STACKTRACE.
+
+   Note: since idle "swapper" tasks don't ever exit the kernel, they
+   instead have a kpatch_patch_task() call in the idle loop which allows
+   them to patched before the CPU enters the idle state.
+
+3. A third approach (not yet implemented) is planned for the case where
+   a kthread is sleeping on an affected function.  In that case we could
+   kick the kthread with a signal and then try to patch the task from
+   the to-be-patched function's livepatch ftrace handler when it
+   re-enters the function.  This will require
+   CONFIG_RELIABLE_STACKTRACE.
+
+All the above approaches may be skipped by setting the 'immediate' flag
+in the 'klp_patch' struct, which will patch all tasks immediately.  This
+can be useful if the patch doesn't change any function or data
+semantics.  Note that, even with this flag set, it's possible that some
+tasks may still be running with an old version of the function, until
+that function returns.
+
+There's also an 'immediate' flag in the 'klp_func' struct which allows
+you to specify that certain functions in the patch can be applied
+without per-task consistency.  This might be useful if you want to patch
+a common function like schedule(), and the function change doesn't need
+consistency but the rest of the patch does.
+
+For architectures which don't have CONFIG_RELIABLE_STACKTRACE, there
+are two options:
+
+a) the user can set the patch->immediate flag which causes all tasks to
+   be patched immediately.  This option should be used with care, only
+   when the patch doesn't change any function or data semantics; or
+
+b) use the kernel exit switching approach (this is the default).
+   Note the patching will never complete because there's no currently no
+   way to patch kthreads without CONFIG_RELIABLE_STACKTRACE.
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
 
 
 4. Livepatch module
@@ -239,9 +323,15 @@ Registered patches might be enabled either by calling klp_enable_patch() or
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
@@ -261,6 +351,12 @@ by writing '0' to /sys/kernel/livepatch/<name>/enabled. At this stage
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
index f2cb8d4..12199ef 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -14,6 +14,7 @@
 #include <linux/rbtree.h>
 #include <net/net_namespace.h>
 #include <linux/sched/rt.h>
+#include <linux/livepatch.h>
 
 #ifdef CONFIG_SMP
 # define INIT_PUSHABLE_TASKS(tsk)					\
@@ -183,6 +184,13 @@ extern struct task_group root_task_group;
 # define INIT_KASAN(tsk)
 #endif
 
+#ifdef CONFIG_LIVEPATCH
+#define INIT_LIVEPATCH(tsk)						\
+	.patch_state = KLP_UNDEFINED,
+#else
+#define INIT_LIVEPATCH(tsk)
+#endif
+
 /*
  *  INIT_TASK is used to set up the first task table, touch at
  * your own risk!. Base=0, limit=0x1fffff (=2MB)
@@ -260,6 +268,7 @@ extern struct task_group root_task_group;
 	INIT_VTIME(tsk)							\
 	INIT_NUMA_BALANCING(tsk)					\
 	INIT_KASAN(tsk)							\
+	INIT_LIVEPATCH(tsk)						\
 }
 
 
diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index c38c694..6ec50ff 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -28,18 +28,40 @@
 
 #include <asm/livepatch.h>
 
+/* task patch states */
+#define KLP_UNDEFINED	-1
+#define KLP_UNPATCHED	0
+#define KLP_PATCHED	1
+
 /**
  * struct klp_func - function structure for live patching
  * @old_name:	name of the function to be patched
  * @new_func:	pointer to the patched function code
  * @old_sympos: a hint indicating which symbol position the old function
  *		can be found (optional)
+ * @immediate:  patch the func immediately, bypassing backtrace safety checks
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
@@ -116,15 +142,21 @@ int klp_disable_patch(struct klp_patch *);
 int klp_module_coming(struct module *mod);
 void klp_module_going(struct module *mod);
 
-static inline bool klp_patch_pending(struct task_struct *task) { return false; }
+void klp_copy_process(struct task_struct *child);
 void klp_patch_task(struct task_struct *task);
 
+static inline bool klp_patch_pending(struct task_struct *task)
+{
+	return test_tsk_thread_flag(task, TIF_PATCH_PENDING);
+}
+
 #else /* !CONFIG_LIVEPATCH */
 
 static inline int klp_module_coming(struct module *mod) { return 0; }
 static inline void klp_module_going(struct module *mod) {}
 static inline bool klp_patch_pending(struct task_struct *task) { return false; }
 static inline void klp_patch_task(struct task_struct *task) {}
+static inline void klp_copy_process(struct task_struct *child) {}
 
 #endif /* CONFIG_LIVEPATCH */
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index fb364a0..7fc8b49 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1860,6 +1860,9 @@ struct task_struct {
 #ifdef CONFIG_MMU
 	struct task_struct *oom_reaper_list;
 #endif
+#ifdef CONFIG_LIVEPATCH
+	int patch_state;
+#endif
 /* CPU-specific state of this task */
 	struct thread_struct thread;
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index d2fe04a..a12e3b0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -76,6 +76,7 @@
 #include <linux/compiler.h>
 #include <linux/sysctl.h>
 #include <linux/kcov.h>
+#include <linux/livepatch.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1586,6 +1587,8 @@ static struct task_struct *copy_process(unsigned long clone_flags,
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
index aa3dbdf..0be352f 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -31,12 +31,15 @@
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
+ * - klp_patch_task()
  */
 static DEFINE_MUTEX(klp_mutex);
 
@@ -44,8 +47,28 @@ static LIST_HEAD(klp_patches);
 
 static struct kobject *klp_root_kobj;
 
-/* TODO: temporary stub */
-void klp_patch_task(struct task_struct *task) {}
+static void klp_work_fn(struct work_struct *work);
+static DECLARE_DELAYED_WORK(klp_work, klp_work_fn);
+
+static void klp_schedule_work(void)
+{
+	schedule_delayed_work(&klp_work, round_jiffies_relative(HZ));
+}
+
+/*
+ * This work can be performed periodically to finish patching or unpatching any
+ * "straggler" tasks which failed to transition in klp_enable_patch().
+ */
+static void klp_work_fn(struct work_struct *work)
+{
+	mutex_lock(&klp_mutex);
+
+	if (klp_transition_patch)
+		if (!klp_try_complete_transition())
+			klp_schedule_work();
+
+	mutex_unlock(&klp_mutex);
+}
 
 static bool klp_is_module(struct klp_object *obj)
 {
@@ -85,7 +108,6 @@ static void klp_find_object_module(struct klp_object *obj)
 	mutex_unlock(&module_mutex);
 }
 
-/* klp_mutex must be held by caller */
 static bool klp_is_patch_registered(struct klp_patch *patch)
 {
 	struct klp_patch *mypatch;
@@ -283,19 +305,18 @@ static int klp_write_object_relocations(struct module *pmod,
 
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
-
-	klp_for_each_object(patch, obj) {
-		if (obj->patched)
-			klp_unpatch_object(obj);
-	}
+	klp_init_transition(patch, KLP_UNPATCHED);
+	klp_start_transition();
+	if (!klp_try_complete_transition())
+		klp_schedule_work();
 
 	patch->enabled = false;
 
@@ -339,6 +360,9 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	struct klp_object *obj;
 	int ret;
 
+	if (klp_transition_patch)
+		return -EBUSY;
+
 	if (WARN_ON(patch->enabled))
 		return -EINVAL;
 
@@ -350,24 +374,32 @@ static int __klp_enable_patch(struct klp_patch *patch)
 	pr_notice_once("tainting kernel with TAINT_LIVEPATCH\n");
 	add_taint(TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
 
-	pr_notice("enabling patch '%s'\n", patch->mod->name);
+	klp_init_transition(patch, KLP_PATCHED);
 
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
+			klp_unpatch_objects(patch);
+			klp_complete_transition();
+
+			return ret;
+		}
 	}
 
+	klp_start_transition();
+
+	if (!klp_try_complete_transition())
+		klp_schedule_work();
+
 	patch->enabled = true;
 
 	return 0;
-
-unregister:
-	WARN_ON(__klp_disable_patch(patch));
-	return ret;
 }
 
 /**
@@ -404,6 +436,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
  * /sys/kernel/livepatch
  * /sys/kernel/livepatch/<patch>
  * /sys/kernel/livepatch/<patch>/enabled
+ * /sys/kernel/livepatch/<patch>/transition
  * /sys/kernel/livepatch/<patch>/<object>
  * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
  */
@@ -432,7 +465,9 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
 		goto err;
 	}
 
-	if (val) {
+	if (patch == klp_transition_patch) {
+		klp_reverse_transition();
+	} else if (val) {
 		ret = __klp_enable_patch(patch);
 		if (ret)
 			goto err;
@@ -460,9 +495,21 @@ static ssize_t enabled_show(struct kobject *kobj,
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
 
@@ -549,6 +596,7 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 {
 	INIT_LIST_HEAD(&func->stack_node);
 	func->patched = false;
+	func->transition = false;
 
 	/* The format for the sysfs directory is <function,sympos> where sympos
 	 * is the nth occurrence of this symbol in kallsyms for the patched
@@ -781,7 +829,11 @@ int klp_module_coming(struct module *mod)
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
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 782fbb5..b3b8639 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -29,6 +29,7 @@
 #include <linux/bug.h>
 #include <linux/printk.h>
 #include "patch.h"
+#include "transition.h"
 
 static LIST_HEAD(klp_ops);
 
@@ -58,11 +59,42 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	ops = container_of(fops, struct klp_ops, fops);
 
 	rcu_read_lock();
+
 	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
 				      stack_node);
-	if (WARN_ON_ONCE(!func))
+
+	if (!func)
 		goto unlock;
 
+	/*
+	 * See the comment for the 2nd smp_wmb() in klp_init_transition() for
+	 * an explanation of why this read barrier is needed.
+	 */
+	smp_rmb();
+
+	if (unlikely(func->transition)) {
+
+		/*
+		 * See the comment for the 1st smp_wmb() in
+		 * klp_init_transition() for an explanation of why this read
+		 * barrier is needed.
+		 */
+		smp_rmb();
+
+		if (current->patch_state == KLP_UNPATCHED) {
+			/*
+			 * Use the previously patched version of the function.
+			 * If no previous patches exist, use the original
+			 * function.
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
@@ -211,3 +243,12 @@ int klp_patch_object(struct klp_object *obj)
 
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
index 0000000..92819bb
--- /dev/null
+++ b/kernel/livepatch/transition.c
@@ -0,0 +1,474 @@
+/*
+ * transition.c - Kernel Live Patching transition functions
+ *
+ * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
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
+#include "../sched/sched.h"
+
+#include "patch.h"
+#include "transition.h"
+
+#define MAX_STACK_ENTRIES 100
+
+struct klp_patch *klp_transition_patch;
+
+static int klp_target_state;
+
+/* called from copy_process() during fork */
+void klp_copy_process(struct task_struct *child)
+{
+	child->patch_state = current->patch_state;
+
+	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
+}
+
+/*
+ * klp_patch_task() - change the patched state of a task
+ * @task:	The task to change
+ *
+ * Switches the patched state of the task to the set of functions in the target
+ * patch state.
+ */
+void klp_patch_task(struct task_struct *task)
+{
+	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+
+	/*
+	 * The corresponding write barriers are in klp_init_transition() and
+	 * klp_reverse_transition().  See the comments there for an explanation.
+	 */
+	smp_rmb();
+
+	task->patch_state = klp_target_state;
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
+	klp_transition_patch = patch;
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
+	for_each_process_thread(g, task)
+		task->patch_state = initial_state;
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Ditto for the idle "swapper" tasks.
+	 */
+	get_online_cpus();
+	for_each_online_cpu(cpu)
+		idle_task(cpu)->patch_state = initial_state;
+	put_online_cpus();
+
+	/*
+	 * Ensure klp_ftrace_handler() sees the task->patch_state updates
+	 * before the func->transition updates.  Otherwise it could read an
+	 * out-of-date task state and pick the wrong function.
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
+
+	/*
+	 * Set the global target patch state which tasks will switch to.  This
+	 * has no effect until the TIF_PATCH_PENDING flags get set later.
+	 */
+	klp_target_state = state;
+
+	/*
+	 * For the enable path, ensure klp_ftrace_handler() will see the
+	 * func->transition updates before the funcs become visible to the
+	 * handler.  Otherwise the handler may wrongly pick the new func before
+	 * the task switches to the patched state.
+	 *
+	 * For the disable path, the funcs are already visible to the handler.
+	 * But we still need to ensure the ftrace handler will see the
+	 * func->transition updates before the tasks start switching to the
+	 * unpatched state.  Otherwise the handler can miss a task patch state
+	 * change which would result in it wrongly picking the new function.
+	 *
+	 * This barrier also ensures that if another CPU goes through the
+	 * syscall barrier, sees the TIF_PATCH_PENDING writes in
+	 * klp_start_transition(), and calls klp_patch_task(), it also sees the
+	 * above write to the target state.  Otherwise it can put the task in
+	 * the wrong universe.
+	 */
+	smp_wmb();
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
+	 * Mark all normal tasks as needing a patch state update.  As they pass
+	 * through the syscall barrier they'll switch over to the target state
+	 * (unless we switch them in klp_try_complete_transition() first).
+	 */
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task)
+		set_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * Ditto for the idle "swapper" tasks, though they never cross the
+	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
+	 */
+	get_online_cpus();
+	for_each_online_cpu(cpu)
+		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
+	put_online_cpus();
+}
+
+/*
+ * The transition to the target patch state is complete.  Clean up the data
+ * structures.
+ */
+void klp_complete_transition(void)
+{
+	struct klp_object *obj;
+	struct klp_func *func;
+	struct task_struct *g, *task;
+	unsigned int cpu;
+
+	if (klp_transition_patch->immediate)
+		goto done;
+
+	klp_for_each_object(klp_transition_patch, obj)
+		klp_for_each_func(obj, func)
+			func->transition = false;
+
+	read_lock(&tasklist_lock);
+	for_each_process_thread(g, task) {
+		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+		task->patch_state = KLP_UNDEFINED;
+	}
+	read_unlock(&tasklist_lock);
+
+	get_online_cpus();
+	for_each_online_cpu(cpu) {
+		task = idle_task(cpu);
+		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+		task->patch_state = KLP_UNDEFINED;
+	}
+	put_online_cpus();
+
+done:
+	klp_transition_patch = NULL;
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
+static int klp_check_stack(struct task_struct *task)
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
+		pr_debug("%s: pid %d (%s) has an unreliable stack\n",
+			 __func__, task->pid, task->comm);
+		return ret;
+	}
+
+	klp_for_each_object(klp_transition_patch, obj) {
+		if (!obj->patched)
+			continue;
+		klp_for_each_func(obj, func) {
+			ret = klp_check_stack_func(func, &trace);
+			if (ret) {
+				pr_debug("%s: pid %d (%s) is sleeping on function %s\n",
+					 __func__, task->pid, task->comm,
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
+	unsigned long flags;
+	int ret;
+	bool success = false;
+
+	/* check if this task has already switched over */
+	if (task->patch_state == klp_target_state)
+		return true;
+
+	/*
+	 * For arches which don't have reliable stack traces, we have to rely
+	 * on other methods (e.g., switching tasks at the syscall barrier).
+	 */
+	if (!IS_ENABLED(CONFIG_RELIABLE_STACKTRACE))
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
+		pr_debug("%s: pid %d (%s) is running\n", __func__, task->pid,
+			 task->comm);
+		goto done;
+	}
+
+	ret = klp_check_stack(task);
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
+	return success;
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
+bool klp_try_complete_transition(void)
+{
+	unsigned int cpu;
+	struct task_struct *g, *task;
+	bool complete = true;
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
+	for_each_online_cpu(cpu)
+		if (!klp_try_switch_task(idle_task(cpu)))
+			complete = false;
+	put_online_cpus();
+
+	/*
+	 * Some tasks weren't able to be switched over.  Try again later and/or
+	 * wait for other methods like syscall barrier switching.
+	 */
+	if (!complete)
+		return false;
+
+success:
+	/*
+	 * When unpatching, all tasks have transitioned to KLP_UNPATCHED so we
+	 * can now remove the new functions from the func_stack.
+	 */
+	if (klp_target_state == KLP_UNPATCHED) {
+		klp_unpatch_objects(klp_transition_patch);
+
+		/*
+		 * Don't allow any existing instances of ftrace handlers to
+		 * access any obsolete funcs before we reset the func
+		 * transition states to false.  Otherwise the handler may see
+		 * the deleted "new" func, see that it's not in transition, and
+		 * wrongly pick the new version of the function.
+		 */
+		synchronize_rcu();
+	}
+
+	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
+		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
+
+	/* we're done, now cleanup the data structures */
+	klp_complete_transition();
+
+	return true;
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
+	struct klp_patch *patch = klp_transition_patch;
+
+	klp_target_state = !klp_target_state;
+
+	/*
+	 * Ensure that if another CPU goes through the syscall barrier, sees
+	 * the TIF_PATCH_PENDING writes in klp_start_transition(), and calls
+	 * klp_patch_task(), it also sees the above write to the target state.
+	 * Otherwise it can put the task in the wrong universe.
+	 */
+	smp_wmb();
+
+	klp_start_transition();
+	klp_try_complete_transition();
+
+	patch->enabled = !patch->enabled;
+}
+
diff --git a/kernel/livepatch/transition.h b/kernel/livepatch/transition.h
new file mode 100644
index 0000000..5191b96
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
+void klp_start_transition(void);
+void klp_reverse_transition(void);
+bool klp_try_complete_transition(void);
+void klp_complete_transition(void);
+
+#endif /* _LIVEPATCH_TRANSITION_H */
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index bd12c6c..60d633f 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
 #include <linux/suspend.h>
+#include <linux/livepatch.h>
 
 #include <asm/tlb.h>
 
@@ -266,6 +267,9 @@ static void cpu_idle_loop(void)
 
 		sched_ttwu_pending();
 		schedule_preempt_disabled();
+
+		if (unlikely(klp_patch_pending(current)))
+			klp_patch_task(current);
 	}
 }
 
-- 
2.4.11
