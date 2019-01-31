Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 31 Jan 2019 17:52:28 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
References: <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
 <20190130233557.GA4240@linux.ibm.com>
 <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901310117110.8200@nanos.tec.linutronix.de>
Message-Id: <20190131165228.GA32680@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 31, 2019 at 01:27:25AM +0100, Thomas Gleixner wrote:
> On Thu, 31 Jan 2019, Thomas Gleixner wrote:
> 
> > On Wed, 30 Jan 2019, Paul E. McKenney wrote:
> > > On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> > > > I might be wrong as usual, but this would definitely explain the fail very
> > > > well.
> > > 
> > > On recent versions of GCC, the fix would be to put this between the two
> > > stores that need ordering:
> > > 
> > > 	__atomic_thread_fence(__ATOMIC_RELEASE);
> > > 
> > > I must defer to Heiko on whether s390 GCC might tear the stores.  My
> > > guess is "probably not".  ;-)
> > 
> > So I just checked the latest glibc code. It has:
> > 
> >             /* We must not enqueue the mutex before we have acquired it.
> >                Also see comments at ENQUEUE_MUTEX.  */
> >             __asm ("" ::: "memory");
> >             ENQUEUE_MUTEX_PI (mutex);
> >             /* We need to clear op_pending after we enqueue the mutex.  */
> >             __asm ("" ::: "memory");
> >             THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> > 
> > 8f9450a0b7a9 ("Add compiler barriers around modifications of the robust mutex list.")
> > 
> > in the glibc repository, There since Dec 24 2016 ...
> 
> And of course, I'm using the latest greatest glibc for testing that, so I'm
> not at all surprised that it just does not reproduce on my tests.

As discussed on IRC: I used plain vanilla glibc version 2.28 for my
tests. This version already contains the commit you mentioned above.

> I just hacked the ordering and restarted the test. If the theory holds,
> then this should die sooner than later.

...nevertheless Stefan and I looked through the lovely disassembly of
_pthread_mutex_lock_full() to verify if the compiler barriers are
actually doing what they are supposed to do. The generated code
however does look correct.
So, it must be something different.
