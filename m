Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Tue, 11 Aug 2015 21:14:00 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 09/10] Define PERF_PMU_TXN_READ interface
Message-ID: <20150812041400.GA28426@us.ibm.com>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150806121029.GQ19282@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150806121029.GQ19282@twins.programming.kicks-ass.net>
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
| On Sun, Jul 26, 2015 at 10:40:37PM -0700, Sukadev Bhattiprolu wrote:
| > @@ -3743,7 +3762,13 @@ static u64 perf_event_aggregate(struct perf_event *event, u64 *enabled,
| >  	lockdep_assert_held(&event->child_mutex);
| >  
| >  	list_for_each_entry(child, &event->child_list, child_list) {
| > +#if 0
| > +		/*
| > +		 * TODO: Do we need this read() for group events on PMUs that
| > +		 * 	 don't implement PERF_PMU_TXN_READ transactions?
| > +		 */
| >  		(void)perf_event_read(child, false);
| > +#endif
| >  		total += perf_event_count(child);
| >  		*enabled += child->total_time_enabled;
| >  		*running += child->total_time_running;
| 
| Aw gawd, I've been an idiot!!
| 
| I just realized this is a _CHILD_ loop, not a _SIBLING_ loop !!
| 
| We need to flip the loops in perf_read_group(), find attached two
| patches that go on top of 1,2,4.
| 
| After this you can add the perf_event_read() return value (just fold
| patches 6,8) after which you can do patch 10 (which has a broken
| Subject fwiw).

Thanks for the patches. I am building and testing, but have a question
on the second patch below:

<snip>


| Subject: perf: Invert perf_read_group() loops
| From: Peter Zijlstra <peterz@infradead.org>
| Date: Thu Aug 6 13:41:13 CEST 2015
| 
| In order to enable the use of perf_event_read(.group = true), we need
| to invert the sibling-child loop nesting of perf_read_group().
| 
| Currently we iterate the child list for each sibling, this precludes
| using group reads. Flip things around so we iterate each group for
| each child.
| 
| Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
| ---
|  kernel/events/core.c |   84 ++++++++++++++++++++++++++++++++-------------------
|  1 file changed, 54 insertions(+), 30 deletions(-)
| 
| --- a/kernel/events/core.c
| +++ b/kernel/events/core.c
| @@ -3809,50 +3809,74 @@ u64 perf_event_read_value(struct perf_ev
|  }
|  EXPORT_SYMBOL_GPL(perf_event_read_value);
| 
| -static int perf_read_group(struct perf_event *event,
| -				   u64 read_format, char __user *buf)
| +static void __perf_read_group_add(struct perf_event *leader, u64 read_format, u64 *values)
|  {
| -	struct perf_event *leader = event->group_leader, *sub;
| -	struct perf_event_context *ctx = leader->ctx;
| -	int n = 0, size = 0, ret;
| -	u64 count, enabled, running;
| -	u64 values[5];
| +	struct perf_event *sub;
| +	int n = 1; /* skip @nr */

This n = 1 is to skip over the values[0] = 1 + nr_siblings in the
caller.

Anyway, in __perf_read_group_add() we always start with n = 1, however
...
| 
| -	lockdep_assert_held(&ctx->mutex);
| +	perf_event_read(leader, true);
| +
| +	/*
| +	 * Since we co-schedule groups, {enabled,running} times of siblings
| +	 * will be identical to those of the leader, so we only publish one
| +	 * set.
| +	 */
| +	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
| +		values[n++] += leader->total_time_enabled +
| +			atomic64_read(leader->child_total_time_enabled);
| +	}
| 
| -	count = perf_event_read_value(leader, &enabled, &running);
| +	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
| +		values[n++] += leader->total_time_running +
| +			atomic64_read(leader->child_total_time_running);
| +	}
| 
| -	values[n++] = 1 + leader->nr_siblings;
| -	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
| -		values[n++] = enabled;
| -	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
| -		values[n++] = running;
| -	values[n++] = count;
| +	/*
| +	 * Write {count,id} tuples for every sibling.
| +	 */
| +	values[n++] += perf_event_count(leader);
|  	if (read_format & PERF_FORMAT_ID)
|  		values[n++] = primary_event_id(leader);
| 
| -	size = n * sizeof(u64);
| +	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
| +		values[n++] += perf_event_count(sub);
| +		if (read_format & PERF_FORMAT_ID)
| +			values[n++] = primary_event_id(sub);
| +	}
| +}
| 
| -	if (copy_to_user(buf, values, size))
| -		return -EFAULT;
| +static int perf_read_group(struct perf_event *event,
| +				   u64 read_format, char __user *buf)
| +{
| +	struct perf_event *leader = event->group_leader, *child;
| +	struct perf_event_context *ctx = leader->ctx;
| +	int ret = leader->read_size;
| +	u64 *values;
| 
| -	ret = size;
| +	lockdep_assert_held(&ctx->mutex);
| 
| -	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
| -		n = 0;
| +	values = kzalloc(event->read_size);
| +	if (!values)
| +		return -ENOMEM;
| 
| -		values[n++] = perf_event_read_value(sub, &enabled, &running);
| -		if (read_format & PERF_FORMAT_ID)
| -			values[n++] = primary_event_id(sub);
| +	values[0] = 1 + leader->nr_siblings;
| 
| -		size = n * sizeof(u64);
| +	/*
| +	 * By locking the child_mutex of the leader we effectively
| +	 * lock the child list of all siblings.. XXX explain how.
| +	 */
| +	mutex_lock(&leader->child_mutex);
| 
| -		if (copy_to_user(buf + ret, values, size)) {
| -			return -EFAULT;
| -		}
| +	__perf_read_group_add(leader, read_format, values);

... we don't copy_to_user() here,

| +	list_for_each_entry(child, &leader->child_list, child_list)
| +		__perf_read_group_add(child, read_format, values);

so won't we overwrite the values[], if we always start at n = 1
in __perf_read_group_add()?

| 

| -		ret += size;
| -	}
| +	mutex_unlock(&leader->child_mutex);
| +
| +	if (copy_to_user(buf, values, event->read_size))
| +		ret = -EFAULT;
| +
| +	kfree(values);
| 
|  	return ret;
|  }
