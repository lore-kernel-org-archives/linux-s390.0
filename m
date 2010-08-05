From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 05 Aug 2010 15:18:51 +0000
Subject: Re: [patch 3/3] S390-HWBKPT v5: Modify ptrace to use Hardware
Message-Id: <20100805151851.GA2175@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20100527034421.GD6404@in.ibm.com>
References: <20100527034421.GD6404@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Mahesh,

On Thu, May 27, 2010 at 09:14:21AM +0530, Mahesh Salgaonkar wrote:

> index 9f654da..7393d34 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c

[...]

> +static void ptrace_set_breakpoint(struct task_struct *task, int disabled)
> +{
> +	per_struct *per_info;
> +	struct perf_event *bp;
> +	struct thread_struct *t = &task->thread;
> +	struct perf_event_attr attr;
> +
> +	ptrace_breakpoint_init(&attr);
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

Ok, this is supposed to convert the arch breakpoints to generic hw breakpoints,
but what about the other breakpoint types and breakpoint controls we have and
may use on s390? E.g. Successful-Branching event and its control bit?

We could encode that somehow into the bp_type field, however that are generic
breakpoint types. Considering that we only have 32 bits in there and that
s390 has some special breakpoint types like "Store-using-real-address event"
it would eat up a considerable amount of bits in there.
Other architectures would eat up even more bits.
Or a specific amount of bits could be reserved for architecture usage?
Too bad that the perf_event_attr structure is user space visible and can't
be extended so that we could add another arch specific field for defining
special arch breakpoint types.
At least that's how I read the current code.

> +static inline addr_t get_psw_mask(struct perf_event *bp)
> +{
> +	return bp->hw.info.type == HW_BREAKPOINT_X ? PER_INST_FETCH :
> +			(bp->hw.info.type == HW_BREAKPOINT_W ? PER_STG_ALT : 0);
> +}

get_per_mask() would be a more appropriate name. And the function is close to
unreadable. The following would be much more readable:

	if (bp->hw.info.type == HW_BREAKPOINT_X)
		return PER_INST_FETCH;
	if (bp->hw.info.type == HW_BREAKPOINT_W)
		return PER_STG_ALT;
	return 0;

But...

> +static addr_t ptrace_get_per_info(struct task_struct *child, addr_t offset)
> +{
> +	per_struct *dummy = NULL;
> +	addr_t tmp;
> +	struct thread_struct *thread = &(child->thread);
> +
> +	if (offset < (addr_t) (&dummy->control_regs + 1)) {
> +		struct perf_event *bp = thread->ptrace_bps[0];
> +
> +		if (!bp)
> +			return 0;
> +		else if (offset == 0)
> +			tmp = get_psw_mask(bp);

This changes the semantics of the ptrace interface: for example if the
ptrace caller would have set the Successful-branching event bit and
maybe in addition the Branch-Address Control bit it would be lost.
Not only that these bits wouldn't be returned to user space via the
PTRACE_PEEKUSR interface, it wouldn't be enabled and work at all anymore.

> + * Use hardware breakpoint interface for PER info.
> + */
> +static void ptrace_set_per_info(struct task_struct *child, addr_t offset,
> +								addr_t data)
> +{
> +	per_struct *dummy = NULL;
> +	int disabled = 0;
> +
> +	/*
> +	 * gdb tries to set the PER storage alteration bit in
> +	 * perf_info->control_regs. With hardware breakpoint interface
> +	 * in place, we do not want anything to be set in
> +	 * perf_info->control_regs. Instead we will store this info
> +	 * in per_info->storage_alteration. Hence make sure that any
> +	 * further writes from gdb does not wipe out
> +	 * per_info->storage_alteration info.
> +	 */
> +
> +	if (offset == (addr_t) &dummy->control_regs) {
> +		if (data & PER_STG_ALT)
> +			child->thread.per_info.storage_alteration = 1;
> +		else
> +			child->thread.per_info.storage_alteration = 0;
> +	} else if (offset == (addr_t) (&dummy->control_regs + 1)) {
> +		if (child->thread.per_info.storage_alteration) {
> +			*(addr_t *)((addr_t) &child->thread.per_info + offset)
> +									= data;
> +			child->thread.per_info.storage_alteration = 1;
> +		} else
> +			*(addr_t *)((addr_t) &child->thread.per_info + offset)
> +									= data;
> +	} else if (offset > (addr_t) (&dummy->control_regs + 1))
> +		*(addr_t *)((addr_t) &child->thread.per_info + offset) = data;

Now, this is really ugly code and hard to maintain if there would be a need
to extend it. We need to come up with something better.
