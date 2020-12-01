Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLALDC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Dec 2020 06:03:02 -0500
Date: Tue, 1 Dec 2020 12:02:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
Message-ID: <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
References: <20201120114145.197714127@infradead.org>
 <20201120114925.594122626@infradead.org>
 <20201130210003.GA40619@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130210003.GA40619@roeck-us.net>
List-ID: <linux-s390.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org, mark.rutland@arm.com, will@kernel.org, svens@linux.ibm.com, linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
> > We call arch_cpu_idle() with RCU disabled, but then use
> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > 
> > Switch all arch_cpu_idle() implementations to use
> > raw_local_irq_{en,dis}able() and carefully manage the
> > lockdep,rcu,tracing state like we do in entry.
> > 
> > (XXX: we really should change arch_cpu_idle() to not return with
> > interrupts enabled)
> > 
> 
> Has this patch been tested on s390 ? Reason for asking is that it causes
> all my s390 emulations to crash. Reverting it fixes the problem.

My understanding is that it changes the error on s390. Previously it
would complain about the local_irq_enable() in arch_cpu_idle(), now it
complains when taking an interrupt during idle.
