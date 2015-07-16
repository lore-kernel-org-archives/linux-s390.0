Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Thu, 16 Jul 2015 14:41:24 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 5/8] perf: Split perf_event_read_value()
Message-ID: <20150716214124.GB31962@us.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-6-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716211219.GN3644@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150716211219.GN3644@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Peter Zijlstra [peterz@infradead.org] wrote:
| On Tue, Jul 14, 2015 at 08:01:52PM -0700, Sukadev Bhattiprolu wrote:
| > Move the part of perf_event_read_value() that computes the event
| > counts and event times into a new function, perf_event_compute().
| > 
| > This would allow us to call perf_event_compute() independently.
| > 
| > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
| > 
| > Changelog[v3]
| > 	Rather than move perf_event_read() into callers and then
| > 	rename, just move the computations into a separate function
| > 	(redesign to address comment from Peter Zijlstra).
| > ---
| 
| Changelog[] bits go here, below the '---' where they get discarded.

Sorry. Will fix it.

| 
| >  kernel/events/core.c |   37 ++++++++++++++++++++++++-------------
| >  1 file changed, 24 insertions(+), 13 deletions(-)
| > 
| > diff --git a/kernel/events/core.c b/kernel/events/core.c
| > index 44fb89d..b1e9a42 100644
| > --- a/kernel/events/core.c
| > +++ b/kernel/events/core.c
| > @@ -3704,6 +3704,29 @@ static int perf_release(struct inode *inode, struct file *file)
| >  	return 0;
| >  }
| >  
| > +static u64 perf_event_compute(struct perf_event *event, u64 *enabled,
| > +			      u64 *running)
| 
| This is a horrible name, 'compute' what?

We are aggregating event counts and time for children.

Would perf_event_aggregate() or perf_event_aggregate_children()
be better?

| 
| > +{
| > +	struct perf_event *child;
| > +	u64 total;
| > +
| > +	total = perf_event_count(event);
| > +
| > +	*enabled += event->total_time_enabled +
| > +			atomic64_read(&event->child_total_time_enabled);
| > +	*running += event->total_time_running +
| > +			atomic64_read(&event->child_total_time_running);
| > +
| 
| 	lockdep_assert_held(&event->child_mutex);

OK. Thanks for the comments.

Sukadev
