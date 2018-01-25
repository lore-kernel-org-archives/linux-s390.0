Return-Path: <pmladek@suse.com>
Date: Thu, 25 Jan 2018 13:13:21 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5 13/15] livepatch: change to a per-task consistency model
Message-ID: <20180125121321.6rzrl5rsrvewxn7j@pathway.suse.cz>
References: <cover.1487036215.git.jpoimboe@redhat.com>
 <a999d965d598b23564355c24db0ed6799f105fa6.1487036215.git.jpoimboe@redhat.com>
 <20180125090444.GB2339@hirez.programming.kicks-ass.net>
 <20180125102414.wu5od5ye5nmx2ckl@pathway.suse.cz>
 <20180125103855.GC2228@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125103855.GC2228@hirez.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu 2018-01-25 11:38:55, Peter Zijlstra wrote:
> On Thu, Jan 25, 2018 at 11:24:14AM +0100, Petr Mladek wrote:
> > On Thu 2018-01-25 10:04:44, Peter Zijlstra wrote:
> > > On Mon, Feb 13, 2017 at 07:42:40PM -0600, Josh Poimboeuf wrote:
> > > > diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> > > > index 6a4bae0..a8b3f1a 100644
> > > > --- a/kernel/sched/idle.c
> > > > +++ b/kernel/sched/idle.c
> > > > @@ -9,6 +9,7 @@
> > > >  #include <linux/mm.h>
> > > >  #include <linux/stackprotector.h>
> > > >  #include <linux/suspend.h>
> > > > +#include <linux/livepatch.h>
> > > >  
> > > >  #include <asm/tlb.h>
> > > >  
> > > > @@ -264,6 +265,9 @@ static void do_idle(void)
> > > >  
> > > >  	sched_ttwu_pending();
> > > >  	schedule_preempt_disabled();
> > > > +
> > > > +	if (unlikely(klp_patch_pending(current)))
> > > > +		klp_update_patch_state(current);
> > > >  }
> > > 
> > > Can someone explain this one? This is a very weird place to add things.
> > > What was the expectation?
> > 
> > AFAIK, it was the least ugly and minimalist solution that we came with.
> > 
> > The tasks are migrated to the new patch when neither of the patched
> > functions is on the stack. The stack can be checked safely only when
> > the task is not running. It might be very hard to catch the idle
> > task on a such a place if we patch something that is used there.
> > 
> > If the idle task is scheduled, you would need to create some fake
> > load on the system, try to migrate the idle task, stop the fake load
> > on the CPU.
> > 
> > The above code makes the idle task to migrate itself on a sane place.
> > You just need to schedule some minimalist job on the CPU. The idle
> > task will do one loop, gets migrated, and might be scheduled again
> > immediately.
> 
> What I was getting at, the klp stuff is the very first thing we run when
> we schedule the idle task, but its placed at the very end of the
> function. This is confusing.

I see.


> The above still doesn't help with solving that. Do you want to run
> something before we go idle, or before we leave idle, in neither cases
> would I place it where it is.

In fact, both ways are fine. We require going the idle task
through the entire cycle anyway. It is because both situations,
too long idling or non-idling, would block finishing the patch
transition.

Feel free to move it right before schedule_idle() or
__current_set_polling().

Or should I send a patch?

Best Regards,
Petr
