Return-Path: <pmladek@suse.com>
Date: Thu, 5 May 2016 13:57:01 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: klp_task_patch: was: [RFC PATCH v2 17/18] livepatch: change to a
 per-task consistency model
Message-ID: <20160505115701.GY2749@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504144854.GT2749@pathway.suse.cz>
 <20160504175700.nizuvflyisfd3lks@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160504175700.nizuvflyisfd3lks@treble>
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

On Wed 2016-05-04 12:57:00, Josh Poimboeuf wrote:
> On Wed, May 04, 2016 at 04:48:54PM +0200, Petr Mladek wrote:
> > On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> > > Change livepatch to use a basic per-task consistency model.  This is the
> > > foundation which will eventually enable us to patch those ~10% of
> > > security patches which change function or data semantics.  This is the
> > > biggest remaining piece needed to make livepatch more generally useful.
> > > 
> > > diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
> > > new file mode 100644
> > > index 0000000..92819bb
> > > --- /dev/null
> > > +++ b/kernel/livepatch/transition.c
> > > +/*
> > > + * klp_patch_task() - change the patched state of a task
> > > + * @task:	The task to change
> > > + *
> > > + * Switches the patched state of the task to the set of functions in the target
> > > + * patch state.
> > > + */
> > > +void klp_patch_task(struct task_struct *task)
> > > +{
> > > +	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
> > > +
> > > +	/*
> > > +	 * The corresponding write barriers are in klp_init_transition() and
> > > +	 * klp_reverse_transition().  See the comments there for an explanation.
> > > +	 */
> > > +	smp_rmb();
> > > +
> > > +	task->patch_state = klp_target_state;
> > > +}
> > > +
> > > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > > index bd12c6c..60d633f 100644
> > > --- a/kernel/sched/idle.c
> > > +++ b/kernel/sched/idle.c
> > > @@ -9,6 +9,7 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/stackprotector.h>
> > >  #include <linux/suspend.h>
> > > +#include <linux/livepatch.h>
> > >  
> > >  #include <asm/tlb.h>
> > >  
> > > @@ -266,6 +267,9 @@ static void cpu_idle_loop(void)
> > >  
> > >  		sched_ttwu_pending();
> > >  		schedule_preempt_disabled();
> > > +
> > > +		if (unlikely(klp_patch_pending(current)))
> > > +			klp_patch_task(current);
> > >  	}
> > 
> > Some more ideas from the world of crazy races. I was shaking my head
> > if this was safe or not.
> > 
> > The problem might be if the task get rescheduled between the check
> > for the pending stuff or inside the klp_patch_task() function.
> > This will get even more important when we use this construct
> > on some more locations, e.g. in some kthreads.
> > 
> > If the task is sleeping on this strange locations, it might assign
> > strange values on strange times.
> > 
> > I think that it is safe only because it is called with the
> > 'current' parameter and on a safe locations. It means that
> > the result is always safe and consistent. Also we could assign
> > an outdated value only when sleeping between reading klp_target_state
> > and storing task->patch_state. But if anyone modified
> > klp_target_state at this point, he also set TIF_PENDING_PATCH,
> > so the change will not get lost.
> > 
> > I think that we should document that klp_patch_func() must be
> > called only from a safe location from within the affected task.
> > 
> > I even suggest to avoid misuse by removing the struct *task_struct
> > parameter. It should always be called with current.
> 
> Would the race involve two tasks trying to call klp_patch_task() for the
> same task at the same time?  If so I don't think that would be a problem
> since they would both write the same value for task->patch_state.

I have missed that the two commands are called with preemption
disabled. So, I had the following crazy scenario in mind:


CPU0				CPU1

klp_enable_patch()

  klp_target_state = KLP_PATCHED;

  for_each_task()
     set TIF_PENDING_PATCH

				# task 123

				if (klp_patch_pending(current)
				  klp_patch_task(current)

                                    clear TIF_PENDING_PATCH

				    smp_rmb();

				    # switch to assembly of
				    # klp_patch_task()

				    mov klp_target_state, %r12

				    # interrupt and schedule
				    # another task


  klp_reverse_transition();

    klp_target_state = KLP_UNPATCHED;

    klt_try_to_complete_transition()

      task = 123;
      if (task->patch_state == klp_target_state;
         return 0;

    => task 123 is in target state and does
    not block conversion

  klp_complete_transition()


  # disable previous patch on the stack
  klp_disable_patch();

    klp_target_state = KLP_UNPATCHED;
  
  
				    # task 123 gets scheduled again
				    lea %r12, task->patch_state

				    => it happily stores an outdated
				    state


This is why the two functions should get called with preemption
disabled. We should document it at least. I imagine that we will
use them later also in another context and nobody will remember
this crazy scenario.

Well, even disabled preemption does not help. The process on
CPU1 might be also interrupted by an NMI and do some long
printk in it.

IMHO, the only safe approach is to call klp_patch_task()
only for "current" on a safe place. Then this race is harmless.
The switch happen on a safe place, so that it does not matter
into which state the process is switched.

By other words, the task state might be updated only

   + by the task itself on a safe place
   + by other task when the updated on is sleeping on a safe place

This should be well documented and the API should help to avoid
a misuse.

Best Regards,
Petr
