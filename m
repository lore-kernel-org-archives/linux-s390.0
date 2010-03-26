From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 26 Mar 2010 23:15:50 +0000
Subject: Re: [patch 3/3] S390-HWBKPT v4: Modify ptrace to use Hardware
Message-Id: <20100326231548.GH7166@nowhere>
In-Reply-To: <20100203063932.GD17281@in.ibm.com>
References: <20100203063932.GD17281@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 03, 2010 at 12:09:32PM +0530, Mahesh Salgaonkar wrote:
> +static void ptrace_triggered(struct perf_event *bp, int nmi,
> +			     struct perf_sample_data *data,
> +			     struct pt_regs *regs)
> +{
> +	struct thread_struct *thread = &(current->thread);
> +
> +	thread->ptrace_bps[0] = bp;
> +}



Hmm, I don't understand what happens here. You only set up the
thread->ptrace_bps here?

So if it never triggers it will never be freed? Also how do you
handle the signal?



> +
> +static void ptrace_set_breakpoint(struct task_struct *task, int disabled)
> +{
> +	per_struct *per_info;
> +	struct perf_event *bp;
> +	struct thread_struct *t = &task->thread;
> +	struct perf_event_attr attr;
> +
> +	hw_breakpoint_init(&attr);
> +	per_info = (per_struct *) &task->thread.per_info;
> +
> +	if (per_info->single_step | per_info->instruction_fetch)
> +		attr.bp_type = HW_BREAKPOINT_X;
> +	else if (per_info->storage_alteration)
> +		attr.bp_type = HW_BREAKPOINT_W;
> +	else {
> +		ptrace_remove_breakpoint(task);
> +		return;
> +	}
> +
> +	attr.disabled = disabled;
> +	attr.bp_addr = get_per_addr(per_info);
> +	attr.bp_len = get_per_len(per_info);
> +
> +	if (!t->ptrace_bps[0]) {
> +		bp = register_user_hw_breakpoint(&attr, ptrace_triggered, task);
> +		if (!IS_ERR(bp))
> +			t->ptrace_bps[0] = bp;



Hmm, and you actually set it up here before.
I'm not sure what's the point of doing the same in ptrace_triggered()
