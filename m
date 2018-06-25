Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 25 Jun 2018 15:23:20 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625085543.GT2494@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Peter,

I have revisted this patch after modifying x86 sched_clock() to contigously
output tsc once it is setup early in boot, based on the latest suggestions
from Thomas.

On 18-06-25 10:55:43, Peter Zijlstra wrote:
> On Thu, Jun 21, 2018 at 05:25:17PM -0400, Pavel Tatashin wrote:
> > Allow sched_clock() to be used before schec_clock_init() and
> > sched_clock_init_late() are called. This provides us with a way to get
> > early boot timestamps on machines with unstable clocks.
> 
> There are !x86 architectures that use this code and might not expect to
> have their sched_clock() called quite that early. Please verify.
> 
> > +	local_irq_disable();
> > +	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
> > +	local_irq_enable();
> 
> This might work in sched_clock_init(), which is pre-SMP.
> 
> >  	sched_clock_running = 2;
> >  	/*
> >  	 * Ensure that it is impossible to not do a static_key update.
> > @@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
> >  	if (sched_clock_stable())
> >  		return sched_clock() + __sched_clock_offset;
> >  
> > -	if (unlikely(!sched_clock_running))
> > -		return 0ull;
> > +	/* Use early clock until sched_clock_init_late() */
> > +	if (unlikely(sched_clock_running < 2))
> > +		return sched_clock() + __sched_clock_offset;
> 
> And then this remains !sched_clock_running, except instead of 0, you
> then return sched_clock() + __sched_clock_offset;
> 
> >  	preempt_disable_notrace();
> >  	scd = cpu_sdc(cpu);

Unfortunatly the above suggestion won't work. And here is why.

We have a call sequence like this:

start_kernel
    sched_init()
        sched_clock_init()
	     In this call sched_clock_running is set to 1. Which means
	     that sched_clock_cpu() starts doing the following sequence:
	     scd = cpu_sdc(cpu);
	     clock = sched_clock_local(scd);
	     Where we try to filter the output of sched_clock() based
	     on the value of scd. But, that won't work, because to get
	     this functionality, we need to have: timer initialized
	     that wakes up and updates scd, and we need timekeeping
	     initialized, so we can call ktime_get_ns(). Both of which
	     are called later.
    ...
    timekeeping_init() After this we can call ktime_get_ns()
    time_init()  Here we configure x86_late_time_init pointer.
    ...
    late_time_init()
        x86_late_time_init()
            x86_init.timers.timer_init()
	        hpet_time_init() Only after this call we finally start
		getting clock interrupts, and can get precise output from
		sched_clock_local().

The way I solved the above, is I changed sched_clock() to keep outputing
time based on early boot sched_clock() until sched_clock_init_late(), at
whic point everything is configured and we can switch to the permanent
clock, eventhough this happens after smp init.

If you have a better solution, please let me know.

Thank you,
Pavel
