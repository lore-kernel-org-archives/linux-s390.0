Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 19 Jul 2018 12:39:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v14 24/25] sched: early boot clock
Message-ID: <20180719103903.GB2494@hirez.programming.kicks-ass.net>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-25-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718022211.6259-25-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 17, 2018 at 10:22:10PM -0400, Pavel Tatashin wrote:

> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index 0e9dbb2d9aea..7a8a63b940ee 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -202,7 +202,15 @@ static void __sched_clock_gtod_offset(void)
>  
>  void __init sched_clock_init(void)
>  {
> +	unsigned long flags;
> +
>  	sched_clock_running = 1;
> +
> +	/* Adjust __gtod_offset for contigious transition from early clock */
> +	local_irq_save(flags);
> +	sched_clock_tick();
> +	local_irq_restore(flags);
> +	__sched_clock_gtod_offset();

I think we want to keep __sched_clock_gtod_offset() inside the IRQ
disabled region.

And I just looked at my patch:

  https://lkml.kernel.org/r/20180626090003.GA2458@hirez.programming.kicks-ass.net

and that had a comment about how we wanted to set the gtod offset
_before_ setting sched_clock_running, yet here you do it the other way
around. Hmm?

>  }
>  /*
>   * We run this as late_initcall() such that it runs after all built-in drivers,
> @@ -356,7 +364,7 @@ u64 sched_clock_cpu(int cpu)
>  		return sched_clock() + __sched_clock_offset;
>  
>  	if (unlikely(!sched_clock_running))
> -		return 0ull;
> +		return sched_clock();
>  
>  	preempt_disable_notrace();
>  	scd = cpu_sdc(cpu);
