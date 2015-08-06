Return-Path: <peterz@infradead.org>
Date: Thu, 6 Aug 2015 14:10:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/10] Define PERF_PMU_TXN_READ interface
Message-ID: <20150806121029.GQ19282@twins.programming.kicks-ass.net>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="v9Ux+11Zm5mwPlX6"
In-Reply-To: <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
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


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 26, 2015 at 10:40:37PM -0700, Sukadev Bhattiprolu wrote:
> @@ -3743,7 +3762,13 @@ static u64 perf_event_aggregate(struct perf_event *event, u64 *enabled,
>  	lockdep_assert_held(&event->child_mutex);
>  
>  	list_for_each_entry(child, &event->child_list, child_list) {
> +#if 0
> +		/*
> +		 * TODO: Do we need this read() for group events on PMUs that
> +		 * 	 don't implement PERF_PMU_TXN_READ transactions?
> +		 */
>  		(void)perf_event_read(child, false);
> +#endif
>  		total += perf_event_count(child);
>  		*enabled += child->total_time_enabled;
>  		*running += child->total_time_running;

Aw gawd, I've been an idiot!!

I just realized this is a _CHILD_ loop, not a _SIBLING_ loop !!

We need to flip the loops in perf_read_group(), find attached two
patches that go on top of 1,2,4.

After this you can add the perf_event_read() return value (just fold
patches 6,8) after which you can do patch 10 (which has a broken
Subject fwiw).



--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf_event_read-group.patch"

Subject: perf: Add group reads to perf_event_read()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 23 Jul 2015 10:04:35 +0200

Enable perf_event_read() to update entire groups at once, this will be
useful for read transactions.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20150723080435.GE25159@twins.programming.kicks-ass.net
---
 kernel/events/core.c |   39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3184,12 +3184,18 @@ void perf_event_exec(void)
 	rcu_read_unlock();
 }
 
+struct perf_read_data {
+	struct perf_event *event;
+	bool group;
+};
+
 /*
  * Cross CPU call to read the hardware event
  */
 static void __perf_event_read(void *info)
 {
-	struct perf_event *event = info;
+	struct perf_read_data *data = info;
+	struct perf_event *sub, *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 
@@ -3208,9 +3214,21 @@ static void __perf_event_read(void *info
 		update_context_time(ctx);
 		update_cgrp_time_from_event(event);
 	}
+
 	update_event_times(event);
 	if (event->state == PERF_EVENT_STATE_ACTIVE)
 		event->pmu->read(event);
+
+	if (!data->group)
+		goto unlock;
+
+	list_for_each_entry(sub, &event->sibling_list, group_entry) {
+		update_event_times(sub);
+		if (sub->state == PERF_EVENT_STATE_ACTIVE)
+			sub->pmu->read(sub);
+	}
+
+unlock:
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -3222,15 +3240,19 @@ static inline u64 perf_event_count(struc
 	return __perf_event_count(event);
 }
 
-static void perf_event_read(struct perf_event *event)
+static void perf_event_read(struct perf_event *event, bool group)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
 	 * value in the event structure:
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE) {
+		struct perf_read_data data = {
+			.event = event,
+			.group = group,
+		};
 		smp_call_function_single(event->oncpu,
-					 __perf_event_read, event, 1);
+					 __perf_event_read, &data, 1);
 	} else if (event->state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
@@ -3245,7 +3267,10 @@ static void perf_event_read(struct perf_
 			update_context_time(ctx);
 			update_cgrp_time_from_event(event);
 		}
-		update_event_times(event);
+		if (group)
+			update_group_times(event);
+		else
+			update_event_times(event);
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
 }
@@ -3764,7 +3789,7 @@ u64 perf_event_read_value(struct perf_ev
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
+	perf_event_read(event, false);
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3773,7 +3798,7 @@ u64 perf_event_read_value(struct perf_ev
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
+		perf_event_read(child, false);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3934,7 +3959,7 @@ static unsigned int perf_poll(struct fil
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	perf_event_read(event);
+	perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }

--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="peterz-perf-invert-perf_read_group.patch"

Subject: perf: Invert perf_read_group() loops
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Aug 6 13:41:13 CEST 2015

In order to enable the use of perf_event_read(.group = true), we need
to invert the sibling-child loop nesting of perf_read_group().

Currently we iterate the child list for each sibling, this precludes
using group reads. Flip things around so we iterate each group for
each child.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c |   84 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 30 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3809,50 +3809,74 @@ u64 perf_event_read_value(struct perf_ev
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static int perf_read_group(struct perf_event *event,
-				   u64 read_format, char __user *buf)
+static void __perf_read_group_add(struct perf_event *leader, u64 read_format, u64 *values)
 {
-	struct perf_event *leader = event->group_leader, *sub;
-	struct perf_event_context *ctx = leader->ctx;
-	int n = 0, size = 0, ret;
-	u64 count, enabled, running;
-	u64 values[5];
+	struct perf_event *sub;
+	int n = 1; /* skip @nr */
 
-	lockdep_assert_held(&ctx->mutex);
+	perf_event_read(leader, true);
+
+	/*
+	 * Since we co-schedule groups, {enabled,running} times of siblings
+	 * will be identical to those of the leader, so we only publish one
+	 * set.
+	 */
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
+		values[n++] += leader->total_time_enabled +
+			atomic64_read(leader->child_total_time_enabled);
+	}
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
+		values[n++] += leader->total_time_running +
+			atomic64_read(leader->child_total_time_running);
+	}
 
-	values[n++] = 1 + leader->nr_siblings;
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		values[n++] = enabled;
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		values[n++] = running;
-	values[n++] = count;
+	/*
+	 * Write {count,id} tuples for every sibling.
+	 */
+	values[n++] += perf_event_count(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 
-	size = n * sizeof(u64);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
+		values[n++] += perf_event_count(sub);
+		if (read_format & PERF_FORMAT_ID)
+			values[n++] = primary_event_id(sub);
+	}
+}
 
-	if (copy_to_user(buf, values, size))
-		return -EFAULT;
+static int perf_read_group(struct perf_event *event,
+				   u64 read_format, char __user *buf)
+{
+	struct perf_event *leader = event->group_leader, *child;
+	struct perf_event_context *ctx = leader->ctx;
+	int ret = leader->read_size;
+	u64 *values;
 
-	ret = size;
+	lockdep_assert_held(&ctx->mutex);
 
-	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
-		n = 0;
+	values = kzalloc(event->read_size);
+	if (!values)
+		return -ENOMEM;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
-		if (read_format & PERF_FORMAT_ID)
-			values[n++] = primary_event_id(sub);
+	values[0] = 1 + leader->nr_siblings;
 
-		size = n * sizeof(u64);
+	/*
+	 * By locking the child_mutex of the leader we effectively
+	 * lock the child list of all siblings.. XXX explain how.
+	 */
+	mutex_lock(&leader->child_mutex);
 
-		if (copy_to_user(buf + ret, values, size)) {
-			return -EFAULT;
-		}
+	__perf_read_group_add(leader, read_format, values);
+	list_for_each_entry(child, &leader->child_list, child_list)
+		__perf_read_group_add(child, read_format, values);
 
-		ret += size;
-	}
+	mutex_unlock(&leader->child_mutex);
+
+	if (copy_to_user(buf, values, event->read_size))
+		ret = -EFAULT;
+
+	kfree(values);
 
 	return ret;
 }

--v9Ux+11Zm5mwPlX6--
