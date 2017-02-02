Return-Path: <pmladek@suse.com>
Date: Thu, 2 Feb 2017 12:51:16 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170202115116.GB23754@pathway.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

!!! This is the right version. I am sorry again for the confusion. !!!

> Change livepatch to use a basic per-task consistency model.  This is the
> foundation which will eventually enable us to patch those ~10% of
> security patches which change function or data semantics.  This is the
> biggest remaining piece needed to make livepatch more generally useful.
> 
> diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> index 7f04e13..fb00d66 100644
> --- a/Documentation/livepatch/livepatch.txt
> +++ b/Documentation/livepatch/livepatch.txt
> +3.1 Adding consistency model support to new architectures
> +---------------------------------------------------------
> +
> +For adding consistency model support to new architectures, there are a
> +few options:
> +
> +1) Add CONFIG_HAVE_RELIABLE_STACKTRACE.  This means porting objtool, and
> +   for non-DWARF unwinders, also making sure there's a way for the stack
> +   tracing code to detect interrupts on the stack.
> +
> +2) Alternatively, figure out a way to patch kthreads without stack
> +   checking.  If all kthreads sleep in the same place, then we can
> +   designate that place as a patching point.  I think Petr M has been
> +   working on that?

Here is version with some more details:

Alternatively, every kthread has to explicitely switch
current->patch_state on a safe place. Kthreads are typically
"infinite" loops that do some action repeatedly. The safe
location is between the loops when there are no locks
taken and all data structures are in a well defined state.

The location is clear when using the workqueues or the kthread worker
API. These kthreads process "independent" works in a generic loop.

It is much more complicated with kthreads using a custom loop.
There the safe place must be carefully localized case by case.


> +  In that case, arches without
> +   HAVE_RELIABLE_STACKTRACE would still be able to use the
> +   non-stack-checking parts of the consistency model:
> +
> +   a) patching user tasks when they cross the kernel/user space
> +      boundary; and
> +
> +   b) patching kthreads and idle tasks at their designated patch points.
> +
> +   This option isn't as good as option 1 because it requires signaling
> +   most of the tasks to patch them.

Kthreads need to be waken because most of them ignore signals.

And idle tasks might need to be explicitely scheduled if there
is too big load. Mirek knows more about this.

Well, I am not sure if you want to get into such details.


> +  But it could still be a good backup
> +   option for those architectures which don't have reliable stack traces
> +   yet.
> +
> +In the meantime, patches for such architectures can bypass the
> +consistency model by setting klp_patch.immediate to true.

I would add that this is perfectly fine for patches that do not
change semantic of the patched functions. In practice, this is
usable in about 90% of security and critical fixes.


>  4. Livepatch module
> @@ -134,7 +242,7 @@ Documentation/livepatch/module-elf-format.txt for more details.
>  
>  
>  4.2. Metadata
> -------------
> +-------------
>  
>  The patch is described by several structures that split the information
>  into three levels:
> @@ -239,9 +347,15 @@ Registered patches might be enabled either by calling klp_enable_patch() or
>  by writing '1' to /sys/kernel/livepatch/<name>/enabled. The system will
>  start using the new implementation of the patched functions at this stage.
>  
> -In particular, if an original function is patched for the first time, a
> -function specific struct klp_ops is created and an universal ftrace handler
> -is registered.
> +When a patch is enabled, livepatch enters into a transition state where
> +tasks are converging to the patched state.  This is indicated by a value
> +of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks have
> +been patched, the 'transition' value changes to '0'.  For more
> +information about this process, see the "Consistency model" section.
> +
> +If an original function is patched for the first time, a function
> +specific struct klp_ops is created and an universal ftrace handler is
> +registered.
>  
>  Functions might be patched multiple times. The ftrace handler is registered
>  only once for the given function. Further patches just add an entry to the
> @@ -261,6 +375,12 @@ by writing '0' to /sys/kernel/livepatch/<name>/enabled. At this stage
>  either the code from the previously enabled patch or even the original
>  code gets used.
>  
> +When a patch is disabled, livepatch enters into a transition state where
> +tasks are converging to the unpatched state.  This is indicated by a
> +value of '1' in /sys/kernel/livepatch/<name>/transition.  Once all tasks
> +have been unpatched, the 'transition' value changes to '0'.  For more
> +information about this process, see the "Consistency model" section.
> +
>  Here all the functions (struct klp_func) associated with the to-be-disabled
>  patch are removed from the corresponding struct klp_ops. The ftrace handler
>  is unregistered and the struct klp_ops is freed when the func_stack list
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> index 325f649..25f0360 100644
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -14,6 +14,7 @@
>  #include <linux/rbtree.h>
>  #include <net/net_namespace.h>
>  #include <linux/sched/rt.h>
> +#include <linux/livepatch.h>
>  
>  #include <asm/thread_info.h>
>  
> @@ -185,6 +186,13 @@ extern struct task_group root_task_group;
>  # define INIT_KASAN(tsk)
>  #endif
>  
> +#ifdef CONFIG_LIVEPATCH
> +# define INIT_LIVEPATCH(tsk)						\
> +	.patch_state = KLP_UNDEFINED,
> +#else
> +# define INIT_LIVEPATCH(tsk)
> +#endif
> +
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  # define INIT_TASK_TI(tsk)			\
>  	.thread_info = INIT_THREAD_INFO(tsk),	\
> @@ -271,6 +279,7 @@ extern struct task_group root_task_group;
>  	INIT_VTIME(tsk)							\
>  	INIT_NUMA_BALANCING(tsk)					\
>  	INIT_KASAN(tsk)							\
> +	INIT_LIVEPATCH(tsk)						\
>  }
>  
>  
> diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> index 6602b34..ed90ad1 100644
> --- a/include/linux/livepatch.h
> +++ b/include/linux/livepatch.h
> @@ -28,18 +28,40 @@
>  
>  #include <asm/livepatch.h>
>  
> +/* task patch states */
> +#define KLP_UNDEFINED	-1
> +#define KLP_UNPATCHED	 0
> +#define KLP_PATCHED	 1
> +
>  /**
>   * struct klp_func - function structure for live patching
>   * @old_name:	name of the function to be patched
>   * @new_func:	pointer to the patched function code
>   * @old_sympos: a hint indicating which symbol position the old function
>   *		can be found (optional)
> + * @immediate:  patch the func immediately, bypassing safety mechanisms
>   * @old_addr:	the address of the function being patched
>   * @kobj:	kobject for sysfs resources
>   * @stack_node:	list node for klp_ops func_stack list
>   * @old_size:	size of the old function
>   * @new_size:	size of the new function
>   * @patched:	the func has been added to the klp_ops list
> + * @transition:	the func is currently being applied or reverted
> + *
> + * The patched and transition variables define the func's patching state.  When
> + * patching, a func is always in one of the following states:
> + *
> + *   patched=0 transition=0: unpatched
> + *   patched=0 transition=1: unpatched, temporary starting state
> + *   patched=1 transition=1: patched, may be visible to some tasks
> + *   patched=1 transition=0: patched, visible to all tasks
> + *
> + * And when unpatching, it goes in the reverse order:
> + *
> + *   patched=1 transition=0: patched, visible to all tasks
> + *   patched=1 transition=1: patched, may be visible to some tasks
> + *   patched=0 transition=1: unpatched, temporary ending state
> + *   patched=0 transition=0: unpatched
>   */
>  struct klp_func {
>  	/* external */
> @@ -53,6 +75,7 @@ struct klp_func {
>  	 * in kallsyms for the given object is used.
>  	 */
>  	unsigned long old_sympos;
> +	bool immediate;
>  
>  	/* internal */
>  	unsigned long old_addr;
> @@ -60,6 +83,7 @@ struct klp_func {
>  	struct list_head stack_node;
>  	unsigned long old_size, new_size;
>  	bool patched;
> +	bool transition;
>  };
>  
>  /**
> @@ -68,7 +92,7 @@ struct klp_func {
>   * @funcs:	function entries for functions to be patched in the object
>   * @kobj:	kobject for sysfs resources
>   * @mod:	kernel module associated with the patched object
> - * 		(NULL for vmlinux)
> + *		(NULL for vmlinux)
>   * @patched:	the object's funcs have been added to the klp_ops list
>   */
>  struct klp_object {
> @@ -86,6 +110,7 @@ struct klp_object {
>   * struct klp_patch - patch structure for live patching
>   * @mod:	reference to the live patch module
>   * @objs:	object entries for kernel objects to be patched
> + * @immediate:  patch all funcs immediately, bypassing safety mechanisms
>   * @list:	list node for global list of registered patches
>   * @kobj:	kobject for sysfs resources
>   * @enabled:	the patch is enabled (but operation may be incomplete)
> @@ -94,6 +119,7 @@ struct klp_patch {
>  	/* external */
>  	struct module *mod;
>  	struct klp_object *objs;
> +	bool immediate;
>  
>  	/* internal */
>  	struct list_head list;
> @@ -121,13 +147,27 @@ void arch_klp_init_object_loaded(struct klp_patch *patch,
>  int klp_module_coming(struct module *mod);
>  void klp_module_going(struct module *mod);
>  
> +void klp_copy_process(struct task_struct *child);
>  void klp_update_patch_state(struct task_struct *task);
>  
> +static inline bool klp_patch_pending(struct task_struct *task)
> +{
> +	return test_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +}
> +
> +static inline bool klp_have_reliable_stack(void)
> +{
> +	return IS_ENABLED(CONFIG_STACKTRACE) &&
> +	       IS_ENABLED(CONFIG_HAVE_RELIABLE_STACKTRACE);
> +}
> +
>  #else /* !CONFIG_LIVEPATCH */
>  
>  static inline int klp_module_coming(struct module *mod) { return 0; }
>  static inline void klp_module_going(struct module *mod) {}
> +static inline bool klp_patch_pending(struct task_struct *task) { return false; }
>  static inline void klp_update_patch_state(struct task_struct *task) {}
> +static inline void klp_copy_process(struct task_struct *child) {}
>  
>  #endif /* CONFIG_LIVEPATCH */
>  
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9df1f42..ccbb1fa 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1973,6 +1973,9 @@ struct task_struct {
>  	/* A live task holds one reference. */
>  	atomic_t stack_refcount;
>  #endif
> +#ifdef CONFIG_LIVEPATCH
> +	int patch_state;
> +#endif
>  /* CPU-specific state of this task */
>  	struct thread_struct thread;
>  /*
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 7da33cb..8c8de80 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -77,6 +77,7 @@
>  #include <linux/compiler.h>
>  #include <linux/sysctl.h>
>  #include <linux/kcov.h>
> +#include <linux/livepatch.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
> @@ -1765,6 +1766,8 @@ static __latent_entropy struct task_struct *copy_process(
>  		p->parent_exec_id = current->self_exec_id;
>  	}
>  
> +	klp_copy_process(p);
> +
>  	spin_lock(&current->sighand->siglock);
>  
>  	/*
> diff --git a/kernel/livepatch/Makefile b/kernel/livepatch/Makefile
> index e136dad..2b8bdb1 100644
> --- a/kernel/livepatch/Makefile
> +++ b/kernel/livepatch/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_LIVEPATCH) += livepatch.o
>  
> -livepatch-objs := core.o patch.o
> +livepatch-objs := core.o patch.o transition.o
> diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> index 10ba3a1..4c5a816 100644
> --- a/kernel/livepatch/core.c
> +++ b/kernel/livepatch/core.c
> @@ -31,22 +31,22 @@
>  #include <linux/moduleloader.h>
>  #include <asm/cacheflush.h>
>  #include "patch.h"
> +#include "transition.h"
>  
>  /*
> - * The klp_mutex protects the global lists and state transitions of any
> - * structure reachable from them.  References to any structure must be obtained
> - * under mutex protection (except in klp_ftrace_handler(), which uses RCU to
> - * ensure it gets consistent data).
> + * klp_mutex is a coarse lock which serializes access to klp data.  All
> + * accesses to klp-related variables and structures must have mutex protection,
> + * except within the following functions which carefully avoid the need for it:
> + *
> + * - klp_ftrace_handler()
> + * - klp_update_patch_state()
>   */
> -static DEFINE_MUTEX(klp_mutex);
> +DEFINE_MUTEX(klp_mutex);
>  
>  static LIST_HEAD(klp_patches);
>  
>  static struct kobject *klp_root_kobj;
>  
> -/* TODO: temporary stub */
> -void klp_update_patch_state(struct task_struct *task) {}
> -
>  static bool klp_is_module(struct klp_object *obj)
>  {
>  	return obj->name;
> @@ -85,7 +85,6 @@ static void klp_find_object_module(struct klp_object *obj)
>  	mutex_unlock(&module_mutex);
>  }
>  
> -/* klp_mutex must be held by caller */
>  static bool klp_is_patch_registered(struct klp_patch *patch)
>  {
>  	struct klp_patch *mypatch;
> @@ -281,20 +280,25 @@ static int klp_write_object_relocations(struct module *pmod,
>  
>  static int __klp_disable_patch(struct klp_patch *patch)
>  {
> -	struct klp_object *obj;
> +	if (klp_transition_patch)
> +		return -EBUSY;
>  
>  	/* enforce stacking: only the last enabled patch can be disabled */
>  	if (!list_is_last(&patch->list, &klp_patches) &&
>  	    list_next_entry(patch, list)->enabled)
>  		return -EBUSY;
>  
> -	pr_notice("disabling patch '%s'\n", patch->mod->name);
> +	klp_init_transition(patch, KLP_UNPATCHED);
>  
> -	klp_for_each_object(patch, obj) {
> -		if (obj->patched)
> -			klp_unpatch_object(obj);
> -	}
> +	/*
> +	 * Enforce the order of the klp_target_state write in
> +	 * klp_init_transition() and the TIF_PATCH_PENDING writes in
> +	 * klp_start_transition() to ensure that klp_update_patch_state()
> +	 * doesn't set a task->patch_state to KLP_UNDEFINED.
> +	 */
> +	smp_wmb();

The description is not clear. The klp_target_state manipulation
is synchronized by another barrier inside klp_init_transition().

A similar barrier is in __klp_enable_patch() and it is correctly
described there:

   It enforces the order of the func->transition writes in
   klp_init_transition() and the ops->func_stack writes in
   klp_patch_object(). The corresponding barrier is in
   klp_ftrace_handler().

But we do not modify ops->func_stack in __klp_disable_patch().
So we need another explanation.

Huh, I spent few hours thinking about it. I am almost sure
that it is not needed. But I am not 100% sure. The many times
rewriten summary looks like:

	/*
	 * Enforce the order of func->transtion write in
	 * klp_init_transition() against TIF_PATCH_PENDING writes
	 * in klp_start_transition(). It makes sure that
	 * klp_ftrace_hadler() will see func->transition set
	 * after the task is migrated by klp_update_patch_state().
	 *
	 * The barrier probably is not needed because the task
	 * must not be migrated when being inside klp_ftrace_handler()
	 * and there is another full barrier in
	 * klp_update_patch_state().
	 * But this is slow path and better be safe than sorry.
	 */
	 smp_wmb();


> +	klp_start_transition();
>  	patch->enabled = false;
>  
>  	return 0;
> @@ -337,6 +341,9 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  	struct klp_object *obj;
>  	int ret;
>  
> +	if (klp_transition_patch)
> +		return -EBUSY;
> +
>  	if (WARN_ON(patch->enabled))
>  		return -EINVAL;
>  
> @@ -347,22 +354,37 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  
>  	pr_notice("enabling patch '%s'\n", patch->mod->name);
>  
> +	klp_init_transition(patch, KLP_PATCHED);
> +
> +	/*
> +	 * Enforce the order of the func->transition writes in
> +	 * klp_init_transition() and the ops->func_stack writes in
> +	 * klp_patch_object(), so that klp_ftrace_handler() will see the
> +	 * func->transition updates before the handler is registered and the
> +	 * new funcs become visible to the handler.
> +	 */
> +	smp_wmb();
> +
>  	klp_for_each_object(patch, obj) {
>  		if (!klp_is_object_loaded(obj))
>  			continue;
>  
>  		ret = klp_patch_object(obj);
> -		if (ret)
> -			goto unregister;
> +		if (ret) {
> +			pr_warn("failed to enable patch '%s'\n",
> +				patch->mod->name);
> +
> +			klp_unpatch_objects(patch);

We should call here synchronize_rcu() here as we do
in klp_try_complete_transition(). Some of the affected
functions might have more versions on the stack and we
need to make sure that klp_ftrace_handler() will _not_
see the removed patch on the stack.

Alternatively, we could move all the code around
klp_unpatch_objects() from klp_try_complete_transition()
into klp_complete_transition(), see below.

> +			klp_complete_transition();
> +
> +			return ret;
> +		}
>  	}
>  
> +	klp_start_transition();
>  	patch->enabled = true;
>  
>  	return 0;
> -
> -unregister:
> -	WARN_ON(__klp_disable_patch(patch));
> -	return ret;
>  }
>  
>  /**
> @@ -399,6 +421,7 @@ EXPORT_SYMBOL_GPL(klp_enable_patch);
>   * /sys/kernel/livepatch
>   * /sys/kernel/livepatch/<patch>
>   * /sys/kernel/livepatch/<patch>/enabled
> + * /sys/kernel/livepatch/<patch>/transition
>   * /sys/kernel/livepatch/<patch>/<object>
>   * /sys/kernel/livepatch/<patch>/<object>/<function,sympos>
>   */
> @@ -424,7 +447,9 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
>  		goto err;
>  	}
>  
> -	if (enabled) {
> +	if (patch == klp_transition_patch) {
> +		klp_reverse_transition();
> +	} else if (enabled) {
>  		ret = __klp_enable_patch(patch);
>  		if (ret)
>  			goto err;
> @@ -452,9 +477,21 @@ static ssize_t enabled_show(struct kobject *kobj,
>  	return snprintf(buf, PAGE_SIZE-1, "%d\n", patch->enabled);
>  }
>  
> +static ssize_t transition_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr, char *buf)
> +{
> +	struct klp_patch *patch;
> +
> +	patch = container_of(kobj, struct klp_patch, kobj);
> +	return snprintf(buf, PAGE_SIZE-1, "%d\n",
> +			patch == klp_transition_patch);
> +}
> +
>  static struct kobj_attribute enabled_kobj_attr = __ATTR_RW(enabled);
> +static struct kobj_attribute transition_kobj_attr = __ATTR_RO(transition);
>  static struct attribute *klp_patch_attrs[] = {
>  	&enabled_kobj_attr.attr,
> +	&transition_kobj_attr.attr,
>  	NULL
>  };
>  
> @@ -544,6 +581,7 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
>  
>  	INIT_LIST_HEAD(&func->stack_node);
>  	func->patched = false;
> +	func->transition = false;
>  
>  	/* The format for the sysfs directory is <function,sympos> where sympos
>  	 * is the nth occurrence of this symbol in kallsyms for the patched
> @@ -740,6 +778,16 @@ int klp_register_patch(struct klp_patch *patch)
>  		return -ENODEV;
>  
>  	/*
> +	 * Architectures without reliable stack traces have to set
> +	 * patch->immediate because there's currently no way to patch kthreads
> +	 * with the consistency model.
> +	 */
> +	if (!klp_have_reliable_stack() && !patch->immediate) {
> +		pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> +		return -ENOSYS;
> +	}
> +
> +	/*
>  	 * A reference is taken on the patch module to prevent it from being
>  	 * unloaded.  Right now, we don't allow patch modules to unload since
>  	 * there is currently no method to determine if a thread is still
> @@ -788,7 +836,11 @@ int klp_module_coming(struct module *mod)
>  				goto err;
>  			}
>  
> -			if (!patch->enabled)
> +			/*
> +			 * Only patch the module if the patch is enabled or is
> +			 * in transition.
> +			 */
> +			if (!patch->enabled && patch != klp_transition_patch)

We need the same change also in klp_module_going().


>  				break;
>  
>  			pr_notice("applying patch '%s' to loading module '%s'\n",
> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> index 5efa262..1a77f05 100644
> --- a/kernel/livepatch/patch.c
> +++ b/kernel/livepatch/patch.c
> @@ -29,6 +29,7 @@
>  #include <linux/bug.h>
>  #include <linux/printk.h>
>  #include "patch.h"
> +#include "transition.h"
>  
>  static LIST_HEAD(klp_ops);
>  
> @@ -54,15 +55,58 @@ static void notrace klp_ftrace_handler(unsigned long ip,
>  {
>  	struct klp_ops *ops;
>  	struct klp_func *func;
> +	int patch_state;
>  
>  	ops = container_of(fops, struct klp_ops, fops);
>  
>  	rcu_read_lock();
> +
>  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
>  				      stack_node);
> +
> +	/*
> +	 * func should never be NULL because preemption should be disabled here
> +	 * and unregister_ftrace_function() does the equivalent of a
> +	 * synchronize_sched() before the func_stack removal.
> +	 */
> +	if (WARN_ON_ONCE(!func))
> +		goto unlock;
> +
> +	/*
> +	 * Enforce the order of the ops->func_stack and func->transition reads.
> +	 * The corresponding write barrier is in __klp_enable_patch().
> +	 */
> +	smp_rmb();

I was curious why the comment did not mention __klp_disable_patch().
It was related to the hours of thinking. I would like to avoid this
in the future and add a comment like.

	 * This barrier probably is not needed when the patch is being
	 * disabled. The patch is removed from the stack in
	 * klp_try_complete_transition() and there we need to call
	 * rcu_synchronize() to prevent seeing the patch on the stack
	 * at all.
	 *
	 * Well, it still might be needed to see func->transition
	 * when the patch is removed and the task is migrated. See
	 * the write barrier in __klp_disable_patch().


> +	if (unlikely(func->transition)) {
> +
> +		/*
> +		 * Enforce the order of the func->transition and
> +		 * current->patch_state reads.  Otherwise we could read an
> +		 * out-of-date task state and pick the wrong function.  The
> +		 * corresponding write barriers are in klp_init_transition()
> +		 * and __klp_disable_patch().
> +		 */
> +		smp_rmb();

IMHO, the corresponding barrier is in klp_init_transition().

The barrier in __klp_disable_patch() is questionable. Anyway,
it has a different purpose.


> +		patch_state = current->patch_state;
> +
> +		WARN_ON_ONCE(patch_state == KLP_UNDEFINED);
> +
> +		if (patch_state == KLP_UNPATCHED) {
> +			/*
> +			 * Use the previously patched version of the function.
> +			 * If no previous patches exist, continue with the
> +			 * original function.
> +			 */
> +			func = list_entry_rcu(func->stack_node.next,
> +					      struct klp_func, stack_node);
> +
> +			if (&func->stack_node == &ops->func_stack)
> +				goto unlock;
> +		}
> +	}
> +
>  	klp_arch_set_pc(regs, (unsigned long)func->new_func);
>  unlock:
>  	rcu_read_unlock();
> @@ -211,3 +255,12 @@ int klp_patch_object(struct klp_object *obj)
>  
>  	return 0;
>  }
> +
> +void klp_unpatch_objects(struct klp_patch *patch)
> +{
> +	struct klp_object *obj;
> +
> +	klp_for_each_object(patch, obj)
> +		if (obj->patched)
> +			klp_unpatch_object(obj);
> +}
> diff --git a/kernel/livepatch/patch.h b/kernel/livepatch/patch.h
> index 2d0cce0..0db2271 100644
> --- a/kernel/livepatch/patch.h
> +++ b/kernel/livepatch/patch.h
> @@ -28,5 +28,6 @@ struct klp_ops *klp_find_ops(unsigned long old_addr);
>  
>  int klp_patch_object(struct klp_object *obj);
>  void klp_unpatch_object(struct klp_object *obj);
> +void klp_unpatch_objects(struct klp_patch *patch);
>  
>  #endif /* _LIVEPATCH_PATCH_H */
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> new file mode 100644
> index 0000000..2b87ff9
> --- /dev/null
> +++ b/kernel/livepatch/transition.c
> @@ -0,0 +1,525 @@
> +/*
> + * transition.c - Kernel Live Patching transition functions
> + *
> + * Copyright (C) 2015-2016 Josh Poimboeuf <jpoimboe@redhat.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpu.h>
> +#include <linux/stacktrace.h>
> +#include "patch.h"
> +#include "transition.h"
> +#include "../sched/sched.h"
> +
> +#define MAX_STACK_ENTRIES  100
> +#define STACK_ERR_BUF_SIZE 128
> +
> +extern struct mutex klp_mutex;
> +
> +struct klp_patch *klp_transition_patch;
> +
> +static int klp_target_state = KLP_UNDEFINED;
> +
> +/*
> + * This work can be performed periodically to finish patching or unpatching any
> + * "straggler" tasks which failed to transition in the first attempt.
> + */
> +static void klp_try_complete_transition(void);
> +static void klp_transition_work_fn(struct work_struct *work)
> +{
> +	mutex_lock(&klp_mutex);
> +
> +	if (klp_transition_patch)
> +		klp_try_complete_transition();
> +
> +	mutex_unlock(&klp_mutex);
> +}
> +static DECLARE_DELAYED_WORK(klp_transition_work, klp_transition_work_fn);
> +
> +/*
> + * The transition to the target patch state is complete.  Clean up the data
> + * structures.
> + */
> +void klp_complete_transition(void)
> +{
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +	struct task_struct *g, *task;
> +	unsigned int cpu;
> +
> +	if (klp_transition_patch->immediate)
> +		goto done;
> +
> +	klp_for_each_object(klp_transition_patch, obj)
> +		klp_for_each_func(obj, func)
> +			func->transition = false;
> +
> +	/* Prevent klp_ftrace_handler() from seeing KLP_UNDEFINED state */
> +	if (klp_target_state == KLP_PATCHED)
> +		synchronize_rcu();

I forgot why this is done only when the patch is beeing enabled.
It is because klp_unpatch_objects() and rcu_synchronize() is called
in klp_try_complete_transition() when klp_target_state ==
KLP_UNPATCHED.

I would suggest to move the code below the "success" label from
klp_try_complete_transtion() to klp_complete_transition().
It will get the two related things close to each other.
Also it would fix the missing rcu_synchronize() in
the error path in __klp_enable_patch(), see above.


> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task) {
> +		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
> +		task->patch_state = KLP_UNDEFINED;
> +	}
> +	read_unlock(&tasklist_lock);
> +
> +	for_each_possible_cpu(cpu) {
> +		task = idle_task(cpu);
> +		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
> +		task->patch_state = KLP_UNDEFINED;
> +	}
> +
> +done:
> +	klp_target_state = KLP_UNDEFINED;
> +	klp_transition_patch = NULL;
> +}
> +
> +/*
> + * Switch the patched state of the task to the set of functions in the target
> + * patch state.
> + *
> + * NOTE: If task is not 'current', the caller must ensure the task is inactive.
> + * Otherwise klp_ftrace_handler() might read the wrong 'patch_state' value.
> + */
> +void klp_update_patch_state(struct task_struct *task)
> +{
> +	rcu_read_lock();
> +
> +	/*
> +	 * This test_and_clear_tsk_thread_flag() call also serves as a read
> +	 * barrier to enforce the order of the TIF_PATCH_PENDING and
> +	 * klp_target_state reads.  The corresponding write barrier is in
> +	 * __klp_disable_patch().

The corresponding barrier is in klp_init_transition(), see below.

In each case, we need the corresponding write barrier in both enable
and disable paths. They both set klp_target_state and
TIF_PATCH_PENDING. The write barrier in klp_init_transition() perfectly
fits the purpose.


> +	 */
> +	if (test_and_clear_tsk_thread_flag(task, TIF_PATCH_PENDING))
> +		task->patch_state = READ_ONCE(klp_target_state);
> +
> +	rcu_read_unlock();
> +}
> +
> +/*
> + * Determine whether the given stack trace includes any references to a
> + * to-be-patched or to-be-unpatched function.
> + */
> +static int klp_check_stack_func(struct klp_func *func,
> +				struct stack_trace *trace)
> +{
> +	unsigned long func_addr, func_size, address;
> +	struct klp_ops *ops;
> +	int i;
> +
> +	if (func->immediate)
> +		return 0;
> +
> +	for (i = 0; i < trace->nr_entries; i++) {
> +		address = trace->entries[i];
> +
> +		if (klp_target_state == KLP_UNPATCHED) {
> +			 /*
> +			  * Check for the to-be-unpatched function
> +			  * (the func itself).
> +			  */
> +			func_addr = (unsigned long)func->new_func;
> +			func_size = func->new_size;
> +		} else {
> +			/*
> +			 * Check for the to-be-patched function
> +			 * (the previous func).
> +			 */
> +			ops = klp_find_ops(func->old_addr);
> +
> +			if (list_is_singular(&ops->func_stack)) {
> +				/* original function */
> +				func_addr = func->old_addr;
> +				func_size = func->old_size;
> +			} else {
> +				/* previously patched function */
> +				struct klp_func *prev;
> +
> +				prev = list_next_entry(func, stack_node);
> +				func_addr = (unsigned long)prev->new_func;
> +				func_size = prev->new_size;
> +			}
> +		}
> +
> +		if (address >= func_addr && address < func_addr + func_size)
> +			return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Determine whether it's safe to transition the task to the target patch state
> + * by looking for any to-be-patched or to-be-unpatched functions on its stack.
> + */
> +static int klp_check_stack(struct task_struct *task, char *err_buf)
> +{
> +	static unsigned long entries[MAX_STACK_ENTRIES];
> +	struct stack_trace trace;
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +	int ret;
> +
> +	trace.skip = 0;
> +	trace.nr_entries = 0;
> +	trace.max_entries = MAX_STACK_ENTRIES;
> +	trace.entries = entries;
> +	ret = save_stack_trace_tsk_reliable(task, &trace);
> +	WARN_ON_ONCE(ret == -ENOSYS);
> +	if (ret) {
> +		snprintf(err_buf, STACK_ERR_BUF_SIZE,
> +			 "%s: %s:%d has an unreliable stack\n",
> +			 __func__, task->comm, task->pid);
> +		return ret;
> +	}
> +
> +	klp_for_each_object(klp_transition_patch, obj) {
> +		if (!obj->patched)
> +			continue;
> +		klp_for_each_func(obj, func) {
> +			ret = klp_check_stack_func(func, &trace);
> +			if (ret) {
> +				snprintf(err_buf, STACK_ERR_BUF_SIZE,
> +					 "%s: %s:%d is sleeping on function %s\n",
> +					 __func__, task->comm, task->pid,
> +					 func->old_name);
> +				return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Try to safely switch a task to the target patch state.  If it's currently
> + * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
> + * if the stack is unreliable, return false.
> + */
> +static bool klp_try_switch_task(struct task_struct *task)
> +{
> +	struct rq *rq;
> +	struct rq_flags flags;
> +	int ret;
> +	bool success = false;
> +	char err_buf[STACK_ERR_BUF_SIZE];
> +
> +	err_buf[0] = '\0';
> +
> +	/* check if this task has already switched over */
> +	if (task->patch_state == klp_target_state)
> +		return true;
> +
> +	/*
> +	 * For arches which don't have reliable stack traces, we have to rely
> +	 * on other methods (e.g., switching tasks at kernel exit).
> +	 */
> +	if (!klp_have_reliable_stack())
> +		return false;
> +
> +	/*
> +	 * Now try to check the stack for any to-be-patched or to-be-unpatched
> +	 * functions.  If all goes well, switch the task to the target patch
> +	 * state.
> +	 */
> +	rq = task_rq_lock(task, &flags);
> +
> +	if (task_running(rq, task) && task != current) {
> +		snprintf(err_buf, STACK_ERR_BUF_SIZE,
> +			 "%s: %s:%d is running\n", __func__, task->comm,
> +			 task->pid);
> +		goto done;
> +	}
> +
> +	ret = klp_check_stack(task, err_buf);
> +	if (ret)
> +		goto done;
> +
> +	success = true;
> +
> +	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	task->patch_state = klp_target_state;
> +
> +done:
> +	task_rq_unlock(rq, task, &flags);
> +
> +	/*
> +	 * Due to console deadlock issues, pr_debug() can't be used while
> +	 * holding the task rq lock.  Instead we have to use a temporary buffer
> +	 * and print the debug message after releasing the lock.
> +	 */
> +	if (err_buf[0] != '\0')
> +		pr_debug("%s", err_buf);
> +
> +	return success;
> +
> +}
> +
> +/*
> + * Try to switch all remaining tasks to the target patch state by walking the
> + * stacks of sleeping tasks and looking for any to-be-patched or
> + * to-be-unpatched functions.  If such functions are found, the task can't be
> + * switched yet.
> + *
> + * If any tasks are still stuck in the initial patch state, schedule a retry.
> + */
> +static void klp_try_complete_transition(void)
> +{
> +	unsigned int cpu;
> +	struct task_struct *g, *task;
> +	bool complete = true;
> +
> +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (klp_transition_patch->immediate)
> +		goto success;
> +
> +	/*
> +	 * Try to switch the tasks to the target patch state by walking their
> +	 * stacks and looking for any to-be-patched or to-be-unpatched
> +	 * functions.  If such functions are found on a stack, or if the stack
> +	 * is deemed unreliable, the task can't be switched yet.
> +	 *
> +	 * Usually this will transition most (or all) of the tasks on a system
> +	 * unless the patch includes changes to a very common function.
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task)
> +		if (!klp_try_switch_task(task))
> +			complete = false;
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Ditto for the idle "swapper" tasks.
> +	 */
> +	get_online_cpus();
> +	for_each_possible_cpu(cpu) {
> +		task = idle_task(cpu);
> +		if (cpu_online(cpu)) {
> +			if (!klp_try_switch_task(task))
> +				complete = false;
> +		} else if (task->patch_state != klp_target_state) {
> +			/* offline idle tasks can be switched immediately */
> +			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +			task->patch_state = klp_target_state;
> +		}
> +	}
> +	put_online_cpus();
> +
> +	/*
> +	 * Some tasks weren't able to be switched over.  Try again later and/or
> +	 * wait for other methods like kernel exit switching.
> +	 */
> +	if (!complete) {
> +		schedule_delayed_work(&klp_transition_work,
> +				      round_jiffies_relative(HZ));
> +		return;
> +	}
> +
> +success:
> +
> +	if (klp_target_state == KLP_UNPATCHED) {
> +		/*
> +		 * All tasks have transitioned to KLP_UNPATCHED so we can now
> +		 * remove the new functions from the func_stack.
> +		 */
> +		klp_unpatch_objects(klp_transition_patch);
> +
> +		/*
> +		 * Make sure klp_ftrace_handler() sees that the functions have
> +		 * been removed from ops->func_stack before we clear
> +		 * func->transition.  Otherwise it may pick the wrong
> +		 * transition.
> +		 */

I was a bit confused by the comment. It might be my problem. I just
wonder if might be more clear with somethink like:

		/*
		 * Make sure klp_ftrace_handler() can not longer see functions
		 * from this patch on the stack.  Otherwise it may use
		 * the being-removed function after func->transition is cleared.
		 */

> +		synchronize_rcu();
> +	}
> +
> +	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
> +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> +
> +	/* we're done, now cleanup the data structures */
> +	klp_complete_transition();
> +}
> +
> +/*
> + * Start the transition to the specified target patch state so tasks can begin
> + * switching to it.
> + */
> +void klp_start_transition(void)
> +{
> +	struct task_struct *g, *task;
> +	unsigned int cpu;
> +
> +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> +
> +	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
> +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (klp_transition_patch->immediate)

We should call klp_try_complete_transition() here. Otherwise, it will
never be called and the transition will never get completed.

Alternative solution would be to move klp_try_complete_transition()
from klp_start_transition() and explicitely call it from
__klp_disable_patch() and klp_enable_patch(). It would actually
solve one issue with klp_revert_patch(), see below.

I kind of like the alternative solution. I hope that it was not
me who suggested to move klp_try_complete_transition() into
klp_start_transtion().

> +		return;
> +
> +	/*
> +	 * Mark all normal tasks as needing a patch state update.  They'll
> +	 * switch either in klp_try_complete_transition() or as they exit the
> +	 * kernel.
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task)
> +		if (task->patch_state != klp_target_state)
> +			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Mark all idle tasks as needing a patch state update.  They'll switch
> +	 * either in klp_try_complete_transition() or at the idle loop switch
> +	 * point.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		task = idle_task(cpu);
> +		if (task->patch_state != klp_target_state)
> +			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	}
> +
> +	klp_try_complete_transition();
> +}
> +
> +/*
> + * Initialize the global target patch state and all tasks to the initial patch
> + * state, and initialize all function transition states to true in preparation
> + * for patching or unpatching.
> + */
> +void klp_init_transition(struct klp_patch *patch, int state)
> +{
> +	struct task_struct *g, *task;
> +	unsigned int cpu;
> +	struct klp_object *obj;
> +	struct klp_func *func;
> +	int initial_state = !state;
> +
> +	WARN_ON_ONCE(klp_target_state != KLP_UNDEFINED);
> +
> +	klp_transition_patch = patch;
> +
> +	/*
> +	 * Set the global target patch state which tasks will switch to.  This
> +	 * has no effect until the TIF_PATCH_PENDING flags get set later.
> +	 */
> +	klp_target_state = state;
> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (patch->immediate)
> +		return;
> +
> +	/*
> +	 * Initialize all tasks to the initial patch state to prepare them for
> +	 * switching to the target state.
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task) {
> +		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
> +		task->patch_state = initial_state;
> +	}
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Ditto for the idle "swapper" tasks.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		task = idle_task(cpu);
> +		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
> +		task->patch_state = initial_state;
> +	}
> +
> +	/*
> +	 * Enforce the order of the task->patch_state initializations and the
> +	 * func->transition updates to ensure that, in the enable path,
> +	 * klp_ftrace_handler() doesn't see a func in transition with a
> +	 * task->patch_state of KLP_UNDEFINED.

It has one more purpose:

	 *
	 * Also enforce the order between klp_target_state and
	 * TIF_PATCH_PENDING. The corresponding read barrier is in
	 * klp_update_patch_state(). 

> +	 */
> +	smp_wmb();
> +
> +	/*
> +	 * Set the func transition states so klp_ftrace_handler() will know to
> +	 * switch to the transition logic.
> +	 *
> +	 * When patching, the funcs aren't yet in the func_stack and will be
> +	 * made visible to the ftrace handler shortly by the calls to
> +	 * klp_patch_object().
> +	 *
> +	 * When unpatching, the funcs are already in the func_stack and so are
> +	 * already visible to the ftrace handler.
> +	 */
> +	klp_for_each_object(patch, obj)
> +		klp_for_each_func(obj, func)
> +			func->transition = true;
> +}
> +
> +/*
> + * This function can be called in the middle of an existing transition to
> + * reverse the direction of the target patch state.  This can be done to
> + * effectively cancel an existing enable or disable operation if there are any
> + * tasks which are stuck in the initial patch state.
> + */
> +void klp_reverse_transition(void)
> +{
> +	unsigned int cpu;
> +	struct task_struct *g, *task;
> +
> +	klp_transition_patch->enabled = !klp_transition_patch->enabled;
> +
> +	klp_target_state = !klp_target_state;
> +
> +	/*
> +	 * Clear all TIF_PATCH_PENDING flags to prevent races caused by
> +	 * klp_update_patch_state() running in parallel with
> +	 * klp_start_transition().
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task)
> +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +	read_unlock(&tasklist_lock);
> +
> +	for_each_possible_cpu(cpu)
> +		clear_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> +
> +	/* Let any remaining calls to klp_update_patch_state() complete */
> +	synchronize_rcu();
> +
> +	klp_start_transition();

Hmm, we should not call klp_try_complete_transition() when
klp_start_transition() is called from here. I can't find a safe
way to cancel klp_transition_work() when we own klp_mutex.
It smells with a possible deadlock.

I suggest to move move klp_try_complete_transition() outside
klp_start_transition() and explicitely call it from
 __klp_disable_patch() and __klp_enabled_patch().
This would fix also the problem with immediate patches, see
klp_start_transition().


> +}
> +
> +/* Called from copy_process() during fork */
> +void klp_copy_process(struct task_struct *child)
> +{
> +	child->patch_state = current->patch_state;
> +
> +	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
> +}
> diff --git a/kernel/livepatch/transition.h b/kernel/livepatch/transition.h
> new file mode 100644
> index 0000000..3ee625f
> --- /dev/null
> +++ b/kernel/livepatch/transition.h
> @@ -0,0 +1,13 @@
> +#ifndef _LIVEPATCH_TRANSITION_H
> +#define _LIVEPATCH_TRANSITION_H
> +
> +#include <linux/livepatch.h>
> +
> +extern struct klp_patch *klp_transition_patch;
> +
> +void klp_init_transition(struct klp_patch *patch, int state);
> +void klp_start_transition(void);
> +void klp_reverse_transition(void);
> +void klp_complete_transition(void);
> +
> +#endif /* _LIVEPATCH_TRANSITION_H */
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 6a4bae0..a8b3f1a 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -9,6 +9,7 @@
>  #include <linux/mm.h>
>  #include <linux/stackprotector.h>
>  #include <linux/suspend.h>
> +#include <linux/livepatch.h>
>  
>  #include <asm/tlb.h>
>  
> @@ -264,6 +265,9 @@ static void do_idle(void)
>  
>  	sched_ttwu_pending();
>  	schedule_preempt_disabled();
> +
> +	if (unlikely(klp_patch_pending(current)))
> +		klp_update_patch_state(current);
>  }
>  
>  bool cpu_in_idle(unsigned long pc)
> diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> index e34f871..629e0dc 100644
> --- a/samples/livepatch/livepatch-sample.c
> +++ b/samples/livepatch/livepatch-sample.c
> @@ -17,6 +17,8 @@
>   * along with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/livepatch.h>
> @@ -69,6 +71,21 @@ static int livepatch_init(void)
>  {
>  	int ret;
>  
> +	if (!klp_have_reliable_stack() && !patch.immediate) {
> +		/*
> +		 * WARNING: Be very careful when using 'patch.immediate' in
> +		 * your patches.  It's ok to use it for simple patches like
> +		 * this, but for more complex patches which change function
> +		 * semantics, locking semantics, or data structures, it may not
> +		 * be safe.  Use of this option will also prevent removal of
> +		 * the patch.
> +		 *
> +		 * See Documentation/livepatch/livepatch.txt for more details.
> +		 */
> +		patch.immediate = true;
> +		pr_notice("The consistency model isn't supported for your architecture.  Bypassing safety mechanisms and applying the patch immediately.\n");
> +	}
> +
>  	ret = klp_register_patch(&patch);
>  	if (ret)
>  		return ret;

I am sorry that the review took me so long. I was interrupted several
times by other tasks. The logic is very complex. I wanted to
make sure that my comments are consistent and make sense.

Anyway, I think that we are getting close.

Best Regards,
Petr
