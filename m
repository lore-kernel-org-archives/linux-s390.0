Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 5 Feb 2015 12:24:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] [PATCH 0/3] sched: Support for real CPU runtime and SMT
 scaling
Message-ID: <20150205112402.GG5029@twins.programming.kicks-ass.net>
References: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
 <20150131114307.GU2896@worktop.programming.kicks-ass.net>
 <20150203151112.35526ffc@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150203151112.35526ffc@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Philipp Hachtmann <phacht@linux.vnet.ibm.com>, mingo@redhat.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Feb 03, 2015 at 03:11:12PM +0100, Martin Schwidefsky wrote:
> On Sat, 31 Jan 2015 12:43:07 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jan 30, 2015 at 03:02:39PM +0100, Philipp Hachtmann wrote:
> > > Hello,
> > > 
> > > when using "real" processors the scheduler can make its decisions based
> > > on wall time. But CPUs under hypervisor control are sometimes
> > > unavailable without further notice to the guest operating system.
> > > Using wall time for scheduling decisions in this case will lead to
> > > unfair decisions and erroneous distribution of CPU bandwidth when
> > > using cgroups.
> > > On (at least) S390 every CPU has a timer that counts the real execution
> > > time from IPL. When the hypervisor has sheduled out the CPU, the timer
> > > is stopped. So it is desirable to use this timer as a source for the
> > > scheduler's rq runtime calculations.
> > > 
> > > On SMT systems the consumed runtime of a task might be worth  more
> > > or less depending on the fact that the task can have run alone or not
> > > during the last delta. This should be scalable based on the current
> > > CPU utilization.
> > 
> > So we've explicitly never done this before because at the end of the day
> > its wall time that people using the computer react to.
> 
> Oh yes, absolutely. That is why we go to all the pain with virtual cputime.
> That is to get to the absolute time a process has been running on a CPU
> *without* the steal time. Only the scheduler "thinks" in wall-clock because
> sched_clock is defined to return nano-seconds since boot.

I'm not entirely sure what you're trying to say there, but if its
agreement -- like the first few words seems to suggest then I'll leave
it at that ;-)

> > Also, once you open this door you can have endless discussions of what
> > constitutes work. People might want to use instructions retired for
> > instance, to normalize against pipeline stalls.
> 
> Yes, we had that discussion in the design for SMT as well. In the end
> the view of a user is ambivalent, we got used to a simplified approach.
> A process that runs on a CPU 100% of the wall-time gets 100% CPU,
> ignoring pipeline stalls, cache misses, temperature throttling and so on.
> But with SMT we suddenly complain about the other thread on the core
> impacting the work.

Welcome to SMT ;-) So far our approach has been, tough luck. That's what
you get, and I see no reason to change that for s390.

For x86, sparc, powerpc, mips, ia64 who all have SMT we completely
ignore the fact that the (logical) CPU is suddenly slower than it was.
In that respect it's no different from cpufreq mucking about with your
clock speeds. We account the task runtime in walltime, irrespective of
what might (or might not) have ran on a sibling.

Now, there is a bunch of people that want to do DVFS accounting; but
that is mostly so we can guestimate relative gain; like can I fit this
new task by making the CPU go faster or should I use this other CPU.

Also, how does your hypervisor thingy deal with vcpu vs SMT? Does it
schedule it like any other logical CPU and Linux is completely oblivious
to actual machine topology?

> > Also, if your hypervisor starves its vcpus of compute time; how is that
> > our problem?
> 
> Because we see the effects of that starvation in the guest OS, no?

But why ruin Linux for an arguably broken hypervisor? If your HV causes
starvation, fix that.

> > Furthermore, we already have some stealtime accounting in
> > update_rq_clock_task() for the virt crazies^Wpeople.
> 
> Yes, defining PARAVIRT_TIME_ACCOUNTING and a paravirt_steal_clock would
> solve one of the problems (the one with the cpu_exec_time hook). But
> it does so in an indirect way, for s390 we do have an instruction for
> that ..

Of course you do! How's work on the crystal ball instruction coming? ;-)

I really _really_ like to not have more than 1 virt means of mucking
with time. I detest virt (everybody knows that, right?) and having all
the virt flavours of the month do different things to me makes me sad.

Computing steal time should not be too expensive for you right? Just
take the walltime and subtract this new time. Maybe you can even
micro-code a new instruction to do that for you :-)

> Which leaves the second hook scale_rq_clock_delta. That one only makes
> sense if the steal time has been subtracted from sched_clock. It scales
> the delta with the average number of threads that have been running
> in the last interval. Basically if two threads are running the delta
> is halved.

Right; so the patches were decidedly light on detail there. I'm very
sure I did not get what you were attempting to do there, and I'm not
sure I do now.

Isn't the whole point of SMT to get _more_ than a single thread of
performance out of a core?

> This technique has an interesting effect. Consider a setup with 2-way
> SMT and CFS bandwidth control. With the new cpu_exec_time hook the
> time counted against the quota is normalized with the average thread
> density. Two logical CPUs on a core use the same quota as a single
> logical CPU on a core. In effect by specifying a quota as a multiple
> of the period you can limit a group to use the CPU capacity of as
> many *cores*.

*groan*... So we muck about with time because you want to do accounting
tricks? That should have been in big bright neon letters in a comment
somewhere. Not squirreled away in a detail.

Arguably one could make that an (optional) feature of
account_cfs_rq_runtime() and only affect the accounting while leaving
the actual scheduling alone.

This needs more thought and certainly more description.

> This avoids that nasty group scheduling issue we
> briefly talked about ..

I remember we did talk; I'm afraid however I seem to have lost many of
the details in the post baby haze (which still hasn't entirely lifted).
