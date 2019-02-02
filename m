Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 2 Feb 2019 11:14:27 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
In-Reply-To: <20190202091043.GA3381@osiris>
Message-ID: <alpine.DEB.2.21.1902021027060.8200@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de> <20190130210733.mg6aascw2gzl3oqz@linutronix.de> <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de> <20190130233557.GA4240@linux.ibm.com> <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de> <20190131165228.GA32680@osiris> <20190131170653.spnrxsiblkssleyd@linutronix.de> <20190201161227.GG3770@osiris> <alpine.DEB.2.21.1902012258290.8200@nanos.tec.linutronix.de>
 <20190202091043.GA3381@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 2 Feb 2019, Heiko Carstens wrote:
> On Fri, Feb 01, 2019 at 10:59:08PM +0100, Thomas Gleixner wrote:
> > Were you able to capture a trace with the last set of additional trace
> > printks?
> 
> Of course I forgot to collect that, sorry! But just reproduced; see
> log below (last 1000 lines) and attachment for full log.

The failing futex is here:

<...>-48786 [002] ....   337.231645: sys_futex(uaddr: 3ff90c00460, op: 6, val: 1, utime: 0, uaddr2: 4, val3: 0)
<...>-48786 [002] ....   337.231646: attach_to_pi_owner: Missing pid 49011
<...>-48786 [002] ....   337.231646: handle_exit_race: uval2 vs uval 8000bf73 vs 8000bf73 (-1)
<...>-48786 [002] ....   337.231741: sys_futex -> 0xfffffffffffffffd

Lets look were it was handled in the kernel right before that:

<...>-49014 [006] ....   337.215675: sys_futex(uaddr: 3ff90c00460, op: 7, val: 3ff00000007, utime: 3ff8d3f8910, uaddr2: 3ff8d3f8910, val3: 3ffc64fe8f7)
<...>-49014 [006] ....   337.215675: do_futex: uaddr: 3ff90c00460 cur: 8000bf76 new: 0

49014 unlocks the futex in the kernel and due to lack of waiters it sets it
to unlocked ---> new: 0.

Between this and the failing sys_futex() invocation, the missing task exits:

<...>-49011 [000] ....   337.221543: handle_futex_death: uaddr: 3ff90c00a00 pi: 1
...
<...>-49011 [000] ....   337.221547: handle_futex_death: uaddr: 3ff90c00488 success
<...>-49011 [000] ....   337.221548: sched_process_exit: comm=ld64.so.1 pid=49011 prio=120

but it does not have futex 3ff90c00460 in its robust list.

So after the unlock @timestamp 337.215675 the kernel does not deal with
that futex at all until the failed lock attempt where it rightfully rejects
the attempt due to the alleged owner being gone.

So this looks more like user space doing something stupid...

As we talked about the missing barriers before, I just looked at
pthread_mutex_trylock() and that does still:

	if (robust)
          {
            ENQUEUE_MUTEX_PI (mutex);
            THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
          }

So it's missing the barriers which pthread_mutex_lock() has. Grasping for
straws obviously....

Thanks,

	tglx
