Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 22:45:52 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
In-Reply-To: <20190129171653.ycl64psq2liy5o5c@linutronix.de>
Message-ID: <alpine.DEB.2.21.1901292230430.1950@nanos.tec.linutronix.de>
References: <20190128134410.GA28485@hirez.programming.kicks-ass.net> <20190128135804.GB28878@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de> <20190129090108.GA26906@osiris> <alpine.DEB.2.21.1901291012330.1669@nanos.tec.linutronix.de>
 <20190129102409.GB26906@osiris> <20190129103557.GF28485@hirez.programming.kicks-ass.net> <alpine.DEB.2.21.1901291402410.1513@nanos.tec.linutronix.de> <20190129132303.GE26906@osiris> <20190129151058.GG26906@osiris>
 <20190129171653.ycl64psq2liy5o5c@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1399204439-1548798352=:1950"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1399204439-1548798352=:1950
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 29 Jan 2019, Sebastian Sewior wrote:

> On 2019-01-29 16:10:58 [+0100], Heiko Carstens wrote:
> > Finally... the trace output is quite large with 26 MB... Therefore an
> > xz compressed attachment. Hope that's ok.
> > 
> > The kernel used was linux-next 20190129 + your patch.
> |        ld64.so.1-10237 [006] .... 14232.031726: sys_futex(uaddr: 3ff88e80618, op: 7, val: 3ff00000007, utime: 3ff88e7f910, uaddr2: 3ff88e7f910, val3: 3ffc167e8d7)
> FUTEX_UNLOCK_PI | SHARED
> 
> |        ld64.so.1-10237 [006] .... 14232.031726: sys_futex -> 0x0
> …
> |        ld64.so.1-10237 [006] .... 14232.051751: sched_process_exit: comm=ld64.so.1 pid=10237 prio=120
> …
> |        ld64.so.1-10148 [006] .... 14232.061826: sys_futex(uaddr: 3ff88e80618, op: 6, val: 1, utime: 0, uaddr2: 2, val3: 0)
> FUTEX_LOCK_PI | SHARED
> 
> |        ld64.so.1-10148 [006] .... 14232.061826: sys_futex -> 0xfffffffffffffffd
> 
> So there got to be another task that acquired the lock in userland and
> left since the last in kernel-user unlocked it. This might bring more

Well, that would mean that this very task did not have a valid robust list,
which is very unlikely according to the test case.

We might actually stick a trace point into the robust list code as well.

> light to it:
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 599da35c2768..aaa782a8a115 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -1209,6 +1209,9 @@ static int handle_exit_race(u32 __user *uaddr, u32 uval,
>  	 * corrupted or the user space value in *uaddr is simply bogus.
>  	 * Give up and tell user space.
>  	 */
> +	trace_printk("uval2 vs uval %08x vs %08x (%d)\n", uval2, uval,
> +		     tsk ? tsk->pid : -1);
> +	__WARN();
>  	return -ESRCH;
>  }
>  
> @@ -1233,8 +1236,10 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
>  	if (!pid)
>  		return -EAGAIN;
>  	p = find_get_task_by_vpid(pid);
> -	if (!p)
> +	if (!p) {
> +		trace_printk("Missing pid %d\n", pid);
>  		return handle_exit_race(uaddr, uval, NULL);
> +	}
>  
>  	if (unlikely(p->flags & PF_KTHREAD)) {
>  		put_task_struct(p);

Yep, that should give us some more clue.

> I am not sure, but isn't this the "known" issue where the kernel drops
> ESRCH in a valid case and glibc upstream does not recognize it because
> it is not a valid /POSIX-defined error code? (I *think* same is true for
> -ENOMEM) If it is, the following C snippet is a small tc:

That testcase is not using robust futexes, but yes it's demonstrating the
glibc does not handle all documented error codes. But I don't think it has
anything to do with the problem at hand. Famous last words....

Thanks,

	tglx

--8323329-1399204439-1548798352=:1950--
