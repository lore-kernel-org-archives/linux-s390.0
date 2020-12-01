Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387833AbgLANje (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Dec 2020 08:39:34 -0500
Date: Tue, 1 Dec 2020 13:38:47 +0000
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201201133846.GA26973@willie-the-truck>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
 <20201130210003.GA40619@roeck-us.net>
 <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
 <yt9dh7p54u50.fsf@linux.ibm.com>
 <20201201125246.GV2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125246.GV2414@hirez.programming.kicks-ass.net>
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Tue, Dec 01, 2020 at 01:52:46PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 12:56:27PM +0100, Sven Schnelle wrote:
> > Peter Zijlstra <peterz@infradead.org> writes:
> > > On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
> > >> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> > >> > We call arch_cpu_idle() with RCU disabled, but then use
> > >> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > >> > 
> > >> > Switch all arch_cpu_idle() implementations to use
> > >> > raw_local_irq_{en,dis}able() and carefully manage the
> > >> > lockdep,rcu,tracing state like we do in entry.
> > >> > 
> > >> > (XXX: we really should change arch_cpu_idle() to not return with
> > >> > interrupts enabled)
> > >> > 
> > >> 
> > >> Has this patch been tested on s390 ? Reason for asking is that it causes
> > >> all my s390 emulations to crash. Reverting it fixes the problem.
> > >
> > > My understanding is that it changes the error on s390. Previously it
> > > would complain about the local_irq_enable() in arch_cpu_idle(), now it
> > > complains when taking an interrupt during idle.
> > 
> > I looked into adding the required functionality for s390, but the code
> > we would need to add to entry.S is rather large - as you noted we would
> > have to duplicate large portions of irqentry_enter() into our code.
> > Given that s390 was fine before that patch, can you revert it and submit
> > it again during the next merge window?
> 
> I'm not sure I understand how s390 was fine without it, let me consdier.
> Also, what's the status of ARM64, they do need this too.

We've got the batch of fixes from Mark queued for -rc7:

https://fixes.arm64.dev/

which rely on Peter's patch:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/fixes&id=114e0a684753516ef4b71ccb55a8ebcfa8735edb

There's room for consolidation and cleanup in future, but right now we've
focussed purely on fixing things.

Will
