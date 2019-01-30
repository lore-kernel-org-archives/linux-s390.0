Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 31 Jan 2019 00:55:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
In-Reply-To: <20190130233557.GA4240@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1901310049440.8200@nanos.tec.linutronix.de>
References: <20190129171653.ycl64psq2liy5o5c@linutronix.de> <20190130094913.GC5299@osiris> <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de> <20190130125955.GD5299@osiris> <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de> <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de> <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de> <20190130233557.GA4240@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Jan 2019, Paul E. McKenney wrote:
> On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> > I might be wrong as usual, but this would definitely explain the fail very
> > well.
> 
> On recent versions of GCC, the fix would be to put this between the two
> stores that need ordering:
> 
> 	__atomic_thread_fence(__ATOMIC_RELEASE);
> 
> I must defer to Heiko on whether s390 GCC might tear the stores.  My
> guess is "probably not".  ;-)

So I just checked the latest glibc code. It has:

            /* We must not enqueue the mutex before we have acquired it.
               Also see comments at ENQUEUE_MUTEX.  */
            __asm ("" ::: "memory");
            ENQUEUE_MUTEX_PI (mutex);
            /* We need to clear op_pending after we enqueue the mutex.  */
            __asm ("" ::: "memory");
            THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);

8f9450a0b7a9 ("Add compiler barriers around modifications of the robust mutex list.")

in the glibc repository, There since Dec 24 2016 ...

So the question is whether this is sufficient. That ordering only only
matters vs. the thread itself and not for others.

Thanks,

	tglx
