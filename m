Return-Path: <pmladek@suse.com>
Date: Thu, 22 Dec 2016 15:34:52 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20161222143452.GK25166@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
 <20161221212505.dbxeddu2skmjmwiq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161221212505.dbxeddu2skmjmwiq@treble>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed 2016-12-21 15:25:05, Josh Poimboeuf wrote:
> On Tue, Dec 20, 2016 at 06:32:46PM +0100, Petr Mladek wrote:
> > On Thu 2016-12-08 12:08:38, Josh Poimboeuf wrote:
> > > Change livepatch to use a basic per-task consistency model.  This is the
> > > foundation which will eventually enable us to patch those ~10% of
> > > security patches which change function or data semantics.  This is the
> > > biggest remaining piece needed to make livepatch more generally useful.
> > > 
> > > [1] https://lkml.kernel.org/r/20141107140458.GA21774@suse.cz
> > > 
> > > --- /dev/null
> > > +++ b/kernel/livepatch/transition.c
> > > +/*
> > > + * Initialize the global target patch state and all tasks to the initial patch
> > > + * state, and initialize all function transition states to true in preparation
> > > + * for patching or unpatching.
> > > + */
> > > +void klp_init_transition(struct klp_patch *patch, int state)
> > > +{
> > > +	struct task_struct *g, *task;
> > > +	unsigned int cpu;
> > > +	struct klp_object *obj;
> > > +	struct klp_func *func;
> > > +	int initial_state = !state;
> > > +
> > > +	WARN_ON_ONCE(klp_target_state != KLP_UNDEFINED);
> > > +
> > > +	klp_transition_patch = patch;
> > > +
> > > +	/*
> > > +	 * Set the global target patch state which tasks will switch to.  This
> > > +	 * has no effect until the TIF_PATCH_PENDING flags get set later.
> > > +	 */
> > > +	klp_target_state = state;
> > > +
> > > +	/*
> > > +	 * If the patch can be applied or reverted immediately, skip the
> > > +	 * per-task transitions.
> > > +	 */
> > > +	if (patch->immediate)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Initialize all tasks to the initial patch state to prepare them for
> > > +	 * switching to the target state.
> > > +	 */
> > > +	read_lock(&tasklist_lock);
> > > +	for_each_process_thread(g, task) {
> > > +		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
> > > +		task->patch_state = initial_state;
> > > +	}
> > > +	read_unlock(&tasklist_lock);
> > > +
> > > +	/*
> > > +	 * Ditto for the idle "swapper" tasks.
> > > +	 */
> > > +	get_online_cpus();
> > > +	for_each_online_cpu(cpu) {
> > > +		task = idle_task(cpu);
> > > +		WARN_ON_ONCE(task->patch_state != KLP_UNDEFINED);
> > > +		task->patch_state = initial_state;
> > > +	}
> > > +	put_online_cpus();
> > 
> > We allow to add/remove CPUs here. I am afraid that we will also need
> > to add a cpu coming/going handler that will set the task->patch_state
> > the right way. We must not set the klp_target_state until all ftrace
> > handlers are ready.
> 
> What if we instead just change the above to use for_each_possible_cpu()?
> We could do the same in klp_complete_transition().

I like this idea. It seems that there is idle task for each possible
cpu, see idle_threads_init().

IMHO, we should do the same everytime we do anything with the idle
tasks. I mean in klp_start_transition, klp_try_complete_transition()
and also complete_transition().

Then they will be handled like any other processes and we do not need
to think of any special races.


> > > +	/*
> > > +	 * Enforce the order of the task->patch_state initializations and the
> > > +	 * func->transition updates to ensure that, in the enable path,
> > > +	 * klp_ftrace_handler() doesn't see a func in transition with a
> > > +	 * task->patch_state of KLP_UNDEFINED.
> > > +	 */
> > > +	smp_wmb();
> > > +
> > > +	/*
> > > +	 * Set the func transition states so klp_ftrace_handler() will know to
> > > +	 * switch to the transition logic.
> > > +	 *
> > > +	 * When patching, the funcs aren't yet in the func_stack and will be
> > > +	 * made visible to the ftrace handler shortly by the calls to
> > > +	 * klp_patch_object().
> > > +	 *
> > > +	 * When unpatching, the funcs are already in the func_stack and so are
> > > +	 * already visible to the ftrace handler.
> > > +	 */
> > > +	klp_for_each_object(patch, obj)
> > > +		klp_for_each_func(obj, func)
> > > +			func->transition = true;
> > > +}
> > > +
> > > +/*
> > > + * Start the transition to the specified target patch state so tasks can begin
> > > + * switching to it.
> > > + */
> > > +void klp_start_transition(void)
> > > +{
> > > +	struct task_struct *g, *task;
> > > +	unsigned int cpu;
> > > +
> > > +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> > > +
> > > +	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
> > > +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> > > +
> > > +	/*
> > > +	 * If the patch can be applied or reverted immediately, skip the
> > > +	 * per-task transitions.
> > > +	 */
> > > +	if (klp_transition_patch->immediate)
> > > +		return;
> > > +
> > > +	/*
> > > +	 * Mark all normal tasks as needing a patch state update.  As they pass
> > > +	 * through the syscall barrier they'll switch over to the target state
> > > +	 * (unless we switch them in klp_try_complete_transition() first).
> > > +	 */
> > > +	read_lock(&tasklist_lock);
> > > +	for_each_process_thread(g, task)
> > > +		set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > 
> > This is called also from klp_reverse_transition(). We should set it
> > only when the task need migration. Also we should clear it when
> > the task is in the right state already.
> > 
> > It is not only optimization. It actually solves a race between
> > klp_complete_transition() and klp_update_patch_state(), see below.
> 
> I agree about the race, but if I did:
> 
> 	for_each_process_thread(g, task) {
> 		if (task->patch_state != klp_target_state)
> 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> 		else
> 			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> 	}
> 
> It would still leave a small window where TIF_PATCH_PENDING gets set for
> an already patched task, if klp_update_patch_state() is running at the
> same time.

I see your point. Well, it seems that it is more complicated:

The race would be possible only when this was called from
klp_reverse_transition(). But we need to call there
rcu_synchronize() to prevent races with klp_update_patch_state()
also to prevent prelimitary patch completion.

The result is:

	if (task->patch_state != klp_target_state) {
	    # it means that the task was already migrated before
	    # we reverted klp_target_state. It means that
	    # the TIF flag was already cleared, the related
	    # klp_update_patch_state() already finished (thanks
	    # to rcu_synchronize() and new one will be called
	    # only when we set the flag again
	    # => it is safe to set it

	    # we should also check and warn when the TIF flag
	    # was not clear before we set it here


	else

	    # the task was not migrated before we reverted
	    # klp_target_state. klp_update_patch_state()
	    # could run in parallel but it will do the same
	    # what we do, clear TIF flag and keep the patch_state
	    # as is
	    # => it is safe to clear it


I agree that this is complex like hell. But it also allows use to
check that things work as we expect.

If we always set the flag here and always clear it later, we might
hide a bug.

If we want to make it slightly more straightforward, we might
clear TIF flags in klp_reverse_transaction() before we revert
klp_target_state. The later rcu_synchronize() should make sure
that all migrations are finished and non-will run in parallel.
Then we could set the TIF flag only where needed here.


> > > +	read_unlock(&tasklist_lock);
> > > +
> > > +	/*
> > > +	 * Ditto for the idle "swapper" tasks, though they never cross the
> > > +	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
> > > +	 */
> > > +	get_online_cpus();
> > > +	for_each_online_cpu(cpu)
> > > +		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > > +	put_online_cpus();
> > 
> > Also this stage need to be somehow handled by CPU coming/going
> > handlers.
> 
> Here I think we could automatically switch any offline CPUs' idle tasks.
> And something similar in klp_try_complete_transition().

We still need to make sure to do not race with the cpu_up()/cpu_down()
calls.

I would use here the trick with for_each_possible_cpu() and let
the migration for the stack check.


> > > +}
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
> > 
> > We should call rcu_synchronize() here. Otherwise, there
> > might be a race, see below:
> > 
> > CPU1					CPU2
> > 
> > klp_ftrace_handler()
> >   if (unlikely(func->transition))
> > 	// still true
> > 
> > 					klp_complete_transition()
> > 					  func->transition = false;
> > 					  task->patch_state =
> > 					      KLP_UNDEFINED;
> > 
> >      patch_state = current->patch_state;
> > 
> >      WARN_ON(patch_state == KLP_UNDEFINED);
> > 
> > BANG!: We print the warning.
> 
> This shouldn't be possible because klp_try_complete_transition() calls
> rcu_synchronize() before calling klp_complete_transition().  So by the
> time klp_complete_transition() is called, the ftrace handler can no
> longer see the affected func.  See the comment for rcu_synchronize() in
> klp_try_complete_transition().

But rcu_synchronize() in klp_try_complete_transition() will help only
when the patch is being disabled. The ftrace handler will still see
this function and race when the patch is being enabled.

But you are partially right. We need the rcu_synchronize() here
only when the patch is being enabled. It actually matches my comments
in klp_try_complete_transition() where I suggested to call it
only when the patch is being removed.


> > Note that that smp_wmb() is enough in klp_init_transition()
> > but it is not enough here. We need to wait longer once
> > someone might be inside the if (true) code.
> > 
> > > +	read_lock(&tasklist_lock);
> > > +	for_each_process_thread(g, task) {
> > > +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > +		task->patch_state = KLP_UNDEFINED;
> > > +	}
> > > +	read_unlock(&tasklist_lock);
> > > +
> > > +	get_online_cpus();
> > > +	for_each_online_cpu(cpu) {
> > > +		task = idle_task(cpu);
> > > +		clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > 
> > If TIF_PATCH_PENDING flag is set here it means that
> > klp_update_patch_state() might get triggered and it might
> > put wrong value into task->patch_state.
> > 
> > We must make sure that all task have this cleared before
> > calling this function. This is another reason why
> > klp_init_transition() should set the flag only when
> > transition is needed.
> > 
> > We should only check the state here.
> > 
> > It still might make sense to clear it when it is set wrongly.
> > But the question is if it is really safe to continue. I am
> > afraid that it is not. It would mean that the consistency
> > model is broken and we are in strange state.
> 
> As I mentioned above, with your proposal I think there could still be a
> task with a spurious set TIF_PATCH_PENDING at this point.

I believe that it could not be here if we add that rcu_synchronize()
into klp_reverse_transition().


> Maybe instead we should clear all the TIF_PATCH_PENDING flags before the
> synchronize_rcu() in klp_try_complete_transition().

It might work. But I believe that we do not need this. If we do it,
we might hide a bug.


> > > +		task->patch_state = KLP_UNDEFINED;
> > > +	}
> > > +	put_online_cpus();
> > > +
> > > +done:
> > > +	klp_target_state = KLP_UNDEFINED;
> > > +	klp_transition_patch = NULL;
> > > +}
> > 
> > [...]
> > 
> > > +
> > > +/*
> > > + * Try to switch all remaining tasks to the target patch state by walking the
> > > + * stacks of sleeping tasks and looking for any to-be-patched or
> > > + * to-be-unpatched functions.  If such functions are found, the task can't be
> > > + * switched yet.
> > > + *
> > > + * If any tasks are still stuck in the initial patch state, schedule a retry.
> > > + */
> > > +bool klp_try_complete_transition(void)
> > > +{
> > > +	unsigned int cpu;
> > > +	struct task_struct *g, *task;
> > > +	bool complete = true;
> > > +
> > > +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> > > +
> > > +	/*
> > > +	 * If the patch can be applied or reverted immediately, skip the
> > > +	 * per-task transitions.
> > > +	 */
> > > +	if (klp_transition_patch->immediate)
> > > +		goto success;
> > > +
> > > +	/*
> > > +	 * Try to switch the tasks to the target patch state by walking their
> > > +	 * stacks and looking for any to-be-patched or to-be-unpatched
> > > +	 * functions.  If such functions are found on a stack, or if the stack
> > > +	 * is deemed unreliable, the task can't be switched yet.
> > > +	 *
> > > +	 * Usually this will transition most (or all) of the tasks on a system
> > > +	 * unless the patch includes changes to a very common function.
> > > +	 */
> > > +	read_lock(&tasklist_lock);
> > > +	for_each_process_thread(g, task)
> > > +		if (!klp_try_switch_task(task))
> > > +			complete = false;
> > > +	read_unlock(&tasklist_lock);
> > > +
> > > +	/*
> > > +	 * Ditto for the idle "swapper" tasks.
> > > +	 */
> > > +	get_online_cpus();
> > > +	for_each_online_cpu(cpu)
> > > +		if (!klp_try_switch_task(idle_task(cpu)))
> > > +			complete = false;
> > > +	put_online_cpus();
> > > +
> > > +	/*
> > > +	 * Some tasks weren't able to be switched over.  Try again later and/or
> > > +	 * wait for other methods like syscall barrier switching.
> > > +	 */
> > > +	if (!complete)
> > > +		return false;
> > > +
> > > +success:
> > > +
> > > +	/*
> > > +	 * When unpatching, all tasks have transitioned to KLP_UNPATCHED so we
> > > +	 * can now remove the new functions from the func_stack.
> > > +	 */
> > > +	if (klp_target_state == KLP_UNPATCHED)
> > > +		klp_unpatch_objects(klp_transition_patch);
> > > +
> > > +	/*
> > > +	 * Wait for all RCU read-side critical sections to complete.
> > > +	 *
> > > +	 * This has two purposes:
> > > +	 *
> > > +	 * 1) Ensure all existing critical sections in klp_update_patch_state()
> > > +	 *    complete, so task->patch_state won't be unexpectedly updated
> > > +	 *    later.
> > 
> > We should not be here if anyone still might be in klp_update_patch_state().
> 
> Depends on our discussion about conditionally setting TIF_PATCH_PENDING.

Yup.

> > > +	 *
> > > +	 * 2) When unpatching, don't allow any existing instances of
> > > +	 *    klp_ftrace_handler() to access any obsolete funcs before we reset
> > > +	 *    the func transition states to false.  Otherwise the handler may
> > > +	 *    see the deleted "new" func, see that it's not in transition, and
> > > +	 *    wrongly pick the new version of the function.
> > > +	 */
> > 
> > This makes sense but it too me long time to understand. I wonder if
> > this might be better:
> > 
> > 	/*
> > 	 * Make sure that the function is removed from ops->func_stack
> > 	 * before we clear func->transition. Otherwise the handler may
> > 	 * pick the wrong version.
> > 	 */
> 
> Sounds good.
> 
> > And I would call this only when the patch is being removed
> > 
> > 	if (klp_target_state = KLP_UNPATCHED)
> > 		synchronize_rcu();
> 
> Depends on our discussion about conditionally setting TIF_PATCH_PENDING.

And yup.

> > I think that this was the reason to remove WARN_ON_ONCE(!func)
> > in klp_ftrace_handler(). But this is not related. If this was
> > the last entry in the list, we removed the ftrace_handler
> > before removing the last entry. And unregister_ftrace_function()
> > calls rcu_synchronize() to prevent calling the handler later.
> > 
> > 
> > > +	synchronize_rcu();
> > > +
> > > +	pr_notice("'%s': %s complete\n", klp_transition_patch->mod->name,
> > > +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> > > +
> > > +	/* we're done, now cleanup the data structures */
> > > +	klp_complete_transition();
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/*
> > > + * This function can be called in the middle of an existing transition to
> > > + * reverse the direction of the target patch state.  This can be done to
> > > + * effectively cancel an existing enable or disable operation if there are any
> > > + * tasks which are stuck in the initial patch state.
> > > + */
> > > +void klp_reverse_transition(void)
> > > +{
> > > +	klp_transition_patch->enabled = !klp_transition_patch->enabled;
> > > +
> > > +	klp_target_state = !klp_target_state;
> > > +
> > > +	/*
> > > +	 * Enforce the order of the write to klp_target_state above and the
> > > +	 * TIF_PATCH_PENDING writes in klp_start_transition() to ensure that
> > > +	 * klp_update_patch_state() doesn't set a wrong task->patch_state.
> > > +	 */
> > > +	smp_wmb();
> > 
> > I would call rcu_synchronize() here to make sure that
> > klp_update_patch_state() calls will not set
> > an outdated task->patch_state.
> > 
> > Note that smp_wmb() is not enough. We do not check TIF_PATCH_PENDING
> > in klp_try_switch_task(). There is a tiny race:
> > 
> > CPU1					CPU2
> > 
> > klp_update_patch_state()
> > 
> > 	if (test_and clear(task, TIF)
> > 	     READ_ONCE(klp_target_state);
> > 
> > 					mutex_lock(klp_lock);
> > 
> > 					klp_reverse_transition()
> > 					  klp_target_state =
> > 					      !klp_target_state;
> > 
> > 					  klp_start_transition()
> > 
> > 					mutex_unlock(klp_lock);
> > 
> > 					 <switch to another process>
> > 
> > 					 klp_transition_work_fn()
> > 					   mutex_lock(klp_lock);
> > 					   klp_try_complete_transition()
> > 					     klp_try_switch_task()
> > 					       if (task->patch_state ==
> > 						   klp_target_state)
> > 						  return true;
> > 
> > 	    task->patch_state = <outdated_value>;
> > 
> > 	 klp_ftrace_handler()
> > 
> > BANG: klp_ftrace_handler() will use wrong implementation according
> >       to the outdated task->patch_state. At the same time,
> >       klp_transition() is not blocked by the task because it thinks
> >       that it has a correct state.
> 
> Good find!

This is important in the puzzle.

> > > +
> > > +	klp_start_transition();
> > > +}
> > > +
> > > diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
> > > index e34f871..bb61c65 100644
> > > --- a/samples/livepatch/livepatch-sample.c
> > > +++ b/samples/livepatch/livepatch-sample.c
> > > @@ -17,6 +17,8 @@
> > >   * along with this program; if not, see <http://www.gnu.org/licenses/>.
> > >   */
> > >  
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > >  #include <linux/module.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/livepatch.h>
> > > @@ -69,6 +71,11 @@ static int livepatch_init(void)
> > >  {
> > >  	int ret;
> > >  
> > > +	if (!klp_have_reliable_stack() && !patch.immediate) {
> > > +		pr_notice("disabling consistency model!\n");
> > > +		patch.immediate = true;
> > > +	}
> > 
> > I am scared to have this in the sample module. It makes sense
> > to use the consistency model even for immediate patches because
> > it allows to remove them. But this must not be used for patches
> > that really require the consistency model. We should add
> > a big fat warning at least.
> 
> I did this so that the sample module would still work for non-x86_64
> arches, for which there's currently no way to patch kthreads.
> 
> Notice I did add a warning:
> 
>   pr_notice("disabling consistency model!\n");
> 
> Is the warning not fat enough?

The warning does not explain who did it, why, if it is safe, and when
this could be used. I suggest a comment like:

/*
 * WARNING: Use this check only when you know what you do!
 *
 * This sample patch does not change the semantic of the data structures,
 * locks, or return adresses. It is safe to be applied immediately.
 * But we want to test and use the consistency model on supported
 * architectures. It allows to remove the patch module.
 *
 * See Documentation/livepatch/livepatch.txt for more details, please.
 */

Also the message might be more explicit.

 pr_notice("livepatch-sample: The consistency model is not supported on
 this architecture. Using the immediate model that is safe enough.\n");


Alternatively, we might allow more values for patch.immediate, e.g.

enum klp_consistency_model {
     KLP_CM_IMMEDIATE,
     KLP_CM_TASK,
     KLP_CM_TASK_OR_IMMEDIATE,
};

Then we could do the decision on the kernel side.
But I am not sure if this would be widely used and it
it is worth the complication.

Best Regards,
Petr

PS: Merry Christmas and happy new year!

    I am not sure if I will be able to do another deep dive into
    this code until next year.
