Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
 <20180712000419.5165-15-pasha.tatashin@oracle.com> <dfd0e8d4-0020-d07c-2570-c1e1652875c5@cn.fujitsu.com>
In-Reply-To: <dfd0e8d4-0020-d07c-2570-c1e1652875c5@cn.fujitsu.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 13 Jul 2018 07:39:02 -0400
Message-ID: <CAGM2readdMd4t5vp0=RxDSZfhdJD_8XWBx0QT1dSKNM6d1xT0Q@mail.gmail.com>
Subject: Re: [PATCH v13 14/18] x86/tsc: initialize cyc2ns when tsc freq. is determined
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: douly.fnst@cn.fujitsu.com
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jul 13, 2018 at 5:13 AM Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
>
>
>
> At 07/12/2018 08:04 AM, Pavel Tatashin wrote:
> > cyc2ns converts tsc to nanoseconds, and it is handled in a per-cpu data
> > structure.
> >
> > Currently, the setup code for c2ns data for every possible CPU goes through
> > the same sequence of calculations as for the boot CPU, but is based on the
> > same tsc frequency as the boot CPU, and thus this is not necessary.
> >
> > Initialize the boot cpu when tsc frequency is determined. Copy the
> > calculated data from the boot CPU to the other CPUs in tsc_init().
> >
> > In addition do the following:
> >
> > - Remove unnecessary zeroing of c2ns data by removing cyc2ns_data_init()
> > - Split set_cyc2ns_scale() into two functions, so set_cyc2ns_scale() can be
> >    called when system is up, and wraps around __set_cyc2ns_scale() that can
> >    be called directly when system is booting but avoids saving restoring
> >    IRQs and going and waking up from idle.
> >
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> > ---
> >   arch/x86/kernel/tsc.c | 94 ++++++++++++++++++++++++-------------------
> >   1 file changed, 53 insertions(+), 41 deletions(-)
> >
> > diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> > index bc8eb82050a3..0b1abe7fdd8e 100644
> > --- a/arch/x86/kernel/tsc.c
> > +++ b/arch/x86/kernel/tsc.c
> > @@ -103,23 +103,6 @@ void cyc2ns_read_end(void)
> >    *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
> >    */
> >
> > -static void cyc2ns_data_init(struct cyc2ns_data *data)
> > -{
> > -     data->cyc2ns_mul = 0;
> > -     data->cyc2ns_shift = 0;
> > -     data->cyc2ns_offset = 0;
> > -}
> > -
> > -static void __init cyc2ns_init(int cpu)
> > -{
> > -     struct cyc2ns *c2n = &per_cpu(cyc2ns, cpu);
> > -
> > -     cyc2ns_data_init(&c2n->data[0]);
> > -     cyc2ns_data_init(&c2n->data[1]);
> > -
> > -     seqcount_init(&c2n->seq);
> > -}
> > -
> >   static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> >   {
> >       struct cyc2ns_data data;
> > @@ -135,18 +118,11 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
> >       return ns;
> >   }
> >
> > -static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> > +static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> >   {
> >       unsigned long long ns_now;
> >       struct cyc2ns_data data;
> >       struct cyc2ns *c2n;
> > -     unsigned long flags;
> > -
> > -     local_irq_save(flags);
> > -     sched_clock_idle_sleep_event();
> > -
> > -     if (!khz)
> > -             goto done;
> >
> >       ns_now = cycles_2_ns(tsc_now);
> >
> > @@ -178,12 +154,55 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
> >       c2n->data[0] = data;
> >       raw_write_seqcount_latch(&c2n->seq);
> >       c2n->data[1] = data;
> > +}
> > +
> > +static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
> > +{
> > +     unsigned long flags;
> > +
> > +     local_irq_save(flags);
> > +     sched_clock_idle_sleep_event();
> > +
> > +     if (khz)
> > +             __set_cyc2ns_scale(khz, cpu, tsc_now);
> >
> > -done:
> >       sched_clock_idle_wakeup_event();
> >       local_irq_restore(flags);
> >   } >
> > +/*
> > + * Initialize cyc2ns for boot cpu
> > + */
> > +static void __init cyc2ns_init_boot_cpu(void)
> > +{
> > +     struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
> > +
> > +     seqcount_init(&c2n->seq);
> > +     __set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
> > +}
> Hi Paval,
>
> Here we didn't protect it with local_irq_save()/local_irq_restore()

Hi Dou,

Thank you for reviewing this work.

Correct, but no need to do that: we do local_irqsave()/restore() only
in set_cyc2ns_scale(), because that is called when system is live, and
frequency changes.

cyc2ns_init_boot_cpu(), and cyc2ns_init_secondary_cpus(), are called
during boot, before smp_init(), and frequency does not change during
that time. So, nothing to protect us from.

> In tsc_init(), the timer interrupt has worked, Is that OK?
>
> IMO, no need to change so much, just use the original code,
> eg:

The request and suggestions on how to cleanup cyc2ns came from Thomas.
Overall, code is cleaner now.

Thank you,
Pavel
