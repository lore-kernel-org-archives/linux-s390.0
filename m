Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jan 2016 09:54:47 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390:ftrace: add save_stack_trace_regs()
Message-ID: <20160129085447.GA3896@osiris>
References: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86d380d172bba0416aef64448b0e1b6a50fad326.1454044645.git.panand@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pratyush Anand <panand@redhat.com>
Cc: schwidefsky@de.ibm.com, rostedt@goodmis.org, linux-s390@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>, open list <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 29, 2016 at 10:50:28AM +0530, Pratyush Anand wrote:
> Implement save_stack_trace_regs, so that stacktrace of a kprobe events can
> be obtained.
> 
> Without this we see following warning:
> "save_stack_trace_regs() not implemented yet."
> when we execute:
> echo stacktrace > /sys/kernel/debug/tracing/trace_options
> echo "p kfree" >> /sys/kernel/debug/tracing/kprobe_events
> echo 1 > /sys/kernel/debug/tracing/events/kprobes/enable
> 
> Reported-by: Chunyu Hu <chuhu@redhat.com>
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  arch/s390/kernel/stacktrace.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
> index 1785cd82253c..586da400f931 100644
> --- a/arch/s390/kernel/stacktrace.c
> +++ b/arch/s390/kernel/stacktrace.c
> @@ -94,3 +94,16 @@ void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
>  		trace->entries[trace->nr_entries++] = ULONG_MAX;
>  }
>  EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
> +
> +void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
> +{
> +	unsigned long sp, low, high;
> +
> +	sp = kernel_stack_pointer(regs);
> +	low = (unsigned long) task_stack_page(current);
> +	high = (unsigned long) task_pt_regs(current);
> +	save_context_stack(trace, sp, low, high, 0);
> +	if (trace->nr_entries < trace->max_entries)
> +		trace->entries[trace->nr_entries++] = ULONG_MAX;
> +}
> +EXPORT_SYMBOL_GPL(save_stack_trace_regs);

Thanks. I just figured out that the ftrace stack tracer doesn't work at all
anymore on s390.  I will apply your patch after I fixed that. ;)
