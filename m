Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 1/7] taskstats: Add new taskstats command
 TASKSTATS_CMD_ATTR_PIDS
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
In-Reply-To: <1289836380.1916.41.camel@holzheu-laptop>
References: <20101111170352.732381138@linux.vnet.ibm.com>
	 <20101111170813.527389224@linux.vnet.ibm.com>
	 <1289676005.2109.148.camel@laptop>
	 <1289836380.1916.41.camel@holzheu-laptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 Nov 2010 17:06:18 +0100
Message-ID: <1289837178.2109.504.camel@laptop>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: holzheu@linux.vnet.ibm.com
Cc: Shailabh Nagar <nagar1234@in.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Venkatesh Pallipadi <venki@google.com>, Suresh Siddha <suresh.b.siddha@intel.com>, Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@redhat.com>, John stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Balbir Singh <balbir@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2010-11-15 at 16:53 +0100, Michael Holzheu wrote:
> Hello Peter,
> 
> On Sat, 2010-11-13 at 20:20 +0100, Peter Zijlstra wrote:
> > On Thu, 2010-11-11 at 18:03 +0100, Michael Holzheu wrote:
> > > As clock for 'now' and 'time' the sched_clock() function is used and the patch
> > 
> > > +       preempt_disable();
> > > +       stats->time_ns = sched_clock();
> > > +       preempt_enable();
> > 
> > > +       task_snap_time = sched_clock();
> > 
> > That's just plain broken...
> 
> What exactly do you mean? Do you mean that we should not use
> sched_clock() in general or that it is called twice?

That you should not use sched_clock(), and if you do (you really
shouldn't) you should have disabled IRQs around it.

> > 
> > 
> > > +       t->sched_info.last_depart = task_rq(t)->clock;
> > 
> > Are you sure you don't mean task_rq(t)->clock_task ?
> 
> Maybe... I want to save in "last_depart" a sched_clock() timestamp that
> is as precise as possible.
> 
> We use "last_depart" for the TASKSTATS_CMD_ATTR_PIDS command to find out
> which tasks have been running on a CPU since the last taskstats
> snapshot. We return all tasks where last_depart > MIN(stats->time_ns for
> all tasks of last snapshot).

What does last departed mean? That is what timeline are you counting in?
Do you want time as tasks see it, or time as your wallclock sees it?
