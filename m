Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Jun 2016 12:29:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 4.7-rc1/s390: WARNING: CPU: 5 PID: 1 at
 kernel/events/core.c:8485 perf_pmu_register+0x420/0x428
Message-ID: <20160606102900.GC30909@twins.programming.kicks-ass.net>
References: <201606060737.u567YMPJ012970@mx0a-001b2d01.pphosted.com>
 <20160606082124.GA30154@twins.programming.kicks-ass.net>
 <201606060929.u569T8fW028400@mx0a-001b2d01.pphosted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201606060929.u569T8fW028400@mx0a-001b2d01.pphosted.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "linux-kernel@vger.kernel.org >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jun 06, 2016 at 11:29:36AM +0200, Hendrik Brueckner wrote:

> > > Looks like perf_pmu_register does not like to be called twice (once for the counter
> > > and once for the sampling facility).
> > 
> > Twice isn't the problem per se, its trying to register two PMUs for
> > perf_hw_context that is the problem.
> > 
> > The perf core does not expect or deal well with that.
> > 
> > The perf core expects a single HW PMU in that when it schedules
> > hw_context events, and encounters an failure to pmu::add() (because the
> > hw pmu is 'full') it stops trying to add more events.
> 
> On s390, there are actually two distinct measurement facilities and, thus,
> two HW PMUs for each.  There is the hardware counter and hardware sampling
> facility/PMU.

Can you quickly describe the cf one; or provide a link to a document
doing so?

If this is a simple always running counter without interrupt you could
make it a 'software' PMU which can always schedule, similar to the x86
MSR driver (arch/x86/events/msr.c).
