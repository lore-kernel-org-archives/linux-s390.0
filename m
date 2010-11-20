Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 20 Nov 2010 16:17:11 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 0/4] taskstats: Improve cumulative time accounting
Message-ID: <20101120151711.GA3019@redhat.com>
References: <20101119201108.269346583@linux.vnet.ibm.com> <1290197955.2109.1617.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1290197955.2109.1617.camel@laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 11/19, Peter Zijlstra wrote:
>
> On Fri, 2010-11-19 at 21:11 +0100, Michael Holzheu wrote:
> > Due to POSIX POSIX.1-2001, the CPU time of processes is not accounted
> > to the cumulative time of the parents, if the parents ignore SIGCHLD
> > or have set SA_NOCLDWAIT. This behaviour has the major drawback that
> > it is not possible to calculate all consumed CPU time of a system by
> > looking at the current tasks. CPU time can be lost.
> >
> > To solve this problem, this patch set duplicates the cumulative accounting
> > data in the signal_struct. In the second set (cdata_acct) the complete
> > cumulative resource counters are stored. The new cumulative CPU time (utime
> > and stime) is then exported via the taskstats interface.
>
> Maybe this has been treated earlier in the threads and I missed it, but
> the obvious solution doesn't get mentioned:

IIRC, the first version did this.

And it was me who spoiled this approach. But! only because I wasn't sure
this user-visible change is acceptable, and because there was some
misunderstanding. See http://marc.info/?l=linux-kernel&m=128552495203050&w=2

But,

> What would break if we

say, any test-case which does getrusage() after fork() with ignored
SIGCHLD/SA_NOCLDWAIT?.

> violate this silly POSIX rule and account time of
> childs regardless of SIGCHLD/SA_NOCLDWAIT?

+1.

Personally, I'd certainly prefer this way, because I don't care about
POSIX at all ;)


Still. Once again, this breaks the current rules, and we never do
this without strong reason.

I think we should ask Roland. If he thinks this is OK, I'd certainly
agree.

Oleg.
