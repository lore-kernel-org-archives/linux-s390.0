Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 30 Jan 2019 15:35:57 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggerede
Reply-To: paulmck@linux.ibm.com
References: <20190129171653.ycl64psq2liy5o5c@linutronix.de>
 <20190130094913.GC5299@osiris>
 <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
 <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
 <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
 <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901302314590.8200@nanos.tec.linutronix.de>
Message-Id: <20190130233557.GA4240@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jan 31, 2019 at 12:13:51AM +0100, Thomas Gleixner wrote:
> On Wed, 30 Jan 2019, Sebastian Sewior wrote:
> 
> > On 2019-01-30 18:56:54 [+0100], Thomas Gleixner wrote:
> > > TBH, no clue. Below are some more traceprintks which hopefully shed some
> > > light on that mystery. See kernel/futex.c line 30  ...
> > 
> > The robust list it somehow buggy. In the last trace we had the
> > handle_futex_death() of uaddr 3ff9e880140 as the last action. That means
> > it was an entry in 56496's ->list_op_pending entry. This makes sense
> > because it tried to acquire the lock, failed, got killed.
> 
> The robust list of the failing task seems to be correct. 
> 
> > According to uaddr pid 56956 is the owner. So 56956 invoked one of
> > pthread_mutex_lock() / pthread_mutex_timedlock() /
> > pthread_mutex_trylock() and should have obtained the lock in userland.
> > Depending on where it got killed, that mutex should be either recorded in
> > ->list_op_pending or the robust_list (or both if it didn't clear
> > ->list_op_pending yet). But it is not.
> > Similar for pthread_mutex_unlock().
> 
> > We don't have a trace_point if we abort processing the list.
> 
> The only reason why it would abort is due a page fault because that cannot
> be handled in the exit code anymore.
> 
> > On the other hand, it didn't trigger on x86 for hours. Could the atomic
> 
> s/hours/days/ ....
> 
> > ops be the culprit?
> 
> The glibc code does:
> 
>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending,
>        		     (void *) (((uintptr_t) &mutex->__data.__list.__next)
>                                    | 1));
> 
>        ....
>        lock in user space
> 
>        or
> 
>        lock in kernel space
> 
>        ENQUEUE_MUTEX_PI (mutex);
>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> 
>        ENQUEUE_MUTEX_PI() resolves to a THREAD_GETMEM() which reads the
>        list head from TLS, some list manipulation operations and the final
>        THREAD_SETMEM() which stores the new list head
> 
> Now on x86 THREAD_GETMEM() and THREAD_SETMEM() are resolving to
> 
>     asm volatile ("movX .....")
> 
> on s390 they are
> 
>    descr->member
> 
> based operations.
> 
> Now the important part of the robust list is the store sequence, i.e. the
> list head and final update to the TLS visible part need to come _before_
> list_op_pending is cleared.
> 
> I might be missing something, but there is no compiler barrier in that code
> which would prevent the compiler from reordering the stores. It can
> rightfully do so because there is no compiler visible dependency of these
> two operations.
> 
> On x8664 the asm volatile might prevent it by chance, but it does not have
> a 'memory' specified which would guarantee a compiler barrier.
> 
> On s390 there is certainly nothing.
> 
> So assumed that clearing list_op_pending comes before the list head update,
> then the robust exit code in the kernel will fail to see either of
> them. FAIL.
> 
> I might be wrong as usual, but this would definitely explain the fail very
> well.

On recent versions of GCC, the fix would be to put this between the two
stores that need ordering:

	__atomic_thread_fence(__ATOMIC_RELEASE);

I must defer to Heiko on whether s390 GCC might tear the stores.  My
guess is "probably not".  ;-)

							Thanx, Paul
