Return-Path: <jpoimboe@redhat.com>
Date: Fri, 16 Dec 2016 16:09:47 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20161216220947.j7bzbttaqklqic37@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <0315b36c08c104d56a4b43537fb300d200418996.1481220077.git.jpoimboe@redhat.com>
 <20161216130739.GB393@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20161216130739.GB393@pathway.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Petr Mladek <pmladek@suse.com>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Dec 16, 2016 at 02:07:39PM +0100, Petr Mladek wrote:
> On Thu 2016-12-08 12:08:26, Josh Poimboeuf wrote:
> > For live patching and possibly other use cases, a stack trace is only
> > useful if it can be assured that it's completely reliable.  Add a new
> > save_stack_trace_tsk_reliable() function to achieve that.
> > 
> > Scenarios which indicate that a stack trace may be unreliable:
> > 
> > - running task
> 
> It seems that this has to be enforced by save_stack_trace_tsk_reliable()
> caller. It should be mentioned in the function description.

Agreed.

> > - interrupt stack
> 
> I guess that it is detected by saved regs on the stack. And it covers
> also dynamic changes like kprobes. Do I get it correctly, please? 

Right.

> What about ftrace? Is ftrace without regs safe and detected?

Yes, it's safe because the mcount code does the right thing with respect
to frame pointers.  See save_mcount_regs().

> > - preemption
> 
> I wonder if some very active kthreads might almost always be
> preempted using irq in preemptive kernel. Then they block
> the conversion with the non-reliable stacks. Have you noticed
> such problems, please?

I haven't seen such a case and I think it would be quite rare for a
kthread to be CPU-bound like that.

> > - corrupted stack data
> > - stack grows the wrong way
> 
> This is detected in unwind_next_frame() and passed via state->error.
> Am I right?

Right.  I'll add more details to the commit message for all of these.
> 
> 
> > - stack walk doesn't reach the bottom
> > - user didn't provide a large enough entries array
> > 
> > Also add CONFIG_HAVE_RELIABLE_STACKTRACE so arch-independent code can
> > determine at build time whether the function is implemented.
> > 
> > diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> > index 0653788..3e0cf5e 100644
> > --- a/arch/x86/kernel/stacktrace.c
> > +++ b/arch/x86/kernel/stacktrace.c
> > @@ -74,6 +74,64 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
> >  }
> >  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
> >  
> > +#ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
> > +static int __save_stack_trace_reliable(struct stack_trace *trace,
> > +				       struct task_struct *task)
> > +{
> > +	struct unwind_state state;
> > +	struct pt_regs *regs;
> > +	unsigned long addr;
> > +
> > +	for (unwind_start(&state, task, NULL, NULL); !unwind_done(&state);
> > +	     unwind_next_frame(&state)) {
> > +
> > +		regs = unwind_get_entry_regs(&state);
> > +		if (regs) {
> > +			/*
> > +			 * Preemption and page faults on the stack can make
> > +			 * frame pointers unreliable.
> > +			 */
> > +			if (!user_mode(regs))
> > +				return -1;
> 
> By other words, it we find regs on the stack, it almost always mean
> a non-reliable stack. The only exception is when we are in the
> userspace mode. Do I get it correctly, please?

Right.

> > +
> > +			/*
> > +			 * This frame contains the (user mode) pt_regs at the
> > +			 * end of the stack.  Finish the unwind.
> > +			 */
> > +			unwind_next_frame(&state);
> > +			break;
> > +		}
> > +
> > +		addr = unwind_get_return_address(&state);
> > +		if (!addr || save_stack_address(trace, addr, false))
> > +			return -1;
> > +	}
> > +
> > +	if (!unwind_done(&state) || unwind_error(&state))
> > +		return -1;
> > +
> > +	if (trace->nr_entries < trace->max_entries)
> > +		trace->entries[trace->nr_entries++] = ULONG_MAX;
> > +
> > +	return 0;
> > +}
> 
> Great work! I am surprised that it looks so straightforward.
> 
> I still have to think and investigate it more. But it looks
> very promissing.
> 
> Best Regards,
> Petr

-- 
Josh
