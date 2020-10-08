Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53236 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726005AbgJHI6Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 04:58:24 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
        <yt9dimbm79qi.fsf@linux.ibm.com>
        <20201007100551.GC2628@hirez.programming.kicks-ass.net>
        <20201007125625.GK2651@hirez.programming.kicks-ass.net>
Date: Thu, 08 Oct 2020 10:58:05 +0200
In-Reply-To: <20201007125625.GK2651@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 7 Oct 2020 14:56:25 +0200")
Message-ID: <yt9dy2khrt5u.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com

Hi Peter,

Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Oct 07, 2020 at 12:05:51PM +0200, Peter Zijlstra wrote:
>> On Wed, Oct 07, 2020 at 09:53:25AM +0200, Sven Schnelle wrote:
>> > Hi Peter,
>> > 
>> > peterz@infradead.org writes:
>> > 
>> > > After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
>> > > lock tracepoints are visible to lockdep and RCU-lockdep is finding a
>> > > bunch more RCU violations that were previously hidden.
>> > >
>> > > Switch the idle->seqcount over to using raw_write_*() to avoid the
>> > > lockdep annotation and thus the lock tracepoints.
>> > >
>> > > Reported-by: Guenter Roeck <linux@roeck-us.net>
>> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > > [..]
>> > 
>> > I'm still seeing the splat below on s390 when irq tracing is enabled:
>> 
>> Damn... :/
>> 
>> This one is tricky, trouble seems to be that arch_cpu_idle() is defined
>> to enable interrupts (no doubt because ot x86 :/), but we call it before
>> rcu_exit_idle().
>> 
>> What a mess... let me rummage around the various archs to see what makes
>> most sense here.
>
> Maybe something like so, I've not yet tested it. I need to figure out
> how to force x86 into this path.

I've gave this patch a quick test on linux-next from today and haven't
seen the splat again. However it wasn't happening all the time, so will
test it a bit longer. I haven't looked into the tracing code in detail,
but i guess it was only happening when the lock was contented.

The only thing with this patch is that rcu complains that it gets called
with interrupts enabled on s390 when rcu_irq_enter() is called. But a
few trace_hardirqs_{on,off} at the beginning and end of the IRQ handlers
are fixing this. Will check why this worked in the past.

Sven
