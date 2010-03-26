From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Fri, 26 Mar 2010 23:04:58 +0000
Subject: Re: [patch 1/3] S390-HWBKPT v4:S390 architecture specific Hardware
Message-Id: <20100326230456.GG7166@nowhere>
In-Reply-To: <20100203063903.GB17281@in.ibm.com>
References: <20100203063903.GB17281@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Sorry for the late review :-(


On Wed, Feb 03, 2010 at 12:09:03PM +0530, Mahesh Salgaonkar wrote:
> +int arch_install_hw_breakpoint(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	struct perf_event **slot;
> +	struct task_struct *tsk = bp->ctx->task;
> +	per_cr_bits per_regs[1];
> +
> +	memset(per_regs, 0, sizeof(per_cr_bits));
> +
> +	slot = &__get_cpu_var(bp_per_reg[0]);
> +	if (!*slot) {
> +		*slot = bp;
> +	} else {
> +		WARN_ONCE(1 , "Can't find any breakpoint slot");
> +		return -EBUSY;
> +	}
> +
> +	if (info->type == S390_BREAKPOINT_WRITE)
> +		per_regs[0].em_storage_alteration = 1;
> +	if (info->type == S390_BREAKPOINT_EXECUTE)
> +		per_regs[0].em_instruction_fetch = 1;
> +	per_regs[0].starting_addr = info->address;
> +	per_regs[0].ending_addr = info->address + info->len - 1;
> +
> +	/* Load the control register 9, 10 and 11 with per info */
> +	__ctl_load(per_regs, 9, 11);
> +	__get_cpu_var(cpu_per_regs[0]) = per_regs[0];
> +
> +	if (((per_cr_words *)per_regs)->cr[0] & PER_EM_MASK) {
> +		if (!tsk) {
> +			/* wide breakpoint in the kernel */
> +			/* FIXME:
> +			 * It's not good idea to use existing flag in lowcore
> +			 * for turning on/off PER tracing in kernel. instead
> +			 * define a new flag and handle PER tracing checks in
> +			 * entry*.S
> +			 */
> +
> +
> +			/* set PER bit int psw_kernel_bits to avoid loosing it
> +			 * accidently if someone modifies PSW bit directly.
> +			 */
> +			psw_kernel_bits |= PSW_MASK_PER;
> +
> +		} else {
> +			/* user-space hardware breakpoint */
> +			struct pt_regs *regs = task_pt_regs(tsk);
> +
> +			regs->psw.mask |= PSW_MASK_PER;



That doesn't look right. You may want to setup a breakpoint in the kernel
that only triggers in a given task context. Your approach only allows
breakpoints in userspace if it is bound to a task context.



> +static inline int is_kernel(unsigned long addr)
> +{
> +	if (addr >= (unsigned long)_stext && addr < (unsigned long)_end)
> +		return 1;
> +	return in_gate_area_no_task(addr);
> +}



We have a kernel_text_address() already, it also handles modules.



> +/*
> + * Store a breakpoint's encoded address, length, and type.
> + */
> +static int arch_store_info(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	/*
> +	 * For kernel-addresses, either the address or symbol name can be
> +	 * specified.
> +	 */
> +	if (info->name)
> +		info->address = kallsyms_lookup_name(info->name);



We don't need the name anymore. Name to addr resolving is done in the
generic code now. You can remove the info->name field.



> +/*
> + * Populate arch specific bp info. s390 arch supports EXECUTE and WRITE
> + * access types.
> + */
> +static int arch_build_bp_info(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +
> +	info->address = bp->attr.bp_addr;
> +	info->len = bp->attr.bp_len;
> +
> +	switch (bp->attr.bp_type) {
> +	case HW_BREAKPOINT_W:
> +		info->type = S390_BREAKPOINT_WRITE;
> +		break;
> +	case HW_BREAKPOINT_X:
> +		info->type = S390_BREAKPOINT_EXECUTE;
> +		if (info->len == 0)
> +			info->len = 1;
> +		break;
> +	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:



You can drop the above as you'd fall down to default anyway.



> +/*
> + * Validate the arch-specific HW Breakpoint register settings
> + */
> +int arch_validate_hwbkpt_settings(struct perf_event *bp,
> +					struct task_struct *tsk)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	int ret;
> +
> +	ret = arch_build_bp_info(bp);
> +	if (ret)
> +		return ret;
> +
> +	ret = arch_store_info(bp);
> +
> +	if (ret)
> +		return ret;
> +
> +	/* Check that the virtual address is in the proper range */
> +	if (tsk) {
> +		/* user space. */
> +		if (!access_ok(VERIFY_WRITE,
> +				(void __user *)info->address, info->len - 1))




Seems like access_ok() is a noop is S390. But even if the breakpoint is
task bound, it should be able to trigger everywhere.



> +			return -EFAULT;
> +	} else {
> +		if (!arch_check_va_in_kernelspace(info->address, info->len))
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Release the user breakpoints used by ptrace
> + */
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> +{
> +	struct thread_struct *t = &tsk->thread;
> +
> +	unregister_hw_breakpoint(t->ptrace_bps[0]);
> +	t->ptrace_bps[0] = NULL;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +static int __kprobes hw_breakpoint_handler(struct die_args *args)
> +{
> +	struct perf_event *bp;
> +	per_cr_bits saved_cregs[1];
> +	per_cr_bits per_regs[1];
> +	per_lowcore_bits *per_code;
> +	int cpu, rc = NOTIFY_STOP;
> +	struct pt_regs *regs = args->regs;
> +
> +	/* Do an early return if this is not a storage-alteration/instruction
> +	 * fetch event.
> +	 *
> +	 * We may be racing with interrupts by the time we reach here. Check
> +	 * if old psw was a kernel/user space. If user space then PER code
> +	 * is copied to thread_struct, otherwise it is in lowcore.
> +	 */
> +	if (regs->psw.mask & PSW_MASK_PSTATE)
> +		per_code = &current->thread.per_info.lowcore.bits;
> +	else
> +		per_code = (per_lowcore_bits *)&S390_lowcore.per_perc_atmid;
> +
> +	if ((!per_code->perc_storage_alteration &&
> +			!per_code->perc_instruction_fetch) ||
> +		(per_code->perc_storage_alteration &&
> +			per_code->perc_store_real_address))
> +		return NOTIFY_DONE;
> +
> +	/* Disable breakpoints during exception handling */
> +	__ctl_store(saved_cregs, 9, 11);
> +	memset(per_regs, 0, sizeof(per_cr_bits));
> +	__ctl_load(per_regs, 9, 11);
> +
> +	cpu = get_cpu();
> +
> +	/*
> +	 * The counter may be concurrently released but that can only
> +	 * occur from a call_rcu() path. We can then safely fetch
> +	 * the breakpoint, use its callback, touch its counter
> +	 * while we are in an rcu_read_lock() path.
> +	 */
> +
> +	rcu_read_lock();
> +	bp = per_cpu(bp_per_reg[0], cpu);



This could be get_cpu_var(), more simply.



> +	/*
> +	 * bp can be NULL due to lazy debug register switching
> +	 * or due to concurrent perf counter removing.
> +	 */
> +	if (bp)
> +		rc = NOTIFY_DONE;
> +
> +	perf_bp_event(bp, args->regs);
> +	rcu_read_unlock();
> +
> +	/* Enable breakpoints */
> +	__ctl_load(saved_cregs, 9, 11);
> +	put_cpu();
> +
> +	return rc;
> +}
>
> +void hw_breakpoint_pmu_unthrottle(struct perf_event *bp)
> +{
> +	/* TODO */
> +}



We have removed the need for this stub recently, you can check the
commit "1e259e0a9982078896f3404240096cbea01daca4"
(hw-breakpoints: Remove stub unthrottle callback)



> diff --git a/samples/hw_breakpoint/data_breakpoint.c b/samples/hw_breakpoint/data_breakpoint.c
> index c69cbe9..465ee4a 100644
> --- a/samples/hw_breakpoint/data_breakpoint.c
> +++ b/samples/hw_breakpoint/data_breakpoint.c
> @@ -58,7 +58,11 @@ static int __init hw_break_module_init(void)
>  	hw_breakpoint_init(&attr);
>  	attr.bp_addr = kallsyms_lookup_name(ksym_name);
>  	attr.bp_len = HW_BREAKPOINT_LEN_4;
> +#ifdef CONFIG_S390
> +	attr.bp_type = HW_BREAKPOINT_W;
> +#else



You can just keep HW_BREAKPOINT_W for everyone in this case.



>  	attr.bp_type = HW_BREAKPOINT_W | HW_BREAKPOINT_R;
> +#endif
>  
>  	sample_hbp = register_wide_hw_breakpoint(&attr, sample_hbp_handler);
>  	if (IS_ERR(sample_hbp)) {
> 


Thanks.
