Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
 <20180718022211.6259-25-pasha.tatashin@oracle.com> <20180719103903.GB2494@hirez.programming.kicks-ass.net>
In-Reply-To: <20180719103903.GB2494@hirez.programming.kicks-ass.net>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 19 Jul 2018 10:16:34 -0400
Message-ID: <CAGM2rebsqJUBSVhN3Ug=wYA+uYzKF06P4afDqEApaWk0bK8-zQ@mail.gmail.com>
Subject: Re: [PATCH v14 24/25] sched: early boot clock
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: peterz@infradead.org
Cc: Steven Sistare <steven.sistare@oracle.com>, Daniel Jordan <daniel.m.jordan@oracle.com>, linux@armlinux.org.uk, schwidefsky@de.ibm.com, Heiko Carstens <heiko.carstens@de.ibm.com>, John Stultz <john.stultz@linaro.org>, sboyd@codeaurora.org, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, prarit@redhat.com, feng.tang@intel.com, Petr Mladek <pmladek@suse.com>, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 19, 2018 at 6:40 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 17, 2018 at 10:22:10PM -0400, Pavel Tatashin wrote:
>
> > diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> > index 0e9dbb2d9aea..7a8a63b940ee 100644
> > --- a/kernel/sched/clock.c
> > +++ b/kernel/sched/clock.c
> > @@ -202,7 +202,15 @@ static void __sched_clock_gtod_offset(void)
> >
> >  void __init sched_clock_init(void)
> >  {
> > +     unsigned long flags;
> > +
> >       sched_clock_running = 1;
> > +
> > +     /* Adjust __gtod_offset for contigious transition from early clock */
> > +     local_irq_save(flags);
> > +     sched_clock_tick();
> > +     local_irq_restore(flags);
> > +     __sched_clock_gtod_offset();
>
> I think we want to keep __sched_clock_gtod_offset() inside the IRQ
> disabled region.

Fixed.

>
> And I just looked at my patch:
>
>   https://lkml.kernel.org/r/20180626090003.GA2458@hirez.programming.kicks-ass.net
>
> and that had a comment about how we wanted to set the gtod offset
> _before_ setting sched_clock_running, yet here you do it the other way
> around. Hmm?

Fixed, and added your comment.

Thank you,
Pavel
