Return-Path: <jpoimboe@redhat.com>
Date: Thu, 26 Jan 2017 11:57:44 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v4 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20170126175744.gv3ttlg52axuq57c@treble>
References: <cover.1484839971.git.jpoimboe@redhat.com>
 <dfe1419dc06f37e1f4aec5bf81d5b60e505a8d0f.1484839971.git.jpoimboe@redhat.com>
 <20170126135603.GD27517@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170126135603.GD27517@pathway.suse.cz>
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

On Thu, Jan 26, 2017 at 02:56:03PM +0100, Petr Mladek wrote:
> On Thu 2017-01-19 09:46:09, Josh Poimboeuf wrote:
> > For live patching and possibly other use cases, a stack trace is only
> > useful if it can be assured that it's completely reliable.  Add a new
> > save_stack_trace_tsk_reliable() function to achieve that.
> 
> > diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> > index 0653788..fc36842 100644
> > --- a/arch/x86/kernel/stacktrace.c
> > +++ b/arch/x86/kernel/stacktrace.c
> > @@ -74,6 +74,90 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
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
> > +			 * Kernel mode registers on the stack indicate an
> > +			 * in-kernel interrupt or exception (e.g., preemption
> > +			 * or a page fault), which can make frame pointers
> > +			 * unreliable.
> > +			 */
> > +			if (!user_mode(regs))
> > +				return -1;
> > +
> > +			/*
> > +			 * The last frame contains the user mode syscall
> > +			 * pt_regs.  Skip it and finish the unwind.
> > +			 */
> > +			unwind_next_frame(&state);
> > +			if (WARN_ON_ONCE(!unwind_done(&state))) {
> > +				show_stack(task, NULL);
> 
> We should make sure that show_stack() is called only once as well.
> Otherwise, it would fill logbuffer with random stacktraces without
> any context. It might easily cause flood of messages and the first
> useful one might get lost in the ring buffer.

Agreed.

> > +				return -1;
> > +			}
> > +			break;
> > +		}
> > +
> > +		addr = unwind_get_return_address(&state);
> > +
> > +		/*
> > +		 * A NULL or invalid return address probably means there's some
> > +		 * generated code which __kernel_text_address() doesn't know
> > +		 * about.
> > +		 */
> > +		if (WARN_ON_ONCE(!addr)) {
> > +			show_stack(task, NULL);
> 
> Same here.
> 
> > +			return -1;
> > +		}
> > +
> > +		if (save_stack_address(trace, addr, false))
> > +			return -1;
> > +	}
> > +
> > +	/* Check for stack corruption */
> > +	if (WARN_ON_ONCE(unwind_error(&state))) {
> > +		show_stack(task, NULL);
> 
> And here.
> 
> > +		return -1;
> > +	}
> > +
> > +	if (trace->nr_entries < trace->max_entries)
> > +		trace->entries[trace->nr_entries++] = ULONG_MAX;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * This function returns an error if it detects any unreliable features of the
> > + * stack.  Otherwise it guarantees that the stack trace is reliable.
> > + *
> > + * If the task is not 'current', the caller *must* ensure the task is inactive.
> > + */
> > +int save_stack_trace_tsk_reliable(struct task_struct *tsk,
> > +				  struct stack_trace *trace)
> > +{
> > +	int ret;
> > +
> > +	if (!try_get_task_stack(tsk))
> > +		return -EINVAL;
> > +
> > +	ret = __save_stack_trace_reliable(trace, tsk);
> 
> __save_stack_trace_reliable() returns -1 in case of problems.
> But this function returns a meaningful error codes, line -EINVAL,
> -ENOSYS, otherwise.
> 
> We should either transform the error code here to something
> "meaningful", probably -EINVAL. Or we should update
> __save_stack_trace_reliable() to return meaningful error codes.

Agreed.

> > +	put_task_stack(tsk);
> > +
> > +	return ret;
> > +}
> > +#endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
> > +
> >  /* Userspace stacktrace - based on kernel/trace/trace_sysprof.c */
> >  
> >  struct stack_frame_user {
> 
> Otherwise, all the logic looks fine to me. Great work!

Thanks!

-- 
Josh
