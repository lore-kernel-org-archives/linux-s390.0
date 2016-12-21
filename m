Return-Path: <jpoimboe@redhat.com>
Date: Wed, 21 Dec 2016 15:25:05 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20161221212505.dbxeddu2skmjmwiq@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161220173246.GC25166@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Dec 20, 2016 at 06:32:46PM +0100, Petr Mladek wrote:
> On Thu 2016-12-08 12:08:38, Josh Poimboeuf wrote:
> > Change livepatch to use a basic per-task consistency model.  This is the
> > foundation which will eventually enable us to patch those ~10% of
> > security patches which change function or data semantics.  This is the
> > biggest remaining piece needed to make livepatch more generally useful.
> > 
> > [1] https://lkml.kernel.org/r/20141107140458.GA21774@suse.cz
> > 
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> > diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> > index 6c43f6e..f87e742 100644
> > --- a/Documentation/livepatch/livepatch.txt
> > +++ b/Documentation/livepatch/livepatch.txt
> 
> I like the description.
> 
> Just a note that we will also need to review the section about
> limitations. But I am not sure that we want to do it in this patch.
> It might open a long discussion on its own.
> 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index 1a5a93c..8e06fe5 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -28,18 +28,40 @@
> >  
> >  #include <asm/livepatch.h>
> >  
> > +/* task patch states */
> > +#define KLP_UNDEFINED	-1
> > +#define KLP_UNPATCHED	 0
> > +#define KLP_PATCHED	 1
> > +
> >  /**
> >   * struct klp_func - function structure for live patching
> >   * @old_name:	name of the function to be patched
> >   * @new_func:	pointer to the patched function code
> >   * @old_sympos: a hint indicating which symbol position the old function
> >   *		can be found (optional)
> > + * @immediate:  patch the func immediately, bypassing backtrace safety checks
> 
> There are more checks possible. I would use the same description
> as for klp_object.

Agreed.

> >   * @old_addr:	the address of the function being patched
> >   * @kobj:	kobject for sysfs resources
> >   * @stack_node:	list node for klp_ops func_stack list
> >   * @old_size:	size of the old function
> >   * @new_size:	size of the new function
> >   * @patched:	the func has been added to the klp_ops list
> > + * @transition:	the func is currently being applied or reverted
> > + *
> > @@ -86,6 +110,7 @@ struct klp_object {
> >   * struct klp_patch - patch structure for live patching
> >   * @mod:	reference to the live patch module
> >   * @objs:	object entries for kernel objects to be patched
> > + * @immediate:  patch all funcs immediately, bypassing safety mechanisms
> >   * @list:	list node for global list of registered patches
> >   * @kobj:	kobject for sysfs resources
> >   * @enabled:	the patch is enabled (but operation may be incomplete)
> 
> [...]
> 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index fc160c6..22c0c01 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -424,7 +477,10 @@ static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
> >  		goto err;
> >  	}
> >  
> > -	if (enabled) {
> > +	if (patch == klp_transition_patch) {
> > +		klp_reverse_transition();
> > +		mod_delayed_work(system_wq, &klp_transition_work, 0);
> 
> I would put this mod_delayed_work() into klp_reverse_transition().
> Also I would put that schedule_delayed_work() into
> klp_try_complete_transition().
> 
> If I did not miss anything, it will allow to move the
> klp_transition_work code to transition.c where it logically
> belongs.

Makes sense, I'll see if I can move all the klp_transition_work code to
transition.c.

> > +	} else if (enabled) {
> >  		ret = __klp_enable_patch(patch);
> >  		if (ret)
> >  			goto err;
> 
> [...]
> 
> > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > index 5efa262..e79ebb5 100644
> > --- a/kernel/livepatch/patch.c
> > +++ b/kernel/livepatch/patch.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/bug.h>
> >  #include <linux/printk.h>
> >  #include "patch.h"
> > +#include "transition.h"
> >  
> >  static LIST_HEAD(klp_ops);
> >  
> > @@ -54,15 +55,53 @@ static void notrace klp_ftrace_handler(unsigned long ip,
> >  {
> >  	struct klp_ops *ops;
> >  	struct klp_func *func;
> > +	int patch_state;
> >  
> >  	ops = container_of(fops, struct klp_ops, fops);
> >  
> >  	rcu_read_lock();
> > +
> >  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
> >  				      stack_node);
> > -	if (WARN_ON_ONCE(!func))
> > +
> > +	if (!func)
> >  		goto unlock;
> 
> Why do you removed the WARN_ON_ONCE(), please?
> 
> We still add the function on the stack before registering
> the ftrace handler. Also we unregister the ftrace handler
> before removing the the last entry from the stack.
> 
> AFAIK, unregister_ftrace_function() calls rcu_synchronize()'
> to make sure that no-one is inside the handler once finished.
> Mirek knows more about it.

Hm, this is news to me.  Mirek, please share :-)

> If this is not true, we have a problem. For example,
> we call kfree(ops) after unregister_ftrace_function();

Agreed.

> BTW: I thought that this change was really needed because of
> klp_try_complete_transition(). But I think that the WARN
> could and should stay after all. See below.
> 
> 
> > +	/*
> > +	 * Enforce the order of the ops->func_stack and func->transition reads.
> > +	 * The corresponding write barrier is in __klp_enable_patch().
> > +	 */
> > +	smp_rmb();
> > +
> > +	if (unlikely(func->transition)) {
> > +
> > +		/*
> > +		 * Enforce the order of the func->transition and
> > +		 * current->patch_state reads.  Otherwise we could read an
> > +		 * out-of-date task state and pick the wrong function.  The
> > +		 * corresponding write barriers are in klp_init_transition()
> > +		 * and __klp_disable_patch().
> > +		 */
> > +		smp_rmb();
> > +
> > +		patch_state = current->patch_state;
> > +
> > +		WARN_ON_ONCE(patch_state == KLP_UNDEFINED);
> > +
> > +		if (patch_state == KLP_UNPATCHED) {
> > +			/*
> > +			 * Use the previously patched version of the function.
> > +			 * If no previous patches exist, use the original
> > +			 * function.
> 
> s/use the original/continue with the original/  ?

Ok.

> > +			 */
> > +			func = list_entry_rcu(func->stack_node.next,
> > +					      struct klp_func, stack_node);
> > +
> > +			if (&func->stack_node == &ops->func_stack)
> > +				goto unlock;
> > +		}
> > +	}
> > +
> >  	klp_arch_set_pc(regs, (unsigned long)func->new_func);
> >  unlock:
> >  	rcu_read_unlock();
> > @@ -211,3 +250,12 @@ int klp_patch_object(struct klp_object *obj)
> >  
> >  	return 0;
> >  }
> > +
> > +void klp_unpatch_objects(struct klp_patch *patch)
> > +{
> > +	struct klp_object *obj;
> > +
> > +	klp_for_each_object(patch, obj)
> > +		if (obj->patched)
> > +			klp_unpatch_object(obj);
> > +}
> > --- /dev/null
> > +++ b/kernel/livepatch/transition.c
> > @@ -0,0 +1,479 @@
> > +/*
> > + * transition.c - Kernel Live Patching transition functions
> > + *
> > + * Copyright (C) 2015-2016 Josh Poimboeuf <jpoimboe@redhat.com>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * as published by the Free Software Foundation; either version 2
> > + * of the License, or (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/stacktrace.h>
> > +#include "patch.h"
> > +#include "transition.h"
> > +#include "../sched/sched.h"
> 
> Is this acceptable for the scheduler guys? 

I discussed the use of task_rq_lock() with Peter Zijlstra on IRC and he
seemed to think it was ok.  Peter, please speak up if you disagree :-)

> > +#define MAX_STACK_ENTRIES 100
> > +
> > +struct klp_patch *klp_transition_patch;
> > +
> > +static int klp_target_state = KLP_UNDEFINED;
> > +
> > +/* called from copy_process() during fork */
> > +void klp_copy_process(struct task_struct *child)
> > +{
> > +	child->patch_state = current->patch_state;
> > +
> > +	/* TIF_PATCH_PENDING gets copied in setup_thread_stack() */
> > +}
> > +
> > +/*
> > + * klp_update_patch_state() - change the patched state of a task
> > + * @task:	The task to change
> > + *
> > + * Switches the patched state of the task to the set of functions in the target
> > + * patch state.
> > + */
> 
> Please, add here some warning. Something like:
> 
>  * This function must never be called in parallel with
>  * klp_ftrace_handler(). Otherwise, the handler might do random
>  * decisions and break the consistency.
>  *
>  * By other words, call this function only by the @task itself
>  * or make sure that it is not running.

Yeah, I'll add a comment here.  This goes back to our discussion from
last time:

  https://lkml.kernel.org/r/20160504172517.tdatoj2nlkqwyd4g@treble

> > +void klp_update_patch_state(struct task_struct *task)
> > +{
> > +	/*
> > +	 * The synchronize_rcu() call in klp_try_complete_transition() ensures
> > +	 * this critical section completes before the global patch transition
> > +	 * is considered complete so we don't have spurious patch_state updates
> > +	 * afterwards.
> > +	 */
> > +	rcu_read_lock();
> > +
> > +	/*
> > +	 * This test_and_clear_tsk_thread_flag() call also serves as a read
> > +	 * barrier to enforce the order of the TIF_PATCH_PENDING and
> > +	 * klp_target_state reads.  The corresponding write barriers are in
> > +	 * __klp_disable_patch() and klp_reverse_transition().
> > +	 */
> > +	if (test_and_clear_tsk_thread_flag(task, TIF_PATCH_PENDING))
> > +		task->patch_state = READ_ONCE(klp_target_state);
> > +
> > +	rcu_read_unlock();
> > +}
> > +
> > +/*
> > + * Initialize the global target patch state and all tasks to the initial patch
> > + * state, and initialize all function transition states to true in preparation
> > + * for patching or unpatching.
> > + */
> > +void klp_init_transition(struct klp_patch *patch, int state)
> > +{
> > +	struct task_struct *g, *task;
> > +	unsigned int cpu;
> > +	struct klp_object *obj;
> > +	struct klp_func *func;
> > +	int initial_state = !state;
> > +
> > +	WARN_ON_ONCE(klp_target_state != KLP_UNDEFINED);
> > +
> > +	klp_transition_patch = patch;
> > +
> > +	/*
> > +	 * Set the global target patch state which tasks will switch to.  This
> > +	 * has no effect until the TIF_PATCH_PENDING flags get set later.
> > +	 */
> > +	klp_target_state = state;
> > +
> > +	/*
> > +	 * If the patch can be applied or reverted immediately, skip the
> > +	 * per-task transitions.
> > +	 */
> > +	if (patch->immediate)
> > +		return;
> > +
> > +	/*
> > +	 * Initialize all tasks to the initial patch state to prepare them for
> > +	 * switching to the target state.
> > +	 */
> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, task) {
> > +		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
> > +		task->patch_state = initial_state;
> > +	}
> > +	read_unlock(&tasklist_lock);
> > +
> > +	/*
> > +	 * Ditto for the idle "swapper" tasks.
> > +	 */
> > +	get_online_cpus();
> > +	for_each_online_cpu(cpu) {
> > +		task = idle_task(cpu);
> > +		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
> > +		task->patch_state = initial_state;
> > +	}
> > +	put_online_cpus();
> 
> We allow to add/remove CPUs here. I am afraid that we will also need
> to add a cpu coming/going handler that will set the task->patch_state
> the right way. We must not set the klp_target_state until all ftrace
> handlers are ready.

What if we instead just change the above to use for_each_possible_cpu()?
We could do the same in klp_complete_transition().

> > +	/*
> > +	 * Enforce the order of the task->patch_state initializations and the
> > +	 * func->transition updates to ensure that, in the enable path,
> > +	 * klp_ftrace_handler() doesn't see a func in transition with a
> > +	 * task->patch_state of KLP_UNDEFINED.
> > +	 */
> > +	smp_wmb();
> > +
> > +	/*
> > +	 * Set the func transition states so klp_ftrace_handler() will know to
> > +	 * switch to the transition logic.
> > +	 *
> > +	 * When patching, the funcs aren't yet in the func_stack and will be
> > +	 * made visible to the ftrace handler shortly by the calls to
> > +	 * klp_patch_object().
> > +	 *
> > +	 * When unpatching, the funcs are already in the func_stack and so are
> > +	 * already visible to the ftrace handler.
> > +	 */
> > +	klp_for_each_object(patch, obj)
> > +		klp_for_each_func(obj, func)
> > +			func->transition = true;
> > +}
> > +
> > +/*
> > + * Start the transition to the specified target patch state so tasks can begin
> > + * switching to it.
> > + */
> > +void klp_start_transition(void)
> > +{
> > +	struct task_struct *g, *task;
> > +	unsigned int cpu;
> > +
> > +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> > +
> > +	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
> > +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> > +
> > +	/*
> > +	 * If the patch can be applied or reverted immediately, skip the
> > +	 * per-task transitions.
> > +	 */
> > +	if (klp_transition_patch->immediate)
> > +		return;
> > +
> > +	/*
> > +	 * Mark all normal tasks as needing a patch state update.  As they pass
> > +	 * through the syscall barrier they'll switch over to the target state
> > +	 * (unless we switch them in klp_try_complete_transition() first).
> > +	 */
> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, task)
> > +		set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> 
> This is called also from klp_reverse_transition(). We should set it
> only when the task need migration. Also we should clear it when
> the task is in the right state already.
> 
> It is not only optimization. It actually solves a race between
> klp_complete_transition() and klp_update_patch_state(), see below.

I agree about the race, but if I did:

	for_each_process_thread(g, task) {
		if (task->patch_state != klp_target_state)
			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
		else
			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
	}

It would still leave a small window where TIF_PATCH_PENDING gets set for
an already patched task, if klp_update_patch_state() is running at the
same time.

See below for another solution.

> > +	read_unlock(&tasklist_lock);
> > +
> > +	/*
> > +	 * Ditto for the idle "swapper" tasks, though they never cross the
> > +	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
> > +	 */
> > +	get_online_cpus();
> > +	for_each_online_cpu(cpu)
> > +		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > +	put_online_cpus();
> 
> Also this stage need to be somehow handled by CPU coming/going
> handlers.

Here I think we could automatically switch any offline CPUs' idle tasks.
And something similar in klp_try_complete_transition().

> > +}
> > +
> > +/*
> > + * The transition to the target patch state is complete.  Clean up the data
> > + * structures.
> > + */
> > +void klp_complete_transition(void)
> > +{
> > +	struct klp_object *obj;
> > +	struct klp_func *func;
> > +	struct task_struct *g, *task;
> > +	unsigned int cpu;
> > +
> > +	if (klp_transition_patch->immediate)
> > +		goto done;
> > +
> > +	klp_for_each_object(klp_transition_patch, obj)
> > +		klp_for_each_func(obj, func)
> > +			func->transition = false;
> 
> We should call rcu_synchronize() here. Otherwise, there
> might be a race, see below:
> 
> CPU1					CPU2
> 
> klp_ftrace_handler()
>   if (unlikely(func->transition))
> 	// still true
> 
> 					klp_complete_transition()
> 					  func->transition = false;
> 					  task->patch_state =
> 					      KLP_UNDEFINED;
> 
>      patch_state = current->patch_state;
> 
>      WARN_ON(patch_state == KLP_UNDEFINED);
> 
> BANG!: We print the warning.

This shouldn't be possible because klp_try_complete_transition() calls
rcu_synchronize() before calling klp_complete_transition().  So by the
time klp_complete_transition() is called, the ftrace handler can no
longer see the affected func.  See the comment for rcu_synchronize() in
klp_try_complete_transition().

> Note that that smp_wmb() is enough in klp_init_transition()
> but it is not enough here. We need to wait longer once
> someone might be inside the if (true) code.
> 
> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, task) {
> > +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > +		task->patch_state = KLP_UNDEFINED;
> > +	}
> > +	read_unlock(&tasklist_lock);
> > +
> > +	get_online_cpus();
> > +	for_each_online_cpu(cpu) {
> > +		task = idle_task(cpu);
> > +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> 
> If TIF_PATCH_PENDING flag is set here it means that
> klp_update_patch_state() might get triggered and it might
> put wrong value into task->patch_state.
> 
> We must make sure that all task have this cleared before
> calling this function. This is another reason why
> klp_init_transition() should set the flag only when
> transition is needed.
> 
> We should only check the state here.
> 
> It still might make sense to clear it when it is set wrongly.
> But the question is if it is really safe to continue. I am
> afraid that it is not. It would mean that the consistency
> model is broken and we are in strange state.

As I mentioned above, with your proposal I think there could still be a
task with a spurious set TIF_PATCH_PENDING at this point.

Maybe instead we should clear all the TIF_PATCH_PENDING flags before the
synchronize_rcu() in klp_try_complete_transition().

> > +		task->patch_state = KLP_UNDEFINED;
> > +	}
> > +	put_online_cpus();
> > +
> > +done:
> > +	klp_target_state = KLP_UNDEFINED;
> > +	klp_transition_patch = NULL;
> > +}
> 
> [...]
> 
> > +
> > +/*
> > + * Try to switch all remaining tasks to the target patch state by walking the
> > + * stacks of sleeping tasks and looking for any to-be-patched or
> > + * to-be-unpatched functions.  If such functions are found, the task can't be
> > + * switched yet.
> > + *
> > + * If any tasks are still stuck in the initial patch state, schedule a retry.
> > + */
> > +bool klp_try_complete_transition(void)
> > +{
> > +	unsigned int cpu;
> > +	struct task_struct *g, *task;
> > +	bool complete = true;
> > +
> > +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> > +
> > +	/*
> > +	 * If the patch can be applied or reverted immediately, skip the
> > +	 * per-task transitions.
> > +	 */
> > +	if (klp_transition_patch->immediate)
> > +		goto success;
> > +
> > +	/*
> > +	 * Try to switch the tasks to the target patch state by walking their
> > +	 * stacks and looking for any to-be-patched or to-be-unpatched
> > +	 * functions.  If such functions are found on a stack, or if the stack
> > +	 * is deemed unreliable, the task can't be switched yet.
> > +	 *
> > +	 * Usually this will transition most (or all) of the tasks on a system
> > +	 * unless the patch includes changes to a very common function.
> > +	 */
> > +	read_lock(&tasklist_lock);
> > +	for_each_process_thread(g, task)
> > +		if (!klp_try_switch_task(task))
> > +			complete = false;
> > +	read_unlock(&tasklist_lock);
> > +
> > +	/*
> > +	 * Ditto for the idle "swapper" tasks.
> > +	 */
> > +	get_online_cpus();
> > +	for_each_online_cpu(cpu)
> > +		if (!klp_try_switch_task(idle_task(cpu)))
> > +			complete = false;
> > +	put_online_cpus();
> > +
> > +	/*
> > +	 * Some tasks weren't able to be switched over.  Try again later and/or
> > +	 * wait for other methods like syscall barrier switching.
> > +	 */
> > +	if (!complete)
> > +		return false;
> > +
> > +success:
> > +
> > +	/*
> > +	 * When unpatching, all tasks have transitioned to KLP_UNPATCHED so we
> > +	 * can now remove the new functions from the func_stack.
> > +	 */
> > +	if (klp_target_state == KLP_UNPATCHED)
> > +		klp_unpatch_objects(klp_transition_patch);
> > +
> > +	/*
> > +	 * Wait for all RCU read-side critical sections to complete.
> > +	 *
> > +	 * This has two purposes:
> > +	 *
> > +	 * 1) Ensure all existing critical sections in klp_update_patch_state()
> > +	 *    complete, so task->patch_state won't be unexpectedly updated
> > +	 *    later.
> 
> We should not be here if anyone still might be in klp_update_patch_state().

Depends on our discussion about conditionally setting TIF_PATCH_PENDING.

> 
> > +	 *
> > +	 * 2) When unpatching, don't allow any existing instances of
> > +	 *    klp_ftrace_handler() to access any obsolete funcs before we reset
> > +	 *    the func transition states to false.  Otherwise the handler may
> > +	 *    see the deleted "new" func, see that it's not in transition, and
> > +	 *    wrongly pick the new version of the function.
> > +	 */
> 
> This makes sense but it too me long time to understand. I wonder if
> this might be better:
> 
> 	/*
> 	 * Make sure that the function is removed from ops->func_stack
> 	 * before we clear func->transition. Otherwise the handler may
> 	 * pick the wrong version.
> 	 */

Sounds good.

> And I would call this only when the patch is being removed
> 
> 	if (klp_target_state = KLP_UNPATCHED)
> 		synchronize_rcu();

Depends on our discussion about conditionally setting TIF_PATCH_PENDING.

> I think that this was the reason to remove WARN_ON_ONCE(!func)
> in klp_ftrace_handler(). But this is not related. If this was
> the last entry in the list, we removed the ftrace_handler
> before removing the last entry. And unregister_ftrace_function()
> calls rcu_synchronize() to prevent calling the handler later.
> 
> 
> > +	synchronize_rcu();
> > +
> > +	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
> > +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> > +
> > +	/* we're done, now cleanup the data structures */
> > +	klp_complete_transition();
> > +
> > +	return true;
> > +}
> > +
> > +/*
> > + * This function can be called in the middle of an existing transition to
> > + * reverse the direction of the target patch state.  This can be done to
> > + * effectively cancel an existing enable or disable operation if there are any
> > + * tasks which are stuck in the initial patch state.
> > + */
> > +void klp_reverse_transition(void)
> > +{
> > +	klp_transition_patch->enabled = !klp_transition_patch->enabled;
> > +
> > +	klp_target_state = !klp_target_state;
> > +
> > +	/*
> > +	 * Enforce the order of the write to klp_target_state above and the
> > +	 * TIF_PATCH_PENDING writes in klp_start_transition() to ensure that
> > +	 * klp_update_patch_state() doesn't set a wrong task->patch_state.
> > +	 */
> > +	smp_wmb();
> 
> I would call rcu_synchronize() here to make sure that
> klp_update_patch_state() calls will not set
> an outdated task->patch_state.
> 
> Note that smp_wmb() is not enough. We do not check TIF_PATCH_PENDING
> in klp_try_switch_task(). There is a tiny race:
> 
> CPU1					CPU2
> 
> klp_update_patch_state()
> 
> 	if (test_and clear(task, TIF)
> 	     READ_ONCE(klp_target_state);
> 
> 					mutex_lock(klp_lock);
> 
> 					klp_reverse_transition()
> 					  klp_target_state =
> 					      !klp_target_state;
> 
> 					  klp_start_transition()
> 
> 					mutex_unlock(klp_lock);
> 
> 					 <switch to another process>
> 
> 					 klp_transition_work_fn()
> 					   mutex_lock(klp_lock);
> 					   klp_try_complete_transition()
> 					     klp_try_switch_task()
> 					       if (task->patch_state ==
> 						   klp_target_state)
> 						  return true;
> 
> 	    task->patch_state = <outdated_value>;
> 
> 	 klp_ftrace_handler()
> 
> BANG: klp_ftrace_handler() will use wrong implementation according
>       to the outdated task->patch_state. At the same time,
>       klp_transition() is not blocked by the task because it thinks
>       that it has a correct state.

Good find!

> > +
> > +	klp_start_transition();
> > +}
> > +
> > diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> > index e34f871..bb61c65 100644
> > --- a/samples/livepatch/livepatch-sample.c
> > +++ b/samples/livepatch/livepatch-sample.c
> > @@ -17,6 +17,8 @@
> >   * along with this program; if not, see <http://www.gnu.org/licenses/>.
> >   */
> >  
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> >  #include <linux/module.h>
> >  #include <linux/kernel.h>
> >  #include <linux/livepatch.h>
> > @@ -69,6 +71,11 @@ static int livepatch_init(void)
> >  {
> >  	int ret;
> >  
> > +	if (!klp_have_reliable_stack() && !patch.immediate) {
> > +		pr_notice("disabling consistency model!\n");
> > +		patch.immediate = true;
> > +	}
> 
> I am scared to have this in the sample module. It makes sense
> to use the consistency model even for immediate patches because
> it allows to remove them. But this must not be used for patches
> that really require the consistency model. We should add
> a big fat warning at least.

I did this so that the sample module would still work for non-x86_64
arches, for which there's currently no way to patch kthreads.

Notice I did add a warning:

  pr_notice("disabling consistency model!\n");

Is the warning not fat enough?

> > +
> >  	ret = klp_register_patch(&patch);
> >  	if (ret)
> >  		return ret;
> 
> I like the patch. All the problems that I found look solvable.
> I think that we are on the right way.

Thank you for the excellent review!

-- 
Josh
