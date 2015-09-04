Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [[PATCH v6 07/10] perf: Add return value for perf_event_read().
Date: Thu,  3 Sep 2015 20:07:50 -0700
Message-Id: <1441336073-22750-8-git-send-email-sukadev@linux.vnet.ibm.com>
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

When we implement the ability to read several counters at once (using
the PERF_PMU_TXN_READ transaction interface), perf_event_read() can
fail when the 'group' parameter is true (eg: trying to read too many
events at once).

For now, have perf_event_read() return an integer. Ignore the return
value when the 'group' parameter is false.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   45 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2c38c09..acdd8b5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3187,6 +3187,7 @@ void perf_event_exec(void)
 struct perf_read_data {
 	struct perf_event *event;
 	bool group;
+	int ret;
 };
 
 /*
@@ -3227,6 +3228,7 @@ static void __perf_event_read(void *info)
 		if (sub->state == PERF_EVENT_STATE_ACTIVE)
 			sub->pmu->read(sub);
 	}
+	data->ret = 0;
 
 unlock:
 	raw_spin_unlock(&ctx->lock);
@@ -3293,8 +3295,10 @@ u64 perf_event_read_local(struct perf_event *event)
 	return val;
 }
 
-static void perf_event_read(struct perf_event *event, bool group)
+static int perf_event_read(struct perf_event *event, bool group)
 {
+	int ret = 0;
+
 	/*
 	 * If event is enabled and currently active on a CPU, update the
 	 * value in the event structure:
@@ -3303,9 +3307,11 @@ static void perf_event_read(struct perf_event *event, bool group)
 		struct perf_read_data data = {
 			.event = event,
 			.group = group,
+			.ret = 0,
 		};
 		smp_call_function_single(event->oncpu,
 					 __perf_event_read, &data, 1);
+		ret = data.ret;
 	} else if (event->state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
@@ -3326,6 +3332,8 @@ static void perf_event_read(struct perf_event *event, bool group)
 			update_event_times(event);
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
+
+	return ret;
 }
 
 /*
@@ -3842,7 +3850,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event, false);
+	(void)perf_event_read(event, false);
 	total += perf_event_count(event);
 
 	*enabled += event->total_time_enabled +
@@ -3851,7 +3859,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 			atomic64_read(&event->child_total_time_running);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child, false);
+		(void)perf_event_read(child, false);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3862,13 +3870,16 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 }
 EXPORT_SYMBOL_GPL(perf_event_read_value);
 
-static void __perf_read_group_add(struct perf_event *leader,
+static int __perf_read_group_add(struct perf_event *leader,
 					u64 read_format, u64 *values)
 {
 	struct perf_event *sub;
 	int n = 1; /* skip @nr */
+	int ret;
 
-	perf_event_read(leader, true);
+	ret = perf_event_read(leader, true);
+	if (ret)
+		return ret;
 
 	/*
 	 * Since we co-schedule groups, {enabled,running} times of siblings
@@ -3897,6 +3908,8 @@ static void __perf_read_group_add(struct perf_event *leader,
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 	}
+
+	return 0;
 }
 
 static int perf_read_group(struct perf_event *event,
@@ -3904,7 +3917,7 @@ static int perf_read_group(struct perf_event *event,
 {
 	struct perf_event *leader = event->group_leader, *child;
 	struct perf_event_context *ctx = leader->ctx;
-	int ret = event->read_size;
+	int ret;
 	u64 *values;
 
 	lockdep_assert_held(&ctx->mutex);
@@ -3921,17 +3934,27 @@ static int perf_read_group(struct perf_event *event,
 	 */
 	mutex_lock(&leader->child_mutex);
 
-	__perf_read_group_add(leader, read_format, values);
-	list_for_each_entry(child, &leader->child_list, child_list)
-		__perf_read_group_add(child, read_format, values);
+	ret = __perf_read_group_add(leader, read_format, values);
+	if (ret)
+		goto unlock;
+
+	list_for_each_entry(child, &leader->child_list, child_list) {
+		ret = __perf_read_group_add(child, read_format, values);
+		if (ret)
+			goto unlock;
+	}
 
 	mutex_unlock(&leader->child_mutex);
 
+	ret = event->read_size;
 	if (copy_to_user(buf, values, event->read_size))
 		ret = -EFAULT;
+	goto out;
 
+unlock:
+	mutex_unlock(&leader->child_mutex);
+out:
 	kfree(values);
-
 	return ret;
 }
 
@@ -4037,7 +4060,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	perf_event_read(event, false);
+	(void)perf_event_read(event, false);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
