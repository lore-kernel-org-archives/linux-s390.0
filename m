Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Nov 2020 12:39:37 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201120123937.GC2328@C02TD0UTHF1T.local>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120114925.594122626@infradead.org>
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org, will@kernel.org, svens@linux.ibm.com, linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> We call arch_cpu_idle() with RCU disabled, but then use
> local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> 
> Switch all arch_cpu_idle() implementations to use
> raw_local_irq_{en,dis}able() and carefully manage the
> lockdep,rcu,tracing state like we do in entry.
> 
> (XXX: we really should change arch_cpu_idle() to not return with
> interrupts enabled)
> 
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

[...]

>  void arch_cpu_idle_prepare(void)
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -126,7 +126,7 @@ void arch_cpu_idle(void)
>  	 * tricks
>  	 */
>  	cpu_do_idle();
> -	local_irq_enable();
> +	raw_local_irq_enable();
>  }

Prior to this patch, I could see the above causing calls to
trace_hardirqs_on() while RCU wasn't watching, with a local patch
hacking RCU_LOCKDEP_WARN(!rcu_is_watching(), ...) into
trace_hardirqs_{on,off}() to make that obvious.

With this patch applied, that splat is gone. We still have a latent
issue on arm64 becuase our IRQ entry path calls trace_hardirqs_on(), and
we can take an interrupt before the idle code calls rcu_idle_exit().
IIUC the right thing to do is something like the generic entry code's
irqentry_{enter,exit}().

I suspect other architectures are in the same bucket w.r.t. that latent
issue, and it'd be nicer for those in that bucket if we could avoid
taking the interrupt while RCU isn't watching, but this is certainly
better than before.

> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -78,7 +78,7 @@ void __weak arch_cpu_idle_dead(void) { }
>  void __weak arch_cpu_idle(void)
>  {
>  	cpu_idle_force_poll = 1;
> -	local_irq_enable();
> +	raw_local_irq_enable();
>  }
>  
>  /**
> @@ -94,9 +94,35 @@ void __cpuidle default_idle_call(void)
>  
>  		trace_cpu_idle(1, smp_processor_id());
>  		stop_critical_timings();
> +
> +		/*
> +		 * arch_cpu_idle() is supposed to enable IRQs, however
> +		 * we can't do that because of RCU and tracing.
> +		 *
> +		 * Trace IRQs enable here, then switch off RCU, and have
> +		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
> +		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
> +		 * last -- this is very similar to the entry code.
> +		 */
> +		trace_hardirqs_on_prepare();
> +		lockdep_hardirqs_on_prepare(_THIS_IP_);
>  		rcu_idle_enter();
> +		lockdep_hardirqs_on(_THIS_IP_);
> +
>  		arch_cpu_idle();
> +
> +		/*
> +		 * OK, so IRQs are enabled here, but RCU needs them disabled to
> +		 * turn itself back on.. funny thing is that disabling IRQs
> +		 * will cause tracing, which needs RCU. Jump through hoops to
> +		 * make it 'work'.
> +		 */
> +		raw_local_irq_disable();
> +		lockdep_hardirqs_off(_THIS_IP_);
>  		rcu_idle_exit();
> +		lockdep_hardirqs_on(_THIS_IP_);
> +		raw_local_irq_enable();
> +
>  		start_critical_timings();
>  		trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());

FWIW looks good to me, so:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
