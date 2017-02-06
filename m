Return-Path: <pmladek@suse.com>
Date: Mon, 6 Feb 2017 17:44:31 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170206164431.GA2980@pathway.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
 <20170202115116.GB23754@pathway.suse.cz>
 <20170203203916.4dlavmvlewgk3j4l@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170203203916.4dlavmvlewgk3j4l@treble>
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

On Fri 2017-02-03 14:39:16, Josh Poimboeuf wrote:
> On Thu, Feb 02, 2017 at 12:51:16PM +0100, Petr Mladek wrote:
> > !!! This is the right version. I am sorry again for the confusion. !!!
> >
> > >  static int __klp_disable_patch(struct klp_patch *patch)
> > >  {
> > > -	struct klp_object *obj;
> > > +	if (klp_transition_patch)
> > > +		return -EBUSY;
> > >  
> > >  	/* enforce stacking: only the last enabled patch can be disabled */
> > >  	if (!list_is_last(&patch->list, &klp_patches) &&
> > >  	    list_next_entry(patch, list)->enabled)
> > >  		return -EBUSY;
> > >  
> > > -	pr_notice("disabling patch '%s'\n", patch->mod->name);
> > > +	klp_init_transition(patch, KLP_UNPATCHED);
> > >  
> > > -	klp_for_each_object(patch, obj) {
> > > -		if (obj->patched)
> > > -			klp_unpatch_object(obj);
> > > -	}
> > > +	/*
> > > +	 * Enforce the order of the klp_target_state write in
> > > +	 * klp_init_transition() and the TIF_PATCH_PENDING writes in
> > > +	 * klp_start_transition() to ensure that klp_update_patch_state()
> > > +	 * doesn't set a task->patch_state to KLP_UNDEFINED.
> > > +	 */
> > > +	smp_wmb();
> > 
> > The description is not clear. The klp_target_state manipulation
> > is synchronized by another barrier inside klp_init_transition().
> 
> Yeah.  I should also update the barrier comment in klp_init_transition()
> to clarify that it also does this.
> 
> > A similar barrier is in __klp_enable_patch() and it is correctly
> > described there:
> > 
> >    It enforces the order of the func->transition writes in
> >    klp_init_transition() and the ops->func_stack writes in
> >    klp_patch_object(). The corresponding barrier is in
> >    klp_ftrace_handler().
> > 
> > But we do not modify ops->func_stack in __klp_disable_patch().
> > So we need another explanation.
> > 
> > Huh, I spent few hours thinking about it. I am almost sure
> > that it is not needed. But I am not 100% sure. The many times
> > rewriten summary looks like:
> > 
> > 	/*
> > 	 * Enforce the order of func->transtion write in
> > 	 * klp_init_transition() against TIF_PATCH_PENDING writes
> > 	 * in klp_start_transition(). It makes sure that
> > 	 * klp_ftrace_hadler() will see func->transition set
> > 	 * after the task is migrated by klp_update_patch_state().
> > 	 *
> > 	 * The barrier probably is not needed because the task
> > 	 * must not be migrated when being inside klp_ftrace_handler()
> > 	 * and there is another full barrier in
> > 	 * klp_update_patch_state().
> > 	 * But this is slow path and better be safe than sorry.
> > 	 */
> > 	 smp_wmb();
> 
> This mostly makes sense,  but I think the barrier *is* needed for
> ordering func->transition and TIF_PATCH_PENDING writes for the rare case
> where klp_ftrace_handler() is called right after
> klp_update_patch_state(), which could be possible in the idle loop, for
> example.
> 
> CPU0				CPU1
> __klp_disable_patch()
>   klp_init_transition()
>     func->transition = true;
>   (...no barrier...)
>   klp_start_transition()
>     set TIF_PATCH_PENDING
> 
> 				klp_update_patch_state()
> 				  if (test_and_clear(TIF_PATCH_PENDING))
> 				    task->patch_state = KLP_UNPATCHED;
> 				...
> 				klp_ftrace_handler()
> 				  smp_rmb();
> 				  if (unlikely(func->transition)) <--- false (patched)
> 				...
> 				klp_ftrace_handler()
> 				  smp_rmb();
> 				  if (unlikely(func->transition)) <--- true (unpatched)

You are right. I was able to find many scenarios where the barrier
was not needed. But it is needed in this one.

The first paragraph should be enough then:

	/*
	 * Enforce the order of func->transition write in
	 * klp_init_transition() against TIF_PATCH_PENDING writes
	 * in klp_start_transition(). It makes sure that
	 * klp_ftrace_handler() will see func->transition set
	 * after the task is migrated by klp_update_patch_state().
	 */
	 smp_wmb();


> So how about:
> 
> 	/*
> 	 * Enforce the order of the func->transition writes in
> 	 * klp_init_transition() and the TIF_PATCH_PENDING writes in
> 	 * klp_start_transition().  In the rare case where klp_ftrace_handler()
> 	 * is called shortly after klp_update_patch_state() switches the task,
> 	 * this ensures the handler sees func->transition is set.
> 	 */
> 	smp_wmb();

Looks good to me.


> > > +	klp_start_transition();
> > >  	patch->enabled = false;
> > >  
> > >  	return 0;
> > > @@ -337,6 +341,9 @@ static int __klp_enable_patch(struct klp_patch *patch)
> > >  	struct klp_object *obj;
> > >  	int ret;
> > >  
> > > +	if (klp_transition_patch)
> > > +		return -EBUSY;
> > > +
> > >  	if (WARN_ON(patch->enabled))
> > >  		return -EINVAL;
> > >  
> > > @@ -347,22 +354,37 @@ static int __klp_enable_patch(struct klp_patch *patch)
> > >  
> > >  	pr_notice("enabling patch '%s'\n", patch->mod->name);
> > >  
> > > +	klp_init_transition(patch, KLP_PATCHED);
> > > +
> > > +	/*
> > > +	 * Enforce the order of the func->transition writes in
> > > +	 * klp_init_transition() and the ops->func_stack writes in
> > > +	 * klp_patch_object(), so that klp_ftrace_handler() will see the
> > > +	 * func->transition updates before the handler is registered and the
> > > +	 * new funcs become visible to the handler.
> > > +	 */
> > > +	smp_wmb();
> > > +
> > >  	klp_for_each_object(patch, obj) {
> > >  		if (!klp_is_object_loaded(obj))
> > >  			continue;
> > >  
> > >  		ret = klp_patch_object(obj);
> > > -		if (ret)
> > > -			goto unregister;
> > > +		if (ret) {
> > > +			pr_warn("failed to enable patch '%s'\n",
> > > +				patch->mod->name);
> > > +
> > > +			klp_unpatch_objects(patch);
> > 
> > We should call here synchronize_rcu() here as we do
> > in klp_try_complete_transition(). Some of the affected
> > functions might have more versions on the stack and we
> > need to make sure that klp_ftrace_handler() will _not_
> > see the removed patch on the stack.
> 
> Even if the handler sees the new func on the stack, the
> task->patch_state is still KLP_UNPATCHED, so it will still choose the
> previous version of the function.  Or did I miss your point?

The barrier is needed from exactly the same reason as the one
in klp_try_complete_transition()

CPU0					CPU1

__klp_enable_patch()
  klp_init_transition()

    for_each...
      task->patch_state = KLP_UNPATCHED

    for_each...
      func->transition = true

  klp_for_each_object()
    klp_patch_object()
      list_add_rcu()

					klp_ftrace_handler()
					  func = list_first_...()

					  if (func->transition)


    ret = klp_patch_object()
    /* error */
    if (ret) {
      klp_unpatch_objects()

	list_remove_rcu()

      klp_complete_transition()

	for_each_....
	  func->transition = true

	for_each_....
	  task->patch_state = PATCH_UNDEFINED

					    patch_state = current->patch_state;
					    WARN_ON_ONCE(patch_state
							==
							 KLP_UNDEFINED);

BANG: The warning is triggered.

=> we need to call rcu_synchronize(). It will make sure that
no ftrace handled will see the removed func on the stack
and we could clear all the other values.


> > Alternatively, we could move all the code around
> > klp_unpatch_objects() from klp_try_complete_transition()
> > into klp_complete_transition(), see below.
> 
> But klp_target_state is KLP_PATCHED so the synchronize_rcu() at the end
> of klp_try_complete_transition() wouldn't get called anyway.
> 
> > 
> > > +			klp_complete_transition();
> > > +
> > > +			return ret;
> > > +		}
> > >  	}
> > >  
> > > +	klp_start_transition();
> > >  	patch->enabled = true;
> > >  
> > >  	return 0;
> > > -
> > > -unregister:
> > > -	WARN_ON(__klp_disable_patch(patch));
> > > -	return ret;
> > >  }
> > >  
> > >  /**

[...]

> > > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > > index 5efa262..1a77f05 100644
> > > --- a/kernel/livepatch/patch.c
> > > +++ b/kernel/livepatch/patch.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/bug.h>
> > >  #include <linux/printk.h>
> > >  #include "patch.h"
> > > +#include "transition.h"
> > >  
> > >  static LIST_HEAD(klp_ops);
> > >  
> > > @@ -54,15 +55,58 @@ static void notrace klp_ftrace_handler(unsigned long ip,
> > >  {
> > >  	struct klp_ops *ops;
> > >  	struct klp_func *func;
> > > +	int patch_state;
> > >  
> > >  	ops = container_of(fops, struct klp_ops, fops);
> > >  
> > >  	rcu_read_lock();
> > > +
> > >  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
> > >  				      stack_node);
> > > +
> > > +	/*
> > > +	 * func should never be NULL because preemption should be disabled here
> > > +	 * and unregister_ftrace_function() does the equivalent of a
> > > +	 * synchronize_sched() before the func_stack removal.
> > > +	 */
> > > +	if (WARN_ON_ONCE(!func))
> > > +		goto unlock;
> > > +
> > > +	/*
> > > +	 * Enforce the order of the ops->func_stack and func->transition reads.
> > > +	 * The corresponding write barrier is in __klp_enable_patch().
> > > +	 */
> > > +	smp_rmb();
> > 
> > I was curious why the comment did not mention __klp_disable_patch().
> > It was related to the hours of thinking. I would like to avoid this
> > in the future and add a comment like.
> > 
> > 	 * This barrier probably is not needed when the patch is being
> > 	 * disabled. The patch is removed from the stack in
> > 	 * klp_try_complete_transition() and there we need to call
> > 	 * rcu_synchronize() to prevent seeing the patch on the stack
> > 	 * at all.
> > 	 *
> > 	 * Well, it still might be needed to see func->transition
> > 	 * when the patch is removed and the task is migrated. See
> > 	 * the write barrier in __klp_disable_patch().
> 
> Agreed, though as you mentioned earlier, there's also the implicit
> barrier in klp_update_patch_state(), which would execute first in such a
> scenario.  So I think I'll update the barrier comments in
> klp_update_patch_state().

You inspired me to a scenario with 3 CPUs:

CPU0			CPU1			CPU2

__klp_disable_patch()

  klp_init_transition()

    func->transition = true

  smp_wmb()

  klp_start_transition()

    set TIF_PATCH_PATCHPENDING

			klp_update_patch_state()

			  task->patch_state
			     = KLP_UNPATCHED

			  smp_mb()

						klp_ftrace_handler()
						  func = list_...

						  smp_rmb() /*needed?*/

						  if (func->transition)

We need to make sure the CPU3 sees func->transition set. Otherwise,
it would wrongly use the function from the patch.

So, the description might be:

	 * Enforce the order of the ops->func_stack and
	 * func->transition reads when the patch is enabled.
	 * The corresponding write barrier is in __klp_enable_patch().
	 *
	 * Also make sure that func->transition is visible before
	 * TIF_PATCH_PENDING_FLAG is set and the task might get
	 * migrated to KLP_UNPATCHED state. The corresponding
	 * write barrier is in __klp_disable_patch().


By other words, the read barrier here is needed from the same
reason as the write barrier in __klp_disable_patch().


> > > +	if (unlikely(func->transition)) {
> > > +
> > > +		/*
> > > +		 * Enforce the order of the func->transition and
> > > +		 * current->patch_state reads.  Otherwise we could read an
> > > +		 * out-of-date task state and pick the wrong function.  The
> > > +		 * corresponding write barriers are in klp_init_transition()
> > > +		 * and __klp_disable_patch().
> > > +		 */
> > > +		smp_rmb();
> > 
> > IMHO, the corresponding barrier is in klp_init_transition().
> > 
> > The barrier in __klp_disable_patch() is questionable. Anyway,
> > it has a different purpose.
> 
> Agreed.

[...]

> > > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > > new file mode 100644
> > > index 0000000..2b87ff9
> > > --- /dev/null
> > > +++ b/kernel/livepatch/transition.c
> > > @@ -0,0 +1,525 @@
> > > +/*
> > > + * transition.c - Kernel Live Patching transition functions
> > > + *
> > > + * Copyright (C) 2015-2016 Josh Poimboeuf <jpoimboe@redhat.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> > > + * modify it under the terms of the GNU General Public License
> > > + * as published by the Free Software Foundation; either version 2
> > > + * of the License, or (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License
> > > + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/cpu.h>
> > > +#include <linux/stacktrace.h>
> > > +#include "patch.h"
> > > +#include "transition.h"
> > > +#include "../sched/sched.h"
> > > +
> > > +#define MAX_STACK_ENTRIES  100
> > > +#define STACK_ERR_BUF_SIZE 128
> > > +
> > > +extern struct mutex klp_mutex;
> > > +
> > > +struct klp_patch *klp_transition_patch;
> > > +
> > > +static int klp_target_state = KLP_UNDEFINED;
> > > +
> > > +/*
> > > + * This work can be performed periodically to finish patching or unpatching any
> > > + * "straggler" tasks which failed to transition in the first attempt.
> > > + */
> > > +static void klp_try_complete_transition(void);
> > > +static void klp_transition_work_fn(struct work_struct *work)
> > > +{
> > > +	mutex_lock(&klp_mutex);
> > > +
> > > +	if (klp_transition_patch)
> > > +		klp_try_complete_transition();
> > > +
> > > +	mutex_unlock(&klp_mutex);
> > > +}
> > > +static DECLARE_DELAYED_WORK(klp_transition_work, klp_transition_work_fn);
> > > +
> > > +/*
> > > + * The transition to the target patch state is complete.  Clean up the data
> > > + * structures.
> > > + */
> > > +void klp_complete_transition(void)
> > > +{
> > > +	struct klp_object *obj;
> > > +	struct klp_func *func;
> > > +	struct task_struct *g, *task;
> > > +	unsigned int cpu;
> > > +
> > > +	if (klp_transition_patch->immediate)
> > > +		goto done;
> > > +
> > > +	klp_for_each_object(klp_transition_patch, obj)
> > > +		klp_for_each_func(obj, func)
> > > +			func->transition = false;
> > > +
> > > +	/* Prevent klp_ftrace_handler() from seeing KLP_UNDEFINED state */
> > > +	if (klp_target_state == KLP_PATCHED)
> > > +		synchronize_rcu();
> > 
> > I forgot why this is done only when the patch is beeing enabled.
> > It is because klp_unpatch_objects() and rcu_synchronize() is called
> > in klp_try_complete_transition() when klp_target_state ==
> > KLP_UNPATCHED.
> > 
> > I would suggest to move the code below the "success" label from
> > klp_try_complete_transtion() to klp_complete_transition().
> > It will get the two related things close to each other.
> > Also it would fix the missing rcu_synchronize() in
> > the error path in __klp_enable_patch(), see above.
> 
> As I mentioned, I don't see how that will fix the __klp_enable_patch()
> error path, nor can I see why it needs fixing in the first place.

I hope that I have persuaded you :-)


> Regardless, it does seem like a good idea to move the end of
> klp_try_complete_transition() into klp_complete_transition().
> 
> > > +	read_lock(&tasklist_lock);
> > > +	for_each_process_thread(g, task) {
> > > +		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
> > > +		task->patch_state = KLP_UNDEFINED;
> > > +	}
> > > +	read_unlock(&tasklist_lock);
> > > +
> > > +	for_each_possible_cpu(cpu) {
> > > +		task = idle_task(cpu);
> > > +		WARN_ON_ONCE(test_tsk_thread_flag(task, TIF_PATCH_PENDING));
> > > +		task->patch_state = KLP_UNDEFINED;
> > > +	}
> > > +
> > > +done:
> > > +	klp_target_state = KLP_UNDEFINED;
> > > +	klp_transition_patch = NULL;
> > > +}
> > > +
> > > +/*
> > > + * Switch the patched state of the task to the set of functions in the target
> > > + * patch state.
> > > + *
> > > + * NOTE: If task is not 'current', the caller must ensure the task is inactive.
> > > + * Otherwise klp_ftrace_handler() might read the wrong 'patch_state' value.
> > > + */

[...]

> > > +void klp_reverse_transition(void)
> > > +{
> > > +	unsigned int cpu;
> > > +	struct task_struct *g, *task;
> > > +
> > > +	klp_transition_patch->enabled = !klp_transition_patch->enabled;
> > > +
> > > +	klp_target_state = !klp_target_state;
> > > +
> > > +	/*
> > > +	 * Clear all TIF_PATCH_PENDING flags to prevent races caused by
> > > +	 * klp_update_patch_state() running in parallel with
> > > +	 * klp_start_transition().
> > > +	 */
> > > +	read_lock(&tasklist_lock);
> > > +	for_each_process_thread(g, task)
> > > +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > +	read_unlock(&tasklist_lock);
> > > +
> > > +	for_each_possible_cpu(cpu)
> > > +		clear_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > > +
> > > +	/* Let any remaining calls to klp_update_patch_state() complete */
> > > +	synchronize_rcu();
> > > +
> > > +	klp_start_transition();
> > 
> > Hmm, we should not call klp_try_complete_transition() when
> > klp_start_transition() is called from here. I can't find a safe
> > way to cancel klp_transition_work() when we own klp_mutex.
> > It smells with a possible deadlock.
> > 
> > I suggest to move move klp_try_complete_transition() outside
> > klp_start_transition() and explicitely call it from
> >  __klp_disable_patch() and __klp_enabled_patch().
> > This would fix also the problem with immediate patches, see
> > klp_start_transition().
> 
> Agreed.  I'll fix it as you suggest and I'll put the mod_delayed_work()
> call in klp_reverse_transition() again.

There is one small catch. The mod_delayed_work() might cause that two
works might be scheduled:

  + one already running that is waiting for the klp_mutex
  + another one scheduled by that mod_delayed_work()

A solution would be to cancel the work from klp_transition_work_fn()
if the transition succeeds.

Another possibility would be to do nothing here. The work is
scheduled very often anyway.


> 
> Yeah, it does take a while to wrap your head around the code, especially
> with respect to synchronization.

Yes. I am looking forward to get this done. But we are really close, IMHO.

I hope that my today's comments make sense. I am not in a good
condition. I need some rest or so.

Best Regards,
Petr
