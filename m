Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 06/10] perf: Add return value for perf_event_read().
Date: Sun, 26 Jul 2015 22:40:34 -0700
Message-Id: <1437975638-789-7-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add a return value to perf_event_read(). The return value will be
needed later in perf_read_group() implements ability to read several
counters in a PERF_PMU_TXN_READ transaction.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0ce3012..21a55d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3212,7 +3212,7 @@ static inline u64 perf_event_count(struct perf_event *event)
 	return __perf_event_count(event);
 }
 
-static void perf_event_read(struct perf_event *event)
+static int perf_event_read(struct perf_event *event)
 {
 	/*
 	 * If event is enabled and currently active on a CPU, update the
@@ -3238,6 +3238,8 @@ static void perf_event_read(struct perf_event *event)
 		update_event_times(event);
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
+
+	return 0;
 }
 
 /*
@@ -3720,7 +3722,7 @@ static u64 perf_event_aggregate(struct perf_event *event, u64 *enabled,
 	lockdep_assert_held(&event->child_mutex);
 
 	list_for_each_entry(child, &event->child_list, child_list) {
-		perf_event_read(child);
+		(void)perf_event_read(child);
 		total += perf_event_count(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
@@ -3774,7 +3776,7 @@ u64 perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *running)
 
 	mutex_lock(&event->child_mutex);
 
-	perf_event_read(event);
+	(void)perf_event_read(event);
 	total = perf_event_aggregate(event, enabled, running);
 
 	mutex_unlock(&event->child_mutex);
@@ -3798,7 +3800,12 @@ static int perf_read_group(struct perf_event *event,
 
 	mutex_lock(&leader->child_mutex);
 
-	perf_event_read(leader);
+	ret = perf_event_read(leader);
+	if (ret) {
+		mutex_unlock(&leader->child_mutex);
+		return ret;
+	}
+
 	count = perf_event_aggregate(leader, &enabled, &running);
 
 	mutex_unlock(&leader->child_mutex);
@@ -3824,7 +3831,7 @@ static int perf_read_group(struct perf_event *event,
 
 		mutex_lock(&leader->child_mutex);
 
-		perf_event_read(sub);
+		(void)perf_event_read(sub);
 		values[n++] = perf_event_aggregate(sub, &enabled, &running);
 
 		mutex_unlock(&leader->child_mutex);
@@ -3946,7 +3953,7 @@ static unsigned int perf_poll(struct file *file, poll_table *wait)
 
 static void _perf_event_reset(struct perf_event *event)
 {
-	perf_event_read(event);
+	(void)perf_event_read(event);
 	local64_set(&event->count, 0);
 	perf_event_update_userpage(event);
 }
-- 
1.7.9.5
