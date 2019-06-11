Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:33672 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbfFKJP4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Jun 2019 05:15:56 -0400
Date: Tue, 11 Jun 2019 11:15:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH/RFC 2/3] s390: improve wait logic of stop_machine
Message-ID: <20190611091546.GV3436@hirez.programming.kicks-ass.net>
References: <20190608110853.35961-1-heiko.carstens@de.ibm.com>
 <20190608110853.35961-3-heiko.carstens@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190608110853.35961-3-heiko.carstens@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org

On Sat, Jun 08, 2019 at 01:08:52PM +0200, Heiko Carstens wrote:
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -31,6 +31,7 @@ struct cpu_info {
>  };
>  
>  static DEFINE_PER_CPU(struct cpu_info, cpu_info);
> +static DEFINE_PER_CPU(int, cpu_relax_retry);
>  
>  static bool machine_has_cpu_mhz;
>  
> @@ -58,13 +59,21 @@ void s390_update_cpu_mhz(void)
>  		on_each_cpu(update_cpu_mhz, NULL, 0);
>  }
>  
> +void notrace cpu_relax_yield(const struct cpumask *cpumask)
>  {
> +	int cpu;
> +
> +	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
> +		__this_cpu_write(cpu_relax_retry, 0);

I don't mind, but do we really need a per-cpu variable for this? Does it
really matter if you spin on a stack variable and occasionally spin a
bit longer due to the missed tail of the previous spin?

> +		cpu = cpumask_next(smp_processor_id(), cpumask);
> +		if (cpu >= nr_cpu_ids) {
> +			cpu = cpumask_first(cpumask);
> +			if (cpu == smp_processor_id())
> +				return;

If this function is passed an empty cpumask, the above will result in
'cpu == nr_cpu_ids' and the below might be unhappy with that.

(FWIW we do have cpumask_next_wrap(), but I admit it is somewhat awkward
to use)

> +		}
> +		if (arch_vcpu_is_preempted(cpu))
> +			smp_yield_cpu(cpu);
>  	}
>  }
>  EXPORT_SYMBOL(cpu_relax_yield);
