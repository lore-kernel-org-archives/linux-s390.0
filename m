Return-Path: <mbenes@suse.cz>
Date: Fri, 23 Dec 2016 10:24:35 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <20161221212505.dbxeddu2skmjmwiq@treble>
Message-ID: <alpine.LSU.2.20.1612231013470.5990@pobox.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
 <20161221212505.dbxeddu2skmjmwiq@treble>
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
Cc: Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

> > > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > > index 5efa262..e79ebb5 100644
> > > --- a/kernel/livepatch/patch.c
> > > +++ b/kernel/livepatch/patch.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/bug.h>
> > >  #include <linux/printk.h>
> > >  #include "patch.h"
> > > +#include "transition.h"
> > >  
> > >  static LIST_HEAD(klp_ops);
> > >  
> > > @@ -54,15 +55,53 @@ static void notrace klp_ftrace_handler(unsigned long ip,
> > >  {
> > >  	struct klp_ops *ops;
> > >  	struct klp_func *func;
> > > +	int patch_state;
> > >  
> > >  	ops = container_of(fops, struct klp_ops, fops);
> > >  
> > >  	rcu_read_lock();
> > > +
> > >  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
> > >  				      stack_node);
> > > -	if (WARN_ON_ONCE(!func))
> > > +
> > > +	if (!func)
> > >  		goto unlock;
> > 
> > Why do you removed the WARN_ON_ONCE(), please?
> > 
> > We still add the function on the stack before registering
> > the ftrace handler. Also we unregister the ftrace handler
> > before removing the the last entry from the stack.
> > 
> > AFAIK, unregister_ftrace_function() calls rcu_synchronize()'
> > to make sure that no-one is inside the handler once finished.
> > Mirek knows more about it.
> 
> Hm, this is news to me.  Mirek, please share :-)

Well, I think the whole thing is well described in emails I exchanged with 
Steven few months ago. See [1].

[1] http://lkml.kernel.org/r/alpine.LNX.2.00.1608081041060.10833@pobox.suse.cz
 
> > If this is not true, we have a problem. For example,
> > we call kfree(ops) after unregister_ftrace_function();
> 
> Agreed.

TL;DR - we should be ok as long as we do not do crazy things in the 
handler, deliberate sleeping for example.

WARN_ON_ONCE() may be crazy too. I think we discussed it long ago and we 
came to an agreement to remove it.

Miroslav, very slowly going through the patch set
