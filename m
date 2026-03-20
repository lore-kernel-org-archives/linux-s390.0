Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D647078F4F;
	Fri, 20 Mar 2026 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017165; cv=none; b=n0fVhPadWhlEp9YGES9N5JjUtsL63W25VYkK6+A6i2eNELIJQPUeBGwnUlnedPHEGnYJqnUBZ4u2Va8HCyAfj5cTTpC6aD3gRerSffcfOCd6P9J5g63WHDSmRGo2gMzdhz5U3m8XklJBfxhCEd3RDcWZrK4rT6t+DOnXxzvInOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017165; c=relaxed/simple;
	bh=1NvHpmAa9Fni/8l7sXhAcVnHca3tIOm2h91PDLFzmVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/ibArJIq0vovjaBqJJaZuZ5yy3FdWEA8ZYi3Q7azAOiM2Mc+8oWvMdmkZylLgZ+kP0jfSWJn648qGZnV8FXhdl57zC7HesMRwVwwcCofEfVx8Sf2t7+5Iook9impLRTU5qnqX1QikV2Mjtsc53NAqfbo3usUPjYCMZg7LoCPVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bIz4mq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bIz4mq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBA9C4CEF7;
	Fri, 20 Mar 2026 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774017165;
	bh=1NvHpmAa9Fni/8l7sXhAcVnHca3tIOm2h91PDLFzmVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4bIz4mqNx8xJQ5yuRzB6rR6NAc63jDuiaEcDCWvutRBdmEhe8xMH24RDEiPMRem7
	 uxOP0FR8I8xYjcGJTaYlXw0DNguxaf77vvGHs2Oc3ylv6EApITdDLmSEY2o8bNRZ5s
	 2qwjX0KizCN7daNyG9Q5TXk3O8hjk8boyBH69lPq5xzoQ96nH6AotcVzVaACyH4ym3
	 Si1V8IlTDX+izjBcrST12nY8bcyP4bHHvh3PDy8t9DH/COsXQ59nvAXfuuvAJgA8cR
	 1luz4t69IPyL+JJAAJRAEwXaSzBN2I5+8sKy54FF1GrZ7OnaeWG71qImKoXSRCOWI/
	 R5+HyhxH6wqNA==
Date: Fri, 20 Mar 2026 15:32:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mel Gorman <mgorman@suse.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Xin Zhao <jackzxcui1989@163.com>, linux-pm@vger.kernel.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 14/15] sched/cputime: Handle idle irqtime gracefully
Message-ID: <ab1airBcTiyxTgvH@localhost.localdomain>
References: <20260206142245.58987-1-frederic@kernel.org>
 <20260206142245.58987-15-frederic@kernel.org>
 <415e925a-e9f0-40ad-9f53-263dd34dd2a9@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <415e925a-e9f0-40ad-9f53-263dd34dd2a9@linux.ibm.com>

Le Tue, Mar 03, 2026 at 04:41:18PM +0530, Shrikanth Hegde a écrit :
> Hi Frederic,
> 
> On 2/6/26 7:52 PM, Frederic Weisbecker wrote:
> > The dyntick-idle cputime accounting always assumes that IRQ time
> > accounting is enabled and consequently stops elapsing the idle time
> > during dyntick-idle IRQs.
> > 
> > This doesn't mix up well with disabled IRQ time accounting because then
> > idle IRQs become a cputime blind-spot. Also this feature is disabled
> > on most configurations and the overhead of pausing dyntick-idle
> > accounting while in idle IRQs could then be avoided.
> > 
> > Fix the situation with conditionally pausing dyntick-idle accounting
> > during idle IRQs only if neither native vtime (which does IRQ time
> > accounting) nor generic IRQ time accounting are enabled.
> > 
> > Also make sure that the accumulated IRQ time is not accidentally
> > substracted from later accounting.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   kernel/sched/cputime.c | 24 +++++++++++++++++++++---
> >   kernel/sched/sched.h   |  1 +
> >   2 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> > index d588a4a50e57..92fa2f037b6e 100644
> > --- a/kernel/sched/cputime.c
> > +++ b/kernel/sched/cputime.c
> > @@ -46,7 +46,8 @@ static void irqtime_account_delta(struct irqtime *irqtime, u64 delta,
> >   	u64_stats_update_begin(&irqtime->sync);
> >   	cpustat[idx] += delta;
> >   	irqtime->total += delta;
> > -	irqtime->tick_delta += delta;
> > +	if (!irqtime->idle_dyntick)
> > +		irqtime->tick_delta += delta;
> 
> Wouldn't kcpustat_idle_dyntick achieve the same thing?

Yes indeed.

> 
> >   	u64_stats_update_end(&irqtime->sync);
> >   }
> > @@ -81,6 +82,16 @@ void irqtime_account_irq(struct task_struct *curr, unsigned int offset)
> >   		irqtime_account_delta(irqtime, delta, CPUTIME_SOFTIRQ);
> >   }
> > +static inline void irqtime_dyntick_start(void)
> > +{
> > +	__this_cpu_write(cpu_irqtime.idle_dyntick, true);
> > +}
> > +
> > +static inline void irqtime_dyntick_stop(void)
> > +{
> > +	__this_cpu_write(cpu_irqtime.idle_dyntick, false);
> > +}
> > +
> >   static u64 irqtime_tick_accounted(u64 maxtime)
> >   {
> >   	struct irqtime *irqtime = this_cpu_ptr(&cpu_irqtime);
> > @@ -94,6 +105,9 @@ static u64 irqtime_tick_accounted(u64 maxtime)
> >   #else /* !CONFIG_IRQ_TIME_ACCOUNTING: */
> > +static inline void irqtime_dyntick_start(void) { }
> > +static inline void irqtime_dyntick_stop(void) { }
> > +
> >   static u64 irqtime_tick_accounted(u64 dummy)
> >   {
> >   	return 0;
> > @@ -444,6 +458,7 @@ void kcpustat_dyntick_stop(u64 now)
> >   		WARN_ON_ONCE(!kc->idle_dyntick);
> >   		kcpustat_idle_stop(kc, now);
> >   		kc->idle_dyntick = false;
> > +		irqtime_dyntick_stop();
> >   		vtime_dyntick_stop();
> >   		steal_account_process_time(ULONG_MAX);
> >   	}
> > @@ -455,6 +470,7 @@ void kcpustat_dyntick_start(u64 now)
> >   	if (!vtime_generic_enabled_this_cpu()) {
> >   		vtime_dyntick_start();
> > +		irqtime_dyntick_start();
> >   		kc->idle_dyntick = true;
> >   		kcpustat_idle_start(kc, now);
> >   	}
> > @@ -464,7 +480,8 @@ void kcpustat_irq_enter(u64 now)
> >   {
> >   	struct kernel_cpustat *kc = kcpustat_this_cpu;
> > -	if (!vtime_generic_enabled_this_cpu())
> > +	if (!vtime_generic_enabled_this_cpu() &&
> > +	    (irqtime_enabled() || vtime_accounting_enabled_this_cpu()))
> >   		kcpustat_idle_stop(kc, now);
> >   }
> Scenario: context_tracking is not enabled(since nohz_full or isolcpus not specified) and
> irqtime/native is not enabled. ( config is CONFIG_VIRT_CPU_ACCOUNTING_GEN + IRQ_TIME=n)
> 
> 
> cpu goes into tickless mode. Gets irqs, but kcpustat_irq_enter/exit is nop.
> Then the time it spent in irq is still accounted for idle time, during
> kcpustat_dyntick_stop?

Right! As is the case for IRQs firing in system and user time. Basically this
just consolidate the IRQ time accounting behaviour in CONFIG_VIRT_CPU_ACCOUNTING_GEN=n

> Who is going to account the irq time in this case?

Nothing, it's part of idle time.

We could also decide to account the idle IRQ time as system time. I guess it's a
matter of which semantic we want to give. Though that would be more overhead.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
