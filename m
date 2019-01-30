Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 30 Jan 2019 13:15:18 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190130094913.GC5299@osiris>
Message-ID: <alpine.DEB.2.21.1901301303320.5537@nanos.tec.linutronix.de>
References: <20190128135804.GB28878@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129090108.GA26906@osiris> <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de> <20190129102409.GB26906@osiris>
 <20190129103557.GF28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de> <20190129132303.GE26906@osiris> <20190129151058.GG26906@osiris> <20190129171653.ycl64psq2liy5o5c@linutronix.de>
 <20190130094913.GC5299@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Jan 2019, Heiko Carstens wrote:
> On Tue, Jan 29, 2019 at 06:16:53PM +0100, Sebastian Sewior wrote:
> >  	if (unlikely(p->flags & PF_KTHREAD)) {
> >  		put_task_struct(p);
> 
> Last lines of the trace with your additional patch (full log attached):
> 
>            <...>-50539 [003] ....  2376.398223: sys_futex -> 0x0
>            <...>-50539 [003] ....  2376.398223: sys_futex(uaddr: 3ffb7700208, op: 6, val: 1, utime: 0, uaddr2: 3, val3: 0)
>            <...>-50539 [003] ....  2376.398225: attach_to_pi_owner: Missing pid 50734
>            <...>-50539 [003] ....  2376.398226: handle_exit_race: uval2 vs uval 8000c62e vs 8000c62e (-1)

So the user space value is: 8000c62e. FUTEX_WAITER bit is set and the owner
of the futex is PID 50734, which exited long time ago:

           <...>-50734 [000] ....  2376.394936: sched_process_exit: comm=ld64.so.1 pid=50734 prio=120

But at least from the kernel view 50734 has released it last:

           <...>-50734 [000] ....  2376.394930: sys_futex(uaddr: 3ffb7700208, op: 7, val: 3ff00000007, utime: 3ffb3ef8910, uaddr2: 3ffb3ef8910, val3: 3ffc0afe987)
           <...>-50539 [003] ....  2376.398223: sys_futex(uaddr: 3ffb7700208, op: 6, val: 1, utime: 0, uaddr2: 3, val3: 0)

Now, if it would have acquired it in userspace again before exiting, then
the robust list exit code should have set the OWNER_DIED bit as well, but
that's not set....

debug patch for the robust list exit handling below.

Thanks,

	tglx

8<-----------------
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3440,10 +3440,13 @@ static int handle_futex_death(u32 __user
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	trace_printk("uaddr: %lx pi: %d\n", (unsigned long) uaddr, pi);
 retry:
 	if (get_user(uval, uaddr))
 		return -1;
 
+	trace_printk("uaddr: %lx uval: %08x\n", (unsigned long) uaddr, uval);
+
 	if ((uval & FUTEX_TID_MASK) == task_pid_vnr(curr)) {
 		/*
 		 * Ok, this dying thread is truly holding a futex
@@ -3480,6 +3483,7 @@ static int handle_futex_death(u32 __user
 		if (!pi && (uval & FUTEX_WAITERS))
 			futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);
 	}
+	trace_printk("uaddr: %lx success\n", (unsigned long) uaddr);
 	return 0;
 }
 

 
