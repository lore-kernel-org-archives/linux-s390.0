Return-Path: <pmladek@suse.com>
Date: Wed, 8 Feb 2017 16:47:50 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170208154749.GE2640@linux.suse>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
 <20170202115116.GB23754@pathway.suse.cz>
 <20170203203916.4dlavmvlewgk3j4l@treble>
 <20170206164431.GA2980@pathway.suse.cz>
 <20170206195148.c75y3ru54s425f7k@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170206195148.c75y3ru54s425f7k@treble>
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

On Mon 2017-02-06 13:51:48, Josh Poimboeuf wrote:
> On Mon, Feb 06, 2017 at 05:44:31PM +0100, Petr Mladek wrote:
> > > > > @@ -347,22 +354,37 @@ static int __klp_enable_patch(struct klp_patch *patch)
> > > > >  
> > > > >  	pr_notice("enabling patch '%s'\n", patch->mod->name);
> > > > >  
> > > > > +	klp_init_transition(patch, KLP_PATCHED);
> > > > > +
> > > > > +	/*
> > > > > +	 * Enforce the order of the func->transition writes in
> > > > > +	 * klp_init_transition() and the ops->func_stack writes in
> > > > > +	 * klp_patch_object(), so that klp_ftrace_handler() will see the
> > > > > +	 * func->transition updates before the handler is registered and the
> > > > > +	 * new funcs become visible to the handler.
> > > > > +	 */
> > > > > +	smp_wmb();
> > > > > +
> > > > >  	klp_for_each_object(patch, obj) {
> > > > >  		if (!klp_is_object_loaded(obj))
> > > > >  			continue;
> > > > >  
> > > > >  		ret = klp_patch_object(obj);
> > > > > -		if (ret)
> > > > > -			goto unregister;
> > > > > +		if (ret) {
> > > > > +			pr_warn("failed to enable patch '%s'\n",
> > > > > +				patch->mod->name);
> > > > > +
> > > > > +			klp_unpatch_objects(patch);
> > > > 
> > > > We should call here synchronize_rcu() here as we do
> > > > in klp_try_complete_transition(). Some of the affected
> > > > functions might have more versions on the stack and we
> > > > need to make sure that klp_ftrace_handler() will _not_
> > > > see the removed patch on the stack.
> > > 
> > > Even if the handler sees the new func on the stack, the
> > > task->patch_state is still KLP_UNPATCHED, so it will still choose the
> > > previous version of the function.  Or did I miss your point?
> > 
> > The barrier is needed from exactly the same reason as the one
> > in klp_try_complete_transition()
> > 
> > CPU0					CPU1
> > 
> > __klp_enable_patch()
> >   klp_init_transition()
> > 
> >     for_each...
> >       task->patch_state = KLP_UNPATCHED
> > 
> >     for_each...
> >       func->transition = true
> > 
> >   klp_for_each_object()
> >     klp_patch_object()
> >       list_add_rcu()
> > 
> > 					klp_ftrace_handler()
> > 					  func = list_first_...()
> > 
> > 					  if (func->transition)
> > 
> > 
> >     ret = klp_patch_object()
> >     /* error */
> >     if (ret) {
> >       klp_unpatch_objects()
> > 
> > 	list_remove_rcu()
> > 
> >       klp_complete_transition()
> > 
> > 	for_each_....
> > 	  func->transition = true
> > 
> > 	for_each_....
> > 	  task->patch_state = PATCH_UNDEFINED
> > 
> > 					    patch_state = current->patch_state;
> > 					    WARN_ON_ONCE(patch_state
> > 							==
> > 							 KLP_UNDEFINED);
> > 
> > BANG: The warning is triggered.
> > 
> > => we need to call rcu_synchronize(). It will make sure that
> > no ftrace handled will see the removed func on the stack
> > and we could clear all the other values.
> 
> Makes sense.
> 
> Notice in this case that klp_target_state is KLP_PATCHED.  Which means
> that klp_complete_transition() would not call synchronize_rcu() at the
> right time, nor would it call module_put().  It can be fixed with:
>
> @@ -387,7 +389,7 @@ static int __klp_enable_patch(struct klp_patch *patch)
>  			pr_warn("failed to enable patch '%s'\n",
>  				patch->mod->name);
>  
> -			klp_unpatch_objects(patch);
> +			klp_target_state = KLP_UNPATCHED;
>  			klp_complete_transition();
>  
>  			return ret;

Great catch! Looks good to me.

> This assumes that the 'if (klp_target_state == KLP_UNPATCHED)' clause in
> klp_try_complete_transition() gets moved to klp_complete_transition() as
> you suggested.
> 
> > > > > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > > > > index 5efa262..1a77f05 100644
> > > > > --- a/kernel/livepatch/patch.c
> > > > > +++ b/kernel/livepatch/patch.c
> > > > > @@ -29,6 +29,7 @@
> > > > >  #include <linux/bug.h>
> > > > >  #include <linux/printk.h>
> > > > >  #include "patch.h"
> > > > > +#include "transition.h"
> > > > >  
> > > > >  static LIST_HEAD(klp_ops);
> > > > >  
> > > > > @@ -54,15 +55,58 @@ static void notrace klp_ftrace_handler(unsigned long ip,
> > > > >  {
> > > > >  	struct klp_ops *ops;
> > > > >  	struct klp_func *func;
> > > > > +	int patch_state;
> > > > >  
> > > > >  	ops = container_of(fops, struct klp_ops, fops);
> > > > >  
> > > > >  	rcu_read_lock();
> > > > > +
> > > > >  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
> > > > >  				      stack_node);
> > > > > +
> > > > > +	/*
> > > > > +	 * func should never be NULL because preemption should be disabled here
> > > > > +	 * and unregister_ftrace_function() does the equivalent of a
> > > > > +	 * synchronize_sched() before the func_stack removal.
> > > > > +	 */
> > > > > +	if (WARN_ON_ONCE(!func))
> > > > > +		goto unlock;
> > > > > +
> > > > > +	/*
> > > > > +	 * Enforce the order of the ops->func_stack and func->transition reads.
> > > > > +	 * The corresponding write barrier is in __klp_enable_patch().
> > > > > +	 */
> > > > > +	smp_rmb();
> > > > 
> > > > I was curious why the comment did not mention __klp_disable_patch().
> > > > It was related to the hours of thinking. I would like to avoid this
> > > > in the future and add a comment like.
> > > > 
> > > > 	 * This barrier probably is not needed when the patch is being
> > > > 	 * disabled. The patch is removed from the stack in
> > > > 	 * klp_try_complete_transition() and there we need to call
> > > > 	 * rcu_synchronize() to prevent seeing the patch on the stack
> > > > 	 * at all.
> > > > 	 *
> > > > 	 * Well, it still might be needed to see func->transition
> > > > 	 * when the patch is removed and the task is migrated. See
> > > > 	 * the write barrier in __klp_disable_patch().
> > > 
> > > Agreed, though as you mentioned earlier, there's also the implicit
> > > barrier in klp_update_patch_state(), which would execute first in such a
> > > scenario.  So I think I'll update the barrier comments in
> > > klp_update_patch_state().
> > 
> > You inspired me to a scenario with 3 CPUs:
> > 
> > CPU0			CPU1			CPU2
> > 
> > __klp_disable_patch()
> > 
> >   klp_init_transition()
> > 
> >     func->transition = true
> > 
> >   smp_wmb()
> > 
> >   klp_start_transition()
> > 
> >     set TIF_PATCH_PATCHPENDING
> > 
> > 			klp_update_patch_state()
> > 
> > 			  task->patch_state
> > 			     = KLP_UNPATCHED
> > 
> > 			  smp_mb()
> > 
> > 						klp_ftrace_handler()
> > 						  func = list_...
> > 
> > 						  smp_rmb() /*needed?*/
> > 
> > 						  if (func->transition)
> > 
> 
> I think this isn't possible.  Remember the comment I added to
> klp_update_patch_state():
> 
>  * NOTE: If task is not 'current', the caller must ensure the task is inactive.
>  * Otherwise klp_ftrace_handler() might read the wrong 'patch_state' value.
> 
> Right now klp_update_patch_state() is only called for current.
> klp_ftrace_handler() on CPU2 would be running in the context of a
> different task.

I agree that it is impossible with the current code. In fact, I cannot
imagine a way to migrate the task where the barrier would be needed.
The question if we could/should somehow document it. Something like

	* The barrier is not really needed when the patch is being
	* disabled. The value of func->transition would change
	* the result of this handled only after the task is migrated.
	* But the conditions for the migration are very limited
	* and practically include a full barrier, see
	* klp_update_patch_state().


> > We need to make sure the CPU3 sees func->transition set. Otherwise,
> > it would wrongly use the function from the patch.
> > 
> > So, the description might be:
> > 
> > 	 * Enforce the order of the ops->func_stack and
> > 	 * func->transition reads when the patch is enabled.
> > 	 * The corresponding write barrier is in __klp_enable_patch().
> > 	 *
> > 	 * Also make sure that func->transition is visible before
> > 	 * TIF_PATCH_PENDING_FLAG is set and the task might get
> > 	 * migrated to KLP_UNPATCHED state. The corresponding
> > 	 * write barrier is in __klp_disable_patch().
> > 
> > 
> > By other words, the read barrier here is needed from the same
> > reason as the write barrier in __klp_disable_patch().
> > > > > +void klp_reverse_transition(void)
> > > > > +{
> > > > > +	unsigned int cpu;
> > > > > +	struct task_struct *g, *task;
> > > > > +
> > > > > +	klp_transition_patch->enabled = !klp_transition_patch->enabled;
> > > > > +
> > > > > +	klp_target_state = !klp_target_state;
> > > > > +
> > > > > +	/*
> > > > > +	 * Clear all TIF_PATCH_PENDING flags to prevent races caused by
> > > > > +	 * klp_update_patch_state() running in parallel with
> > > > > +	 * klp_start_transition().
> > > > > +	 */
> > > > > +	read_lock(&tasklist_lock);
> > > > > +	for_each_process_thread(g, task)
> > > > > +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > > > +	read_unlock(&tasklist_lock);
> > > > > +
> > > > > +	for_each_possible_cpu(cpu)
> > > > > +		clear_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > > > > +
> > > > > +	/* Let any remaining calls to klp_update_patch_state() complete */
> > > > > +	synchronize_rcu();
> > > > > +
> > > > > +	klp_start_transition();
> > > > 
> > > > Hmm, we should not call klp_try_complete_transition() when
> > > > klp_start_transition() is called from here. I can't find a safe
> > > > way to cancel klp_transition_work() when we own klp_mutex.
> > > > It smells with a possible deadlock.
> > > > 
> > > > I suggest to move move klp_try_complete_transition() outside
> > > > klp_start_transition() and explicitely call it from
> > > >  __klp_disable_patch() and __klp_enabled_patch().
> > > > This would fix also the problem with immediate patches, see
> > > > klp_start_transition().
> > > 
> > > Agreed.  I'll fix it as you suggest and I'll put the mod_delayed_work()
> > > call in klp_reverse_transition() again.
> > 
> > There is one small catch. The mod_delayed_work() might cause that two
> > works might be scheduled:
> > 
> >   + one already running that is waiting for the klp_mutex
> >   + another one scheduled by that mod_delayed_work()
> >
> > A solution would be to cancel the work from klp_transition_work_fn()
> > if the transition succeeds.
> > 
> > Another possibility would be to do nothing here. The work is
> > scheduled very often anyway.
> 
> Yes, I think I'll do this, for the sake of simplicity.

Sounds good to me.

I am sorry for the late reply. I am ill and work only limited
time.

Best Regards,
Petr
