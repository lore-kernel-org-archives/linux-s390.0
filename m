Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 11:24:09 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
 <20190129090108.GA26906@osiris>
 <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
Message-Id: <20190129102409.GB26906@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jan 29, 2019 at 10:45:44AM +0100, Thomas Gleixner wrote:
> On Tue, 29 Jan 2019, Heiko Carstens wrote:
> > On Mon, Jan 28, 2019 at 04:53:19PM +0100, Thomas Gleixner wrote:
> > > Patch below cures that.
> > 
> > With your patch the kernel warning doesn't occur anymore. So if this
> > is supposed to be the fix feel free to add:
> 
> Yes, it's supposed to be the fix.
> > 
> > However now I see every now and then the following failure from the
> > same test case:
> > 
> > tst-robustpi8: ../nptl/pthread_mutex_lock.c:425: __pthread_mutex_lock_full: Assertion `INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust' failed.
> > 
> > 		/* ESRCH can happen only for non-robust PI mutexes where
> > 		   the owner of the lock died.	*/
> > 		assert (INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust);
> > 
> > I just verified that this happened also without your patch, I just
> > didn't see it since I started my tests with panic_on_warn=1 and the
> > warning triggered always earlier.
> > So, this seems to be something different.
> 
> Moo. I ran the test loop all night (simply because I forgot to stop it) and
> of course this does not trigger here. Could you try to gather a bit more
> information with lightweight tracing?

Yes, sure. However ;) I reproduced the above with v5.0-rc4 + your
patch. And now I am trying to reproduce with linux-next 20190129 +
your patch and it doesn't trigger. Did I miss a patch which is only in
linux-next which could fix this?
