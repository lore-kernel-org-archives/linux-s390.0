Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 10:01:08 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
Message-Id: <20190129090108.GA26906@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 28, 2019 at 04:53:19PM +0100, Thomas Gleixner wrote:
> On Mon, 28 Jan 2019, Peter Zijlstra wrote:
> > On Mon, Jan 28, 2019 at 02:44:10PM +0100, Peter Zijlstra wrote:
> > > On Thu, Nov 29, 2018 at 12:23:21PM +0100, Heiko Carstens wrote:
> > > 
> > > > And indeed, if I run only this test case in an endless loop and do
> > > > some parallel work (like kernel compile) it currently seems to be
> > > > possible to reproduce the warning:
> > > > 
> > > > while true; do time ./testrun.sh nptl/tst-robustpi8 --direct ; done
> > > > 
> > > > within the build directory of glibc (2.28).
> > > 
> > > Right; so that reproduces for me.
> > > 
> > > After staring at all that for a while; trying to remember how it all
> > > worked (or supposed to work rather), I became suspiscous of commit:
> > > 
> > >   56222b212e8e ("futex: Drop hb->lock before enqueueing on the rtmutex")
> > > 
> > > And indeed, when I revert that; the above reproducer no longer works (as
> > > in, it no longer triggers in minutes and has -- so far -- held up for an
> > > hour+ or so).
> 
> Right after staring long enough at it, the commit simply forgot to give
> __rt_mutex_start_proxy_lock() the same treatment as it gave to
> rt_mutex_wait_proxy_lock().
> 
> Patch below cures that.

With your patch the kernel warning doesn't occur anymore. So if this
is supposed to be the fix feel free to add:

Tested-by: Heiko Carstens <heiko.carstens@de.ibm.com>


However now I see every now and then the following failure from the
same test case:

tst-robustpi8: ../nptl/pthread_mutex_lock.c:425: __pthread_mutex_lock_full: Assertion `INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust' failed.

		/* ESRCH can happen only for non-robust PI mutexes where
		   the owner of the lock died.	*/
		assert (INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust);

I just verified that this happened also without your patch, I just
didn't see it since I started my tests with panic_on_warn=1 and the
warning triggered always earlier.
So, this seems to be something different.
