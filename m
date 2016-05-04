Return-Path: <pmladek@suse.com>
Date: Wed, 4 May 2016 14:39:40 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: barriers: was: [RFC PATCH v2 17/18] livepatch: change to a per-task
 consistency model
Message-ID: <20160504123940.GR2749@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> Change livepatch to use a basic per-task consistency model.  This is the
> foundation which will eventually enable us to patch those ~10% of
> security patches which change function or data semantics.  This is the
> biggest remaining piece needed to make livepatch more generally useful.

I spent a lot of time with checking the memory barriers. It seems that
they are basically correct.  Let me use my own words to show how
I understand it. I hope that it will help others with review.

> diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> index 782fbb5..b3b8639 100644
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
> @@ -58,11 +59,42 @@ static void notrace klp_ftrace_handler(unsigned long ip,
>  	ops = container_of(fops, struct klp_ops, fops);
>  
>  	rcu_read_lock();
> +
>  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
>  				      stack_node);
> -	if (WARN_ON_ONCE(!func))
> +
> +	if (!func)
>  		goto unlock;
>  
> +	/*
> +	 * See the comment for the 2nd smp_wmb() in klp_init_transition() for
> +	 * an explanation of why this read barrier is needed.
> +	 */
> +	smp_rmb();

I would prefer to be more explicit, e.g.

	/*
	 * Read the right func->transition when the struct appeared on top of
	 * func_stack.  See klp_init_transition and klp_patch_func().
	 */

Note that this barrier is not really needed when the patch is being
disabled, see below.

> +
> +	if (unlikely(func->transition)) {
> +
> +		/*
> +		 * See the comment for the 1st smp_wmb() in
> +		 * klp_init_transition() for an explanation of why this read
> +		 * barrier is needed.
> +		 */
> +		smp_rmb();

Similar here:

		/*
		 * Read the right initial state when func->transition was
		 * enabled, see klp_init_transition().
		 *
		 * Note that the task must never be migrated to the target
		 * state when being inside this ftrace handler.
		 */

We might want to move the second paragraph on top of the function.
It is a basic and important fact. It actually explains why the first
read barrier is not needed when the patch is being disabled.

There are some more details below. I started to check and comment the
barriers from klp_init_transition().


> +		if (current->patch_state == KLP_UNPATCHED) {
> +			/*
> +			 * Use the previously patched version of the function.
> +			 * If no previous patches exist, use the original
> +			 * function.
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
> diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> new file mode 100644
> index 0000000..92819bb
> --- /dev/null
> +++ b/kernel/livepatch/transition.c
> +/*
> + * klp_patch_task() - change the patched state of a task
> + * @task:	The task to change
> + *
> + * Switches the patched state of the task to the set of functions in the target
> + * patch state.
> + */
> +void klp_patch_task(struct task_struct *task)
> +{
> +	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> +
> +	/*
> +	 * The corresponding write barriers are in klp_init_transition() and
> +	 * klp_reverse_transition().  See the comments there for an explanation.
> +	 */
> +	smp_rmb();

I would prefer to be more explicit, e.g.

	/*
	 * Read the correct klp_target_state when TIF_PATCH_PENDING was set
	 * and this function was called.  See klp_init_transition() and
	 * klp_reverse_transition().
	 */
> +
> +	task->patch_state = klp_target_state;
> +}

The function name confused me few times when klp_target_state
was KLP_UNPATCHED. I suggest to rename it to klp_update_task()
or klp_transit_task().

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
> +	klp_transition_patch = patch;
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
> +	for_each_process_thread(g, task)
> +		task->patch_state = initial_state;
> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Ditto for the idle "swapper" tasks.
> +	 */
> +	get_online_cpus();
> +	for_each_online_cpu(cpu)
> +		idle_task(cpu)->patch_state = initial_state;
> +	put_online_cpus();
> +
> +	/*
> +	 * Ensure klp_ftrace_handler() sees the task->patch_state updates
> +	 * before the func->transition updates.  Otherwise it could read an
> +	 * out-of-date task state and pick the wrong function.
> +	 */
> +	smp_wmb();

This barrier is needed when the patch is being disabled. In this case,
the ftrace handler is already in use and the related struct klp_func
are on top of func_stack. The purpose is well described above.

It is not needed when the patch is being enabled because it is
not visible to the ftrace handler at the moment. The barrier below
is enough.


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
> +
> +	/*
> +	 * Set the global target patch state which tasks will switch to.  This
> +	 * has no effect until the TIF_PATCH_PENDING flags get set later.
> +	 */
> +	klp_target_state = state;
> +
> +	/*
> +	 * For the enable path, ensure klp_ftrace_handler() will see the
> +	 * func->transition updates before the funcs become visible to the
> +	 * handler.  Otherwise the handler may wrongly pick the new func before
> +	 * the task switches to the patched state.

By other words, it makes sure that the ftrace handler will see
the updated func->transition before the ftrace handler is registered
and/or before the struct klp_func is listed in func_stack.


> +	 * For the disable path, the funcs are already visible to the handler.
> +	 * But we still need to ensure the ftrace handler will see the
> +	 * func->transition updates before the tasks start switching to the
> +	 * unpatched state.  Otherwise the handler can miss a task patch state
> +	 * change which would result in it wrongly picking the new function.

If this is true, it would mean that the task might be switched when it
is in the middle of klp_ftrace_handler. It would mean that reading
task->patch_state would be racy against the modification by
klp_patch_task().

Note that before we call klp_patch_task(), the task will stay in the
previous state. We are disabling the patch, so the previous state
is that the patch is enabled. It means that it should always use
the new function before klp_patch_task() is called. It means
that it does not matter if it sees func->transition updated or not.
In both cases, it will use the new function.

Fortunately, task->patch_state might be set to KLP_UNPATCHED
only when it is sleeping or on some other safe location, e.g.
when leaving to userspace. In both cases, the barrier is not needed
here.

By other words, this barrier is not needed to synchronize func_stack
and patch->transition when it is being disabled.


> +	 * This barrier also ensures that if another CPU goes through the
> +	 * syscall barrier, sees the TIF_PATCH_PENDING writes in
> +	 * klp_start_transition(), and calls klp_patch_task(), it also sees the
> +	 * above write to the target state.  Otherwise it can put the task in
> +	 * the wrong universe.
> +	 */

By other words, it makes sure that klp_patch_task() will assign the
right patch_state. Where klp_patch_task() could not be called
before we set TIF_PATCH_PENDING in klp_start_transition().

> +	smp_wmb();
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
> +	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
> +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> +
> +	/*
> +	 * If the patch can be applied or reverted immediately, skip the
> +	 * per-task transitions.
> +	 */
> +	if (klp_transition_patch->immediate)
> +		return;
> +
> +	/*
> +	 * Mark all normal tasks as needing a patch state update.  As they pass
> +	 * through the syscall barrier they'll switch over to the target state
> +	 * (unless we switch them in klp_try_complete_transition() first).
> +	 */
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, task)
> +		set_tsk_thread_flag(task, TIF_PATCH_PENDING);

A bad intuition might suggest that we do not need to set this flag
when klp_start_transition() is called from klp_reverse_transition()
and the task already is in the right state.

But I think that we actually must set TIF_PATCH_PENDING even in this
case to avoid a possible race. We do not know if klp_patch_task()
is not running at the moment with the previous klp_target_state().


> +	read_unlock(&tasklist_lock);
> +
> +	/*
> +	 * Ditto for the idle "swapper" tasks, though they never cross the
> +	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
> +	 */
> +	get_online_cpus();
> +	for_each_online_cpu(cpu)
> +		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> +	put_online_cpus();
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
> +	struct klp_patch *patch = klp_transition_patch;
> +
> +	klp_target_state = !klp_target_state;
> +
> +	/*
> +	 * Ensure that if another CPU goes through the syscall barrier, sees
> +	 * the TIF_PATCH_PENDING writes in klp_start_transition(), and calls
> +	 * klp_patch_task(), it also sees the above write to the target state.
> +	 * Otherwise it can put the task in the wrong universe.
> +	 */
> +	smp_wmb();

Yup, it is the same reason as for the 2nd barrier in klp_init_transition()
regarding klp_target_state and klp_patch_task() that is triggered by
TIF_PATCH_PENDING.

> +
> +	klp_start_transition();
> +	klp_try_complete_transition();
> +
> +	patch->enabled = !patch->enabled;
> +}
> +

Best Regards,
Petr
