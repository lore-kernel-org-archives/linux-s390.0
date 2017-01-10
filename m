Return-Path: <jpoimboe@redhat.com>
Date: Tue, 10 Jan 2017 14:46:46 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170110204646.a4wughlsu6atxu2i@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
 <20161221212505.dbxeddu2skmjmwiq@treble>
 <20161222143452.GK25166@pathway.suse.cz>
 <20161222183137.sdfsiv5dpi7po6zk@treble>
 <20170110130058.GH20785@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170110130058.GH20785@pathway.suse.cz>
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

On Tue, Jan 10, 2017 at 02:00:58PM +0100, Petr Mladek wrote:
> On Thu 2016-12-22 12:31:37, Josh Poimboeuf wrote:
> > On Thu, Dec 22, 2016 at 03:34:52PM +0100, Petr Mladek wrote:
> > > On Wed 2016-12-21 15:25:05, Josh Poimboeuf wrote:
> > > > On Tue, Dec 20, 2016 at 06:32:46PM +0100, Petr Mladek wrote:
> > > > > On Thu 2016-12-08 12:08:38, Josh Poimboeuf wrote:
> > > > > > Change livepatch to use a basic per-task consistency model.  This is the
> > > > > > foundation which will eventually enable us to patch those ~10% of
> > > > > > security patches which change function or data semantics.  This is the
> > > > > > biggest remaining piece needed to make livepatch more generally useful.
> > > > > > 
> > > > > > [1] https://lkml.kernel.org/r/20141107140458.GA21774@suse.cz
> > > > > > 
> > > > > > --- /dev/null
> > > > > > +++ b/kernel/livepatch/transition.c
> > > > > > +	/*
> > > > > > +	 * Enforce the order of the task->patch_state initializations and the
> > > > > > +	 * func->transition updates to ensure that, in the enable path,
> > > > > > +	 * klp_ftrace_handler() doesn't see a func in transition with a
> > > > > > +	 * task->patch_state of KLP_UNDEFINED.
> > > > > > +	 */
> > > > > > +	smp_wmb();
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Set the func transition states so klp_ftrace_handler() will know to
> > > > > > +	 * switch to the transition logic.
> > > > > > +	 *
> > > > > > +	 * When patching, the funcs aren't yet in the func_stack and will be
> > > > > > +	 * made visible to the ftrace handler shortly by the calls to
> > > > > > +	 * klp_patch_object().
> > > > > > +	 *
> > > > > > +	 * When unpatching, the funcs are already in the func_stack and so are
> > > > > > +	 * already visible to the ftrace handler.
> > > > > > +	 */
> > > > > > +	klp_for_each_object(patch, obj)
> > > > > > +		klp_for_each_func(obj, func)
> > > > > > +			func->transition = true;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * Start the transition to the specified target patch state so tasks can begin
> > > > > > + * switching to it.
> > > > > > + */
> > > > > > +void klp_start_transition(void)
> > > > > > +{
> > > > > > +	struct task_struct *g, *task;
> > > > > > +	unsigned int cpu;
> > > > > > +
> > > > > > +	WARN_ON_ONCE(klp_target_state == KLP_UNDEFINED);
> > > > > > +
> > > > > > +	pr_notice("'%s': %s...\n", klp_transition_patch->mod->name,
> > > > > > +		  klp_target_state == KLP_PATCHED ? "patching" : "unpatching");
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * If the patch can be applied or reverted immediately, skip the
> > > > > > +	 * per-task transitions.
> > > > > > +	 */
> > > > > > +	if (klp_transition_patch->immediate)
> > > > > > +		return;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Mark all normal tasks as needing a patch state update.  As they pass
> > > > > > +	 * through the syscall barrier they'll switch over to the target state
> > > > > > +	 * (unless we switch them in klp_try_complete_transition() first).
> > > > > > +	 */
> > > > > > +	read_lock(&tasklist_lock);
> > > > > > +	for_each_process_thread(g, task)
> > > > > > +		set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > > > 
> > > > > This is called also from klp_reverse_transition(). We should set it
> > > > > only when the task need migration. Also we should clear it when
> > > > > the task is in the right state already.
> > > > > 
> > > > > It is not only optimization. It actually solves a race between
> > > > > klp_complete_transition() and klp_update_patch_state(), see below.
> > > > 
> > > > I agree about the race, but if I did:
> > > > 
> > > > 	for_each_process_thread(g, task) {
> > > > 		if (task->patch_state != klp_target_state)
> > > > 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > > 		else
> > > > 			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > > 	}
> > > > 
> > > > It would still leave a small window where TIF_PATCH_PENDING gets set for
> > > > an already patched task, if klp_update_patch_state() is running at the
> > > > same time.
> > > 
> > > I see your point. Well, it seems that it is more complicated:
> > > 
> > > The race would be possible only when this was called from
> > > klp_reverse_transition(). But we need to call there
> > > rcu_synchronize() to prevent races with klp_update_patch_state()
> > > also to prevent prelimitary patch completion.
> > > 
> > > The result is:
> > > 
> > > 	if (task->patch_state != klp_target_state) {
> > > 	    # it means that the task was already migrated before
> > > 	    # we reverted klp_target_state. It means that
> > > 	    # the TIF flag was already cleared, the related
> > > 	    # klp_update_patch_state() already finished (thanks
> > > 	    # to rcu_synchronize() and new one will be called
> > > 	    # only when we set the flag again
> > > 	    # => it is safe to set it
> > > 
> > > 	    # we should also check and warn when the TIF flag
> > > 	    # was not clear before we set it here
> > > 
> > > 
> > > 	else
> > > 
> > > 	    # the task was not migrated before we reverted
> > > 	    # klp_target_state. klp_update_patch_state()
> > > 	    # could run in parallel but it will do the same
> > > 	    # what we do, clear TIF flag and keep the patch_state
> > > 	    # as is
> > > 	    # => it is safe to clear it
> > > 
> > > 
> > > I agree that this is complex like hell. But it also allows use to
> > > check that things work as we expect.
> > 
> > Ouch.  I agree that it seems safe but it's way too hard to reason about.
> > And then it gets worse if you try to think about what happens when
> > adding another reverse operation.
> > 
> > > 
> > > If we always set the flag here and always clear it later, we might
> > > hide a bug.
> > > 
> > > If we want to make it slightly more straightforward, we might
> > > clear TIF flags in klp_reverse_transaction() before we revert
> > > klp_target_state. The later rcu_synchronize() should make sure
> > > that all migrations are finished and non-will run in parallel.
> > > Then we could set the TIF flag only where needed here.
> > 
> > I think this last paragraph is important.  It would simplify things
> > greatly and ensure we won't have klp_update_patch_state() changing
> > things in the background.
> 
> OK, let's clear all TIF_PATCH_PENDIG flags and call rcu_synchronize()
> at the beginning of klp_reverse_transition(). It might be slightly
> suboptimal but it greatly simplifies the situation. I vote for it.
> We need to prevent our heads from cracking ;-)
> 
> Note that I would still set TIF_PATCH_PENDING flag only for tasks
> that are not in the requested state.

Ok, sounds good.

> > > > > > +	read_unlock(&tasklist_lock);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Ditto for the idle "swapper" tasks, though they never cross the
> > > > > > +	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
> > > > > > +	 */
> > > > > > +	get_online_cpus();
> > > > > > +	for_each_online_cpu(cpu)
> > > > > > +		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > > > > > +	put_online_cpus();
> > > > > 
> > > > > Also this stage need to be somehow handled by CPU coming/going
> > > > > handlers.
> > > > 
> > > > Here I think we could automatically switch any offline CPUs' idle tasks.
> > > > And something similar in klp_try_complete_transition().
> > > 
> > > We still need to make sure to do not race with the cpu_up()/cpu_down()
> > > calls.
> > 
> > Hm, maybe we'd need to call cpu_hotplug_disable() before switching the
> > offline idle tasks?
> > 
> > > I would use here the trick with for_each_possible_cpu() and let
> > > the migration for the stack check.
> > 
> > There are a few issues with that:
> > 
> > 1) The idle task of a missing CPU doesn't *have* a stack, so it doesn't
> >    make much sense to try to check it.
> > 
> > 2) We can't rely *only* on the stack check, because not all arches have
> >    it.  The other way to migrate idle tasks is from the idle loop switch
> >    point.  But if the task's CPU is down, its idle loop isn't running so
> >    it can't migrate.
> > 
> >    (Note this is currently a theoretical point: we currently don't allow
> >    such arches to use the consistency model anyway because there's no
> >    way for them to migrate kthreads.)
> 
> Good points. My only concern is that the transaction might take a long
> or even forever. I am not sure if it is wise to disable cpu_hotplug
> for the entire transaction.
> 
> A compromise might be to disable cpu hotplug only when the task
> state is manipulated a more complex way. Hmm, cpu_hotplug_disable()
> looks like a rather costly function. We should not call it in
> klp_try_complete_transition(). But we could do:
> 
>   1. When the patch is being enabled, disable cpu hotplug,
>      go through each_possible_cpu and setup the transaction
>      only for CPUs that are online. Then we could enable
>      the hotplug again.
> 
>   2. Check only each_online_cpu in klp_try_complete_transition().
>      If all tasks are migrated, disable cpu hotplug and re-check
>      idle tasks on online CPUs. If any is not migrated, enable
>      hotplug and return failure. Othewise, continue with
>      completion of the transaction. [*]
> 
>   3. In klp_complete_transition, update all tasks including
>      the offline CPUs and enable cpu hotplug again.
> 
> If the re-check in the 2nd step looks ugly, we could add some hotlug
> notifiers to make sure that enabled/disabled CPUs are in a reasonable
> state. We still should disable the hotplug in the 1st and 3rd step.
> 
> BTW: There is a new API for the cpu hotplug callbacks. I was involved
> in one conversion. You might take inspiration in
> drivers/thermal/intel_powerclamp.c. See cpuhp_setup_state_nocalls()
> there.

Backing up a bit, although I brought up cpu_hotplug_disable(), I think I
misunderstood the race you mentioned.  I actually don't think
cpu_hotplug_disable() is necessary.  What do you think about something
like the following:

In klp_start_transition:

	get_online_cpus();
	for_each_possible_cpu(cpu)
		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
	put_online_cpus();

In klp_try_complete_transition:

	get_online_cpus();
	for_each_possible_cpu(cpu) {
		task = idle_task(cpu);
		if (cpu_online(cpu)) {
			if (!klp_try_switch_task(task))
				complete = false;
		} else if (task->patch_state != klp_target_state) {
			/* offline CPU idle tasks can be switched immediately */
			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
			task->patch_state = klp_target_state;
		}
	}
	put_online_cpus();

-- 
Josh
