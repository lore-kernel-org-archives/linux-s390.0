Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 09/10] Define PERF_PMU_TXN_READ interface
Date: Sun, 26 Jul 2015 22:40:37 -0700
Message-Id: <1437975638-789-10-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1437975638-789-1-git-send-email-sukadev@linux.vnet.ibm.com>
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

Define a new PERF_PMU_TXN_READ interface to read a group of counters
at once.

        pmu->start_txn()                // Initialize before first event

        for each event in group
                pmu->read(event);       // Queue each event to be read

        pmu->commit_txn()               // Read/update all queued counters

Note that we use this interface with all PMUs.  PMUs that implement this
interface use the ->read() operation to _queue_ the counters to be read
and use ->commit_txn() to actually read all the queued counters at once.

PMUs that don't implement PERF_PMU_TXN_READ ignore ->start_txn() and
->commit_txn() and continue to read counters one at a time.

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v4]
        [Peter Zijlstra] Add lockdep_assert_held() in perf_event_read_group().
        Make sure the entire transaction happens on the same CPU.

---
 include/linux/perf_event.h |    1 +
 kernel/events/core.c       |   38 +++++++++++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 44bf05f..da307ad 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -169,6 +169,7 @@ struct perf_event;
 #define PERF_EVENT_TXN 0x1
 
 #define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
+#define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
 
 /**
  * pmu::capabilities flags
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 951d835..b5aa92c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3176,6 +3176,7 @@ void perf_event_exec(void)
 
 struct perf_read_data {
 	struct perf_event *event;
+	bool group;
 	int ret;
 };
 
@@ -3186,8 +3187,10 @@ static void __perf_event_read(void *info)
 {
 	struct perf_read_data *data = info;
 	struct perf_event *event = data->event;
+	struct perf_event *sub;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
+	struct pmu *pmu = event->pmu;
 
 	/*
 	 * If this is a task context, we need to check whether it is
@@ -3205,10 +3208,25 @@ static void __perf_event_read(void *info)
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
 
-	data->ret = 0;
+	pmu->read(event);
+	list_for_each_entry(sub, &event->sibling_list, group_entry) {
+		if (sub->state == PERF_EVENT_STATE_ACTIVE)
+			pmu->read(sub);
+	}
+
+	data->ret = pmu->commit_txn(pmu);
+
+unlock:
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -3231,6 +3249,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 	if (event->state == PERF_EVENT_STATE_ACTIVE) {
 		struct perf_read_data data = {
 			.event = event,
+			.group = group,
 			.ret = 0,
 		};
 
@@ -3743,7 +3762,13 @@ static u64 perf_event_aggregate(struct perf_event *event, u64 *enabled,
 	lockdep_assert_held(&event->child_mutex);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
+#if 0
+		/*
+		 * TODO: Do we need this read() for group events on PMUs that
+		 * 	 don't implement PERF_PMU_TXN_READ transactions?
+		 */
 		(void)perf_event_read(child, false);
+#endif
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3821,7 +3846,7 @@ static int perf_read_group(struct perf_event *event,
 
 	mutex_lock(&leader->child_mutex);
 
-	ret = perf_event_read(leader);
+	ret = perf_event_read(leader, true);
 	if (ret) {
 		mutex_unlock(&leader->child_mutex);
 		return ret;
@@ -3850,12 +3875,11 @@ static int perf_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		mutex_lock(&leader->child_mutex);
+		mutex_lock(&sub->child_mutex);
 
-		(void)perf_event_read(sub, false);
 		values[n++] = perf_event_aggregate(sub, &enabled, &running);
 
-		mutex_unlock(&leader->child_mutex);
+		mutex_unlock(&sub->child_mutex);
 
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
-- 
1.7.9.5
