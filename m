Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 24 Jun 2018 01:38:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> > So you forgot to answer this question. I did not find a system yet, which
> > actually exposes this behaviour on mainline.
> >
> > Is this an artifact of your early sched clock thing?
> >
> 
> Yes, it is. Let me explain how it happens.
> 
> So, the problem is introduced in patch "sched: early boot clock" by this change:
> 
> -       if (unlikely(!sched_clock_running))
> -               return 0ull;
> +       /* Use early clock until sched_clock_init_late() */
> +       if (unlikely(sched_clock_running < 2))
> +               return sched_clock() + __sched_clock_offset;
> 
> As soon as sched_clock() starts output non-zero values, we start
> output time without correcting the output as it is done in
> sched_clock_local() where unstable TSC and backward motion are
> detected. But, since early in boot interrupts are disabled, we cannot
> really correct invalid time, and therefore must rely on sched_clock()
> to provide us with a contiguous and sane time.

In early boot the TSC frequency is not changing at all so the whole
unstable thing is completely irrelevant. And that also applies to backward
motion. There is no such thing during early boot.

> In earlier versions of this project, I was solving this problem by
> adjusting __sched_clock_offset every time sched_clock()'s continuity was
> changed by using a callback function into sched/clock.c. But, Peter was
> against that approach.

So your changelog is completely misleading and utterly wrong. What the heck
has this to do with jiffies and the use_tsc jump label? Exactly nothing.

> [    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.009000] tsc: Fast TSC calibration using PIT
> [    0.010000] tsc: Detected 3192.137 MHz processor
> [    0.011000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e03465ceb2,    max_idle_ns: 440795259855 ns

> static_branch_enable(__use_tsc) is called, and timestamps became precise
> but reduced:

> [    0.002233] Calibrating delay loop (skipped), value calculated using timer frequency..     6384.27 BogoMIPS (lpj=3192137)

This is crap, because this is not what the current implementation does. The
current implementation enables the static branch when the early TSC sched
clock is enabled. So even the timestamps are crap because with the early
sched clock the time stamps are precise _before_ the timer interrupt is
initialized. That's the whole purpose of the exercise, right?

This made me assume that its an existing problem. Heck, changelogs are
about facts and not fairy tales. And it's completely non interesting that
you observed this problem with some random variant of your patches. What's
interesting is the factual problem which makes the change necessary.

So the problem is not the transition from jiffies to early TSC because at
the point where you enable the early TSC sched clock the jiffies sched
clock value is exactly ZERO simply because the timer interrupt is not
running yet.

The problem happens when you switch from the early TSC thing to the real
one in tsc_init(). And that happens because you reinitialize the cyc2ns
data of the boot CPU which was already initialized. That sets the offset to
the current TSC value and voila time goes backwards.

This whole nonsense can be completely avoided.

If you look at the existing tsc_init() then you'll notice that the loop
which initializes cyc2ns data for each possible cpu is bonkers. It does the
same stupid thing over and over for every possible CPU, i.e.

      - Set already zeroed data to zero

      - Calculate the cyc2ns conversion values from the same input

      - Invoke sched_clock_idle_sleep/wakeup_event() which executes the
        same code over and over on the boot cpu and the boot cpu sched
        clock data.

That's pointless and wants to be fixed in a preparatory step.

static void __init cyc2ns_init(void)
{
	unsigned int cpu, this_cpu = smp_processor_id();
	struct cyc2ns_data data;
	struct cyc2ns *c2n;

	c2n = this_cpu_ptr(&cyc2ns);
	seqcount_init(&c2n->seq);
	set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
	data = c2n->data[0];

	for_each_possible_cpu(cpu) {
		if (cpu == this_cpu)
			continue;
		seqcount_init(&c2n->seq);
		c2n = per_cpu_ptr(&cyc2ns, cpu)
		c2n->data[0] = c2n->data[1] = data;
	}
}

This is safe and correct because the whole latch mechanics are completely
irrelevant for the non boot cpus as they are far away from being up. That
replaces the loop in tsc_init() with a single call to cyc2ns_init(().

The next bogosity is the whole calibration logic.

void __init tsc_early_delay_calibrate(void)
{
	cpu_khz = x86_platform.calibrate_cpu();
        tsc_khz = x86_platform.calibrate_tsc();

        tsc_khz = tsc_khz ? : cpu_khz;
        if (!tsc_khz)
                return;

        lpj = tsc_khz * 1000;
        do_div(lpj, HZ);
        loops_per_jiffy = lpj;
}

and

void __init tsc_init(void)
{
        cpu_khz = x86_platform.calibrate_cpu();
        tsc_khz = x86_platform.calibrate_tsc();

        /*
         * Trust non-zero tsc_khz as authorative,
         * and use it to sanity check cpu_khz,
         * which will be off if system timer is off.
         */
	if (tsc_khz == 0)
                tsc_khz = cpu_khz;
        else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
		cpu_khz = tsc_khz;

        if (!tsc_khz) {
		.....

So this is exactly the same code sequence just that tsc_init() has the
extra logic of sanitizing cpu_khz for some bogus cpuid/msr values.

So we have yet another completely pointless exercise in tsc_init(). It just
can go away and the tsc_khz value will not be more precise in the second
invocation of that stuff than in the first. Ergo the extra cpu_khz
sanitizing can be moved to early calibrate and the duplicate nonsense in
tsc_init() can be discarded.. tsc_init() then needs only to check for
tsc_khz == 0 and be done with it.

Now back to your early sched clock thing. It does in the init code:

tsc_sched_clock_init()
{
	c2n = this_cpu_ptr(&cyc2ns);
	seqcount_init(&c2n->seq);
	__set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
}	

i.e it avoids the sched_clock_idle_sleep/wakeup_event() calls because they
make no sense, but it initializes cyc2ns for the boot CPU with the correct
values.

And this early init sequence also needs to pull over the tsc adjust
magic. So tsc_early_delay_calibrate() which should btw. be renamed to
tsc_early_init() should have:

{
	cpu_khz = x86_platform.calibrate_cpu();
        tsc_khz = x86_platform.calibrate_tsc();

        tsc_khz = tsc_khz ? : cpu_khz;
        if (!tsc_khz)
                return;

        /* Sanitize TSC ADJUST before cyc2ns gets initialized */
        tsc_store_and_check_tsc_adjust(true);

	calc_lpj(tsc_khz);
		
	tsc_sched_clock_init();
}

After that there is absolutely _ZERO_ reason to reinitialize the cyc2ns
value for the boot CPU which also completely removes the requirement for
this 'adjust offset' change. It's just going to work.

The only change you have to make is:

static void __init cyc2ns_init(void)
{
	unsigned int cpu, this_cpu = smp_processor_id();
	struct cyc2ns_data data;
	struct cyc2ns *c2n;

	c2n = this_cpu_ptr(&cyc2ns);
-	seqcount_init(&c2n->seq);
-	set_cyc2ns_scale(tsc_khz, cpu, rdtsc());
	data = c2n->data[0];

	for_each_possible_cpu(cpu) {
		if (cpu == this_cpu)
			continue;
		seqcount_init(&c2n->seq);
		c2n = per_cpu_ptr(&cyc2ns, cpu)
		c2n->data[0] = c2n->data[1] = data;
	}
}

<rant>

TBH. I'm utterly disappointed how all this was approached.

I absolutely detest the approach of duct taping something new into existing
code without a proper analysis of the existing infrastructure in the first
place. This is just utter waste of time. I don't care about your wasted
time at all, but I care about the fact, that I had to sit down and do the
analysis myself and about the time wasted in reviewing half baken
stuff. Sure, I was able do the analysis rather fast because I'm familiar
with the code, but I still had to sit down and figure out all the
details. You might have needed a week for that, but that would have saved
you several weeks of tinkering and the frustration of getting your patches
rejected over and over.

Alone the fact that dmesg has this:

[    0.000000] tsc: Fast TSC calibration using PIT
[    0.020000] tsc: Fast TSC calibration using PIT

should have made you look into exactly what I was looking at just now. It's
really not rocket science to figure out that both calibrations do
absolutely the same thing and this is even more hilarious as you are doing
this to do boot time analysis in order to make the boot faster. Oh well.

</rant>

So I made your homework and expect as compensation a sqeaky clean patch set
with proper changelogs. I surely might have missed a few details, but I'm
also sure you find and fix them if you avoid trying to repost the whole
thing tomorrow. Take your time and do it right and ask questions upfront if
anything is unclear instead of implementing hacks based on weird
assumptions.

That'll make up for both your and my frustration over this whole excercise.

Thanks,

	tglx
