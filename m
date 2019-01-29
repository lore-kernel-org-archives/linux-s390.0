Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 10:45:44 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190129090108.GA26906@osiris>
Message-ID: <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
References: <20181127081115.GB3625@osiris> <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de> <20181129112321.GB3449@osiris> <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129090108.GA26906@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Tue, 29 Jan 2019, Heiko Carstens wrote:
> On Mon, Jan 28, 2019 at 04:53:19PM +0100, Thomas Gleixner wrote:
> > Patch below cures that.
> 
> With your patch the kernel warning doesn't occur anymore. So if this
> is supposed to be the fix feel free to add:

Yes, it's supposed to be the fix.
> 
> However now I see every now and then the following failure from the
> same test case:
> 
> tst-robustpi8: ../nptl/pthread_mutex_lock.c:425: __pthread_mutex_lock_full: Assertion `INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust' failed.
> 
> 		/* ESRCH can happen only for non-robust PI mutexes where
> 		   the owner of the lock died.	*/
> 		assert (INTERNAL_SYSCALL_ERRNO (e, __err) != ESRCH || !robust);
> 
> I just verified that this happened also without your patch, I just
> didn't see it since I started my tests with panic_on_warn=1 and the
> warning triggered always earlier.
> So, this seems to be something different.

Moo. I ran the test loop all night (simply because I forgot to stop it) and
of course this does not trigger here. Could you try to gather a bit more
information with lightweight tracing?

Something like the below should give us at least a clue. Stop the tst loop
when the assert triggers and then extract the trace.

Thanks,

	tglx

8<--------------

#!/bin/sh

# Substitute with your ld comm string if it starts differently 
C=ld-linux

echo 'comm ~ "$C*"' >/sys/kernel/debug/tracing/events/syscalls/sys_enter_futex/filter
echo 'comm ~ "$C*"' >/sys/kernel/debug/tracing/events/syscalls/sys_exit_futex/filter
echo 'comm ~ "$C*"' >/sys/kernel/debug/tracing/events/sched/sched_process_exit/filter
echo 'prev_comm ~ "$C*" || next_comm ~ "$C*"' >/sys/kernel/debug/tracing/events/sched/sched_switch/filter

echo 1 > /sys/kernel/debug/tracing/events/syscalls/sys_enter_futex/enable
echo 1 > /sys/kernel/debug/tracing/events/syscalls/sys_exit_futex/enable
echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_exit/enable
echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
