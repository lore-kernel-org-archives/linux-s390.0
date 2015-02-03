Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Feb 2015 15:11:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC] [PATCH 0/3] sched: Support for real CPU runtime and SMT
 scaling
Message-ID: <20150203151112.35526ffc@mschwide>
In-Reply-To: <20150131114307.GU2896@worktop.programming.kicks-ass.net>
References: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
 <20150131114307.GU2896@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Philipp Hachtmann <phacht@linux.vnet.ibm.com>, mingo@redhat.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 31 Jan 2015 12:43:07 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jan 30, 2015 at 03:02:39PM +0100, Philipp Hachtmann wrote:
> > Hello,
> > 
> > when using "real" processors the scheduler can make its decisions based
> > on wall time. But CPUs under hypervisor control are sometimes
> > unavailable without further notice to the guest operating system.
> > Using wall time for scheduling decisions in this case will lead to
> > unfair decisions and erroneous distribution of CPU bandwidth when
> > using cgroups.
> > On (at least) S390 every CPU has a timer that counts the real execution
> > time from IPL. When the hypervisor has sheduled out the CPU, the timer
> > is stopped. So it is desirable to use this timer as a source for the
> > scheduler's rq runtime calculations.
> > 
> > On SMT systems the consumed runtime of a task might be worth  more
> > or less depending on the fact that the task can have run alone or not
> > during the last delta. This should be scalable based on the current
> > CPU utilization.
> 
> So we've explicitly never done this before because at the end of the day
> its wall time that people using the computer react to.

Oh yes, absolutely. That is why we go to all the pain with virtual cputime.
That is to get to the absolute time a process has been running on a CPU
*without* the steal time. Only the scheduler "thinks" in wall-clock because
sched_clock is defined to return nano-seconds since boot.
 
> Also, once you open this door you can have endless discussions of what
> constitutes work. People might want to use instructions retired for
> instance, to normalize against pipeline stalls.

Yes, we had that discussion in the design for SMT as well. In the end
the view of a user is ambivalent, we got used to a simplified approach.
A process that runs on a CPU 100% of the wall-time gets 100% CPU,
ignoring pipeline stalls, cache misses, temperature throttling and so on.
But with SMT we suddenly complain about the other thread on the core
impacting the work.
 
> Also, if your hypervisor starves its vcpus of compute time; how is that
> our problem?

Because we see the effects of that starvation in the guest OS, no?
 
> Furthermore, we already have some stealtime accounting in
> update_rq_clock_task() for the virt crazies^Wpeople.

Yes, defining PARAVIRT_TIME_ACCOUNTING and a paravirt_steal_clock would
solve one of the problems (the one with the cpu_exec_time hook). But
it does so in an indirect way, for s390 we do have an instruction for
that ..

Which leaves the second hook scale_rq_clock_delta. That one only makes
sense if the steal time has been subtracted from sched_clock. It scales
the delta with the average number of threads that have been running
in the last interval. Basically if two threads are running the delta
is halved.

This technique has an interesting effect. Consider a setup with 2-way
SMT and CFS bandwidth control. With the new cpu_exec_time hook the
time counted against the quota is normalized with the average thread
density. Two logical CPUs on a core use the same quota as a single
logical CPU on a core. In effect by specifying a quota as a multiple
of the period you can limit a group to use the CPU capacity of as
many *cores*. This avoids that nasty group scheduling issue we
briefly talked about ..

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
