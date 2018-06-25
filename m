Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com> <20180625085543.GT2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180625085543.GT2494@hirez.programming.kicks-ass.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 25 Jun 2018 08:44:56 -0400
Message-ID: <CAGM2reaQTYhRCWHO05h+AjpCpefVetySSD1_3nCC=hjx0Q+sUA@mail.gmail.com>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 25, 2018 at 4:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 21, 2018 at 05:25:17PM -0400, Pavel Tatashin wrote:
> > Allow sched_clock() to be used before schec_clock_init() and
> > sched_clock_init_late() are called. This provides us with a way to get
> > early boot timestamps on machines with unstable clocks.
>
> There are !x86 architectures that use this code and might not expect to
> have their sched_clock() called quite that early. Please verify.

Correct, with this change from what I could gather so far, the other
arches with unstable clocks either pick-up and start output time
earlier or output 0. I could not test on every specific configuration
of course.

>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >  kernel/sched/clock.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index 10c83e73837a..f034392b0f6c 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -205,6 +205,11 @@ void clear_sched_clock_stable(void)
> >   */
> >  static int __init sched_clock_init_late(void)
> >  {
> > +     /* Transition to unstable clock from early clock */
>
> This is wrong... or at least it smells horribly.
>
> This is not the point where we transition from early to unstable, that
> is in fact in sched_clock_init.
>
> This function, sched_clock_init_late(), is where we attempt to
> transition from unstable to stable. And this is _waaaay_ after SMP init.
>
> > +     local_irq_disable();
> > +     __gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
> > +     local_irq_enable();
>
> This might work in sched_clock_init(), which is pre-SMP.
>
> >       sched_clock_running = 2;
> >       /*
> >        * Ensure that it is impossible to not do a static_key update.
> > @@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
> >       if (sched_clock_stable())
> >               return sched_clock() + __sched_clock_offset;
> >
> > -     if (unlikely(!sched_clock_running))
> > -             return 0ull;
> > +     /* Use early clock until sched_clock_init_late() */
> > +     if (unlikely(sched_clock_running < 2))
> > +             return sched_clock() + __sched_clock_offset;
>
> And then this remains !sched_clock_running, except instead of 0, you
> then return sched_clock() + __sched_clock_offset;
>
> >       preempt_disable_notrace();
> >       scd = cpu_sdc(cpu);
>

All the above is because of:

> > +     if (unlikely(sched_clock_running < 2))
> > +             return sched_clock() + __sched_clock_offset;

Keep early boot clock until sched_clock_running
sched_clock_init_late(). This can be changed to:

+     if (unlikely(!sched_clock_running))
+             return sched_clock() + __sched_clock_offset;

And do all the necessary changes in sched_clock_init().

The reason, why I had "< 2" in the first place, is because we did not
have early static branching before, and ended-up with sched_clock()
outputting:  early TSC, jiffies, real TSC. The imprecise jiffies
timestamps during boot were confusing.

However, now with the early branching, and with upcoming change that
Thomas suggested that guarantees that if early TSC are enabled we will
keep them forever, the "< 2" is not needed. I will update this patch
accordingly.

Thank you,
Pavel
