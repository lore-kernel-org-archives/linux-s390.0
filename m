Return-Path: <jpoimboe@redhat.com>
Date: Fri, 6 Jan 2017 15:01:20 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170106210120.6xdwnakjjfdoe7ra@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1701041423100.6852@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1701041423100.6852@pobox.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 04, 2017 at 02:44:47PM +0100, Miroslav Benes wrote:
> On Thu, 8 Dec 2016, Josh Poimboeuf wrote:
> 
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
> > +	read_unlock(&tasklist_lock);
> > +
> > +	/*
> > +	 * Ditto for the idle "swapper" tasks, though they never cross the
> > +	 * syscall barrier.  Instead they switch over in cpu_idle_loop().
> 
> ...or we switch them in klp_try_complete_transition() first by looking at 
> their stacks, right? I would add it to the comment.

Yeah, I guess the "ditto" was intended to include the "unless we switch
them in klp_try_complete_transition() first" statement from the previous
comment.  I'll try to make it clearer.

> > +	 */
> > +	get_online_cpus();
> > +	for_each_online_cpu(cpu)
> > +		set_tsk_thread_flag(idle_task(cpu), TIF_PATCH_PENDING);
> > +	put_online_cpus();
> > +}
> 
> [...]
> 
> > --- a/kernel/sched/idle.c
> > +++ b/kernel/sched/idle.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/stackprotector.h>
> >  #include <linux/suspend.h>
> > +#include <linux/livepatch.h>
> >  
> >  #include <asm/tlb.h>
> >  
> > @@ -264,6 +265,9 @@ static void do_idle(void)
> >  
> >  	sched_ttwu_pending();
> >  	schedule_preempt_disabled();
> > +
> > +	if (unlikely(klp_patch_pending(current)))
> > +		klp_update_patch_state(current);
> >  }
> 
> I think that (theoretically) this is not sufficient, if we patch a 
> function present on an idle task's stack and one of the two following 
> scenarios happen.

Agreed, though I'd argue that these are rare edge cases which can
probably be refined later, outside the scope of this patch set.

> 1. there is nothing to schedule on a cpu and an idle task does not leave a 
> loop in do_idle() for some time. It may be a nonsense practically and if 
> it is not we could solve with schedule_on_each_cpu() on an empty stub 
> somewhere in our code.

This might only be a theoretical issue, as it only happens when patching
one of the idle functions themselves.

If we decided that this were a real world problem, we could use
something like schedule_on_each_cpu() to flush them out as you
suggested.  Or it could even be done from user space by briefly running
a CPU-intensive program on the affected CPUs.

> 2. there is a cpu-bound process running on one of the cpus. No chance of 
> going to do_idle() there at all and the idle task would block the 
> patching.

To clarify I think this would only be an issue when trying to patch idle
code or schedule()/__schedule().

> We ran into it in kGraft and I tried to solve it with this new 
> hunk in pick_next_task()...
> 
> +       /*
> +        * Patching is in progress, schedule an idle task to migrate it
> +        */
> +       if (kgr_in_progress_branch()) {
> +               if (!test_bit(0, kgr_immutable) &&
> +                   klp_kgraft_task_in_progress(rq->idle)) {
> +                       p = idle_sched_class.pick_next_task(rq, prev);
> +
> +                       return p;
> +               }
> +       }
> 
> (kgr_in_progress_branch() is a static key basically. kgr_immutable flag 
> solves something we don't have a problem with in upstream livepatch thanks 
> to a combination of task->patch_state and klp_func->transition. 
> klp_kgraft_task_in_progress() checks the livepatching TIF of a task.)
> 
> It is not tested properly and it is a hack as hell so take it as that. 
> Also note that the problem in kGraft is more serious as we don't have a 
> stack checking there. So any livepatch could cause the issue easily.
> 
> I can imagine even crazier solutions but nothing nice and pretty (which is 
> probably impossible because the whole idea to deliberately schedule an 
> idle task is not nice and pretty).

Yeah, that looks hairy...

Since this is such a specialized case (patching the scheduler in an idle
task while CPU-intensive tasks are running) this might also be more
reasonably accomplished from user space by briefly SIGSTOPing the CPU
hog.

> Otherwise the patch looks good to me. I don't understand how Petr found 
> those races there.

Agreed, kudos to Petr :-)

-- 
Josh
