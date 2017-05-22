Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <alpine.DEB.2.20.1705211859410.3023@nanos>
References: <20170516114812.10660-1-hch@lst.de>
 <CAK8P3a1FoR_usw7du3ZRMF+PPhJ712EpArL_e1bLVNs7BYBu-w@mail.gmail.com>
 <20170516155132.GA1494@lst.de>
 <CAK8P3a3_Rjz9gTmayN1w8HrFHWY+wakeFgQSYRTAADJzF6zKJA@mail.gmail.com>
 <alpine.DEB.2.20.1705211859410.3023@nanos>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 May 2017 15:32:24 +0200
Message-ID: <CAK8P3a0uF-=7Ot16YpsyuZHVaoE1rLR6q7w5r4+uXkaVdPHT4A@mail.gmail.com>
Subject: Re: RFC: better timer interface
Content-Type: text/plain; charset="UTF-8"
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mark Gross <mark.gross@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, May 21, 2017 at 7:13 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 16 May 2017, Arnd Bergmann wrote:
>> On Tue, May 16, 2017 at 5:51 PM, Christoph Hellwig <hch@lst.de> wrote:
>> > Yes, that sounds useful to me as well.  As you said it's an independent
>> > but somewhat related change.  I can add it to my series, but I'll
>> > need a suggestions for a good and short name.  That already was the
>> > hardest part for the setup side :)
>>
>> If we keep the unusual *_timer() naming (rather than timer_*() as hrtimer
>> has), we could use one of
>>
>> a) start_timer(struct timer_list *timer, unsigned long ms);
>> b) restart_timer(struct timer_list *timer, unsigned long ms);
>> c) mod_timer_ms(struct timer_list *timer, unsigned long ms);
>>     mod_timer_sec(struct timer_list *timer, unsigned long sec);
>
> Please make new functions prefixed with timer_ and get rid of that old
> interface completely. It's horrible.
>
> timer_init()
> timer_start(timer, ms, abs)
> timer_start_on(timer, ms, abs, cpu)
> timer_cancel(timer, sync)
>
> Is all what's required to make up a new milliseconds based interface.
>
> We really do not need all that mod/restart/ whatever variants. Where is the
> point of those?

I agree, one of the above is good enough, if we do the large-scale API
replacement. Having both ms and sec variants would be for convenience
to avoid having lots of open-coded  '*MSEC_PER_SEC) multiplications.

We still need at least three variants of timer_init, for statically initialized
timers, dynamic allocation and on-stack allocation, as before.

For the 'abs' argument, I'd probably leave that out until we find code
that actually needs it and that can't use hrtimer as easily.

For timer_start_on(), that would be a replacement of add_timer_on(),
which only has seven callers today:

arch/x86/kernel/apic/x2apic_uv_x.c:             add_timer_on(timer, cpu);
drivers/tty/metag_da.c: add_timer_on(poll_timer, 0);
drivers/tty/mips_ejtag_fdc.c:
add_timer_on(&priv->poll_timer, dev->cpu);
drivers/tty/mips_ejtag_fdc.c:
add_timer_on(&priv->poll_timer, dev->cpu);
kernel/time/clocksource.c:      add_timer_on(&watchdog_timer, next_cpu);
kernel/time/clocksource.c:      add_timer_on(&watchdog_timer,
cpumask_first(cpu_online_mask));
kernel/workqueue.c:             add_timer_on(timer, cpu);

If hrtimer isn't already a better interface for those, we can probably
convert them all to the new API at once.

       Arnd
