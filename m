Return-Path: <pmladek@suse.com>
Date: Tue, 10 Jan 2017 11:40:04 +0100
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170110104004.GG20785@pathway.suse.cz>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <eeda3a8cf83bcbb569db4774c646ad739b8db415.1481220077.git.jpoimboe@redhat.com>
 <20161220173246.GC25166@pathway.suse.cz>
 <20161221212505.dbxeddu2skmjmwiq@treble>
 <alpine.LSU.2.20.1612231013470.5990@pobox.suse.cz>
 <20161223101803.GB2541@linux.suse>
 <20170106200734.d7wvry4upz2ffwem@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170106200734.d7wvry4upz2ffwem@treble>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri 2017-01-06 14:07:34, Josh Poimboeuf wrote:
> On Fri, Dec 23, 2016 at 11:18:03AM +0100, Petr Mladek wrote:
> > On Fri 2016-12-23 10:24:35, Miroslav Benes wrote:
> > > > > > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > > > > > index 5efa262..e79ebb5 100644
> > > > > > --- a/kernel/livepatch/patch.c
> > > > > > +++ b/kernel/livepatch/patch.c
> > > > > > @@ -29,6 +29,7 @@
> > > > > >  #include <linux/bug.h>
> > > > > >  #include <linux/printk.h>
> > > > > >  #include "patch.h"
> > > > > > +#include "transition.h"
> > > > > >  
> > > > > >  static LIST_HEAD(klp_ops);
> > > > > >  
> > > > > > @@ -54,15 +55,53 @@ static void notrace klp_ftrace_handler(unsigned long ip,
> > > > > >  {
> > > > > >  	struct klp_ops *ops;
> > > > > >  	struct klp_func *func;
> > > > > > +	int patch_state;
> > > > > >  
> > > > > >  	ops = container_of(fops, struct klp_ops, fops);
> > > > > >  
> > > > > >  	rcu_read_lock();
> > > > > > +
> > > > > >  	func = list_first_or_null_rcu(&ops->func_stack, struct klp_func,
> > > > > >  				      stack_node);
> > > > > > -	if (WARN_ON_ONCE(!func))
> > > > > > +
> > > > > > +	if (!func)
> > > > > >  		goto unlock;
> > > > > 
 
> Yeah, I'm thinking we should keep the warning to catch any bugs in case
> any of our ftrace assumptions change.  Maybe I should add a comment:
> 
> 	/*
> 	 * func can never be NULL because preemption should be disabled
> 	 * here and unregister_ftrace_function() does the equivalent of
> 	 * a synchronize_sched() before the func_stack removal.
> 	 */
> 	if (WARN_ON_ONCE(!func))
> 		goto unlock;

Sounds reasonable to me.

Best Regards,
Petr
