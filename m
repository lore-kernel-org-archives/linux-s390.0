Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgJGKGA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 06:06:00 -0400
Date: Wed, 7 Oct 2020 12:05:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20201007100551.GC2628@hirez.programming.kicks-ass.net>
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
 <yt9dimbm79qi.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dimbm79qi.fsf@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com

On Wed, Oct 07, 2020 at 09:53:25AM +0200, Sven Schnelle wrote:
> Hi Peter,
> 
> peterz@infradead.org writes:
> 
> > After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> > lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> > bunch more RCU violations that were previously hidden.
> >
> > Switch the idle->seqcount over to using raw_write_*() to avoid the
> > lockdep annotation and thus the lock tracepoints.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > [..]
> 
> I'm still seeing the splat below on s390 when irq tracing is enabled:

Damn... :/

This one is tricky, trouble seems to be that arch_cpu_idle() is defined
to enable interrupts (no doubt because ot x86 :/), but we call it before
rcu_exit_idle().

What a mess... let me rummage around the various archs to see what makes
most sense here.
