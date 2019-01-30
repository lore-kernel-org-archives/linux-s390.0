Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 30 Jan 2019 22:07:33 +0100
From: Sebastian Sewior <bigeasy@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190130210733.mg6aascw2gzl3oqz@linutronix.de>
References: <20190129132303.GE26906@osiris>
 <20190129151058.GG26906@osiris>
 <20190129171653.ycl64psq2liy5o5c@linutronix.de>
 <20190130094913.GC5299@osiris>
 <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
 <20190130125955.GD5299@osiris>
 <20190130132420.spwrq2d4oxeydk5s@linutronix.de>
 <alpine.DEB.2.21.1901301428390.5537@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301517220.1950@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901301853290.1622@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 2019-01-30 18:56:54 [+0100], Thomas Gleixner wrote:
> TBH, no clue. Below are some more traceprintks which hopefully shed some
> light on that mystery. See kernel/futex.c line 30  ...

The robust list it somehow buggy. In the last trace we had the
handle_futex_death() of uaddr 3ff9e880140 as the last action. That means
it was an entry in 56496's ->list_op_pending entry. This makes sense
because it tried to acquire the lock, failed, got killed.

According to uaddr pid 56956 is the owner. So 56956 invoked one of
pthread_mutex_lock() / pthread_mutex_timedlock() /
pthread_mutex_trylock() and should have obtained the lock in userland.
Depending on where it got killed, that mutex should be either recorded
in ->list_op_pending or the robust_list (or both if it didn't clear
->list_op_pending yet). But it is not.
Similar for pthread_mutex_unlock().
We don't have a trace_point if we abort processing the list.
On the other hand, it didn't trigger on x86 for hours. Could the atomic
ops be the culprit?

> Thanks,
> 
> 	tglx

Sebastian
