Return-Path: <peterz@infradead.org>
Date: Wed, 12 Aug 2015 10:45:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/10] Define PERF_PMU_TXN_READ interface
Message-ID: <20150812084545.GR16853@twins.programming.kicks-ass.net>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150806121029.GQ19282@twins.programming.kicks-ass.net>
 <20150812041400.GA28426@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150812041400.GA28426@us.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Aug 11, 2015 at 09:14:00PM -0700, Sukadev Bhattiprolu wrote:
> | +static void __perf_read_group_add(struct perf_event *leader, u64 read_format, u64 *values)
> |  {
> | +	struct perf_event *sub;
> | +	int n = 1; /* skip @nr */
> 
> This n = 1 is to skip over the values[0] = 1 + nr_siblings in the
> caller.
> 
> Anyway, in __perf_read_group_add() we always start with n = 1, however
> ...
> | 
> | +	perf_event_read(leader, true);
> | +
> | +	/*
> | +	 * Since we co-schedule groups, {enabled,running} times of siblings
> | +	 * will be identical to those of the leader, so we only publish one
> | +	 * set.
> | +	 */
> | +	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
> | +		values[n++] += leader->total_time_enabled +
> | +			atomic64_read(leader->child_total_time_enabled);

Note how this is an in-place addition,

> | +	}
> | 
> | +	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
> | +		values[n++] += leader->total_time_running +
> | +			atomic64_read(leader->child_total_time_running);

and here,

> | +	}
> | 
> | +	/*
> | +	 * Write {count,id} tuples for every sibling.
> | +	 */
> | +	values[n++] += perf_event_count(leader);

and here,


> |  	if (read_format & PERF_FORMAT_ID)
> |  		values[n++] = primary_event_id(leader);

and this will always assign the same value.

> | +	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
> | +		values[n++] += perf_event_count(sub);
> | +		if (read_format & PERF_FORMAT_ID)
> | +			values[n++] = primary_event_id(sub);

Same for these, therefore,

> | +	}
> | +}
> | 
> | +static int perf_read_group(struct perf_event *event,
> | +				   u64 read_format, char __user *buf)
> | +{
> | +	struct perf_event *leader = event->group_leader, *child;
> | +	struct perf_event_context *ctx = leader->ctx;
> | +	int ret = leader->read_size;
> | +	u64 *values;
> | 
> | +	lockdep_assert_held(&ctx->mutex);
> | 
> | +	values = kzalloc(event->read_size);
> | +	if (!values)
> | +		return -ENOMEM;
> | 
> | +	values[0] = 1 + leader->nr_siblings;
> | 
> | +	/*
> | +	 * By locking the child_mutex of the leader we effectively
> | +	 * lock the child list of all siblings.. XXX explain how.
> | +	 */
> | +	mutex_lock(&leader->child_mutex);
> | 
> | +	__perf_read_group_add(leader, read_format, values);
> 
> ... we don't copy_to_user() here,
> 
> | +	list_for_each_entry(child, &leader->child_list, child_list)
> | +		__perf_read_group_add(child, read_format, values);
> 
> so won't we overwrite the values[], if we always start at n = 1
> in __perf_read_group_add()?

yes and no, we have to re-iterate the same values for each child as they
all have the same group, but we add the time and count fields, we do not
overwrite. The _add() suffix was supposed to be a hint ;-)

> | +	mutex_unlock(&leader->child_mutex);
> | +
> | +	if (copy_to_user(buf, values, event->read_size))
> | +		ret = -EFAULT;
> | +
> | +	kfree(values);
> | 
> |  	return ret;
> |  }

Where previously we would iterate the group and for each member
iterate/sum all the child values together before copying the value out,
we now, because we need to read groups together, need to first iterate
the child list and sum whole groups.
