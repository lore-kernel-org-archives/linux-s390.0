Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 31 Jan 2015 12:43:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] [PATCH 0/3] sched: Support for real CPU runtime and SMT
 scaling
Message-ID: <20150131114307.GU2896@worktop.programming.kicks-ass.net>
References: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1422626562-6966-1-git-send-email-phacht@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Hachtmann <phacht@linux.vnet.ibm.com>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, Jan 30, 2015 at 03:02:39PM +0100, Philipp Hachtmann wrote:
> Hello,
> 
> when using "real" processors the scheduler can make its decisions based
> on wall time. But CPUs under hypervisor control are sometimes
> unavailable without further notice to the guest operating system.
> Using wall time for scheduling decisions in this case will lead to
> unfair decisions and erroneous distribution of CPU bandwidth when
> using cgroups.
> On (at least) S390 every CPU has a timer that counts the real execution
> time from IPL. When the hypervisor has sheduled out the CPU, the timer
> is stopped. So it is desirable to use this timer as a source for the
> scheduler's rq runtime calculations.
> 
> On SMT systems the consumed runtime of a task might be worth  more
> or less depending on the fact that the task can have run alone or not
> during the last delta. This should be scalable based on the current
> CPU utilization.

So we've explicitly never done this before because at the end of the day
its wall time that people using the computer react to.

Also, once you open this door you can have endless discussions of what
constitutes work. People might want to use instructions retired for
instance, to normalize against pipeline stalls.

Also, if your hypervisor starves its vcpus of compute time; how is that
our problem?

Furthermore, we already have some stealtime accounting in
update_rq_clock_task() for the virt crazies^Wpeople.
