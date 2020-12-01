Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH 1/2] sched/idle: Fix arch_cpu_idle() vs tracing
References: <20201120114145.197714127@infradead.org>
        <20201120114925.594122626@infradead.org>
        <20201130210003.GA40619@roeck-us.net>
        <20201201110209.GQ3040@hirez.programming.kicks-ass.net>
Date: Tue, 01 Dec 2020 12:12:18 +0100
In-Reply-To: <20201201110209.GQ3040@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 1 Dec 2020 12:02:09 +0100")
Message-ID: <yt9d4kl56ar1.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, rafael@kernel.org, viresh.kumar@linaro.org, mingo@kernel.org, x86@kernel.org, mark.rutland@arm.com, will@kernel.org, linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Nov 30, 2020 at 01:00:03PM -0800, Guenter Roeck wrote:
>> On Fri, Nov 20, 2020 at 12:41:46PM +0100, Peter Zijlstra wrote:
>> > We call arch_cpu_idle() with RCU disabled, but then use
>> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
>> > 
>> > Switch all arch_cpu_idle() implementations to use
>> > raw_local_irq_{en,dis}able() and carefully manage the
>> > lockdep,rcu,tracing state like we do in entry.
>> > 
>> > (XXX: we really should change arch_cpu_idle() to not return with
>> > interrupts enabled)
>> > 
>> 
>> Has this patch been tested on s390 ? Reason for asking is that it causes
>> all my s390 emulations to crash. Reverting it fixes the problem.
>
> My understanding is that it changes the error on s390. Previously it
> would complain about the local_irq_enable() in arch_cpu_idle(), now it
> complains when taking an interrupt during idle.

The errors on s390 all were fixed in the meantime. I cannot say which
patch fixed it, but we haven't seen any warning in our internal CI
during the last weeks. So reverting the patch would likely fix the issue
for us.

s390 is likely to switch to generic entry with the next merge window (im
working on it), so all that stuff will be easier than.
