From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 28 Jul 2010 09:07:14 +0000
Subject: Re: [patch 2/3] S390-HWBKPT v5: Enabling s390 kernel for kernel
Message-Id: <20100728090714.GB3020@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20100527034301.GC6404@in.ibm.com>
References: <20100527034301.GC6404@in.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 27, 2010 at 09:13:01AM +0530, Mahesh Salgaonkar wrote:
> --- a/arch/s390/kernel/hw_breakpoint.c
> +++ b/arch/s390/kernel/hw_breakpoint.c
> @@ -82,6 +82,19 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  	per_regs[0].starting_addr = info->address;
>  	per_regs[0].ending_addr = info->address + info->len - 1;
> 
> +	if (!bp->attr.exclude_kernel
> +		&& per_regs[0].em_storage_alteration) {
> +		/* For kernel wide breakpoints the Storage-Alteration-Space
> +		 * Control bit as well as the Storage-Alternation-Event bit
> +		 * in the ASCE needs to be set. Otherwise we might end up
> +		 * tracing copy_to_user events as well.
> +		 */
> +		per_regs[0].storage_alt_space_ctl = 1;
> +		__ctl_set_bit(1, 7);
> +		__ctl_set_bit(7, 7);
> +		__ctl_set_bit(13, 7);
> +	}

If !exclude_kernel has the same meaning as "only_kernel" then this could work
if the Storage-Alteration-Event would only be set in the kernel space ASCE.

The corresponding bit in the user space ASCE would be lost on next context
switch. But since that is hopefully irrelevant that shouldn't be a problem.
