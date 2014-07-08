Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 8 Jul 2014 10:07:40 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390: add support for DYNAMIC_FTRACE_WITH_REGS
Message-ID: <20140708080740.GA4491@osiris>
References: <20140703120046.GA10664@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140703120046.GA10664@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>, Jiri Slaby <jslaby@suse.cz>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 03, 2014 at 02:00:46PM +0200, Vojtech Pavlik wrote:
> Add support for DYNAMIC_FTRACE_WITH_REGS to 64-bit and 31-bit s390
> architectures. This is required for kGraft and kpatch to work on s390.
> 
> It's done by adding a _regs variant of ftrace_caller that preserves
> registers and puts them on stack in a struct pt_regs layout and
> allows modification of return address by changing the PSW (instruction
> pointer) member od struct pt_regs. 
>
> Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
> Reviewed-by: Jiri Kosina <jkosina@suse.cz>
> Cc: Steven Rostedt <rostedt@goodmis.org>

So I assume you use the instruction_pointer() macro to access the
return address then?

All of this seems a bit of a hack to me.. the natural place of the
return address of a function would be register 14, and not the
psw member of the pt_regs structure.

It's then also inconsistent to only save register r0-r13 to the
gprs member.. well, you can't save r14, since what should
happen if both r14 in the gprs member of pt_regs and in the psw
part would have been changed?

Besides that a couple more comments below.

> diff --git a/arch/s390/kernel/mcount64.S b/arch/s390/kernel/mcount64.S
> index 1c52eae..bcad958 100644
> --- a/arch/s390/kernel/mcount64.S
> +++ b/arch/s390/kernel/mcount64.S
> @@ -49,6 +49,44 @@ ENTRY(ftrace_graph_caller)
>  	lg	%r14,112(%r15)
>  	br	%r14
> 
> +#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +ENTRY(ftrace_regs_caller)
> +	larl	%r1,function_trace_stop
> +	icm	%r1,0xf,0(%r1)
> +	bnzr	%r14

The three lines above should go away, but that's not your problem, since
Steven is about to remove the function_trace_stop functionality.

> +	lgr	%r1,%r15
> +	aghi	%r15,-336
> +	stg	%r1,__SF_BACKCHAIN(%r15)
> +	stg	%r1,304(%r15)
> +	stmg	%r0,%r13,184(%r15)
> +	stg	%r14,176(%r15)
> +	lgr	%r2,%r14
> +	aghi	%r2,-MCOUNT_INSN_SIZE
> +	lg	%r3,344(%r15)
> +	stg	%r3,296(%r15)
> +	larl	%r4,function_trace_op
> +	lg	%r4,0(%r4)
> +	lgr	%r5, %r15
> +	aghi	%r5, 160
> +	larl	%r14,ftrace_trace_function
> +	lg	%r14,0(%r14)
> +	basr	%r14,%r14
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +	lg	%r2,344(%r15)
> +	lg	%r3,448(%r15)
> +ENTRY(ftrace_regs_graph_caller)
> +# The bras instruction gets runtime patched to call prepare_ftrace_return.
> +# See ftrace_enable_ftrace_graph_caller. The patched instruction is:
> +#	bras	%r14,prepare_ftrace_return
> +	bras	%r14,0f
> +0:	stg	%r2,344(%r15)
> +#endif
> +	lmg	%r0,%r13,184(%r15)
> +	lg	%r14,176(%r15)
> +	aghi	%r15,336
> +	br	%r14
> +#endif

Some objections: this code assumes that sizeof(struct pt_regs) does not
change, which is not correct. So as soon as we touch struct pt_regs this
code would be broken. Also the order of the members within struct pt_regs
is not necessarily static (pt_regs is not ABI).

So using the supplied asm-offsets.c offsets within the pt_regs structure
would be the way to go.

In addition I don't like the code duplication. This is nearly an identical
copy of ftrace_caller, except that it (partially) creates a pt_regs structure
on the stack. I'd rather change the existing ftrace_caller code to do that
unconditionally.

However, what I _really_ do not like is the odd usage of r14 to create
a malformed psw member within the pt_regs structure, and thus omitting r14
from the gprs array.
