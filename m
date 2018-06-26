Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-11-pasha.tatashin@oracle.com> <20180625085543.GT2494@hirez.programming.kicks-ass.net>
 <20180625192320.kzmqkvmfh5aeuhhx@xakep.localdomain> <20180626090003.GA2458@hirez.programming.kicks-ass.net>
 <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
In-Reply-To: <20180626112705.4dxrsd5acvobla5y@xakep.localdomain>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Tue, 26 Jun 2018 07:51:54 -0400
Message-ID: <CAGM2reZ98fm1TJEpeXErrXFOsMUwB9xHPr-Aq8E7uGjPQDvz+A@mail.gmail.com>
Subject: Re: [PATCH v12 10/11] sched: early boot clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 26, 2018 at 7:29 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> >
> > How's something like this? That moves sched_clock_init() to right before
> > we enable IRQs for the first time (which is after we've started the
> > whole timekeeping business).
> >
> > The thing is, sched_clock_init_late() reall is far too late, we need to
> > switch to unstable before we bring up SMP.
>
> OK, sure.
>
> > -     sched_clock_postinit();
> > +     sched_clock_init();
>
> Yes, we can move sched_clock_init(). But placing it after time_init() would
> work on all arches with unstable clock except for x86.
>
> See comment above time_init x86:
> arch/x86/kernel/time.c
>
>  99/*
> 100 * Initialize TSC and delay the periodic timer init to
> 101 * late x86_late_time_init() so ioremap works.
> 102 */
> 103void __init time_init(void)
> 104{
> 105     late_time_init = x86_late_time_init;
> 106}
>
> Only After this:
> > >     late_time_init()
> > >         x86_late_time_init()
> > >             x86_init.timers.timer_init()
> > >             hpet_time_init() Only after this call we finally start
> > >             getting clock interrupts, and can get precise output from
> > >             sched_clock_local().
>
> We start getting timer interrupts. Is it acceptable to move
> sched_clock_init() after late_time_init()?

A change like this on top of your suggested change, would work:

1. Move  sched_clock_init() after late_time_init().
diff --git a/init/main.c b/init/main.c
index 162d931c9511..ff0a24170b95 100644
--- a/init/main.c
+++ b/init/main.c
@@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
        softirq_init();
        timekeeping_init();
        time_init();
-       sched_clock_init();
        printk_safe_init();
        perf_event_init();
        profile_init();
@@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
        acpi_early_init();
        if (late_time_init)
                late_time_init();
+       sched_clock_init();
        calibrate_delay();
        pid_idr_init();
        anon_vma_init();

2. sched_clock_tick() bailouts while sched_clock_running == 0, so we
must do __sched_clock_gtod_offset() after setting sched_clock_running
to 1, but also, we must have at least one tick passed in order for
correct computation. So something like this works, and preserves
continuity:

 void __init sched_clock_init(void)
 {
+       unsigned long flags;
+
+       pr_err("before sched_clock_running = 1");
+       sched_clock_running = 1;
        /*
         * Set __gtod_offset such that once we mark sched_clock_running,
         * sched_clock_tick() continues where sched_clock() left off.
@@ -208,8 +212,11 @@ void __init sched_clock_init(void)
         * Even if TSC is buggered, we're still UP at this point so it
         * can't really be out of sync.
         */
+       local_irq_save(flags);
+       sched_clock_tick();
+       local_irq_restore(flags);
        __sched_clock_gtod_offset();
-       sched_clock_running = 1;
+       pr_err("after sched_clock_running = 1");
 }

[    0.712302] APIC: Switch to symmetric I/O mode setup
[    0.717386] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.722031] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x2e02bde913e, max
_idle_ns: 440795290413 ns
[    0.722415] before sched_clock_running = 1
[    0.722544] after sched_clock_running = 1
[    0.722680] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6383.98 BogoMIPS (lpj=3191993)
[    0.723546] pid_max: default: 32768 minimum: 301
[    0.724087] Security Framework initialized
