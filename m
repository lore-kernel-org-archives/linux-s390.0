Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 28 Jan 2019 14:58:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190128135804.GB28878@hirez.programming.kicks-ass.net>
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128134410.GA28485@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 28, 2019 at 02:44:10PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:
> 
> > And indeed, if I run only this test case in an endless loop and do
> > some parallel work (like kernel compile) it currently seems to be
> > possible to reproduce the warning:
> > 
> > while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> > 
> > within the build directory of glibc (2.28).
> 
> Right; so that reproduces for me.
> 
> After staring at all that for a while; trying to remember how it all
> worked (or supposed to work rather), I became suspiscous of commit:
> 
>   56222b212e8e ("futex: Drop hb->lock before enqueueing on the rtmutex")
> 
> And indeed, when I revert that; the above reproducer no longer works (as
> in, it no longer triggers in minutes and has -- so far -- held up for an
> hour+ or so).
> 
> That patch in particular allows futex_unlock_pi() to 'start' early:
> 
> 
> futex_lock_pi()			futex_unlock_pi()
>   lock hb
>   queue
>   lock wait_lock
>   unlock hb
> 					lock hb
> 					futex_top_waiter
> 					get_pi_state
> 					lock wait_lock
>   rt_mutex_proxy_start // fail
>   unlock wait_lock
> 					// acquired wait_lock
					unlock hb
> 					wake_futex_pi()
> 					rt_mutex_next_owner() // whoops, no waiter
> 					WARN

and simply removing that WARN, would allow futex_unlock_pi() to spin on
retry until the futex_lock_pi() CPU comes around to doing the lock hb
below:

>   lock hb
>   unqueue_me_pi

Which seems undesirable from a determinsm POV.
