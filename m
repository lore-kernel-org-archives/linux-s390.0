Return-Path: <peterz@infradead.org>
Date: Tue, 8 Sep 2015 13:29:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [[PATCH v6 09/10] powerpc/perf/hv-24x7: Use PMU_TXN_READ interface
Message-ID: <20150908112900.GF3644@twins.programming.kicks-ass.net>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1441336073-22750-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <1441703275.7601.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1441703275.7601.5.camel@ellerman.id.au>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Sep 08, 2015 at 07:07:55PM +1000, Michael Ellerman wrote:
> On Thu, 2015-09-03 at 20:07 -0700, Sukadev Bhattiprolu wrote:
> > The 24x7 counters in Powerpc allow monitoring a large number of counters
> > simultaneously. They also allow reading several counters in a single
> > HCALL so we can get a more consistent snapshot of the system.
> > 
> > Use the PMU's transaction interface to monitor and read several event
> > counters at once. The idea is that users can group several 24x7 events
> > into a single group of events. We use the following logic to submit
> > the group of events to the PMU and read the values:
> > 
> > 	pmu->start_txn()		// Initialize before first event
> > 
> > 	for each event in group
> > 		pmu->read(event);	// Queue each event to be read
> > 
> > 	pmu->commit_txn()		// Read/update all queuedcounters
> > 
> > The ->commit_txn() also updates the event counts in the respective
> > perf_event objects.  The perf subsystem can then directly get the
> > event counts from the perf_event and can avoid submitting a new
> > ->read() request to the PMU.
> > 
> > Thanks to input from Peter Zijlstra.
> > 
> > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/perf/hv-24x7.c |  166 ++++++++++++++++++++++++++++++++++++++++++-
> 
> This looks fine to me from an arch perspective. I assume the whole series can
> go via tip-something?

Yeah, I've had it queued for a few days, there was one s390 compile
fail reported by the build-bot, which I've just fixed. So if nothing
weird happens, it should hit tip somewhere this week.

> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks!
