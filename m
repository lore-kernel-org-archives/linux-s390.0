Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 26 Jun 2018 14:42:09 -0400
Message-ID: <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: tglx@linutronix.de
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Thomas,

On Tue, Jun 26, 2018 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Pavel,
>
> first of all, sorry for my last outburst. I just was in a lousy mood after
> staring into too much half baken stuff and failed to make myself stay away
> from the computer.

Thank you.

>
> On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> > On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> > And this early init sequence also needs to pull over the tsc adjust
> > magic. So tsc_early_delay_calibrate() which should btw. be renamed to
> > tsc_early_init() should have:
> >
> > {
> >       cpu_khz = x86_platform.calibrate_cpu();
> >         tsc_khz = x86_platform.calibrate_tsc();
> >
> >         tsc_khz = tsc_khz ? : cpu_khz;
> >         if (!tsc_khz)
> >                 return;
> >
> >         /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> >         tsc_store_and_check_tsc_adjust(true);
> >
> >       calc_lpj(tsc_khz);
> >
> >       tsc_sched_clock_init();
> > }
>
> Peter made me look deeper into this and there are a few issues, which I
> missed, depending on when some of the resources become available. So we
> probably cannot hook all of this into tsc_early_delay_calibrate().
>
> I have an idea how to distangle it and we'll end up in a staged approach,
> which looks like this:
>
>     1) Earliest one (not sure how early yet)
>
>        Attempt to use MSR/CPUID. If not running on a hypervisor this can
>        try the quick PIT calibration, but nothing else.
>
>     2) Post init_hypervisor_platform()
>
>        An attempt to use the hypervisor data can be made.
>
>     3) Post early_acpi_boot_init()
>
>        This can do PIT/HPET based calibration
>
>     4) Post x86_dtb_init()
>
>        PIT/PMTIMER based calibration
>
> Once tsc_khz is known, no further attempts of calibration are made. I'll
> look into that later tonight.

I think, there are no reasons to try staged attempts. It usually gets
harder to maintain overtime. In my opinion it is best if do it in two
tries, as right now, but just cleaner. The first attempt we get a
crude result, using the lowest denominator to which current logic
might fallback if something else is not available that early in boot:
i.e cpu calibration loop in native_calibrate_cpu() but later get
something better. Also, even if early clock does not work because we
could not get tsc early, it is not a problem, we still will probably
determine it later during tsc_init call.

I have re-wrote tsc_early_init()/tsc_init(), they are much simpler now:

void __init tsc_early_init(void)
{
        if (!boot_cpu_has(X86_FEATURE_TSC))
                return;

        if (!determine_cpu_tsc_frequncies())
                return;

        cyc2ns_init_boot_cpu();
        static_branch_enable(&__use_tsc);

        loops_per_jiffy = get_loops_per_jiffy(tsc_khz);
}

void __init tsc_init(void)
{
        if (!boot_cpu_has(X86_FEATURE_TSC))
                return;

        if (!determine_cpu_tsc_frequncies()) {
                setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
                return;
        }

        /* Sanitize TSC ADJUST before cyc2ns gets initialized */
        tsc_store_and_check_tsc_adjust(true);

        cyc2ns_reinit_boot_cpu();
        cyc2ns_init_secondary_cpus();
        static_branch_enable(&__use_tsc);

        if (!no_sched_irq_time)
                enable_sched_clock_irqtime();

        lpj_fine = get_loops_per_jiffy(tsc_khz);
        use_tsc_delay();
        check_system_tsc_reliable();

        if (unsynchronized_tsc()) {
                mark_tsc_unstable("TSCs unsynchronized");
                return;
        }

        clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
        detect_art();
}

All the new functions are self explanatory. I added three cyc2ns
related functions based on your suggestions on how to clean-up that
code:

static void __init cyc2ns_init_boot(void)
{
        struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);

        seqcount_init(&c2n->seq);
        __set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
}

static void __init cyc2ns_init_secondary(void)
{
        unsigned int cpu, this_cpu = smp_processor_id();
        struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
        struct cyc2ns_data *data = c2n->data;

        for_each_possible_cpu(cpu) {
                if (cpu != this_cpu) {
                        seqcount_init(&c2n->seq);
                        c2n = per_cpu_ptr(&cyc2ns, cpu);
                        c2n->data[0] = data[0];
                        c2n->data[1] = data[1];
                }
        }
}

/* Reinitialize boot cpu c2ns, using the offset of the current
sched_clock() value */
static void __init cyc2ns_reinit_boot(void)
{
        struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
        unsigned long sched_now = sched_clock();

        __set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
        c2n->data[0].cyc2ns_offset += sched_now;
        c2n->data[1].cyc2ns_offset += sched_now;
}

I know, conceptually, it is similar to what I had before, but I think
it is simple enough, easy to maintain, but more importantly safe. What
do you think?

Thank you,
Pavel
