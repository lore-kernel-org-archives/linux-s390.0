Return-Path: <pmladek@suse.com>
Date: Mon, 9 May 2016 14:23:03 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: klp_task_patch: was: [RFC PATCH v2 17/18] livepatch: change to a
 per-task consistency model
Message-ID: <20160509122303.GD2895@pathway.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504144854.GT2749@pathway.suse.cz>
 <20160504175700.nizuvflyisfd3lks@treble>
 <20160505115701.GY2749@pathway.suse.cz>
 <20160506123855.oabdeehqu3aj6nqy@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160506123855.oabdeehqu3aj6nqy@treble>
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

On Fri 2016-05-06 07:38:55, Josh Poimboeuf wrote:
> On Thu, May 05, 2016 at 01:57:01PM +0200, Petr Mladek wrote:
> > I have missed that the two commands are called with preemption
> > disabled. So, I had the following crazy scenario in mind:
> > 
> > 
> > CPU0				CPU1
> > 
> > klp_enable_patch()
> > 
> >   klp_target_state = KLP_PATCHED;
> > 
> >   for_each_task()
> >      set TIF_PENDING_PATCH
> > 
> > 				# task 123
> > 
> > 				if (klp_patch_pending(current)
> > 				  klp_patch_task(current)
> > 
> >                                     clear TIF_PENDING_PATCH
> > 
> > 				    smp_rmb();
> > 
> > 				    # switch to assembly of
> > 				    # klp_patch_task()
> > 
> > 				    mov klp_target_state, %r12
> > 
> > 				    # interrupt and schedule
> > 				    # another task
> > 
> > 
> >   klp_reverse_transition();
> > 
> >     klp_target_state = KLP_UNPATCHED;
> > 
> >     klt_try_to_complete_transition()
> > 
> >       task = 123;
> >       if (task->patch_state == klp_target_state;
> >          return 0;
> > 
> >     => task 123 is in target state and does
> >     not block conversion
> > 
> >   klp_complete_transition()
> > 
> > 
> >   # disable previous patch on the stack
> >   klp_disable_patch();
> > 
> >     klp_target_state = KLP_UNPATCHED;
> >   
> >   
> > 				    # task 123 gets scheduled again
> > 				    lea %r12, task->patch_state
> > 
> > 				    => it happily stores an outdated
> > 				    state
> > 
> 
> Thanks for the clear explanation, this helps a lot.
> 
> > This is why the two functions should get called with preemption
> > disabled. We should document it at least. I imagine that we will
> > use them later also in another context and nobody will remember
> > this crazy scenario.
> > 
> > Well, even disabled preemption does not help. The process on
> > CPU1 might be also interrupted by an NMI and do some long
> > printk in it.
> > 
> > IMHO, the only safe approach is to call klp_patch_task()
> > only for "current" on a safe place. Then this race is harmless.
> > The switch happen on a safe place, so that it does not matter
> > into which state the process is switched.
> 
> I'm not sure about this solution.  When klp_complete_transition() is
> called, we need all tasks to be patched, for good.  We don't want any of
> them to randomly switch to the wrong state at some later time in the
> middle of a future patch operation.  How would changing klp_patch_task()
> to only use "current" prevent that?

You are right that it is pity but it really should be safe because
it is not entirely random.

If the race happens and assign an outdated value, there are two
situations:

1. It is assigned when there is not transition in the progress.
   Then it is OK because it will be ignored by the ftrace handler.
   The right state will be set before the next transition starts.

2. It is assigned when some other transition is in progress.
   Then it is OK as long as the function is called from "current".
   The "wrong" state will be used consistently. It will switch
   to the right state on another safe state.


> > By other words, the task state might be updated only
> > 
> >    + by the task itself on a safe place
> >    + by other task when the updated on is sleeping on a safe place
> > 
> > This should be well documented and the API should help to avoid
> > a misuse.
> 
> I think we could fix it to be safe for future callers who might not have
> preemption disabled with a couple of changes to klp_patch_task():
> disabling preemption and testing/clearing the TIF_PATCH_PENDING flag
> before changing the patch state:
> 
>   void klp_patch_task(struct task_struct *task)
>   {
>   	preempt_disable();
>   
>   	if (test_and_clear_tsk_thread_flag(task, TIF_PATCH_PENDING))
>   		task->patch_state = READ_ONCE(klp_target_state);
>   
>   	preempt_enable();
>   }

It reduces the race window a bit but it is still there. For example,
NMI still might add a huge delay between reading klp_target_state
and assigning task->patch state.

What about the following?

/*
 * This function might assign an outdated value if the transaction
`* is reverted and finalized in parallel. But it is safe. If the value
 * is assigned outside of a transaction, it is ignored and the next
 * transaction will set the right one. Or if it gets assigned
 * inside another transaction, it will repeat the cycle and
 * set the right state.
 */
void klp_update_current_patch_state()
{
	while (test_and_clear_tsk_thread_flag(current, TIF_PATCH_PENDING))
		current->patch_state = READ_ONCE(klp_target_state);
}

Note that the disabled preemption helped only partially,
so I think that it was not really needed.

Hmm, it means that the task->patch_state  might be either
KLP_PATCHED or KLP_UNPATCHED outside a transition. I wonder
if the tristate really brings some advantages.


Alternatively, we might synchronize the operation with klp_mutex.
The function is called in a slow path and in a safe context.
Well, it might cause contention on the lock when many CPUs are
trying to update their tasks.

Best Regards,
Petr
