Return-Path: <sukadev@linux.vnet.ibm.com>
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 08/10] perf: Add return value to __perf_event_read()
Date: Sun, 26 Jul 2015 22:40:36 -0700
Message-Id: <1437975638-789-9-git-send-email-sukadev@linux.vnet.ibm.com>
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

Add a return value to __perf_event_read(). The return value will be
needed later in perf_read_group() implements ability to read several
counters in a PERF_PMU_TXN_READ transaction.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 kernel/events/core.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f38fe0b..951d835 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3174,12 +3174,18 @@ void perf_event_exec(void)
 	rcu_read_unlock();
 }
 
+struct perf_read_data {
+	struct perf_event *event;
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
+	struct perf_event *event = data->event;
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 
@@ -3201,6 +3207,8 @@ static void __perf_event_read(void *info)
 	update_event_times(event);
 	if (event->state == PERF_EVENT_STATE_ACTIVE)
 		event->pmu->read(event);
+
+	data->ret = 0;
 	raw_spin_unlock(&ctx->lock);
 }
 
@@ -3214,13 +3222,21 @@ static inline u64 perf_event_count(struct perf_event *event)
 
 static int perf_event_read(struct perf_event *event, bool group)
 {
+	int ret = 0;
+
 	/*
 	 * If event is enabled and currently active on a CPU, update the
 	 * value in the event structure:
 	 */
 	if (event->state == PERF_EVENT_STATE_ACTIVE) {
+		struct perf_read_data data = {
+			.event = event,
+			.ret = 0,
+		};
+
 		smp_call_function_single(event->oncpu,
-					 __perf_event_read, event, 1);
+					 __perf_event_read, &data, 1);
+		ret = data.ret;
 	} else if (event->state == PERF_EVENT_STATE_INACTIVE) {
 		struct perf_event_context *ctx = event->ctx;
 		unsigned long flags;
@@ -3244,7 +3260,7 @@ static int perf_event_read(struct perf_event *event, bool group)
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 	}
 
-	return 0;
+	return ret;
 }
 
 /*
-- 
1.7.9.5
