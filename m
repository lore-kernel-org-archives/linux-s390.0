Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 30 Jan 2019 15:33:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de> <20190129102409.GB26906@osiris> <20190129103557.GF28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de> <20190129132303.GE26906@osiris>
 <20190129151058.GG26906@osiris> <20190129171653.ycl64psq2liy5o5c@linutronix.de> <20190130094913.GC5299@osiris> <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de> <20190130125955.GD5299@osiris> <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1894196896-1548858839=:1950"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1894196896-1548858839=:1950
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 30 Jan 2019, Thomas Gleixner wrote:
> On Wed, 30 Jan 2019, Sebastian Sewior wrote:
> 
> > On 2019-01-30 13:59:55 [+0100], Heiko Carstens wrote:
> > > Last lines of trace below (full log attached):
> > 
> >             <...>-56956 [005] ....   658.931364: handle_futex_death: uaddr: 3ff9e880c58 pi: 1
> > …
> >             <...>-56956 [005] ....   658.931369: handle_futex_death: uaddr: 3ff9e8808c0 success
> >             <...>-56956 [005] ....   658.931370: sched_process_exit: comm=ld64.so.1 pid=56956 prio=120
> > 
> > not including 3ff9e880140
> > 
> >             <...>-56956 [005] ....   658.931370: sched_process_exit: comm=ld64.so.1 pid=56956 prio=120
> > 
> >             <...>-56496 [001] ....   658.932404: sys_futex(uaddr: 3ff9e880140, op: 6, val: 1, utime: 0, uaddr2: 5, val3: 0)
> >             <...>-56496 [001] ....   658.932405: attach_to_pi_owner: Missing pid 56956
> >             <...>-56496 [001] ....   658.932406: handle_exit_race: uval2 vs uval 8000de7c vs 8000de7c (-1)
> >             <...>-56496 [001] ....   658.932501: sys_futex -> 0xfffffffffffffffd
> > …
> >             <...>-56496 [001] ....   659.020750: handle_futex_death: uaddr: 3ff9e880140 pi: 1
> >             <...>-56496 [001] ....   659.020750: handle_futex_death: uaddr: 3ff9e880140 uval: 8000de7c
> >             <...>-56496 [001] ....   659.020750: handle_futex_death: uaddr: 3ff9e880140 success
> > 
> > and here we have it.

Well no. That futex is in the robust list of the dying task because it
tried to lock it and then died probably before removing itself from the
robust list.

handle_futex_death() of that task does not touch it because the userspace
TID value is de7c which is 56956.

The last entries with that uaddr are:

          <...>-56956 [005] ....   658.923608: sys_futex(uaddr: 3ff9e880140, op: 7, val: 3ff00000007, utime: 3ff9b078910, uaddr2: 3ff9b078910, val3: 3ffea67e3f7)

UNLOCK

           <...>-56945 [006] ....   658.923612: sys_futex(uaddr: 3ff9e880140, op: 6, val: 1, utime: 1003ff0, uaddr2: 3ff9e87f910, val3: 3ff0000de71)

LOCK

           <...>-56956 [005] ....   658.923612: sys_futex(uaddr: 3ff9e880140, op: 7, val: 3ff00000007, utime: 3ff9b078910, uaddr2: 3ff9b078910, val3: 3ffea67e3f7)

UNLOCK

           <...>-56945 [006] ....   658.923830: sys_futex(uaddr: 3ff9e880140, op: 7, val: 3ff00000007, utime: 3ff9e87f910, uaddr2: 3ff9e87f910, val3: 3ffea67e3f7)

UNLOCK

           <...>-56496 [001] ....   658.932404: sys_futex(uaddr: 3ff9e880140, op: 6, val: 1, utime: 0, uaddr2: 5, val3: 0)

LOCK which fails.

This does not make any sense. The last kernel visible operation of 56956 on
that uaddr is the UNLOCK above.

I need to think some more about what might happen.

Thanks,

	tglx




--8323329-1894196896-1548858839=:1950--
