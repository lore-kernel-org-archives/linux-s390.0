Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 17:49:18 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390:ftrace: add save_stack_trace_regs()
Message-ID: <20160129164917.GF3896@osiris>
References: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
 <20160129085447.GA3896@osiris>
 <20160129125749.GD3896@osiris>
 <20160129085936.09458371@gandalf.local.home>
 <20160129144522.GE3896@osiris>
 <20160129102241.1b3c9c04@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160129102241.1b3c9c04@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Pratyush Anand <panand@redhat.com>, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 29, 2016 at 10:22:41AM -0500, Steven Rostedt wrote:
> > No, that doesn't fix it (current Linus' master):
> > 
> > # uname -a
> > Linux p2345007 4.5.0-rc1-00032-g26cd83670f2f #26 SMP Fri Jan 29 15:39:47 CET 2016 s390x s390x s390x GNU/Linux
> > 
> > # cat stack_max_size 
> > 4496
> > 
> > # cat stack_trace
> >         Depth    Size   Location    (0 entries)
> >         -----    ----   --------
> 
> Ah this stack trace. This is different than what Pratyush Anand is
> fixing. This is the stack tracer which uses function tracing. The other
> fix is to deal with stack traces from events, specifically kprobes. As
> he stated, you test with:
> 
> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
> # echo "p kfree" >> /sys/kernel/debug/tracing/kprobe_events
> # echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable

Yes, I was aware of that, however the output of the trace file looked like
this:

            bash-1516  [003] d.s.    44.002233: p_kfree_0: (kfree+0x0/0x1a8)
            bash-1516  [003] d.s.    44.002233: <stack trace>
            bash-1540  [000] d...    44.002335: p_kfree_0: (kfree+0x0/0x1a8)
            bash-1540  [000] d...    44.002336: <stack trace>
            bash-1540  [000] d...    44.002338: p_kfree_0: (kfree+0x0/0x1a8)
            bash-1540  [000] d...    44.002338: <stack trace>

Which made me check the stack tracer which did not work anymore.

> But anyway, I'm curious, does this fix the issue for you?
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index dda9e6742950..db1c26c385c7 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -125,6 +125,9 @@ check_stack(unsigned long ip, unsigned long *stack)
>  			break;
>  	}
> 
> +	if (i == stack_trace_max.nr_entries)
> +		i = 0;
> +

With this patch the trace file now contains:

            bash-1543  [001] d...    31.273255: p_kfree_0: (kfree+0x0/0x1c0)
            bash-1543  [001] d...    31.273256: <stack trace>
 => pipe_release
 => __fput
 => task_work_run
 => do_notify_resume
 => system_call
            bash-1543  [001] d...    31.273400: p_kfree_0: (kfree+0x0/0x1c0)
            bash-1543  [001] d...    31.273400: <stack trace>
 => load_elf_binary
 => search_binary_handler
 => do_execveat_common.isra.14
 => SyS_execve
 => system_call

Which looks much better. The stack tracer also works again!

If the above is supposed to be the final fix, please feel free to add

Tested-by: Heiko Carstens <heiko.carstens@de.ibm.com>

Thanks a lot, Steven!
