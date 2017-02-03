Return-Path: <mbenes@suse.cz>
Date: Fri, 3 Feb 2017 17:21:41 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 13/15] livepatch: change to a per-task consistency model
In-Reply-To: <20170202115116.GB23754@pathway.suse.cz>
Message-ID: <alpine.LSU.2.20.1702031711120.28531@pobox.suse.cz>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <62e96e43de6f09e16f36d3d51af766c8fcbbb05f.1484839971.git.jpoimboe@redhat.com>
 <20170202115116.GB23754@pathway.suse.cz>
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
To: Petr Mladek <pmladek@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2 Feb 2017, Petr Mladek wrote:

> > diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> > index 7f04e13..fb00d66 100644
> > --- a/Documentation/livepatch/livepatch.txt
> > +++ b/Documentation/livepatch/livepatch.txt
> 
> > +  In that case, arches without
> > +   HAVE_RELIABLE_STACKTRACE would still be able to use the
> > +   non-stack-checking parts of the consistency model:
> > +
> > +   a) patching user tasks when they cross the kernel/user space
> > +      boundary; and
> > +
> > +   b) patching kthreads and idle tasks at their designated patch points.
> > +
> > +   This option isn't as good as option 1 because it requires signaling
> > +   most of the tasks to patch them.
> 
> Kthreads need to be waken because most of them ignore signals.
> 
> And idle tasks might need to be explicitely scheduled if there
> is too big load. Mirek knows more about this.

Yes, and we've already discussed it with Josh. The plan is not to do 
anything now, because described situations should be rare and/or 
theoretical only. It should be on our TODO lists though.
 
> Well, I am not sure if you want to get into such details.

I would not bother about it.
 
[...]

> > +/*
> > + * Start the transition to the specified target patch state so tasks can begin
> > + * switching to it.
> > + */
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
> 
> We should call klp_try_complete_transition() here. Otherwise, it will
> never be called and the transition will never get completed.
> 
> Alternative solution would be to move klp_try_complete_transition()
> from klp_start_transition() and explicitely call it from
> __klp_disable_patch() and klp_enable_patch(). It would actually
> solve one issue with klp_revert_patch(), see below.
> 
> I kind of like the alternative solution. I hope that it was not
> me who suggested to move klp_try_complete_transition() into
> klp_start_transtion().

[...]

> Hmm, we should not call klp_try_complete_transition() when
> klp_start_transition() is called from here. I can't find a safe
> way to cancel klp_transition_work() when we own klp_mutex.
> It smells with a possible deadlock.
> 
> I suggest to move move klp_try_complete_transition() outside
> klp_start_transition() and explicitely call it from
>  __klp_disable_patch() and __klp_enabled_patch().
> This would fix also the problem with immediate patches, see
> klp_start_transition().

I agree. I think the best would be to move klp_try_complete_transition() 
out from klp_start_transition() and call it explicitly. This would solve 
the immediate problem for free.

I agree we should not call klp_try_complete_transition() from 
klp_reverse_transition() and leave it entirely to our delayed work. We 
discussed this in the past and the counter argument was that explicit call 
to klp_try_complete_transition() could make the process a bit faster. 
Possibly true, but reversion is really slow path and I would not care 
about speed at all. I think it is cleaner and perhaps safer.

Thanks,
Miroslav
