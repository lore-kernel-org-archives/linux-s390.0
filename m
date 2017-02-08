Return-Path: <jpoimboe@redhat.com>
Date: Wed, 8 Feb 2017 10:46:36 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
Message-ID: <20170208164636.moddpqpwppozk5v3@treble>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
 <20170202115116.GB23754@pathway.suse.cz>
 <20170203203916.4dlavmvlewgk3j4l@treble>
 <20170206164431.GA2980@pathway.suse.cz>
 <20170206195148.c75y3ru54s425f7k@treble>
 <20170208154749.GE2640@linux.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170208154749.GE2640@linux.suse>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 08, 2017 at 04:47:50PM +0100, Petr Mladek wrote:
> > Notice in this case that klp_target_state is KLP_PATCHED.  Which means
> > that klp_complete_transition() would not call synchronize_rcu() at the
> > right time, nor would it call module_put().  It can be fixed with:
> >
> > @@ -387,7 +389,7 @@ static int __klp_enable_patch(struct klp_patch *patch)
> >  			pr_warn("failed to enable patch '%s'\n",
> >  				patch->mod->name);
> >  
> > -			klp_unpatch_objects(patch);
> > +			klp_target_state = KLP_UNPATCHED;
> >  			klp_complete_transition();
> >  
> >  			return ret;
> 
> Great catch! Looks good to me.

As it turns out, klp_target_state isn't accessible from this file, so
I'll make a klp_cancel_transition() helper function which reverses
klp_target_state and calls klp_complete_transition().

> > This assumes that the 'if (klp_target_state == KLP_UNPATCHED)' clause in
> > klp_try_complete_transition() gets moved to klp_complete_transition() as
> > you suggested.
> > 
> > > > > > diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
> > > > > > index 5efa262..1a77f05 100644
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
> > > > > > @@ -54,15 +55,58 @@ static void notrace klp_ftrace_handler(unsigned long ip,
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
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * func should never be NULL because preemption should be disabled here
> > > > > > +	 * and unregister_ftrace_function() does the equivalent of a
> > > > > > +	 * synchronize_sched() before the func_stack removal.
> > > > > > +	 */
> > > > > > +	if (WARN_ON_ONCE(!func))
> > > > > > +		goto unlock;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Enforce the order of the ops->func_stack and func->transition reads.
> > > > > > +	 * The corresponding write barrier is in __klp_enable_patch().
> > > > > > +	 */
> > > > > > +	smp_rmb();
> > > > > 
> > > > > I was curious why the comment did not mention __klp_disable_patch().
> > > > > It was related to the hours of thinking. I would like to avoid this
> > > > > in the future and add a comment like.
> > > > > 
> > > > > 	 * This barrier probably is not needed when the patch is being
> > > > > 	 * disabled. The patch is removed from the stack in
> > > > > 	 * klp_try_complete_transition() and there we need to call
> > > > > 	 * rcu_synchronize() to prevent seeing the patch on the stack
> > > > > 	 * at all.
> > > > > 	 *
> > > > > 	 * Well, it still might be needed to see func->transition
> > > > > 	 * when the patch is removed and the task is migrated. See
> > > > > 	 * the write barrier in __klp_disable_patch().
> > > > 
> > > > Agreed, though as you mentioned earlier, there's also the implicit
> > > > barrier in klp_update_patch_state(), which would execute first in such a
> > > > scenario.  So I think I'll update the barrier comments in
> > > > klp_update_patch_state().
> > > 
> > > You inspired me to a scenario with 3 CPUs:
> > > 
> > > CPU0			CPU1			CPU2
> > > 
> > > __klp_disable_patch()
> > > 
> > >   klp_init_transition()
> > > 
> > >     func->transition = true
> > > 
> > >   smp_wmb()
> > > 
> > >   klp_start_transition()
> > > 
> > >     set TIF_PATCH_PATCHPENDING
> > > 
> > > 			klp_update_patch_state()
> > > 
> > > 			  task->patch_state
> > > 			     = KLP_UNPATCHED
> > > 
> > > 			  smp_mb()
> > > 
> > > 						klp_ftrace_handler()
> > > 						  func = list_...
> > > 
> > > 						  smp_rmb() /*needed?*/
> > > 
> > > 						  if (func->transition)
> > > 
> > 
> > I think this isn't possible.  Remember the comment I added to
> > klp_update_patch_state():
> > 
> >  * NOTE: If task is not 'current', the caller must ensure the task is inactive.
> >  * Otherwise klp_ftrace_handler() might read the wrong 'patch_state' value.
> > 
> > Right now klp_update_patch_state() is only called for current.
> > klp_ftrace_handler() on CPU2 would be running in the context of a
> > different task.
> 
> I agree that it is impossible with the current code. In fact, I cannot
> imagine a way to migrate the task where the barrier would be needed.
> The question if we could/should somehow document it. Something like
> 
> 	* The barrier is not really needed when the patch is being
> 	* disabled. The value of func->transition would change
> 	* the result of this handled only after the task is migrated.
> 	* But the conditions for the migration are very limited
> 	* and practically include a full barrier, see
> 	* klp_update_patch_state().

Well, I'd like to avoid over-commenting this issue.  For v5 I've added
the following comment to klp_update_patch_state() -- see #2:

	/*
	 * This test_and_clear_tsk_thread_flag() call also serves as a read
	 * barrier (smp_rmb) for two cases:
	 *
	 * 1) Enforce the order of the TIF_PATCH_PENDING read and the
	 *    klp_target_state read.  The corresponding write barrier is in
	 *    klp_init_transition().
	 *
	 * 2) Enforce the order of the TIF_PATCH_PENDING read and a future read
	 *    of func->transition, if klp_ftrace_handler() is called later on
	 *    the same CPU.  See __klp_disable_patch().
	 */

Is that sufficient?  If not, I could maybe add another related comment
in klp_ftrace_handler() which refers to this comment.

-- 
Josh
