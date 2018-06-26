Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 26 Jun 2018 07:27:05 -0400
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Message-ID: <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com>
 <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain>
 <20180626090003.GA2458@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626090003.GA2458@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> 
> How's something like this? That moves sched_clock_init() to right before
> we enable IRQs for the first time (which is after we've started the
> whole timekeeping business).
> 
> The thing is, sched_clock_init_late() reall is far too late, we need to
> switch to unstable before we bring up SMP.

OK, sure.

> -	sched_clock_postinit();
> +	sched_clock_init();

Yes, we can move sched_clock_init(). But placing it after time_init() would
work on all arches with unstable clock except for x86.

See comment above time_init x86:
arch/x86/kernel/time.c

 99/*
100 * Initialize TSC and delay the periodic timer init to
101 * late x86_late_time_init() so ioremap works.
102 */
103void __init time_init(void)
104{
105	late_time_init = x86_late_time_init;
106}

Only After this:
> >     late_time_init()
> >         x86_late_time_init()
> >             x86_init.timers.timer_init()
> > 	        hpet_time_init() Only after this call we finally start
> > 		getting clock interrupts, and can get precise output from
> > 		sched_clock_local().

We start getting timer interrupts. Is it acceptable to move
sched_clock_init() after late_time_init()?

Thank you,
Pavel
