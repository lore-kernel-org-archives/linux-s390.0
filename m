Return-Path: <mbenes@suse.cz>
Date: Tue, 10 Jan 2017 11:45:18 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <20170106210120.6xdwnakjjfdoe7ra@treble>
Message-ID: <alpine.LSU.2.20.1701101134160.28763@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1701041423100.6852@pobox.suse.cz>
 <20170106210120.6xdwnakjjfdoe7ra@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>


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
> > > @@ -264,6 +265,9 @@ static void do_idle(void)
> > >  
> > >  	sched_ttwu_pending();
> > >  	schedule_preempt_disabled();
> > > +
> > > +	if (unlikely(klp_patch_pending(current)))
> > > +		klp_update_patch_state(current);
> > >  }
> > 
> > I think that (theoretically) this is not sufficient, if we patch a 
> > function present on an idle task's stack and one of the two following 
> > scenarios happen.
> 
> Agreed, though I'd argue that these are rare edge cases which can
> probably be refined later, outside the scope of this patch set.

You're right. They should be really rare and we can solve them (if we even 
want to) later.
 
> > 1. there is nothing to schedule on a cpu and an idle task does not leave a 
> > loop in do_idle() for some time. It may be a nonsense practically and if 
> > it is not we could solve with schedule_on_each_cpu() on an empty stub 
> > somewhere in our code.
> 
> This might only be a theoretical issue, as it only happens when patching
> one of the idle functions themselves.
> 
> If we decided that this were a real world problem, we could use
> something like schedule_on_each_cpu() to flush them out as you
> suggested.  Or it could even be done from user space by briefly running
> a CPU-intensive program on the affected CPUs.

Yes.

> > 2. there is a cpu-bound process running on one of the cpus. No chance of 
> > going to do_idle() there at all and the idle task would block the 
> > patching.
> 
> To clarify I think this would only be an issue when trying to patch idle
> code or schedule()/__schedule().

Yes.

> > We ran into it in kGraft and I tried to solve it with this new 
> > hunk in pick_next_task()...
> > 
> > +       /*
> > +        * Patching is in progress, schedule an idle task to migrate it
> > +        */
> > +       if (kgr_in_progress_branch()) {
> > +               if (!test_bit(0, kgr_immutable) &&
> > +                   klp_kgraft_task_in_progress(rq->idle)) {
> > +                       p = idle_sched_class.pick_next_task(rq, prev);
> > +
> > +                       return p;
> > +               }
> > +       }
> > 
> > (kgr_in_progress_branch() is a static key basically. kgr_immutable flag 
> > solves something we don't have a problem with in upstream livepatch thanks 
> > to a combination of task->patch_state and klp_func->transition. 
> > klp_kgraft_task_in_progress() checks the livepatching TIF of a task.)
> > 
> > It is not tested properly and it is a hack as hell so take it as that. 
> > Also note that the problem in kGraft is more serious as we don't have a 
> > stack checking there. So any livepatch could cause the issue easily.
> > 
> > I can imagine even crazier solutions but nothing nice and pretty (which is 
> > probably impossible because the whole idea to deliberately schedule an 
> > idle task is not nice and pretty).
> 
> Yeah, that looks hairy...
> 
> Since this is such a specialized case (patching the scheduler in an idle
> task while CPU-intensive tasks are running) this might also be more
> reasonably accomplished from user space by briefly SIGSTOPing the CPU
> hog.

Yes, that is true. I can imagine there are users who don't want to stop 
the cpu hog at all. Even for a fraction of time. HPC comes to mind. But it 
is not worth it to solve it with something like the code above. Let's add 
it to the very end of our TODO lists :). 

Miroslav
