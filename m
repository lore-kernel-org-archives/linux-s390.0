Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 11 Jun 2015 15:28:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] perf: return ENOENT instead of ENOTSUPP
Message-ID: <20150611132800.GT19282@twins.programming.kicks-ass.net>
References: <1434016745-17608-1-git-send-email-brueckner@linux.vnet.ibm.com>
 <1434018301.1495.73.camel@twins>
 <20150611130255.GA4636@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150611130255.GA4636@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vince Weaver <vincent.weaver@maine.edu>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 11, 2015 at 03:02:55PM +0200, Hendrik Brueckner wrote:
> On Thu, Jun 11, 2015 at 12:25:01PM +0200, Peter Zijlstra wrote:
> > On Thu, 2015-06-11 at 11:59 +0200, Hendrik Brueckner wrote:
> > > The ENOTSUPP (which actually should be EOPNOTSUPP for user space) does not
> > > trigger a fallback event selection, for example, by perf record.
> > > If hardware support for the cycles perf event is available, but the hardware
> > > does not provide interrupts, returning ENOTSUPP causes perf to end.  Returning
> > > ENOENT causes the perf tool to fallback to a software-based cycle PMU that
> > > supports interrupts.
> > > 
> > > The commit 53b25335dd ("perf: Disable sampled events if no PMU interrupt")
> > > introduced that incompatible change.
> > 
> > That's 3.16
> 
> Correct... I recently encountered the problem.
> 
> > 
> > >  		if (event->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT) {
> > > -			err = -ENOTSUPP;
> > > +			err = -ENOENT;
> > >  			goto err_alloc;
> > >  		}
> > >  	}
> > 
> > And now you would be changing an API that's been around for at least 4
> > releases.
> 
> Well... the behavior before 53b25335dd was differently in this regard.  Of
> course, the API changed 4 releases ago.   The question here is rather was
> this desired or not.  In my mind I considered this problem as a regression.

Ah, I see what you mean:

  97b1198fece0 ("s390, perf: Use common PMU interrupt disabled code")

> > Also, I really think -ENOENT is the wrong return here, you're asking for
> > things that's not supported, not for something that's not there.
> 
> So looks like -ENOTSUPP is the desired API now.  So the problem I'd like
> to solve is that there are two different hardware PMUs that support the
> "cycles" event.  Just one of them supports sampling of cycles, the other not.

perf_event_attr::type will uniquely identify the pmu.

	if (event->attr.type != pmu->type)
		return -ENOENT;

	/* event is for this pmu, any fail hereafter should be fatal */

	if (is_sampling_event(event))
		return -EOPNOTSUPP;

> In the past (prior to 3.16), the perf tool tried several PMUs if -ENOENT
> was returned.  With 3.16, -ENOTSUPP is returned (which actually should be
> -EOPNOTSUPP but different story) and the perf tool exits.

So cpumf_pmu_event_init() should not have returned -ENOENT to start
with.

It should have first ascertained that this event was indeed for that
pmu, if not, -ENOENT would indeed be the correct return. However once it
finds its an event for this pmu, which requests sampling, which this pmu
cannot deliver, it should have returned a fatal error (!-ENOENT).

-EOPNOTSUPP would have been a good one there.

> So the question is: what is the desired behavior?

I think desired would be EOPNOTSUPP, but it would mean yet another
change to the API.

Then again, seeing how this isn't actually working no, that might not be
too bad.
