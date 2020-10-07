Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgJGHxg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 03:53:36 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
Date: Wed, 07 Oct 2020 09:53:25 +0200
In-Reply-To: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
        (peterz@infradead.org's message of "Tue, 8 Sep 2020 15:30:31 +0200")
Message-ID: <yt9dimbm79qi.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: peterz@infradead.org
Cc: hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com

Hi Peter,

peterz@infradead.org writes:

> After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> bunch more RCU violations that were previously hidden.
>
> Switch the idle->seqcount over to using raw_write_*() to avoid the
> lockdep annotation and thus the lock tracepoints.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> [..]

I'm still seeing the splat below on s390 when irq tracing is enabled:

[ 1273.747948] =============================
[ 1273.747953] WARNING: suspicious RCU usage
[ 1273.747960] 5.9.0-20201006.rc8.git0.162c12a918a1.300.fc32.s390x+debug #1 Not tainted
[ 1273.747965] -----------------------------
[ 1273.747971] include/trace/events/lock.h:74 suspicious rcu_dereference_check() usage!
[ 1273.747976] other info that might help us debug this:
[ 1273.747982] rcu_scheduler_active = 2, debug_locks = 1
[ 1273.747987] RCU used illegally from extended quiescent state!
[ 1273.747993] 1 lock held by swapper/8/0:
[ 1273.747998]  #0: 000000010f7281b8 (max_trace_lock){..-.}-{2:2}, at: check_critical_timing+0x7c/0x1c8
[ 1273.748019] stack backtrace:
[ 1273.748034] CPU: 8 PID: 0 Comm: swapper/8 Not tainted 5.9.0-20201006.rc8.git0.162c12a918a1.300.fc32.s390x+debug #1
[ 1273.748040] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0)
[ 1273.748045] Call Trace:
[ 1273.748053]  [<000000010e656de0>] show_stack+0x90/0xf8 
[ 1273.748060]  [<000000010eea94da>] dump_stack+0xa2/0xd8 
[ 1273.748068]  [<000000010e711cc8>] trace_lock_acquired+0x178/0x180 
[ 1273.748075]  [<000000010e718ed4>] lock_contended+0x24/0xd8 
[ 1273.748083]  [<000000010f26d148>] _raw_spin_lock_irqsave+0xb0/0xd8 
[ 1273.748089]  [<000000010e7ec404>] check_critical_timing+0x7c/0x1c8 
[ 1273.748096]  [<000000010e7ecaa8>] tracer_hardirqs_on+0x128/0x148 
[ 1273.748103]  [<000000010e7eae0c>] trace_hardirqs_on+0x6c/0x1b0 
[ 1273.748110]  [<000000010e644ba8>] arch_cpu_idle+0x28/0x38 
[ 1273.748116]  [<000000010f26ccd6>] default_idle_call+0x56/0x98 
[ 1273.748124]  [<000000010e6da81a>] do_idle+0xf2/0x1b0 
[ 1273.748130]  [<000000010e6dab4e>] cpu_startup_entry+0x36/0x40 
[ 1273.748137]  [<000000010e6590fa>] smp_start_secondary+0x82/0x88 
[ 1273.748142] 1 lock held by swapper/8/0:
[ 1273.748147]  #0: 000000010f7281b8 (max_trace_lock){..-.}-{2:2}, at: check_critical_timing+0x7c/0x1c8

I think this happens because trace_lock_acquired gets called from idle
context?

Regards
Sven
