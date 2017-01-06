Return-Path: <jpoimboe@redhat.com>
Date: Fri, 6 Jan 2017 14:07:34 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170106200734.d7wvry4upz2ffwem@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
 <20161221212505.dbxeddu2skmjmwiq@treble>
 <alpine.LSU.2.20.1612231013470.5990@pobox.suse.cz>
 <20161223101803.GB2541@linux.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161223101803.GB2541@linux.suse>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 23, 2016 at 11:18:03AM +0100, Petr Mladek wrote:
> On Fri 2016-12-23 10:24:35, Miroslav Benes wrote:
> > > > > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > > > > index 5efa262..e79ebb5 100644
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
> > > > > @@ -54,15 +55,53 @@ static void notrace klp_ftrace_handler(unsigned long ip,
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
> > > > > -	if (WARN_ON_ONCE(!func))
> > > > > +
> > > > > +	if (!func)
> > > > >  		goto unlock;
> > > > 
> > > > Why do you removed the WARN_ON_ONCE(), please?
> > > > 
> > > > We still add the function on the stack before registering
> > > > the ftrace handler. Also we unregister the ftrace handler
> > > > before removing the the last entry from the stack.
> > > > 
> > > > AFAIK, unregister_ftrace_function() calls rcu_synchronize()'
> > > > to make sure that no-one is inside the handler once finished.
> > > > Mirek knows more about it.
> > > 
> > > Hm, this is news to me.  Mirek, please share :-)
> > 
> > Well, I think the whole thing is well described in emails I exchanged with 
> > Steven few months ago. See [1].
> > 
> > [1] http://lkml.kernel.org/r/alpine.LNX.2.00.1608081041060.10833@pobox.suse.cz
> >  
> > > > If this is not true, we have a problem. For example,
> > > > we call kfree(ops) after unregister_ftrace_function();
> > > 
> > > Agreed.
> > 
> > TL;DR - we should be ok as long as we do not do crazy things in the 
> > handler, deliberate sleeping for example.
> > 
> > WARN_ON_ONCE() may be crazy too. I think we discussed it long ago and we 
> > came to an agreement to remove it.
> 
> There are definitely situations where this might hurt. For example,
> when we redirect a function called under logbuf_lock.
> 
> On the other hand, there is a work in progress[1][2] that will mitigate
> this risk a lot. Also this warning would be printed only when
> something goes wrong. IMHO, it is worth the risk. It will succeed
> in 99,999% cases and it might save us some headache when debugging
> random crashes of the system.
> 
> Anyway, if there is a reason to remove the warning, it should be
> described. And if it is not strictly related to this patch, it should
> be handled separately.
> 
> [1] https://lkml.kernel.org/r/20161221143605.2272-1-sergey.senozhatsky@gmail.com
> [2] https://lkml.kernel.org/r/1461333180-2897-1-git-send-email-sergey.senozhatsky@gmail.com

Yeah, I'm thinking we should keep the warning to catch any bugs in case
any of our ftrace assumptions change.  Maybe I should add a comment:

	/*
	 * func can never be NULL because preemption should be disabled
	 * here and unregister_ftrace_function() does the equivalent of
	 * a synchronize_sched() before the func_stack removal.
	 */
	if (WARN_ON_ONCE(!func))
		goto unlock;

-- 
Josh
