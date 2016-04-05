Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 13:23:36 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PREEMPT-RT] [PATCH] s390/cpum_sf: Remove superfluous SMP
 function call
Message-ID: <20160405112336.GB6890@osiris>
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris>
 <57039DC2.6090907@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57039DC2.6090907@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 05, 2016 at 01:13:06PM +0200, Sebastian Andrzej Siewior wrote:
> On 04/05/2016 12:49 PM, Heiko Carstens wrote:
> >> --- a/arch/s390/kernel/perf_cpum_sf.c
> >> +++ b/arch/s390/kernel/perf_cpum_sf.c
> >> @@ -1510,7 +1510,6 @@ static void cpumf_measurement_alert(stru
> >>  static int cpumf_pmu_notifier(struct notifier_block *self,
> >>  			      unsigned long action, void *hcpu)
> >>  {
> >> -	unsigned int cpu = (long) hcpu;
> >>  	int flags;
> >>
> >>  	/* Ignore the notification if no events are scheduled on the PMU.
> >> @@ -1523,11 +1522,15 @@ static int cpumf_pmu_notifier(struct not
> >>  	case CPU_ONLINE:
> >>  	case CPU_DOWN_FAILED:
> >>  		flags = PMC_INIT;
> >> -		smp_call_function_single(cpu, setup_pmc_cpu, &flags, 1);
> >> +		local_irq_disable();
> >> +		setup_pmc_cpu(&flags);
> >> +		local_irq_enable();
> >>  		break;
> > 
> > ...but at least the CPU_DOWN_FAILED callback will not necessarily be called
> > on the cpu that couldn't be brought offline.
> 
> I don't follow.

I was trying to say that if bringing a cpu down fails, then the cpu hotplug
notifier with CPU_DOWN_FAILED might be called on a cpu that is _not_ the
same cpu that was supposed to be brought offline.

Subsequently, in this case, the setup_pmc_cpu() call will be executed on
the wrong cpu.
