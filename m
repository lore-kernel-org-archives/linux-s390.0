Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sun, 24 Jun 2018 09:30:58 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v12 09/11] x86/tsc: prepare for early sched_clock
In-Reply-To: <CAGM2rearx+sGh5pHzy4m-2y3izpQvVotyySt6Raam4L5Zmz5iQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806240913130.8650@nanos.tec.linutronix.de>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com> <20180621212518.19914-10-pasha.tatashin@oracle.com> <alpine.DEB.2.21.1806231815060.8650@nanos.tec.linutronix.de> <alpine.DEB.2.21.1806232210110.8650@nanos.tec.linutronix.de>
 <CAGM2reYQx769omkWVweEcTMy8WNrKOiuUVo4OFWNh4zW-rc4pg@mail.gmail.com> <alpine.DEB.2.21.1806232347540.8650@nanos.tec.linutronix.de> <CAGM2rearx+sGh5pHzy4m-2y3izpQvVotyySt6Raam4L5Zmz5iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 23 Jun 2018, Pavel Tatashin wrote:
> > > As soon as sched_clock() starts output non-zero values, we start
> > > output time without correcting the output as it is done in
> > > sched_clock_local() where unstable TSC and backward motion are
> > > detected. But, since early in boot interrupts are disabled, we cannot
> > > really correct invalid time, and therefore must rely on sched_clock()
> > > to provide us with a contiguous and sane time.
> >
> > In early boot the TSC frequency is not changing at all so the whole
> > unstable thing is completely irrelevant. And that also applies to backward
> > motion. There is no such thing during early boot.
> 
> Yes, however, the frequency changes slightly during re-calibration. I
> see it every time in my no-kvm qemu VM, and I think even on physical
> machine. Now, as you suggest below, I can remove the second
> calibration entirely, and keep only the early calibration, I am not
> sure what the historical reason to why linux has two of them in the

git log/blame exist for a reason and in case that does not work asking
around might give answers as well.

> first place. But, I assumed the later one was more precise because of
> some outside reasons, such as different cpu p-state, or something
> else.

cpu p->states are exactly the same. This is still early boot. Nothing has
fiddled with any of this.

> > > In earlier versions of this project, I was solving this problem by
> > > adjusting __sched_clock_offset every time sched_clock()'s continuity was
> > > changed by using a callback function into sched/clock.c. But, Peter was
> > > against that approach.
> >
> > So your changelog is completely misleading and utterly wrong. What the heck
> > has this to do with jiffies and the use_tsc jump label? Exactly nothing.
> 
> This output is what happens after: "sched: early sched_clock" but
> before"x86/tsc: use tsc early", hence the title of patch: "x86/tsc:
> prepare for early sched_clock"
> So, before  "x86/tsc: prepare for early sched_clock" we go from
> jiffies to real tsc, and thats where the problem happens. I assume
> theoretically, the same problem could happen if we can't calibrate TSC
> early, but succeed later. Now, this is, however, a moot point, as you
> suggest to remove the second calibration.

Please stop assuming things. Figure the root cause out, really.

> After thinking about this some more, in the future revision I will
> simply switch order for "x86/tsc: use tsc early" to go before  "sched:
> early sched_clock", since transitions jiffies -> tsc and tsc ->
> jiffies won't be possible with the changes you suggest below.
> 
> >
> > > [    0.004000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> > > [    0.009000] tsc: Fast TSC calibration using PIT
> > > [    0.010000] tsc: Detected 3192.137 MHz processor
> > > [    0.011000] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e03465ceb2,    max_idle_ns: 440795259855 ns
> >
> > > static_branch_enable(__use_tsc) is called, and timestamps became precise
> > > but reduced:
> >
> > > [    0.002233] Calibrating delay loop (skipped), value calculated using timer frequency..     6384.27 BogoMIPS (lpj=3192137)
> >
> > This is crap, because this is not what the current implementation does. The
> > current implementation enables the static branch when the early TSC sched
> > clock is enabled. So even the timestamps are crap because with the early
> > sched clock the time stamps are precise _before_ the timer interrupt is
> > initialized. That's the whole purpose of the exercise, right?
> >
> > This made me assume that its an existing problem. Heck, changelogs are
> > about facts and not fairy tales. And it's completely non interesting that
> > you observed this problem with some random variant of your patches. What's
> > interesting is the factual problem which makes the change necessary.
> 
> The changelog was about a fact, as stated above: output is from what
> happens after "sched: early sched_clock" but before "x86/tsc: use tsc
> early", (i.e.  "x86/tsc: use tsc early" might be reverted or
> bisected).

I can see the intention now, but this is exactly why precise wording and
problem description and root cause analysis matter. It just confused me
completely,

> For this particular patch, I politely asked for suggestions in cover letter:
> 
> v10-v11
>        - I added one more patch:
>           "x86/tsc: prepare for early sched_clock" which fixes a problem
>           that I discovered while testing. I am not particularly happy with
>           the fix, as it adds a new argument that is used only in one
>           place, but if you have a suggestion for a different approach on
>           how to address this problem please let me know.

Fair enough. I missed that. It would have been more obvious to mark the
patch RFC and add exactly this into the changelog.

Thanks,

	tglx
