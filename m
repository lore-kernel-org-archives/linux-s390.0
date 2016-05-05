Return-Path: <mbenes@suse.cz>
Date: Thu, 5 May 2016 11:41:44 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC PATCH v2 17/18] livepatch: change to a per-task consistency
 model
In-Reply-To: <20160504155121.twuvstygaeag7yjq@treble>
Message-ID: <alpine.LNX.2.00.1605051136000.19692@pobox.suse.cz>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160504084223.GQ2749@pathway.suse.cz>
 <20160504155121.twuvstygaeag7yjq@treble>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 4 May 2016, Josh Poimboeuf wrote:

> On Wed, May 04, 2016 at 10:42:23AM +0200, Petr Mladek wrote:
> > On Thu 2016-04-28 15:44:48, Josh Poimboeuf wrote:
> > > Change livepatch to use a basic per-task consistency model.  This is the
> > > foundation which will eventually enable us to patch those ~10% of
> > > security patches which change function or data semantics.  This is the
> > > biggest remaining piece needed to make livepatch more generally useful.
> > 
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -76,6 +76,7 @@
> > >  #include <linux/compiler.h>
> > >  #include <linux/sysctl.h>
> > >  #include <linux/kcov.h>
> > > +#include <linux/livepatch.h>
> > >  
> > >  #include <asm/pgtable.h>
> > >  #include <asm/pgalloc.h>
> > > @@ -1586,6 +1587,8 @@ static struct task_struct *copy_process(unsigned long clone_flags,
> > >  		p->parent_exec_id = current->self_exec_id;
> > >  	}
> > >  
> > > +	klp_copy_process(p);
> > 
> > I am in doubts here. We copy the state from the parent here. It means
> > that the new process might still need to be converted. But at the same
> > point print_context_stack_reliable() returns zero without printing
> > any stack trace when TIF_FORK flag is set. It means that a freshly
> > forked task might get be converted immediately. I seems that boot
> > operations are always done when copy_process() is called. But
> > they are contradicting each other.
> > 
> > I guess that print_context_stack_reliable() should either return
> > -EINVAL when TIF_FORK is set. Or it should try to print the
> > stack of the newly forked task.
> > 
> > Or do I miss something, please?
> 
> Ok, I admit it's confusing.
> 
> A newly forked task doesn't *have* a stack (other than the pt_regs frame
> it needs for the return to user space), which is why
> print_context_stack_reliable() returns success with an empty array of
> addresses.
> 
> For a little background, see the second switch_to() macro in
> arch/x86/include/asm/switch_to.h.  When a newly forked task runs for the
> first time, it returns from __switch_to() with no stack.  It then jumps
> straight to ret_from_fork in entry_64.S, calls a few C functions, and
> eventually returns to user space.  So, assuming we aren't patching entry
> code or the switch_to() macro in __schedule(), it should be safe to
> patch the task before it does all that.
> 
> With the current code, if an unpatched task gets forked, the child will
> also be unpatched.  In theory, we could go ahead and patch the child
> then.  In fact, that's what I did in v1.9.
> 
> But in v1.9 discussions it was pointed out that someday maybe the
> ret_from_fork stuff will get cleaned up and instead the child stack will
> be copied from the parent.  In that case the child should inherit its
> parent's patched state.  So we decided to make it more future-proof by
> having the child inherit the parent's patched state.
> 
> So, having said all that, I'm really not sure what the best approach is
> for print_context_stack_reliable().  Right now I'm thinking I'll change
> it back to return -EINVAL for a newly forked task, so it'll be more
> future-proof: better to have a false positive than a false negative.
> Either way it will probably need to be changed again if the
> ret_from_fork code gets cleaned up.

I'd be for returning -EINVAL. It is a safe play for now.

[...]
 
> > Finally, the following is always called right after
> > klp_start_transition(), so I would call it from there.
> > 
> > 	if (!klp_try_complete_transition())
> > 		klp_schedule_work();

On the other hand it is quite nice to see the sequence

init
start
try_complete

there. Just my 2 cents.

> Except for when it's called by klp_reverse_transition().  And it really
> depends on whether we want to allow transition.c to use the mutex.  I
> don't have a strong opinion either way, I may need to think about it
> some more.

Miroslav
