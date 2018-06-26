Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
 <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1806261725510.1587@nanos.tec.linutronix.de> <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
In-Reply-To: <CAGM2reYQ23XhQHAOO0Oo8MGvgrjpNZPZkwp+wwsU8Fb+jfANyA@mail.gmail.com>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 26 Jun 2018 15:47:51 -0400
Message-ID: <CAGM2rebiy7fMssEvnxj9DLNN-SGzgULh7iuMfe4=dgF89H5DFQ@mail.gmail.com>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: tglx@linutronix.de
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 26, 2018 at 2:42 PM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> Hi Thomas,
>
> On Tue, Jun 26, 2018 at 11:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > Pavel,
> >
> > first of all, sorry for my last outburst. I just was in a lousy mood after
> > staring into too much half baken stuff and failed to make myself stay away
> > from the computer.
>
> Thank you.
>
> >
> > On Sun, 24 Jun 2018, Thomas Gleixner wrote:
> > > On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> > > And this early init sequence also needs to pull over the tsc adjust
> > > magic. So tsc_early_delay_calibrate() which should btw. be renamed to
> > > tsc_early_init() should have:
> > >
> > > {
> > >       cpu_khz = x86_platform.calibrate_cpu();
> > >         tsc_khz = x86_platform.calibrate_tsc();
> > >
> > >         tsc_khz = tsc_khz ? : cpu_khz;
> > >         if (!tsc_khz)
> > >                 return;
> > >
> > >         /* Sanitize TSC ADJUST before cyc2ns gets initialized */
> > >         tsc_store_and_check_tsc_adjust(true);
> > >
> > >       calc_lpj(tsc_khz);
> > >
> > >       tsc_sched_clock_init();
> > > }
> >
> > Peter made me look deeper into this and there are a few issues, which I
> > missed, depending on when some of the resources become available. So we
> > probably cannot hook all of this into tsc_early_delay_calibrate().
> >
> > I have an idea how to distangle it and we'll end up in a staged approach,
> > which looks like this:
> >
> >     1) Earliest one (not sure how early yet)
> >
> >        Attempt to use MSR/CPUID. If not running on a hypervisor this can
> >        try the quick PIT calibration, but nothing else.
> >
> >     2) Post init_hypervisor_platform()
> >
> >        An attempt to use the hypervisor data can be made.
> >
> >     3) Post early_acpi_boot_init()
> >
> >        This can do PIT/HPET based calibration
> >
> >     4) Post x86_dtb_init()
> >
> >        PIT/PMTIMER based calibration
> >
> > Once tsc_khz is known, no further attempts of calibration are made. I'll
> > look into that later tonight.
>
> I think, there are no reasons to try staged attempts. It usually gets
> harder to maintain overtime. In my opinion it is best if do it in two
> tries, as right now, but just cleaner. The first attempt we get a
> crude result, using the lowest denominator to which current logic
> might fallback if something else is not available that early in boot:
> i.e cpu calibration loop in native_calibrate_cpu() but later get
> something better. Also, even if early clock does not work because we
> could not get tsc early, it is not a problem, we still will probably
> determine it later during tsc_init call.

Actually, nevermind, I looked through the code again, it seems that if
we get early tsc frequency we can keep it, but otherwise just try it
again at later time when in tsc_init(). So, no need for
cyc2ns_reinit_boot(). I still think no need for staged attempts, but
try in two different places: in tsc_init_early() -> works? use that
tsc frequency later, does not try again in tsc_init(), and use the new
one.

In tsc_init we can have something like this:
void __init tsc_init(void)
{
        if (!boot_cpu_has(X86_FEATURE_TSC))
                return;

        /* See if we were not able to determine tsc frequency early,
but can now */
        if (!tsc_khz && determine_cpu_tsc_frequncies()) {
              /* Sanitize TSC ADJUST before cyc2ns gets initialized */
              tsc_store_and_check_tsc_adjust(true);
               cyc2ns_init_boot_cpu();
        }
        ....

}

Pavel
