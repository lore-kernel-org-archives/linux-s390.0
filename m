Return-Path: <peterz@infradead.org>
Date: Thu, 23 Jul 2015 10:04:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Message-ID: <20150723080435.GE25159@twins.programming.kicks-ass.net>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716222015.GO3644@twins.programming.kicks-ass.net>
 <20150722015045.GA24420@us.ibm.com>
 <20150722055503.GO25159@twins.programming.kicks-ass.net>
 <20150722231916.GA1863@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722231916.GA1863@us.ibm.com>
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

On Wed, Jul 22, 2015 at 04:19:16PM -0700, Sukadev Bhattiprolu wrote:
> Peter Zijlstra [peterz@infradead.org] wrote:
> | I've not woken up yet, and not actually fully read the email, but can
> | you stuff the entire above chunk inside the IPI?
> | 
> | I think you could then actually optimize __perf_event_read() as well,
> | because all these events should be on the same context, so no point in
> | calling update_*time*() for every event or so.
> | 
> 
> Do you mean something like this (will move the rename to a separate
> patch before posting):

More like so.. please double check, I've not even had tea yet.

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3174,14 +3174,22 @@ void perf_event_exec(void)
 	rcu_read_unlock();
 }
 
+struct perf_read_data {
+	struct perf_event *event;
+	bool group;
+	int ret;
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
+	struct pmu *pmu = event->pmu;
 
 	/*
 	 * If this is a task context, we need to check whether it is
@@ -3199,8 +3207,23 @@ static void __perf_event_read(void *info
 		update_cgrp_time_from_event(event);
 	}
 	update_event_times(event);
-	if (event->state == PERF_EVENT_STATE_ACTIVE)
-		event->pmu->read(event);
+	if (event->state != PERF_EVENT_STATE_ACTIVE)
+		goto unlock;
+
+	if (!data->group) {
+		pmu->read(event);
+		goto unlock;
+	}
+
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+	pmu->read(event);
+	list_for_each_entry(sub, &event->sibling_list, group_entry) {
+		if (sub->state == PERF_EVENT_STATE_ACTIVE)
+			pmu->read(sub);
+	}
+	data->ret = pmu->commit_txn(pmu);
+
+unlock:
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -3212,15 +3235,23 @@ static inline u64 perf_event_count(struc
 	return __perf_event_count(event);
 }
 
-static void perf_event_read(struct perf_event *event)
+static int perf_event_read(struct perf_event *event, bool group)
 {
+	int ret = 0
+
 	/*
 	 * If event is enabled and currently active on a CPU, update the
 	 * value in the event structure:
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE) {
+		struct perf_read_data data = {
+			.event = event,
+			.group = group,
+			.ret = 0,
+		};
 		smp_call_function_single(event->oncpu,
-					 __perf_event_read, event, 1);
+					 __perf_event_read, &data, 1);
+		ret = data.ret;
 	} else if (event->state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
@@ -3235,9 +3266,14 @@ static void perf_event_read(struct perf_
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
+
+	return ret;
 }
 
 /*
@@ -3718,7 +3754,6 @@ static u64 perf_event_compute(struct per
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3772,7 +3807,7 @@ u64 perf_event_read_value(struct perf_ev
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
+	perf_event_read(event, false);
 	total = perf_event_compute(event, enabled, running);
 
 	mutex_unlock(&event->child_mutex);
@@ -3792,7 +3827,11 @@ static int perf_read_group(struct perf_e
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	ret = perf_event_read(leader, true);
+	if (ret)
+		return ret;
+
+	count = perf_event_compute(leader, &enabled, &running);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3813,7 +3852,7 @@ static int perf_read_group(struct perf_e
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		values[n++] = perf_event_compute(sub, &enabled, &running);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
@@ -3931,7 +3970,7 @@ static unsigned int perf_poll(struct fil
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	perf_event_read(event);
+	perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
