Return-Path: <tglx@linutronix.de>
Date: Mon, 22 May 2017 21:14:36 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: RFC: better timer interface
In-Reply-To: <CAK8P3a0uF-=7Ot16YpsyuZHVaoE1rLR6q7w5r4+uXkaVdPHT4A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1705222106390.2407@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
 <alpine.DEB.2.20.1705211859410.3023@nanos>
 <CAK8P3a0uF-=7Ot16YpsyuZHVaoE1rLR6q7w5r4+uXkaVdPHT4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 22 May 2017, Arnd Bergmann wrote:
> On Sun, May 21, 2017 at 7:13 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> I agree, one of the above is good enough, if we do the large-scale API
> replacement. Having both ms and sec variants would be for convenience
> to avoid having lots of open-coded  '*MSEC_PER_SEC) multiplications.

Right, but that _sec variant is just a wrapper around the _ms functionality.

> We still need at least three variants of timer_init, for statically initialized
> timers, dynamic allocation and on-stack allocation, as before.

Again, that's variants. What I wanted to avoid is that mod_ restart_ start_
whatever distinction. It's pointless.

> For the 'abs' argument, I'd probably leave that out until we find code
> that actually needs it and that can't use hrtimer as easily.

> For timer_start_on(), that would be a replacement of add_timer_on(),
> which only has seven callers today:

> arch/x86/kernel/apic/x2apic_uv_x.c:             add_timer_on(timer, cpu);
> drivers/tty/metag_da.c: add_timer_on(poll_timer, 0);
> drivers/tty/mips_ejtag_fdc.c:
> add_timer_on(&priv->poll_timer, dev->cpu);
> drivers/tty/mips_ejtag_fdc.c:
> add_timer_on(&priv->poll_timer, dev->cpu);
> kernel/time/clocksource.c:      add_timer_on(&watchdog_timer, next_cpu);
> kernel/time/clocksource.c:      add_timer_on(&watchdog_timer,
> cpumask_first(cpu_online_mask));
> kernel/workqueue.c:             add_timer_on(timer, cpu);
> 
> If hrtimer isn't already a better interface for those, we can probably
> convert them all to the new API at once.

Some of them certainly can be converted. Though I'm starting to worry about
massive hrtimer usage, which can really become a burden because the expiry
functions run from hard interrupt context. We already have this horrible
construct of hrtimer -> tasklet -> real function, which is used to get the
hrtimer expiry out into softirq context.

We have similar issue in RT, where we need to move out everything which is
not hard irq safe to softirq context. I'm working on a solution there which
is less ugly than what we have now in RT. It's moving non irq safe timers
onto a different time base, e.g. MONOTONIC_SOFT, which merily wakes the
softirq when the first queued timer expires and let that one sort out the
expiry of those timers. It's WIP and should be available soon.

Thanks,

	tglx
