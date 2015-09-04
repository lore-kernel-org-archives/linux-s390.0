Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [[PATCH v6 05/10] perf: Add group reads to perf_event_read()
Date: Thu,  3 Sep 2015 20:07:48 -0700
Message-Id: <1441336073-22750-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1441336073-22750-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Peter Zijlstra <peterz@infradead.org>

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

diff --git a/kernel/events/core.c b/kernel/events/core.c
index be39e63..7bb9141 100644
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
 
@@ -3208,9 +3214,21 @@ static void __perf_event_read(void *info)
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
 
@@ -3275,15 +3293,19 @@ u64 perf_event_read_local(struct perf_event *event)
 	return val;
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
@@ -3298,7 +3320,10 @@ static void perf_event_read(struct perf_event *event)
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
@@ -3817,7 +3842,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
+	perf_event_read(event, false);
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3826,7 +3851,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
+		perf_event_read(child, false);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3987,7 +4012,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	perf_event_read(event);
+	perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
