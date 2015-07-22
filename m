Return-Path: <sukadev@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 16:19:16 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 7/8] perf: Define PMU_TXN_READ interface
Message-ID: <20150722231916.GA1863@us.ibm.com>
References: <1436929315-28520-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1436929315-28520-8-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150716222015.GO3644@twins.programming.kicks-ass.net>
 <20150722015045.GA24420@us.ibm.com>
 <20150722055503.GO25159@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150722055503.GO25159@twins.programming.kicks-ass.net>
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
| I've not woken up yet, and not actually fully read the email, but can
| you stuff the entire above chunk inside the IPI?
| 
| I think you could then actually optimize __perf_event_read() as well,
| because all these events should be on the same context, so no point in
| calling update_*time*() for every event or so.
| 

Do you mean something like this (will move the rename to a separate
patch before posting):
--

From e8eddb5d3877ebdb3b71213a00aaa980f4010dd0 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Tue, 7 Jul 2015 21:45:23 -0400
Subject: [PATCH 1/1] perf: Define PMU_TXN_READ interface

Define a new PERF_PMU_TXN_READ interface to read a group of counters
at once. Note that we use this interface with all PMUs.

PMUs that implement this interface use the ->read() operation to _queue_
the counters to be read and use ->commit_txn() to actually read all the
queued counters at once.

PMUs that don't implement PERF_PMU_TXN_READ ignore ->start_txn() and
->commit_txn() and continue to read counters one at a time.

Thanks to input from Peter Zijlstra.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

Changelog[v5]
	[Peter Zijlstra] Ensure the entire transaction happens on the same CPU.

Changelog[v4]
	[Peter Zijlstra] Add lockdep_assert_held() in perf_event_read_group()
---
 include/linux/perf_event.h |    1 +
 kernel/events/core.c       |   72 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 62 insertions(+), 11 deletions(-)

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
index a6bd09d..7177dd8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3174,12 +3174,8 @@ void perf_event_exec(void)
 	rcu_read_unlock();
 }
 
-/*
- * Cross CPU call to read the hardware event
- */
-static void __perf_event_read(void *info)
+static void __perf_event_read(struct perf_event *event, int update_ctx)
 {
-	struct perf_event *event = info;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 
@@ -3194,7 +3190,7 @@ static void __perf_event_read(void *info)
 		return;
 
 	raw_spin_lock(&ctx->lock);
-	if (ctx->is_active) {
+	if (ctx->is_active && update_ctx) {
 		update_context_time(ctx);
 		update_cgrp_time_from_event(event);
 	}
@@ -3204,6 +3200,16 @@ static void __perf_event_read(void *info)
 	raw_spin_unlock(&ctx->lock);
 }
 
+/*
+ * Cross CPU call to read the hardware event
+ */
+static void __perf_event_read_ipi(void *info)
+{
+	struct perf_event *event = info;
+
+	__perf_event_read(event, 1);
+}
+
 static inline u64 perf_event_count(struct perf_event *event)
 {
 	if (event->pmu->count)
@@ -3220,7 +3226,7 @@ static void perf_event_read(struct perf_event *event)
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE) {
 		smp_call_function_single(event->oncpu,
-					 __perf_event_read, event, 1);
+					 __perf_event_read_ipi, event, 1);
 	} else if (event->state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
@@ -3765,6 +3771,36 @@ static void orphans_remove_work(struct work_struct *work)
 	put_ctx(ctx);
 }
 
+/*
+ * Use the transaction interface to read the group of events in @leader.
+ * PMUs like the 24x7 counters in Power, can use this to queue the events
+ * in the ->read() operation and perform the actual read in ->commit_txn.
+ *
+ * Other PMUs can ignore the ->start_txn and ->commit_txn and read each
+ * PMU directly in the ->read() operation.
+ */
+static int perf_event_read_group(struct perf_event *leader)
+{
+	int ret;
+	struct perf_event *sub;
+	struct pmu *pmu;
+	struct perf_event_context *ctx = leader->ctx;
+
+	lockdep_assert_held(&ctx->mutex);
+
+	pmu = leader->pmu;
+
+	pmu->start_txn(pmu, PERF_PMU_TXN_READ);
+
+	__perf_event_read(leader, 1);
+	list_for_each_entry(sub, &leader->sibling_list, group_entry)
+		__perf_event_read(sub, 0);
+
+	ret = pmu->commit_txn(pmu);
+
+	return ret;
+}
+
 u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 {
 	u64 total = 0;
@@ -3794,7 +3830,17 @@ static int perf_read_group(struct perf_event *event,
 
 	lockdep_assert_held(&ctx->mutex);
 
-	count = perf_event_read_value(leader, &enabled, &running);
+	mutex_lock(&leader->child_mutex);
+
+	ret = perf_event_read_group(leader);
+	if (ret) {
+		mutex_unlock(&leader->child_mutex);
+		return ret;
+	}
+
+	count = perf_event_aggregate(leader, &enabled, &running);
+
+	mutex_unlock(&leader->child_mutex);
 
 	values[n++] = 1 + leader->nr_siblings;
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
@@ -3815,15 +3861,19 @@ static int perf_read_group(struct perf_event *event,
 	list_for_each_entry(sub, &leader->sibling_list, group_entry) {
 		n = 0;
 
-		values[n++] = perf_event_read_value(sub, &enabled, &running);
+		mutex_lock(&sub->child_mutex);
+
+		values[n++] = perf_event_aggregate(sub, &enabled, &running);
+
+		mutex_unlock(&sub->child_mutex);
+
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 
 		size = n * sizeof(u64);
 
-		if (copy_to_user(buf + ret, values, size)) {
+		if (copy_to_user(buf + ret, values, size))
 			return -EFAULT;
-		}
 
 		ret += size;
 	}
-- 
1.7.9.5
